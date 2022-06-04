## 玩家相关
```
player
    获取本地玩家,玩家id,玩家种族,玩家姓名
    玩家联盟(队伍)
playercolor
    玩家颜色
playergameresult
    本局游戏结果
playerscore
    玩家的积分
playerslotstate
    玩家槽
playerstate
    玩家信息
    
playerevent
    玩家事件
playerunitevent
    玩家单位事件
```

## JassGlobals
```lua
bj_MAX_PLAYERS = 12
bj_PLAYER_NEUTRAL_VICTIM = 13
bj_PLAYER_NEUTRAL_EXTRA = 14


PLAYER_NEUTRAL_PASSIVE = 15
PLAYER_NEUTRAL_AGGRESSIVE = 12

-- 玩家种族
RACE_HUMAN = cj.ConvertRace(1)
RACE_ORC = cj.ConvertRace(2)
RACE_UNDEAD = cj.ConvertRace(3)
RACE_NIGHTELF = cj.ConvertRace(4)
RACE_DEMON = cj.ConvertRace(5)
RACE_OTHER = cj.ConvertRace(7)


-- 玩家颜色
PLAYER_COLOR_RED = cj.ConvertPlayerColor(0)
PLAYER_COLOR_BLUE = cj.ConvertPlayerColor(1)
PLAYER_COLOR_CYAN = cj.ConvertPlayerColor(2)
PLAYER_COLOR_PURPLE = cj.ConvertPlayerColor(3)
PLAYER_COLOR_YELLOW = cj.ConvertPlayerColor(4)
PLAYER_COLOR_ORANGE = cj.ConvertPlayerColor(5)
PLAYER_COLOR_GREEN = cj.ConvertPlayerColor(6)
PLAYER_COLOR_PINK = cj.ConvertPlayerColor(7)
PLAYER_COLOR_LIGHT_GRAY = cj.ConvertPlayerColor(8)
PLAYER_COLOR_LIGHT_BLUE = cj.ConvertPlayerColor(9)
PLAYER_COLOR_AQUA = cj.ConvertPlayerColor(10)
PLAYER_COLOR_BROWN = cj.ConvertPlayerColor(11)
PLAYER_COLOR_BLACK = cj.ConvertPlayerColor(12)


-- 玩家游戏结果
PLAYER_GAME_RESULT_VICTORY = cj.ConvertPlayerGameResult(0)
PLAYER_GAME_RESULT_DEFEAT = cj.ConvertPlayerGameResult(1)
PLAYER_GAME_RESULT_TIE = cj.ConvertPlayerGameResult(2)
PLAYER_GAME_RESULT_NEUTRAL = cj.ConvertPlayerGameResult(3)


-- 队伍设置
ALLIANCE_PASSIVE = cj.ConvertAllianceType(0)
ALLIANCE_HELP_REQUEST = cj.ConvertAllianceType(1)
ALLIANCE_HELP_RESPONSE = cj.ConvertAllianceType(2)
ALLIANCE_SHARED_XP = cj.ConvertAllianceType(3)
ALLIANCE_SHARED_SPELLS = cj.ConvertAllianceType(4)
ALLIANCE_SHARED_VISION = cj.ConvertAllianceType(5)
ALLIANCE_SHARED_CONTROL = cj.ConvertAllianceType(6)
ALLIANCE_SHARED_ADVANCED_CONTROL = cj.ConvertAllianceType(7)
ALLIANCE_RESCUABLE = cj.ConvertAllianceType(8)
ALLIANCE_SHARED_VISION_FORCED = cj.ConvertAllianceType(9)

-- 玩家槽状态
PLAYER_SLOT_STATE_EMPTY = cj.ConvertPlayerSlotState(0)
PLAYER_SLOT_STATE_PLAYING = cj.ConvertPlayerSlotState(1)
PLAYER_SLOT_STATE_LEFT = cj.ConvertPlayerSlotState(2)

-- 玩家信息
PLAYER_STATE_GAME_RESULT = cj.ConvertPlayerState(0)
PLAYER_STATE_RESOURCE_GOLD = cj.ConvertPlayerState(1)
PLAYER_STATE_RESOURCE_LUMBER = cj.ConvertPlayerState(2)
PLAYER_STATE_RESOURCE_HERO_TOKENS = cj.ConvertPlayerState(3)
PLAYER_STATE_RESOURCE_FOOD_CAP = cj.ConvertPlayerState(4)
PLAYER_STATE_RESOURCE_FOOD_USED = cj.ConvertPlayerState(5)
PLAYER_STATE_FOOD_CAP_CEILING = cj.ConvertPlayerState(6)
PLAYER_STATE_GIVES_BOUNTY = cj.ConvertPlayerState(7)
PLAYER_STATE_ALLIED_VICTORY = cj.ConvertPlayerState(8)
PLAYER_STATE_PLACED = cj.ConvertPlayerState(9)
PLAYER_STATE_OBSERVER_ON_DEATH = cj.ConvertPlayerState(10)
PLAYER_STATE_OBSERVER = cj.ConvertPlayerState(11)
PLAYER_STATE_UNFOLLOWABLE = cj.ConvertPlayerState(12)
PLAYER_STATE_GOLD_UPKEEP_RATE = cj.ConvertPlayerState(13)
PLAYER_STATE_LUMBER_UPKEEP_RATE = cj.ConvertPlayerState(14)
PLAYER_STATE_GOLD_GATHERED = cj.ConvertPlayerState(15)
PLAYER_STATE_LUMBER_GATHERED = cj.ConvertPlayerState(16)
PLAYER_STATE_NO_CREEP_SLEEP = cj.ConvertPlayerState(25)

PLAYER_SCORE_UNITS_TRAINED = cj.ConvertPlayerScore(0)
PLAYER_SCORE_UNITS_KILLED = cj.ConvertPlayerScore(1)
PLAYER_SCORE_STRUCT_BUILT = cj.ConvertPlayerScore(2)
PLAYER_SCORE_STRUCT_RAZED = cj.ConvertPlayerScore(3)
PLAYER_SCORE_TECH_PERCENT = cj.ConvertPlayerScore(4)
PLAYER_SCORE_FOOD_MAXPROD = cj.ConvertPlayerScore(5)
PLAYER_SCORE_FOOD_MAXUSED = cj.ConvertPlayerScore(6)
PLAYER_SCORE_HEROES_KILLED = cj.ConvertPlayerScore(7)
PLAYER_SCORE_ITEMS_GAINED = cj.ConvertPlayerScore(8)
PLAYER_SCORE_MERCS_HIRED = cj.ConvertPlayerScore(9)
PLAYER_SCORE_GOLD_MINED_TOTAL = cj.ConvertPlayerScore(10)
PLAYER_SCORE_GOLD_MINED_UPKEEP = cj.ConvertPlayerScore(11)
PLAYER_SCORE_GOLD_LOST_UPKEEP = cj.ConvertPlayerScore(12)
PLAYER_SCORE_GOLD_LOST_TAX = cj.ConvertPlayerScore(13)
PLAYER_SCORE_GOLD_GIVEN = cj.ConvertPlayerScore(14)
PLAYER_SCORE_GOLD_RECEIVED = cj.ConvertPlayerScore(15)
PLAYER_SCORE_LUMBER_TOTAL = cj.ConvertPlayerScore(16)
PLAYER_SCORE_LUMBER_LOST_UPKEEP = cj.ConvertPlayerScore(17)
PLAYER_SCORE_LUMBER_LOST_TAX = cj.ConvertPlayerScore(18)
PLAYER_SCORE_LUMBER_GIVEN = cj.ConvertPlayerScore(19)
PLAYER_SCORE_LUMBER_RECEIVED = cj.ConvertPlayerScore(20)
PLAYER_SCORE_UNIT_TOTAL = cj.ConvertPlayerScore(21)
PLAYER_SCORE_HERO_TOTAL = cj.ConvertPlayerScore(22)
PLAYER_SCORE_RESOURCE_TOTAL = cj.ConvertPlayerScore(23)
PLAYER_SCORE_TOTAL = cj.ConvertPlayerScore(24)

-- 事件
EVENT_PLAYER_STATE_LIMIT = cj.ConvertPlayerEvent(11)
EVENT_PLAYER_ALLIANCE_CHANGED = cj.ConvertPlayerEvent(12)
EVENT_PLAYER_DEFEAT = cj.ConvertPlayerEvent(13)
EVENT_PLAYER_VICTORY = cj.ConvertPlayerEvent(14)
EVENT_PLAYER_LEAVE = cj.ConvertPlayerEvent(15)
EVENT_PLAYER_CHAT = cj.ConvertPlayerEvent(16)
EVENT_PLAYER_END_CINEMATIC = cj.ConvertPlayerEvent(17)

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

EVENT_PLAYER_ARROW_LEFT_DOWN = cj.ConvertPlayerEvent(261)
EVENT_PLAYER_ARROW_LEFT_UP = cj.ConvertPlayerEvent(262)
EVENT_PLAYER_ARROW_RIGHT_DOWN = cj.ConvertPlayerEvent(263)
EVENT_PLAYER_ARROW_RIGHT_UP = cj.ConvertPlayerEvent(264)
EVENT_PLAYER_ARROW_DOWN_DOWN = cj.ConvertPlayerEvent(265)
EVENT_PLAYER_ARROW_DOWN_UP = cj.ConvertPlayerEvent(266)
EVENT_PLAYER_ARROW_UP_DOWN = cj.ConvertPlayerEvent(267)
EVENT_PLAYER_ARROW_UP_UP = cj.ConvertPlayerEvent(268)

EVENT_PLAYER_UNIT_SELL = cj.ConvertPlayerUnitEvent(269)
EVENT_PLAYER_UNIT_CHANGE_OWNER = cj.ConvertPlayerUnitEvent(270)
EVENT_PLAYER_UNIT_SELL_ITEM = cj.ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_SPELL_CHANNEL = cj.ConvertPlayerUnitEvent(272)
EVENT_PLAYER_UNIT_SPELL_CAST = cj.ConvertPlayerUnitEvent(273)
EVENT_PLAYER_UNIT_SPELL_EFFECT = cj.ConvertPlayerUnitEvent(274)
EVENT_PLAYER_UNIT_SPELL_FINISH = cj.ConvertPlayerUnitEvent(275)
EVENT_PLAYER_UNIT_SPELL_ENDCAST = cj.ConvertPlayerUnitEvent(276)
EVENT_PLAYER_UNIT_PAWN_ITEM = cj.ConvertPlayerUnitEvent(277)
```
## JassCommon

```lua
cj.AddPlayerTechResearched = JassCommon["AddPlayerTechResearched"]
cj.CachePlayerHeroData = JassCommon["CachePlayerHeroData"]

cj.ConvertPlayerColor = JassCommon["ConvertPlayerColor"]
cj.ConvertPlayerEvent = JassCommon["ConvertPlayerEvent"]
cj.ConvertPlayerGameResult = JassCommon["ConvertPlayerGameResult"]
cj.ConvertPlayerScore = JassCommon["ConvertPlayerScore"]
cj.ConvertPlayerSlotState = JassCommon["ConvertPlayerSlotState"]
cj.ConvertPlayerState = JassCommon["ConvertPlayerState"]
cj.ConvertPlayerUnitEvent = JassCommon["ConvertPlayerUnitEvent"]

cj.CripplePlayer = JassCommon["CripplePlayer"]

cj.DisplayTextToPlayer = JassCommon["DisplayTextToPlayer"]
cj.DisplayTimedTextFromPlayer = JassCommon["DisplayTimedTextFromPlayer"]
cj.DisplayTimedTextToPlayer = JassCommon["DisplayTimedTextToPlayer"]

cj.ForceAddPlayer = JassCommon["ForceAddPlayer"]

cj.ForceEnumPlayers = JassCommon["ForceEnumPlayers"]
cj.ForceEnumPlayersCounted = JassCommon["ForceEnumPlayersCounted"]
cj.ForcePlayerStartLocation = JassCommon["ForcePlayerStartLocation"]
cj.ForceRemovePlayer = JassCommon["ForceRemovePlayer"]

cj.GetEnumPlayer = JassCommon["GetEnumPlayer"]

cj.GetEventDetectingPlayer = JassCommon["GetEventDetectingPlayer"]
cj.GetEventPlayerChatString = JassCommon["GetEventPlayerChatString"]
cj.GetEventPlayerChatStringMatched = JassCommon["GetEventPlayerChatStringMatched"]
cj.GetEventPlayerState = JassCommon["GetEventPlayerState"]

cj.GetFilterPlayer = JassCommon["GetFilterPlayer"]

cj.GetItemPlayer = JassCommon["GetItemPlayer"]

cj.GetLocalPlayer = JassCommon["GetLocalPlayer"]

cj.GetOwningPlayer = JassCommon["GetOwningPlayer"]
cj.GetPlayerAlliance = JassCommon["GetPlayerAlliance"]
cj.GetPlayerColor = JassCommon["GetPlayerColor"]
cj.GetPlayerController = JassCommon["GetPlayerController"]
cj.GetPlayerHandicap = JassCommon["GetPlayerHandicap"]
cj.GetPlayerHandicapXP = JassCommon["GetPlayerHandicapXP"]
cj.GetPlayerId = JassCommon["GetPlayerId"]
cj.GetPlayerName = JassCommon["GetPlayerName"]
cj.GetPlayerRace = JassCommon["GetPlayerRace"]
cj.GetPlayerScore = JassCommon["GetPlayerScore"]
cj.GetPlayerSelectable = JassCommon["GetPlayerSelectable"]
cj.GetPlayerSlotState = JassCommon["GetPlayerSlotState"]
cj.GetPlayerStartLocation = JassCommon["GetPlayerStartLocation"]
cj.GetPlayerState = JassCommon["GetPlayerState"]
cj.GetPlayerStructureCount = JassCommon["GetPlayerStructureCount"]
cj.GetPlayerTaxRate = JassCommon["GetPlayerTaxRate"]
cj.GetPlayerTeam = JassCommon["GetPlayerTeam"]
cj.GetPlayerTechCount = JassCommon["GetPlayerTechCount"]
cj.GetPlayerTechMaxAllowed = JassCommon["GetPlayerTechMaxAllowed"]
cj.GetPlayerTechResearched = JassCommon["GetPlayerTechResearched"]
cj.GetPlayerTypedUnitCount = JassCommon["GetPlayerTypedUnitCount"]
cj.GetPlayerUnitCount = JassCommon["GetPlayerUnitCount"]
cj.GetPlayers = JassCommon["GetPlayers"]

cj.GetTournamentFinishNowPlayer = JassCommon["GetTournamentFinishNowPlayer"]

cj.GetTriggerPlayer = JassCommon["GetTriggerPlayer"]

cj.GetWinningPlayer = JassCommon["GetWinningPlayer"]
cj.GroupEnumUnitsOfPlayer = JassCommon["GroupEnumUnitsOfPlayer"]

cj.IsFoggedToPlayer = JassCommon["IsFoggedToPlayer"]

cj.IsLocationFoggedToPlayer = JassCommon["IsLocationFoggedToPlayer"]

cj.IsLocationMaskedToPlayer = JassCommon["IsLocationMaskedToPlayer"]
cj.IsLocationVisibleToPlayer = JassCommon["IsLocationVisibleToPlayer"]

cj.IsMaskedToPlayer = JassCommon["IsMaskedToPlayer"]

cj.IsPlayerAlly = JassCommon["IsPlayerAlly"]
cj.IsPlayerEnemy = JassCommon["IsPlayerEnemy"]
cj.IsPlayerInForce = JassCommon["IsPlayerInForce"]
cj.IsPlayerObserver = JassCommon["IsPlayerObserver"]
cj.IsPlayerRacePrefSet = JassCommon["IsPlayerRacePrefSet"]

cj.IsUnitOwnedByPlayer = JassCommon["IsUnitOwnedByPlayer"]
cj.IsVisibleToPlayer = JassCommon["IsVisibleToPlayer"]

cj.LeaderboardGetPlayerIndex = JassCommon["LeaderboardGetPlayerIndex"]
cj.LeaderboardHasPlayerItem = JassCommon["LeaderboardHasPlayerItem"]
cj.LeaderboardRemovePlayerItem = JassCommon["LeaderboardRemovePlayerItem"]
cj.LeaderboardSortItemsByPlayer = JassCommon["LeaderboardSortItemsByPlayer"]
cj.LoadPlayerHandle = JassCommon["LoadPlayerHandle"]

cj.Player = JassCommon["Player"]
cj.PlayerGetLeaderboard = JassCommon["PlayerGetLeaderboard"]
cj.PlayerSetLeaderboard = JassCommon["PlayerSetLeaderboard"]

cj.RemovePlayer = JassCommon["RemovePlayer"]

cj.SavePlayerHandle = JassCommon["SavePlayerHandle"]
cj.SetItemPlayer = JassCommon["SetItemPlayer"]

cj.SetPlayerAbilityAvailable = JassCommon["SetPlayerAbilityAvailable"]
cj.SetPlayerAlliance = JassCommon["SetPlayerAlliance"]
cj.SetPlayerColor = JassCommon["SetPlayerColor"]
cj.SetPlayerController = JassCommon["SetPlayerController"]
cj.SetPlayerHandicap = JassCommon["SetPlayerHandicap"]
cj.SetPlayerHandicapXP = JassCommon["SetPlayerHandicapXP"]
cj.SetPlayerName = JassCommon["SetPlayerName"]
cj.SetPlayerOnScoreScreen = JassCommon["SetPlayerOnScoreScreen"]
cj.SetPlayerRacePreference = JassCommon["SetPlayerRacePreference"]
cj.SetPlayerRaceSelectable = JassCommon["SetPlayerRaceSelectable"]
cj.SetPlayerStartLocation = JassCommon["SetPlayerStartLocation"]
cj.SetPlayerState = JassCommon["SetPlayerState"]
cj.SetPlayerTaxRate = JassCommon["SetPlayerTaxRate"]
cj.SetPlayerTeam = JassCommon["SetPlayerTeam"]
cj.SetPlayerTechMaxAllowed = JassCommon["SetPlayerTechMaxAllowed"]
cj.SetPlayerTechResearched = JassCommon["SetPlayerTechResearched"]
cj.SetPlayerUnitsOwner = JassCommon["SetPlayerUnitsOwner"]
cj.SetPlayers = JassCommon["SetPlayers"]

cj.TriggerRegisterPlayerAllianceChange = JassCommon["TriggerRegisterPlayerAllianceChange"]
cj.TriggerRegisterPlayerChatEvent = JassCommon["TriggerRegisterPlayerChatEvent"]
cj.TriggerRegisterPlayerEvent = JassCommon["TriggerRegisterPlayerEvent"]
cj.TriggerRegisterPlayerStateEvent = JassCommon["TriggerRegisterPlayerStateEvent"]
cj.TriggerRegisterPlayerUnitEvent = JassCommon["TriggerRegisterPlayerUnitEvent"]
```
## JassJapi
```
DzGetPlayerName
DzGetPlayerSelectedHero
DzGetPlayerInitGold
DzDotaInfo_IsPlayerRandom
DzAPI_Map_Ladder_SetPlayerStat
DzPlatform_HasGameOver_Player
DzAPI_Map_UpdatePlayerHero
DzGetTriggerUIEventPlayer
DzGetTriggerKeyPlayer
DzGetTriggerSyncPlayer
```

## 常用
1. 玩家id
- 从0开始到最大玩家数量 对于玩家槽
2. 玩家id与玩家Obj
```
constant native GetLocalPlayer () returns player
constant native Player (integer number) returns player
```
3. 设置与读取玩家信息