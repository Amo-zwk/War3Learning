## 单位Unit
- 英雄单位,建筑单位,普通单位,特殊单位
- 友方单位,敌对单位,中立单位

## 单位的api
## Types
```
unit
unitstate
unittype

unitevent
unitpool
```
## Globals
```lua
UNIT_STATE_LIFE = cj.ConvertUnitState(0)
UNIT_STATE_MAX_LIFE = cj.ConvertUnitState(1)
UNIT_STATE_MANA = cj.ConvertUnitState(2)
UNIT_STATE_MAX_MANA = cj.ConvertUnitState(3)
UNIT_STATE_ATTACK_DICE = cj.ConvertUnitState(0x10) -- 骰子数量
UNIT_STATE_ATTACK_SIDE = cj.ConvertUnitState(0x11) -- 骰子面数
UNIT_STATE_ATTACK_WHITE = cj.ConvertUnitState(0x12) -- 基础攻击
UNIT_STATE_ATTACK_BONUS = cj.ConvertUnitState(0x13) -- 附加伤害
UNIT_STATE_ATTACK_MIX = cj.ConvertUnitState(0x14) -- 攻击最小值
UNIT_STATE_ATTACK_MAX = cj.ConvertUnitState(0x15) -- 攻击最大值
UNIT_STATE_ATTACK_RANGE = cj.ConvertUnitState(0x16) -- 攻击范围
UNIT_STATE_DEFEND_WHITE = cj.ConvertUnitState(0x20) -- 基础护甲
UNIT_STATE_ATTACK_SPACE = cj.ConvertUnitState(0x25) -- 攻击间隔
UNIT_STATE_ATTACK_SPEED = cj.ConvertUnitState(0x51) -- 攻击速度

UNIT_TYPE_HERO = cj.ConvertUnitType(0)
UNIT_TYPE_DEAD = cj.ConvertUnitType(1)
UNIT_TYPE_STRUCTURE = cj.ConvertUnitType(2)
UNIT_TYPE_FLYING = cj.ConvertUnitType(3)
UNIT_TYPE_GROUND = cj.ConvertUnitType(4)
UNIT_TYPE_ATTACKS_FLYING = cj.ConvertUnitType(5)
UNIT_TYPE_ATTACKS_GROUND = cj.ConvertUnitType(6)
UNIT_TYPE_MELEE_ATTACKER = cj.ConvertUnitType(7)
UNIT_TYPE_RANGED_ATTACKER = cj.ConvertUnitType(8)
UNIT_TYPE_GIANT = cj.ConvertUnitType(9)
UNIT_TYPE_SUMMONED = cj.ConvertUnitType(10)
UNIT_TYPE_STUNNED = cj.ConvertUnitType(11)
UNIT_TYPE_PLAGUED = cj.ConvertUnitType(12)
UNIT_TYPE_SNARED = cj.ConvertUnitType(13)
UNIT_TYPE_UNDEAD = cj.ConvertUnitType(14)
UNIT_TYPE_MECHANICAL = cj.ConvertUnitType(15)
UNIT_TYPE_PEON = cj.ConvertUnitType(16)
UNIT_TYPE_SAPPER = cj.ConvertUnitType(17)
UNIT_TYPE_TOWNHALL = cj.ConvertUnitType(18)
UNIT_TYPE_ANCIENT = cj.ConvertUnitType(19)
UNIT_TYPE_TAUREN = cj.ConvertUnitType(20)
UNIT_TYPE_POISONED = cj.ConvertUnitType(21)
UNIT_TYPE_POLYMORPHED = cj.ConvertUnitType(22)
UNIT_TYPE_SLEEPING = cj.ConvertUnitType(23)
UNIT_TYPE_RESISTANT = cj.ConvertUnitType(24)
UNIT_TYPE_ETHEREAL = cj.ConvertUnitType(25)
UNIT_TYPE_MAGIC_IMMUNE = cj.ConvertUnitType(26)

EVENT_PLAYER_UNIT_SELL = cj.ConvertPlayerUnitEvent(269)
EVENT_PLAYER_UNIT_CHANGE_OWNER = cj.ConvertPlayerUnitEvent(270)
EVENT_PLAYER_UNIT_SELL_ITEM = cj.ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_SPELL_CHANNEL = cj.ConvertPlayerUnitEvent(272)
EVENT_PLAYER_UNIT_SPELL_CAST = cj.ConvertPlayerUnitEvent(273)
EVENT_PLAYER_UNIT_SPELL_EFFECT = cj.ConvertPlayerUnitEvent(274)
EVENT_PLAYER_UNIT_SPELL_FINISH = cj.ConvertPlayerUnitEvent(275)
EVENT_PLAYER_UNIT_SPELL_ENDCAST = cj.ConvertPlayerUnitEvent(276)
EVENT_PLAYER_UNIT_PAWN_ITEM = cj.ConvertPlayerUnitEvent(277)
EVENT_UNIT_SELL = cj.ConvertUnitEvent(286)
EVENT_UNIT_CHANGE_OWNER = cj.ConvertUnitEvent(287)
EVENT_UNIT_SELL_ITEM = cj.ConvertUnitEvent(288)
EVENT_UNIT_SPELL_CHANNEL = cj.ConvertUnitEvent(289)
EVENT_UNIT_SPELL_CAST = cj.ConvertUnitEvent(290)
EVENT_UNIT_SPELL_EFFECT = cj.ConvertUnitEvent(291)
EVENT_UNIT_SPELL_FINISH = cj.ConvertUnitEvent(292)
EVENT_UNIT_SPELL_ENDCAST = cj.ConvertUnitEvent(293)
EVENT_UNIT_PAWN_ITEM = cj.ConvertUnitEvent(294)

EVENT_PLAYER_UNIT_ATTACKED = cj.ConvertPlayerUnitEvent(18)
EVENT_PLAYER_UNIT_RESCUED = cj.ConvertPlayerUnitEvent(19)
EVENT_PLAYER_UNIT_DEATH = cj.ConvertPlayerUnitEvent(20)
EVENT_PLAYER_UNIT_DECAY = cj.ConvertPlayerUnitEvent(21)
EVENT_PLAYER_UNIT_DETECTED = cj.ConvertPlayerUnitEvent(22)
EVENT_PLAYER_UNIT_HIDDEN = cj.ConvertPlayerUnitEvent(23)
EVENT_PLAYER_UNIT_SELECTED = cj.ConvertPlayerUnitEvent(24)
EVENT_PLAYER_UNIT_DESELECTED = cj.ConvertPlayerUnitEvent(25)
EVENT_PLAYER_UNIT_CONSTRUCT_START = cj.ConvertPlayerUnitEvent(26)
EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = cj.ConvertPlayerUnitEvent(27)
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = cj.ConvertPlayerUnitEvent(28)
EVENT_PLAYER_UNIT_UPGRADE_START = cj.ConvertPlayerUnitEvent(29)
EVENT_PLAYER_UNIT_UPGRADE_CANCEL = cj.ConvertPlayerUnitEvent(30)
EVENT_PLAYER_UNIT_UPGRADE_FINISH = cj.ConvertPlayerUnitEvent(31)
EVENT_PLAYER_UNIT_TRAIN_START = cj.ConvertPlayerUnitEvent(32)
EVENT_PLAYER_UNIT_TRAIN_CANCEL = cj.ConvertPlayerUnitEvent(33)
EVENT_PLAYER_UNIT_TRAIN_FINISH = cj.ConvertPlayerUnitEvent(34)
EVENT_PLAYER_UNIT_RESEARCH_START = cj.ConvertPlayerUnitEvent(35)
EVENT_PLAYER_UNIT_RESEARCH_CANCEL = cj.ConvertPlayerUnitEvent(36)
EVENT_PLAYER_UNIT_RESEARCH_FINISH = cj.ConvertPlayerUnitEvent(37)
EVENT_PLAYER_UNIT_ISSUED_ORDER = cj.ConvertPlayerUnitEvent(38)
EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER = cj.ConvertPlayerUnitEvent(39)
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER = cj.ConvertPlayerUnitEvent(40)
EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER = cj.ConvertPlayerUnitEvent(40)
EVENT_PLAYER_HERO_LEVEL = cj.ConvertPlayerUnitEvent(41)
EVENT_PLAYER_HERO_SKILL = cj.ConvertPlayerUnitEvent(42)
EVENT_PLAYER_HERO_REVIVABLE = cj.ConvertPlayerUnitEvent(43)
EVENT_PLAYER_HERO_REVIVE_START = cj.ConvertPlayerUnitEvent(44)
EVENT_PLAYER_HERO_REVIVE_CANCEL = cj.ConvertPlayerUnitEvent(45)
EVENT_PLAYER_HERO_REVIVE_FINISH = cj.ConvertPlayerUnitEvent(46)
EVENT_PLAYER_UNIT_SUMMON = cj.ConvertPlayerUnitEvent(47)
EVENT_PLAYER_UNIT_DROP_ITEM = cj.ConvertPlayerUnitEvent(48)
EVENT_PLAYER_UNIT_PICKUP_ITEM = cj.ConvertPlayerUnitEvent(49)
EVENT_PLAYER_UNIT_USE_ITEM = cj.ConvertPlayerUnitEvent(50)
EVENT_PLAYER_UNIT_LOADED = cj.ConvertPlayerUnitEvent(51)
EVENT_UNIT_DAMAGED = cj.ConvertUnitEvent(52)
EVENT_UNIT_DEATH = cj.ConvertUnitEvent(53)
EVENT_UNIT_DECAY = cj.ConvertUnitEvent(54)
EVENT_UNIT_DETECTED = cj.ConvertUnitEvent(55)
EVENT_UNIT_HIDDEN = cj.ConvertUnitEvent(56)
EVENT_UNIT_SELECTED = cj.ConvertUnitEvent(57)
EVENT_UNIT_DESELECTED = cj.ConvertUnitEvent(58)
EVENT_UNIT_STATE_LIMIT = cj.ConvertUnitEvent(59)
EVENT_UNIT_ACQUIRED_TARGET = cj.ConvertUnitEvent(60)
EVENT_UNIT_TARGET_IN_RANGE = cj.ConvertUnitEvent(61)
EVENT_UNIT_ATTACKED = cj.ConvertUnitEvent(62)
EVENT_UNIT_RESCUED = cj.ConvertUnitEvent(63)
EVENT_UNIT_CONSTRUCT_CANCEL = cj.ConvertUnitEvent(64)
EVENT_UNIT_CONSTRUCT_FINISH = cj.ConvertUnitEvent(65)
EVENT_UNIT_UPGRADE_START = cj.ConvertUnitEvent(66)
EVENT_UNIT_UPGRADE_CANCEL = cj.ConvertUnitEvent(67)
EVENT_UNIT_UPGRADE_FINISH = cj.ConvertUnitEvent(68)
EVENT_UNIT_TRAIN_START = cj.ConvertUnitEvent(69)
EVENT_UNIT_TRAIN_CANCEL = cj.ConvertUnitEvent(70)
EVENT_UNIT_TRAIN_FINISH = cj.ConvertUnitEvent(71)
EVENT_UNIT_RESEARCH_START = cj.ConvertUnitEvent(72)
EVENT_UNIT_RESEARCH_CANCEL = cj.ConvertUnitEvent(73)
EVENT_UNIT_RESEARCH_FINISH = cj.ConvertUnitEvent(74)
EVENT_UNIT_ISSUED_ORDER = cj.ConvertUnitEvent(75)
EVENT_UNIT_ISSUED_POINT_ORDER = cj.ConvertUnitEvent(76)
EVENT_UNIT_ISSUED_TARGET_ORDER = cj.ConvertUnitEvent(77)
EVENT_UNIT_HERO_LEVEL = cj.ConvertUnitEvent(78)
EVENT_UNIT_HERO_SKILL = cj.ConvertUnitEvent(79)
EVENT_UNIT_HERO_REVIVABLE = cj.ConvertUnitEvent(80)
EVENT_UNIT_HERO_REVIVE_START = cj.ConvertUnitEvent(81)
EVENT_UNIT_HERO_REVIVE_CANCEL = cj.ConvertUnitEvent(82)
EVENT_UNIT_HERO_REVIVE_FINISH = cj.ConvertUnitEvent(83)
EVENT_UNIT_SUMMON = cj.ConvertUnitEvent(84)
EVENT_UNIT_DROP_ITEM = cj.ConvertUnitEvent(85)
EVENT_UNIT_PICKUP_ITEM = cj.ConvertUnitEvent(86)
EVENT_UNIT_USE_ITEM = cj.ConvertUnitEvent(87)
EVENT_UNIT_LOADED = cj.ConvertUnitEvent(88)
```
## Common
```lua
cj.AddUnitAnimationProperties = JassCommon["AddUnitAnimationProperties"]
cj.AddUnitToAllStock = JassCommon["AddUnitToAllStock"]
cj.AddUnitToStock = JassCommon["AddUnitToStock"]

cj.ConvertPlayerUnitEvent = JassCommon["ConvertPlayerUnitEvent"]
cj.ConvertUnitEvent = JassCommon["ConvertUnitEvent"]
cj.ConvertUnitState = JassCommon["ConvertUnitState"]
cj.ConvertUnitType = JassCommon["ConvertUnitType"]

cj.CreateUnit = JassCommon["CreateUnit"]
cj.CreateUnitAtLoc = JassCommon["CreateUnitAtLoc"]
cj.CreateUnitAtLocByName = JassCommon["CreateUnitAtLocByName"]
cj.CreateUnitByName = JassCommon["CreateUnitByName"]
cj.CreateUnitPool = JassCommon["CreateUnitPool"]

cj.DecUnitAbilityLevel = JassCommon["DecUnitAbilityLevel"]

cj.DestroyUnitPool = JassCommon["DestroyUnitPool"]

cj.FlushStoredUnit = JassCommon["FlushStoredUnit"]

cj.GetBuyingUnit = JassCommon["GetBuyingUnit"]

cj.GetChangingUnit = JassCommon["GetChangingUnit"]
cj.GetChangingUnitPrevOwner = JassCommon["GetChangingUnitPrevOwner"]

cj.GetDecayingUnit = JassCommon["GetDecayingUnit"]

cj.GetDetectedUnit = JassCommon["GetDetectedUnit"]
cj.GetDyingUnit = JassCommon["GetDyingUnit"]
cj.GetEnteringUnit = JassCommon["GetEnteringUnit"]

cj.GetEnumUnit = JassCommon["GetEnumUnit"]

cj.GetEventTargetUnit = JassCommon["GetEventTargetUnit"]
cj.GetEventUnitState = JassCommon["GetEventUnitState"]

cj.GetFilterUnit = JassCommon["GetFilterUnit"]

cj.GetKillingUnit = JassCommon["GetKillingUnit"]


cj.GetLearningUnit = JassCommon["GetLearningUnit"]
cj.GetLeavingUnit = JassCommon["GetLeavingUnit"]
cj.GetLevelingUnit = JassCommon["GetLevelingUnit"]
cj.GetLoadedUnit = JassCommon["GetLoadedUnit"]

cj.GetManipulatingUnit = JassCommon["GetManipulatingUnit"]

cj.GetOrderTargetUnit = JassCommon["GetOrderTargetUnit"]
cj.GetOrderedUnit = JassCommon["GetOrderedUnit"]

cj.GetPlayerTypedUnitCount = JassCommon["GetPlayerTypedUnitCount"]
cj.GetPlayerUnitCount = JassCommon["GetPlayerUnitCount"]

cj.GetResearchingUnit = JassCommon["GetResearchingUnit"]
cj.GetRevivableUnit = JassCommon["GetRevivableUnit"]
cj.GetRevivingUnit = JassCommon["GetRevivingUnit"]

cj.GetSellingUnit = JassCommon["GetSellingUnit"]
cj.GetSoldUnit = JassCommon["GetSoldUnit"]

cj.GetSpellAbilityUnit = JassCommon["GetSpellAbilityUnit"]
cj.GetSpellTargetUnit = JassCommon["GetSpellTargetUnit"]

cj.GetSummonedUnit = JassCommon["GetSummonedUnit"]
cj.GetSummoningUnit = JassCommon["GetSummoningUnit"]

cj.GetTrainedUnit = JassCommon["GetTrainedUnit"]
cj.GetTrainedUnitType = JassCommon["GetTrainedUnitType"]
cj.GetTransportUnit = JassCommon["GetTransportUnit"]

cj.GetTriggerUnit = JassCommon["GetTriggerUnit"]

cj.GetUnitAbilityLevel = JassCommon["GetUnitAbilityLevel"]
cj.GetUnitAcquireRange = JassCommon["GetUnitAcquireRange"]
cj.GetUnitCurrentOrder = JassCommon["GetUnitCurrentOrder"]
cj.GetUnitDefaultAcquireRange = JassCommon["GetUnitDefaultAcquireRange"]
cj.GetUnitDefaultFlyHeight = JassCommon["GetUnitDefaultFlyHeight"]
cj.GetUnitDefaultMoveSpeed = JassCommon["GetUnitDefaultMoveSpeed"]
cj.GetUnitDefaultPropWindow = JassCommon["GetUnitDefaultPropWindow"]
cj.GetUnitDefaultTurnSpeed = JassCommon["GetUnitDefaultTurnSpeed"]
cj.GetUnitFacing = JassCommon["GetUnitFacing"]
cj.GetUnitFlyHeight = JassCommon["GetUnitFlyHeight"]
cj.GetUnitFoodMade = JassCommon["GetUnitFoodMade"]
cj.GetUnitFoodUsed = JassCommon["GetUnitFoodUsed"]
cj.GetUnitLevel = JassCommon["GetUnitLevel"]
cj.GetUnitLoc = JassCommon["GetUnitLoc"]
cj.GetUnitMoveSpeed = JassCommon["GetUnitMoveSpeed"]
cj.GetUnitName = JassCommon["GetUnitName"]
cj.GetUnitPointValue = JassCommon["GetUnitPointValue"]
cj.GetUnitPointValueByType = JassCommon["GetUnitPointValueByType"]
cj.GetUnitPropWindow = JassCommon["GetUnitPropWindow"]
cj.GetUnitRace = JassCommon["GetUnitRace"]
cj.GetUnitRallyDestructable = JassCommon["GetUnitRallyDestructable"]
cj.GetUnitRallyPoint = JassCommon["GetUnitRallyPoint"]
cj.GetUnitRallyUnit = JassCommon["GetUnitRallyUnit"]
cj.GetUnitState = JassCommon["GetUnitState"]
cj.GetUnitTurnSpeed = JassCommon["GetUnitTurnSpeed"]
cj.GetUnitTypeId = JassCommon["GetUnitTypeId"]
cj.GetUnitUserData = JassCommon["GetUnitUserData"]
cj.GetUnitX = JassCommon["GetUnitX"]
cj.GetUnitY = JassCommon["GetUnitY"]


cj.GroupEnumUnitsInRange = JassCommon["GroupEnumUnitsInRange"]
cj.GroupEnumUnitsInRangeCounted = JassCommon["GroupEnumUnitsInRangeCounted"]
cj.GroupEnumUnitsInRangeOfLoc = JassCommon["GroupEnumUnitsInRangeOfLoc"]
cj.GroupEnumUnitsInRangeOfLocCounted = JassCommon["GroupEnumUnitsInRangeOfLocCounted"]
cj.GroupEnumUnitsInRect = JassCommon["GroupEnumUnitsInRect"]
cj.GroupEnumUnitsInRectCounted = JassCommon["GroupEnumUnitsInRectCounted"]
cj.GroupEnumUnitsOfPlayer = JassCommon["GroupEnumUnitsOfPlayer"]
cj.GroupEnumUnitsOfType = JassCommon["GroupEnumUnitsOfType"]
cj.GroupEnumUnitsOfTypeCounted = JassCommon["GroupEnumUnitsOfTypeCounted"]
cj.GroupEnumUnitsSelected = JassCommon["GroupEnumUnitsSelected"]

cj.GroupRemoveUnit = JassCommon["GroupRemoveUnit"]
cj.HaveStoredUnit = JassCommon["HaveStoredUnit"]

cj.IncUnitAbilityLevel = JassCommon["IncUnitAbilityLevel"]

cj.IsHeroUnitId = JassCommon["IsHeroUnitId"]


cj.IsUnit = JassCommon["IsUnit"]
cj.IsUnitAlly = JassCommon["IsUnitAlly"]
cj.IsUnitDetected = JassCommon["IsUnitDetected"]
cj.IsUnitEnemy = JassCommon["IsUnitEnemy"]
cj.IsUnitFogged = JassCommon["IsUnitFogged"]
cj.IsUnitHidden = JassCommon["IsUnitHidden"]
cj.IsUnitIdType = JassCommon["IsUnitIdType"]
cj.IsUnitIllusion = JassCommon["IsUnitIllusion"]
cj.IsUnitInForce = JassCommon["IsUnitInForce"]
cj.IsUnitInGroup = JassCommon["IsUnitInGroup"]
cj.IsUnitInRange = JassCommon["IsUnitInRange"]
cj.IsUnitInRangeLoc = JassCommon["IsUnitInRangeLoc"]
cj.IsUnitInRangeXY = JassCommon["IsUnitInRangeXY"]
cj.IsUnitInRegion = JassCommon["IsUnitInRegion"]
cj.IsUnitInTransport = JassCommon["IsUnitInTransport"]
cj.IsUnitInvisible = JassCommon["IsUnitInvisible"]
cj.IsUnitLoaded = JassCommon["IsUnitLoaded"]
cj.IsUnitMasked = JassCommon["IsUnitMasked"]
cj.IsUnitOwnedByPlayer = JassCommon["IsUnitOwnedByPlayer"]
cj.IsUnitPaused = JassCommon["IsUnitPaused"]
cj.IsUnitRace = JassCommon["IsUnitRace"]
cj.IsUnitSelected = JassCommon["IsUnitSelected"]
cj.IsUnitType = JassCommon["IsUnitType"]
cj.IsUnitVisible = JassCommon["IsUnitVisible"]

cj.KillUnit = JassCommon["KillUnit"]

cj.LoadUnitHandle = JassCommon["LoadUnitHandle"]
cj.LoadUnitPoolHandle = JassCommon["LoadUnitPoolHandle"]

cj.PauseUnit = JassCommon["PauseUnit"]
cj.PlaceRandomUnit = JassCommon["PlaceRandomUnit"]

cj.QueueUnitAnimation = JassCommon["QueueUnitAnimation"]

cj.RemoveUnit = JassCommon["RemoveUnit"]
cj.RemoveUnitFromAllStock = JassCommon["RemoveUnitFromAllStock"]
cj.RemoveUnitFromStock = JassCommon["RemoveUnitFromStock"]

cj.ResetUnitLookAt = JassCommon["ResetUnitLookAt"]
cj.RestoreUnit = JassCommon["RestoreUnit"]

cj.SaveUnitHandle = JassCommon["SaveUnitHandle"]
cj.SaveUnitPoolHandle = JassCommon["SaveUnitPoolHandle"]

cj.SelectUnit = JassCommon["SelectUnit"]
cj.SetAllUnitTypeSlots = JassCommon["SetAllUnitTypeSlots"]

cj.SetPlayerUnitsOwner = JassCommon["SetPlayerUnitsOwner"]


cj.SetUnitAbilityLevel = JassCommon["SetUnitAbilityLevel"]
cj.SetUnitAcquireRange = JassCommon["SetUnitAcquireRange"]
cj.SetUnitAnimation = JassCommon["SetUnitAnimation"]
cj.SetUnitAnimationByIndex = JassCommon["SetUnitAnimationByIndex"]
cj.SetUnitAnimationWithRarity = JassCommon["SetUnitAnimationWithRarity"]
cj.SetUnitBlendTime = JassCommon["SetUnitBlendTime"]
cj.SetUnitColor = JassCommon["SetUnitColor"]
cj.SetUnitCreepGuard = JassCommon["SetUnitCreepGuard"]
cj.SetUnitExploded = JassCommon["SetUnitExploded"]
cj.SetUnitFacing = JassCommon["SetUnitFacing"]
cj.SetUnitFacingTimed = JassCommon["SetUnitFacingTimed"]
cj.SetUnitFlyHeight = JassCommon["SetUnitFlyHeight"]
cj.SetUnitFog = JassCommon["SetUnitFog"]
cj.SetUnitInvulnerable = JassCommon["SetUnitInvulnerable"]
cj.SetUnitLookAt = JassCommon["SetUnitLookAt"]
cj.SetUnitMoveSpeed = JassCommon["SetUnitMoveSpeed"]
cj.SetUnitOwner = JassCommon["SetUnitOwner"]
cj.SetUnitPathing = JassCommon["SetUnitPathing"]
cj.SetUnitPosition = JassCommon["SetUnitPosition"]
cj.SetUnitPositionLoc = JassCommon["SetUnitPositionLoc"]
cj.SetUnitPropWindow = JassCommon["SetUnitPropWindow"]
cj.SetUnitRescuable = JassCommon["SetUnitRescuable"]
cj.SetUnitRescueRange = JassCommon["SetUnitRescueRange"]
cj.SetUnitScale = JassCommon["SetUnitScale"]
cj.SetUnitState = JassCommon["SetUnitState"]
cj.SetUnitTimeScale = JassCommon["SetUnitTimeScale"]
cj.SetUnitTurnSpeed = JassCommon["SetUnitTurnSpeed"]
cj.SetUnitTypeSlots = JassCommon["SetUnitTypeSlots"]
cj.SetUnitUseFood = JassCommon["SetUnitUseFood"]
cj.SetUnitUserData = JassCommon["SetUnitUserData"]
cj.SetUnitVertexColor = JassCommon["SetUnitVertexColor"]
cj.SetUnitX = JassCommon["SetUnitX"]
cj.SetUnitY = JassCommon["SetUnitY"]

cj.ShowUnit = JassCommon["ShowUnit"]
cj.StoreUnit = JassCommon["StoreUnit"]
cj.SyncStoredUnit = JassCommon["SyncStoredUnit"]

cj.TriggerRegisterFilterUnitEvent = JassCommon["TriggerRegisterFilterUnitEvent"]

cj.TriggerRegisterPlayerUnitEvent = JassCommon["TriggerRegisterPlayerUnitEvent"]


cj.TriggerRegisterUnitEvent = JassCommon["TriggerRegisterUnitEvent"]
cj.TriggerRegisterUnitInRange = JassCommon["TriggerRegisterUnitInRange"]
cj.TriggerRegisterUnitStateEvent = JassCommon["TriggerRegisterUnitStateEvent"]


cj.UnitAddAbility = JassCommon["UnitAddAbility"]
cj.UnitAddIndicator = JassCommon["UnitAddIndicator"]
cj.UnitAddItem = JassCommon["UnitAddItem"]
cj.UnitAddItemById = JassCommon["UnitAddItemById"]
cj.UnitAddItemToSlotById = JassCommon["UnitAddItemToSlotById"]
cj.UnitAddSleep = JassCommon["UnitAddSleep"]
cj.UnitAddSleepPerm = JassCommon["UnitAddSleepPerm"]
cj.UnitAddType = JassCommon["UnitAddType"]
cj.UnitApplyTimedLife = JassCommon["UnitApplyTimedLife"]
cj.UnitCanSleep = JassCommon["UnitCanSleep"]
cj.UnitCanSleepPerm = JassCommon["UnitCanSleepPerm"]
cj.UnitCountBuffsEx = JassCommon["UnitCountBuffsEx"]
cj.UnitDamagePoint = JassCommon["UnitDamagePoint"]
cj.UnitDamageTarget = JassCommon["UnitDamageTarget"]
cj.UnitDropItemPoint = JassCommon["UnitDropItemPoint"]
cj.UnitDropItemSlot = JassCommon["UnitDropItemSlot"]
cj.UnitDropItemTarget = JassCommon["UnitDropItemTarget"]
cj.UnitHasBuffsEx = JassCommon["UnitHasBuffsEx"]
cj.UnitHasItem = JassCommon["UnitHasItem"]
cj.UnitId = JassCommon["UnitId"]
cj.UnitId2String = JassCommon["UnitId2String"]
cj.UnitIgnoreAlarm = JassCommon["UnitIgnoreAlarm"]
cj.UnitIgnoreAlarmToggled = JassCommon["UnitIgnoreAlarmToggled"]
cj.UnitInventorySize = JassCommon["UnitInventorySize"]
cj.UnitIsSleeping = JassCommon["UnitIsSleeping"]
cj.UnitItemInSlot = JassCommon["UnitItemInSlot"]
cj.UnitMakeAbilityPermanent = JassCommon["UnitMakeAbilityPermanent"]
cj.UnitModifySkillPoints = JassCommon["UnitModifySkillPoints"]
cj.UnitPauseTimedLife = JassCommon["UnitPauseTimedLife"]
cj.UnitPoolAddUnitType = JassCommon["UnitPoolAddUnitType"]
cj.UnitPoolRemoveUnitType = JassCommon["UnitPoolRemoveUnitType"]
cj.UnitRemoveAbility = JassCommon["UnitRemoveAbility"]
cj.UnitRemoveBuffs = JassCommon["UnitRemoveBuffs"]
cj.UnitRemoveBuffsEx = JassCommon["UnitRemoveBuffsEx"]
cj.UnitRemoveItem = JassCommon["UnitRemoveItem"]
cj.UnitRemoveItemFromSlot = JassCommon["UnitRemoveItemFromSlot"]
cj.UnitRemoveType = JassCommon["UnitRemoveType"]
cj.UnitResetCooldown = JassCommon["UnitResetCooldown"]
cj.UnitSetConstructionProgress = JassCommon["UnitSetConstructionProgress"]
cj.UnitSetUpgradeProgress = JassCommon["UnitSetUpgradeProgress"]
cj.UnitSetUsesAltIcon = JassCommon["UnitSetUsesAltIcon"]
cj.UnitShareVision = JassCommon["UnitShareVision"]
cj.UnitStripHeroLevel = JassCommon["UnitStripHeroLevel"]
cj.UnitSuspendDecay = JassCommon["UnitSuspendDecay"]
cj.UnitUseItem = JassCommon["UnitUseItem"]
cj.UnitUseItemPoint = JassCommon["UnitUseItemPoint"]
cj.UnitUseItemTarget = JassCommon["UnitUseItemTarget"]
cj.UnitWakeUp = JassCommon["UnitWakeUp"]
```
## Japi
```
EXGetUnitArrayString
DzAPI_UnitType_SetEnum_PreventOrReguirePlace
EXSetUnitReal
EXSetUnitCollisionType
DzAPI_UnitType_GetUnitTypeDataAbilID
GetUnitState
DzAPI_UnitType_SetEnum_armor
SetUnitState


EXGetUnitReal
DzAPI_UnitType_GetUnitTypeDataBoolean
EXGetUnitString
EXSetUnitString
EXGetUnitInteger
EXSetUnitInteger

DzAPI_UnitType_CountUnitTypeDataArrayTechID

DzAPI_UnitType_GetEnum_weapTp
EXSetUnitArrayString

EXPauseUnit


EXSetUnitMoveType
EXSetUnitFacing
EXGetUnitAbility

EXGetUnitAbilityByIndex
DzAPI_UnitType_SetUnitTypeDataArrayString

DzAPI_UnitType_ResizeUnitTypeDataArrayAbilID
DzAPI_UnitType_GetEnum_type

DzAPI_UnitType_CountUnitTypeDataArrayItemID
DzAPI_UnitType_ResizeUnitTypeDataArrayReal
DzAPI_UnitType_SetUnitTypeDataArrayAbilID
DzAPI_UnitType_GetUnitTypeDataRequiresamount
DzAPI_UnitType_SetUnitTypeDataReal

DzEvent_Unit_Hired
DzUnitLearningSkill
DzAPI_UnitType_CountUnitTypeDataArrayAbilID

DzAPI_UnitType_SetEnum_typeModify
DzAPI_UnitType_GetUnitTypeDataRequires
DzAPI_UnitType_GetUnitTypeDataArrayString

DzEvent_Unit_Dead
DzEvent_Unit_Start
DzEvent_Unit_Cancel

DzAPI_UnitType_GetEnum_weapType
DzEvent_Unit_Finish
DzAPI_UnitType_GetUnitTypeDataReal

DzEvent_Unit_ChangeOwner
DzAPI_UnitType_GetEnum_movetp

DzAPI_UnitType_GetUnitTypeDataArrayUnitID
DzAPI_UnitType_SetUnitTypeDataArrayReal

DzAPI_UnitType_GetUnitTypeDataString
DzAPI_UnitType_SetUnitTypeDataArrayUnitID

DzUnitDisableInventory

DzAPI_UnitType_GetUnitTypeDataArrayReal
DzAPI_UnitstateToInteger
DzAPI_UnitType_GettUnitTypeDataRequirescount
DzAPI_UnitType_GetEnum_PreventOrReguirePlaceCheck
DzAPI_UnitType_GetUnitTypeDataInt
DzAPI_UnitType_SetUnitTypeDataInt


DzAPI_UnitType_CountUnitTypeDataArrayReal
DzAPI_UnitType_SetUnitTypeDataBoolean
DzAPI_UnitType_CountUnitTypeDataArrayBoolean
DzAPI_UnitType_ResizeUnitTypeDataArrayBoolean

DzAPI_UnitType_GetUnitTypeDataArrayBoolean


DzAPI_UnitType_SetUnitTypeDataArrayBoolean
DzAPI_UnitType_SetUnitTypeDataString
DzAPI_UnitType_CountUnitTypeDataArrayString
DzAPI_UnitType_ResizeUnitTypeDataArrayString
DzAPI_UnitType_ResizeUnitTypeDataArrayTechID
DzAPI_UnitType_GetUnitTypeDataArrayTechID
DzAPI_UnitType_SetUnitTypeDataArrayTechID
DzAPI_UnitType_SetUnitTypeDataAbilID
DzAPI_UnitType_GetUnitTypeDataArrayAbilID
DzAPI_UnitType_CountUnitTypeDataArrayUnitID
DzAPI_UnitType_SetEnum_TargetTypeSeries
DzAPI_UnitType_SetEnum_atkType
DzAPI_UnitType_ResizeUnitTypeDataArrayUnitID

DzAPI_UnitType_ResizeUnitTypeDataArrayItemID
DzAPI_UnitType_GetUnitTypeDataArrayItemID
DzAPI_UnitType_SetUnitTypeDataArrayItemID
DzAPI_UnitType_GetEnum_regenType
DzAPI_UnitType_SetEnum_regenType
DzAPI_UnitType_SetEnum_race
DzAPI_UnitType_SetEnum_weapTp
DzAPI_UnitType_GetEnum_defType
DzAPI_UnitType_GetEnum_PreventOrReguirePlace
DzAPI_UnitType_SetEnum_defType

DzAPI_UnitType_GetEnum_Primary
DzAPI_UnitType_GetEnum_warpsOn

DzAPI_UnitType_SetEnum_warpsOn
DzAPI_UnitType_GetEnum_atkType
DzAPI_UnitType_SetEnum_weapType

DzAPI_UnitType_SetEnum_Primary

DzAPI_UnitType_SetEnum_movetp
DzAPI_UnitType_GetEnum_buffType
DzAPI_UnitType_SetEnum_buffType

DzAPI_UnitType_GetEnum_race
DzAPI_UnitType_GetEnum_deathType
DzAPI_UnitType_SetEnum_deathType
DzAPI_UnitType_GetEnum_armor
DzAPI_UnitType_GetEnum_TargetTypeSeries
DzAPI_UnitType_GetEnum_TargetTypeCheck
DzAPI_UnitType_SetEnum_TargetTypeModify
DzAPI_UnitType_SetEnum_type
DzAPI_UnitType_GetEnum_typeCheck
DzAPI_UnitType_SetEnum_PreventOrReguirePlaceModify
DzAPI_UnitType_CountUnitTypeDataRequires
DzAPI_UnitType_ResizeUnitTypeDataRequires

DzAPI_UnitType_SetUnitTypeDataRequires
DzSetUnitTexture
DzAPI_UnitType_CountUnitTypeDataRequiresamount
DzAPI_UnitType_ResizeUnitTypeDataRequiresamount
DzAPI_UnitType_SetUnitTypeDataRequiresamount

DzGetUnitNeededXP

DzGetUnitUnderMouse
DzSetUnitPosition
DzSetUnitModel
DzSetUnitID

DzUnitSilence
DzUnitDisableAttack
```