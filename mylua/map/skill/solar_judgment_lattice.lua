local solar_judgment_lattice = {}

local DAMAGE = 1180 -- You may change this damage value only.

local ABILITY_ID = char2id("C019")
local HIDDEN_ABILITY_ID = char2id("C020")
local DUMMY_UNIT_ID = char2id("u011")

local MAX_CAST_RANGE = 980.0
local DOMAIN_RADIUS = 610.0
local OUTER_RING_RADIUS = 500.0
local BEACON_RADIUS = 460.0
local LANE_HALF_WIDTH = 82.0
local PILLAR_RADIUS = 145.0
local FINALE_RADIUS = 280.0
local BEACON_COUNT = 6

local ANNOUNCE_TICKS = 7
local ANNOUNCE_PERIOD = 0.16
local LATTICE_TICKS = 9
local LATTICE_PERIOD = 0.15
local SWEEP_TICKS = 8
local SWEEP_PERIOD = 0.16
local PILLAR_TICKS = 8
local PILLAR_PERIOD = 0.15
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.12

local ANNOUNCE_DAMAGE_FACTOR = 0.07
local LATTICE_DAMAGE_FACTOR = 0.14
local SWEEP_DAMAGE_FACTOR = 0.16
local PILLAR_DAMAGE_FACTOR = 0.18
local FINALE_PULL_DAMAGE_FACTOR = 0.10
local FINALE_BURST_DAMAGE_FACTOR = 1.00

local FULL_CIRCLE = 6.283185
local HALF_PI = 1.570796
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

local function create_state(caster, center_x, center_y)
    return {
        caster = caster,
        owner = _F.GetOwningPlayer(caster),
        center_x = center_x,
        center_y = center_y,
        anchor = nil,
        beacons = {},
        hit_marks = {},
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

local function move_toward(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + (x - tx) * factor, ty + (y - ty) * factor)
end

local function create_domain_objects(state)
    state.anchor = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)

    for i = 1, BEACON_COUNT, 1 do
        local angle = (i - 1) * FULL_CIRCLE / BEACON_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, BEACON_RADIUS, angle)
        state.beacons[i] = {
            unit = create_hidden_dummy(state.owner, x, y, angle * DEG),
            x = x,
            y = y,
            angle = angle,
        }
    end
end

local function cleanup_state(state)
    finish_caster_pose(state.caster)

    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.beacons, 1 do
        if state.beacons[i] ~= nil and state.beacons[i].unit ~= nil then
            _F.RemoveUnit(state.beacons[i].unit)
            state.beacons[i].unit = nil
        end
    end
end

local function update_beacons(state, radius, base_angle)
    for i = 1, #state.beacons, 1 do
        local beacon = state.beacons[i]
        local angle = base_angle + (i - 1) * FULL_CIRCLE / BEACON_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        beacon.x = x
        beacon.y = y
        beacon.angle = angle
        set_unit_position(beacon.unit, x, y)
        _F.SetUnitFacing(beacon.unit, angle * DEG)
        effect_at("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", x, y)
    end
end

local function draw_ring(state, radius, effect_path)
    for i = 1, 10, 1 do
        local angle = (i - 1) * FULL_CIRCLE / 10
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        effect_at(effect_path, x, y)
    end
end

local function damage_ring(state, radius, thickness, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 90.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if math.abs(distance - radius) <= thickness and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin")
        end
    end)
end

local function point_line_distance(px, py, ax, ay, bx, by)
    local vx = bx - ax
    local vy = by - ay
    local wx = px - ax
    local wy = py - ay
    local vv = vx * vx + vy * vy

    if vv < 1.0 then
        return distance_between(px, py, ax, ay)
    end

    local t = (wx * vx + wy * vy) / vv
    if t < 0.0 then
        t = 0.0
    elseif t > 1.0 then
        t = 1.0
    end

    local cx = ax + vx * t
    local cy = ay + vy * t
    return distance_between(px, py, cx, cy)
end

local function draw_lattice(state)
    for i = 1, #state.beacons, 1 do
        local first = state.beacons[i]
        local second_index = i + 2
        while second_index > #state.beacons do
            second_index = second_index - #state.beacons
        end
        local second = state.beacons[second_index]

        for step = 0, 5, 1 do
            local progress = step / 5
            local x = first.x + (second.x - first.x) * progress
            local y = first.y + (second.y - first.y) * progress
            effect_at("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", x, y)
        end
    end
end

local function damage_lattice(state, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 120.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)

        for i = 1, #state.beacons, 1 do
            local first = state.beacons[i]
            local second_index = i + 2
            while second_index > #state.beacons do
                second_index = second_index - #state.beacons
            end
            local second = state.beacons[second_index]
            local line_distance = point_line_distance(tx, ty, first.x, first.y, second.x, second.y)
            if line_distance <= LANE_HALF_WIDTH and mark_hit(state.hit_marks, target) then
                damage_target(state.caster, target, amount)
                effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
                move_toward(target, state.center_x, state.center_y, 0.08)
                break
            end
        end
    end)
end

local function draw_sweeps(state, angle)
    local lanes = {
        angle,
        angle + HALF_PI,
        angle + 3.141592,
        angle + 4.712388,
    }

    for i = 1, #lanes, 1 do
        local x1, y1 = point_on_circle(state.center_x, state.center_y, OUTER_RING_RADIUS, lanes[i])
        local x2, y2 = point_on_circle(state.center_x, state.center_y, 50.0, lanes[i])
        for step = 0, 6, 1 do
            local progress = step / 6
            local x = x1 + (x2 - x1) * progress
            local y = y1 + (y2 - y1) * progress
            effect_at("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", x, y)
        end
    end
end

local function damage_sweeps(state, angle, amount)
    local lanes = {
        angle,
        angle + HALF_PI,
        angle + 3.141592,
        angle + 4.712388,
    }

    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 120.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        for i = 1, #lanes, 1 do
            local x1, y1 = point_on_circle(state.center_x, state.center_y, OUTER_RING_RADIUS, lanes[i])
            local x2, y2 = point_on_circle(state.center_x, state.center_y, 50.0, lanes[i])
            if point_line_distance(tx, ty, x1, y1, x2, y2) <= LANE_HALF_WIDTH and mark_hit(state.hit_marks, target) then
                damage_target(state.caster, target, amount)
                effect_on_target("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin")
                move_toward(target, state.center_x, state.center_y, 0.10)
                break
            end
        end
    end)
end

local function draw_pillar(state, angle)
    local x, y = point_on_circle(state.center_x, state.center_y, 250.0, angle)
    effect_at("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", x, y)
    effect_at("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", x, y)
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", x, y)
end

local function damage_pillar(state, angle, amount)
    local x, y = point_on_circle(state.center_x, state.center_y, 250.0, angle)
    sweep_enemies(state.caster, x, y, PILLAR_RADIUS + 80.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if distance_between(x, y, tx, ty) <= PILLAR_RADIUS and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.12)
        end
    end)
end

local function damage_finale_pull(state, radius, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, radius + 90.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if distance_between(state.center_x, state.center_y, tx, ty) <= radius and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.18)
        end
    end)
end

local function damage_finale_burst(state, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, FINALE_RADIUS + 80.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if distance_between(state.center_x, state.center_y, tx, ty) <= FINALE_RADIUS and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", target, "origin")
            effect_on_target("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", target, "chest")
        end
    end)
end

local function start_finale_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, FINALE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 4
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = OUTER_RING_RADIUS - tick * 36.0
        if radius < FINALE_RADIUS then
            radius = FINALE_RADIUS
        end

        update_beacons(state, radius, tick * 0.52)
        set_unit_position(state.caster, state.center_x, state.center_y)
        set_caster_pose(state.caster, tick * 48.0, "spell slam", 1.24)
        draw_ring(state, radius, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl")

        if tick < FINALE_TICKS then
            damage_finale_pull(state, radius, DAMAGE * FINALE_PULL_DAMAGE_FACTOR)
        else
            damage_finale_burst(state, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
            effect_at("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", state.center_x, state.center_y)
        end

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            cleanup_state(state)
        end
    end)
end

local function start_pillar_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PILLAR_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local base_angle = tick * 0.64
        update_beacons(state, BEACON_RADIUS - 60.0, base_angle)
        set_unit_position(state.caster, state.beacons[1].x, state.beacons[1].y)
        set_caster_pose(state.caster, base_angle * DEG, "attack", 1.16)

        for i = 1, 3, 1 do
            local angle = base_angle + (i - 1) * 2.094395
            draw_pillar(state, angle)
            damage_pillar(state, angle, DAMAGE * PILLAR_DAMAGE_FACTOR)
        end

        if tick >= PILLAR_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_sweep_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, SWEEP_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local angle = tick * 0.40
        update_beacons(state, BEACON_RADIUS, angle * 0.5)
        set_unit_position(state.caster, state.center_x, state.center_y)
        set_caster_pose(state.caster, angle * DEG, "spell", 1.12)
        draw_sweeps(state, angle)
        damage_sweeps(state, angle, DAMAGE * SWEEP_DAMAGE_FACTOR)

        if tick >= SWEEP_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_pillar_phase(state)
        end
    end)
end

local function start_lattice_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, LATTICE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        update_beacons(state, BEACON_RADIUS + 18.0 * _F.Sin(tick * 0.55), tick * 0.30)
        set_unit_position(state.caster, state.beacons[1].x, state.beacons[1].y)
        set_caster_pose(state.caster, state.beacons[1].angle * DEG, "spell channel", 1.10)
        draw_lattice(state)
        damage_lattice(state, DAMAGE * LATTICE_DAMAGE_FACTOR)

        if tick >= LATTICE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_sweep_phase(state)
        end
    end)
end

local function start_announce_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.26)

    _F.TimerStart(timer, ANNOUNCE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = OUTER_RING_RADIUS + 24.0 * _F.Sin(tick * 0.6)
        update_beacons(state, BEACON_RADIUS, tick * 0.12)
        draw_ring(state, radius, "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
        effect_at("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", state.center_x, state.center_y)
        damage_ring(state, radius, 54.0, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_lattice_phase(state)
        end
    end)
end

local function begin_skill(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local center_x, center_y = clamp_target(start_x, start_y, target_x, target_y)
    local state = create_state(caster, center_x, center_y)

    create_domain_objects(state)
    start_announce_phase(state)
end

function solar_judgment_lattice.init()
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

return solar_judgment_lattice
