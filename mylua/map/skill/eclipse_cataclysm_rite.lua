local eclipse_cataclysm_rite = {}

local DAMAGE = 760 -- You may change this damage value only.

local ABILITY_ID = char2id("C007")
local HIDDEN_ABILITY_ID = char2id("C008")
local DUMMY_UNIT_ID = char2id("u005")

local MAX_CAST_RANGE = 950.0
local TELEGRAPH_RADIUS = 420.0
local DOMAIN_RADIUS = 430.0
local INNER_RING_RADIUS = 250.0
local SAFE_POCKET_RADIUS = 135.0
local PRISON_RADIUS = 470.0
local HUNT_RADIUS = 520.0
local RAIN_RADIUS = 560.0
local FINALE_RADIUS = 610.0
local SIGIL_COUNT = 6
local MIRROR_COUNT = 4

local TELEGRAPH_TICKS = 7
local TELEGRAPH_PERIOD = 0.15
local DOMAIN_TICKS = 16
local DOMAIN_PERIOD = 0.11
local PRISON_TICKS = 14
local PRISON_PERIOD = 0.12
local HUNT_TICKS = 6
local HUNT_PERIOD = 0.18
local RAIN_TICKS = 10
local RAIN_PERIOD = 0.12
local FINALE_TICKS = 8
local FINALE_PERIOD = 0.10

local TELEGRAPH_DAMAGE_FACTOR = 0.06
local DOMAIN_SIGIL_DAMAGE_FACTOR = 0.08
local DOMAIN_RING_DAMAGE_FACTOR = 0.12
local PRISON_DAMAGE_FACTOR = 0.08
local HUNT_PATH_DAMAGE_FACTOR = 0.11
local HUNT_IMPACT_DAMAGE_FACTOR = 0.13
local RAIN_DAMAGE_FACTOR = 0.10
local FINALE_PULL_DAMAGE_FACTOR = 0.10
local FINALE_BURST_DAMAGE_FACTOR = 0.92

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

local function make_hidden_dummy(owner, x, y, facing)
    local unit = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(unit, false)
    _F.SetUnitPathing(unit, false)
    _F.SetUnitInvulnerable(unit, true)
    _F.SetUnitVertexColor(unit, 255, 255, 255, 0)
    _F.UnitAddAbility(unit, HIDDEN_ABILITY_ID)
    return unit
end

local function make_afterimage(owner, x, y, facing, alpha, duration)
    local image = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(image, false)
    _F.SetUnitPathing(image, false)
    _F.SetUnitInvulnerable(image, true)
    _F.SetUnitVertexColor(image, 190, 220, 255, alpha)
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
        sigils = {},
        mirrors = {},
        cycle_hits = {},
        hunt_hits = {},
        rain_hits = {},
        finale_hits = {},
        phase_index = 0,
        phase_tick = 0,
    }
end

local function reset_marks(mark_table)
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
    local result = collect_enemies(source, x, y, radius)
    table.sort(result, function(a, b)
        local ax = _F.GetUnitX(a)
        local ay = _F.GetUnitY(a)
        local bx = _F.GetUnitX(b)
        local by = _F.GetUnitY(b)
        return distance_between(x, y, ax, ay) < distance_between(x, y, bx, by)
    end)
    return result
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

local function create_anchor_and_sigils(state)
    state.anchor = make_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)

    for i = 1, SIGIL_COUNT, 1 do
        local angle = (i - 1) * FULL_CIRCLE / SIGIL_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, DOMAIN_RADIUS, angle)
        local sigil = make_hidden_dummy(state.owner, x, y, angle * DEG)
        state.sigils[i] = {
            unit = sigil,
            angle = angle,
            radius = DOMAIN_RADIUS,
            x = x,
            y = y,
        }
    end

    for i = 1, MIRROR_COUNT, 1 do
        local mirror = make_hidden_dummy(state.owner, state.center_x, state.center_y, 270.0)
        state.mirrors[i] = mirror
    end
end

local function cleanup_state(state)
    if state.anchor ~= nil then
        _F.RemoveUnit(state.anchor)
        state.anchor = nil
    end

    for i = 1, #state.sigils, 1 do
        if state.sigils[i] and state.sigils[i].unit ~= nil then
            _F.RemoveUnit(state.sigils[i].unit)
            state.sigils[i].unit = nil
        end
    end

    for i = 1, #state.mirrors, 1 do
        if state.mirrors[i] ~= nil then
            _F.RemoveUnit(state.mirrors[i])
            state.mirrors[i] = nil
        end
    end
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

local function update_sigil_positions(state, radius, base_angle)
    for i = 1, #state.sigils, 1 do
        local angle = base_angle + (i - 1) * FULL_CIRCLE / SIGIL_COUNT
        local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
        local sigil = state.sigils[i]
        sigil.angle = angle
        sigil.radius = radius
        sigil.x = x
        sigil.y = y
        set_unit_position(sigil.unit, x, y)
    end
end

local function play_domain_visuals(state, effect_path)
    for i = 1, #state.sigils, 1 do
        effect_at(effect_path, state.sigils[i].x, state.sigils[i].y)
    end
end

local function damage_near_sigils(state, radius, amount, marks)
    for i = 1, #state.sigils, 1 do
        local sigil = state.sigils[i]
        sweep_enemies(state.caster, sigil.x, sigil.y, radius, function(target)
            if mark_hit(marks, target) then
                effect_on_target("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
        end)
    end
end

local function damage_ring(state, ring_radius, thickness, amount, marks)
    sweep_enemies(state.caster, state.center_x, state.center_y, ring_radius + thickness, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        if distance >= ring_radius - thickness and distance <= ring_radius + thickness then
            if mark_hit(marks, target) then
                effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
        end
    end)
end

local function damage_sector_outside_safe(state, safe_angle, safe_width, safe_radius, amount, marks)
    sweep_enemies(state.caster, state.center_x, state.center_y, PRISON_RADIUS, function(target)
        local tx = _F.GetUnitX(target)
        local ty = _F.GetUnitY(target)
        local angle = normalize_angle(angle_between(state.center_x, state.center_y, tx, ty))
        local distance = distance_between(state.center_x, state.center_y, tx, ty)
        local is_safe_angle = angle_delta(angle, safe_angle) <= safe_width
        local is_safe_radius = distance <= safe_radius

        if not (is_safe_angle and is_safe_radius) then
            if mark_hit(marks, target) then
                effect_on_target("Abilities\\Spells\\NightElf\\ManaBurn\\ManaBurnTarget.mdl", target, "origin")
                damage_target(state.caster, target, amount)
            end
            move_toward(target, state.center_x, state.center_y, 0.06)
        end
    end)
end

local function draw_safe_pocket(state, safe_angle, safe_radius)
    local pocket_x, pocket_y = point_on_circle(state.center_x, state.center_y, safe_radius * 0.70, safe_angle)
    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", pocket_x, pocket_y)
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", pocket_x, pocket_y)
end

local function draw_prison_walls(state, tick)
    local base_angle = tick * 0.44
    for i = 1, #state.sigils, 1 do
        local sigil = state.sigils[i]
        local beam_angle = base_angle + i * 0.52
        local wall_x, wall_y = point_on_circle(sigil.x, sigil.y, 120.0, beam_angle)
        effect_at("Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl", wall_x, wall_y)
    end
end

local function damage_line(state, from_x, from_y, to_x, to_y, samples, radius, amount, marks)
    for i = 1, samples, 1 do
        local progress = i / samples
        local x = from_x + (to_x - from_x) * progress
        local y = from_y + (to_y - from_y) * progress
        sweep_enemies(state.caster, x, y, radius, function(target)
            if mark_hit(marks, target) then
                effect_on_target("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", target, "chest")
                damage_target(state.caster, target, amount)
            end
        end)
    end
end

local function perform_hunt_strike(state, mirror_index, target)
    local sigil = state.sigils[((mirror_index - 1) % #state.sigils) + 1]
    local start_x = sigil.x
    local start_y = sigil.y
    local target_x = _F.GetUnitX(target)
    local target_y = _F.GetUnitY(target)
    local angle = angle_between(start_x, start_y, target_x, target_y)
    local mirror = state.mirrors[mirror_index]
    local impact_x = target_x
    local impact_y = target_y

    set_unit_position(mirror, start_x, start_y)
    _F.SetUnitFacing(mirror, angle * DEG)
    make_afterimage(state.owner, start_x, start_y, angle * DEG, 160, 0.45)
    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", start_x, start_y)

    damage_line(
        state,
        start_x,
        start_y,
        impact_x,
        impact_y,
        7,
        95.0,
        DAMAGE * HUNT_PATH_DAMAGE_FACTOR,
        state.hunt_hits
    )

    set_unit_position(mirror, impact_x, impact_y)
    _F.SetUnitFacing(mirror, angle * DEG)
    make_afterimage(state.owner, impact_x, impact_y, angle * DEG, 120, 0.35)

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", impact_x, impact_y)
    effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", impact_x, impact_y)
    effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", impact_x, impact_y)

    sweep_enemies(state.caster, impact_x, impact_y, 160.0, function(enemy)
        if mark_hit(state.hunt_hits, enemy) then
            damage_target(state.caster, enemy, DAMAGE * HUNT_IMPACT_DAMAGE_FACTOR)
        end
    end)
end

local function perform_orbit_dash(state, index, radius)
    local angle = index * 1.047197
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    local facing = angle * DEG + 180.0
    set_unit_position(state.caster, x, y)
    set_caster_pose(state.caster, facing, "attack", 1.25)
    make_afterimage(state.owner, x, y, facing, 145, 0.40)
end

local function perform_rain_impact(state, angle, radius, marks)
    local x, y = point_on_circle(state.center_x, state.center_y, radius, angle)
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallTarget.mdl", x, y)
    effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", x, y)
    effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y)

    sweep_enemies(state.caster, x, y, 150.0, function(target)
        if mark_hit(marks, target) then
            damage_target(state.caster, target, DAMAGE * RAIN_DAMAGE_FACTOR)
        end
    end)
end

local function pull_whole_field(state, radius, factor)
    sweep_enemies(state.caster, state.center_x, state.center_y, radius, function(target)
        move_toward(target, state.center_x, state.center_y, factor)
    end)
end

local function push_inner_field(state, radius, factor)
    sweep_enemies(state.caster, state.center_x, state.center_y, radius, function(target)
        move_away(target, state.center_x, state.center_y, factor)
    end)
end

local function damage_finale_pull(state, amount, marks)
    sweep_enemies(state.caster, state.center_x, state.center_y, FINALE_RADIUS, function(target)
        if mark_hit(marks, target) then
            effect_on_target("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", target, "origin")
            damage_target(state.caster, target, amount)
        end
    end)
end

local function perform_finale_burst(state)
    set_unit_position(state.caster, state.center_x, state.center_y - 70.0)
    set_caster_pose(state.caster, 90.0, "attack slam", 1.35)

    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
    effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", state.center_x, state.center_y)
    effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", state.center_x, state.center_y)
    effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", state.center_x, state.center_y)

    sweep_enemies(state.caster, state.center_x, state.center_y, FINALE_RADIUS, function(target)
        effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
        damage_target(state.caster, target, DAMAGE * FINALE_BURST_DAMAGE_FACTOR)
    end)

    finish_caster_pose(state.caster)
end

local function start_finale_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    reset_marks(state.finale_hits)

    _F.TimerStart(timer, FINALE_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 5
        state.phase_tick = tick

        local progress = tick / FINALE_TICKS
        local radius = DOMAIN_RADIUS * (1.0 - progress)
        local base_angle = tick * 0.82

        update_sigil_positions(state, radius, base_angle)
        play_domain_visuals(state, "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl")

        pull_whole_field(state, FINALE_RADIUS, 0.11)
        damage_finale_pull(state, DAMAGE * FINALE_PULL_DAMAGE_FACTOR, state.finale_hits)

        if tick % 2 == 0 then
            push_inner_field(state, 130.0, 0.20)
            effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", state.center_x, state.center_y)
        end

        if tick >= FINALE_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            perform_finale_burst(state)
            cleanup_state(state)
        end
    end)
end

local function start_rain_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, RAIN_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 4
        state.phase_tick = tick

        reset_marks(state.rain_hits)

        local base_angle = tick * 0.69
        local caster_angle = base_angle + 1.570796
        perform_orbit_dash(state, tick, INNER_RING_RADIUS)
        update_sigil_positions(state, DOMAIN_RADIUS - 35.0, base_angle * 0.45)

        perform_rain_impact(state, base_angle, 0.0, state.rain_hits)
        perform_rain_impact(state, base_angle + 0.55, 170.0, state.rain_hits)
        perform_rain_impact(state, base_angle + 1.80, 290.0, state.rain_hits)
        perform_rain_impact(state, base_angle + 3.05, 360.0, state.rain_hits)
        perform_rain_impact(state, base_angle + 4.20, 430.0, state.rain_hits)

        effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)
        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", state.center_x + 20.0 * _F.Cos(caster_angle), state.center_y + 20.0 * _F.Sin(caster_angle))

        pull_whole_field(state, RAIN_RADIUS, 0.07)

        if tick >= RAIN_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_finale_phase(state)
        end
    end)
end

local function start_hunt_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, HUNT_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 3
        state.phase_tick = tick

        reset_marks(state.hunt_hits)

        local targets = collect_sorted_enemies(state.caster, state.center_x, state.center_y, HUNT_RADIUS)
        local focus_count = MIRROR_COUNT
        local orbit_angle = tick * 1.18
        local caster_x, caster_y = point_on_circle(state.center_x, state.center_y, INNER_RING_RADIUS, orbit_angle)
        set_unit_position(state.caster, caster_x, caster_y)
        set_caster_pose(state.caster, orbit_angle * DEG + 180.0, "spell", 1.18)

        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", caster_x, caster_y)
        effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", state.center_x, state.center_y)

        if #targets < focus_count then
            focus_count = #targets
        end

        for i = 1, focus_count, 1 do
            perform_hunt_strike(state, i, targets[i])
        end

        if focus_count == 0 then
            local fallback_x, fallback_y = point_on_circle(state.center_x, state.center_y, 210.0, orbit_angle + 0.6)
            effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", fallback_x, fallback_y)
            effect_at("Abilities\\Spells\\Other\\Drain\\DrainCaster.mdl", fallback_x, fallback_y)
        end

        if tick >= HUNT_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_rain_phase(state)
        end
    end)
end

local function start_prison_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PRISON_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 2
        state.phase_tick = tick

        reset_marks(state.cycle_hits)

        local safe_angle = normalize_angle(0.42 + tick * 0.54)
        local safe_width = 0.42
        local radius = DOMAIN_RADIUS - 30.0 + 18.0 * _F.Sin(tick * 0.4)

        update_sigil_positions(state, radius, safe_angle * 0.6)
        draw_safe_pocket(state, safe_angle, SAFE_POCKET_RADIUS)
        draw_prison_walls(state, tick)

        damage_sector_outside_safe(
            state,
            safe_angle,
            safe_width,
            SAFE_POCKET_RADIUS,
            DAMAGE * PRISON_DAMAGE_FACTOR,
            state.cycle_hits
        )

        if tick % 3 == 0 then
            damage_ring(
                state,
                radius,
                65.0,
                DAMAGE * DOMAIN_RING_DAMAGE_FACTOR,
                state.cycle_hits
            )
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", state.center_x, state.center_y)
        end

        perform_orbit_dash(state, tick, INNER_RING_RADIUS - 25.0)

        if tick >= PRISON_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_hunt_phase(state)
        end
    end)
end

local function start_domain_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, DOMAIN_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 1
        state.phase_tick = tick

        reset_marks(state.cycle_hits)

        local base_angle = tick * 0.36
        local radius = DOMAIN_RADIUS + 20.0 * _F.Sin(tick * 0.4)

        update_sigil_positions(state, radius, base_angle)
        play_domain_visuals(state, "Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl")
        damage_near_sigils(
            state,
            120.0,
            DAMAGE * DOMAIN_SIGIL_DAMAGE_FACTOR,
            state.cycle_hits
        )

        if tick % 2 == 0 then
            damage_ring(
                state,
                radius,
                58.0,
                DAMAGE * DOMAIN_RING_DAMAGE_FACTOR,
                state.cycle_hits
            )
        end

        perform_orbit_dash(state, tick, INNER_RING_RADIUS)

        if tick % 4 == 0 then
            effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", state.center_x, state.center_y)
        end

        if tick >= DOMAIN_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_prison_phase(state)
        end
    end)
end

local function start_telegraph_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()
    local facing = angle_between(_F.GetUnitX(state.caster), _F.GetUnitY(state.caster), state.center_x, state.center_y) * DEG

    set_caster_pose(state.caster, facing, "spell", 1.35)

    _F.TimerStart(timer, TELEGRAPH_PERIOD, true, function()
        tick = tick + 1
        state.phase_index = 0
        state.phase_tick = tick

        local current_radius = TELEGRAPH_RADIUS - tick * 22.0
        local current_angle = tick * 0.22

        update_sigil_positions(state, current_radius, current_angle)
        play_domain_visuals(state, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")

        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", state.center_x, state.center_y)
        effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", state.center_x, state.center_y)

        if tick % 2 == 1 then
            reset_marks(state.cycle_hits)
            damage_ring(
                state,
                current_radius,
                52.0,
                DAMAGE * TELEGRAPH_DAMAGE_FACTOR,
                state.cycle_hits
            )
        end

        if tick >= TELEGRAPH_TICKS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_domain_phase(state)
        end
    end)
end

local function begin_skill(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local center_x, center_y = clamp_target(start_x, start_y, target_x, target_y)
    local state = create_state(caster, center_x, center_y)

    create_anchor_and_sigils(state)
    start_telegraph_phase(state)
end

function eclipse_cataclysm_rite.init()
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

return eclipse_cataclysm_rite
