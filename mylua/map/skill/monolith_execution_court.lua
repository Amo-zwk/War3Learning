local monolith_execution_court = {}

local DAMAGE = 1040 -- You may change this damage value only.

local ABILITY_ID = char2id("C015")
local HIDDEN_ABILITY_ID = char2id("C016")
local DUMMY_UNIT_ID = char2id("u009")

local MAX_CAST_RANGE = 980.0
local COURT_HALF_SIZE = 420.0
local CORNER_OFFSET = 430.0
local BORDER_THICKNESS = 56.0
local GRID_HALF_WIDTH = 86.0
local DIAGONAL_HALF_WIDTH = 78.0
local STRIKE_RADIUS = 150.0
local FINALE_MIN_HALF = 130.0
local CENTER_BURST_RADIUS = 250.0

local ANNOUNCE_TICKS = 7
local ANNOUNCE_PERIOD = 0.16
local GRID_TICKS = 10
local GRID_PERIOD = 0.14
local DIAGONAL_TICKS = 9
local DIAGONAL_PERIOD = 0.15
local PYLON_TICKS = 8
local PYLON_PERIOD = 0.16
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.12

local ANNOUNCE_DAMAGE_FACTOR = 0.07
local GRID_DAMAGE_FACTOR = 0.14
local DIAGONAL_DAMAGE_FACTOR = 0.16
local PYLON_DAMAGE_FACTOR = 0.18
local FINALE_PULL_DAMAGE_FACTOR = 0.10
local FINALE_BURST_DAMAGE_FACTOR = 0.96

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

local function create_geometry(caster_x, caster_y, center_x, center_y)
    local angle = angle_between(caster_x, caster_y, center_x, center_y) + 0.785398
    local fx = _F.Cos(angle)
    local fy = _F.Sin(angle)
    local rx = -fy
    local ry = fx

    return {
        center_x = center_x,
        center_y = center_y,
        angle = angle,
        facing = angle * DEG,
        fx = fx,
        fy = fy,
        rx = rx,
        ry = ry,
        bound_radius = _F.SquareRoot(COURT_HALF_SIZE * COURT_HALF_SIZE * 2.0) + 220.0,
    }
end

local function world_from_local(geom, forward, side)
    return geom.center_x + geom.fx * forward + geom.rx * side,
        geom.center_y + geom.fy * forward + geom.ry * side
end

local function local_from_world(geom, x, y)
    local dx = x - geom.center_x
    local dy = y - geom.center_y
    return dx * geom.fx + dy * geom.fy, dx * geom.rx + dy * geom.ry
end

local function create_state(caster, geom)
    return {
        caster = caster,
        owner = _F.GetOwningPlayer(caster),
        geom = geom,
        anchor = nil,
        corners = {},
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

local function sweep_court_enemies(state, callback)
    local geom = state.geom
    sweep_units(geom.center_x, geom.center_y, geom.bound_radius, function(target)
        if is_living_enemy(state.caster, target) then
            local forward, side = local_from_world(geom, _F.GetUnitX(target), _F.GetUnitY(target))
            callback(target, forward, side)
        end
    end)
end

local function move_toward(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + (x - tx) * factor, ty + (y - ty) * factor)
end

local function move_away(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + (tx - x) * factor, ty + (ty - y) * factor)
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

local function create_court_objects(state)
    local geom = state.geom
    state.anchor = create_hidden_dummy(state.owner, geom.center_x, geom.center_y, geom.facing)

    local offsets = {
        { CORNER_OFFSET, CORNER_OFFSET },
        { CORNER_OFFSET, -CORNER_OFFSET },
        { -CORNER_OFFSET, -CORNER_OFFSET },
        { -CORNER_OFFSET, CORNER_OFFSET },
    }

    for i = 1, #offsets, 1 do
        local x, y = world_from_local(geom, offsets[i][1], offsets[i][2])
        state.corners[i] = create_hidden_dummy(state.owner, x, y, geom.facing + (i - 1) * 90.0)
    end
end

local function cleanup_state(state)
    finish_caster_pose(state.caster)

    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.corners, 1 do
        if state.corners[i] ~= nil then
            _F.RemoveUnit(state.corners[i])
            state.corners[i] = nil
        end
    end
end

local function place_caster_on_ring(state, angle, radius, animation, scale)
    local x, y = point_on_circle(state.geom.center_x, state.geom.center_y, radius, angle)
    set_unit_position(state.caster, x, y)
    set_caster_pose(state.caster, (angle + 3.141592) * DEG, animation, scale)
end

local function draw_square_border(state, half_size, effect_path)
    local geom = state.geom
    for step = -3, 3, 1 do
        local fraction = step / 3
        local edge = half_size * fraction

        local x1, y1 = world_from_local(geom, edge, half_size)
        local x2, y2 = world_from_local(geom, edge, -half_size)
        local x3, y3 = world_from_local(geom, half_size, edge)
        local x4, y4 = world_from_local(geom, -half_size, edge)

        effect_at(effect_path, x1, y1)
        effect_at(effect_path, x2, y2)
        effect_at(effect_path, x3, y3)
        effect_at(effect_path, x4, y4)
    end
end

local function damage_square_border(state, half_size, amount)
    sweep_court_enemies(state, function(target, forward, side)
        local abs_forward = math.abs(forward)
        local abs_side = math.abs(side)
        local on_vertical = abs_forward <= half_size and math.abs(abs_side - half_size) <= BORDER_THICKNESS
        local on_horizontal = abs_side <= half_size and math.abs(abs_forward - half_size) <= BORDER_THICKNESS

        if (on_vertical or on_horizontal) and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", target, "origin")
        end
    end)
end

local function draw_grid_lane(state, axis, offset)
    local geom = state.geom
    for step = -4, 4, 1 do
        local fraction = step / 4
        local x, y
        if axis == 1 then
            x, y = world_from_local(geom, offset, COURT_HALF_SIZE * fraction)
        else
            x, y = world_from_local(geom, COURT_HALF_SIZE * fraction, offset)
        end
        effect_at("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", x, y)
    end
end

local function damage_grid_lane(state, axis, offset, amount)
    sweep_court_enemies(state, function(target, forward, side)
        local inside = math.abs(forward) <= COURT_HALF_SIZE and math.abs(side) <= COURT_HALF_SIZE
        if not inside then
            return
        end

        local distance = math.abs(axis == 1 and (forward - offset) or (side - offset))
        if distance <= GRID_HALF_WIDTH and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", target, "origin")
            move_toward(target, state.geom.center_x, state.geom.center_y, 0.08)
        end
    end)
end

local function draw_diagonal(state, sign, bias)
    local geom = state.geom
    local start_x, start_y = world_from_local(geom, -COURT_HALF_SIZE, sign * (-COURT_HALF_SIZE + bias))
    local end_x, end_y = world_from_local(geom, COURT_HALF_SIZE, sign * (COURT_HALF_SIZE + bias))

    for step = 0, 8, 1 do
        local progress = step / 8
        local x = start_x + (end_x - start_x) * progress
        local y = start_y + (end_y - start_y) * progress
        effect_at("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl", x, y)
    end
end

local function damage_diagonals(state, bias, amount)
    local geom = state.geom
    local lines = {
        { world_from_local(geom, -COURT_HALF_SIZE, -COURT_HALF_SIZE + bias), world_from_local(geom, COURT_HALF_SIZE, COURT_HALF_SIZE + bias) },
        { world_from_local(geom, -COURT_HALF_SIZE, COURT_HALF_SIZE - bias), world_from_local(geom, COURT_HALF_SIZE, -COURT_HALF_SIZE - bias) },
    }

    sweep_court_enemies(state, function(target, forward, side)
        if math.abs(forward) > COURT_HALF_SIZE or math.abs(side) > COURT_HALF_SIZE then
            return
        end

        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local near_first = point_line_distance(tx, ty, lines[1][1], lines[1][2], lines[1][3], lines[1][4]) <= DIAGONAL_HALF_WIDTH
        local near_second = point_line_distance(tx, ty, lines[2][1], lines[2][2], lines[2][3], lines[2][4]) <= DIAGONAL_HALF_WIDTH

        if (near_first or near_second) and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl", target, "origin")
            move_away(target, geom.center_x, geom.center_y, 0.06)
        end
    end)
end

local function draw_corner_strikes(state)
    local geom = state.geom
    for i = 1, #state.corners, 1 do
        local corner = state.corners[i]
        local x = _F.GetUnitX(corner)
        local y = _F.GetUnitY(corner)
        effect_at("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", x, y)
        effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y)
        effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", geom.center_x, geom.center_y)

        for step = 1, 5, 1 do
            local progress = step / 5
            local px = x + (geom.center_x - x) * progress
            local py = y + (geom.center_y - y) * progress
            effect_at("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", px, py)
        end
    end
end

local function damage_corner_strikes(state, amount)
    local geom = state.geom
    for i = 1, #state.corners, 1 do
        local corner = state.corners[i]
        local cx = _F.GetUnitX(corner)
        local cy = _F.GetUnitY(corner)

        sweep_court_enemies(state, function(target, forward, side)
            if math.abs(forward) > COURT_HALF_SIZE or math.abs(side) > COURT_HALF_SIZE then
                return
            end

            local tx = _F.GetUnitX(target)
            local ty = _F.GetUnitY(target)
            local line_distance = point_line_distance(tx, ty, cx, cy, geom.center_x, geom.center_y)
            local center_distance = distance_between(tx, ty, geom.center_x, geom.center_y)

            if (line_distance <= 72.0 or center_distance <= STRIKE_RADIUS) and mark_hit(state.hit_marks, target) then
                damage_target(state.caster, target, amount)
                effect_on_target("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", target, "origin")
                move_toward(target, geom.center_x, geom.center_y, 0.12)
            end
        end)
    end
end

local function draw_finale(state, half_size)
    draw_square_border(state, half_size, "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
    effect_at("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", state.geom.center_x, state.geom.center_y)
end

local function damage_finale_pull(state, half_size, amount)
    sweep_court_enemies(state, function(target, forward, side)
        if math.abs(forward) <= half_size and math.abs(side) <= half_size and mark_hit(state.hit_marks, target) then
            damage_target(state.caster, target, amount)
            effect_on_target("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", target, "origin")
            move_toward(target, state.geom.center_x, state.geom.center_y, 0.18)
        end
    end)
end

local function damage_finale_burst(state, amount)
    sweep_units(state.geom.center_x, state.geom.center_y, CENTER_BURST_RADIUS + 80.0, function(target)
        if is_living_enemy(state.caster, target) and mark_hit(state.hit_marks, target) then
            local tx = _F.GetUnitX(target)
            local ty = _F.GetUnitY(target)
            if distance_between(tx, ty, state.geom.center_x, state.geom.center_y) <= CENTER_BURST_RADIUS then
                damage_target(state.caster, target, amount)
                effect_on_target("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", target, "origin")
                effect_on_target("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", target, "chest")
            end
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

        local progress = tick / FINALE_TICKS
        local half_size = COURT_HALF_SIZE - (COURT_HALF_SIZE - FINALE_MIN_HALF) * progress
        place_caster_on_ring(state, tick * 0.55, 190.0, "spell slam", 1.22)
        draw_finale(state, half_size)

        if tick < FINALE_TICKS then
            damage_finale_pull(state, half_size, DAMAGE * FINALE_PULL_DAMAGE_FACTOR)
        else
            damage_finale_burst(state, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
        end

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            finish_skill(state)
        end
    end)
end

local function start_pylon_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PYLON_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        place_caster_on_ring(state, tick * 0.40 + HALF_PI, 250.0, "spell channel", 1.10)
        draw_corner_strikes(state)
        damage_corner_strikes(state, DAMAGE * PYLON_DAMAGE_FACTOR)

        if tick >= PYLON_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_diagonal_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, DIAGONAL_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local bias = 140.0 * _F.Sin(tick * 0.55)
        place_caster_on_ring(state, tick * 0.48, 320.0, "attack", 1.16)
        draw_diagonal(state, 1, bias)
        draw_diagonal(state, -1, -bias)
        damage_diagonals(state, bias, DAMAGE * DIAGONAL_DAMAGE_FACTOR)

        if tick >= DIAGONAL_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_pylon_phase(state)
        end
    end)
end

local function start_grid_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, GRID_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local progress = tick / GRID_TICKS
        local offset = -COURT_HALF_SIZE + progress * COURT_HALF_SIZE * 2.0
        place_caster_on_ring(state, tick * 0.36 + 3.141592, 280.0, "spell", 1.14)
        draw_grid_lane(state, 1, offset)
        draw_grid_lane(state, 2, -offset)
        damage_grid_lane(state, 1, offset, DAMAGE * GRID_DAMAGE_FACTOR)
        damage_grid_lane(state, 2, -offset, DAMAGE * GRID_DAMAGE_FACTOR)

        if tick >= GRID_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_diagonal_phase(state)
        end
    end)
end

local function start_announce_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.geom.center_x, state.geom.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.26)

    _F.TimerStart(timer, ANNOUNCE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local half_size = COURT_HALF_SIZE - 18.0 * _F.Sin(tick * 0.6)
        draw_square_border(state, half_size, "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl")
        draw_square_border(state, half_size - 70.0, "Abilities\\Weapons\\Bolt\\BoltImpact.mdl")
        damage_square_border(state, half_size, DAMAGE * ANNOUNCE_DAMAGE_FACTOR)

        if tick >= ANNOUNCE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_grid_phase(state)
        end
    end)
end

local function begin_skill(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local center_x, center_y = clamp_target(start_x, start_y, target_x, target_y)
    local geom = create_geometry(start_x, start_y, center_x, center_y)
    local state = create_state(caster, geom)

    create_court_objects(state)
    start_announce_phase(state)
end

function monolith_execution_court.init()
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

return monolith_execution_court
