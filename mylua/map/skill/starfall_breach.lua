local starfall_breach = {}

local DAMAGE = 420 -- You may change this damage value only.

local ABILITY_ID = char2id("C003")
local DUMMY_UNIT_ID = char2id("u003")
local MARK_ABILITY_ID = char2id("C004")

local MAX_RANGE = 720.0
local DASH_STEPS = 12
local DASH_PERIOD = 0.03
local DASH_AOE = 145.0
local SLASH_COUNT = 4
local SLASH_PERIOD = 0.16
local SLASH_RADIUS = 215.0
local PULL_COUNT = 6
local PULL_PERIOD = 0.03
local PULL_RADIUS = 320.0
local FINISH_RADIUS = 360.0
local ORBIT_RADIUS = 175.0
local DASH_DAMAGE_FACTOR = 0.24
local SLASH_DAMAGE_FACTOR = 0.11
local IMPLODE_DAMAGE_FACTOR = 0.16
local FINISH_DAMAGE_FACTOR = 0.80

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
        return target_x, target_y, dx, dy, distance
    end

    if distance < 1.0 then
        distance = 1.0
    end

    local scale = MAX_RANGE / distance
    local final_dx = dx * scale
    local final_dy = dy * scale

    return start_x + final_dx, start_y + final_dy, final_dx, final_dy, MAX_RANGE
end

local function create_anchor(owner, x, y)
    local dummy = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, 270.0)
    _F.ShowUnit(dummy, false)
    _F.SetUnitPathing(dummy, false)
    _F.SetUnitInvulnerable(dummy, true)
    _F.SetUnitVertexColor(dummy, 255, 255, 255, 0)
    _F.UnitAddAbility(dummy, MARK_ABILITY_ID)
    return dummy
end

local function create_afterimage(owner, x, y, facing, alpha)
    local image = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(image, false)
    _F.SetUnitPathing(image, false)
    _F.SetUnitInvulnerable(image, true)
    _F.SetUnitVertexColor(image, 180, 225, 255, alpha)
    _F.UnitApplyTimedLife(image, char2id("BTLF"), 0.45)
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
    _F.SetUnitY(state.caster, center_y - 45.0)
    _F.SetUnitFacing(state.caster, 90.0)
    _F.SetUnitTimeScale(state.caster, 1.20)
    _F.SetUnitAnimation(state.caster, "attack slam")
    _F.QueueUnitAnimation(state.caster, "stand")

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", center_x, center_y)
    effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", center_x, center_y)

    sweep_enemies(center_x, center_y, FINISH_RADIUS, function(target)
        if is_living_enemy(state.caster, target) then
            effect_on_target("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", target, "origin")
            damage_target(state.caster, target, DAMAGE * FINISH_DAMAGE_FACTOR)
        end
    end)

    _F.SetUnitTimeScale(state.caster, 1.00)
    _F.RemoveUnit(state.anchor)
end

local function start_implosion(state)
    local tick = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PULL_PERIOD, true, function()
        tick = tick + 1

        local center_x = _F.GetUnitX(state.anchor)
        local center_y = _F.GetUnitY(state.anchor)
        local targets = collect_enemies(center_x, center_y, PULL_RADIUS, state.caster)

        effect_at("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", center_x, center_y)

        for _, target in ipairs(targets) do
            pull_unit_toward(target, center_x, center_y, 0.18)
            if tick == PULL_COUNT and mark_hit(state.implode_hits, target) then
                damage_target(state.caster, target, DAMAGE * IMPLODE_DAMAGE_FACTOR)
            end
        end

        if tick >= PULL_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            perform_finale(state)
        end
    end)
end

local function slash_angle(index)
    return (index - 1) * 1.570796 + 0.785398
end

local function perform_slash(state, index)
    local center_x = _F.GetUnitX(state.anchor)
    local center_y = _F.GetUnitY(state.anchor)
    local angle = slash_angle(index)
    local slash_x = center_x + ORBIT_RADIUS * _F.Cos(angle)
    local slash_y = center_y + ORBIT_RADIUS * _F.Sin(angle)
    local facing = angle * 57.29582 + 180.0

    _F.SetUnitX(state.caster, slash_x)
    _F.SetUnitY(state.caster, slash_y)
    _F.SetUnitFacing(state.caster, facing)
    _F.SetUnitAnimation(state.caster, "attack")
    create_afterimage(state.owner, slash_x, slash_y, facing, 135)

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", slash_x, slash_y)
    effect_at("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", slash_x, slash_y)
    effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", slash_x, slash_y)
    effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", center_x, center_y)

    sweep_enemies(center_x, center_y, SLASH_RADIUS, function(target)
        if is_living_enemy(state.caster, target) then
            effect_on_target("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", target, "chest")
            damage_target(state.caster, target, DAMAGE * SLASH_DAMAGE_FACTOR)
        end
    end)
end

local function start_slash_phase(state)
    local count = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, SLASH_PERIOD, true, function()
        count = count + 1
        perform_slash(state, count)

        if count >= SLASH_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            start_implosion(state)
        end
    end)
end

local function perform_dash_wave(caster, x, y, dash_hits)
    sweep_enemies(x, y, DASH_AOE, function(target)
        if is_living_enemy(caster, target) and mark_hit(dash_hits, target) then
            effect_on_target("Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl", target, "origin")
            damage_target(caster, target, DAMAGE * DASH_DAMAGE_FACTOR)
        end
    end)
end

local function start_dash(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local final_x, final_y, dx, dy, distance = clamp_target(start_x, start_y, target_x, target_y)

    if distance < 1.0 then
        distance = 1.0
    end

    local step_x = dx / distance * (distance / DASH_STEPS)
    local step_y = dy / distance * (distance / DASH_STEPS)
    local facing = _F.Atan2(dy, dx) * 57.29582
    local owner = _F.GetOwningPlayer(caster)
    local anchor = create_anchor(owner, final_x, final_y)
    local dash_hits = {}
    local implode_hits = {}
    local step = 0
    local timer = _F.CreateTimer()

    _F.SetUnitFacing(caster, facing)
    _F.SetUnitAnimation(caster, "spell")
    _F.SetUnitTimeScale(caster, 1.45)

    effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", start_x, start_y)
    effect_at("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl", final_x, final_y)

    _F.TimerStart(timer, DASH_PERIOD, true, function()
        step = step + 1

        local current_x = start_x + step_x * step
        local current_y = start_y + step_y * step

        _F.SetUnitX(caster, current_x)
        _F.SetUnitY(caster, current_y)

        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", current_x, current_y)
        effect_at("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", current_x, current_y)
        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl", current_x, current_y)
        create_afterimage(owner, current_x, current_y, facing, 90 + step * 10)
        perform_dash_wave(caster, current_x, current_y, dash_hits)

        if step >= DASH_STEPS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)

            _F.SetUnitX(caster, final_x)
            _F.SetUnitY(caster, final_y)
            _F.SetUnitFacing(caster, facing)
            _F.SetUnitTimeScale(caster, 1.10)
            effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", final_x, final_y)

            start_slash_phase({
                caster = caster,
                owner = owner,
                anchor = anchor,
                implode_hits = implode_hits,
            })
        end
    end)
end

function starfall_breach.init()
    local trigger = _F.CreateTrigger()

    for i = 0, _C.bj_MAX_PLAYER_SLOTS - 1, 1 do
        _F.TriggerRegisterPlayerUnitEvent(trigger, _F.Player(i), _C.EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
    end

    _F.TriggerAddAction(trigger, function()
        if _F.GetSpellAbilityId() ~= ABILITY_ID then
            return
        end

        start_dash(
            _F.GetTriggerUnit(),
            _F.GetSpellTargetX(),
            _F.GetSpellTargetY()
        )
    end)
end

return starfall_breach
