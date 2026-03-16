local abyssal_maw_decree = {}

local DAMAGE = 980 -- You may change this damage value only.

local ABILITY_ID = char2id("C013")
local HIDDEN_ABILITY_ID = char2id("C014")
local DUMMY_UNIT_ID = char2id("u008")

local MAX_CAST_RANGE = 980.0
local DOMAIN_RADIUS = 620.0
local BEACON_RADIUS = 520.0
local ANNOUNCE_RING_RADIUS = 470.0
local JAW_HALF_WIDTH = 88.0
local JAW_ANGLE_WIDTH = 0.30
local VORTEX_RADIUS = 285.0
local VORTEX_AOE = 150.0
local LANCE_HALF_WIDTH = 82.0
local LANCE_LENGTH = 700.0
local FINALE_PULL_RADIUS = 640.0
local FINALE_BURST_RADIUS = 300.0

local ANNOUNCE_TICKS = 7
local ANNOUNCE_PERIOD = 0.16
local JAW_TICKS = 10
local JAW_PERIOD = 0.14
local VORTEX_TICKS = 9
local VORTEX_PERIOD = 0.16
local LANCE_TICKS = 8
local LANCE_PERIOD = 0.15
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.12

local ANNOUNCE_DAMAGE_FACTOR = 0.07
local JAW_DAMAGE_FACTOR = 0.13
local VORTEX_DAMAGE_FACTOR = 0.14
local LANCE_DAMAGE_FACTOR = 0.16
local FINALE_PULL_DAMAGE_FACTOR = 0.10
local FINALE_BURST_DAMAGE_FACTOR = 0.94

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

local function normalize_angle(angle)
    while angle < 0.0 do
        angle = angle + FULL_CIRCLE
    end
    while angle >= FULL_CIRCLE do
        angle = angle - FULL_CIRCLE
    end
    return angle
end

local function angle_delta(a, b)
    local delta = normalize_angle(a - b)
    if delta > 3.141592 then
        delta = FULL_CIRCLE - delta
    end
    return delta
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
        vortices = {},
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

local function move_sideways(target, angle, distance)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + _F.Cos(angle) * distance, ty + _F.Sin(angle) * distance)
end

local function point_line_distance(px, py, ax, ay, bx, by)
    local vx = bx - ax
    local vy = by - ay
    local wx = px - ax
    local wy = py - ay
    local vv = vx * vx + vy * vy

    if vv < 1.0 then
        return distance_between(px, py, ax, ay), 0.0
    end

    local t = (wx * vx + wy * vy) / vv
    if t < 0.0 then
        t = 0.0
    elseif t > 1.0 then
        t = 1.0
    end

    local cx = ax + vx * t
    local cy = ay + vy * t
    return distance_between(px, py, cx, cy), t
end

local function create_domain_objects(state)
    state.anchor = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)

    for i = 1, 8, 1 do
        local angle = (i - 1) * FULL_CIRCLE / 8
        local x, y = point_on_circle(state.center_x, state.center_y, BEACON_RADIUS, angle)
        state.beacons[i] = create_hidden_dummy(state.owner, x, y, angle * DEG)
    end

    for i = 1, 3, 1 do
        state.vortices[i] = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)
    end
end

local function cleanup_state(state)
    finish_caster_pose(state.caster)

    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.beacons, 1 do
        if state.beacons[i] ~= nil then
            _F.RemoveUnit(state.beacons[i])
            state.beacons[i] = nil
        end
    end

    for i = 1, #state.vortices, 1 do
        if state.vortices[i] ~= nil then
            _F.RemoveUnit(state.vortices[i])
            state.vortices[i] = nil
        end
    end
end

local function move_caster_on_ring(state, angle, radius, animation, scale)
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    set_unit_position(state.caster, x, y)
    set_caster_pose(state.caster, normalize_angle(angle + 3.141592) * DEG, animation, scale)
end

local function draw_domain_ring(state, radius, effect_path)
    for i = 1, 8, 1 do
        local angle = (i - 1) * FULL_CIRCLE / 8
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        effect_at(effect_path, x, y)
    end
end

local function damage_ring(state, radius, thickness, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 120.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if math.abs(distance - radius) <= thickness and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
        end
    end)
end

local function draw_jaw_line(state, angle, side)
    local dir_angle = angle + side * HALF_PI
    local start_x, start_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS, dir_angle)
    local end_x, end_y = point_on_circle(state.center_x, state.center_y, 90.0, dir_angle)

    for step = 0, 6, 1 do
        local progress = step / 6
        local x = start_x + (end_x - start_x) * progress
        local y = start_y + (end_y - start_y) * progress
        effect_at("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl", x, y)
    end
end

local function damage_jaws(state, angle, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 90.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local target_angle = angle_between(state.center_x, state.center_y, tx, ty)
        local target_distance = distance_between(state.center_x, state.center_y, tx, ty)

        if target_distance <= DOMAIN_RADIUS + 40.0 then
            local on_left = angle_delta(target_angle, angle + HALF_PI) <= JAW_ANGLE_WIDTH
            local on_right = angle_delta(target_angle, angle - HALF_PI) <= JAW_ANGLE_WIDTH
            if (on_left or on_right) and mark_hit(state.hit_marks, target) then
                damage_target(state.caster, target, amount)
                effect_on_target("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", target, "origin")
                move_toward(target, state.center_x, state.center_y, 0.11)
            end
        end
    end)
end

local function update_vortices(state, base_angle)
    for i = 1, 3, 1 do
        local angle = base_angle + (i - 1) * FULL_CIRCLE / 3
        local x, y = point_on_circle(state.center_x, state.center_y, VORTEX_RADIUS, angle)
        local vortex = state.vortices[i]
        set_unit_position(vortex, x, y)
        _F.SetUnitFacing(vortex, normalize_angle(angle + 3.141592) * DEG)
        effect_at("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", x, y)
    end
end

local function damage_vortices(state, amount)
    for i = 1, #state.vortices, 1 do
        local vortex = state.vortices[i]
        if vortex ~= nil then
            local vx = _F.GetUnitX(vortex)
            local vy = _F.GetUnitY(vortex)
            sweep_enemies(state.caster, vx, vy, VORTEX_AOE + 110.0, function(target)
                local tx = _F.GetUnitX(target)
                local ty = _F.GetUnitY(target)
                local distance = distance_between(vx, vy, tx, ty)
                if distance <= VORTEX_AOE and mark_hit(state.hit_marks, target) then
                    damage_target(state.caster, target, amount)
                    effect_on_target("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", target, "origin")
                    move_toward(target, vx, vy, 0.16)
                end
            end)
        end
    end
end

local function draw_lance(state, angle)
    local start_x, start_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS + 30.0, angle)
    local end_x, end_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS - LANCE_LENGTH, angle)

    for step = 0, 7, 1 do
        local progress = step / 7
        local x = start_x + (end_x - start_x) * progress
        local y = start_y + (end_y - start_y) * progress
        effect_at("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", x, y)
    end
end

local function damage_lance(state, angle, amount)
    local start_x, start_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS + 30.0, angle)
    local end_x, end_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS - LANCE_LENGTH, angle)

    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 120.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local line_distance, progress = point_line_distance(tx, ty, start_x, start_y, end_x, end_y)
        if progress >= 0.0 and progress <= 1.0 and line_distance <= LANCE_HALF_WIDTH and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", target, "origin")
            move_sideways(target, angle + HALF_PI, 34.0)
        end
    end)
end

local function draw_finale_field(state, radius)
    for i = 1, 10, 1 do
        local angle = (i - 1) * FULL_CIRCLE / 10
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        effect_at("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl", x, y)
        effect_at("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", x, y)
    end
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
end

local function damage_finale_pull(state, radius, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, radius + 60.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if distance <= radius and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.20)
        end
    end)
end

local function damage_finale_burst(state, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, FINALE_BURST_RADIUS + 80.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if distance <= FINALE_BURST_RADIUS and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
            effect_on_target("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", target, "chest")
        end
    end)
end

local function finish_skill(state)
    cleanup_state(state)
end

local function start_finale_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, FINALE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 4
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = FINALE_PULL_RADIUS - tick * 42.0
        if radius < FINALE_BURST_RADIUS then
            radius = FINALE_BURST_RADIUS
        end

        move_caster_on_ring(state, tick * 0.42, 210.0, "spell", 1.25)
        draw_finale_field(state, radius)

        if tick < FINALE_TICKS then
            damage_finale_pull(state, radius, DAMAGE * FINALE_PULL_DAMAGE_FACTOR)
        else
            damage_finale_burst(state, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
            effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
            effect_at("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", state.center_x, state.center_y)
        end

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            finish_skill(state)
        end
    end)
end

local function start_lance_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, LANCE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local base_angle = tick * 0.34
        move_caster_on_ring(state, base_angle + 3.141592, DOMAIN_RADIUS - 130.0, "attack", 1.18)

        for i = 1, 4, 1 do
            local angle = base_angle + (i - 1) * HALF_PI
            draw_lance(state, angle)
            damage_lance(state, angle, DAMAGE * LANCE_DAMAGE_FACTOR)
        end

        if tick >= LANCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_vortex_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, VORTEX_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local base_angle = tick * 0.47
        move_caster_on_ring(state, base_angle, DOMAIN_RADIUS - 90.0, "spell channel", 1.10)
        update_vortices(state, base_angle)
        draw_domain_ring(state, ANNOUNCE_RING_RADIUS - 70.0, "Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl")
        damage_vortices(state, DAMAGE * VORTEX_DAMAGE_FACTOR)

        if tick >= VORTEX_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_lance_phase(state)
        end
    end)
end

local function start_jaw_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, JAW_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local angle = tick * 0.52
        move_caster_on_ring(state, angle + HALF_PI, DOMAIN_RADIUS - 40.0, "attack", 1.16)
        draw_jaw_line(state, angle, 1)
        draw_jaw_line(state, angle, -1)
        draw_domain_ring(state, DOMAIN_RADIUS - 40.0, "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl")
        damage_jaws(state, angle, DAMAGE * JAW_DAMAGE_FACTOR)

        if tick >= JAW_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_vortex_phase(state)
        end
    end)
end

local function start_announce_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.28)

    _F.TimerStart(timer, ANNOUNCE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local ring_radius = ANNOUNCE_RING_RADIUS + 18.0 * _F.Sin(tick * 0.6)
        draw_domain_ring(state, ring_radius, "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")
        draw_domain_ring(state, BEACON_RADIUS, "Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl")
        effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
        damage_ring(state, ring_radius, 55.0, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_jaw_phase(state)
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

function abyssal_maw_decree.init()
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

return abyssal_maw_decree
