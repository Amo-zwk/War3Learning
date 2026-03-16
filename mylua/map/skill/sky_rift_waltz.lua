local sky_rift_waltz = {}

local DAMAGE = 300 -- You may change this damage value only.

local ABILITY_ID = char2id("C001")
local DUMMY_UNIT_ID = char2id("u002")

local DASH_DISTANCE = 420.0
local DASH_STEPS = 10
local DASH_PERIOD = 0.03
local DASH_AOE = 135.0
local PULSE_COUNT = 3
local PULSE_PERIOD = 0.18
local PULSE_AOE = 225.0
local FINISH_AOE = 320.0
local ORBIT_RADIUS = 150.0
local DASH_DAMAGE_FACTOR = 0.30
local PULSE_DAMAGE_FACTOR = 0.30
local FINISH_DAMAGE_FACTOR = 0.70

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

local function effect_at(path, x, y)
    local effect = _F.AddSpecialEffect(path, x, y)
    _F.DestroyEffect(effect)
end

local function create_anchor(owner, x, y)
    local dummy = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, 270.0)
    _F.ShowUnit(dummy, false)
    _F.SetUnitPathing(dummy, false)
    _F.SetUnitInvulnerable(dummy, true)
    _F.SetUnitVertexColor(dummy, 255, 255, 255, 0)
    return dummy
end

local function create_afterimage(owner, x, y, facing)
    local image = _F.CreateUnit(owner, DUMMY_UNIT_ID, x, y, facing)
    _F.ShowUnit(image, false)
    _F.SetUnitPathing(image, false)
    _F.SetUnitInvulnerable(image, true)
    _F.SetUnitVertexColor(image, 180, 220, 255, 120)
    _F.UnitApplyTimedLife(image, char2id("BTLF"), 0.35)
    return image
end

local function mark_and_damage(mark_table, source, target, amount)
    local key = _F.GetHandleId(target)
    if mark_table[key] then
        return
    end
    mark_table[key] = true
    damage_target(source, target, amount)
end

local function perform_finisher(state)
    local x = _F.GetUnitX(state.anchor)
    local y = _F.GetUnitY(state.anchor)

    effect_at("Abilities\\Spells\\NightElf\\Starfall\\StarfallCaster.mdl", x, y)
    effect_at("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", x, y)
    effect_at("Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl", x, y)

    _F.SetUnitTimeScale(state.caster, 1.20)
    _F.SetUnitAnimation(state.caster, "attack")
    _F.QueueUnitAnimation(state.caster, "stand")

    sweep_enemies(x, y, FINISH_AOE, function(target)
        if is_living_enemy(state.caster, target) then
            damage_target(state.caster, target, DAMAGE * FINISH_DAMAGE_FACTOR)
        end
    end)

    _F.SetUnitTimeScale(state.caster, 1.00)
    _F.RemoveUnit(state.anchor)
end

local function start_pulse_phase(state)
    local pulse_count = 0
    local timer = _F.CreateTimer()

    _F.TimerStart(timer, PULSE_PERIOD, true, function()
        pulse_count = pulse_count + 1

        local x = _F.GetUnitX(state.anchor)
        local y = _F.GetUnitY(state.anchor)
        local angle = (pulse_count - 1) * 2.09439
        local slash_x = x + ORBIT_RADIUS * _F.Cos(angle)
        local slash_y = y + ORBIT_RADIUS * _F.Sin(angle)

        effect_at("Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", slash_x, slash_y)
        effect_at("Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl", x, y)
        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", slash_x, slash_y)

        _F.SetUnitX(state.caster, slash_x)
        _F.SetUnitY(state.caster, slash_y)
        _F.SetUnitFacing(state.caster, angle * 57.29582 + 120.0)
        _F.SetUnitAnimation(state.caster, "attack")

        sweep_enemies(x, y, PULSE_AOE, function(target)
            if is_living_enemy(state.caster, target) then
                mark_and_damage(state.pulse_hits, state.caster, target, DAMAGE * PULSE_DAMAGE_FACTOR / PULSE_COUNT)
            end
        end)

        if pulse_count >= PULSE_COUNT then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            perform_finisher(state)
        end
    end)
end

local function start_dash(caster, target_x, target_y)
    local start_x = _F.GetUnitX(caster)
    local start_y = _F.GetUnitY(caster)
    local dx = target_x - start_x
    local dy = target_y - start_y
    local distance = _F.SquareRoot(dx * dx + dy * dy)

    if distance < 1.0 then
        distance = 1.0
    end

    local travel = distance
    if travel > DASH_DISTANCE then
        travel = DASH_DISTANCE
    end

    local step_x = dx / distance * (travel / DASH_STEPS)
    local step_y = dy / distance * (travel / DASH_STEPS)
    local facing = _F.Atan2(dy, dx) * 57.29582
    local owner = _F.GetOwningPlayer(caster)
    local dash_hits = {}
    local pulse_hits = {}
    local anchor = create_anchor(owner, start_x, start_y)
    local step = 0
    local timer = _F.CreateTimer()

    _F.SetUnitFacing(caster, facing)
    _F.SetUnitAnimation(caster, "spell")
    _F.SetUnitTimeScale(caster, 1.35)

    _F.TimerStart(timer, DASH_PERIOD, true, function()
        step = step + 1

        local current_x = start_x + step_x * step
        local current_y = start_y + step_y * step

        _F.SetUnitX(caster, current_x)
        _F.SetUnitY(caster, current_y)
        _F.SetUnitX(anchor, current_x)
        _F.SetUnitY(anchor, current_y)

        effect_at("Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", current_x, current_y)
        effect_at("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", current_x, current_y)
        create_afterimage(owner, current_x, current_y, facing)

        sweep_enemies(current_x, current_y, DASH_AOE, function(target)
            if is_living_enemy(caster, target) then
                mark_and_damage(dash_hits, caster, target, DAMAGE * DASH_DAMAGE_FACTOR)
            end
        end)

        if step >= DASH_STEPS then
            _F.PauseTimer(timer)
            _F.DestroyTimer(timer)
            _F.SetUnitTimeScale(caster, 1.00)
            start_pulse_phase({
                caster = caster,
                anchor = anchor,
                pulse_hits = pulse_hits,
            })
        end
    end)
end

function sky_rift_waltz.init()
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

return sky_rift_waltz
