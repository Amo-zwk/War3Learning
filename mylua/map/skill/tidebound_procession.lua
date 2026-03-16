local tidebound_procession = {}

local DAMAGE = 1480 -- You may change this damage value only.

local ABILITY_ID = char2id("C027")
local HIDDEN_ABILITY_ID = char2id("C028")
local DUMMY_UNIT_ID = char2id("u015")

local MAX_CAST_RANGE = 980.0
local DOMAIN_RADIUS = 720.0
local BEACON_RADIUS = 560.0
local OUTER_RING_RADIUS = 610.0
local WALL_HALF_WIDTH = 96.0
local WALL_GAP = 150.0
local SANCTUARY_RADIUS = 255.0
local SANCTUARY_SAFE_RADIUS = 175.0
local JUDGMENT_START_RADIUS = 510.0
local JUDGMENT_IMPACT_RADIUS = 150.0
local FINALE_PULL_RADIUS = 420.0
local FINALE_BURST_RADIUS = 320.0
local BEACON_COUNT = 6

local ANNOUNCE_TICKS = 7
local ANNOUNCE_PERIOD = 0.16
local WALL_TICKS = 8
local WALL_PERIOD = 0.17
local UNDERTOW_TICKS = 8
local UNDERTOW_PERIOD = 0.16
local JUDGMENT_TICKS = 6
local JUDGMENT_PERIOD = 0.18

local ANNOUNCE_DAMAGE_FACTOR = 0.06
local WALL_DAMAGE_FACTOR = 0.17
local UNDERTOW_DAMAGE_FACTOR = 0.18
local JUDGMENT_DAMAGE_FACTOR = 0.24
local FINALE_PULL_DAMAGE_FACTOR = 0.14
local FINALE_BURST_DAMAGE_FACTOR = 1.15

local FULL_CIRCLE = 6.283185
local HALF_PI = 1.570796
local PI = 3.141592
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
        sanctuary = nil,
        beacons = {},
        hit_marks = {},
        sanctuary_angle = 0.0,
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
    state.sanctuary = create_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)

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

    if state.sanctuary ~= nil then
        _F.RemoveUnit(state.sanctuary)
        state.sanctuary = nil
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
        effect_at("Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl", x, y)
    end
end

local function update_sanctuary(state, angle, radius)
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    state.sanctuary_angle = angle
    set_unit_position(state.sanctuary, x, y)
    _F.SetUnitFacing(state.sanctuary, angle * DEG)
    return x, y
end

local function draw_ring(state, radius, effect_path)
    for i = 1, BEACON_COUNT * 3, 1 do
        local angle = (i - 1) * FULL_CIRCLE / (BEACON_COUNT * 3)
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        effect_at(effect_path, x, y)
    end
end

local function damage_ring(state, radius, thickness, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 150.0, function(target)
        local distance = distance_between(state.center_x, state.center_y, _F.GetUnitX(target), _F.GetUnitY(target))
        if distance >= radius - thickness and distance <= radius + thickness and mark_hit(state.hit_marks, target) then
            effect_on_target("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", target, "origin")
            damage_target(state.caster, target, amount)
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

local function draw_segment(ax, ay, bx, by, effect_path)
    for i = 0, 7, 1 do
        local progress = i / 7.0
        local x = ax + (bx - ax) * progress
        local y = ay + (by - ay) * progress
        effect_at(effect_path, x, y)
    end
end

local function damage_segment(state, ax, ay, bx, by, half_width, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 170.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if point_line_distance(tx, ty, ax, ay, bx, by) <= half_width and mark_hit(state.hit_marks, target) then
            effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
            damage_target(state.caster, target, amount)
        end
    end)
end

local function draw_wall_lanes(state, angle)
    local dir_x = _F.Cos(angle)
    local dir_y = _F.Sin(angle)
    local normal_x = -dir_y
    local normal_y = dir_x

    for lane = -1, 1, 1 do
        local offset = lane * WALL_GAP
        local start_x = state.center_x - dir_x * DOMAIN_RADIUS + normal_x * offset
        local start_y = state.center_y - dir_y * DOMAIN_RADIUS + normal_y * offset
        local end_x = state.center_x + dir_x * DOMAIN_RADIUS + normal_x * offset
        local end_y = state.center_y + dir_y * DOMAIN_RADIUS + normal_y * offset
        draw_segment(start_x, start_y, end_x, end_y, "Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
        damage_segment(state, start_x, start_y, end_x, end_y, WALL_HALF_WIDTH, DAMAGE * WALL_DAMAGE_FACTOR)
    end
end

local function damage_undertow(state, eye_x, eye_y, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 150.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local target_distance = distance_between(state.center_x, state.center_y, tx, ty)
        local eye_distance = distance_between(eye_x, eye_y, tx, ty)

        if target_distance <= DOMAIN_RADIUS + 40.0 and eye_distance > SANCTUARY_SAFE_RADIUS then
            move_toward(target, eye_x, eye_y, 0.16)
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", target, "chest")
                damage_target(state.caster, target, amount)
            end
        end
    end)
end

local function draw_undertow(state, eye_x, eye_y, tick)
    local outer_radius = OUTER_RING_RADIUS - 18.0 * _F.Sin(tick * 0.8)
    draw_ring(state, outer_radius, "Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
    effect_at("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", eye_x, eye_y)
    effect_at("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", eye_x, eye_y)

    for i = 1, 5, 1 do
        local angle = state.sanctuary_angle + i * 0.9 + tick * 0.13
        local x, y = point_on_circle(eye_x, eye_y, SANCTUARY_SAFE_RADIUS + 30.0, angle)
        effect_at("Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl", x, y)
    end
end

local function draw_judgment_marks(state, eye_x, eye_y, progress)
    for i = 0, 3, 1 do
        local angle = i * HALF_PI
        local start_x, start_y = point_on_circle(state.center_x, state.center_y, JUDGMENT_START_RADIUS, angle)
        local impact_x = start_x + (eye_x - start_x) * progress
        local impact_y = start_y + (eye_y - start_y) * progress
        draw_segment(start_x, start_y, impact_x, impact_y, "Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
        effect_at("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", impact_x, impact_y)

        sweep_enemies(state.caster, impact_x, impact_y, JUDGMENT_IMPACT_RADIUS + 90.0, function(target)
            local tx = _F.GetUnitX(target)
            local ty = _F.GetUnitY(target)
            if distance_between(impact_x, impact_y, tx, ty) <= JUDGMENT_IMPACT_RADIUS and mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
                damage_target(state.caster, target, DAMAGE * JUDGMENT_DAMAGE_FACTOR)
            end
        end)
    end
end

local function perform_finale(state)
    local eye_x = _F.GetUnitX(state.sanctuary)
    local eye_y = _F.GetUnitY(state.sanctuary)

    set_unit_position(state.caster, eye_x, eye_y - 40.0)
    set_caster_pose(state.caster, 90.0, "attack slam", 1.28)

    draw_ring(state, OUTER_RING_RADIUS, "Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl")
    effect_at("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", eye_x, eye_y)
    effect_at("Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl", eye_x, eye_y)
    effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", eye_x, eye_y)

    sweep_enemies(state.caster, eye_x, eye_y, FINALE_PULL_RADIUS, function(target)
        move_toward(target, eye_x, eye_y, 0.34)
        effect_on_target("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", target, "origin")
        damage_target(state.caster, target, DAMAGE * FINALE_PULL_DAMAGE_FACTOR)
    end)

    sweep_enemies(state.caster, eye_x, eye_y, FINALE_BURST_RADIUS, function(target)
        effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
        damage_target(state.caster, target, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
    end)

    cleanup_state(state)
end

local function start_judgment_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local eye_x = _F.GetUnitX(state.sanctuary)
    local eye_y = _F.GetUnitY(state.sanctuary)
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), eye_x, eye_y) * DEG

    set_caster_pose(state.caster, facing, "spell slam", 1.22)

    _F.TimerStart(timer, JUDGMENT_PERIOD, true, function()
        tick = tick + 1
        clear_hit_marks(state.hit_marks)

        local progress = tick / JUDGMENT_TICKS
        update_beacons(state, BEACON_RADIUS - 30.0 * progress, state.sanctuary_angle + tick * 0.10)
        effect_at("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", eye_x, eye_y)
        draw_judgment_marks(state, eye_x, eye_y, progress)

        if tick >= JUDGMENT_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            perform_finale(state)
        end
    end)
end

local function start_undertow_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    set_caster_pose(state.caster, 270.0, "spell", 1.18)

    _F.TimerStart(timer, UNDERTOW_PERIOD, true, function()
        tick = tick + 1
        clear_hit_marks(state.hit_marks)

        local angle = PI * 0.35 + tick * 0.62
        local eye_x, eye_y = update_sanctuary(state, angle, SANCTUARY_RADIUS)
        update_beacons(state, BEACON_RADIUS - 28.0, angle * 0.65)

        local caster_x, caster_y = point_on_circle(state.center_x, state.center_y, 160.0, angle + PI)
        set_unit_position(state.caster, caster_x, caster_y)
        _F.SetUnitFacing(state.caster, angle_between(caster_x, caster_y, eye_x, eye_y) * DEG)

        draw_undertow(state, eye_x, eye_y, tick)
        damage_undertow(state, eye_x, eye_y, DAMAGE * UNDERTOW_DAMAGE_FACTOR)

        if tick >= UNDERTOW_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_judgment_phase(state)
        end
    end)
end

local function start_wall_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local start_angle = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y)

    set_caster_pose(state.caster, start_angle * DEG, "attack", 1.20)

    _F.TimerStart(timer, WALL_PERIOD, true, function()
        tick = tick + 1
        clear_hit_marks(state.hit_marks)

        local angle = start_angle + HALF_PI * 0.35 + tick * 0.42
        local caster_x, caster_y = point_on_circle(state.center_x, state.center_y, 260.0, angle + PI)
        set_unit_position(state.caster, caster_x, caster_y)
        _F.SetUnitFacing(state.caster, angle * DEG)

        update_beacons(state, BEACON_RADIUS + 15.0 * _F.Sin(tick * 0.7), angle * 0.22)
        draw_wall_lanes(state, angle)
        effect_at("Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl", state.center_x, state.center_y)

        if tick >= WALL_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_undertow_phase(state)
        end
    end)
end

local function start_announce_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.24)

    _F.TimerStart(timer, ANNOUNCE_PERIOD, true, function()
        tick = tick + 1
        clear_hit_marks(state.hit_marks)

        local radius = OUTER_RING_RADIUS + 16.0 * _F.Sin(tick * 0.6)
        update_beacons(state, BEACON_RADIUS, tick * 0.12)
        draw_ring(state, radius, "Abilities\\Spells\\Other\\Tornado\\Tornado_Target.mdl")
        effect_at("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", state.center_x, state.center_y)
        damage_ring(state, radius, 58.0, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_wall_phase(state)
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

function tidebound_procession.init()
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

return tidebound_procession
