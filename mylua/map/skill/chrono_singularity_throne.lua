local chrono_singularity_throne = {}

local DAMAGE = 840 -- You may change this damage value only.

local ABILITY_ID = char2id("C009")
local HIDDEN_ABILITY_ID = char2id("C010")
local DUMMY_UNIT_ID = char2id("u006")

local MAX_CAST_RANGE = 1000.0
local DOMAIN_RADIUS = 520.0
local CLOCK_RING_RADIUS = 360.0
local HOUR_MARK_RADIUS = 430.0
local CORE_RADIUS = 150.0
local LANE_WIDTH = 110.0
local REWIND_RADIUS = 560.0
local COLLAPSE_RADIUS = 660.0
local THRONE_RADIUS = 260.0
local MIRAGE_COUNT = 5
local HOUR_MARK_COUNT = 8

local ANNOUNCE_TICKS = 8
local ANNOUNCE_PERIOD = 0.13
local CLOCK_TICKS = 12
local CLOCK_PERIOD = 0.12
local LANE_TICKS = 10
local LANE_PERIOD = 0.14
local REWIND_TICKS = 7
local REWIND_PERIOD = 0.18
local THRONE_TICKS = 9
local THRONE_PERIOD = 0.12
local COLLAPSE_TICKS = 8
local COLLAPSE_PERIOD = 0.09

local ANNOUNCE_DAMAGE_FACTOR = 0.05
local CLOCK_MARK_DAMAGE_FACTOR = 0.08
local CLOCK_RING_DAMAGE_FACTOR = 0.11
local LANE_DAMAGE_FACTOR = 0.13
local REWIND_DAMAGE_FACTOR = 0.14
local THRONE_DAMAGE_FACTOR = 0.12
local COLLAPSE_PULL_DAMAGE_FACTOR = 0.11
local COLLAPSE_BURST_DAMAGE_FACTOR = 0.95

local FULL_CIRCLE = 6.283185
local DEG = 57.29582

local function is_living_enemy(source, target)
    if source == nil or target == nil then
        return false
    end
    if source == target then
        return false
    end
    if not _F.IsUnitEnemy(target, _F.GetOwningPlayer(source)) then
        return false
    end
    if _F.IsUnitType(target, _C.UNIT_TYPE_DEAD) then
        return false
    end
    return _F.GetWidgetLife(target) > 0.405
end

local function damage_target(source, target, amount)
    _F.UnitDamageTarget(
        source,
        target,
        amount,
        true,
        false,
        _C.ATTACK_TYPE_HERO,
        _C.DAMAGE_TYPE_MAGIC,
        _C.WEAPON_TYPE_WHOKNOWS
    )
end

local function effect_at(path, x, y)
    local effect = _F.AddSpecialEffect(path, x, y)
    _F.DestroyEffect(effect)
end

local function effect_on_target(path, target, point)
    local effect = _F.AddSpecialEffectTarget(path, target, point)
    _F.DestroyEffect(effect)
end

local function distance_between(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return _F.SquareRoot(dx * dx + dy * dy)
end

local function angle_between(x1, y1, x2, y2)
    return _F.Atan2(y2 - y1, x2 - x1)
end

local function normalize_angle(angle)
    while angle < 0.0 do
        angle = angle + FULL_CIRCLE
    end
    while angle >= FULL_CIRCLE do
        angle = angle - FULL_CIRCLE
    end
    return angle
end

local function point_on_circle(cx, cy, radius, angle)
    return cx + radius * _F.Cos(angle), cy + radius * _F.Sin(angle)
end

local function clamp_target(start_x, start_y, target_x, target_y)
    local dx = target_x - start_x
    local dy = target_y - start_y
    local distance = _F.SquareRoot(dx * dx + dy * dy)

    if distance <= MAX_CAST_RANGE then
        return target_x, target_y
    end

    if distance < 1.0 then
        distance = 1.0
    end

    local scale = MAX_CAST_RANGE / distance
    return start_x + dx * scale, start_y + dy * scale
end

local function set_unit_position(unit, x, y)
    _F.SetUnitX(unit, x)
    _F.SetUnitY(unit, y)
end

local function set_caster_pose(caster, facing, animation, scale)
    _F.SetUnitFacing(caster, facing)
    _F.SetUnitAnimation(caster, animation)
    _F.SetUnitTimeScale(caster, scale)
end

local function finish_caster_pose(caster)
    _F.SetUnitTimeScale(caster, 1.00)
    _F.QueueUnitAnimation(caster, "stand")
end

local function create_hidden_dummy(owner, x, y, facing)
    local dummy = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(dummy, false)
    _F.SetUnitPathing(dummy, false)
    _F.SetUnitInvulnerable(dummy, true)
    _F.SetUnitVertexColor(dummy, 255, 255, 255, 0)
    _F.UnitAddAbility(dummy, HIDDEN_ABILITY_ID)
    return dummy
end

local function create_afterimage(owner, x, y, facing, alpha, duration)
    local image = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(image, false)
    _F.SetUnitPathing(image, false)
    _F.SetUnitInvulnerable(image, true)
    _F.SetUnitVertexColor(image, 185, 235, 255, alpha)
    _F.UnitApplyTimedLife(image, char2id("BTLF"), duration)
    return image
end

local function create_state(caster, center_x, center_y)
    return {
        caster = caster,
        owner = _F.GetOwningPlayer(caster),
        center_x = center_x,
        center_y = center_y,
        anchor = nil,
        marks = {},
        mirages = {},
        hit_marks = {},
        rewind_memory = {},
        throne_angle = 0.0,
        phase = 0,
        tick = 0,
    }
end

local function clear_hit_marks(mark_table)
    for key, _ in pairs(mark_table) do
        mark_table[key] = nil
    end
end

local function mark_hit(mark_table, target)
    local key = _F.GetHandleId(target)
    if mark_table[key] then
        return false
    end
    mark_table[key] = true
    return true
end

local function sweep_units(x, y, radius, callback)
    local group = _F.CreateGroup()
    _F.GroupEnumUnitsInRange(group, x, y, radius, nil)
    while true do
        local target = _F.FirstOfGroup(group)
        if target == nil then
            break
        end
        _F.GroupRemoveUnit(group, target)
        callback(target)
    end
    _F.DestroyGroup(group)
end

local function sweep_enemies(source, x, y, radius, callback)
    sweep_units(x, y, radius, function(target)
        if is_living_enemy(source, target) then
            callback(target)
        end
    end)
end

local function collect_enemies(source, x, y, radius)
    local result = {}
    sweep_enemies(source, x, y, radius, function(target)
        result[#result + 1] = target
    end)
    return result
end

local function collect_sorted_enemies(source, x, y, radius)
    local units = collect_enemies(source, x, y, radius)
    table.sort(units, function(a, b)
        local ax = _F.GetUnitX(a)
        local ay = _F.GetUnitY(a)
        local bx = _F.GetUnitX(b)
        local by = _F.GetUnitY(b)
        return distance_between(x, y, ax, ay) < distance_between(x, y, bx, by)
    end)
    return units
end

local function pull_unit(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + (x - tx) * factor, ty + (y - ty) * factor)
end

local function push_unit(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + (tx - x) * factor, ty + (ty - y) * factor)
end

local function record_rewind_positions(state)
    state.rewind_memory = {}
    sweep_enemies(state.caster, state.center_x, state.center_y, REWIND_RADIUS, function(target)
        local key = _F.GetHandleId(target)
        state.rewind_memory[key] = {
            unit = target,
            x = _F.GetUnitX(target),
            y = _F.GetUnitY(target),
        }
    end)
end

local function spawn_domain_objects(state)
    state.anchor = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)

    for i = 1, HOUR_MARK_COUNT, 1 do
        local angle = (i - 1) * FULL_CIRCLE / HOUR_MARK_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, HOUR_MARK_RADIUS, angle)
        state.marks[i] = {
            unit = create_hidden_dummy(state.owner, x, y, angle * DEG),
            angle = angle,
            x = x,
            y = y,
        }
    end

    for i = 1, MIRAGE_COUNT, 1 do
        state.mirages[i] = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)
    end
end

local function cleanup_state(state)
    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.marks, 1 do
        local mark = state.marks[i]
        if mark and mark.unit ~= nil then
            _F.RemoveUnit(mark.unit)
            mark.unit = nil
        end
    end

    for i = 1, #state.mirages, 1 do
        if state.mirages[i] ~= nil then
            _F.RemoveUnit(state.mirages[i])
            state.mirages[i] = nil
        end
    end
end

local function update_hour_marks(state, radius, base_angle)
    for i = 1, #state.marks, 1 do
        local angle = base_angle + (i - 1) * FULL_CIRCLE / HOUR_MARK_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        local mark = state.marks[i]
        mark.angle = angle
        mark.x = x
        mark.y = y
        set_unit_position(mark.unit, x, y)
    end
end

local function play_mark_effects(state, path)
    for i = 1, #state.marks, 1 do
        effect_at(path, state.marks[i].x, state.marks[i].y)
    end
end

local function damage_near_marks(state, radius, amount)
    for i = 1, #state.marks, 1 do
        local mark = state.marks[i]
        sweep_enemies(state.caster, mark.x, mark.y, radius, function(target)
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
        end)
    end
end

local function damage_ring(state, ring_radius, thickness, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, ring_radius + thickness, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if distance >= ring_radius - thickness and distance <= ring_radius + thickness then
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\NightElf\\ManaBurn\\ManaBurnTarget.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
        end
    end)
end

local function distance_to_lane(center_x, center_y, angle, x, y)
    local dx = x - center_x
    local dy = y - center_y
    local forward = dx * _F.Cos(angle) + dy * _F.Sin(angle)
    local side = math.abs(-dx * _F.Sin(angle) + dy * _F.Cos(angle))
    return forward, side
end

local function damage_lane(state, angle, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local forward, side = distance_to_lane(state.center_x, state.center_y, angle, tx, ty)
        if forward >= -80.0 and forward <= DOMAIN_RADIUS and side <= LANE_WIDTH then
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", target, "chest")
                damage_target(state.caster, target, amount)
            end
        end
    end)
end

local function draw_lane_effects(state, angle, length)
    for i = 1, 6, 1 do
        local step = length * i / 6
        local x, y = point_on_circle(state.center_x, state.center_y, step, angle)
        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", x, y)
        effect_at("Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl", x, y)
    end
end

local function place_caster_on_ring(state, angle, radius, animation)
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    local facing = angle * DEG + 180.0
    set_unit_position(state.caster, x, y)
    set_caster_pose(state.caster, facing, animation, 1.20)
    create_afterimage(state.owner, x, y, facing, 145, 0.42)
end

local function move_mirages_to_marks(state, angle_shift)
    for i = 1, #state.mirages, 1 do
        local angle = angle_shift + (i - 1) * FULL_CIRCLE / MIRAGE_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, THRONE_RADIUS, angle)
        set_unit_position(state.mirages[i], x, y)
        _F.SetUnitFacing(state.mirages[i], angle * DEG + 180.0)
    end
end

local function draw_clock_hands(state, primary_angle, secondary_angle)
    draw_lane_effects(state, primary_angle, CLOCK_RING_RADIUS)
    draw_lane_effects(state, secondary_angle, DOMAIN_RADIUS)
    damage_lane(state, primary_angle, DAMAGE * LANE_DAMAGE_FACTOR)
    damage_lane(state, secondary_angle, DAMAGE * LANE_DAMAGE_FACTOR)
end

local function rewind_targets(state)
    for _, memory in pairs(state.rewind_memory) do
        local target = memory.unit
        if is_living_enemy(state.caster, target) then
            local before_x = _F.GetUnitX(target)
            local before_y = _F.GetUnitY(target)
            set_unit_position(target, memory.x, memory.y)
            effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", before_x, before_y)
            effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", memory.x, memory.y)
            damage_target(state.caster, target, DAMAGE * REWIND_DAMAGE_FACTOR)
        end
    end
end

local function execute_mirage_slash(state, index, target)
    local mirage = state.mirages[index]
    local start_x = _F.GetUnitX(mirage)
    local start_y = _F.GetUnitY(mirage)
    local target_x = _F.GetUnitX(target)
    local target_y = _F.GetUnitY(target)
    local angle = angle_between(start_x, start_y, target_x, target_y)

    create_afterimage(state.owner, start_x, start_y, angle * DEG, 155, 0.34)
    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", start_x, start_y)

    for i = 1, 6, 1 do
        local progress = i / 6
        local x = start_x + (target_x - start_x) * progress
        local y = start_y + (target_y - start_y) * progress
        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", x, y)
        sweep_enemies(state.caster, x, y, 90.0, function(enemy)
            if mark_hit(state.hit_marks, enemy) then
                damage_target(state.caster, enemy, DAMAGE * THRONE_DAMAGE_FACTOR)
            end
        end)
    end

    set_unit_position(mirage, target_x, target_y)
    _F.SetUnitFacing(mirage, angle * DEG)
    effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", target_x, target_y)
end

local function draw_throne_circle(state, angle)
    for i = 1, MIRAGE_COUNT, 1 do
        local x, y = point_on_circle(state.center_x, state.center_y, THRONE_RADIUS, angle + (i - 1) * FULL_CIRCLE / MIRAGE_COUNT)
        effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", x, y)
    end
end

local function start_collapse_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, COLLAPSE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 5
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = DOMAIN_RADIUS * (1.0 - tick / COLLAPSE_TICKS)
        local angle = tick * 0.88

        update_hour_marks(state, radius, angle)
        play_mark_effects(state, "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
        place_caster_on_ring(state, angle, math.max(60.0, radius), "attack")

        sweep_enemies(state.caster, state.center_x, state.center_y, COLLAPSE_RADIUS, function(target)
            pull_unit(target, state.center_x, state.center_y, 0.12)
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
                damage_target(state.caster, target, DAMAGE * COLLAPSE_PULL_DAMAGE_FACTOR)
            end
        end)

        if tick % 2 == 0 then
            sweep_enemies(state.caster, state.center_x, state.center_y, CORE_RADIUS, function(target)
                push_unit(target, state.center_x, state.center_y, 0.18)
            end)
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", state.center_x, state.center_y)
        end

        if tick >= COLLAPSE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)

            set_unit_position(state.caster, state.center_x, state.center_y - 75.0)
            set_caster_pose(state.caster, 90.0, "attack slam", 1.32)
            effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", state.center_x, state.center_y)
            effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
            effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", state.center_x, state.center_y)

            sweep_enemies(state.caster, state.center_x, state.center_y, COLLAPSE_RADIUS, function(target)
                effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
                damage_target(state.caster, target, DAMAGE * COLLAPSE_BURST_DAMAGE_FACTOR)
            end)

            finish_caster_pose(state.caster)
            cleanup_state(state)
        end
    end)
end

local function start_throne_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, THRONE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 4
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        state.throne_angle = tick * 0.72
        move_mirages_to_marks(state, state.throne_angle)
        draw_throne_circle(state, state.throne_angle)
        place_caster_on_ring(state, state.throne_angle + 1.3, THRONE_RADIUS + 70.0, "spell")

        local targets = collect_sorted_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS)
        local count = MIRAGE_COUNT
        if #targets < count then
            count = #targets
        end

        for i = 1, count, 1 do
            execute_mirage_slash(state, i, targets[i])
        end

        if count == 0 then
            effect_at("Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl", state.center_x, state.center_y)
        end

        if tick >= THRONE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_collapse_phase(state)
        end
    end)
end

local function start_rewind_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    record_rewind_positions(state)

    _F.TimerStart(timer, REWIND_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local angle = tick * 0.96
        local radius = CLOCK_RING_RADIUS + 25.0 * _F.Sin(tick * 0.8)

        update_hour_marks(state, HOUR_MARK_RADIUS - 20.0, angle * 0.55)
        play_mark_effects(state, "Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
        place_caster_on_ring(state, angle, radius, "spell")

        if tick == 3 or tick == 6 then
            rewind_targets(state)
            effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", state.center_x, state.center_y)
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", state.center_x, state.center_y)
        else
            sweep_enemies(state.caster, state.center_x, state.center_y, REWIND_RADIUS, function(target)
                pull_unit(target, state.center_x, state.center_y, 0.05)
            end)
        end

        if tick >= REWIND_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_throne_phase(state)
        end
    end)
end

local function start_lane_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, LANE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local primary_angle = normalize_angle(tick * 0.78)
        local secondary_angle = normalize_angle(primary_angle + 1.570796)
        local radius = CLOCK_RING_RADIUS + 18.0 * _F.Sin(tick * 0.45)

        update_hour_marks(state, HOUR_MARK_RADIUS, primary_angle * 0.30)
        play_mark_effects(state, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
        place_caster_on_ring(state, primary_angle + 3.141592, radius, "attack")

        draw_clock_hands(state, primary_angle, secondary_angle)

        if tick % 2 == 0 then
            damage_ring(state, CLOCK_RING_RADIUS, 55.0, DAMAGE * CLOCK_RING_DAMAGE_FACTOR)
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", state.center_x, state.center_y)
        end

        if tick >= LANE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_rewind_phase(state)
        end
    end)
end

local function start_clock_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, CLOCK_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local angle = tick * 0.42
        local radius = HOUR_MARK_RADIUS + 20.0 * _F.Sin(tick * 0.4)

        update_hour_marks(state, radius, angle)
        play_mark_effects(state, "Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
        damage_near_marks(state, 115.0, DAMAGE * CLOCK_MARK_DAMAGE_FACTOR)

        if tick % 2 == 0 then
            damage_ring(state, CLOCK_RING_RADIUS, 50.0, DAMAGE * CLOCK_RING_DAMAGE_FACTOR)
        end

        place_caster_on_ring(state, angle + 1.570796, CLOCK_RING_RADIUS - 40.0, "attack")

        if tick >= CLOCK_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_lane_phase(state)
        end
    end)
end

local function start_announce_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.34)

    _F.TimerStart(timer, ANNOUNCE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = DOMAIN_RADIUS - tick * 18.0
        local angle = tick * 0.24

        update_hour_marks(state, radius, angle)
        play_mark_effects(state, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", state.center_x, state.center_y)
        effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)

        if tick % 2 == 1 then
            damage_ring(state, radius, 48.0, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)
        end

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_clock_phase(state)
        end
    end)
end

local function begin_skill(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local center_x, center_y = clamp_target(start_x, start_y, target_x, target_y)
    local state = create_state(caster, center_x, center_y)

    spawn_domain_objects(state)
    start_announce_phase(state)
end

function chrono_singularity_throne.init()
    local trigger = _F.CreateTrigger()

    for i = 0, _C.bj_MAX_PLAYER_SLOTS - 1, 1 do
        _F.TriggerRegisterPlayerUnitEvent(trigger, _F.Player(i), _C.EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
    end

    _F.TriggerAddAction(trigger, function()
        if _F.GetSpellAbilityId() ~= ABILITY_ID then
            return
        end

        begin_skill(
            _F.GetTriggerUnit(),
            _F.GetSpellTargetX(),
            _F.GetSpellTargetY()
        )
    end)
end

return chrono_singularity_throne
