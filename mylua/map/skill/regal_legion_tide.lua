local regal_legion_tide = {}

local DAMAGE = 1240 -- You may change this damage value only.

local ABILITY_ID = char2id("C021")
local HIDDEN_ABILITY_ID = char2id("C022")
local DUMMY_UNIT_ID = char2id("u012")

local MAX_CAST_RANGE = 980.0
local DOMAIN_RADIUS = 640.0
local BANNER_RADIUS = 500.0
local OUTER_RING_RADIUS = 540.0
local INNER_RING_RADIUS = 260.0
local LINE_HALF_WIDTH = 86.0
local CHARGE_HALF_WIDTH = 110.0
local VOLLEY_RADIUS = 150.0
local FINALE_RADIUS = 320.0
local BANNER_COUNT = 8

local ANNOUNCE_TICKS = 7
local ANNOUNCE_PERIOD = 0.16
local INFANTRY_TICKS = 8
local INFANTRY_PERIOD = 0.16
local CAVALRY_TICKS = 8
local CAVALRY_PERIOD = 0.15
local VOLLEY_TICKS = 7
local VOLLEY_PERIOD = 0.16
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.13

local ANNOUNCE_DAMAGE_FACTOR = 0.07
local INFANTRY_DAMAGE_FACTOR = 0.15
local CAVALRY_DAMAGE_FACTOR = 0.18
local VOLLEY_DAMAGE_FACTOR = 0.20
local FINALE_PULL_DAMAGE_FACTOR = 0.11
local FINALE_BURST_DAMAGE_FACTOR = 1.04

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
        banners = {},
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

    for i = 1, BANNER_COUNT, 1 do
        local angle = (i - 1) * FULL_CIRCLE / BANNER_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, BANNER_RADIUS, angle)
        state.banners[i] = {
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

    for i = 1, #state.banners, 1 do
        if state.banners[i] ~= nil and state.banners[i].unit ~= nil then
            _F.RemoveUnit(state.banners[i].unit)
            state.banners[i].unit = nil
        end
    end
end

local function update_banners(state, radius, base_angle)
    for i = 1, #state.banners, 1 do
        local banner = state.banners[i]
        local angle = base_angle + (i - 1) * FULL_CIRCLE / BANNER_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        banner.x = x
        banner.y = y
        banner.angle = angle
        set_unit_position(banner.unit, x, y)
        _F.SetUnitFacing(banner.unit, angle * DEG)
        effect_at("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", x, y)
    end
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

local function draw_ring(state, radius, effect_path)
    for i = 1, 12, 1 do
        local angle = (i - 1) * FULL_CIRCLE / 12
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
            effect_on_target("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", target, "origin")
        end
    end)
end

local function infantry_line_data(state, lane_index, progress, reverse)
    local lane_offsets = { -210.0, 0.0, 210.0 }
    local y = state.center_y + lane_offsets[lane_index]
    local start_x = state.center_x - DOMAIN_RADIUS - 80.0
    local end_x = state.center_x + DOMAIN_RADIUS + 80.0

    if reverse then
        start_x = state.center_x + DOMAIN_RADIUS + 80.0
        end_x = state.center_x - DOMAIN_RADIUS - 80.0
    end

    local front_x = start_x + (end_x - start_x) * progress
    local rear_x = front_x - 220.0
    if reverse then
        rear_x = front_x + 220.0
    end

    return rear_x, y, front_x, y
end

local function draw_infantry_line(state, lane_index, progress, reverse)
    local ax, ay, bx, by = infantry_line_data(state, lane_index, progress, reverse)
    for step = 0, 6, 1 do
        local ratio = step / 6
        local x = ax + (bx - ax) * ratio
        local y = ay + (by - ay) * ratio
        effect_at("Abilities\\Weapons\\FootmanMissile\\FootmanMissile.mdl", x, y)
        effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y)
    end
end

local function damage_infantry_line(state, lane_index, progress, reverse, amount)
    local ax, ay, bx, by = infantry_line_data(state, lane_index, progress, reverse)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 140.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if point_line_distance(tx, ty, ax, ay, bx, by) <= LINE_HALF_WIDTH and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.07)
        end
    end)
end

local function cavalry_charge_data(state, angle, progress)
    local start_x, start_y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS + 120.0, angle)
    local end_x, end_y = point_on_circle(state.center_x, state.center_y, 90.0, angle)
    local head_x = start_x + (end_x - start_x) * progress
    local head_y = start_y + (end_y - start_y) * progress
    local tail_x = start_x + (end_x - start_x) * math.max(progress - 0.22, 0.0)
    local tail_y = start_y + (end_y - start_y) * math.max(progress - 0.22, 0.0)
    return tail_x, tail_y, head_x, head_y
end

local function draw_cavalry_charge(state, angle, progress)
    local ax, ay, bx, by = cavalry_charge_data(state, angle, progress)
    for step = 0, 6, 1 do
        local ratio = step / 6
        local x = ax + (bx - ax) * ratio
        local y = ay + (by - ay) * ratio
        effect_at("Abilities\\Weapons\\BallistaMissile\\BallistaMissile.mdl", x, y)
        effect_at("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", x, y)
    end
end

local function damage_cavalry_charge(state, angle, progress, amount)
    local ax, ay, bx, by = cavalry_charge_data(state, angle, progress)
    sweep_enemies(state.caster, state.center_x, state.center_y, DOMAIN_RADIUS + 150.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if point_line_distance(tx, ty, ax, ay, bx, by) <= CHARGE_HALF_WIDTH and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.12)
        end
    end)
end

local function volley_target_data(state, angle, radius)
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    return x, y
end

local function draw_volley_impact(state, angle, radius)
    local x, y = volley_target_data(state, angle, radius)
    effect_at("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", x, y)
    effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", x, y)
end

local function damage_volley_impact(state, angle, radius, amount)
    local x, y = volley_target_data(state, angle, radius)
    sweep_enemies(state.caster, x, y, VOLLEY_RADIUS + 80.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if distance_between(x, y, tx, ty) <= VOLLEY_RADIUS and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.09)
        end
    end)
end

local function damage_finale_pull(state, radius, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, radius + 120.0, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        if distance_between(state.center_x, state.center_y, tx, ty) <= radius and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl", target, "origin")
            move_toward(target, state.center_x, state.center_y, 0.18)
        end
    end)
end

local function damage_finale_burst(state, amount)
    sweep_enemies(state.caster, state.center_x, state.center_y, FINALE_RADIUS + 100.0, function(target)
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

        local radius = BANNER_RADIUS - tick * 34.0
        if radius < FINALE_RADIUS then
            radius = FINALE_RADIUS
        end

        update_banners(state, radius, tick * 0.34)
        set_unit_position(state.caster, state.center_x, state.center_y)
        set_caster_pose(state.caster, tick * 50.0, "spell slam", 1.24)
        draw_ring(state, radius, "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl")

        if tick < FINALE_TICKS then
            damage_finale_pull(state, radius, DAMAGE * FINALE_PULL_DAMAGE_FACTOR)
        else
            draw_ring(state, FINALE_RADIUS, "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
            effect_at("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", state.center_x, state.center_y)
            damage_finale_burst(state, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
        end

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            cleanup_state(state)
        end
    end)
end

local function start_volley_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, VOLLEY_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local base_angle = tick * 0.42
        local target_radius = INNER_RING_RADIUS + 36.0 * _F.Sin(tick * 0.55)
        update_banners(state, BANNER_RADIUS, base_angle * 0.5)
        set_unit_position(state.caster, state.banners[1].x, state.banners[1].y)
        set_caster_pose(state.caster, (state.banners[1].angle + PI) * DEG, "attack", 1.16)

        for i = 1, 4, 1 do
            local angle = base_angle + (i - 1) * HALF_PI
            draw_volley_impact(state, angle, target_radius)
            damage_volley_impact(state, angle, target_radius, DAMAGE * VOLLEY_DAMAGE_FACTOR)
        end

        if tick >= VOLLEY_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_cavalry_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, CAVALRY_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local progress = tick / CAVALRY_TICKS
        local base_angle = tick * 0.18
        update_banners(state, BANNER_RADIUS - 20.0, base_angle)
        set_unit_position(state.caster, state.center_x, state.center_y)
        set_caster_pose(state.caster, base_angle * DEG, "spell", 1.14)

        for i = 1, 4, 1 do
            local angle = base_angle + (i - 1) * HALF_PI
            draw_cavalry_charge(state, angle, progress)
            damage_cavalry_charge(state, angle, progress, DAMAGE * CAVALRY_DAMAGE_FACTOR)
        end

        if tick >= CAVALRY_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_volley_phase(state)
        end
    end)
end

local function start_infantry_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, INFANTRY_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local progress = tick / INFANTRY_TICKS
        update_banners(state, BANNER_RADIUS + 12.0 * _F.Sin(tick * 0.50), tick * 0.15)
        set_unit_position(state.caster, state.banners[1].x, state.banners[1].y)
        set_caster_pose(state.caster, state.banners[1].angle * DEG, "spell channel", 1.10)

        for lane = 1, 3, 1 do
            draw_infantry_line(state, lane, progress, false)
            damage_infantry_line(state, lane, progress, false, DAMAGE * INFANTRY_DAMAGE_FACTOR)
            draw_infantry_line(state, lane, progress, true)
            damage_infantry_line(state, lane, progress, true, DAMAGE * INFANTRY_DAMAGE_FACTOR)
        end

        if tick >= INFANTRY_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_cavalry_phase(state)
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
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local radius = OUTER_RING_RADIUS + 18.0 * _F.Sin(tick * 0.65)
        update_banners(state, BANNER_RADIUS, tick * 0.10)
        draw_ring(state, radius, "Abilities\\Spells\\Human\\Flare\\FlareCaster.mdl")
        effect_at("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", state.center_x, state.center_y)
        damage_ring(state, radius, 56.0, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_infantry_phase(state)
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

function regal_legion_tide.init()
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

return regal_legion_tide
