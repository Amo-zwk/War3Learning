# 技能
- 单位之间的互动  修改单位的属性
    - 攻击类的技能 减少目标单位的血量
    - 辅助类的技能 增减目标单位的属性(友军的辅助技能 敌军的辅助技能)
    - buff类技能   增减目标单位的属性
    - 物品类的技能  增减目标单位的属性

# api
## Types
```
ability
```
## Globals
```lua


```
## Common
```lua
cj.AbilityId = JassCommon["AbilityId"]
cj.AbilityId2String = JassCommon["AbilityId2String"]

cj.DecUnitAbilityLevel = JassCommon["DecUnitAbilityLevel"]


cj.GetAbilityEffect = JassCommon["GetAbilityEffect"]
cj.GetAbilityEffectById = JassCommon["GetAbilityEffectById"]
cj.GetAbilitySound = JassCommon["GetAbilitySound"]
cj.GetAbilitySoundById = JassCommon["GetAbilitySoundById"]

cj.GetSpellAbility = JassCommon["GetSpellAbility"]
cj.GetSpellAbilityId = JassCommon["GetSpellAbilityId"]
cj.GetSpellAbilityUnit = JassCommon["GetSpellAbilityUnit"]

cj.GetUnitAbilityLevel = JassCommon["GetUnitAbilityLevel"]

cj.IncUnitAbilityLevel = JassCommon["IncUnitAbilityLevel"]

cj.LoadAbilityHandle = JassCommon["LoadAbilityHandle"]

cj.SaveAbilityHandle = JassCommon["SaveAbilityHandle"]

cj.SetPlayerAbilityAvailable = JassCommon["SetPlayerAbilityAvailable"]

cj.SetUnitAbilityLevel = JassCommon["SetUnitAbilityLevel"]
cj.UnitAddAbility = JassCommon["UnitAddAbility"]

cj.UnitMakeAbilityPermanent = JassCommon["UnitMakeAbilityPermanent"]
cj.UnitRemoveAbility = JassCommon["UnitRemoveAbility"]


```
## Japi
```lua
EXGetAbilityDataString

EXGetUnitAbilityByIndex
EXGetAbilityId

EXGetAbilityState
EXSetAbilityState

EXGetAbilityDataReal
EXSetAbilityDataReal

EXGetAbilityDataInteger
EXSetAbilityDataInteger

EXSetAbilityString
EXSetAbilityDataString

EXSetAbilityAEmeDataA
EXGetAbilityString

```