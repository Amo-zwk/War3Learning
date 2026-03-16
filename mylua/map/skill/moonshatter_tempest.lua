local moonshatter_tempest = {}

local DAMAGE = 520 -- You may change this damage value only.

local ABILITY_ID = char2id("C005")
local DUMMY_UNIT_ID = char2id("u004")
local HELPER_ABILITY_ID = char2id("C006")

local MAX_RANGE = 850.0
local DASH_COUNT = 5
local DASH_PERIOD = 0.09
local DASH_RADIUS = 170.0
local RING_RADIUS = 265.0
local CUT_RADIUS = 235.0
local STORM_COUNT = 7
local STORM_PERIOD = 0.09
local PULL_RADIUS = 340.0
local FINALE_RADIUS = 390.0
local DASH_DAMAGE_FACTOR = 0.11
local CUT_DAMAGE_FACTOR = 0.10
local STORM_DAMAGE_FACTOR = 0.17
local FINALE_DAMAGE_FACTOR = 0.78

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

local function sweep_enemies(x, y, radius, callback)
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

local function clamp_target(start_x, start_y, target_x, target_y)
    local dx = target_x - start_x
    local dy = target_y - start_y
    local distance = _F.SquareRoot(dx * dx + dy * dy)

    if distance <= MAX_RANGE then
        return target_x, target_y
    end

    if distance < 1.0 then
        distance = 1.0
    end

    local scale = MAX_RANGE / distance
    return start_x + dx * scale, start_y + dy * scale
end

local function create_anchor(owner, x, y)
    local anchor = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, 270.0)
    _F.ShowUnit(anchor, false)
    _F.SetUnitPathing(anchor, false)
    _F.SetUnitInvulnerable(anchor, true)
    _F.SetUnitVertexColor(anchor, 255, 255, 255, 0)
    _F.UnitAddAbility(anchor, HELPER_ABILITY_ID)
    return anchor
end

local function create_afterimage(owner, x, y, facing, alpha)
    local image = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(image, false)
    _F.SetUnitPathing(image, false)
    _F.SetUnitInvulnerable(image, true)
    _F.SetUnitVertexColor(image, 185, 225, 255, alpha)
    _F.UnitApplyTimedLife(image, char2id("BTLF"), 0.42)
    return image
end

local function mark_hit(mark_table, target)
    local key = _F.GetHandleId(target)
    if mark_table[key] then
        return false
    end
    mark_table[key] = true
    return true
end

local function collect_enemies(x, y, radius, source)
    local units = {}
    sweep_enemies(x, y, radius, function(target)
        if is_living_enemy(source, target) then
            units[#units + 1] = target
        end
    end)
    return units
end

local function pull_unit_toward(target, x, y, factor)
    local tx = _F.GetUnitX(target)
    local ty = _F.GetUnitY(target)
    local dx = x - tx
    local dy = y - ty
    _F.SetUnitX(target, tx + dx * factor)
    _F.SetUnitY(target, ty + dy * factor)
end

local function perform_finale(state)
    local center_x = _F.GetUnitX(state.anchor)
    local center_y = _F.GetUnitY(state.anchor)

    _F.SetUnitX(state.caster, center_x)
    _F.SetUnitY(state.caster, center_y - 55.0)
    _F.SetUnitFacing(state.caster, 90.0)
    _F.SetUnitTimeScale(state.caster, 1.28)
    _F.SetUnitAnimation(state.caster, "attack slam")
    _F.QueueUnitAnimation(state.caster, "stand")

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", center_x, center_y)

    sweep_enemies(center_x, center_y, FINALE_RADIUS, function(target)
        if is_living_enemy(state.caster, target) then
            effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
            damage_target(state.caster, target, DAMAGE * FINALE_DAMAGE_FACTOR)
        end
    end)

    _F.SetUnitTimeScale(state.caster, 1.00)
    _F.RemoveUnit(state.anchor)
end

local function start_storm_phase(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, STORM_PERIOD, true, function()
        tick = tick + 1

        local center_x = _F.GetUnitX(state.anchor)
        local center_y = _F.GetUnitY(state.anchor)
        local angle = tick * 0.897598
        local orbit_x = center_x + RING_RADIUS * _F.Cos(angle)
        local orbit_y = center_y + RING_RADIUS * _F.Sin(angle)
        local facing = angle * 57.29582 + 225.0
        local targets = collect_enemies(center_x, center_y, PULL_RADIUS, state.caster)

        _F.SetUnitX(state.caster, orbit_x)
        _F.SetUnitY(state.caster, orbit_y)
        _F.SetUnitFacing(state.caster, facing)
        _F.SetUnitAnimation(state.caster, "attack")
        create_afterimage(state.owner, orbit_x, orbit_y, facing, 120)

        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", orbit_x, orbit_y)
        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", orbit_x, orbit_y)
        effect_at("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", center_x, center_y)

        for _, target in ipairs(targets) do
            pull_unit_toward(target, center_x, center_y, 0.16)
            if tick % 2 == 1 and mark_hit(state.storm_hits, target) then
                effect_on_target("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", target, "chest")
                damage_target(state.caster, target, DAMAGE * STORM_DAMAGE_FACTOR)
            end
        end

        if tick >= STORM_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            perform_finale(state)
        end
    end)
end

local function perform_cross_cut(state, index)
    local center_x = _F.GetUnitX(state.anchor)
    local center_y = _F.GetUnitY(state.anchor)
    local angle = (index - 1) * 1.256637
    local slash_x = center_x + RING_RADIUS * _F.Cos(angle)
    local slash_y = center_y + RING_RADIUS * _F.Sin(angle)
    local facing = angle * 57.29582 + 180.0

    _F.SetUnitX(state.caster, slash_x)
    _F.SetUnitY(state.caster, slash_y)
    _F.SetUnitFacing(state.caster, facing)
    _F.SetUnitAnimation(state.caster, "attack")

    create_afterimage(state.owner, slash_x, slash_y, facing, 145)
    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", slash_x, slash_y)
    effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", slash_x, slash_y)
    effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", center_x, center_y)

    sweep_enemies(center_x, center_y, CUT_RADIUS, function(target)
        if is_living_enemy(state.caster, target) then
            effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
            damage_target(state.caster, target, DAMAGE * CUT_DAMAGE_FACTOR)
        end
    end)
end

local function start_cross_cuts(state)
    local count = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, DASH_PERIOD, true, function()
        count = count + 1
        perform_cross_cut(state, count)

        if count >= DASH_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_storm_phase(state)
        end
    end)
end

local function perform_entry_slash(caster, x, y, dash_hits)
    sweep_enemies(x, y, DASH_RADIUS, function(target)
        if is_living_enemy(caster, target) and mark_hit(dash_hits, target) then
            effect_on_target("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", target, "origin")
            damage_target(caster, target, DAMAGE * DASH_DAMAGE_FACTOR)
        end
    end)
end

local function start_sequence(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local center_x, center_y = clamp_target(start_x, start_y, target_x, target_y)
    local dx = center_x - start_x
    local dy = center_y - start_y
    local distance = _F.SquareRoot(dx * dx + dy * dy)

    if distance < 1.0 then
        distance = 1.0
    end

    local facing = _F.Atan2(dy, dx) * 57.29582
    local step_x = dx / DASH_COUNT
    local step_y = dy / DASH_COUNT
    local owner = _F.GetOwningPlayer(caster)
    local anchor = create_anchor(owner, center_x, center_y)
    local dash_hits = {}
    local storm_hits = {}
    local step = 0
    local timer = _F.CreateTimer()

    _F.SetUnitFacing(caster, facing)
    _F.SetUnitAnimation(caster, "spell")
    _F.SetUnitTimeScale(caster, 1.40)

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", start_x, start_y)
    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", center_x, center_y)

    _F.TimerStart(timer, DASH_PERIOD, true, function()
        step = step + 1

        local current_x = start_x + step_x * step
        local current_y = start_y + step_y * step

        _F.SetUnitX(caster, current_x)
        _F.SetUnitY(caster, current_y)

        create_afterimage(owner, current_x, current_y, facing, 95 + step * 18)
        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", current_x, current_y)
        effect_at("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", current_x, current_y)
        perform_entry_slash(caster, current_x, current_y, dash_hits)

        if step >= DASH_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)

            _F.SetUnitX(caster, center_x + RING_RADIUS)
            _F.SetUnitY(caster, center_y)
            _F.SetUnitFacing(caster, 180.0)
            _F.SetUnitTimeScale(caster, 1.12)
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", center_x, center_y)

            start_cross_cuts({
                caster = caster,
                owner = owner,
                anchor = anchor,
                storm_hits = storm_hits,
            })
        end
    end)
end

function moonshatter_tempest.init()
    local trigger = _F.CreateTrigger()

    for i = 0, _C.bj_MAX_PLAYER_SLOTS - 1, 1 do
        _F.TriggerRegisterPlayerUnitEvent(trigger, _F.Player(i), _C.EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
    end

    _F.TriggerAddAction(trigger, function()
        if _F.GetSpellAbilityId() ~= ABILITY_ID then
            return
        end

        start_sequence(
            _F.GetTriggerUnit(),
            _F.GetSpellTargetX(),
            _F.GetSpellTargetY()
        )
    end)
end

return moonshatter_tempest
