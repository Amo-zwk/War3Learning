## 事件触发
- Trigger触发器 事件的处理
- 魔兽的事件回调机制   
- 图形界面的重要交互方式
    - 当点击一个按钮时 执行某个动作
    - 点击按钮就是事件(触发) 
    - 执行的动作就是作者自己写的逻辑
- 游戏里面的重要交互方式
    - 当单位拾取到物品 执行某个动作
    - 拾取物品就是事件(触发)
    - 执行的动作就是作者自己写的逻辑 (物品自动合成,物品自动使用)
- 魔兽中的触发逻辑
    - 触发器            
        - `CreateTrigger()`                     
        - 创建一个触发器
    - [触发器过滤条件]     
        - `TriggerAddCondition(function()end)`  
        - 返回boolean的参数 一般不用
    - 触发动作           
        - `TriggerAddAction(function()end)`    
        - 注册触发的执行逻辑
    - 注册触发器到事件    
        - `TriggerRegister[XX]()`              
        - 注册触发器到事件

## 事件类型
- 魔兽中可以注册的事件类型
1. GameEvent        TriggerRegisterGameEvent
2. PlayerEvent      TriggerRegisterPlayerEvent
3. PlayerUnitEvent  TriggerRegisterPlayerUnitEvent  所有单位
4. UnitEvent        TriggerRegisterUnitEvent        某个单位
5. UIEvent          TriggerRegisterDialogEvent



- GameEvent
```lua
EVENT_GAME_BUILD_SUBMENU 游戏事件-创建子菜单 
EVENT_GAME_END_LEVEL 游戏事件-游戏本关结束 
EVENT_GAME_ENTER_REGION 游戏事件-进入区域 
EVENT_GAME_LEAVE_REGION 游戏事件-离开区域 
EVENT_GAME_LOADED 游戏事件-游戏装载完毕 
EVENT_GAME_SAVE 游戏事件-储存 
EVENT_GAME_SHOW_SKILL 游戏事件-显示技能 
EVENT_GAME_STATE_LIMIT 游戏事件-游戏状态限制 
EVENT_GAME_TIMER_EXPIRED 游戏事件-游戏超时 
EVENT_GAME_TOURNAMENT_FINISH_NOW 游戏事件-比赛完成 
EVENT_GAME_TOURNAMENT_FINISH_SOON 游戏事件-比赛即将完成 
EVENT_GAME_TRACKABLE_HIT 游戏事件-可跟踪打击 
EVENT_GAME_TRACKABLE_TRACK 游戏事件-可跟踪跟踪 
EVENT_GAME_VARIABLE_LIMIT 游戏事件-游戏变量限制 
EVENT_GAME_VICTORY 游戏事件-游戏胜利 
```




- PlayerEvent
```lua

EVENT_PLAYER_ALLIANCE_CHANGED 玩家事件-盟友设置变化 
EVENT_PLAYER_ARROW_DOWN_DOWN 玩家事件-按下键 
EVENT_PLAYER_ARROW_DOWN_UP 玩家事件-释放下键 
EVENT_PLAYER_ARROW_LEFT_DOWN 玩家事件-按左键 
EVENT_PLAYER_ARROW_LEFT_UP 玩家事件-释放左键 
EVENT_PLAYER_ARROW_RIGHT_DOWN 玩家事件-按右键 
EVENT_PLAYER_ARROW_RIGHT_UP 玩家事件-释放右键 
EVENT_PLAYER_ARROW_UP_DOWN 玩家事件-按上键 
EVENT_PLAYER_ARROW_UP_UP 玩家事件-释放上键
 
EVENT_PLAYER_CHAT 玩家事件-聊天 
EVENT_PLAYER_DEFEAT 玩家事件-失败 
EVENT_PLAYER_END_CINEMATIC 玩家事件-结束电影 
EVENT_PLAYER_LEAVE 玩家事件-离开 
EVENT_PLAYER_STATE_LIMIT 玩家事件-状态限制 
EVENT_PLAYER_VICTORY 玩家事件-胜利 
```

- PlayerUnitEvent 玩家的所有单位

```lua
EVENT_PLAYER_UNIT_ATTACKED 玩家单位事件-被攻击的 
EVENT_PLAYER_UNIT_CHANGE_OWNER 玩家单位事件-变化拥有者 
EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL 玩家单位事件-取消建造 
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH 玩家单位事件-完成建造 
EVENT_PLAYER_UNIT_CONSTRUCT_START 玩家单位事件-开始建造 
EVENT_PLAYER_UNIT_DEATH 玩家单位事件-死亡 
EVENT_PLAYER_UNIT_DECAY 玩家单位事件-衰退 
EVENT_PLAYER_UNIT_DESELECTED 玩家单位事件-取消选择 
EVENT_PLAYER_UNIT_DETECTED 玩家单位事件-被发现 
EVENT_PLAYER_UNIT_DROP_ITEM 玩家单位事件-丢失一件物品 
EVENT_PLAYER_UNIT_HIDDEN 玩家单位事件-隐藏 
EVENT_PLAYER_UNIT_ISSUED_ORDER 玩家单位事件-发布一个无目标的 
EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER 玩家单位事件-发布一个锁定一个 
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER 玩家单位事件-发布一个目标指令 
EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER 玩家单位事件-发布一个锁定一个 
EVENT_PLAYER_UNIT_LOADED 玩家单位事件-装进了传送门 
EVENT_PLAYER_UNIT_PAWN_ITEM 玩家单位事件-抵押物品(到商店) 
EVENT_PLAYER_UNIT_PICKUP_ITEM 玩家单位事件-获得一件物品 
EVENT_PLAYER_UNIT_RESCUED 玩家单位事件-被营救了 
EVENT_PLAYER_UNIT_RESEARCH_CANCEL 玩家单位事件-取消研究 
EVENT_PLAYER_UNIT_RESEARCH_FINISH 玩家单位事件-完成研究 
EVENT_PLAYER_UNIT_RESEARCH_START 玩家单位事件-开始研究 
EVENT_PLAYER_UNIT_SELECTED 玩家单位事件-被选择 
EVENT_PLAYER_UNIT_SELL 玩家单位事件-贩卖一个单位 
EVENT_PLAYER_UNIT_SELL_ITEM 玩家单位事件-购买物品(从商店) 
EVENT_PLAYER_UNIT_SPELL_CAST 玩家单位事件-开始施放一种技能 
EVENT_PLAYER_UNIT_SPELL_CHANNEL 玩家单位事件-开始一种持续性技 
EVENT_PLAYER_UNIT_SPELL_EFFECT 玩家单位事件-开始一种技能的效 
EVENT_PLAYER_UNIT_SPELL_ENDCAST 玩家单位事件-停止施放一种技能 
EVENT_PLAYER_UNIT_SPELL_FINISH 玩家单位事件-施放技能结束 
EVENT_PLAYER_UNIT_SUMMON 玩家单位事件-产生一个召唤单位 
EVENT_PLAYER_UNIT_TRAIN_CANCEL 玩家单位事件-取消训练一个单位 
EVENT_PLAYER_UNIT_TRAIN_FINISH 玩家单位事件-完成训练一个单位 
EVENT_PLAYER_UNIT_TRAIN_START 玩家单位事件-开始训练一个单位 
EVENT_PLAYER_UNIT_UPGRADE_CANCEL 玩家单位事件-取消升级 
EVENT_PLAYER_UNIT_UPGRADE_FINISH 玩家单位事件-完成升级 
EVENT_PLAYER_UNIT_UPGRADE_START 玩家单位事件-开始升级 
EVENT_PLAYER_UNIT_USE_ITEM 玩家单位事件-使用一件物品 
```

- UnitEvent 某个单位事件
```lua

EVENT_UNIT_ACQUIRED_TARGET 单位事件-获得一个目标 
EVENT_UNIT_ATTACKED 单位事件-被攻击 
EVENT_UNIT_CHANGE_OWNER 单位事件-变化拥有者 
EVENT_UNIT_CONSTRUCT_CANCEL 单位事件-取消建造 
EVENT_UNIT_CONSTRUCT_FINISH 单位事件-完成建造 
EVENT_UNIT_DAMAGED 单位事件-接受伤害 
EVENT_UNIT_DEATH 单位事件-死亡 
EVENT_UNIT_DECAY 单位事件-衰退 
EVENT_UNIT_DESELECTED 单位事件-取消选择 
EVENT_UNIT_DETECTED 单位事件-被发现 
EVENT_UNIT_DROP_ITEM 单位事件-丢失一件物品 
EVENT_UNIT_HERO_LEVEL 英雄单位事件-提升一个等级 
EVENT_UNIT_HERO_REVIVABLE 英雄单位事件-变得可重生的 
EVENT_UNIT_HERO_REVIVE_CANCEL 英雄单位事件-取消重生 
EVENT_UNIT_HERO_REVIVE_FINISH 英雄单位事件-完成重生 
EVENT_UNIT_HERO_REVIVE_START 英雄单位事件-开始重生 
EVENT_UNIT_HERO_SKILL 英雄单位事件-学习一项技能 
EVENT_UNIT_HIDDEN 单位事件-隐藏 
EVENT_UNIT_ISSUED_ORDER 单位事件-发布一个无目标的指令 
EVENT_UNIT_ISSUED_POINT_ORDER 单位事件-发布一个锁定一个点的 
EVENT_UNIT_ISSUED_TARGET_ORDER 单位事件-发布一个锁定目标的指 
EVENT_UNIT_LOADED 单位事件-装进了传送门 
EVENT_UNIT_PAWN_ITEM 单位事件-抵押物品(到商店) 
EVENT_UNIT_PICKUP_ITEM 单位事件-获得一件物品 
EVENT_UNIT_RESCUED 单位事件-被营救 
EVENT_UNIT_RESEARCH_CANCEL 单位事件-取消研究 
EVENT_UNIT_RESEARCH_FINISH 单位事件-完成研究 
EVENT_UNIT_RESEARCH_START 单位事件-开始研究 
EVENT_UNIT_SELECTED 单位事件-被选择 
EVENT_UNIT_SELL 单位事件-贩卖一个单位 
EVENT_UNIT_SELL_ITEM 单位事件-购买物品(从商店) 
EVENT_UNIT_SPELL_CAST 单位事件-开始施放一种技能 
EVENT_UNIT_SPELL_CHANNEL 单位事件-开始一种持续性技能 
EVENT_UNIT_SPELL_EFFECT 单位事件-开始一种技能的效果 
EVENT_UNIT_SPELL_ENDCAST 单位事件-停止施放一种技能 
EVENT_UNIT_SPELL_FINISH 单位事件-施放技能结束 
EVENT_UNIT_STATE_LIMIT 单位事件-状态限制 
EVENT_UNIT_SUMMON 单位事件-产生一个召唤单位 
EVENT_UNIT_TARGET_IN_RANGE 单位事件-注意范围内的一个目标 
EVENT_UNIT_TRAIN_CANCEL 单位事件-取消训练一个单位 
EVENT_UNIT_TRAIN_FINISH 单位事件-完成训练一个单位 
EVENT_UNIT_TRAIN_START 单位事件-开始训练一个单位 
EVENT_UNIT_UPGRADE_CANCEL 单位事件-取消升级 
EVENT_UNIT_UPGRADE_FINISH 单位事件-完成升级 
EVENT_UNIT_UPGRADE_START 单位事件-开始升级 
EVENT_UNIT_USE_ITEM 单位事件-使用一件物品 
```

- UIEvent
```lua
EVENT_DIALOG_BUTTON_CLICK 事件-对话按钮点击 

EVENT_DIALOG_CLICK 事件-对话点击 

MOUSE_ORDER_CLICK = 1
MOUSE_ORDER_ENTER = 2
MOUSE_ORDER_LEAVE = 3
MOUSE_ORDER_RELEASE = 4
MOUSE_ORDER_SCROLL = 6
MOUSE_ORDER_DOUBLE_CLICK = 12
```