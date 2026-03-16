local scarlet_curtain_finale = {}

local DAMAGE = 900 -- You may change this damage value only.

local ABILITY_ID = char2id("C011")
local HIDDEN_ABILITY_ID = char2id("C012")
local DUMMY_UNIT_ID = char2id("u007")

local MAX_CAST_RANGE = 950.0
local MIN_STAGE_LENGTH = 700.0
local MAX_STAGE_LENGTH = 930.0
local STAGE_HALF_WIDTH = 240.0
local OVERTURE_BORDER_THICKNESS = 65.0
local CURTAIN_MIN_HALF_WIDTH = 72.0
local SPOTLIGHT_RADIUS = 130.0
local PROCESSION_LANE_HALF = 72.0
local FINALE_BAND_HALF = 95.0

local OVERTURE_TICKS = 7
local OVERTURE_PERIOD = 0.16
local CURTAIN_TICKS = 10
local CURTAIN_PERIOD = 0.14
local SPOTLIGHT_TICKS = 9
local SPOTLIGHT_PERIOD = 0.17
local PROCESSION_TICKS = 8
local PROCESSION_PERIOD = 0.16
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.14

local OVERTURE_DAMAGE_FACTOR = 0.07
local CURTAIN_DAMAGE_FACTOR = 0.13
local SPOTLIGHT_DAMAGE_FACTOR = 0.15
local PROCESSION_DAMAGE_FACTOR = 0.16
local FINALE_SWEEP_DAMAGE_FACTOR = 0.18
local FINALE_VERDICT_DAMAGE_FACTOR = 0.96

local DEG = 57.29582
local FULL_CIRCLE = 6.283185

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

local function clamp_target(start_x, start_y, target_x, target_y)
    local dx = target_x - start_x
    local dy = target_y - start_y
    local distance = _F.SquareRoot(dx * dx + dy * dy)

    if distance < 1.0 then
        distance = 1.0
    end

    local clamped = distance
    if clamped > MAX_CAST_RANGE then
        clamped = MAX_CAST_RANGE
    end
    if clamped < MIN_STAGE_LENGTH then
        clamped = MIN_STAGE_LENGTH
    end
    if clamped > MAX_STAGE_LENGTH then
        clamped = MAX_STAGE_LENGTH
    end

    local scale = clamped / distance
    return start_x + dx * scale, start_y + dy * scale, clamped
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

local function build_geometry(start_x, start_y, target_x, target_y, length)
    local angle = angle_between(start_x, start_y, target_x, target_y)
    local fx = _F.Cos(angle)
    local fy = _F.Sin(angle)
    local rx = -fy
    local ry = fx
    local center_x = start_x + fx * length * 0.5
    local center_y = start_y + fy * length * 0.5

    return {
        start_x = start_x,
        start_y = start_y,
        target_x = target_x,
        target_y = target_y,
        length = length,
        half_width = STAGE_HALF_WIDTH,
        angle = angle,
        facing = angle * DEG,
        fx = fx,
        fy = fy,
        rx = rx,
        ry = ry,
        center_x = center_x,
        center_y = center_y,
        bound_radius = _F.SquareRoot((length * 0.5) * (length * 0.5) + STAGE_HALF_WIDTH * STAGE_HALF_WIDTH) + 220.0,
    }
end

local function world_from_local(geom, forward, side)
    return geom.start_x + geom.fx * forward + geom.rx * side,
        geom.start_y + geom.fy * forward + geom.ry * side
end

local function local_from_world(geom, x, y)
    local dx = x - geom.start_x
    local dy = y - geom.start_y
    local forward = dx * geom.fx + dy * geom.fy
    local side = dx * geom.rx + dy * geom.ry
    return forward, side
end

local function is_inside_stage(geom, x, y, forward_margin, side_margin)
    local forward, side = local_from_world(geom, x, y)
    return forward >= -forward_margin
        and forward <= geom.length + forward_margin
        and math.abs(side) <= geom.half_width + side_margin,
        forward,
        side
end

local function create_state(caster, geom)
    return {
        caster = caster,
        owner = _F.GetOwningPlayer(caster),
        geom = geom,
        anchor = nil,
        wings = {},
        spotlights = {},
        actors = {},
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

local function sweep_stage_enemies(state, forward_margin, side_margin, callback)
    local geom = state.geom
    sweep_units(geom.center_x, geom.center_y, geom.bound_radius, function(target)
        if is_living_enemy(state.caster, target) then
            local ok, forward, side = is_inside_stage(geom, _F.GetUnitX(target), _F.GetUnitY(target), forward_margin, side_margin)
            if ok then
                callback(target, forward, side)
            end
        end
    end)
end

local function place_caster_backstage(state, side_offset, animation, scale)
    local x, y = world_from_local(state.geom, -60.0, side_offset)
    set_unit_position(state.caster, x, y)
    set_caster_pose(state.caster, state.geom.facing, animation, scale)
end

local function push_toward_centerline(state, target, side, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    local move = -side * factor
    set_unit_position(target, tx + state.geom.rx * move, ty + state.geom.ry * move)
end

local function push_forward(state, target, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    set_unit_position(target, tx + state.geom.fx * factor, ty + state.geom.fy * factor)
end

local function spawn_stage_objects(state)
    local geom = state.geom
    state.anchor = create_hidden_dummy(state.owner, geom.center_x, geom.center_y, geom.facing)

    for i = 1, 4, 1 do
        local forward = geom.length * (i - 1) / 3
        local lx, ly = world_from_local(geom, forward, -geom.half_width)
        local rx, ry = world_from_local(geom, forward, geom.half_width)
        state.wings[#state.wings + 1] = create_hidden_dummy(state.owner, lx, ly, geom.facing - 90.0)
        state.wings[#state.wings + 1] = create_hidden_dummy(state.owner, rx, ry, geom.facing + 90.0)
    end

    for i = 1, 3, 1 do
        local x, y = world_from_local(geom, 120.0, (i - 2) * 150.0)
        state.spotlights[i] = create_hidden_dummy(state.owner, x, y, geom.facing)
    end

    for i = 1, 4, 1 do
        local x, y = world_from_local(geom, -40.0, (-1.5 + (i - 1)) * 120.0)
        state.actors[i] = create_hidden_dummy(state.owner, x, y, geom.facing)
    end
end

local function cleanup_state(state)
    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.wings, 1 do
        if state.wings[i] ~= nil then
            _F.RemoveUnit(state.wings[i])
            state.wings[i] = nil
        end
    end

    for i = 1, #state.spotlights, 1 do
        if state.spotlights[i] ~= nil then
            _F.RemoveUnit(state.spotlights[i])
            state.spotlights[i] = nil
        end
    end

    for i = 1, #state.actors, 1 do
        if state.actors[i] ~= nil then
            _F.RemoveUnit(state.actors[i])
            state.actors[i] = nil
        end
    end
end

local function draw_side_wall(state, side, half_width, path)
    local geom = state.geom
    local wall_side = side * half_width
    for i = 0, 8, 1 do
        local forward = geom.length * i / 8
        local x, y = world_from_local(geom, forward, wall_side)
        effect_at(path, x, y)
    end
end

local function draw_rear_and_front(state, path)
    local geom = state.geom
    for i = 0, 6, 1 do
        local side = -geom.half_width + geom.half_width * 2 * i / 6
        local back_x, back_y = world_from_local(geom, 0.0, side)
        local front_x, front_y = world_from_local(geom, geom.length, side)
        effect_at(path, back_x, back_y)
        effect_at(path, front_x, front_y)
    end
end

local function draw_stage_outline(state, half_width)
    draw_side_wall(state, -1.0, half_width, "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
    draw_side_wall(state, 1.0, half_width, "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl")
    draw_rear_and_front(state, "Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl")
end

local function damage_border_units(state, half_width, thickness, amount)
    sweep_stage_enemies(state, 40.0, 120.0, function(target, forward, side)
        if forward >= 0.0 and forward <= state.geom.length then
            if math.abs(math.abs(side) - half_width) <= thickness then
                if mark_hit(state.hit_marks, target) then
                    effect_on_target("Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl", target, "origin")
                    damage_target(state.caster, target, amount)
                end
            end
        end
    end)
end

local function update_wings(state, half_width)
    local geom = state.geom
    for i = 1, 4, 1 do
        local forward = geom.length * (i - 1) / 3
        local left_x, left_y = world_from_local(geom, forward, -half_width)
        local right_x, right_y = world_from_local(geom, forward, half_width)
        local left_wing = state.wings[(i - 1) * 2 + 1]
        local right_wing = state.wings[(i - 1) * 2 + 2]
        set_unit_position(left_wing, left_x, left_y)
        set_unit_position(right_wing, right_x, right_y)
        _F.SetUnitFacing(left_wing, geom.facing - 90.0)
        _F.SetUnitFacing(right_wing, geom.facing + 90.0)
    end
end

local function squeeze_curtains(state, half_width, amount)
    sweep_stage_enemies(state, 40.0, 140.0, function(target, forward, side)
        if forward >= 40.0 and forward <= state.geom.length - 40.0 then
            if math.abs(side) >= half_width - 55.0 then
                if mark_hit(state.hit_marks, target) then
                    effect_on_target("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", target, "origin")
                    damage_target(state.caster, target, amount)
                end
                push_toward_centerline(state, target, side, 0.32)
            end
        end
    end)
end

local function draw_spotlight(state, forward, side, radius)
    local x, y = world_from_local(state.geom, forward, side)
    effect_at("Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl", x, y)
    for i = 0, 3, 1 do
        local angle = i * FULL_CIRCLE / 4
        local sx = x + _F.Cos(angle) * radius * 0.45
        local sy = y + _F.Sin(angle) * radius * 0.45
        effect_at("Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl", sx, sy)
    end
end

local function damage_spotlight(state, forward_center, side_center, radius, amount)
    local x, y = world_from_local(state.geom, forward_center, side_center)
    sweep_units(x, y, radius + 80.0, function(target)
        if is_living_enemy(state.caster, target) then
            local tx = _F.GetUnitX(target)
            local ty = _F.GetUnitY(target)
            if distance_between(x, y, tx, ty) <= radius then
                if mark_hit(state.hit_marks, target) then
                    effect_on_target("Abilities\\Spells\\Other\\Drain\\DrainTarget.mdl", target, "origin")
                    damage_target(state.caster, target, amount)
                end
            end
        end
    end)
end

local function set_spotlight_positions(state, tick)
    local geom = state.geom
    local f1 = geom.length * tick / SPOTLIGHT_TICKS
    local f2 = geom.length * (1.0 - tick / SPOTLIGHT_TICKS)
    local f3 = geom.length * 0.18 + geom.length * 0.64 * tick / SPOTLIGHT_TICKS
    local s1 = -geom.half_width * 0.65
    local s2 = geom.half_width * 0.65
    local s3 = geom.half_width * _F.Sin(tick * 0.75) * 0.55
    local positions = {
        { forward = f1, side = s1 },
        { forward = f2, side = s2 },
        { forward = f3, side = s3 },
    }

    for i = 1, 3, 1 do
        local x, y = world_from_local(geom, positions[i].forward, positions[i].side)
        set_unit_position(state.spotlights[i], x, y)
        _F.SetUnitFacing(state.spotlights[i], geom.facing)
    end

    return positions
end

local function set_actor_positions(state, tick)
    local geom = state.geom
    local positions = {}
    local base_forward = geom.length * tick / PROCESSION_TICKS
    for i = 1, 4, 1 do
        local side = (-1.5 + (i - 1)) * 125.0
        local forward = math.min(geom.length + 40.0, base_forward + (i - 1) * 55.0)
        local x, y = world_from_local(geom, forward, side)
        set_unit_position(state.actors[i], x, y)
        _F.SetUnitFacing(state.actors[i], geom.facing)
        positions[i] = {
            forward = forward,
            side = side,
            x = x,
            y = y,
        }
    end
    return positions
end

local function draw_actor_column(actor_data)
    effect_at("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", actor_data.x, actor_data.y)
    effect_at("Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl", actor_data.x, actor_data.y)
    effect_at("Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl", actor_data.x, actor_data.y)
end

local function damage_actor_lane(state, actor_data, lane_half_width, amount)
    sweep_stage_enemies(state, 40.0, 120.0, function(target, forward, side)
        if math.abs(forward - actor_data.forward) <= 95.0 and math.abs(side - actor_data.side) <= lane_half_width then
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", target, "origin")
                damage_target(state.caster, target, amount)
                push_forward(state, target, 32.0)
            end
        end
    end)
end

local function draw_finale_band(state, forward)
    local geom = state.geom
    for i = 0, 8, 1 do
        local side = -geom.half_width + geom.half_width * 2 * i / 8
        local x, y = world_from_local(geom, forward, side)
        effect_at("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", x, y)
        effect_at("Abilities\\Spells\\Undead\\Possession\\PossessionTarget.mdl", x, y)
        effect_at("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", x, y)
    end
end

local function damage_finale_band(state, forward_center, band_half, amount)
    sweep_stage_enemies(state, 30.0, 90.0, function(target, forward, side)
        if math.abs(forward - forward_center) <= band_half and math.abs(side) <= state.geom.half_width + 20.0 then
            if mark_hit(state.hit_marks, target) then
                effect_on_target("Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
        end
    end)
end

local function final_verdict(state)
    sweep_stage_enemies(state, 0.0, 0.0, function(target)
        effect_on_target("Abilities\\Spells\\Other\\Doom\\DoomTarget.mdl", target, "origin")
        effect_on_target("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", target, "origin")
        damage_target(state.caster, target, DAMAGE * FINALE_VERDICT_DAMAGE_FACTOR)
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

        local forward = state.geom.length * tick / FINALE_TICKS
        place_caster_backstage(state, 0.0, "stand victory", 1.24)
        draw_finale_band(state, forward)
        damage_finale_band(state, forward, FINALE_BAND_HALF, DAMAGE * FINALE_SWEEP_DAMAGE_FACTOR)

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", state.geom.target_x, state.geom.target_y)
            effect_at("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", state.geom.center_x, state.geom.center_y)
            final_verdict(state)
            finish_caster_pose(state.caster)
            cleanup_state(state)
        end
    end)
end

local function start_procession_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PROCESSION_PERIOD, true, function()
        tick = tick + 1
        state.phase = 3
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        place_caster_backstage(state, -110.0 + tick * 28.0, "spell", 1.18)
        local actors = set_actor_positions(state, tick)
        for i = 1, #actors, 1 do
            draw_actor_column(actors[i])
            damage_actor_lane(state, actors[i], PROCESSION_LANE_HALF, DAMAGE * PROCESSION_DAMAGE_FACTOR)
        end

        if tick >= PROCESSION_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_spotlight_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, SPOTLIGHT_PERIOD, true, function()
        tick = tick + 1
        state.phase = 2
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        place_caster_backstage(state, 140.0 * _F.Sin(tick * 0.7), "spell channel", 1.12)
        local positions = set_spotlight_positions(state, tick)
        for i = 1, #positions, 1 do
            draw_spotlight(state, positions[i].forward, positions[i].side, SPOTLIGHT_RADIUS)
            damage_spotlight(state, positions[i].forward, positions[i].side, SPOTLIGHT_RADIUS, DAMAGE * SPOTLIGHT_DAMAGE_FACTOR)
        end

        if tick >= SPOTLIGHT_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_procession_phase(state)
        end
    end)
end

local function start_curtain_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, CURTAIN_PERIOD, true, function()
        tick = tick + 1
        state.phase = 1
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local progress = tick / CURTAIN_TICKS
        local half_width = state.geom.half_width - (state.geom.half_width - CURTAIN_MIN_HALF_WIDTH) * progress
        update_wings(state, half_width)
        place_caster_backstage(state, 0.0, "attack", 1.16)
        draw_side_wall(state, -1.0, half_width, "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl")
        draw_side_wall(state, 1.0, half_width, "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl")
        squeeze_curtains(state, half_width, DAMAGE * CURTAIN_DAMAGE_FACTOR)

        if tick % 2 == 0 then
            draw_rear_and_front(state, "Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl")
        end

        if tick >= CURTAIN_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_spotlight_phase(state)
        end
    end)
end

local function start_overture_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    place_caster_backstage(state, 0.0, "spell slam", 1.20)

    _F.TimerStart(timer, OVERTURE_PERIOD, true, function()
        tick = tick + 1
        state.phase = 0
        state.tick = tick

        clear_hit_marks(state.hit_marks)

        local pulse_width = state.geom.half_width - 18.0 * _F.Sin(tick * 0.5)
        update_wings(state, pulse_width)
        draw_stage_outline(state, pulse_width)
        damage_border_units(state, pulse_width, OVERTURE_BORDER_THICKNESS, DAMAGE * OVERTURE_DAMAGE_FACTOR)

        if tick >= OVERTURE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_curtain_phase(state)
        end
    end)
end

local function begin_skill(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local clamped_x, clamped_y, length = clamp_target(start_x, start_y, target_x, target_y)
    local geom = build_geometry(start_x, start_y, clamped_x, clamped_y, length)
    local state = create_state(caster, geom)

    spawn_stage_objects(state)
    start_overture_phase(state)
end

function scarlet_curtain_finale.init()
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

return scarlet_curtain_finale
