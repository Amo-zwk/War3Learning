local jc = require "jass.common"

_F = {} 

---@type fun(:string,):integer
_F.AbilityId = jc["AbilityId"]

---@type fun(abilityId:integer,):string
_F.AbilityId2String = jc["AbilityId2String"]

---反余弦(弧度)[R]
---Acos(${数值})
---采用弧度制计算.返回弧度取值0—π.
---@type fun(x:real,):real
_F.Acos = jc["Acos"]

---增加经验值[R]
---增加${Hero}${Quantity}点经验值,${Show/Hide}升级动画
---经验值不能倒退.
---@type fun(whichHero:unit,xpToAdd:integer,showEyeCandy:boolean,):nothing
_F.AddHeroXP = jc["AddHeroXP"]

---@type fun(whichWidget:widget,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.AddIndicator = jc["AddIndicator"]

---添加物品(所有市场)
---添加${物品类型}到所有市场并设置库存量:${Count}最大库存量:${Max}
---影响所有拥有'出售物品'技能的单位.
---@type fun(itemId:integer,currentStock:integer,stockMax:integer,):nothing
_F.AddItemToAllStock = jc["AddItemToAllStock"]

---@type fun(whichUnit:unit,itemId:integer,currentStock:integer,stockMax:integer,):nothing
_F.AddItemToStock = jc["AddItemToStock"]

---新建闪电效果[R]
---新建闪电效果:${闪电效果}(${Boolean}检查可见性)起始点:(${X},${Y})终结点:(${X},${Y})
---会创建闪电效果.允许检查可见性则在起始点和终结点都不可见时将不创建闪电效果.
---@type fun(codeName:string,checkVisibility:boolean,x1:real,y1:real,x2:real,y2:real,):lightning
_F.AddLightning = jc["AddLightning"]

---新建闪电效果(指定Z轴)[R]
---新建闪电效果:${闪电效果}(${Boolean}检查可见性)起始点:(${X},${Y},${Z})终结点:(${X},${Y},${Z})
---会创建闪电效果.允许检查可见性则在起始点和终结点都不可见时将不创建闪电效果.
---@type fun(codeName:string,checkVisibility:boolean,x1:real,y1:real,z1:real,x2:real,y2:real,z2:real,):lightning
_F.AddLightningEx = jc["AddLightningEx"]

---增加科技等级
---增加${玩家}的${科技}科技${整数}级
---科技等级不能倒退。
---@type fun(whichPlayer:player,techid:integer,levels:integer,):nothing
_F.AddPlayerTechResearched = jc["AddPlayerTechResearched"]

---@type fun(whichUnit:unit,amount:integer,):nothing
_F.AddResourceAmount = jc["AddResourceAmount"]

---新建特效(创建到坐标)[R]
---新建特效${ModelFile}在(${X},${Y})处
---会创建特效.
---@type fun(modelName:string,x:real,y:real,):effect
_F.AddSpecialEffect = jc["AddSpecialEffect"]

---新建特效(创建到点)[R]
---新建特效${ModelFile}在${指定点}处
---会创建特效.
---@type fun(modelName:string,where:location,):effect
_F.AddSpecialEffectLoc = jc["AddSpecialEffectLoc"]

---新建特效(创建到单位)[R]
---新建特效${ModelFile}并绑定到${单位}的${AttachmentPoint}附加点上
---会创建特效.
---@type fun(modelName:string,targetWidget:widget,attachPointName:string,):effect
_F.AddSpecialEffectTarget = jc["AddSpecialEffectTarget"]

---@type fun(abilityString:string,t:effecttype,x:real,y:real,):effect
_F.AddSpellEffect = jc["AddSpellEffect"]

---新建特效(指定技能，创建到坐标)[R]
---${技能}的${EffectType},创建到坐标(${X},${Y})
---会创建特效.
---@type fun(abilityId:integer,t:effecttype,x:real,y:real,):effect
_F.AddSpellEffectById = jc["AddSpellEffectById"]

---新建特效(指定技能，创建到点)[R]
---${技能}的${EffectType},创建到${指定点}
---会创建特效.
---@type fun(abilityId:integer,t:effecttype,where:location,):effect
_F.AddSpellEffectByIdLoc = jc["AddSpellEffectByIdLoc"]

---@type fun(abilityString:string,t:effecttype,where:location,):effect
_F.AddSpellEffectLoc = jc["AddSpellEffectLoc"]

---@type fun(modelName:string,t:effecttype,targetWidget:widget,attachPoint:string,):effect
_F.AddSpellEffectTarget = jc["AddSpellEffectTarget"]

---新建特效(指定技能，创建到单位)[R]
---${技能}的${EffectType},绑定到${单位}的${String}附加点
---会创建特效.
---@type fun(abilityId:integer,t:effecttype,targetWidget:widget,attachPoint:string,):effect
_F.AddSpellEffectTargetById = jc["AddSpellEffectTargetById"]

---添加/删除单位动画附加名[R]
---给${单位}附加动作${Tag},状态为${Add/Remove}
---比如恶魔猎手添加'alternate'会显示为恶魔形态;农民添加'gold'则为背负黄金形态.
---@type fun(whichUnit:unit,animProperties:string,add:boolean,):nothing
_F.AddUnitAnimationProperties = jc["AddUnitAnimationProperties"]

---添加单位(所有市场)
---添加${单位类型}到所有市场并设置库存量:${Count}最大库存量:${Max}
---影响所有拥有'出售单位'技能的单位.
---@type fun(unitId:integer,currentStock:integer,stockMax:integer,):nothing
_F.AddUnitToAllStock = jc["AddUnitToAllStock"]

---@type fun(whichUnit:unit,unitId:integer,currentStock:integer,stockMax:integer,):nothing
_F.AddUnitToStock = jc["AddUnitToStock"]

---新建天气效果[R]
---新建的在${矩形区域}的天气效果:${WeatherId}
---会创建天气效果.
---@type fun(where:rect,effectID:integer,):weathereffect
_F.AddWeatherEffect = jc["AddWeatherEffect"]

---@type fun(whichField:camerafield,offset:real,duration:real,):nothing
_F.AdjustCameraField = jc["AdjustCameraField"]

---@type fun(operandA:boolexpr,operandB:boolexpr,):boolexpr
_F.And = jc["And"]

---反正弦(弧度)[R]
---Asin(${数值})
---采用弧度制计算.返回弧度取值-π/2—π/2.
---@type fun(y:real,):real
_F.Asin = jc["Asin"]

---反正切(弧度)[R]
---Atan(${数值})
---采用弧度制计算.返回弧度取值-π/2—π/2.
---@type fun(x:real,):real
_F.Atan = jc["Atan"]

---反正切(Y:X)(弧度)[R]
---Atan(${Y}:${X})
---采用弧度制计算.返回弧度取值-π/2—π/2.
---@type fun(y:real,x:real,):real
_F.Atan2 = jc["Atan2"]

---@type fun(soundHandle:sound,whichUnit:unit,):nothing
_F.AttachSoundToUnit = jc["AttachSoundToUnit"]

---@type fun(whichPlayer:player,):nothing
_F.CachePlayerHeroData = jc["CachePlayerHeroData"]

---@type fun(factor:real,):nothing
_F.CameraSetSmoothingFactor = jc["CameraSetSmoothingFactor"]

---@type fun(mag:real,velocity:real,):nothing
_F.CameraSetSourceNoise = jc["CameraSetSourceNoise"]

---摇晃镜头源(所有玩家)[R]
---摇晃玩家的镜头源,摇晃幅度:${Magnitude}速率:${Velocity}摇晃方式:${方式}
---使用'镜头-重置镜头'或设置摇晃幅度和速率为0来停止摇晃.
---@type fun(mag:real,velocity:real,vertOnly:boolean,):nothing
_F.CameraSetSourceNoiseEx = jc["CameraSetSourceNoiseEx"]

---@type fun(mag:real,velocity:real,):nothing
_F.CameraSetTargetNoise = jc["CameraSetTargetNoise"]

---摇晃镜头目标(所有玩家)[R]
---摇晃玩家的镜头源,摇晃幅度:${Magnitude}速率:${Velocity}摇晃方式:${方式}
---使用'镜头-重置镜头'或设置摇晃幅度和速率为0来停止摇晃.
---@type fun(mag:real,velocity:real,vertOnly:boolean,):nothing
_F.CameraSetTargetNoiseEx = jc["CameraSetTargetNoiseEx"]

---@type fun(whichSetup:camerasetup,doPan:boolean,panTimed:boolean,):nothing
_F.CameraSetupApply = jc["CameraSetupApply"]

---应用镜头(所有玩家)(限时)[R]
---将${镜头}应用方式设置为${ApplyMethod},持续${Time}秒
---@type fun(whichSetup:camerasetup,doPan:boolean,forceDuration:real,):nothing
_F.CameraSetupApplyForceDuration = jc["CameraSetupApplyForceDuration"]

---@type fun(whichSetup:camerasetup,zDestOffset:real,forceDuration:real,):nothing
_F.CameraSetupApplyForceDurationWithZ = jc["CameraSetupApplyForceDurationWithZ"]

---@type fun(whichSetup:camerasetup,zDestOffset:real,):nothing
_F.CameraSetupApplyWithZ = jc["CameraSetupApplyWithZ"]

---镜头目标点
---${镜头}的目标点
---会创建点.
---@type fun(whichSetup:camerasetup,):location
_F.CameraSetupGetDestPositionLoc = jc["CameraSetupGetDestPositionLoc"]

---@type fun(whichSetup:camerasetup,):real
_F.CameraSetupGetDestPositionX = jc["CameraSetupGetDestPositionX"]

---@type fun(whichSetup:camerasetup,):real
_F.CameraSetupGetDestPositionY = jc["CameraSetupGetDestPositionY"]

---镜头属性(指定镜头)[R]
---${镜头}的${CameraField}
---@type fun(whichSetup:camerasetup,whichField:camerafield,):real
_F.CameraSetupGetField = jc["CameraSetupGetField"]

---@type fun(whichSetup:camerasetup,x:real,y:real,duration:real,):nothing
_F.CameraSetupSetDestPosition = jc["CameraSetupSetDestPosition"]

---@type fun(whichSetup:camerasetup,whichField:camerafield,value:real,duration:real,):nothing
_F.CameraSetupSetField = jc["CameraSetupSetField"]

---切换关卡[R]
---切换到关卡:${Filename}(${Show/Skip}计分屏)
---@type fun(newLevel:string,doScoreScreen:boolean,):nothing
_F.ChangeLevel = jc["ChangeLevel"]

---输入作弊码[R]
---输入作弊码:${String}
---作弊码只在单机有效.
---@type fun(cheatStr:string,):nothing
_F.Cheat = jc["Cheat"]

---@type fun(level:integer,):integer
_F.ChooseRandomCreep = jc["ChooseRandomCreep"]

---@type fun(level:integer,):integer
_F.ChooseRandomItem = jc["ChooseRandomItem"]

---@type fun(whichType:itemtype,level:integer,):integer
_F.ChooseRandomItemEx = jc["ChooseRandomItemEx"]

---@type fun():integer
_F.ChooseRandomNPBuilding = jc["ChooseRandomNPBuilding"]

---@type fun():nothing
_F.ClearMapMusic = jc["ClearMapMusic"]

---清空选择(所有玩家)
---清空所有玩家的选择
---使玩家取消选择所有已选单位.
---@type fun():nothing
_F.ClearSelection = jc["ClearSelection"]

---清空文本信息(所有玩家)[R]
---清空玩家屏幕上的文本信息
---@type fun():nothing
_F.ClearTextMessages = jc["ClearTextMessages"]

---发送AI命令
---对${Player}发送AI命令:(${命令},${数据})
---发送的AI命令将被AI脚本所使用.
---@type fun(num:player,command:integer,data:integer,):nothing
_F.CommandAI = jc["CommandAI"]

---@type fun(func:code,):conditionfunc
_F.Condition = jc["Condition"]

---@type fun(i:integer,):aidifficulty
_F.ConvertAIDifficulty = jc["ConvertAIDifficulty"]

---@type fun(i:integer,):alliancetype
_F.ConvertAllianceType = jc["ConvertAllianceType"]

---@type fun(i:integer,):attacktype
_F.ConvertAttackType = jc["ConvertAttackType"]

---@type fun(i:integer,):blendmode
_F.ConvertBlendMode = jc["ConvertBlendMode"]

---@type fun(i:integer,):camerafield
_F.ConvertCameraField = jc["ConvertCameraField"]

---@type fun(i:integer,):damagetype
_F.ConvertDamageType = jc["ConvertDamageType"]

---@type fun(i:integer,):dialogevent
_F.ConvertDialogEvent = jc["ConvertDialogEvent"]

---@type fun(i:integer,):effecttype
_F.ConvertEffectType = jc["ConvertEffectType"]

---@type fun(i:integer,):fgamestate
_F.ConvertFGameState = jc["ConvertFGameState"]

---@type fun(i:integer,):fogstate
_F.ConvertFogState = jc["ConvertFogState"]

---@type fun(i:integer,):gamedifficulty
_F.ConvertGameDifficulty = jc["ConvertGameDifficulty"]

---@type fun(i:integer,):gameevent
_F.ConvertGameEvent = jc["ConvertGameEvent"]

---@type fun(i:integer,):gamespeed
_F.ConvertGameSpeed = jc["ConvertGameSpeed"]

---@type fun(i:integer,):gametype
_F.ConvertGameType = jc["ConvertGameType"]

---@type fun(i:integer,):igamestate
_F.ConvertIGameState = jc["ConvertIGameState"]

---@type fun(i:integer,):itemtype
_F.ConvertItemType = jc["ConvertItemType"]

---@type fun(i:integer,):limitop
_F.ConvertLimitOp = jc["ConvertLimitOp"]

---@type fun(i:integer,):mapcontrol
_F.ConvertMapControl = jc["ConvertMapControl"]

---@type fun(i:integer,):mapdensity
_F.ConvertMapDensity = jc["ConvertMapDensity"]

---@type fun(i:integer,):mapflag
_F.ConvertMapFlag = jc["ConvertMapFlag"]

---@type fun(i:integer,):mapsetting
_F.ConvertMapSetting = jc["ConvertMapSetting"]

---@type fun(i:integer,):mapvisibility
_F.ConvertMapVisibility = jc["ConvertMapVisibility"]

---@type fun(i:integer,):pathingtype
_F.ConvertPathingType = jc["ConvertPathingType"]

---@type fun(i:integer,):placement
_F.ConvertPlacement = jc["ConvertPlacement"]

---@type fun(i:integer,):playercolor
_F.ConvertPlayerColor = jc["ConvertPlayerColor"]

---@type fun(i:integer,):playerevent
_F.ConvertPlayerEvent = jc["ConvertPlayerEvent"]

---@type fun(i:integer,):playergameresult
_F.ConvertPlayerGameResult = jc["ConvertPlayerGameResult"]

---@type fun(i:integer,):playerscore
_F.ConvertPlayerScore = jc["ConvertPlayerScore"]

---@type fun(i:integer,):playerslotstate
_F.ConvertPlayerSlotState = jc["ConvertPlayerSlotState"]

---@type fun(i:integer,):playerstate
_F.ConvertPlayerState = jc["ConvertPlayerState"]

---@type fun(i:integer,):playerunitevent
_F.ConvertPlayerUnitEvent = jc["ConvertPlayerUnitEvent"]

---@type fun(i:integer,):race
_F.ConvertRace = jc["ConvertRace"]

---@type fun(i:integer,):racepreference
_F.ConvertRacePref = jc["ConvertRacePref"]

---@type fun(i:integer,):raritycontrol
_F.ConvertRarityControl = jc["ConvertRarityControl"]

---@type fun(i:integer,):soundtype
_F.ConvertSoundType = jc["ConvertSoundType"]

---@type fun(i:integer,):startlocprio
_F.ConvertStartLocPrio = jc["ConvertStartLocPrio"]

---@type fun(i:integer,):texmapflags
_F.ConvertTexMapFlags = jc["ConvertTexMapFlags"]

---@type fun(i:integer,):unitevent
_F.ConvertUnitEvent = jc["ConvertUnitEvent"]

---@type fun(i:integer,):unitstate
_F.ConvertUnitState = jc["ConvertUnitState"]

---@type fun(i:integer,):unittype
_F.ConvertUnitType = jc["ConvertUnitType"]

---@type fun(i:integer,):version
_F.ConvertVersion = jc["ConvertVersion"]

---@type fun(i:integer,):volumegroup
_F.ConvertVolumeGroup = jc["ConvertVolumeGroup"]

---@type fun(i:integer,):weapontype
_F.ConvertWeaponType = jc["ConvertWeaponType"]

---@type fun(i:integer,):widgetevent
_F.ConvertWidgetEvent = jc["ConvertWidgetEvent"]

---@type fun(sourceSaveName:string,destSaveName:string,):boolean
_F.CopySaveGame = jc["CopySaveGame"]

---余弦(弧度)[R]
---Cos(${Angle})
---采用弧度制计算.
---@type fun(radians:real,):real
_F.Cos = jc["Cos"]

---新建不死族金矿[R]
---新建${玩家}的不死族金矿在(${X},${Y}),面向角度:${Face}度
---@type fun(id:player,x:real,y:real,face:real,):unit
_F.CreateBlightedGoldmine = jc["CreateBlightedGoldmine"]

---@type fun():camerasetup
_F.CreateCameraSetup = jc["CreateCameraSetup"]

---新建尸体[R]
---新建${玩家}的${单位}的尸体在(${X},${Y}),面向角度:${Face}度
---@type fun(whichPlayer:player,unitid:integer,x:real,y:real,face:real,):unit
_F.CreateCorpse = jc["CreateCorpse"]

---@type fun(objectid:integer,x:real,y:real,face:real,scale:real,variation:integer,):destructable
_F.CreateDeadDestructable = jc["CreateDeadDestructable"]

---新建可破坏物(死亡的)[R]
---新建死亡的${可破坏物类型}在(${X},${Y},${Z\),面向角度:\}${Direction}尺寸缩放:${Scale}样式:${Variation}
---坐标为(X,Y,Z)格式.面向角度采用角度制,0度为正东方向,90度为正北方向.
---@type fun(objectid:integer,x:real,y:real,z:real,face:real,scale:real,variation:integer,):destructable
_F.CreateDeadDestructableZ = jc["CreateDeadDestructableZ"]

---@type fun():defeatcondition
_F.CreateDefeatCondition = jc["CreateDefeatCondition"]

---@type fun(objectid:integer,x:real,y:real,face:real,scale:real,variation:integer,):destructable
_F.CreateDestructable = jc["CreateDestructable"]

---新建可破坏物[R]
---新建的${可破坏物类型}在(${X},${Y},${Z}),面向角度:${Direction}尺寸缩放:${Scale}样式:${Variation}
---坐标为(X,Y,Z)格式.面向角度采用角度制,0度为正东方向,90度为正北方向.
---@type fun(objectid:integer,x:real,y:real,z:real,face:real,scale:real,variation:integer,):destructable
_F.CreateDestructableZ = jc["CreateDestructableZ"]

---新建可见度修正器(圆范围)[R]
---新建的${玩家}可见度修正器.可见度:${FogStateVisible}圆心坐标:(${X},${Y})半径:${数值}(对盟友${共享}视野,${覆盖}单位视野)
---会创建可见度修正器.
---@type fun(forWhichPlayer:player,whichState:fogstate,centerx:real,centerY:real,radius:real,useSharedVision:boolean,afterUnits:boolean,):fogmodifier
_F.CreateFogModifierRadius = jc["CreateFogModifierRadius"]

---@type fun(forWhichPlayer:player,whichState:fogstate,center:location,radius:real,useSharedVision:boolean,afterUnits:boolean,):fogmodifier
_F.CreateFogModifierRadiusLoc = jc["CreateFogModifierRadiusLoc"]

---新建可见度修正器(矩形区域)[R]
---新建的${玩家}可见度修正器.可见度:${FogStateVisible}影响区域:${矩形区域}(对盟友${共享}视野,${覆盖}单位视野)
---会创建可见度修正器.
---@type fun(forWhichPlayer:player,whichState:fogstate,where:rect,useSharedVision:boolean,afterUnits:boolean,):fogmodifier
_F.CreateFogModifierRect = jc["CreateFogModifierRect"]

---新建玩家组[R]
---新建空玩家组
---会创建玩家组.
---@type fun():force
_F.CreateForce = jc["CreateForce"]

---新建的单位组[R]
---新建的空单位组
---会创建单位组.
---@type fun():group
_F.CreateGroup = jc["CreateGroup"]

---新建图像[R]
---新建图像:${Image}大小:(${X},${Y},${Z})创建点:(${X},${Y},${Z})原点坐标:(${X},${Y},${Z})图像类型:${Type}
---使用'图像-设置永久渲染状态'动作才能显示图像.大小、创建点和原点格式为(X,Y,Z).创建点作为图像的左下角位置.会创建图像.
---@type fun(file:string,sizeX:real,sizeY:real,sizeZ:real,posX:real,posY:real,posZ:real,originX:real,originY:real,originZ:real,imageType:integer,):image
_F.CreateImage = jc["CreateImage"]

---创建
---新建${物品}在(${X},${Y})
---@type fun(itemid:integer,x:real,y:real,):item
_F.CreateItem = jc["CreateItem"]

---新建物品池[R]
---新建的空物品池
---会创建物品池.
---@type fun():itempool
_F.CreateItemPool = jc["CreateItemPool"]

---新建排行榜[R]
---新建的空排行榜
---会创建排行榜.
---@type fun():leaderboard
_F.CreateLeaderboard = jc["CreateLeaderboard"]

---@type fun(soundLabel:string,fadeInRate:integer,fadeOutRate:integer,):sound
_F.CreateMIDISound = jc["CreateMIDISound"]

---新建多面板[R]
---新建的空多面板
---会创建多面板.
---@type fun():multiboard
_F.CreateMultiboard = jc["CreateMultiboard"]

---新建任务[R]
---新建任务
---新建一个任务.注：这条毫无用处，别用——everguo
---@type fun():quest
_F.CreateQuest = jc["CreateQuest"]

---新建区域[R]
---新建区域
---会创建一个新的不规则区域,如果不往该区域添加点或地区,则该区域无效果.
---@type fun():region
_F.CreateRegion = jc["CreateRegion"]

---@type fun(fileName:string,looping:boolean,is3D:boolean,stopwhenoutofrange:boolean,fadeInRate:integer,fadeOutRate:integer,eaxSetting:string,):sound
_F.CreateSound = jc["CreateSound"]

---@type fun(fileName:string,looping:boolean,is3D:boolean,stopwhenoutofrange:boolean,fadeInRate:integer,fadeOutRate:integer,SLKEntryName:string,):sound
_F.CreateSoundFilenameWithLabel = jc["CreateSoundFilenameWithLabel"]

---@type fun(soundLabel:string,looping:boolean,is3D:boolean,stopwhenoutofrange:boolean,fadeInRate:integer,fadeOutRate:integer,):sound
_F.CreateSoundFromLabel = jc["CreateSoundFromLabel"]

---新建漂浮文字[R]
---新建的空漂浮文字
---会创建漂浮文字.
---@type fun():texttag
_F.CreateTextTag = jc["CreateTextTag"]

---新建计时器[R]
---新建的计时器
---会创建计时器.
---@type fun():timer
_F.CreateTimer = jc["CreateTimer"]

---新建计时器窗口[R]
---为${计时器}新建计时窗口
---为一个计时器创建一个新建计时器窗口.
---@type fun(t:timer,):timerdialog
_F.CreateTimerDialog = jc["CreateTimerDialog"]

---新建可追踪物[R]
---新建的可追踪物,使用模型:${模型名字}所在位置:(${X轴},${Y轴})面向角度:${数值}度
---可用来响应鼠标的移动和点击.会创建可追踪物.
---@type fun(trackableModelPath:string,x:real,y:real,facing:real,):trackable
_F.CreateTrackable = jc["CreateTrackable"]

---新建触发[R]
---新建触发
---会创建一个新的触发器,如果对该功能不熟悉请慎用.
---@type fun():trigger
_F.CreateTrigger = jc["CreateTrigger"]

---新建地面纹理变化[R]
---新建的地面纹理变化在点(${X},${Y}),使用图像:${Type}颜色值为(${Red},${Green},${Blue})Alpha值为${Transparency}(${Enable/Disable}暂停状态,${Enble/Disable}跳过出生动画)
---颜色值和Alpha值取值范围0-255.使用'地面纹理变化-设置永久渲染状态'来显示创建的纹理变化.暂停状态表示动画播放完毕后是否继续保留该纹理变化.会创建纹理变化.
---@type fun(x:real,y:real,name:string,red:integer,green:integer,blue:integer,alpha:integer,forcePaused:boolean,noBirthTime:boolean,):ubersplat
_F.CreateUbersplat = jc["CreateUbersplat"]

---创建单位(指定坐标)[C]
---为玩家${玩家}创建一个${单位}在(X坐标:${输入坐标}Y坐标:${输入坐标}),面向角度:${facing}
---不能被'最后创建的单位'捕获之
---@type fun(id:player,unitid:integer,x:real,y:real,face:real,):unit
_F.CreateUnit = jc["CreateUnit"]

---创建单位(指定点)[C]
---为玩家${玩家}创建一个${单位}在${指定点}面向角度:${Face}度
---不能被'最后创建的单位'捕获之
---@type fun(id:player,unitid:integer,whichLocation:location,face:real,):unit
_F.CreateUnitAtLoc = jc["CreateUnitAtLoc"]

---@type fun(id:player,unitname:string,whichLocation:location,face:real,):unit
_F.CreateUnitAtLocByName = jc["CreateUnitAtLocByName"]

---@type fun(whichPlayer:player,unitname:string,x:real,y:real,face:real,):unit
_F.CreateUnitByName = jc["CreateUnitByName"]

---新建单位池[R]
---新建的空单位池
---会创建单位池。
---@type fun():unitpool
_F.CreateUnitPool = jc["CreateUnitPool"]

---@type fun(whichPlayer:player,toWhichPlayers:force,flag:boolean,):nothing
_F.CripplePlayer = jc["CripplePlayer"]

---降低技能等级[R]
---使${单位}的${技能}等级降低1级
---改变死亡单位的光环技能会导致魔兽崩溃.
---@type fun(whichUnit:unit,abilcode:integer,):integer
_F.DecUnitAbilityLevel = jc["DecUnitAbilityLevel"]

---@type fun(whichCondition:defeatcondition,description:string,):nothing
_F.DefeatConditionSetDescription = jc["DefeatConditionSetDescription"]

---@type fun(whichStartLoc:integer,x:real,y:real,):nothing
_F.DefineStartLocation = jc["DefineStartLocation"]

---@type fun(whichStartLoc:integer,whichLocation:location,):nothing
_F.DefineStartLocationLoc = jc["DefineStartLocationLoc"]

---转换角度为弧度
---转换角度${Degrees}为弧度
---@type fun(degrees:real,):real
_F.Deg2Rad = jc["Deg2Rad"]

---@type fun(e:boolexpr,):nothing
_F.DestroyBoolExpr = jc["DestroyBoolExpr"]

---@type fun(c:conditionfunc,):nothing
_F.DestroyCondition = jc["DestroyCondition"]

---@type fun(whichCondition:defeatcondition,):nothing
_F.DestroyDefeatCondition = jc["DestroyDefeatCondition"]

---@type fun(whichEffect:effect,):nothing
_F.DestroyEffect = jc["DestroyEffect"]

---@type fun(f:filterfunc,):nothing
_F.DestroyFilter = jc["DestroyFilter"]

---删除可见度修正器
---删除${VisibilityModifier}
---@type fun(whichFogModifier:fogmodifier,):nothing
_F.DestroyFogModifier = jc["DestroyFogModifier"]

---删除玩家组[R]
---删除${玩家组}
---注意:不要删除系统预置的玩家组.
---@type fun(whichForce:force,):nothing
_F.DestroyForce = jc["DestroyForce"]

---删除单位组[R]
---删除${单位组}
---@type fun(whichGroup:group,):nothing
_F.DestroyGroup = jc["DestroyGroup"]

---删除
---删除${图像}
---@type fun(whichImage:image,):nothing
_F.DestroyImage = jc["DestroyImage"]

---删除物品池[R]
---删除${物品池}
---@type fun(whichItemPool:itempool,):nothing
_F.DestroyItemPool = jc["DestroyItemPool"]

---@type fun(lb:leaderboard,):nothing
_F.DestroyLeaderboard = jc["DestroyLeaderboard"]

---@type fun(whichBolt:lightning,):boolean
_F.DestroyLightning = jc["DestroyLightning"]

---@type fun(lb:multiboard,):nothing
_F.DestroyMultiboard = jc["DestroyMultiboard"]

---@type fun(whichQuest:quest,):nothing
_F.DestroyQuest = jc["DestroyQuest"]

---@type fun(t:texttag,):nothing
_F.DestroyTextTag = jc["DestroyTextTag"]

---删除计时器[R]
---删除${计时器}
---一般来说,计时器并不需要删除.只为某些有特别需求的用户提供.
---@type fun(whichTimer:timer,):nothing
_F.DestroyTimer = jc["DestroyTimer"]

---@type fun(whichDialog:timerdialog,):nothing
_F.DestroyTimerDialog = jc["DestroyTimerDialog"]

---删除触发器[R]
---删除${触发器}
---对不再使用的触发器可以使用该动作来删除.
---@type fun(whichTrigger:trigger,):nothing
_F.DestroyTrigger = jc["DestroyTrigger"]

---删除地面纹理变化
---删除${Ubersplat}
---@type fun(whichSplat:ubersplat,):nothing
_F.DestroyUbersplat = jc["DestroyUbersplat"]

---删除单位池[R]
---删除${单位池}
---@type fun(whichPool:unitpool,):nothing
_F.DestroyUnitPool = jc["DestroyUnitPool"]

---复活
---复活${Destructible},设置生命值为${Value}并${Show/Hide}生长动画
---@type fun(d:destructable,life:real,birth:boolean,):nothing
_F.DestructableRestoreLife = jc["DestructableRestoreLife"]

---添加对话框按钮[R]
---给${对话框}添加按钮,使用标题:${文字}快捷键:${HotKey}
---会创建对话框按钮.
---@type fun(whichDialog:dialog,buttonText:string,hotkey:integer,):button
_F.DialogAddButton = jc["DialogAddButton"]

---添加退出游戏按钮[R]
---为${对话框}添加退出游戏按钮(${跳过}计分屏)按钮标题为:${文字}快捷键为:${HotKey}
---该函数创建的按钮并不被纪录到'最后创建的对话框按钮'.当该按钮被点击时会退出游戏
---@type fun(whichDialog:dialog,doScoreScreen:boolean,buttonText:string,hotkey:integer,):button
_F.DialogAddQuitButton = jc["DialogAddQuitButton"]

---@type fun(whichDialog:dialog,):nothing
_F.DialogClear = jc["DialogClear"]

---新建对话框[R]
---新建对话框
---创建新的对话框.
---@type fun():dialog
_F.DialogCreate = jc["DialogCreate"]

---删除[R]
---删除${对话框}
---将对话框清除出内存.一般来说对话框并不需要删除.
---@type fun(whichDialog:dialog,):nothing
_F.DialogDestroy = jc["DialogDestroy"]

---显示/隐藏[R]
---对${Player}设置${对话框}的状态为${Show/Hide}
---对话框不能应用于地图初始化事件.
---@type fun(whichPlayer:player,whichDialog:dialog,flag:boolean,):nothing
_F.DialogDisplay = jc["DialogDisplay"]

---@type fun(whichDialog:dialog,messageText:string,):nothing
_F.DialogSetMessage = jc["DialogSetMessage"]

---禁用重新开始任务按钮
---设置重新开始任务按钮可以点击为${}
---当单人游戏时，可以设置重新开始任务按钮能否允许点击。
---@type fun(flag:boolean,):nothing
_F.DisableRestartMission = jc["DisableRestartMission"]

---关闭触发
---关闭${Trigger}
---@type fun(whichTrigger:trigger,):nothing
_F.DisableTrigger = jc["DisableTrigger"]

---@type fun(flag:boolean,):nothing
_F.DisplayCineFilter = jc["DisplayCineFilter"]

---@type fun():nothing
_F.DisplayLoadDialog = jc["DisplayLoadDialog"]

---对玩家显示文本消息(自动限时)[R]
---对${玩家}在屏幕位移(${X},${Y})处显示文本:${文字}
---显示时间取决于文字长度.位移的取值在0-1之间.可使用'本地玩家'实现对所有玩家发送消息.
---@type fun(toPlayer:player,x:real,y:real,message:string,):nothing
_F.DisplayTextToPlayer = jc["DisplayTextToPlayer"]

---@type fun(toPlayer:player,x:real,y:real,duration:real,message:string,):nothing
_F.DisplayTimedTextFromPlayer = jc["DisplayTimedTextFromPlayer"]

---对玩家显示文本消息(指定时间)[R]
---对${玩家}在屏幕位移(${X},${Y})处显示${时间}秒的文本信息:${文字}
---位移的取值在0-1之间.可使用'本地玩家[R]'实现对所有玩家发送消息.
---@type fun(toPlayer:player,x:real,y:real,duration:real,message:string,):nothing
_F.DisplayTimedTextToPlayer = jc["DisplayTimedTextToPlayer"]

---关闭游戏录像功能[R]
---关闭游戏录像功能
---游戏结束时不保存游戏录像.
---@type fun():nothing
_F.DoNotSaveReplay = jc["DoNotSaveReplay"]

---允许/禁用框选
---${Enable/Disable}框选功能(${Enable/Disable}显示选择框)
---@type fun(state:boolean,ui:boolean,):nothing
_F.EnableDragSelect = jc["EnableDragSelect"]

---允许/禁用小地图按钮
---${Enable/Disable}联盟颜色显示按钮,${Enable/Disable}中立生物显示按钮
---@type fun(enableAlly:boolean,enableCreep:boolean,):nothing
_F.EnableMinimapFilterButtons = jc["EnableMinimapFilterButtons"]

---允许/禁止闭塞(所有玩家)[R]
---${Enable/Disable}闭塞
---@type fun(flag:boolean,):nothing
_F.EnableOcclusion = jc["EnableOcclusion"]

---允许/禁用预选
---${Enable/Disable}预选功能(${Enable/Disable}显示预选圈,生命槽,物体信息)
---@type fun(state:boolean,ui:boolean,):nothing
_F.EnablePreSelect = jc["EnablePreSelect"]

---允许/禁用选择
---${Enable/Disable}选择和取消选择功能(${Enable/Disable}显示选择圈)
---禁用选择后仍可以通过触发来选择物体.只有允许选择功能时才会显示选择圈.
---@type fun(state:boolean,ui:boolean,):nothing
_F.EnableSelect = jc["EnableSelect"]

---开启触发
---开启${Trigger}
---@type fun(whichTrigger:trigger,):nothing
_F.EnableTrigger = jc["EnableTrigger"]

---启用/禁用玩家控制权(所有玩家)[R]
---${启用/禁用}玩家控制权
---@type fun(b:boolean,):nothing
_F.EnableUserControl = jc["EnableUserControl"]

---@type fun(b:boolean,):nothing
_F.EnableUserUI = jc["EnableUserUI"]

---启用/禁用天气效果
---设置${WeatherEffect}的状态为:${On/Off}
---可以使用'环境-创建天气效果'动作来创建天气效果.
---@type fun(whichEffect:weathereffect,enable:boolean,):nothing
_F.EnableWeatherEffect = jc["EnableWeatherEffect"]

---允许/禁止边界染色(所有玩家)[R]
---${Enable/Disable}边界染色,应用于所有玩家
---禁用边界染色时边界为普通地形,不显示为黑色,但仍是不可通行的.
---@type fun(b:boolean,):nothing
_F.EnableWorldFogBoundary = jc["EnableWorldFogBoundary"]

---@type fun():nothing
_F.EndCinematicScene = jc["EndCinematicScene"]

---@type fun(doScoreScreen:boolean,):nothing
_F.EndGame = jc["EndGame"]

---@type fun():nothing
_F.EndThematicMusic = jc["EndThematicMusic"]

---@type fun(r:rect,filter:boolexpr,actionFunc:code,):nothing
_F.EnumDestructablesInRect = jc["EnumDestructablesInRect"]

---@type fun(r:rect,filter:boolexpr,actionFunc:code,):nothing
_F.EnumItemsInRect = jc["EnumItemsInRect"]

---运行函数[R]
---运行:${函数名}
---使用该功能运行的函数与触发独立,只能运行自定义无参数函数.
---@type fun(funcName:string,):nothing
_F.ExecuteFunc = jc["ExecuteFunc"]

---@type fun(func:code,):filterfunc
_F.Filter = jc["Filter"]

---结束地面纹理变化
---结束${Ubersplat}
---在动画播放完毕时自动清除该地面纹理变化.
---@type fun(whichSplat:ubersplat,):nothing
_F.FinishUbersplat = jc["FinishUbersplat"]

---@type fun(whichGroup:group,):unit
_F.FirstOfGroup = jc["FirstOfGroup"]

---@type fun():nothing
_F.FlashQuestDialogButton = jc["FlashQuestDialogButton"]

---@type fun()
_F.FlushChildHashtable = jc["FlushChildHashtable"]

---@type fun(cache:gamecache,):nothing
_F.FlushGameCache = jc["FlushGameCache"]

---@type fun()
_F.FlushParentHashtable = jc["FlushParentHashtable"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.FlushStoredBoolean = jc["FlushStoredBoolean"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.FlushStoredInteger = jc["FlushStoredInteger"]

---删除类别
---删除缓存${GameCache}中${Category}类别
---清空该类别下的所有缓存数据.
---@type fun(cache:gamecache,missionKey:string,):nothing
_F.FlushStoredMission = jc["FlushStoredMission"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.FlushStoredReal = jc["FlushStoredReal"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.FlushStoredString = jc["FlushStoredString"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.FlushStoredUnit = jc["FlushStoredUnit"]

---启用/禁用战争迷雾[R]
---${启用/禁用}战争迷雾
---@type fun(enable:boolean,):nothing
_F.FogEnable = jc["FogEnable"]

---启用/禁用黑色阴影[R]
---${启用/禁用}黑色阴影
---@type fun(enable:boolean,):nothing
_F.FogMaskEnable = jc["FogMaskEnable"]

---启用可见度修正器
---启用${VisibilityModifier}
---@type fun(whichFogModifier:fogmodifier,):nothing
_F.FogModifierStart = jc["FogModifierStart"]

---禁用可见度修正器
---禁用${VisibilityModifier}
---@type fun(whichFogModifier:fogmodifier,):nothing
_F.FogModifierStop = jc["FogModifierStop"]

---选取玩家组内玩家做动作
---选取${玩家组}内所有玩家${做动作}
---玩家组动作中可使用'选取玩家'来获取对应的玩家.等待不能在组动作中运行.
---@type fun(whichForce:force,callback:code,):nothing
_F.ForForce = jc["ForForce"]

---@type fun(whichGroup:group,callback:code,):nothing
_F.ForGroup = jc["ForGroup"]

---添加玩家[R]
---${玩家组}添加${玩家}
---并不影响玩家本身.
---@type fun(whichForce:force,whichPlayer:player,):nothing
_F.ForceAddPlayer = jc["ForceAddPlayer"]

---@type fun():nothing
_F.ForceCampaignSelectScreen = jc["ForceCampaignSelectScreen"]

---@type fun(flag:boolean,):nothing
_F.ForceCinematicSubtitles = jc["ForceCinematicSubtitles"]

---清空玩家组
---清空${玩家组}内所有玩家
---并不影响玩家本身.
---@type fun(whichForce:force,):nothing
_F.ForceClear = jc["ForceClear"]

---@type fun(whichForce:force,whichPlayer:player,filter:boolexpr,):nothing
_F.ForceEnumAllies = jc["ForceEnumAllies"]

---@type fun(whichForce:force,whichPlayer:player,filter:boolexpr,):nothing
_F.ForceEnumEnemies = jc["ForceEnumEnemies"]

---@type fun(whichForce:force,filter:boolexpr,):nothing
_F.ForceEnumPlayers = jc["ForceEnumPlayers"]

---@type fun(whichForce:force,filter:boolexpr,countLimit:integer,):nothing
_F.ForceEnumPlayersCounted = jc["ForceEnumPlayersCounted"]

---@type fun(whichPlayer:player,startLocIndex:integer,):nothing
_F.ForcePlayerStartLocation = jc["ForcePlayerStartLocation"]

---@type fun():nothing
_F.ForceQuestDialogUpdate = jc["ForceQuestDialogUpdate"]

---移除玩家[R]
---从${玩家组}中移除${玩家}
---并不影响玩家本身.
---@type fun(whichForce:force,whichPlayer:player,):nothing
_F.ForceRemovePlayer = jc["ForceRemovePlayer"]

---@type fun():nothing
_F.ForceUICancel = jc["ForceUICancel"]

---@type fun(key:string,):nothing
_F.ForceUIKey = jc["ForceUIKey"]

---玩家的AI难度
---${Player}的对战AI难度
---对非AI玩家返回普通难度.
---@type fun(num:player,):aidifficulty
_F.GetAIDifficulty = jc["GetAIDifficulty"]

---@type fun(abilityString:string,t:effecttype,index:integer,):string
_F.GetAbilityEffect = jc["GetAbilityEffect"]

---@type fun(abilityId:integer,t:effecttype,index:integer,):string
_F.GetAbilityEffectById = jc["GetAbilityEffectById"]

---@type fun(abilityString:string,t:soundtype,):string
_F.GetAbilitySound = jc["GetAbilitySound"]

---@type fun(abilityId:integer,t:soundtype,):string
_F.GetAbilitySoundById = jc["GetAbilitySoundById"]

---联盟颜色显示设置
---联盟颜色显示设置
---0为不开启.1为小地图显示.2为小地图和游戏都显示.
---@type fun():integer
_F.GetAllyColorFilterState = jc["GetAllyColorFilterState"]

---攻击单位
---攻击单位
---响应'被攻击'单位事件.
---@type fun():unit
_F.GetAttacker = jc["GetAttacker"]

---购买者
---购买者
---响应'出售单位','出售物品'或'抵押物品'单位事件.
---@type fun():unit
_F.GetBuyingUnit = jc["GetBuyingUnit"]

---@type fun():real
_F.GetCameraBoundMaxX = jc["GetCameraBoundMaxX"]

---@type fun():real
_F.GetCameraBoundMaxY = jc["GetCameraBoundMaxY"]

---@type fun():real
_F.GetCameraBoundMinX = jc["GetCameraBoundMinX"]

---@type fun():real
_F.GetCameraBoundMinY = jc["GetCameraBoundMinY"]

---当前镜头源位置
---当前镜头源位置
---会创建点.注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():location
_F.GetCameraEyePositionLoc = jc["GetCameraEyePositionLoc"]

---当前镜头源X坐标
---当前镜头源X坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraEyePositionX = jc["GetCameraEyePositionX"]

---当前镜头源Y坐标
---当前镜头源Y坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraEyePositionY = jc["GetCameraEyePositionY"]

---当前镜头源Z坐标
---当前镜头源Z坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraEyePositionZ = jc["GetCameraEyePositionZ"]

---镜头属性(当前镜头)
---当前镜头的${CameraField}
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun(whichField:camerafield,):real
_F.GetCameraField = jc["GetCameraField"]

---@type fun(whichMargin:integer,):real
_F.GetCameraMargin = jc["GetCameraMargin"]

---当前镜头目标点
---当前镜头目标点
---会创建点.注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():location
_F.GetCameraTargetPositionLoc = jc["GetCameraTargetPositionLoc"]

---当前镜头目标X坐标
---当前镜头目标X坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraTargetPositionX = jc["GetCameraTargetPositionX"]

---当前镜头目标Y坐标
---当前镜头目标Y坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraTargetPositionY = jc["GetCameraTargetPositionY"]

---当前镜头目标Z坐标
---当前镜头目标Z坐标
---注意:该函数对各玩家返回值不同,请确定你知道自己在做什么,否则很容易引起掉线.
---@type fun():real
_F.GetCameraTargetPositionZ = jc["GetCameraTargetPositionZ"]

---被取消的建筑
---被取消的建筑
---响应'取消建造建筑'单位事件.
---@type fun():unit
_F.GetCancelledStructure = jc["GetCancelledStructure"]

---被改变所有者的单位
---被改变所有者的单位
---响应'改变所有者'单位事件.
---@type fun():unit
_F.GetChangingUnit = jc["GetChangingUnit"]

---原所有者
---原所有者
---响应'改变所有者'单位事件,指代单位原来的所有者.
---@type fun():player
_F.GetChangingUnitPrevOwner = jc["GetChangingUnitPrevOwner"]

---@type fun():button
_F.GetClickedButton = jc["GetClickedButton"]

---@type fun():dialog
_F.GetClickedDialog = jc["GetClickedDialog"]

---完成的建筑
---完成的建筑
---响应'完成建造建筑'单位事件.
---@type fun():unit
_F.GetConstructedStructure = jc["GetConstructedStructure"]

---正在建造的建筑
---正在建造的建筑
---响应'开始建造建筑'单位事件.
---@type fun():unit
_F.GetConstructingStructure = jc["GetConstructingStructure"]

---@type fun():mapdensity
_F.GetCreatureDensity = jc["GetCreatureDensity"]

---小地图中立生物显示开启
---小地图中立生物显示开启
---@type fun():boolean
_F.GetCreepCampFilterState = jc["GetCreepCampFilterState"]

---@type fun(whichButton:integer,):boolean
_F.GetCustomCampaignButtonVisible = jc["GetCustomCampaignButtonVisible"]

---腐化的单位
---腐化的单位
---响应'开始腐化'单位事件.
---@type fun():unit
_F.GetDecayingUnit = jc["GetDecayingUnit"]

---@type fun():gamedifficulty
_F.GetDefaultDifficulty = jc["GetDefaultDifficulty"]

---生命值
---${可破坏物}的当前生命值
---@type fun(d:destructable,):real
_F.GetDestructableLife = jc["GetDestructableLife"]

---最大生命值
---${可破坏物}的最大生命值
---@type fun(d:destructable,):real
_F.GetDestructableMaxLife = jc["GetDestructableMaxLife"]

---物件名字
---${物件}的名字
---@type fun(d:destructable,):string
_F.GetDestructableName = jc["GetDestructableName"]

---闭塞高度
---${可破坏物}的闭塞高度
---@type fun(d:destructable,):real
_F.GetDestructableOccluderHeight = jc["GetDestructableOccluderHeight"]

---指定可破坏物的类型
---${可破坏物}的类型
---@type fun(d:destructable,):integer
_F.GetDestructableTypeId = jc["GetDestructableTypeId"]

---可破坏物所在X轴坐标[R]
---${可破坏物}所在X轴坐标
---@type fun(d:destructable,):real
_F.GetDestructableX = jc["GetDestructableX"]

---@type fun(d:destructable,):real
_F.GetDestructableY = jc["GetDestructableY"]

---@type fun():unit
_F.GetDetectedUnit = jc["GetDetectedUnit"]

---死亡单位
---死亡单位
---响应'死亡'单位事件.
---@type fun():unit
_F.GetDyingUnit = jc["GetDyingUnit"]

---进入的单位
---进入的单位
---响应'单位进入区域'单位事件.
---@type fun():unit
_F.GetEnteringUnit = jc["GetEnteringUnit"]

---选取的可破坏物
---选取的可破坏物
---使用'选取可破坏物做动作'时,指代相应的可破坏物.
---@type fun():destructable
_F.GetEnumDestructable = jc["GetEnumDestructable"]

---选取物品
---选取物品
---使用'选取物品做动作'时,指代相应的物品.
---@type fun():item
_F.GetEnumItem = jc["GetEnumItem"]

---选取玩家
---选取玩家
---使用'选取玩家做动作'时,指代相应的玩家.
---@type fun():player
_F.GetEnumPlayer = jc["GetEnumPlayer"]

---选取单位
---选取单位
---使用'选取单位做动作'时,指代相应的单位.
---@type fun():unit
_F.GetEnumUnit = jc["GetEnumUnit"]

---伤害值
---单位所受伤害
---响应'受到伤害'单位事件,指代单位所受伤害.
---@type fun():real
_F.GetEventDamage = jc["GetEventDamage"]

---伤害来源
---伤害来源
---响应'受到伤害'单位事件.
---@type fun():unit
_F.GetEventDamageSource = jc["GetEventDamageSource"]

---@type fun():player
_F.GetEventDetectingPlayer = jc["GetEventDetectingPlayer"]

---@type fun():gamestate
_F.GetEventGameState = jc["GetEventGameState"]

---输入的聊天信息
---输入的聊天信息
---@type fun():string
_F.GetEventPlayerChatString = jc["GetEventPlayerChatString"]

---匹配的聊天信息
---匹配的聊天信息
---@type fun():string
_F.GetEventPlayerChatStringMatched = jc["GetEventPlayerChatStringMatched"]

---@type fun():playerstate
_F.GetEventPlayerState = jc["GetEventPlayerState"]

---事件目标单位
---事件目标单位
---响应'注意到/获取攻击目标'单位事件,指代目标单位.
---@type fun():unit
_F.GetEventTargetUnit = jc["GetEventTargetUnit"]

---@type fun():unitstate
_F.GetEventUnitState = jc["GetEventUnitState"]

---到期的计时器
---到期的计时器
---响应'时间-计时器到期'事件.
---@type fun():timer
_F.GetExpiredTimer = jc["GetExpiredTimer"]

---匹配的可破坏物
---匹配的可破坏物
---在'选取可破坏物满足条件'之类功能的条件中,指代被判断的可破坏物.
---@type fun():destructable
_F.GetFilterDestructable = jc["GetFilterDestructable"]

---匹配物品
---匹配物品
---在'选取物品满足条件'之类功能的条件中,指代被判断单位.
---@type fun():item
_F.GetFilterItem = jc["GetFilterItem"]

---匹配玩家
---匹配玩家
---在'选取玩家满足条件'之类功能的条件中,指代被判断玩家.
---@type fun():player
_F.GetFilterPlayer = jc["GetFilterPlayer"]

---匹配单位
---匹配单位
---在'选取单位满足条件'之类功能的条件中,指代被判断单位.
---@type fun():unit
_F.GetFilterUnit = jc["GetFilterUnit"]

---@type fun(whichFloatGameState:fgamestate,):real
_F.GetFloatGameState = jc["GetFloatGameState"]

---单位提供人口数量(指定单位类型)
---${单位类型}提供的人口数量
---@type fun(unitId:integer,):integer
_F.GetFoodMade = jc["GetFoodMade"]

---单位使用人口数量(指定单位类型)
---${单位类型}使用的人口数量
---@type fun(unitId:integer,):integer
_F.GetFoodUsed = jc["GetFoodUsed"]

---当前游戏难度
---当前游戏难度
---@type fun():gamedifficulty
_F.GetGameDifficulty = jc["GetGameDifficulty"]

---@type fun():placement
_F.GetGamePlacement = jc["GetGamePlacement"]

---当前游戏速度
---当前游戏速度
---@type fun():gamespeed
_F.GetGameSpeed = jc["GetGameSpeed"]

---@type fun():gametype
_F.GetGameTypeSelected = jc["GetGameTypeSelected"]

---<1.24>获取对象的h2i值[C]
---转换${Handle}为整数
---创建一个对应该handle的临时密钥,可以在哈希表中作为索引号使用.当该handle被彻底销毁时,密钥会被回收.
---@type fun(h:handle,):integer
_F.GetHandleId = jc["GetHandleId"]

---英雄敏捷[R]
---${英雄}的敏捷值(${Include/Exclude}加成)
---@type fun(whichHero:unit,includeBonuses:boolean,):integer
_F.GetHeroAgi = jc["GetHeroAgi"]

---英雄智力[R]
---${英雄}的智力值(${Include/Exclude}加成)
---@type fun(whichHero:unit,includeBonuses:boolean,):integer
_F.GetHeroInt = jc["GetHeroInt"]

---英雄等级
---${英雄}的英雄等级
---@type fun(whichHero:unit,):integer
_F.GetHeroLevel = jc["GetHeroLevel"]

---英雄称谓
---${Hero}的称谓
---如圣骑士会返回'无惧的布赞恩'而不是'圣骑士'.
---@type fun(whichHero:unit,):string
_F.GetHeroProperName = jc["GetHeroProperName"]

---未分配技能点数
---${英雄}的未分配技能点数
---@type fun(whichHero:unit,):integer
_F.GetHeroSkillPoints = jc["GetHeroSkillPoints"]

---英雄力量[R]
---${英雄}的力量值(${Include/Exclude}加成)
---@type fun(whichHero:unit,includeBonuses:boolean,):integer
_F.GetHeroStr = jc["GetHeroStr"]

---英雄经验值
---${英雄}的经验值
---@type fun(whichHero:unit,):integer
_F.GetHeroXP = jc["GetHeroXP"]

---@type fun(whichIntegerGameState:igamestate,):integer
_F.GetIntegerGameState = jc["GetIntegerGameState"]

---@type fun():integer
_F.GetIssuedOrderId = jc["GetIssuedOrderId"]

---使用次数
---${物品}的使用次数
---无限使用物品将返回0.
---@type fun(whichItem:item,):integer
_F.GetItemCharges = jc["GetItemCharges"]

---物品等级
---${物品}的物品等级
---@type fun(whichItem:item,):integer
_F.GetItemLevel = jc["GetItemLevel"]

---物品名字
---${物品}的名字
---@type fun(whichItem:item,):string
_F.GetItemName = jc["GetItemName"]

---物品所属玩家
---${物品}的所属玩家
---与持有者无关,默认为中立被动玩家.
---@type fun(whichItem:item,):player
_F.GetItemPlayer = jc["GetItemPlayer"]

---指定物品的分类
---${物品}的分类
---@type fun(whichItem:item,):itemtype
_F.GetItemType = jc["GetItemType"]

---指定物品的类型
---${物品}的类型
---@type fun(i:item,):integer
_F.GetItemTypeId = jc["GetItemTypeId"]

---物品自定义值
---${物品}的自定义值
---可以使用'物品-设置自定义值'来设置该值.
---@type fun(whichItem:item,):integer
_F.GetItemUserData = jc["GetItemUserData"]

---物品的X轴坐标[R]
---${物品}的X轴坐标
---@type fun(i:item,):real
_F.GetItemX = jc["GetItemX"]

---物品的Y轴坐标[R]
---${物品}的Y轴坐标
---@type fun(i:item,):real
_F.GetItemY = jc["GetItemY"]

---@type fun():unit
_F.GetKillingUnit = jc["GetKillingUnit"]

---学习技能[R]
---学习技能
---响应'学习技能'单位事件,指代被学习的技能.
---@type fun():integer
_F.GetLearnedSkill = jc["GetLearnedSkill"]

---学习技能等级
---学习技能等级
---响应'学习技能'单位事件,指代被学习技能的等级.注意,该值为学习后的等级.
---@type fun():integer
_F.GetLearnedSkillLevel = jc["GetLearnedSkillLevel"]

---学习技能的英雄
---学习技能的英雄
---响应'学习技能'单位事件.
---@type fun():unit
_F.GetLearningUnit = jc["GetLearningUnit"]

---离开的单位
---离开的单位
---响应'单位离开区域'单位事件.
---@type fun():unit
_F.GetLeavingUnit = jc["GetLeavingUnit"]

---升级的英雄
---升级的英雄
---响应'提升等级'单位事件.
---@type fun():unit
_F.GetLevelingUnit = jc["GetLevelingUnit"]

---@type fun(whichBolt:lightning,):real
_F.GetLightningColorA = jc["GetLightningColorA"]

---@type fun(whichBolt:lightning,):real
_F.GetLightningColorB = jc["GetLightningColorB"]

---@type fun(whichBolt:lightning,):real
_F.GetLightningColorG = jc["GetLightningColorG"]

---@type fun(whichBolt:lightning,):real
_F.GetLightningColorR = jc["GetLightningColorR"]

---@type fun():unit
_F.GetLoadedUnit = jc["GetLoadedUnit"]

---本地玩家[R]
---本地玩家
---指代玩家自己,所以对每个玩家返回值都不一样.如果不清楚该函数的话千万别用,因为很可能因为不同步而导致掉线.
---@type fun():player
_F.GetLocalPlayer = jc["GetLocalPlayer"]

---本地热键
---本地热键:${文字}
---获取ui\\miscui.txt中定义的热键.
---@type fun(source:string,):integer
_F.GetLocalizedHotkey = jc["GetLocalizedHotkey"]

---本地字符串[R]
---本地字符串:${文字}
---获取ui\\framedef\\globalstrings.fdf中定义的字符串.
---@type fun(source:string,):string
_F.GetLocalizedString = jc["GetLocalizedString"]

---点的X轴坐标
---${点}的X轴坐标
---@type fun(whichLocation:location,):real
_F.GetLocationX = jc["GetLocationX"]

---点的Y轴坐标
---${点}的Y轴坐标
---@type fun(whichLocation:location,):real
_F.GetLocationY = jc["GetLocationY"]

---点的Z轴高度[R]
---${点}的Z轴高度
---@type fun(whichLocation:location,):real
_F.GetLocationZ = jc["GetLocationZ"]

---被操作物品
---被操作物品
---响应'使用/得到/丢弃物品'单位事件.
---@type fun():item
_F.GetManipulatedItem = jc["GetManipulatedItem"]

---操作物品的单位
---操作物品的单位
---响应'使用/获得/丢失物品'单位事件.
---@type fun():unit
_F.GetManipulatingUnit = jc["GetManipulatingUnit"]

---物体名称[C]
---${物体ID}的名称
---如'A01Z',物体编辑器中物体的名字
---@type fun(objectId:integer,):string
_F.GetObjectName = jc["GetObjectName"]

---命令发布点
---命令发布点
---响应'发布指定点目标命令'单位事件.会创建点.
---@type fun():location
_F.GetOrderPointLoc = jc["GetOrderPointLoc"]

---命令发布点X坐标[R]
---命令发布点X坐标
---用坐标代替点可以省去创建、删除点的麻烦.
---@type fun():real
_F.GetOrderPointX = jc["GetOrderPointX"]

---命令发布点Y坐标[R]
---命令发布点Y坐标
---用坐标代替点可以省去创建、删除点的麻烦.
---@type fun():real
_F.GetOrderPointY = jc["GetOrderPointY"]

---@type fun():widget
_F.GetOrderTarget = jc["GetOrderTarget"]

---命令发布目标(可破坏物)
---命令发布目标
---响应'发布指定物体目标命令'单位事件并以可破坏物为目标时.
---@type fun():destructable
_F.GetOrderTargetDestructable = jc["GetOrderTargetDestructable"]

---命令发布目标
---命令发布目标
---响应'发布指定物体目标命令'单位事件并以物品为目标时.
---@type fun():item
_F.GetOrderTargetItem = jc["GetOrderTargetItem"]

---命令发布目标
---命令发布目标
---响应'发布指定物体目标命令'单位事件并以单位为目标时.
---@type fun():unit
_F.GetOrderTargetUnit = jc["GetOrderTargetUnit"]

---发布命令的单位
---发布命令的单位
---响应'发布命令'单位事件.
---@type fun():unit
_F.GetOrderedUnit = jc["GetOrderedUnit"]

---单位所有者
---${单位}的所有者
---@type fun(whichUnit:unit,):player
_F.GetOwningPlayer = jc["GetOwningPlayer"]

---联盟状态设置
---${Player}对${Player}开启${AllianceType}
---@type fun(sourcePlayer:player,otherPlayer:player,whichAllianceSetting:alliancetype,):boolean
_F.GetPlayerAlliance = jc["GetPlayerAlliance"]

---玩家颜色
---${Player}的颜色
---@type fun(whichPlayer:player,):playercolor
_F.GetPlayerColor = jc["GetPlayerColor"]

---玩家控制者
---${Player}的控制者
---@type fun(whichPlayer:player,):mapcontrol
_F.GetPlayerController = jc["GetPlayerController"]

---@type fun(whichPlayer:player,):real
_F.GetPlayerHandicap = jc["GetPlayerHandicap"]

---@type fun(whichPlayer:player,):real
_F.GetPlayerHandicapXP = jc["GetPlayerHandicapXP"]

---玩家ID-1[R]
---${Player}的玩家ID-1
---玩家ID取值1-16.
---@type fun(whichPlayer:player,):integer
_F.GetPlayerId = jc["GetPlayerId"]

---玩家名字
---${Player}的名字
---@type fun(whichPlayer:player,):string
_F.GetPlayerName = jc["GetPlayerName"]

---玩家的种族
---${Player}的种族
---@type fun(whichPlayer:player,):race
_F.GetPlayerRace = jc["GetPlayerRace"]

---玩家得分
---${Player}${Score}
---@type fun(whichPlayer:player,whichPlayerScore:playerscore,):integer
_F.GetPlayerScore = jc["GetPlayerScore"]

---@type fun(whichPlayer:player,):boolean
_F.GetPlayerSelectable = jc["GetPlayerSelectable"]

---玩家游戏状态
---${Player}的游戏状态
---@type fun(whichPlayer:player,):playerslotstate
_F.GetPlayerSlotState = jc["GetPlayerSlotState"]

---@type fun(whichPlayer:player,):integer
_F.GetPlayerStartLocation = jc["GetPlayerStartLocation"]

---玩家属性
---${Player}${Property}
---@type fun(whichPlayer:player,whichPlayerState:playerstate,):integer
_F.GetPlayerState = jc["GetPlayerState"]

---建筑数量
---${Player}拥有的建筑数量(${Include/Exclude}未完成的)
---@type fun(whichPlayer:player,includeIncomplete:boolean,):integer
_F.GetPlayerStructureCount = jc["GetPlayerStructureCount"]

---玩家税率[R]
---${Player}需要交纳给${Player}的${Resource}所得税
---所得税取值范围0-100.
---@type fun(sourcePlayer:player,otherPlayer:player,whichResource:playerstate,):integer
_F.GetPlayerTaxRate = jc["GetPlayerTaxRate"]

---玩家队伍
---${Player}所属队伍编号
---@type fun(whichPlayer:player,):integer
_F.GetPlayerTeam = jc["GetPlayerTeam"]

---@type fun(whichPlayer:player,techid:integer,specificonly:boolean,):integer
_F.GetPlayerTechCount = jc["GetPlayerTechCount"]

---@type fun(whichPlayer:player,techid:integer,):integer
_F.GetPlayerTechMaxAllowed = jc["GetPlayerTechMaxAllowed"]

---@type fun(whichPlayer:player,techid:integer,specificonly:boolean,):boolean
_F.GetPlayerTechResearched = jc["GetPlayerTechResearched"]

---@type fun(whichPlayer:player,unitName:string,includeIncomplete:boolean,includeUpgrades:boolean,):integer
_F.GetPlayerTypedUnitCount = jc["GetPlayerTypedUnitCount"]

---非建筑单位数量
---${Player}拥有的非建筑单位数量(${Include/Exclude}未完成的)
---@type fun(whichPlayer:player,includeIncomplete:boolean,):integer
_F.GetPlayerUnitCount = jc["GetPlayerUnitCount"]

---玩家数量
---玩家数量
---地图编辑器中开启的玩家数量(1-12).
---@type fun():integer
_F.GetPlayers = jc["GetPlayers"]

---随机整数
---随机整数,最小值:${Minimum}最大值:${Maximum}
---@type fun(lowBound:integer,highBound:integer,):integer
_F.GetRandomInt = jc["GetRandomInt"]

---随机实数
---随机实数,最小值:${Minimum}最大值:${Maximum}
---@type fun(lowBound:real,highBound:real,):real
_F.GetRandomReal = jc["GetRandomReal"]

---中心X坐标
---${矩形区域}的中心X坐标
---@type fun(whichRect:rect,):real
_F.GetRectCenterX = jc["GetRectCenterX"]

---中心Y坐标
---${矩形区域}的中心Y坐标
---@type fun(whichRect:rect,):real
_F.GetRectCenterY = jc["GetRectCenterY"]

---右上角X坐标
---${矩形区域}的右上角X坐标
---@type fun(whichRect:rect,):real
_F.GetRectMaxX = jc["GetRectMaxX"]

---右上角Y坐标
---${矩形区域}的右上角Y坐标
---@type fun(whichRect:rect,):real
_F.GetRectMaxY = jc["GetRectMaxY"]

---左下角X坐标
---${矩形区域}的左下角X坐标
---@type fun(whichRect:rect,):real
_F.GetRectMinX = jc["GetRectMinX"]

---左下角Y坐标
---${矩形区域}的左下角Y坐标
---@type fun(whichRect:rect,):real
_F.GetRectMinY = jc["GetRectMinY"]

---@type fun():unit
_F.GetRescuer = jc["GetRescuer"]

---被研究科技
---被研究科技
---响应'开始/取消/完成科技研究'单位事件.
---@type fun():integer
_F.GetResearched = jc["GetResearched"]

---研究科技的单位
---研究科技的单位
---响应'开始/取消/完成科技研究'单位事件.
---@type fun():unit
_F.GetResearchingUnit = jc["GetResearchingUnit"]

---储金量
---${金矿}的储金量
---只对金矿有效.
---@type fun(whichUnit:unit,):integer
_F.GetResourceAmount = jc["GetResourceAmount"]

---@type fun():mapdensity
_F.GetResourceDensity = jc["GetResourceDensity"]

---可复活英雄
---可复活英雄
---响应'变为可复活的'单位事件.
---@type fun():unit
_F.GetRevivableUnit = jc["GetRevivableUnit"]

---复活英雄
---复活英雄
---响应'开始/取消/完成复活'单位事件.
---@type fun():unit
_F.GetRevivingUnit = jc["GetRevivingUnit"]

---存档文件名
---存档文件名
---响应'游戏-保存进度'事件.
---@type fun():string
_F.GetSaveBasicFilename = jc["GetSaveBasicFilename"]

---贩卖者
---贩卖者
---响应'出售单位','出售物品'或'抵押物品'单位事件.
---@type fun():unit
_F.GetSellingUnit = jc["GetSellingUnit"]

---被售出物品
---被售出物品
---响应'出售物品'或'抵押物品'单位事件.
---@type fun():item
_F.GetSoldItem = jc["GetSoldItem"]

---被贩卖单位
---被贩卖单位
---响应'出售单位'单位事件.
---@type fun():unit
_F.GetSoldUnit = jc["GetSoldUnit"]

---@type fun(soundHandle:sound,):integer
_F.GetSoundDuration = jc["GetSoundDuration"]

---@type fun(musicFileName:string,):integer
_F.GetSoundFileDuration = jc["GetSoundFileDuration"]

---@type fun(soundHandle:sound,):boolean
_F.GetSoundIsLoading = jc["GetSoundIsLoading"]

---@type fun(soundHandle:sound,):boolean
_F.GetSoundIsPlaying = jc["GetSoundIsPlaying"]

---@type fun():ability
_F.GetSpellAbility = jc["GetSpellAbility"]

---施放技能
---施放技能
---响应施放技能单位事件,指代被施放的技能.
---@type fun():integer
_F.GetSpellAbilityId = jc["GetSpellAbilityId"]

---施法单位
---施法单位
---响应'施放技能'单位事件.
---@type fun():unit
_F.GetSpellAbilityUnit = jc["GetSpellAbilityUnit"]

---技能施放目标(可破坏物)
---技能施放目标
---响应'施放技能'单位事件并以可破坏物为目标时.注意:技能施放结束将无法捕获施放目标.
---@type fun():destructable
_F.GetSpellTargetDestructable = jc["GetSpellTargetDestructable"]

---技能施放目标
---技能施放目标
---响应施放技能单位事件并以物品为目标时.注意:技能施放结束将无法捕获施放目标.
---@type fun():item
_F.GetSpellTargetItem = jc["GetSpellTargetItem"]

---技能施放点
---技能施放点
---响应'技能施放'单位事件.注意技能施放结束将无法捕获该点.会创建点.
---@type fun():location
_F.GetSpellTargetLoc = jc["GetSpellTargetLoc"]

---技能施放目标
---技能施放目标
---响应'施放技能'单位事件并以单位为目标时.注意:技能施放结束将无法捕获施放目标.
---@type fun():unit
_F.GetSpellTargetUnit = jc["GetSpellTargetUnit"]

---技能施放点X坐标
---获取技能目标点的X坐标
---这是1.24的函数，但已加入函数库，在1.20也可以使用。
---@type fun():real
_F.GetSpellTargetX = jc["GetSpellTargetX"]

---技能施放点Y坐标
---获取技能目标点的Y坐标
---这是1.24的函数，但已加入函数库，在1.20也可以使用。
---@type fun():real
_F.GetSpellTargetY = jc["GetSpellTargetY"]

---@type fun(whichStartLoc:integer,prioSlotIndex:integer,):startlocprio
_F.GetStartLocPrio = jc["GetStartLocPrio"]

---@type fun(whichStartLoc:integer,prioSlotIndex:integer,):integer
_F.GetStartLocPrioSlot = jc["GetStartLocPrioSlot"]

---@type fun(whichStartLocation:integer,):location
_F.GetStartLocationLoc = jc["GetStartLocationLoc"]

---@type fun(whichStartLocation:integer,):real
_F.GetStartLocationX = jc["GetStartLocationX"]

---@type fun(whichStartLocation:integer,):real
_F.GetStartLocationY = jc["GetStartLocationY"]

---读取布尔值[R]
---从${GameCache}中读取布尔值,类别:${Category},名称:${文字}
---如果该值不存在则返回false.
---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.GetStoredBoolean = jc["GetStoredBoolean"]

---缓存读取整数[C]
---从${GameCache}中读取整数值,类别:${Category},名称:${文字}
---如果该值不存在则返回0.
---@type fun(cache:gamecache,missionKey:string,key:string,):integer
_F.GetStoredInteger = jc["GetStoredInteger"]

---缓存读取实数[C]
---从${GameCache}中读取实数,类别:${Category}名称:${文字}
---如果该值不存在则返回0.
---@type fun(cache:gamecache,missionKey:string,key:string,):real
_F.GetStoredReal = jc["GetStoredReal"]

---读取字符串[C]
---从${GameCache}中读取字符串,类别:${Category}名称:${文字}
---如果该值不存在,则返回空字符串.注意,空字符串不等于null
---@type fun(cache:gamecache,missionKey:string,key:string,):string
_F.GetStoredString = jc["GetStoredString"]

---召唤单位
---召唤单位
---响应'召唤单位'单位事件,指代被召唤单位.
---@type fun():unit
_F.GetSummonedUnit = jc["GetSummonedUnit"]

---召唤者
---召唤者
---响应'召唤单位'单位事件.
---@type fun():unit
_F.GetSummoningUnit = jc["GetSummoningUnit"]

---队伍数量
---队伍数量
---@type fun():integer
_F.GetTeams = jc["GetTeams"]

---地形悬崖高度(指定坐标)[R]
---坐标(${X},${Y})处的地形悬崖高度
---悬崖高度:深水区为0,浅水区为1,平原为2,之后每层+1.
---@type fun(x:real,y:real,):integer
_F.GetTerrainCliffLevel = jc["GetTerrainCliffLevel"]

---指定坐标地形[R]
---坐标(${X},${Y})处的地形
---@type fun(x:real,y:real,):integer
_F.GetTerrainType = jc["GetTerrainType"]

---地形样式(指定坐标)[R]
---坐标(${X},${Y})处的地形样式
---@type fun(x:real,y:real,):integer
_F.GetTerrainVariance = jc["GetTerrainVariance"]

---@type fun():real
_F.GetTimeOfDayScale = jc["GetTimeOfDayScale"]

---@type fun():player
_F.GetTournamentFinishNowPlayer = jc["GetTournamentFinishNowPlayer"]

---比赛结束规则
---比赛结束规则
---1表示游戏开始时间已经超过限定时,无法以平局结束.其他值表示游戏还在初期阶段,此时退出游戏将以平局结束..
---@type fun():integer
_F.GetTournamentFinishNowRule = jc["GetTournamentFinishNowRule"]

---比赛剩余时间
---比赛剩余时间
---响应'比赛事件'游戏将要结束.单位为秒.
---@type fun():real
_F.GetTournamentFinishSoonTimeRemaining = jc["GetTournamentFinishSoonTimeRemaining"]

---对战比赛得分
---${Player}的当前对战比赛得分
---对战游戏时如果游戏时间过长,系统将以该值来决定胜负.
---@type fun(whichPlayer:player,):integer
_F.GetTournamentScore = jc["GetTournamentScore"]

---训练单位
---训练单位
---响应'完成训练单位'单位事件,指代被训练单位.
---@type fun():unit
_F.GetTrainedUnit = jc["GetTrainedUnit"]

---训练单位类型
---训练单位类型
---响应'开始/取消/完成训练单位'单位事件,指代所训练的单位类型.
---@type fun():integer
_F.GetTrainedUnitType = jc["GetTrainedUnitType"]

---@type fun():unit
_F.GetTransportUnit = jc["GetTransportUnit"]

---@type fun():destructable
_F.GetTriggerDestructable = jc["GetTriggerDestructable"]

---触发条件判断次数
---${Trigger}的触发条件判断次数
---@type fun(whichTrigger:trigger,):integer
_F.GetTriggerEvalCount = jc["GetTriggerEvalCount"]

---@type fun():eventid
_F.GetTriggerEventId = jc["GetTriggerEventId"]

---触发动作运行次数
---${Trigger}的触发动作运行次数
---@type fun(whichTrigger:trigger,):integer
_F.GetTriggerExecCount = jc["GetTriggerExecCount"]

---触发玩家
---触发玩家
---@type fun():player
_F.GetTriggerPlayer = jc["GetTriggerPlayer"]

---触发单位
---触发单位
---@type fun():unit
_F.GetTriggerUnit = jc["GetTriggerUnit"]

---@type fun():widget
_F.GetTriggerWidget = jc["GetTriggerWidget"]

---触发区域[R]
---触发区域
---响应单位进入/离开不规则区域事件.
---@type fun():region
_F.GetTriggeringRegion = jc["GetTriggeringRegion"]

---事件响应-触发可追踪物[R]
---事件响应-触发可追踪物
---@type fun():trackable
_F.GetTriggeringTrackable = jc["GetTriggeringTrackable"]

---当前触发
---当前触发
---当前所运行的触发器.
---@type fun():trigger
_F.GetTriggeringTrigger = jc["GetTriggeringTrigger"]

---单位技能等级[R]
---${单位}的${技能}技能等级
---如果单位没有该技能,则返回0.
---@type fun(whichUnit:unit,abilcode:integer,):integer
_F.GetUnitAbilityLevel = jc["GetUnitAbilityLevel"]

---当前主动攻击范围
---${单位}的当前主动攻击范围
---@type fun(whichUnit:unit,):real
_F.GetUnitAcquireRange = jc["GetUnitAcquireRange"]

---当前命令ID
---${单位}的当前命令ID.
---@type fun(whichUnit:unit,):integer
_F.GetUnitCurrentOrder = jc["GetUnitCurrentOrder"]

---默认主动攻击范围
---${单位}的默认主动攻击范围
---@type fun(whichUnit:unit,):real
_F.GetUnitDefaultAcquireRange = jc["GetUnitDefaultAcquireRange"]

---默认飞行高度
---${单位}的默认飞行高度
---飞行单位可以直接改变飞行高度.其他单位通过添加/删除替换为飞行单位的变身技能(如乌鸦形态)之后,也能改变飞行高度.
---@type fun(whichUnit:unit,):real
_F.GetUnitDefaultFlyHeight = jc["GetUnitDefaultFlyHeight"]

---默认移动速度
---${单位}的默认移动速度
---@type fun(whichUnit:unit,):real
_F.GetUnitDefaultMoveSpeed = jc["GetUnitDefaultMoveSpeed"]

---@type fun(whichUnit:unit,):real
_F.GetUnitDefaultPropWindow = jc["GetUnitDefaultPropWindow"]

---默认转身速度
---${单位}的默认转身速度
---转身速度表示单位改变面向方向时的速度.数值越小表示转身越慢.
---@type fun(whichUnit:unit,):real
_F.GetUnitDefaultTurnSpeed = jc["GetUnitDefaultTurnSpeed"]

---面向角度
---${单位}的面向角度
---采用角度制.0度为正东方向,90度为正北方向.
---@type fun(whichUnit:unit,):real
_F.GetUnitFacing = jc["GetUnitFacing"]

---当前飞行高度
---${单位}的当前飞行高度
---飞行单位可以直接改变飞行高度.其他单位通过添加/删除替换为飞行单位的变身技能(如乌鸦形态)之后,也能改变飞行高度.
---@type fun(whichUnit:unit,):real
_F.GetUnitFlyHeight = jc["GetUnitFlyHeight"]

---单位提供人口数量
---${单位}提供的人口数量
---@type fun(whichUnit:unit,):integer
_F.GetUnitFoodMade = jc["GetUnitFoodMade"]

---单位使用人口数量
---${单位}使用的人口数量
---@type fun(whichUnit:unit,):integer
_F.GetUnitFoodUsed = jc["GetUnitFoodUsed"]

---单位等级
---${单位}的等级
---对于英雄则会返回其英雄等级.
---@type fun(whichUnit:unit,):integer
_F.GetUnitLevel = jc["GetUnitLevel"]

---单位位置
---${单位}的位置
---会创建点.
---@type fun(whichUnit:unit,):location
_F.GetUnitLoc = jc["GetUnitLoc"]

---当前移动速度
---${单位}的当前移动速度
---@type fun(whichUnit:unit,):real
_F.GetUnitMoveSpeed = jc["GetUnitMoveSpeed"]

---单位名字
---${单位}的名字
---@type fun(whichUnit:unit,):string
_F.GetUnitName = jc["GetUnitName"]

---单位附加值
---${单位}的附加值
---单位附加值不可改变.可以做一些特殊用途.比如TD地图中的建筑贩卖价格.
---@type fun(whichUnit:unit,):integer
_F.GetUnitPointValue = jc["GetUnitPointValue"]

---单位附加值(指定单位类型)
---${单位类型}的附加值
---单位附加值不可改变.可以做一些特殊用途.比如TD地图中的建筑贩卖价格.
---@type fun(unitType:integer,):integer
_F.GetUnitPointValueByType = jc["GetUnitPointValueByType"]

---当前转向角度(弧度制)[R]
---${单位}的当前转向角度(弧度制)
---单位转身时的转向角度.数值越大转向幅度越大.
---@type fun(whichUnit:unit,):real
_F.GetUnitPropWindow = jc["GetUnitPropWindow"]

---单位种族
---${单位}所属种族
---物体编辑器中设置的单位所属种族.
---@type fun(whichUnit:unit,):race
_F.GetUnitRace = jc["GetUnitRace"]

---单位集结点目标
---${单位}的集结点目标
---如果指定单位没有设置集结点到可破坏物上,则返回null.
---@type fun(whichUnit:unit,):destructable
_F.GetUnitRallyDestructable = jc["GetUnitRallyDestructable"]

---单位集结点
---${单位}的集结点位置
---如果单位没有设置集结点,则返回null.设置自己为集结点可取消集结点设置.会创建点.
---@type fun(whichUnit:unit,):location
_F.GetUnitRallyPoint = jc["GetUnitRallyPoint"]

---单位集结点目标
---${单位}的集结点目标
---如果指定单位没有设置集结点到单位目标,则返回null.
---@type fun(whichUnit:unit,):unit
_F.GetUnitRallyUnit = jc["GetUnitRallyUnit"]

---属性[R]
---${单位}的${Property}
---@type fun(whichUnit:unit,whichUnitState:unitstate,):real
_F.GetUnitState = jc["GetUnitState"]

---当前转身速度
---${单位}的当前转身速度
---转身速度表示单位改变面向方向时的速度.数值越小表示转身越慢.
---@type fun(whichUnit:unit,):real
_F.GetUnitTurnSpeed = jc["GetUnitTurnSpeed"]

---指定单位的类型
---${单位}的类型
---@type fun(whichUnit:unit,):integer
_F.GetUnitTypeId = jc["GetUnitTypeId"]

---单位自定义值
---${单位}的自定义值
---可使用'单位-设置自定义值'来设置该值.
---@type fun(whichUnit:unit,):integer
_F.GetUnitUserData = jc["GetUnitUserData"]

---单位所在X轴坐标[R]
---${单位}所在X轴坐标
---@type fun(whichUnit:unit,):real
_F.GetUnitX = jc["GetUnitX"]

---单位所在Y轴坐标[R]
---${单位}所在Y轴坐标
---@type fun(whichUnit:unit,):real
_F.GetUnitY = jc["GetUnitY"]

---@type fun(whichWidget:widget,):real
_F.GetWidgetLife = jc["GetWidgetLife"]

---@type fun(whichWidget:widget,):real
_F.GetWidgetX = jc["GetWidgetX"]

---@type fun(whichWidget:widget,):real
_F.GetWidgetY = jc["GetWidgetY"]

---@type fun():player
_F.GetWinningPlayer = jc["GetWinningPlayer"]

---@type fun():rect
_F.GetWorldBounds = jc["GetWorldBounds"]

---添加单位[R]
---为${单位组}添加${单位}
---并不影响单位本身.
---@type fun(whichGroup:group,whichUnit:unit,):nothing
_F.GroupAddUnit = jc["GroupAddUnit"]

---清空单位组
---清空${单位组}内所有单位
---并不影响单位本身.
---@type fun(whichGroup:group,):nothing
_F.GroupClear = jc["GroupClear"]

---选取单位添加到单位组(坐标)
---为${单位组}添加以(${坐标X},${坐标Y})为圆心，${半径}为半径的圆范围内，满足${条件}的单位
---@type fun(whichGroup:group,x:real,y:real,radius:real,filter:boolexpr,):nothing
_F.GroupEnumUnitsInRange = jc["GroupEnumUnitsInRange"]

---选取单位添加到单位组(坐标)(不建议使用)
---为${单位组}添加以(${坐标X},${坐标Y})为圆心，${半径}为半径的圆范围内，满足${条件}的单位。无效项(${N})
---最后一项是无效项，建议用上一个UI
---@type fun(whichGroup:group,x:real,y:real,radius:real,filter:boolexpr,countLimit:integer,):nothing
_F.GroupEnumUnitsInRangeCounted = jc["GroupEnumUnitsInRangeCounted"]

---选取单位添加到单位组(点)
---为${单位组}添加以${点}为圆心，${半径}为半径的圆范围内，满足${条件}的单位
---@type fun(whichGroup:group,whichLocation:location,radius:real,filter:boolexpr,):nothing
_F.GroupEnumUnitsInRangeOfLoc = jc["GroupEnumUnitsInRangeOfLoc"]

---选取单位添加到单位组(点)(不建议使用)
---为${单位组}添加以${点}为圆心，${半径}为半径的圆范围内，满足${条件}的单位。无效项(${N})
---最后一项是无效项，建议用上一个UI
---@type fun(whichGroup:group,whichLocation:location,radius:real,filter:boolexpr,countLimit:integer,):nothing
_F.GroupEnumUnitsInRangeOfLocCounted = jc["GroupEnumUnitsInRangeOfLocCounted"]

---@type fun(whichGroup:group,r:rect,filter:boolexpr,):nothing
_F.GroupEnumUnitsInRect = jc["GroupEnumUnitsInRect"]

---@type fun(whichGroup:group,r:rect,filter:boolexpr,countLimit:integer,):nothing
_F.GroupEnumUnitsInRectCounted = jc["GroupEnumUnitsInRectCounted"]

---@type fun(whichGroup:group,whichPlayer:player,filter:boolexpr,):nothing
_F.GroupEnumUnitsOfPlayer = jc["GroupEnumUnitsOfPlayer"]

---@type fun(whichGroup:group,unitname:string,filter:boolexpr,):nothing
_F.GroupEnumUnitsOfType = jc["GroupEnumUnitsOfType"]

---@type fun(whichGroup:group,unitname:string,filter:boolexpr,countLimit:integer,):nothing
_F.GroupEnumUnitsOfTypeCounted = jc["GroupEnumUnitsOfTypeCounted"]

---@type fun(whichGroup:group,whichPlayer:player,filter:boolexpr,):nothing
_F.GroupEnumUnitsSelected = jc["GroupEnumUnitsSelected"]

---发布命令(无目标)
---对${单位组}发布${Order}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:string,):boolean
_F.GroupImmediateOrder = jc["GroupImmediateOrder"]

---发布命令(无目标)(ID)
---对${单位组}发布${Order}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:integer,):boolean
_F.GroupImmediateOrderById = jc["GroupImmediateOrderById"]

---发布命令(指定坐标)[R]
---对${单位组}发布${Order}命令,目标点:(${X},${Y})
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:string,x:real,y:real,):boolean
_F.GroupPointOrder = jc["GroupPointOrder"]

---发布命令(指定坐标)(ID)
---对${单位组}发布${Order}命令,目标点:(${X},${Y})
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:integer,x:real,y:real,):boolean
_F.GroupPointOrderById = jc["GroupPointOrderById"]

---发布命令(指定点)(ID)
---对${单位组}发布${Order}命令,目标:${指定点}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:integer,whichLocation:location,):boolean
_F.GroupPointOrderByIdLoc = jc["GroupPointOrderByIdLoc"]

---发布命令(指定点)
---对${单位组}发布${Order}命令,目标:${指定点}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:string,whichLocation:location,):boolean
_F.GroupPointOrderLoc = jc["GroupPointOrderLoc"]

---移除单位[R]
---为${单位组}删除${单位}
---并不影响单位本身.
---@type fun(whichGroup:group,whichUnit:unit,):nothing
_F.GroupRemoveUnit = jc["GroupRemoveUnit"]

---发布命令(指定单位)
---对${单位组}发布${Order}命令,目标:${单位}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:string,targetWidget:widget,):boolean
_F.GroupTargetOrder = jc["GroupTargetOrder"]

---发布命令(指定单位)(ID)
---对${单位组}发布${Order}命令,目标:${单位}
---最多只能对单位组中12个单位发布命令.
---@type fun(whichGroup:group,order:integer,targetWidget:widget,):boolean
_F.GroupTargetOrderById = jc["GroupTargetOrderById"]

---@type fun()
_F.HaveSavedBoolean = jc["HaveSavedBoolean"]

---@type fun()
_F.HaveSavedHandle = jc["HaveSavedHandle"]

---@type fun()
_F.HaveSavedInteger = jc["HaveSavedInteger"]

---@type fun()
_F.HaveSavedReal = jc["HaveSavedReal"]

---@type fun(table:hashtable,parentKey:integer,childKey:integer,):boolean
_F.HaveSavedString = jc["HaveSavedString"]

---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.HaveStoredBoolean = jc["HaveStoredBoolean"]

---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.HaveStoredInteger = jc["HaveStoredInteger"]

---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.HaveStoredReal = jc["HaveStoredReal"]

---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.HaveStoredString = jc["HaveStoredString"]

---@type fun(cache:gamecache,missionKey:string,key:string,):boolean
_F.HaveStoredUnit = jc["HaveStoredUnit"]

---转换整数为实数
---转换${Integer}为实数
---@type fun(i:integer,):real
_F.I2R = jc["I2R"]

---转换整数为字符串
---转换${Integer}为字符串
---@type fun(i:integer,):string
_F.I2S = jc["I2S"]

---提升技能等级[R]
---使${单位}的${技能}等级提升1级
---改变死亡单位的光环技能会导致魔兽崩溃.
---@type fun(whichUnit:unit,abilcode:integer,):integer
_F.IncUnitAbilityLevel = jc["IncUnitAbilityLevel"]

---新建游戏缓存[R]
---新建游戏缓存:${缓存名}
---创建一个新的游戏缓存,一个地图最多只有有256个游戏缓存.
---@type fun(campaignFile:string,):gamecache
_F.InitGameCache = jc["InitGameCache"]

---<1.24>新建哈希表[C]
---创建一个新的哈希表
---您可以使用哈希表来储存临时数据
---@type fun():hashtable
_F.InitHashtable = jc["InitHashtable"]

---@type fun():boolean
_F.IsCineFilterDisplayed = jc["IsCineFilterDisplayed"]

---@type fun(d:destructable,):boolean
_F.IsDestructableInvulnerable = jc["IsDestructableInvulnerable"]

---战争迷雾开启
---战争迷雾开启
---@type fun():boolean
_F.IsFogEnabled = jc["IsFogEnabled"]

---黑色阴影开启
---黑色阴影开启
---@type fun():boolean
_F.IsFogMaskEnabled = jc["IsFogMaskEnabled"]

---坐标在迷雾中
---坐标(${x},${y})在${玩家}的迷雾范围内
---黑色阴影内的坐标不被计算在内。
---@type fun(x:real,y:real,whichPlayer:player,):boolean
_F.IsFoggedToPlayer = jc["IsFoggedToPlayer"]

---@type fun(whichGameType:gametype,):boolean
_F.IsGameTypeSupported = jc["IsGameTypeSupported"]

---@type fun(unitId:integer,):boolean
_F.IsHeroUnitId = jc["IsHeroUnitId"]

---@type fun(itemId:integer,):boolean
_F.IsItemIdPawnable = jc["IsItemIdPawnable"]

---@type fun(itemId:integer,):boolean
_F.IsItemIdPowerup = jc["IsItemIdPowerup"]

---@type fun(itemId:integer,):boolean
_F.IsItemIdSellable = jc["IsItemIdSellable"]

---物品无敌
---${物品}是无敌的
---@type fun(whichItem:item,):boolean
_F.IsItemInvulnerable = jc["IsItemInvulnerable"]

---物品被持有
---${物品}是被持有的
---在物品栏中的物品都是被持有的.就算单位正处于死亡状态.
---@type fun(whichItem:item,):boolean
_F.IsItemOwned = jc["IsItemOwned"]

---物品可被抵押[R]
---${物品}可被抵押
---@type fun(whichItem:item,):boolean
_F.IsItemPawnable = jc["IsItemPawnable"]

---物品是拾取时自动使用的[R]
---${物品}是拾取时自动使用类物品
---@type fun(whichItem:item,):boolean
_F.IsItemPowerup = jc["IsItemPowerup"]

---物品可被市场随机出售[R]
---${物品}可被市场随机出售
---@type fun(whichItem:item,):boolean
_F.IsItemSellable = jc["IsItemSellable"]

---物品可见[R]
---${物品}是可见的
---物品不被隐藏且不被单位持有时即为可见的.
---@type fun(whichItem:item,):boolean
_F.IsItemVisible = jc["IsItemVisible"]

---@type fun(lb:leaderboard,):boolean
_F.IsLeaderboardDisplayed = jc["IsLeaderboardDisplayed"]

---点在迷雾中
---${指定点}在${Player}的迷雾范围内
---黑色阴影内的点不被计算在内.
---@type fun(whichLocation:location,whichPlayer:player,):boolean
_F.IsLocationFoggedToPlayer = jc["IsLocationFoggedToPlayer"]

---包含点
---${不规则区域}内包含点:${点}
---TC_REGION
---@type fun(whichRegion:region,whichLocation:location,):boolean
_F.IsLocationInRegion = jc["IsLocationInRegion"]

---点在黑色阴影中
---${指定点}在${Player}的黑色阴影内
---@type fun(whichLocation:location,whichPlayer:player,):boolean
_F.IsLocationMaskedToPlayer = jc["IsLocationMaskedToPlayer"]

---点可见
---${指定点}对${Player}可见
---@type fun(whichLocation:location,whichPlayer:player,):boolean
_F.IsLocationVisibleToPlayer = jc["IsLocationVisibleToPlayer"]

---地图参数设置
---${MapFlag}已设置
---@type fun(whichMapFlag:mapflag,):boolean
_F.IsMapFlagSet = jc["IsMapFlagSet"]

---坐标在黑色阴影中
---坐标(${x},${y})在${玩家}的黑色阴影内
---@type fun(x:real,y:real,whichPlayer:player,):boolean
_F.IsMaskedToPlayer = jc["IsMaskedToPlayer"]

---多面板显示
---${Multiboard}是显示的
---@type fun(lb:multiboard,):boolean
_F.IsMultiboardDisplayed = jc["IsMultiboardDisplayed"]

---多面板最小化
---${Multiboard}是最小化的
---@type fun(lb:multiboard,):boolean
_F.IsMultiboardMinimized = jc["IsMultiboardMinimized"]

---无法失败[R]
---玩家开启作弊模式:无法失败
---单机作弊码开启的模式.
---@type fun():boolean
_F.IsNoDefeatCheat = jc["IsNoDefeatCheat"]

---无法胜利[R]
---玩家开启作弊模式:无法胜利
---单机作弊码开启的模式.
---@type fun():boolean
_F.IsNoVictoryCheat = jc["IsNoVictoryCheat"]

---是玩家的盟友
---${Player}是${Player}的盟友
---包括中立状态.单向判断玩家A对玩家B联盟不侵犯,即表示玩家A是玩家B的盟友.
---@type fun(whichPlayer:player,otherPlayer:player,):boolean
_F.IsPlayerAlly = jc["IsPlayerAlly"]

---是玩家的敌人
---${Player}是${Player}的敌人
---不包括中立状态.单向判断玩家A对玩家B敌对侵犯,即表示玩家A是玩家B的盟友.
---@type fun(whichPlayer:player,otherPlayer:player,):boolean
_F.IsPlayerEnemy = jc["IsPlayerEnemy"]

---在玩家组
---${Player}在${玩家组}中
---@type fun(whichPlayer:player,whichForce:force,):boolean
_F.IsPlayerInForce = jc["IsPlayerInForce"]

---玩家是裁判或观察者[R]
---${Player}是裁判或观察者
---@type fun(whichPlayer:player,):boolean
_F.IsPlayerObserver = jc["IsPlayerObserver"]

---玩家的种族选择
---${Player}选择了${RacePreference}
---@type fun(whichPlayer:player,pref:racepreference,):boolean
_F.IsPlayerRacePrefSet = jc["IsPlayerRacePrefSet"]

---坐标点被荒芜地表覆盖[R]
---坐标点(${X},${Y})被荒芜地表覆盖
---@type fun(x:real,y:real,):boolean
_F.IsPointBlighted = jc["IsPointBlighted"]

---包含坐标
---${不规则区域}内包含坐标(${X},${Y})
---TC_REGION
---@type fun(whichRegion:region,x:real,y:real,):boolean
_F.IsPointInRegion = jc["IsPointInRegion"]

---任务完成
---${Quest}已完成
---@type fun(whichQuest:quest,):boolean
_F.IsQuestCompleted = jc["IsQuestCompleted"]

---任务被发现
---${Quest}已被发现
---@type fun(whichQuest:quest,):boolean
_F.IsQuestDiscovered = jc["IsQuestDiscovered"]

---任务激活
---${Quest}已激活
---@type fun(whichQuest:quest,):boolean
_F.IsQuestEnabled = jc["IsQuestEnabled"]

---任务失败
---${Quest}失败
---@type fun(whichQuest:quest,):boolean
_F.IsQuestFailed = jc["IsQuestFailed"]

---任务项目完成
---${QuestRequirement}已完成
---@type fun(whichQuestItem:questitem,):boolean
_F.IsQuestItemCompleted = jc["IsQuestItemCompleted"]

---是主要任务
---${Quest}是主要任务
---@type fun(whichQuest:quest,):boolean
_F.IsQuestRequired = jc["IsQuestRequired"]

---经验不可获得
---${Hero}不可获得经验
---可使用'英雄-允许/禁止经验获取'来设置该项.
---@type fun(whichHero:unit,):boolean
_F.IsSuspendedXP = jc["IsSuspendedXP"]

---地形通行状态关闭(指定坐标)[R]
---坐标(${X},${Y})处的${PathingType}通行状态为关闭
---指定类型单位不能通行即通行状态为关闭.如该点不能造建筑就是'建造'通行状态为关闭.可使用'环境-设置地形通行状态'来改变通行状态.
---@type fun(x:real,y:real,t:pathingtype,):boolean
_F.IsTerrainPathable = jc["IsTerrainPathable"]

---@type fun(whichDialog:timerdialog,):boolean
_F.IsTimerDialogDisplayed = jc["IsTimerDialogDisplayed"]

---触发开启
---${触发}处于开启状态
---@type fun(whichTrigger:trigger,):boolean
_F.IsTriggerEnabled = jc["IsTriggerEnabled"]

---@type fun(whichTrigger:trigger,):boolean
_F.IsTriggerWaitOnSleeps = jc["IsTriggerWaitOnSleeps"]

---单位检查
---${单位}与${单位}相同
---用来判断两个单位是否相等。
---@type fun(whichUnit:unit,whichSpecifiedUnit:unit,):boolean
_F.IsUnit = jc["IsUnit"]

---是玩家的同盟单位
---${单位}是${Player}的同盟单位
---包括中立状态.单向判断玩家对单位是否为不侵犯状态.
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitAlly = jc["IsUnitAlly"]

---被检测到
---${单位}处在${玩家}的真实视野范围内
---用来判断单位在这个玩家反隐形范围内，注：不包含该玩家同盟的反隐范围。
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitDetected = jc["IsUnitDetected"]

---是玩家的敌对单位
---${单位}是${Player}的敌对单位
---不包括中立状态.单向判断玩家对单位是否为敌对侵犯.
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitEnemy = jc["IsUnitEnemy"]

---单位在迷雾中
---${单位}在${Player}的迷雾范围内
---黑色阴影内的单位不被计算在内.
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitFogged = jc["IsUnitFogged"]

---@type fun(whichUnit:unit,):boolean
_F.IsUnitHidden = jc["IsUnitHidden"]

---单位类别检查(指定单位类型)
---${单位类型}是${Type}
---@type fun(unitId:integer,whichUnitType:unittype,):boolean
_F.IsUnitIdType = jc["IsUnitIdType"]

---@type fun(whichUnit:unit,):boolean
_F.IsUnitIllusion = jc["IsUnitIllusion"]

---是玩家组里玩家的单位
---${单位}属于${玩家组}里的玩家
---判断单位是否属于这个玩家组里的玩家。
---@type fun(whichUnit:unit,whichForce:force,):boolean
_F.IsUnitInForce = jc["IsUnitInForce"]

---在单位组
---${单位}在${单位组}中
---@type fun(whichUnit:unit,whichGroup:group,):boolean
_F.IsUnitInGroup = jc["IsUnitInGroup"]

---在指定单位范围内[R]
---${单位}在距离${指定单位}${范围}范围内
---@type fun(whichUnit:unit,otherUnit:unit,distance:real,):boolean
_F.IsUnitInRange = jc["IsUnitInRange"]

---在指定点范围内[R]
---${单位}在距离${指定点}${范围}范围内
---@type fun(whichUnit:unit,whichLocation:location,distance:real,):boolean
_F.IsUnitInRangeLoc = jc["IsUnitInRangeLoc"]

---在指定坐标范围内[R]
---${单位}在距离坐标(${X},${Y})${范围}范围内
---@type fun(whichUnit:unit,x:real,y:real,distance:real,):boolean
_F.IsUnitInRangeXY = jc["IsUnitInRangeXY"]

---在不规则区域内[R]
---${不规则区域}内存在${单位}
---@type fun(whichRegion:region,whichUnit:unit,):boolean
_F.IsUnitInRegion = jc["IsUnitInRegion"]

---@type fun(whichUnit:unit,whichTransport:unit,):boolean
_F.IsUnitInTransport = jc["IsUnitInTransport"]

---单位不可见
---${单位}对${Player}不可见
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitInvisible = jc["IsUnitInvisible"]

---@type fun(whichUnit:unit,):boolean
_F.IsUnitLoaded = jc["IsUnitLoaded"]

---单位在黑色阴影中
---${单位}在${Player}的黑色阴影内
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitMasked = jc["IsUnitMasked"]

---是玩家的单位
---${单位}属于${Player}
---判断单位是否属于这个玩家。
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitOwnedByPlayer = jc["IsUnitOwnedByPlayer"]

---@type fun(whichHero:unit,):boolean
_F.IsUnitPaused = jc["IsUnitPaused"]

---单位种族检查
---${单位}是${Race}
---@type fun(whichUnit:unit,whichRace:race,):boolean
_F.IsUnitRace = jc["IsUnitRace"]

---被玩家选择
---${单位}被${Player}选择
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitSelected = jc["IsUnitSelected"]

---单位类别检查
---${单位}是${Type}
---@type fun(whichUnit:unit,whichUnitType:unittype,):boolean
_F.IsUnitType = jc["IsUnitType"]

---单位可见
---${单位}对${Player}可见
---@type fun(whichUnit:unit,whichPlayer:player,):boolean
_F.IsUnitVisible = jc["IsUnitVisible"]

---坐标可见
---坐标(${x},${y})对${玩家}可见
---@type fun(x:real,y:real,whichPlayer:player,):boolean
_F.IsVisibleToPlayer = jc["IsVisibleToPlayer"]

---@type fun(whichPeon:unit,unitToBuild:string,x:real,y:real,):boolean
_F.IssueBuildOrder = jc["IssueBuildOrder"]

---发布建造命令(指定坐标)[R]
---命令${单位}建造${单位类型}在坐标:(${X},${Y})
---@type fun(whichPeon:unit,unitId:integer,x:real,y:real,):boolean
_F.IssueBuildOrderById = jc["IssueBuildOrderById"]

---发布命令(无目标)
---对${单位}发布${Order}命令
---@type fun(whichUnit:unit,order:string,):boolean
_F.IssueImmediateOrder = jc["IssueImmediateOrder"]

---发布命令(无目标)(ID)
---对${单位}发布${Order}命令
---@type fun(whichUnit:unit,order:integer,):boolean
_F.IssueImmediateOrderById = jc["IssueImmediateOrderById"]

---@type fun(whichUnit:unit,order:string,x:real,y:real,instantTargetWidget:widget,):boolean
_F.IssueInstantPointOrder = jc["IssueInstantPointOrder"]

---@type fun(whichUnit:unit,order:integer,x:real,y:real,instantTargetWidget:widget,):boolean
_F.IssueInstantPointOrderById = jc["IssueInstantPointOrderById"]

---@type fun(whichUnit:unit,order:string,targetWidget:widget,instantTargetWidget:widget,):boolean
_F.IssueInstantTargetOrder = jc["IssueInstantTargetOrder"]

---@type fun(whichUnit:unit,order:integer,targetWidget:widget,instantTargetWidget:widget,):boolean
_F.IssueInstantTargetOrderById = jc["IssueInstantTargetOrderById"]

---发布中介命令(无目标)
---使${玩家}对${单位}发布${Order}命令
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitToBuild:string,):boolean
_F.IssueNeutralImmediateOrder = jc["IssueNeutralImmediateOrder"]

---发布中介命令(无目标)(ID)
---使${玩家}对${单位}发布${Order}命令
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitId:integer,):boolean
_F.IssueNeutralImmediateOrderById = jc["IssueNeutralImmediateOrderById"]

---发布中介命令(指定坐标)
---使${玩家}对${单位}发布${Order}命令到坐标:(${X},${Y})
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitToBuild:string,x:real,y:real,):boolean
_F.IssueNeutralPointOrder = jc["IssueNeutralPointOrder"]

---发布中介命令(指定坐标)(ID)
---使${玩家}对${单位}发布${Order}命令到坐标:(${X},${Y})
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitId:integer,x:real,y:real,):boolean
_F.IssueNeutralPointOrderById = jc["IssueNeutralPointOrderById"]

---发布中介命令(指定单位)
---使${玩家}对${单位}发布${Order}命令到目标:${单位}
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitToBuild:string,target:widget,):boolean
_F.IssueNeutralTargetOrder = jc["IssueNeutralTargetOrder"]

---发布中介命令(指定单位)(ID)
---使${玩家}对${单位}发布${Order}命令到目标:${单位}
---可以用来对非本玩家单位发布命令.
---@type fun(forWhichPlayer:player,neutralStructure:unit,unitId:integer,target:widget,):boolean
_F.IssueNeutralTargetOrderById = jc["IssueNeutralTargetOrderById"]

---发布命令(指定坐标)
---对${单位}发布${Order}命令到坐标:(${X},${Y})
---@type fun(whichUnit:unit,order:string,x:real,y:real,):boolean
_F.IssuePointOrder = jc["IssuePointOrder"]

---发布命令(指定坐标)(ID)
---对${单位}发布${Order}命令到坐标:(${X},${Y})
---@type fun(whichUnit:unit,order:integer,x:real,y:real,):boolean
_F.IssuePointOrderById = jc["IssuePointOrderById"]

---发布命令(指定点)(ID)
---对${单位}发布${Order}命令到目标点:${指定点}
---@type fun(whichUnit:unit,order:integer,whichLocation:location,):boolean
_F.IssuePointOrderByIdLoc = jc["IssuePointOrderByIdLoc"]

---发布命令(指定点)
---对${单位}发布${Order}命令到目标点:${指定点}
---@type fun(whichUnit:unit,order:string,whichLocation:location,):boolean
_F.IssuePointOrderLoc = jc["IssuePointOrderLoc"]

---发布命令(指定单位)
---对${单位}发布${Order}命令到目标:${单位}
---@type fun(whichUnit:unit,order:string,targetWidget:widget,):boolean
_F.IssueTargetOrder = jc["IssueTargetOrder"]

---发布命令(指定单位)(ID)
---对${单位}发布${Order}命令到目标:${单位}
---@type fun(whichUnit:unit,order:integer,targetWidget:widget,):boolean
_F.IssueTargetOrderById = jc["IssueTargetOrderById"]

---添加物品类型[R]
---在${物品池}中添加一个${物品}比重为${数值}
---比重越高被选择的机率越大.
---@type fun(whichItemPool:itempool,itemId:integer,weight:real,):nothing
_F.ItemPoolAddItemType = jc["ItemPoolAddItemType"]

---删除物品类型[R]
---从${物品池}中删除${物品}
---@type fun(whichItemPool:itempool,itemId:integer,):nothing
_F.ItemPoolRemoveItemType = jc["ItemPoolRemoveItemType"]

---杀死
---杀死${可破坏物}
---@type fun(d:destructable,):nothing
_F.KillDestructable = jc["KillDestructable"]

---@type fun(soundHandle:sound,):nothing
_F.KillSoundWhenDone = jc["KillSoundWhenDone"]

---杀死
---杀死${单位}
---@type fun(whichUnit:unit,):nothing
_F.KillUnit = jc["KillUnit"]

---@type fun(lb:leaderboard,label:string,value:integer,p:player,):nothing
_F.LeaderboardAddItem = jc["LeaderboardAddItem"]

---清空[R]
---清空${排行榜}
---清空排行榜中所有内容.
---@type fun(lb:leaderboard,):nothing
_F.LeaderboardClear = jc["LeaderboardClear"]

---显示/隐藏[R]
---设置${排行榜}${Show/Hide}
---排行榜不能在地图初始化时显示.
---@type fun(lb:leaderboard,show:boolean,):nothing
_F.LeaderboardDisplay = jc["LeaderboardDisplay"]

---行数
---${Leaderboard}的行数
---@type fun(lb:leaderboard,):integer
_F.LeaderboardGetItemCount = jc["LeaderboardGetItemCount"]

---@type fun(lb:leaderboard,):string
_F.LeaderboardGetLabelText = jc["LeaderboardGetLabelText"]

---@type fun(lb:leaderboard,p:player,):integer
_F.LeaderboardGetPlayerIndex = jc["LeaderboardGetPlayerIndex"]

---@type fun(lb:leaderboard,p:player,):boolean
_F.LeaderboardHasPlayerItem = jc["LeaderboardHasPlayerItem"]

---@type fun(lb:leaderboard,index:integer,):nothing
_F.LeaderboardRemoveItem = jc["LeaderboardRemoveItem"]

---@type fun(lb:leaderboard,p:player,):nothing
_F.LeaderboardRemovePlayerItem = jc["LeaderboardRemovePlayerItem"]

---@type fun(lb:leaderboard,whichItem:integer,val:string,):nothing
_F.LeaderboardSetItemLabel = jc["LeaderboardSetItemLabel"]

---@type fun(lb:leaderboard,whichItem:integer,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.LeaderboardSetItemLabelColor = jc["LeaderboardSetItemLabelColor"]

---@type fun(lb:leaderboard,whichItem:integer,showLabel:boolean,showValue:boolean,showIcon:boolean,):nothing
_F.LeaderboardSetItemStyle = jc["LeaderboardSetItemStyle"]

---@type fun(lb:leaderboard,whichItem:integer,val:integer,):nothing
_F.LeaderboardSetItemValue = jc["LeaderboardSetItemValue"]

---@type fun(lb:leaderboard,whichItem:integer,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.LeaderboardSetItemValueColor = jc["LeaderboardSetItemValueColor"]

---@type fun(lb:leaderboard,label:string,):nothing
_F.LeaderboardSetLabel = jc["LeaderboardSetLabel"]

---设置文字颜色[R]
---设置${Leaderboard}的文字颜色为(${Red},${Green},${Blue})Alpha通道值为:${Transparency}
---颜色格式为(红,绿,蓝).Alpha通道值0为不可见.颜色值和Alpha通道值取值范围为0-255.
---@type fun(lb:leaderboard,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.LeaderboardSetLabelColor = jc["LeaderboardSetLabelColor"]

---@type fun(lb:leaderboard,count:integer,):nothing
_F.LeaderboardSetSizeByItemCount = jc["LeaderboardSetSizeByItemCount"]

---@type fun(lb:leaderboard,showLabel:boolean,showNames:boolean,showValues:boolean,showIcons:boolean,):nothing
_F.LeaderboardSetStyle = jc["LeaderboardSetStyle"]

---设置数值颜色[R]
---设置${Leaderboard}的数值颜色为(${Red},${Green},${Blue})Alpha通道值为:${Transparency}
---颜色格式为(红,绿,蓝).Alpha通道值0为不可见.颜色值和Alpha通道值取值范围为0-255.
---@type fun(lb:leaderboard,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.LeaderboardSetValueColor = jc["LeaderboardSetValueColor"]

---@type fun(lb:leaderboard,ascending:boolean,):nothing
_F.LeaderboardSortItemsByLabel = jc["LeaderboardSortItemsByLabel"]

---@type fun(lb:leaderboard,ascending:boolean,):nothing
_F.LeaderboardSortItemsByPlayer = jc["LeaderboardSortItemsByPlayer"]

---@type fun(lb:leaderboard,ascending:boolean,):nothing
_F.LeaderboardSortItemsByValue = jc["LeaderboardSortItemsByValue"]

---@type fun()
_F.LoadAbilityHandle = jc["LoadAbilityHandle"]

---<1.24>从哈希表提取布尔[C]
---在${Hashtable}的主索引${Value}子索引${Value}内提取布尔
---如果不存在则返回False
---@type fun(table:hashtable,parentKey:integer,childKey:integer,):boolean
_F.LoadBoolean = jc["LoadBoolean"]

---@type fun()
_F.LoadBooleanExprHandle = jc["LoadBooleanExprHandle"]

---@type fun()
_F.LoadButtonHandle = jc["LoadButtonHandle"]

---@type fun()
_F.LoadDefeatConditionHandle = jc["LoadDefeatConditionHandle"]

---@type fun()
_F.LoadDestructableHandle = jc["LoadDestructableHandle"]

---@type fun()
_F.LoadDialogHandle = jc["LoadDialogHandle"]

---@type fun()
_F.LoadEffectHandle = jc["LoadEffectHandle"]

---@type fun()
_F.LoadFogModifierHandle = jc["LoadFogModifierHandle"]

---@type fun()
_F.LoadFogStateHandle = jc["LoadFogStateHandle"]

---@type fun()
_F.LoadForceHandle = jc["LoadForceHandle"]

---@type fun(saveFileName:string,doScoreScreen:boolean,):nothing
_F.LoadGame = jc["LoadGame"]

---@type fun()
_F.LoadGroupHandle = jc["LoadGroupHandle"]

---@type fun()
_F.LoadHashtableHandle = jc["LoadHashtableHandle"]

---@type fun()
_F.LoadImageHandle = jc["LoadImageHandle"]

---@type fun()
_F.LoadInteger = jc["LoadInteger"]

---@type fun()
_F.LoadItemHandle = jc["LoadItemHandle"]

---@type fun()
_F.LoadItemPoolHandle = jc["LoadItemPoolHandle"]

---@type fun()
_F.LoadLeaderboardHandle = jc["LoadLeaderboardHandle"]

---@type fun()
_F.LoadLightningHandle = jc["LoadLightningHandle"]

---@type fun()
_F.LoadLocationHandle = jc["LoadLocationHandle"]

---@type fun()
_F.LoadMultiboardHandle = jc["LoadMultiboardHandle"]

---@type fun()
_F.LoadMultiboardItemHandle = jc["LoadMultiboardItemHandle"]

---@type fun()
_F.LoadPlayerHandle = jc["LoadPlayerHandle"]

---@type fun()
_F.LoadQuestHandle = jc["LoadQuestHandle"]

---@type fun()
_F.LoadQuestItemHandle = jc["LoadQuestItemHandle"]

---@type fun()
_F.LoadReal = jc["LoadReal"]

---@type fun()
_F.LoadRectHandle = jc["LoadRectHandle"]

---@type fun()
_F.LoadRegionHandle = jc["LoadRegionHandle"]

---@type fun()
_F.LoadSoundHandle = jc["LoadSoundHandle"]

---@type fun()
_F.LoadStr = jc["LoadStr"]

---@type fun()
_F.LoadTextTagHandle = jc["LoadTextTagHandle"]

---@type fun()
_F.LoadTimerDialogHandle = jc["LoadTimerDialogHandle"]

---@type fun()
_F.LoadTimerHandle = jc["LoadTimerHandle"]

---@type fun()
_F.LoadTrackableHandle = jc["LoadTrackableHandle"]

---@type fun()
_F.LoadTriggerActionHandle = jc["LoadTriggerActionHandle"]

---@type fun()
_F.LoadTriggerConditionHandle = jc["LoadTriggerConditionHandle"]

---@type fun()
_F.LoadTriggerEventHandle = jc["LoadTriggerEventHandle"]

---@type fun()
_F.LoadTriggerHandle = jc["LoadTriggerHandle"]

---@type fun()
_F.LoadUbersplatHandle = jc["LoadUbersplatHandle"]

---@type fun()
_F.LoadUnitHandle = jc["LoadUnitHandle"]

---@type fun()
_F.LoadUnitPoolHandle = jc["LoadUnitPoolHandle"]

---@type fun()
_F.LoadWidgetHandle = jc["LoadWidgetHandle"]

---坐标点
---坐标(${X},${Y})
---会创建点.
---@type fun(x:real,y:real,):location
_F.Location = jc["Location"]

---@type fun(whichBolt:lightning,checkVisibility:boolean,x1:real,y1:real,x2:real,y2:real,):boolean
_F.MoveLightning = jc["MoveLightning"]

---移动闪电效果(指定坐标)[R]
---移动${Lightning}到新位置,(${Boolean}检查可见性)新起始点:(${X},${Y},${Z})新终结点:(${X},${Y},${Z})
---可指定Z坐标.允许检查可见性则在指定起始点和终结点都不可见时将不移动闪电效果.
---@type fun(whichBolt:lightning,checkVisibility:boolean,x1:real,y1:real,z1:real,x2:real,y2:real,z2:real,):boolean
_F.MoveLightningEx = jc["MoveLightningEx"]

---移动点[R]
---移动${点}到(${X},${Y})
---该点必须是一个变量.因为移动一个不可重用的点是无意义的.
---@type fun(whichLocation:location,newX:real,newY:real,):nothing
_F.MoveLocation = jc["MoveLocation"]

---移动矩形区域(指定坐标)[R]
---移动${矩形区域}到(${X},${Y})
---该区域必须是一个变量.目标点将作为该区域的新中心点.
---@type fun(whichRect:rect,newCenterX:real,newCenterY:real,):nothing
_F.MoveRectTo = jc["MoveRectTo"]

---移动矩形区域(指定点)
---移动${矩形区域}到${目标点}
---该区域必须是一个变量.目标点将作为该区域的新中心点.
---@type fun(whichRect:rect,newCenterLoc:location,):nothing
_F.MoveRectToLoc = jc["MoveRectToLoc"]

---清空多面板
---清空${Multiboard}
---清空该多面板中的所有行和列.
---@type fun(lb:multiboard,):nothing
_F.MultiboardClear = jc["MultiboardClear"]

---显示/隐藏[R]
---设置${Multiboard}${Show/Hide}
---多面板不能在地图初始化时显示.
---@type fun(lb:multiboard,show:boolean,):nothing
_F.MultiboardDisplay = jc["MultiboardDisplay"]

---列数
---${Multiboard}的列数
---@type fun(lb:multiboard,):integer
_F.MultiboardGetColumnCount = jc["MultiboardGetColumnCount"]

---多面板项目[R]
---${多面板}的第${X}行,第${Y}列项
---(0,0)作为多面板首项,会创建多面板项目.
---@type fun(lb:multiboard,row:integer,column:integer,):multiboarditem
_F.MultiboardGetItem = jc["MultiboardGetItem"]

---行数
---${Multiboard}的行数
---@type fun(lb:multiboard,):integer
_F.MultiboardGetRowCount = jc["MultiboardGetRowCount"]

---多面板标题
---${Multiboard}的标题
---@type fun(lb:multiboard,):string
_F.MultiboardGetTitleText = jc["MultiboardGetTitleText"]

---最大/最小化[R]
---设置${Multiboard}${Minimize/Maximize}
---最小化的多面板只显示标题.
---@type fun(lb:multiboard,minimize:boolean,):nothing
_F.MultiboardMinimize = jc["MultiboardMinimize"]

---删除多面板项目[R]
---删除${多面板项目}
---并不会影响对多面板的显示.多面板项目指向多面板但不附属于多面板.
---@type fun(mbi:multiboarditem,):nothing
_F.MultiboardReleaseItem = jc["MultiboardReleaseItem"]

---设置列数
---设置${Multiboard}的列数为${Columns}
---@type fun(lb:multiboard,count:integer,):nothing
_F.MultiboardSetColumnCount = jc["MultiboardSetColumnCount"]

---@type fun(mbi:multiboarditem,iconFileName:string,):nothing
_F.MultiboardSetItemIcon = jc["MultiboardSetItemIcon"]

---设置指定项目显示风格[R]
---设置${多面板项目}的显示风格:${Show/Hide}文字${Show/Hide}图标
---@type fun(mbi:multiboarditem,showValue:boolean,showIcon:boolean,):nothing
_F.MultiboardSetItemStyle = jc["MultiboardSetItemStyle"]

---设置指定项目文本[R]
---设置${多面板项目}的项目文本为${文字}
---@type fun(mbi:multiboarditem,val:string,):nothing
_F.MultiboardSetItemValue = jc["MultiboardSetItemValue"]

---设置指定项目颜色[R]
---设置${多面板项目}的项目颜色为(${Red},${Green},${Blue}),Alpha值为${Transparency}
---颜色格式为(红,绿,蓝).Alpha值为0是不可见的.颜色值和Alpha值取值范围为0-255.
---@type fun(mbi:multiboarditem,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.MultiboardSetItemValueColor = jc["MultiboardSetItemValueColor"]

---@type fun(mbi:multiboarditem,width:real,):nothing
_F.MultiboardSetItemWidth = jc["MultiboardSetItemWidth"]

---@type fun(lb:multiboard,iconPath:string,):nothing
_F.MultiboardSetItemsIcon = jc["MultiboardSetItemsIcon"]

---@type fun(lb:multiboard,showValues:boolean,showIcons:boolean,):nothing
_F.MultiboardSetItemsStyle = jc["MultiboardSetItemsStyle"]

---@type fun(lb:multiboard,value:string,):nothing
_F.MultiboardSetItemsValue = jc["MultiboardSetItemsValue"]

---设置所有项目颜色[R]
---设置${多面板}的所有项目颜色为(${Red},${Green},${Blue}),Alpha值为${Transparency}
---颜色格式为(红,绿,蓝).Alpha值为0是不可见的.颜色值和Alpha值取值范围为0-255.
---@type fun(lb:multiboard,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.MultiboardSetItemsValueColor = jc["MultiboardSetItemsValueColor"]

---@type fun(lb:multiboard,width:real,):nothing
_F.MultiboardSetItemsWidth = jc["MultiboardSetItemsWidth"]

---设置行数
---设置${Multiboard}的行数为${Rows}
---@type fun(lb:multiboard,count:integer,):nothing
_F.MultiboardSetRowCount = jc["MultiboardSetRowCount"]

---设置标题
---设置${Multiboard}的标题为${文字}
---@type fun(lb:multiboard,label:string,):nothing
_F.MultiboardSetTitleText = jc["MultiboardSetTitleText"]

---设置标题颜色[R]
---设置${Multiboard}的标题颜色为(${Red},${Green},${Blue}),Alpha值为${Transparency}
---颜色格式为(红,绿,蓝).Alpha值为0是不可见的.颜色值和Alpha值取值范围为0-255.
---@type fun(lb:multiboard,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.MultiboardSetTitleTextColor = jc["MultiboardSetTitleTextColor"]

---显示/隐藏多面板模式[R]
---${打开/关闭}隐藏多面板模式
---隐藏多面板模式将无法显示多面板.
---@type fun(flag:boolean,):nothing
_F.MultiboardSuppressDisplay = jc["MultiboardSuppressDisplay"]

---@type fun(environmentName:string,):nothing
_F.NewSoundEnvironment = jc["NewSoundEnvironment"]

---@type fun(operand:boolexpr,):boolexpr
_F.Not = jc["Not"]

---@type fun(operandA:boolexpr,operandB:boolexpr,):boolexpr
_F.Or = jc["Or"]

---@type fun(:string,):integer
_F.OrderId = jc["OrderId"]

---@type fun(orderId:integer,):string
_F.OrderId2String = jc["OrderId2String"]

---@type fun(x:real,y:real,):nothing
_F.PanCameraTo = jc["PanCameraTo"]

---平移镜头(所有玩家)(限时)[R]
---平移玩家镜头到(${X},${Y}),持续${Time}秒
---@type fun(x:real,y:real,duration:real,):nothing
_F.PanCameraToTimed = jc["PanCameraToTimed"]

---指定高度平移镜头(所有玩家)(限时)[R]
---平移玩家镜头到(${X},${Y}),镜头距离地面高度为${Z},持续${Time}秒
---在指定移动路径上镜头不会低于地面高度.
---@type fun(x:real,y:real,zOffsetDest:real,duration:real,):nothing
_F.PanCameraToTimedWithZ = jc["PanCameraToTimedWithZ"]

---@type fun(x:real,y:real,zOffsetDest:real,):nothing
_F.PanCameraToWithZ = jc["PanCameraToWithZ"]

---暂停/恢复AI脚本运行[R]
---设定${Player}${暂停/恢复}当前AI脚本的运行
---事实上该函数是有问题的,可以这么理解:设玩家当前AI脚本的运行状态R为0,暂停1次则R+1,恢复1次则R-1,仅当R=0时该玩家才会运行AI.在使用前请先理解这段话的意思.
---@type fun(p:player,pause:boolean,):nothing
_F.PauseCompAI = jc["PauseCompAI"]

---暂停/恢复游戏[R]
---${暂停/恢复}游戏
---@type fun(flag:boolean,):nothing
_F.PauseGame = jc["PauseGame"]

---暂停计时器[R]
---暂停${计时器}
---@type fun(whichTimer:timer,):nothing
_F.PauseTimer = jc["PauseTimer"]

---暂停/恢复[R]
---设置${单位}${Pause/Unpause}
---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.PauseUnit = jc["PauseUnit"]

---小地图信号(所有玩家)[R]
---对所有玩家发送小地图信号到坐标(${X},${Y})持续时间:${Duration}秒
---@type fun(x:real,y:real,duration:real,):nothing
_F.PingMinimap = jc["PingMinimap"]

---小地图信号(指定颜色)(所有玩家)[R]
---对所有玩家发送小地图信号到坐标(${X},${Y})持续时间:${Duration}秒,信号颜色:(${Red},${Green},${Blue})信号类型:${Style}
---颜色格式为(红,绿,蓝).颜色值取值范围为0-255.
---@type fun(x:real,y:real,duration:real,red:integer,green:integer,blue:integer,extraEffects:boolean,):nothing
_F.PingMinimapEx = jc["PingMinimapEx"]

---选择放置物品[R]
---从${物品池}中任意选择一个物品并放置到(${X},${Y})点
---@type fun(whichItemPool:itempool,x:real,y:real,):item
_F.PlaceRandomItem = jc["PlaceRandomItem"]

---选择放置单位[R]
---从${单位池}中为${玩家}任意选择一个单位并放置到点(${X},${Y})面向${度}
---@type fun(whichPool:unitpool,forWhichPlayer:player,x:real,y:real,facing:real,):unit
_F.PlaceRandomUnit = jc["PlaceRandomUnit"]

---@type fun(movieName:string,):nothing
_F.PlayCinematic = jc["PlayCinematic"]

---@type fun(modelName:string,):nothing
_F.PlayModelCinematic = jc["PlayModelCinematic"]

---@type fun(musicName:string,):nothing
_F.PlayMusic = jc["PlayMusic"]

---@type fun(musicName:string,frommsecs:integer,fadeinmsecs:integer,):nothing
_F.PlayMusicEx = jc["PlayMusicEx"]

---@type fun(musicFileName:string,):nothing
_F.PlayThematicMusic = jc["PlayThematicMusic"]

---@type fun(musicFileName:string,frommsecs:integer,):nothing
_F.PlayThematicMusicEx = jc["PlayThematicMusicEx"]

---@type fun(number:integer,):player
_F.Player = jc["Player"]

---@type fun(toPlayer:player,):leaderboard
_F.PlayerGetLeaderboard = jc["PlayerGetLeaderboard"]

---设置玩家使用的排行榜[R]
---设置${Player}使用${排行榜}
---每个玩家只能显示一个排行榜.
---@type fun(toPlayer:player,lb:leaderboard,):nothing
_F.PlayerSetLeaderboard = jc["PlayerSetLeaderboard"]

---幂运算
---${实数}的${实数}次幂
---@type fun(x:real,power:real,):real
_F.Pow = jc["Pow"]

---预载文件
---预载${文件}
---可以事先载入文件并调入到游戏内存,以加快游戏的速度.
---@type fun(filename:string,):nothing
_F.Preload = jc["Preload"]

---开始预载
---开始预载,超时设置${Time}秒
---将文件调入到游戏内存中.
---@type fun(timeout:real,):nothing
_F.PreloadEnd = jc["PreloadEnd"]

---@type fun():nothing
_F.PreloadEndEx = jc["PreloadEndEx"]

---@type fun():nothing
_F.PreloadGenClear = jc["PreloadGenClear"]

---@type fun(filename:string,):nothing
_F.PreloadGenEnd = jc["PreloadGenEnd"]

---@type fun():nothing
_F.PreloadGenStart = jc["PreloadGenStart"]

---@type fun():nothing
_F.PreloadRefresh = jc["PreloadRefresh"]

---@type fun():nothing
_F.PreloadStart = jc["PreloadStart"]

---批量预载
---预载所有在${文件}中列出的文件
---@type fun(filename:string,):nothing
_F.Preloader = jc["Preloader"]

---@type fun(whichQuest:quest,):questitem
_F.QuestCreateItem = jc["QuestCreateItem"]

---@type fun(whichQuestItem:questitem,completed:boolean,):nothing
_F.QuestItemSetCompleted = jc["QuestItemSetCompleted"]

---@type fun(whichQuestItem:questitem,description:string,):nothing
_F.QuestItemSetDescription = jc["QuestItemSetDescription"]

---@type fun(whichQuest:quest,completed:boolean,):nothing
_F.QuestSetCompleted = jc["QuestSetCompleted"]

---@type fun(whichQuest:quest,description:string,):nothing
_F.QuestSetDescription = jc["QuestSetDescription"]

---@type fun(whichQuest:quest,discovered:boolean,):nothing
_F.QuestSetDiscovered = jc["QuestSetDiscovered"]

---启用/禁用任务[R]
---设置${Quest}${Enable/Disable}
---被禁用的任务将不会显示在任务列表.
---@type fun(whichQuest:quest,enabled:boolean,):nothing
_F.QuestSetEnabled = jc["QuestSetEnabled"]

---@type fun(whichQuest:quest,failed:boolean,):nothing
_F.QuestSetFailed = jc["QuestSetFailed"]

---@type fun(whichQuest:quest,iconPath:string,):nothing
_F.QuestSetIconPath = jc["QuestSetIconPath"]

---@type fun(whichQuest:quest,required:boolean,):nothing
_F.QuestSetRequired = jc["QuestSetRequired"]

---@type fun(whichQuest:quest,title:string,):nothing
_F.QuestSetTitle = jc["QuestSetTitle"]

---@type fun(d:destructable,whichAnimation:string,):nothing
_F.QueueDestructableAnimation = jc["QueueDestructableAnimation"]

---@type fun(whichUnit:unit,whichAnimation:string,):nothing
_F.QueueUnitAnimation = jc["QueueUnitAnimation"]

---转换实数为整数
---转换${Real}为整数
---舍弃小数部分.
---@type fun(r:real,):integer
_F.R2I = jc["R2I"]

---转换实数为字符串
---转换${Real}为字符串
---@type fun(r:real,):string
_F.R2S = jc["R2S"]

---格式转换实数为字符串
---转换${Real}为字符串,最小宽度:${Width},小数位数:${Precision}
---如:转换(1.234,7,2)后为''1.23''.转换(1.234,2,5)后为''1.23400''.
---@type fun(r:real,width:integer,precision:integer,):string
_F.R2SW = jc["R2SW"]

---转换弧度为角度
---转换弧度${Radians}为角度
---@type fun(radians:real,):real
_F.Rad2Deg = jc["Rad2Deg"]

---新建矩形区域(指定边角坐标)
---左下角为(${X1},${Y1}),右上角为(${X2},${Y2})的矩形区域
---会创建矩形区域.
---@type fun(minx:real,miny:real,maxx:real,maxy:real,):rect
_F.Rect = jc["Rect"]

---新建矩形区域(指定边角点)
---左下角为${点1},右上角为${点2}的矩形区域
---会创建矩形区域.
---@type fun(min:location,max:location,):rect
_F.RectFromLoc = jc["RectFromLoc"]

---恢复指定单位的警戒点
---恢复${单位}的警戒点
---这个动作通过AI来恢复特定单位的警戒点.
---@type fun(hUnit:unit,):nothing
_F.RecycleGuardPosition = jc["RecycleGuardPosition"]

---添加单元点(指定坐标)[R]
---对${不规则区域}添加单元点:(${X},${Y})
---单元点大小为32x32.
---@type fun(whichRegion:region,x:real,y:real,):nothing
_F.RegionAddCell = jc["RegionAddCell"]

---添加单元点(指定点)[R]
---对${不规则区域}添加单元点:${点}
---单元点大小为32x32.
---@type fun(whichRegion:region,whichLocation:location,):nothing
_F.RegionAddCellAtLoc = jc["RegionAddCellAtLoc"]

---添加区域[R]
---对${不规则区域}添加${矩形区域}
---区域是游戏中一个游戏地区的集合体,可以包含地区和点.
---@type fun(whichRegion:region,r:rect,):nothing
_F.RegionAddRect = jc["RegionAddRect"]

---移除单元点(指定坐标)[R]
---在${不规则区域}中移除单元点:(${X},${Y})
---单元点大小为32x32.
---@type fun(whichRegion:region,x:real,y:real,):nothing
_F.RegionClearCell = jc["RegionClearCell"]

---移除单元点(指定点)[R]
---在${不规则区域}中移除单元点:${点}
---单元点大小为32x32.
---@type fun(whichRegion:region,whichLocation:location,):nothing
_F.RegionClearCellAtLoc = jc["RegionClearCellAtLoc"]

---移除区域[R]
---在${不规则区域}中移除${矩形区域}
---@type fun(whichRegion:region,r:rect,):nothing
_F.RegionClearRect = jc["RegionClearRect"]

---@type fun(soundHandle:sound,byPosition:boolean,rectwidth:real,rectheight:real,):nothing
_F.RegisterStackedSound = jc["RegisterStackedSound"]

---@type fun():nothing
_F.ReloadGame = jc["ReloadGame"]

---读取本地缓存数据
---从本地硬盘读取缓存数据
---只对单机游戏有效,从本地硬盘读取缓存数据,主要用来实现战役关卡间的数据传递.
---@type fun():boolean
_F.ReloadGameCachesFromDisk = jc["ReloadGameCachesFromDisk"]

---忽视所有单位的警戒点
---忽视${Player}的所有单位的警戒点
---单位将不会自动返回原警戒点.一个很有用的功能就是刷怪进攻时忽视单位警戒范围的话,怪就不会想家了.
---@type fun(num:player,):nothing
_F.RemoveAllGuardPositions = jc["RemoveAllGuardPositions"]

---删除
---删除${可破坏物}
---@type fun(d:destructable,):nothing
_F.RemoveDestructable = jc["RemoveDestructable"]

---忽视指定单位的警戒点
---忽视${单位}的警戒点
---单位将不会自动返回原警戒点.一个很有用的功能就是刷怪进攻时忽视单位警戒范围的话,怪就不会想家了.
---@type fun(hUnit:unit,):nothing
_F.RemoveGuardPosition = jc["RemoveGuardPosition"]

---删除
---删除${物品}
---@type fun(whichItem:item,):nothing
_F.RemoveItem = jc["RemoveItem"]

---删除物品(所有市场)
---删除${物品类型}从所有市场
---影响所有拥有'出售物品'技能的单位.
---@type fun(itemId:integer,):nothing
_F.RemoveItemFromAllStock = jc["RemoveItemFromAllStock"]

---@type fun(whichUnit:unit,itemId:integer,):nothing
_F.RemoveItemFromStock = jc["RemoveItemFromStock"]

---清除点[R]
---清除${点}
---点是堆积最多的垃圾资源,不需要再使用的点都要记得清除掉.
---@type fun(whichLocation:location,):nothing
_F.RemoveLocation = jc["RemoveLocation"]

---踢除玩家
---踢除${Player}，玩家的游戏结果为${文字}
---@type fun(whichPlayer:player,gameResult:playergameresult,):nothing
_F.RemovePlayer = jc["RemovePlayer"]

---删除矩形区域[R]
---删除${矩形区域}
---@type fun(whichRect:rect,):nothing
_F.RemoveRect = jc["RemoveRect"]

---删除不规则区域[R]
---删除${不规则区域}
---@type fun(whichRegion:region,):nothing
_F.RemoveRegion = jc["RemoveRegion"]

---@type fun(sourceDirName:string,):boolean
_F.RemoveSaveDirectory = jc["RemoveSaveDirectory"]

---@type fun()
_F.RemoveSavedBoolean = jc["RemoveSavedBoolean"]

---@type fun()
_F.RemoveSavedHandle = jc["RemoveSavedHandle"]

---@type fun()
_F.RemoveSavedInteger = jc["RemoveSavedInteger"]

---@type fun()
_F.RemoveSavedReal = jc["RemoveSavedReal"]

---@type fun()
_F.RemoveSavedString = jc["RemoveSavedString"]

---删除
---删除${单位}
---被删除的单位不会留下尸体.如果是英雄则不能再被复活.
---@type fun(whichUnit:unit,):nothing
_F.RemoveUnit = jc["RemoveUnit"]

---删除单位(所有市场)
---删除${单位类型}从所有市场
---影响所有拥有'出售单位'技能的单位.
---@type fun(unitId:integer,):nothing
_F.RemoveUnitFromAllStock = jc["RemoveUnitFromAllStock"]

---@type fun(whichUnit:unit,unitId:integer,):nothing
_F.RemoveUnitFromStock = jc["RemoveUnitFromStock"]

---@type fun(whichEffect:weathereffect,):nothing
_F.RemoveWeatherEffect = jc["RemoveWeatherEffect"]

---@type fun(sourceDirName:string,destDirName:string,):boolean
_F.RenameSaveDirectory = jc["RenameSaveDirectory"]

---@type fun():nothing
_F.ResetTerrainFog = jc["ResetTerrainFog"]

---重置游戏镜头(所有玩家)[R]
---重置玩家镜头为游戏默认状态,持续${Time}秒
---@type fun(duration:real,):nothing
_F.ResetToGameCamera = jc["ResetToGameCamera"]

---@type fun(whichTrigger:trigger,):nothing
_F.ResetTrigger = jc["ResetTrigger"]

---重置地面纹理变化
---重置${Ubersplat}
---@type fun(whichSplat:ubersplat,):nothing
_F.ResetUbersplat = jc["ResetUbersplat"]

---重置身体朝向
---重置${单位}的身体朝向
---恢复单位的身体朝向为正常状态.
---@type fun(whichUnit:unit,):nothing
_F.ResetUnitLookAt = jc["ResetUnitLookAt"]

---@type fun(doScoreScreen:boolean,):nothing
_F.RestartGame = jc["RestartGame"]

---@type fun(cache:gamecache,missionKey:string,key:string,forWhichPlayer:player,x:real,y:real,facing:real,):unit
_F.RestoreUnit = jc["RestoreUnit"]

---@type fun():nothing
_F.ResumeMusic = jc["ResumeMusic"]

---恢复计时器[R]
---恢复${计时器}
---@type fun(whichTimer:timer,):nothing
_F.ResumeTimer = jc["ResumeTimer"]

---立即复活(指定坐标)[R]
---立即复活${英雄}在(${X},${Y}),${Show/Hide}复活动画
---如果英雄正在祭坛复活,则会退回部分花费(默认为100%).
---@type fun(whichHero:unit,x:real,y:real,doEyecandy:boolean,):boolean
_F.ReviveHero = jc["ReviveHero"]

---立即复活(指定点)
---立即复活${英雄}在${指定点},${Show/Hide}复活动画
---如果英雄正在祭坛复活,则会退回部分花费(默认为100%).
---@type fun(whichHero:unit,loc:location,doEyecandy:boolean,):boolean
_F.ReviveHeroLoc = jc["ReviveHeroLoc"]

---转换字符串为整数
---转换${String}为整数
---@type fun(s:string,):integer
_F.S2I = jc["S2I"]

---转换字符串为实数
---转换${String}为实数
---@type fun(s:string,):real
_F.S2R = jc["S2R"]

---@type fun()
_F.SaveAbilityHandle = jc["SaveAbilityHandle"]

---@type fun()
_F.SaveBoolean = jc["SaveBoolean"]

---@type fun()
_F.SaveBooleanExprHandle = jc["SaveBooleanExprHandle"]

---@type fun()
_F.SaveButtonHandle = jc["SaveButtonHandle"]

---@type fun()
_F.SaveDefeatConditionHandle = jc["SaveDefeatConditionHandle"]

---@type fun()
_F.SaveDestructableHandle = jc["SaveDestructableHandle"]

---@type fun()
_F.SaveDialogHandle = jc["SaveDialogHandle"]

---@type fun()
_F.SaveEffectHandle = jc["SaveEffectHandle"]

---@type fun()
_F.SaveFogModifierHandle = jc["SaveFogModifierHandle"]

---@type fun()
_F.SaveFogStateHandle = jc["SaveFogStateHandle"]

---@type fun()
_F.SaveForceHandle = jc["SaveForceHandle"]

---保存进度[R]
---保存游戏进度为:${Filename}
---@type fun(saveFileName:string,):nothing
_F.SaveGame = jc["SaveGame"]

---@type fun(whichCache:gamecache,):boolean
_F.SaveGameCache = jc["SaveGameCache"]

---游戏存档存在
---${存档文件}已存在
---@type fun(saveName:string,):boolean
_F.SaveGameExists = jc["SaveGameExists"]

---@type fun()
_F.SaveGroupHandle = jc["SaveGroupHandle"]

---@type fun()
_F.SaveImageHandle = jc["SaveImageHandle"]

---@type fun()
_F.SaveInteger = jc["SaveInteger"]

---@type fun()
_F.SaveItemHandle = jc["SaveItemHandle"]

---@type fun()
_F.SaveItemPoolHandle = jc["SaveItemPoolHandle"]

---@type fun()
_F.SaveLeaderboardHandle = jc["SaveLeaderboardHandle"]

---@type fun()
_F.SaveLightningHandle = jc["SaveLightningHandle"]

---@type fun()
_F.SaveLocationHandle = jc["SaveLocationHandle"]

---@type fun()
_F.SaveMultiboardHandle = jc["SaveMultiboardHandle"]

---@type fun()
_F.SaveMultiboardItemHandle = jc["SaveMultiboardItemHandle"]

---@type fun()
_F.SavePlayerHandle = jc["SavePlayerHandle"]

---@type fun()
_F.SaveQuestHandle = jc["SaveQuestHandle"]

---@type fun()
_F.SaveQuestItemHandle = jc["SaveQuestItemHandle"]

---@type fun()
_F.SaveReal = jc["SaveReal"]

---@type fun()
_F.SaveRectHandle = jc["SaveRectHandle"]

---@type fun()
_F.SaveRegionHandle = jc["SaveRegionHandle"]

---@type fun()
_F.SaveSoundHandle = jc["SaveSoundHandle"]

---@type fun()
_F.SaveStr = jc["SaveStr"]

---@type fun()
_F.SaveTextTagHandle = jc["SaveTextTagHandle"]

---@type fun()
_F.SaveTimerDialogHandle = jc["SaveTimerDialogHandle"]

---@type fun()
_F.SaveTimerHandle = jc["SaveTimerHandle"]

---@type fun()
_F.SaveTrackableHandle = jc["SaveTrackableHandle"]

---@type fun()
_F.SaveTriggerActionHandle = jc["SaveTriggerActionHandle"]

---@type fun()
_F.SaveTriggerConditionHandle = jc["SaveTriggerConditionHandle"]

---@type fun()
_F.SaveTriggerEventHandle = jc["SaveTriggerEventHandle"]

---@type fun()
_F.SaveTriggerHandle = jc["SaveTriggerHandle"]

---@type fun()
_F.SaveUbersplatHandle = jc["SaveUbersplatHandle"]

---@type fun()
_F.SaveUnitHandle = jc["SaveUnitHandle"]

---@type fun()
_F.SaveUnitPoolHandle = jc["SaveUnitPoolHandle"]

---@type fun()
_F.SaveWidgetHandle = jc["SaveWidgetHandle"]

---学习技能
---命令${Hero}学习技能${Skill}
---只有当英雄有剩余技能点时有效.
---@type fun(whichHero:unit,abilcode:integer,):nothing
_F.SelectHeroSkill = jc["SelectHeroSkill"]

---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.SelectUnit = jc["SelectUnit"]

---限制物品种类(所有市场)
---限制所有市场的可出售物品种类数为${Quantity}
---影响所有拥有'出售物品'技能的单位.
---@type fun(slots:integer,):nothing
_F.SetAllItemTypeSlots = jc["SetAllItemTypeSlots"]

---限制单位种类(所有市场)
---限制所有市场的可出售单位种类数为${Quantity}
---影响所有拥有'出售单位'技能的单位.
---@type fun(slots:integer,):nothing
_F.SetAllUnitTypeSlots = jc["SetAllUnitTypeSlots"]

---设置联盟颜色显示
---设置联盟颜色显示状态为${State}
---0为不开启.1为小地图显示.2为小地图和游戏都显示.相当于游戏中Alt+A功能.
---@type fun(state:integer,):nothing
_F.SetAllyColorFilterState = jc["SetAllyColorFilterState"]

---设置小地图特殊标志
---设置小地图特殊标志为${Image}
---必须使用16x16的图像.
---@type fun(iconPath:string,):nothing
_F.SetAltMinimapIcon = jc["SetAltMinimapIcon"]

---创建/删除荒芜地表(圆范围)(指定坐标)[R]
---为${Player}在圆心为(${X},${Y}),半径为${R}的圆范围内${Create/Remove}一块荒芜地表
---@type fun(whichPlayer:player,x:real,y:real,radius:real,addBlight:boolean,):nothing
_F.SetBlight = jc["SetBlight"]

---@type fun(whichPlayer:player,whichLocation:location,radius:real,addBlight:boolean,):nothing
_F.SetBlightLoc = jc["SetBlightLoc"]

---@type fun(whichPlayer:player,x:real,y:real,addBlight:boolean,):nothing
_F.SetBlightPoint = jc["SetBlightPoint"]

---创建/删除荒芜地表(矩形区域)[R]
---为${Player}在${Region}${Create/Remove}一块荒芜地表
---@type fun(whichPlayer:player,r:rect,addBlight:boolean,):nothing
_F.SetBlightRect = jc["SetBlightRect"]

---设置可用镜头区域(所有玩家)[R]
---设置玩家可用镜头区域:左下角(${X},${Y}),左上角(${X},${Y}),右上角(${X},${Y}),右下角(${X},${Y})
---该动作同样会影响小地图的显示.但小地图的图片是无法改变的.实际可用区域要大于可用镜头区域.
---@type fun(x1:real,y1:real,x2:real,y2:real,x3:real,y3:real,x4:real,y4:real,):nothing
_F.SetCameraBounds = jc["SetCameraBounds"]

---设置镜头属性(所有玩家)(限时)[R]
---设置玩家的镜头属性${Field}为${数值},持续${Time}秒
---@type fun(whichField:camerafield,value:real,duration:real,):nothing
_F.SetCameraField = jc["SetCameraField"]

---锁定镜头到单位(固定镜头源)(所有玩家)[R]
---锁定玩家镜头到${单位},偏移坐标(${X},${Y})
---偏移坐标(X,Y)以单位脚底为原点坐标.
---@type fun(whichUnit:unit,xoffset:real,yoffset:real,):nothing
_F.SetCameraOrientController = jc["SetCameraOrientController"]

---@type fun(x:real,y:real,):nothing
_F.SetCameraPosition = jc["SetCameraPosition"]

---设置空格键转向点(所有玩家)[R]
---设置玩家的空格键转向点为(${X},${Y})
---按下空格键时镜头转向的位置.
---@type fun(x:real,y:real,):nothing
_F.SetCameraQuickPosition = jc["SetCameraQuickPosition"]

---指定点旋转镜头(所有玩家)(弧度)(限时)[R]
---以(${X},${Y})为中心,旋转弧度为${Rad},持续:${Time}秒
---@type fun(x:real,y:real,radiansToSweep:real,duration:real,):nothing
_F.SetCameraRotateMode = jc["SetCameraRotateMode"]

---锁定镜头到单位(所有玩家)[R]
---锁定玩家镜头到${单位},偏移坐标(${X},${Y}),使用${RotationSource}
---偏移坐标(X,Y)以单位脚底为原点坐标.
---@type fun(whichUnit:unit,xoffset:real,yoffset:real,inheritOrientation:boolean,):nothing
_F.SetCameraTargetController = jc["SetCameraTargetController"]

---@type fun(campaignNumber:integer,available:boolean,):nothing
_F.SetCampaignAvailable = jc["SetCampaignAvailable"]

---@type fun(r:race,):nothing
_F.SetCampaignMenuRace = jc["SetCampaignMenuRace"]

---@type fun(campaignIndex:integer,):nothing
_F.SetCampaignMenuRaceEx = jc["SetCampaignMenuRaceEx"]

---@type fun(whichMode:blendmode,):nothing
_F.SetCineFilterBlendMode = jc["SetCineFilterBlendMode"]

---@type fun(duration:real,):nothing
_F.SetCineFilterDuration = jc["SetCineFilterDuration"]

---@type fun(red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetCineFilterEndColor = jc["SetCineFilterEndColor"]

---@type fun(minu:real,minv:real,maxu:real,maxv:real,):nothing
_F.SetCineFilterEndUV = jc["SetCineFilterEndUV"]

---@type fun(red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetCineFilterStartColor = jc["SetCineFilterStartColor"]

---@type fun(minu:real,minv:real,maxu:real,maxv:real,):nothing
_F.SetCineFilterStartUV = jc["SetCineFilterStartUV"]

---@type fun(whichFlags:texmapflags,):nothing
_F.SetCineFilterTexMapFlags = jc["SetCineFilterTexMapFlags"]

---@type fun(filename:string,):nothing
_F.SetCineFilterTexture = jc["SetCineFilterTexture"]

---播放电影镜头(所有玩家)[R]
---对所有玩家播放电影镜头:${CameraFile}
---在'Objects\\CinematicCameras'目录下有一些电影镜头,可用Mpq工具来查询.
---@type fun(cameraModelFile:string,):nothing
_F.SetCinematicCamera = jc["SetCinematicCamera"]

---@type fun(portraitUnitId:integer,color:playercolor,speakerTitle:string,text:string,sceneDuration:real,voiceoverDuration:real,):nothing
_F.SetCinematicScene = jc["SetCinematicScene"]

---@type fun(whichdensity:mapdensity,):nothing
_F.SetCreatureDensity = jc["SetCreatureDensity"]

---设置小地图中立生物显示
---小地图${Show/Hide}中立生物
---相当于游戏中Alt+R功能.
---@type fun(state:boolean,):nothing
_F.SetCreepCampFilterState = jc["SetCreepCampFilterState"]

---@type fun(whichButton:integer,visible:boolean,):nothing
_F.SetCustomCampaignButtonVisible = jc["SetCustomCampaignButtonVisible"]

---@type fun(terrainDNCFile:string,unitDNCFile:string,):nothing
_F.SetDayNightModels = jc["SetDayNightModels"]

---@type fun(g:gamedifficulty,):nothing
_F.SetDefaultDifficulty = jc["SetDefaultDifficulty"]

---@type fun(d:destructable,whichAnimation:string,):nothing
_F.SetDestructableAnimation = jc["SetDestructableAnimation"]

---改变可破坏物动画播放速度[R]
---改变${可破坏物}的动画播放速度为正常的${Percent}倍
---设置1倍动画播放速度来恢复正常状态.
---@type fun(d:destructable,speedFactor:real,):nothing
_F.SetDestructableAnimationSpeed = jc["SetDestructableAnimationSpeed"]

---@type fun(d:destructable,flag:boolean,):nothing
_F.SetDestructableInvulnerable = jc["SetDestructableInvulnerable"]

---设置生命值(指定值)
---设置${可破坏物}的生命值为${Value}
---@type fun(d:destructable,life:real,):nothing
_F.SetDestructableLife = jc["SetDestructableLife"]

---@type fun(d:destructable,max:real,):nothing
_F.SetDestructableMaxLife = jc["SetDestructableMaxLife"]

---设置闭塞高度
---设置${可破坏物}的闭塞高度为${Height}
---@type fun(d:destructable,height:real,):nothing
_F.SetDestructableOccluderHeight = jc["SetDestructableOccluderHeight"]

---播放圆范围内地形装饰物动画[R]
---选取圆心为(${X},${Y}),半径为${半径}的圆范围内的${装饰物类型}(选取方式:${选取方式}),做${AnimationName}动作(${允许/禁止}随机播放)
---特殊动画名:'show','hide','soundon','soundoff'.随机播放:比如某装饰物有好几个'stand'动作,则允许该项时会随机抽取某个动作播放,而禁止该项时只播放首个动作.
---@type fun(x:real,y:real,radius:real,doodadID:integer,nearestOnly:boolean,animName:string,animRandom:boolean,):nothing
_F.SetDoodadAnimation = jc["SetDoodadAnimation"]

---播放矩形区域内地形装饰物动画[R]
---播放${Rect}内所有${装饰物类型}的${AnimationName}动作(${允许/禁止}随机播放)
---特殊动画名:'show','hide','soundon','soundoff'.随机播放:比如某装饰物有好几个'stand'动作,则允许该项时会随机抽取某个动作播放,而禁止该项时只播放首个动作.
---@type fun(r:rect,doodadID:integer,animName:string,animRandom:boolean,):nothing
_F.SetDoodadAnimationRect = jc["SetDoodadAnimationRect"]

---@type fun(campaignNumber:integer,available:boolean,):nothing
_F.SetEdCinematicAvailable = jc["SetEdCinematicAvailable"]

---@type fun(whichFloatGameState:fgamestate,value:real,):nothing
_F.SetFloatGameState = jc["SetFloatGameState"]

---设置地图迷雾(圆范围)[R]
---为${玩家}设置${FogStateVisible}在圆心为(${X},${Y})半径为${数值}的范围,(对盟友${共享}视野)
---@type fun(forWhichPlayer:player,whichState:fogstate,centerx:real,centerY:real,radius:real,useSharedVision:boolean,):nothing
_F.SetFogStateRadius = jc["SetFogStateRadius"]

---@type fun(forWhichPlayer:player,whichState:fogstate,center:location,radius:real,useSharedVision:boolean,):nothing
_F.SetFogStateRadiusLoc = jc["SetFogStateRadiusLoc"]

---设置地图迷雾(矩形区域)[R]
---为${玩家}设置${FogStateVisible}在${矩形区域}(对盟友${共享}视野)
---@type fun(forWhichPlayer:player,whichState:fogstate,where:rect,useSharedVision:boolean,):nothing
_F.SetFogStateRect = jc["SetFogStateRect"]

---设置游戏难度[R]
---设置当前游戏难度为${GameDifficulty}
---游戏难度只是作为运行AI的一个参考值,没有AI的地图该功能无用.
---@type fun(whichdifficulty:gamedifficulty,):nothing
_F.SetGameDifficulty = jc["SetGameDifficulty"]

---@type fun(whichPlacementType:placement,):nothing
_F.SetGamePlacement = jc["SetGamePlacement"]

---设定游戏速度
---设定游戏速度为${Speed}
---你可以通过'游戏-锁定游戏速度'动作来锁定游戏速度.
---@type fun(whichspeed:gamespeed,):nothing
_F.SetGameSpeed = jc["SetGameSpeed"]

---@type fun(whichGameType:gametype,value:boolean,):nothing
_F.SetGameTypeSupported = jc["SetGameTypeSupported"]

---设置英雄敏捷[R]
---设置${英雄}的敏捷为${Value},(${Permanent}永久奖励)
---永久奖励貌似无效项,不需要理会.
---@type fun(whichHero:unit,newAgi:integer,permanent:boolean,):nothing
_F.SetHeroAgi = jc["SetHeroAgi"]

---设置英雄智力[R]
---设置${英雄}的智力为${Value},(${Permanent}永久奖励)
---永久奖励貌似无效项,不需要理会.
---@type fun(whichHero:unit,newInt:integer,permanent:boolean,):nothing
_F.SetHeroInt = jc["SetHeroInt"]

---@type fun(whichHero:unit,level:integer,showEyeCandy:boolean,):nothing
_F.SetHeroLevel = jc["SetHeroLevel"]

---设置英雄力量[R]
---设置${英雄}的力量为${Value},(${Permanent}永久奖励)
---永久奖励貌似无效项,不需要理会.
---@type fun(whichHero:unit,newStr:integer,permanent:boolean,):nothing
_F.SetHeroStr = jc["SetHeroStr"]

---设置经验值
---设置${Hero}的经验值为${Quantity},${Show/Hide}升级动画
---经验值不能倒退.
---@type fun(whichHero:unit,newXpVal:integer,showEyeCandy:boolean,):nothing
_F.SetHeroXP = jc["SetHeroXP"]

---图像水面显示状态
---设置${Image}:${Enable/Disable}水面显示,${Enable/Disable}水的Alpha通道
---前者设置图像在水面或是水底显示.后者设置图像是否受水的Alpha通道影响.
---@type fun(whichImage:image,flag:boolean,useWaterAlpha:boolean,):nothing
_F.SetImageAboveWater = jc["SetImageAboveWater"]

---改变图像颜色[R]
---设置${Image}的颜色值为(${Red},${Green},${Blue})Alpha值为${Alpha}
---颜色格式为(红,绿,蓝).Alpha值为0是不可见的.颜色值和Alpha值取值范围0-255.
---@type fun(whichImage:image,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetImageColor = jc["SetImageColor"]

---设置图像高度
---设置${Image}${Enable/Disable}Z轴显示,并设置高度为${Height}
---实际显示高度为图像高度+Z轴偏移.只有允许Z轴显示时才有效.
---@type fun(whichImage:image,flag:boolean,height:real,):nothing
_F.SetImageConstantHeight = jc["SetImageConstantHeight"]

---改变图像位置(指定坐标)[R]
---改变${Image}的位置为(${X},${Y}),Z轴偏移为${Z}
---指图像的左下角位置.
---@type fun(whichImage:image,x:real,y:real,z:real,):nothing
_F.SetImagePosition = jc["SetImagePosition"]

---设置图像渲染状态
---设置${Image}:${Enable/Disable}显示状态
---未发现有任何作用.
---@type fun(whichImage:image,flag:boolean,):nothing
_F.SetImageRender = jc["SetImageRender"]

---设置图像永久渲染状态
---设置${Image}:${Enable/Disable}永久显示状态
---要显示图像则必须开启该项.
---@type fun(whichImage:image,flag:boolean,):nothing
_F.SetImageRenderAlways = jc["SetImageRenderAlways"]

---改变图像类型
---改变${Image}类型为${Type}
---@type fun(whichImage:image,imageType:integer,):nothing
_F.SetImageType = jc["SetImageType"]

---@type fun(whichIntegerGameState:igamestate,value:integer,):nothing
_F.SetIntegerGameState = jc["SetIntegerGameState"]

---@type fun(introModelPath:string,):nothing
_F.SetIntroShotModel = jc["SetIntroShotModel"]

---@type fun(introText:string,):nothing
_F.SetIntroShotText = jc["SetIntroShotText"]

---设置物品使用次数
---设置${物品}的使用次数为${Charges}
---设置为0可以使物品能无限次使用.
---@type fun(whichItem:item,charges:integer,):nothing
_F.SetItemCharges = jc["SetItemCharges"]

---设置重生神符的产生单位类型
---设置${物品}产生${单位类型}
---设置重生神符对应的单位类型后，当英雄吃了重生神符，则会产生指定类型的单位。
---@type fun(whichItem:item,unitId:integer,):nothing
_F.SetItemDropID = jc["SetItemDropID"]

---@type fun(whichItem:item,flag:boolean,):nothing
_F.SetItemDropOnDeath = jc["SetItemDropOnDeath"]

---@type fun(i:item,flag:boolean,):nothing
_F.SetItemDroppable = jc["SetItemDroppable"]

---@type fun(whichItem:item,flag:boolean,):nothing
_F.SetItemInvulnerable = jc["SetItemInvulnerable"]

---设置物品可否抵押
---设置${物品}${Pawnable/Unpawnable}
---不可抵押物品不能被卖到商店.
---@type fun(i:item,flag:boolean,):nothing
_F.SetItemPawnable = jc["SetItemPawnable"]

---@type fun(whichItem:item,whichPlayer:player,changeColor:boolean,):nothing
_F.SetItemPlayer = jc["SetItemPlayer"]

---移动物品到坐标(立即)(指定坐标)[R]
---移动${物品}到(${X},${Y})
---@type fun(i:item,x:real,y:real,):nothing
_F.SetItemPosition = jc["SetItemPosition"]

---限制物品种类(指定市场)
---限制${Marketplace}的可出售物品种类数为${Quantity}
---只影响有'出售物品'技能的单位.
---@type fun(whichUnit:unit,slots:integer,):nothing
_F.SetItemTypeSlots = jc["SetItemTypeSlots"]

---设置物品自定义值
---设置${物品}的自定义值为${Index}
---物品自定义值只用于触发器.可以用来为物品绑定一个整型数据.
---@type fun(whichItem:item,data:integer,):nothing
_F.SetItemUserData = jc["SetItemUserData"]

---显示/隐藏[R]
---设置${物品}的状态为:${Show/Hide}
---只对在地面的物品有效,不会影响在物品栏中的物品.单位通过触发得到一个隐藏物品时,会自动显示该物品.
---@type fun(whichItem:item,show:boolean,):nothing
_F.SetItemVisible = jc["SetItemVisible"]

---@type fun(whichBolt:lightning,r:real,g:real,b:real,a:real,):boolean
_F.SetLightningColor = jc["SetLightningColor"]

---@type fun(description:string,):nothing
_F.SetMapDescription = jc["SetMapDescription"]

---设置地图参数
---设置${MapFlag}为${On/Off}
---@type fun(whichMapFlag:mapflag,value:boolean,):nothing
_F.SetMapFlag = jc["SetMapFlag"]

---设置背景音乐列表[R]
---设置背景音乐列表为:${Music},${允许/禁止}随机播放,开始播放序号为${Index}
---可指定播放文件或播放目录.
---@type fun(musicName:string,random:boolean,index:integer,):nothing
_F.SetMapMusic = jc["SetMapMusic"]

---@type fun(name:string,):nothing
_F.SetMapName = jc["SetMapName"]

---@type fun(campaignNumber:integer,missionNumber:integer,available:boolean,):nothing
_F.SetMissionAvailable = jc["SetMissionAvailable"]

---@type fun(millisecs:integer,):nothing
_F.SetMusicPlayPosition = jc["SetMusicPlayPosition"]

---设置背景音乐音量[R]
---设置背景音乐音量为${Volume}
---音量取值范围为0-127.
---@type fun(volume:integer,):nothing
_F.SetMusicVolume = jc["SetMusicVolume"]

---@type fun(campaignNumber:integer,available:boolean,):nothing
_F.SetOpCinematicAvailable = jc["SetOpCinematicAvailable"]

---允许/禁用技能[R]
---设置${Player}的${技能}为${Enable/Disable}
---设置玩家能否使用该技能.
---@type fun(whichPlayer:player,abilid:integer,avail:boolean,):nothing
_F.SetPlayerAbilityAvailable = jc["SetPlayerAbilityAvailable"]

---设置联盟状态(指定项目)[R]
---命令${Player}对${Player}设置${AllianceType}${On/Off}
---注意:可以对玩家自己设置联盟状态.可用来实现一些特殊效果.
---@type fun(sourcePlayer:player,otherPlayer:player,whichAllianceSetting:alliancetype,value:boolean,):nothing
_F.SetPlayerAlliance = jc["SetPlayerAlliance"]

---改变玩家颜色[R]
---将${Player}的玩家颜色改为${Color}
---不改变现有单位的颜色.
---@type fun(whichPlayer:player,color:playercolor,):nothing
_F.SetPlayerColor = jc["SetPlayerColor"]

---@type fun(whichPlayer:player,controlType:mapcontrol,):nothing
_F.SetPlayerController = jc["SetPlayerController"]

---设置生命上限[R]
---设置${Player}的生命障碍为正常的${Percent}倍
---生命上限影响玩家拥有单位的生命最大值.生命之书并不受生命上限限制,所以对英雄血量可能会有偏差.
---@type fun(whichPlayer:player,handicap:real,):nothing
_F.SetPlayerHandicap = jc["SetPlayerHandicap"]

---设置经验获得率[R]
---设置${Player}的经验获得率为正常的${Value}倍
---@type fun(whichPlayer:player,handicap:real,):nothing
_F.SetPlayerHandicapXP = jc["SetPlayerHandicapXP"]

---更改名字
---更改${Player}的名字为${文字}
---@type fun(whichPlayer:player,name:string,):nothing
_F.SetPlayerName = jc["SetPlayerName"]

---显示/隐藏计分屏显示[R]
---设置${Player}${Show/Hide}在计分屏的显示.
---@type fun(whichPlayer:player,flag:boolean,):nothing
_F.SetPlayerOnScoreScreen = jc["SetPlayerOnScoreScreen"]

---@type fun(whichPlayer:player,whichRacePreference:racepreference,):nothing
_F.SetPlayerRacePreference = jc["SetPlayerRacePreference"]

---@type fun(whichPlayer:player,value:boolean,):nothing
_F.SetPlayerRaceSelectable = jc["SetPlayerRaceSelectable"]

---@type fun(whichPlayer:player,startLocIndex:integer,):nothing
_F.SetPlayerStartLocation = jc["SetPlayerStartLocation"]

---@type fun(whichPlayer:player,whichPlayerState:playerstate,value:integer,):nothing
_F.SetPlayerState = jc["SetPlayerState"]

---设置税率[R]
---设置${Player}交纳给${Player}的${Resource}所得税为${Rate}%
---缴纳所得税所损失的资源可以通过'玩家得分'的'税务损失的黄金/木材'来获取.所得税最高为100%.且玩家1对玩家2和玩家3都交纳80%所得税.则玩家1采集黄金时将给玩家28黄金,玩家32黄金.
---@type fun(sourcePlayer:player,otherPlayer:player,whichResource:playerstate,rate:integer,):nothing
_F.SetPlayerTaxRate = jc["SetPlayerTaxRate"]

---设置玩家队伍
---设置${Player}的队伍为${队伍ID}
---@type fun(whichPlayer:player,whichTeam:integer,):nothing
_F.SetPlayerTeam = jc["SetPlayerTeam"]

---@type fun(whichPlayer:player,techid:integer,maximum:integer,):nothing
_F.SetPlayerTechMaxAllowed = jc["SetPlayerTechMaxAllowed"]

---@type fun(whichPlayer:player,techid:integer,setToLevel:integer,):nothing
_F.SetPlayerTechResearched = jc["SetPlayerTechResearched"]

---@type fun(whichPlayer:player,newOwner:integer,):nothing
_F.SetPlayerUnitsOwner = jc["SetPlayerUnitsOwner"]

---@type fun(playercount:integer,):nothing
_F.SetPlayers = jc["SetPlayers"]

---设置随机种子
---设置随机种子数为：${整数}
---设置游戏的随机种子，随机种子会影响随机整数，攻击骰子之类的随机数。
---@type fun(seed:integer,):nothing
_F.SetRandomSeed = jc["SetRandomSeed"]

---设置矩形区域(指定坐标)[R]
---重新设置${矩形区域},左下角坐标为(${X},${Y}),右上角坐标为(${X},${Y})
---该区域必须是一个变量.重新设置矩形区域的大小和位置.
---@type fun(whichRect:rect,minx:real,miny:real,maxx:real,maxy:real,):nothing
_F.SetRect = jc["SetRect"]

---设置矩形区域(指定点)[R]
---重新设置${矩形区域},左下角点为${点}右上角点为${点}
---该区域必须是一个变量.重新设置矩形区域的大小和位置.
---@type fun(whichRect:rect,min:location,max:location,):nothing
_F.SetRectFromLoc = jc["SetRectFromLoc"]

---保留英雄图标
---为玩家保留${Number}个左上角英雄图标.
---因为共享单位而被控制的其他玩家英雄的图标将在保留位置之后开始显示.
---@type fun(reserved:integer,):nothing
_F.SetReservedLocalHeroButtons = jc["SetReservedLocalHeroButtons"]

---设置黄金储量
---设置${金矿}的黄金储量为${Quantity}
---@type fun(whichUnit:unit,amount:integer,):nothing
_F.SetResourceAmount = jc["SetResourceAmount"]

---@type fun(whichdensity:mapdensity,):nothing
_F.SetResourceDensity = jc["SetResourceDensity"]

---设置天空
---设置天空模型为${Sky}
---@type fun(skyModelFile:string,):nothing
_F.SetSkyModel = jc["SetSkyModel"]

---@type fun(soundHandle:sound,channel:integer,):nothing
_F.SetSoundChannel = jc["SetSoundChannel"]

---@type fun(soundHandle:sound,inside:real,outside:real,outsideVolume:integer,):nothing
_F.SetSoundConeAngles = jc["SetSoundConeAngles"]

---@type fun(soundHandle:sound,x:real,y:real,z:real,):nothing
_F.SetSoundConeOrientation = jc["SetSoundConeOrientation"]

---@type fun(soundHandle:sound,cutoff:real,):nothing
_F.SetSoundDistanceCutoff = jc["SetSoundDistanceCutoff"]

---设置3D音效衰减范围
---设置${3D音效}的衰减最小范围:${数值}最大范围:${数值}
---该动作仅用于3D音效.注意不一定要达到最大范围,音量衰减到一定程度也会变没的.
---@type fun(soundHandle:sound,minDist:real,maxDist:real,):nothing
_F.SetSoundDistances = jc["SetSoundDistances"]

---@type fun(soundHandle:sound,duration:integer,):nothing
_F.SetSoundDuration = jc["SetSoundDuration"]

---@type fun(soundHandle:sound,soundLabel:string,):nothing
_F.SetSoundParamsFromLabel = jc["SetSoundParamsFromLabel"]

---@type fun(soundHandle:sound,pitch:real,):nothing
_F.SetSoundPitch = jc["SetSoundPitch"]

---设置音效播放时间点[R]
---设置${音效}的播放时间点为${Offset}毫秒
---音效必须是正在播放的.不能用于3D音效.
---@type fun(soundHandle:sound,millisecs:integer,):nothing
_F.SetSoundPlayPosition = jc["SetSoundPlayPosition"]

---设置3D音效位置(指定坐标)[R]
---设置${3D音效}的播放位置为(${X},${Y}),Z轴高度为${Z}
---该动作仅用于3D音效.
---@type fun(soundHandle:sound,x:real,y:real,z:real,):nothing
_F.SetSoundPosition = jc["SetSoundPosition"]

---@type fun(soundHandle:sound,x:real,y:real,z:real,):nothing
_F.SetSoundVelocity = jc["SetSoundVelocity"]

---设置音效音量[R]
---设置${音效}的音量为${Volume}
---音量取值范围0-127.
---@type fun(soundHandle:sound,volume:integer,):nothing
_F.SetSoundVolume = jc["SetSoundVolume"]

---@type fun(whichStartLoc:integer,prioSlotIndex:integer,otherStartLocIndex:integer,priority:startlocprio,):nothing
_F.SetStartLocPrio = jc["SetStartLocPrio"]

---@type fun(whichStartLoc:integer,prioSlotCount:integer,):nothing
_F.SetStartLocPrioCount = jc["SetStartLocPrioCount"]

---@type fun(teamcount:integer,):nothing
_F.SetTeams = jc["SetTeams"]

---@type fun(a:real,b:real,c:real,d:real,e:real,):nothing
_F.SetTerrainFog = jc["SetTerrainFog"]

---设置迷雾[R]
---迷雾风格:${Style},Z轴开始端:${Z-Start},Z轴结束端:${Z-End},密度:${Density}颜色:(${Red},${Green},${Blue})
---颜色格式为(红,绿,蓝).取值范围0.00-1.00.
---@type fun(style:integer,zstart:real,zend:real,density:real,red:real,green:real,blue:real,):nothing
_F.SetTerrainFogEx = jc["SetTerrainFogEx"]

---设置地形通行状态(指定坐标)[R]
---设置(${X},${Y})处单元点的${Pathing}地形通行状态为:${On/Off}
---例:设置'建造'通行状态为开,则该点可以建造建筑.一个单元点范围为32x32.
---@type fun(x:real,y:real,t:pathingtype,flag:boolean,):nothing
_F.SetTerrainPathable = jc["SetTerrainPathable"]

---改变地形类型(指定坐标)[R]
---改变(${X},${Y})处的地形为${TerrainType},使用样式:${Variation}范围:${Area}形状:${Shape}
---地形样式-1表示随机样式.范围即地形编辑器中的刷子大小.1表示128x128范围
---@type fun(x:real,y:real,terrainType:integer,variation:integer,area:integer,shape:integer,):nothing
_F.SetTerrainType = jc["SetTerrainType"]

---@type fun(t:texttag,age:real,):nothing
_F.SetTextTagAge = jc["SetTextTagAge"]

---改变颜色[R]
---改变${FloatingText}的颜色为(${Red},${Green},${Blue})透明值为${Transparency}
---颜色格式为(红,绿,蓝).透明值0为不可见.颜色值和透明值取值范围为0-255.
---@type fun(t:texttag,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetTextTagColor = jc["SetTextTagColor"]

---@type fun(t:texttag,fadepoint:real,):nothing
_F.SetTextTagFadepoint = jc["SetTextTagFadepoint"]

---@type fun(t:texttag,lifespan:real,):nothing
_F.SetTextTagLifespan = jc["SetTextTagLifespan"]

---@type fun(t:texttag,flag:boolean,):nothing
_F.SetTextTagPermanent = jc["SetTextTagPermanent"]

---改变位置(坐标)[R]
---改变${FloatingText}的位置为(${X},${Y}),Z轴高度为${Z}
---@type fun(t:texttag,x:real,y:real,heightOffset:real,):nothing
_F.SetTextTagPos = jc["SetTextTagPos"]

---@type fun(t:texttag,whichUnit:unit,heightOffset:real,):nothing
_F.SetTextTagPosUnit = jc["SetTextTagPosUnit"]

---@type fun(t:texttag,flag:boolean,):nothing
_F.SetTextTagSuspended = jc["SetTextTagSuspended"]

---改变文字内容[R]
---改变${FloatingText}的内容为${文字},字体大小:${Size}
---采用原始字体大小单位.字体大小不能超过0.5.
---@type fun(t:texttag,s:string,height:real,):nothing
_F.SetTextTagText = jc["SetTextTagText"]

---设置速率[R]
---设置${FloatingText}的X轴速率:${XSpeed},Y轴速率:${YSpeed}
---对移动后的漂浮文字设置速率,该漂浮文字会先回到原点再向设定的角度移动.这里的1约等于游戏中的1800速度.
---@type fun(t:texttag,xvel:real,yvel:real,):nothing
_F.SetTextTagVelocity = jc["SetTextTagVelocity"]

---显示/隐藏(所有玩家)[R]
---对所有玩家${Show/Hide}${FloatingText}
---@type fun(t:texttag,flag:boolean,):nothing
_F.SetTextTagVisibility = jc["SetTextTagVisibility"]

---设置主题音乐播放时间点[R]
---设置当前主题音乐播放时间点为${Offset}毫秒
---@type fun(millisecs:integer,):nothing
_F.SetThematicMusicPlayPosition = jc["SetThematicMusicPlayPosition"]

---设置昼夜时间流逝速度[R]
---设置昼夜时间流逝速度为默认值的${Value}倍
---设置100%来恢复正常值.该值并不影响游戏速度.
---@type fun(r:real,):nothing
_F.SetTimeOfDayScale = jc["SetTimeOfDayScale"]

---@type fun(cleared:boolean,):nothing
_F.SetTutorialCleared = jc["SetTutorialCleared"]

---设置渲染状态
---设置${Ubersplat}:${Enable/Disable}渲染状态
---未发现有任何作用.
---@type fun(whichSplat:ubersplat,flag:boolean,):nothing
_F.SetUbersplatRender = jc["SetUbersplatRender"]

---设置永久渲染状态
---设置${Ubersplat}:${Enable/Disable}永久渲染状态
---要显示地面纹理变化则必须开启该项.
---@type fun(whichSplat:ubersplat,flag:boolean,):nothing
_F.SetUbersplatRenderAlways = jc["SetUbersplatRenderAlways"]

---设置技能等级[R]
---设置${单位}的${技能}等级为${Level}
---改变死亡单位的光环技能会导致魔兽崩溃.
---@type fun(whichUnit:unit,abilcode:integer,level:integer,):integer
_F.SetUnitAbilityLevel = jc["SetUnitAbilityLevel"]

---@type fun(whichUnit:unit,newAcquireRange:real,):nothing
_F.SetUnitAcquireRange = jc["SetUnitAcquireRange"]

---播放单位动画
---播放${Unit}的${动画名}动作
---通过'重置单位动作'恢复到普通的动作.
---@type fun(whichUnit:unit,whichAnimation:string,):nothing
_F.SetUnitAnimation = jc["SetUnitAnimation"]

---播放单位指定序号动动作[R]
---播放${单位}的第${序号}号动作
---可以指定播放所有的单位动画,不过需要自己多尝试.每个单位的动作序号不一样的.
---@type fun(whichUnit:unit,whichAnimation:integer,):nothing
_F.SetUnitAnimationByIndex = jc["SetUnitAnimationByIndex"]

---播放单位动运作(指定概率)
---播放${单位}的${AnimationName}动作,只用${Rarity}动作
---通过'重置单位动作'恢复到普通的动作.
---@type fun(whichUnit:unit,whichAnimation:string,rarity:raritycontrol,):nothing
_F.SetUnitAnimationWithRarity = jc["SetUnitAnimationWithRarity"]

---@type fun(whichUnit:unit,blendTime:real,):nothing
_F.SetUnitBlendTime = jc["SetUnitBlendTime"]

---改变队伍颜色
---改变${单位}的队伍颜色为${Color}
---改变队伍颜色并不会改变单位所属.
---@type fun(whichUnit:unit,whichColor:playercolor,):nothing
_F.SetUnitColor = jc["SetUnitColor"]

---锁定指定单位的警戒点[R]
---设置${单位}的警戒点:${option}
---锁定并防止AI脚本改动单位警戒点.
---@type fun(whichUnit:unit,creepGuard:boolean,):nothing
_F.SetUnitCreepGuard = jc["SetUnitCreepGuard"]

---@type fun(whichUnit:unit,exploded:boolean,):nothing
_F.SetUnitExploded = jc["SetUnitExploded"]

---设置单位面向角度[R]
---设置${单位}的面向角度为${Angle}度
---面向角度采用角度制,0度为正东方向,90度为正北方向。速度等于单位的转身速度。
---@type fun(whichUnit:unit,facingAngle:real,):nothing
_F.SetUnitFacing = jc["SetUnitFacing"]

---设置单位面向角度(指定时间)
---设置${单位}的面向角度为${Angle}度,使用时间${Time}秒
---面向角度采用角度制,0度为正东方向,90度为正北方向。不能超过单位的转身速度。
---@type fun(whichUnit:unit,facingAngle:real,duration:real,):nothing
_F.SetUnitFacingTimed = jc["SetUnitFacingTimed"]

---@type fun(whichUnit:unit,newHeight:real,rate:real,):nothing
_F.SetUnitFlyHeight = jc["SetUnitFlyHeight"]

---@type fun(a:real,b:real,c:real,d:real,e:real,):nothing
_F.SetUnitFog = jc["SetUnitFog"]

---设置无敌/可攻击
---设置${单位}${Invulnerable/Vulnerable}
---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.SetUnitInvulnerable = jc["SetUnitInvulnerable"]

---锁定身体朝向
---锁定${单位}的${Source}朝向${目标单位},偏移坐标(${X},${Y},${Z})
---单位的该身体部件会一直朝向目标单位的偏移坐标点处,直到使用'重置身体朝向'.坐标偏移以目标单位脚下为坐标原点.
---@type fun(whichUnit:unit,whichBone:string,lookAtTarget:unit,offsetX:real,offsetY:real,offsetZ:real,):nothing
_F.SetUnitLookAt = jc["SetUnitLookAt"]

---设置移动速度
---设置${单位}的移动速度为${Speed}
---@type fun(whichUnit:unit,newSpeed:real,):nothing
_F.SetUnitMoveSpeed = jc["SetUnitMoveSpeed"]

---改变所属
---改变${单位}所属为${Player}并${Change/RetainColor}
---@type fun(whichUnit:unit,whichPlayer:player,changeColor:boolean,):nothing
_F.SetUnitOwner = jc["SetUnitOwner"]

---设置碰撞开关
---设置${单位}${On/Off}碰撞
---关闭碰撞的单位无视障碍物,但其他单位仍视其为障碍物.
---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.SetUnitPathing = jc["SetUnitPathing"]

---移动单位(立即)(指定坐标)[R]
---立即移动${单位}到(${X},${Y})
---@type fun(whichUnit:unit,newX:real,newY:real,):nothing
_F.SetUnitPosition = jc["SetUnitPosition"]

---移动单位(立即)(指定点)
---立即移动${单位}到${指定点}
---@type fun(whichUnit:unit,whichLocation:location,):nothing
_F.SetUnitPositionLoc = jc["SetUnitPositionLoc"]

---改变单位转向角度(弧度制)[R]
---改变${单位}的转向角度为${数值}(弧度制)
---设置单位转身时的转向角度.数值越大转向幅度越大.
---@type fun(whichUnit:unit,newPropWindowAngle:real,):nothing
_F.SetUnitPropWindow = jc["SetUnitPropWindow"]

---设置可否营救(对玩家)[R]
---设置${单位}对${玩家}${Rescuable/Unrescuable}
---@type fun(whichUnit:unit,byWhichPlayer:player,flag:boolean,):nothing
_F.SetUnitRescuable = jc["SetUnitRescuable"]

---设置营救范围
---设置${单位}的营救范围为${Range}
---@type fun(whichUnit:unit,range:real,):nothing
_F.SetUnitRescueRange = jc["SetUnitRescueRange"]

---改变单位尺寸(按倍数)[R]
---改变${单位}的尺寸缩放为:(${X},${Y},${Z})
---缩放尺寸使用(长,宽,高)格式.
---@type fun(whichUnit:unit,scaleX:real,scaleY:real,scaleZ:real,):nothing
_F.SetUnitScale = jc["SetUnitScale"]

---设置单位属性[R]
---设置${单位}的${属性}为${Value}
---@type fun(whichUnit:unit,whichUnitState:unitstate,newVal:real,):nothing
_F.SetUnitState = jc["SetUnitState"]

---改变单位动画播放速度(按倍数)[R]
---改变${单位}的动画播放速度为正常速度的${Percent}倍
---设置1倍动画播放速度来恢复正常状态.
---@type fun(whichUnit:unit,timeScale:real,):nothing
_F.SetUnitTimeScale = jc["SetUnitTimeScale"]

---@type fun(whichUnit:unit,newTurnSpeed:real,):nothing
_F.SetUnitTurnSpeed = jc["SetUnitTurnSpeed"]

---限制单位种类(指定市场)
---限制${Marketplace}的可出售单位种类数为${Quantity}
---只影响有'出售单位'技能的单位.
---@type fun(whichUnit:unit,slots:integer,):nothing
_F.SetUnitTypeSlots = jc["SetUnitTypeSlots"]

---允许/禁止人口占用[R]
---设置${单位}:${Enable/Disable}其人口占用
---@type fun(whichUnit:unit,useFood:boolean,):nothing
_F.SetUnitUseFood = jc["SetUnitUseFood"]

---设置自定义值
---设置${单位}的自定义值为${Index}
---单位自定义值仅用于触发器.可用来给单位绑定一个整型数据.
---@type fun(whichUnit:unit,data:integer,):nothing
_F.SetUnitUserData = jc["SetUnitUserData"]

---改变单位的颜色(RGB:0-255)[R]
---改变${单位}的颜色值:(${Red},${Green},${Blue}),透明值:${Transparency}
---颜色格式为(红,绿,蓝).大多数单位使用(255,255,255)的颜色值和255的Alpha值.透明值为0是不可见的.颜色值和Alpha值取值范围为0-255.
---@type fun(whichUnit:unit,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetUnitVertexColor = jc["SetUnitVertexColor"]

---设置X坐标[R]
---设置${单位}的X坐标为${X}
---注意如果坐标超出地图边界是会出错的.
---@type fun(whichUnit:unit,newX:real,):nothing
_F.SetUnitX = jc["SetUnitX"]

---设置Y坐标[R]
---设置${单位}的Y坐标为${Y}
---注意如果坐标超出地图边界是会出错的.
---@type fun(whichUnit:unit,newY:real,):nothing
_F.SetUnitY = jc["SetUnitY"]

---设置水颜色[R]
---设置水颜色为:(${Red},${Green},${Blue}),透明值为:${Transparency}
---颜色格式为(红,绿,蓝).透明值0为不可见.颜色值和透明道值取值范围为0-255.
---@type fun(red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.SetWaterBaseColor = jc["SetWaterBaseColor"]

---开启/关闭水面变形
---${On/Off}水面变形
---开启时当发生地形变化时水面高度也会随着变化.对永久变形无效.
---@type fun(val:boolean,):nothing
_F.SetWaterDeforms = jc["SetWaterDeforms"]

---@type fun(whichWidget:widget,newLife:real,):nothing
_F.SetWidgetLife = jc["SetWidgetLife"]

---显示/隐藏[R]
---设置${可破坏物}的状态为${Show/Hide}
---隐藏的可破坏物不被显示,但仍影响通行和视线.
---@type fun(d:destructable,flag:boolean,):nothing
_F.ShowDestructable = jc["ShowDestructable"]

---显示/隐藏[R]
---设置${Image}${Show/Hide}
---@type fun(whichImage:image,flag:boolean,):nothing
_F.ShowImage = jc["ShowImage"]

---开启/关闭信箱模式(所有玩家)[R]
---${开启/关闭}信箱模式,转换时间为${Duration}秒
---使用电影镜头模式,隐藏游戏界面.
---@type fun(flag:boolean,fadeDuration:real,):nothing
_F.ShowInterface = jc["ShowInterface"]

---显示/隐藏地面纹理变化[R]
---设置${Ubersplat}状态为${Show/Hide}
---@type fun(whichSplat:ubersplat,flag:boolean,):nothing
_F.ShowUbersplat = jc["ShowUbersplat"]

---显示/隐藏[R]
---设置${单位}的状态为${显示/隐藏}
---隐藏单位不会被'区域内单位'所选取.
---@type fun(whichUnit:unit,show:boolean,):nothing
_F.ShowUnit = jc["ShowUnit"]

---正弦(弧度)[R]
---Sin(${Angle})
---采用弧度制计算.
---@type fun(radians:real,):real
_F.Sin = jc["Sin"]

---平方根
---${实数}的平方根
---@type fun(x:real,):real
_F.SquareRoot = jc["SquareRoot"]

---启用战役AI
---为${Player}启用战役AI:${Script}
---AI只能对电脑玩家使用,当运行该动作后,与之配匹的电脑玩家会强制执行该AI脚本.
---@type fun(num:player,script:string,):nothing
_F.StartCampaignAI = jc["StartCampaignAI"]

---启用对战AI
---为${Player}启用对战AI:${Script}
---AI只能对电脑玩家使用,当运行该动作后,与之配匹的电脑玩家会强制执行该AI脚本.
---@type fun(num:player,script:string,):nothing
_F.StartMeleeAI = jc["StartMeleeAI"]

---@type fun(soundHandle:sound,):nothing
_F.StartSound = jc["StartSound"]

---停止播放镜头(所有玩家)[R]
---让所有玩家停止播放镜头
---比如在平移镜头的过程中可用该动作来中断平移.
---@type fun():nothing
_F.StopCamera = jc["StopCamera"]

---@type fun(fadeOut:boolean,):nothing
_F.StopMusic = jc["StopMusic"]

---@type fun(soundHandle:sound,killWhenDone:boolean,fadeOut:boolean,):nothing
_F.StopSound = jc["StopSound"]

---记录布尔值
---缓存:${GameCache}类别名:${Category}使用名称:${文字}记录:${布尔值}
---使用'游戏缓存-读取布尔值'来读取该值.名称和类别名不能包含空格.
---@type fun(cache:gamecache,missionKey:string,key:string,value:boolean,):nothing
_F.StoreBoolean = jc["StoreBoolean"]

---记录整数
---缓存:${GameCache}类别名:${Category}使用名称:${文字}记录:${整数}
---使用'游戏缓存-读取整数'来读取该数值.名称和类别名不能包含空格.
---@type fun(cache:gamecache,missionKey:string,key:string,value:integer,):nothing
_F.StoreInteger = jc["StoreInteger"]

---记录实数
---缓存:${GameCache}类别名:${Category}使用名称:${文字}记录:${实数}
---使用'游戏缓存-读取实数'来读取该数值.名称和类别名不能包含空格.
---@type fun(cache:gamecache,missionKey:string,key:string,value:real,):nothing
_F.StoreReal = jc["StoreReal"]

---记录字符串
---缓存:${GameCache}类别名:${Category}使用名称:${文字}记录:${字符串}
---使用'游戏缓存-读取字符串'来读取该值.名称和类别名不能包含空格.
---@type fun(cache:gamecache,missionKey:string,key:string,value:string,):boolean
_F.StoreString = jc["StoreString"]

---@type fun(cache:gamecache,missionKey:string,key:string,whichUnit:unit,):boolean
_F.StoreUnit = jc["StoreUnit"]

---大小写转换
---转换${字符串}为${Lower/UpperCase}形式
---@type fun(source:string,upper:boolean,):string
_F.StringCase = jc["StringCase"]

---获取字符串的哈希值
---(${String})的哈希值
---获取一个对应该字符串的密钥，不同的字符串的密钥基本不可能相同，也很难找到两个不同的字符串他们有着相同的密钥。可以用于制作密码等功能。
---@type fun(s:string,):integer
_F.StringHash = jc["StringHash"]

---字符串长度
---${String}的长度
---@type fun(s:string,):integer
_F.StringLength = jc["StringLength"]

---截取字符串[R]
---截取${字符串}的${Start}-${End}字节部分(不包括首字节)
---例:截取''Gruntsstink''的2-4字节部分=''un''.
---@type fun(source:string,start:integer,end:integer,):string
_F.SubString = jc["SubString"]

---允许/禁止经验获取[R]
---${Enable/Disable}${Hero}的经验获取
---@type fun(whichHero:unit,flag:boolean,):nothing
_F.SuspendHeroXP = jc["SuspendHeroXP"]

---@type fun(b:boolean,):nothing
_F.SuspendTimeOfDay = jc["SuspendTimeOfDay"]

---@type fun():nothing
_F.SyncSelections = jc["SyncSelections"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.SyncStoredBoolean = jc["SyncStoredBoolean"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.SyncStoredInteger = jc["SyncStoredInteger"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.SyncStoredReal = jc["SyncStoredReal"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.SyncStoredString = jc["SyncStoredString"]

---@type fun(cache:gamecache,missionKey:string,key:string,):nothing
_F.SyncStoredUnit = jc["SyncStoredUnit"]

---正切(弧度)[R]
---Tan(${Angle})
---采用弧度制计算.
---@type fun(radians:real,):real
_F.Tan = jc["Tan"]

---新建地形变化:弹坑[R]
---新建的弹坑变形.中心坐标:(${X},${Y})半径:${Radius}深度:${Depth}持续时间:${Duration}毫秒,变化类型:${Type}
---深度可取负数.永久地形变化在保存游戏时不会被记录.
---@type fun(x:real,y:real,radius:real,depth:real,duration:integer,permanent:boolean,):terraindeformation
_F.TerrainDeformCrater = jc["TerrainDeformCrater"]

---新建地形变化:随机[R]
---新建的随机变形.中心坐标:(${X},${Y})半径:${Radius}最小高度变化:${Depth}最大高度变化:${Depth}持续时间:${Duration}毫秒,变化周期:${Duration}毫秒
---@type fun(x:real,y:real,radius:real,minDelta:real,maxDelta:real,duration:integer,updateInterval:integer,):terraindeformation
_F.TerrainDeformRandom = jc["TerrainDeformRandom"]

---新建地形变化:波纹[R]
---新建的波纹变形.中心坐标:(${X},${Y})最终半径:${Radius}深度:${Depth}持续时间:${Duration}毫秒,变化次数:${Count}面波数:${SpaceWave}总波数:${TimeWave}初始半径率:${数值}变化类型:${Type}
---初始半径率=初始半径/最终半径.
---@type fun(x:real,y:real,radius:real,depth:real,duration:integer,count:integer,spaceWaves:real,timeWaves:real,radiusStartPct:real,limitNeg:boolean,):terraindeformation
_F.TerrainDeformRipple = jc["TerrainDeformRipple"]

---停止地形变化[R]
---停止${TerrainDeformation},衰退时间:${Duration}毫秒
---地形变化会平滑地过渡到无.
---@type fun(deformation:terraindeformation,duration:integer,):nothing
_F.TerrainDeformStop = jc["TerrainDeformStop"]

---停止所有地形变化
---停止所有地形变化
---包括由技能引起的地形变化.
---@type fun():nothing
_F.TerrainDeformStopAll = jc["TerrainDeformStopAll"]

---新建地形变化:冲击波[R]
---新建的冲击波变形.起始坐标:(${X},${Y})波方向:(${X},${Y})波距离:${distance}波速度:${speed}波半径:${radius}深度:${Depth}变形效果持续时间:${Delay}毫秒,变化次数:${Count}
---深度可取负数.方向以(X,Y)坐标形式表示,如(1,1)表示45度.
---@type fun(x:real,y:real,dirX:real,dirY:real,distance:real,speed:real,radius:real,depth:real,trailTime:integer,count:integer,):terraindeformation
_F.TerrainDeformWave = jc["TerrainDeformWave"]

---显示/隐藏计时器窗口(所有玩家)[R]
---设置${计时器窗口}的状态为${Show/Hide}
---计时器窗口不能在地图初始化时显示.
---@type fun(whichDialog:timerdialog,display:boolean,):nothing
_F.TimerDialogDisplay = jc["TimerDialogDisplay"]

---@type fun(whichDialog:timerdialog,timeRemaining:real,):nothing
_F.TimerDialogSetRealTimeRemaining = jc["TimerDialogSetRealTimeRemaining"]

---设置计时器窗口速率[R]
---设置${TimerWindow}的时间流逝速度为${Factor}倍
---同时计时器显示时间也会随之变化.就是说60秒的计时器设置为2倍速则显示时间也会变为120秒.
---@type fun(whichDialog:timerdialog,speedMultFactor:real,):nothing
_F.TimerDialogSetSpeed = jc["TimerDialogSetSpeed"]

---改变计时器窗口计时颜色[R]
---改变${TimerWindow}的计间颜色为(${Red},${Green},${Blue})透明值为:${Transparency}
---颜色格式为(红,绿,蓝).Alpha通道值0为不可见.颜色值和透明值值取值范围为0-255.
---@type fun(whichDialog:timerdialog,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.TimerDialogSetTimeColor = jc["TimerDialogSetTimeColor"]

---@type fun(whichDialog:timerdialog,title:string,):nothing
_F.TimerDialogSetTitle = jc["TimerDialogSetTitle"]

---改变计时器窗口文字颜色[R]
---改变${TimerWindow}文字颜色为(${Red},${Green},${Blue})透明值为:${Transparency}
---颜色格式为(红,绿,蓝).Alpha通道值0为不可见.颜色值和透明值值取值范围为0-255.
---@type fun(whichDialog:timerdialog,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.TimerDialogSetTitleColor = jc["TimerDialogSetTitleColor"]

---逝去时间
---${计时器}的逝去时间
---@type fun(whichTimer:timer,):real
_F.TimerGetElapsed = jc["TimerGetElapsed"]

---剩余时间
---${计时器}的剩余时间
---@type fun(whichTimer:timer,):real
_F.TimerGetRemaining = jc["TimerGetRemaining"]

---设置时间
---${计时器}设置的时间
---@type fun(whichTimer:timer,):real
_F.TimerGetTimeout = jc["TimerGetTimeout"]

---运行计时器[C]
---运行${计时器}，周期:${时间}秒，模式:${模式}，运行函数:${函数}
---等同于TimerStart
---@type fun(whichTimer:timer,timeout:real,periodic:boolean,handlerFunc:code,):nothing
_F.TimerStart = jc["TimerStart"]

---@type fun(whichTrigger:trigger,actionFunc:code,):triggeraction
_F.TriggerAddAction = jc["TriggerAddAction"]

---@type fun(whichTrigger:trigger,condition:boolexpr,):triggercondition
_F.TriggerAddCondition = jc["TriggerAddCondition"]

---@type fun(whichTrigger:trigger,):nothing
_F.TriggerClearActions = jc["TriggerClearActions"]

---@type fun(whichTrigger:trigger,):nothing
_F.TriggerClearConditions = jc["TriggerClearConditions"]

---触发条件成立
---${触发}的条件成立
---@type fun(whichTrigger:trigger,):boolean
_F.TriggerEvaluate = jc["TriggerEvaluate"]

---运行触发(无视条件)
---运行${触发}(无视条件)
---无视事件和条件,运行触发动作.
---@type fun(whichTrigger:trigger,):nothing
_F.TriggerExecute = jc["TriggerExecute"]

---@type fun(whichTrigger:trigger,):nothing
_F.TriggerExecuteWait = jc["TriggerExecuteWait"]

---可破坏物死亡
---${可破坏物}死亡
---使用'事件响应-死亡的可破坏物'来获取死亡物体.
---@type fun(whichTrigger:trigger,whichWidget:widget,):event
_F.TriggerRegisterDeathEvent = jc["TriggerRegisterDeathEvent"]

---对话框按钮被点击[R]
---${对话框按钮}被点击
---指定对话框按钮被点击,该事件一般需要在其他触发为其添加.
---@type fun(whichTrigger:trigger,whichButton:button,):event
_F.TriggerRegisterDialogButtonEvent = jc["TriggerRegisterDialogButtonEvent"]

---@type fun(whichTrigger:trigger,whichDialog:dialog,):event
_F.TriggerRegisterDialogEvent = jc["TriggerRegisterDialogEvent"]

---单位进入不规则区域(指定条件)[R]
---单位进入${区域}并满足${条件}
---使用'事件响应-进入的单位'来响应进入该区域的单位.该事件需要在其他触发为其添加.
---@type fun(whichTrigger:trigger,whichRegion:region,filter:boolexpr,):event
_F.TriggerRegisterEnterRegion = jc["TriggerRegisterEnterRegion"]

---@type fun(whichTrigger:trigger,whichUnit:unit,whichEvent:unitevent,filter:boolexpr,):event
_F.TriggerRegisterFilterUnitEvent = jc["TriggerRegisterFilterUnitEvent"]

---比赛游戏事件
---该游戏将在${EventType}后结束
---该事件只出现在Battle.net的自动匹配游戏.
---@type fun(whichTrigger:trigger,whichGameEvent:gameevent,):event
_F.TriggerRegisterGameEvent = jc["TriggerRegisterGameEvent"]

---@type fun(whichTrigger:trigger,whichState:gamestate,opcode:limitop,limitval:real,):event
_F.TriggerRegisterGameStateEvent = jc["TriggerRegisterGameStateEvent"]

---单位离开不规则区域(指定条件)[R]
---单位离开${区域}并满足${条件}
---使用'事件响应-离开的单位'来响应离开该区域的单位.该事件需要在其他触发为其添加.
---@type fun(whichTrigger:trigger,whichRegion:region,filter:boolexpr,):event
_F.TriggerRegisterLeaveRegion = jc["TriggerRegisterLeaveRegion"]

---联盟状态更改(指定项目)
---${Player}更改${AllianceType}设置
---当改变项目为【共享单位】时，(触发玩家)会不生效，此时不建议使用【任意玩家】事件。
---@type fun(whichTrigger:trigger,whichPlayer:player,whichAlliance:alliancetype,):event
_F.TriggerRegisterPlayerAllianceChange = jc["TriggerRegisterPlayerAllianceChange"]

---输入聊天信息
---${玩家}输入${Text},信息过滤方式${MatchType}
---事件ID是(096)
---@type fun(whichTrigger:trigger,whichPlayer:player,chatMessageToDetect:string,exactMatchOnly:boolean,):event
_F.TriggerRegisterPlayerChatEvent = jc["TriggerRegisterPlayerChatEvent"]

---@type fun(whichTrigger:trigger,:player,whichPlayerEvent:playerevent,):event
_F.TriggerRegisterPlayerEvent = jc["TriggerRegisterPlayerEvent"]

---属性事件
---${玩家}的${Property}属性${Operation}${值}
---@type fun(whichTrigger:trigger,whichPlayer:player,whichState:playerstate,opcode:limitop,limitval:real,):event
_F.TriggerRegisterPlayerStateEvent = jc["TriggerRegisterPlayerStateEvent"]

---@type fun(whichTrigger:trigger,whichPlayer:player,whichPlayerUnitEvent:playerunitevent,filter:boolexpr,):event
_F.TriggerRegisterPlayerUnitEvent = jc["TriggerRegisterPlayerUnitEvent"]

---@type fun(whichTrigger:trigger,timeout:real,periodic:boolean,):event
_F.TriggerRegisterTimerEvent = jc["TriggerRegisterTimerEvent"]

---@type fun(whichTrigger:trigger,t:timer,):event
_F.TriggerRegisterTimerExpireEvent = jc["TriggerRegisterTimerExpireEvent"]

---鼠标点击可追踪物[R]
---鼠标点击${可追踪物}
---@type fun(whichTrigger:trigger,t:trackable,):event
_F.TriggerRegisterTrackableHitEvent = jc["TriggerRegisterTrackableHitEvent"]

---鼠标移动到追踪对象[R]
---鼠标移动到${可追踪物}
---@type fun(whichTrigger:trigger,t:trackable,):event
_F.TriggerRegisterTrackableTrackEvent = jc["TriggerRegisterTrackableTrackEvent"]

---指定单位事件
---${指定单位}${事件}
---@type fun(whichTrigger:trigger,whichUnit:unit,whichEvent:unitevent,):event
_F.TriggerRegisterUnitEvent = jc["TriggerRegisterUnitEvent"]

---@type fun(whichTrigger:trigger,whichUnit:unit,range:real,filter:boolexpr,):event
_F.TriggerRegisterUnitInRange = jc["TriggerRegisterUnitInRange"]

---@type fun(whichTrigger:trigger,whichUnit:unit,whichState:unitstate,opcode:limitop,limitval:real,):event
_F.TriggerRegisterUnitStateEvent = jc["TriggerRegisterUnitStateEvent"]

---实数变量事件
---${变量}的值${Operation}${值}
---这个事件只适用于实数类型的变量.
---@type fun(whichTrigger:trigger,varName:string,opcode:limitop,limitval:real,):event
_F.TriggerRegisterVariableEvent = jc["TriggerRegisterVariableEvent"]

---@type fun(whichTrigger:trigger,whichAction:triggeraction,):nothing
_F.TriggerRemoveAction = jc["TriggerRemoveAction"]

---@type fun(whichTrigger:trigger,whichCondition:triggercondition,):nothing
_F.TriggerRemoveCondition = jc["TriggerRemoveCondition"]

---等待(玩家时间)
---等待${Time}秒
---该延迟功能受真实时间的影响(也就是玩家机器上的时间).因此每个玩家所延迟的时间可能不一致.
---@type fun(timeout:real,):nothing
_F.TriggerSleepAction = jc["TriggerSleepAction"]

---@type fun():nothing
_F.TriggerSyncReady = jc["TriggerSyncReady"]

---@type fun():nothing
_F.TriggerSyncStart = jc["TriggerSyncStart"]

---@type fun(s:sound,offset:real,):nothing
_F.TriggerWaitForSound = jc["TriggerWaitForSound"]

---@type fun(whichTrigger:trigger,flag:boolean,):nothing
_F.TriggerWaitOnSleeps = jc["TriggerWaitOnSleeps"]

---添加技能[R]
---为${单位}添加${技能}
---@type fun(whichUnit:unit,abilityId:integer,):boolean
_F.UnitAddAbility = jc["UnitAddAbility"]

---@type fun(whichUnit:unit,red:integer,green:integer,blue:integer,alpha:integer,):nothing
_F.UnitAddIndicator = jc["UnitAddIndicator"]

---给予物品[R]
---给予${单位}${物品}
---@type fun(whichUnit:unit,whichItem:item,):boolean
_F.UnitAddItem = jc["UnitAddItem"]

---@type fun(whichUnit:unit,itemId:integer,):item
_F.UnitAddItemById = jc["UnitAddItemById"]

---新建物品到指定物品栏[R]
---给予${单位}${物品类型}并放在物品栏#${数值}
---注意:物品栏编号从0-5,而不是1-6.该动作创建的物品不被'最后创建的物品'所记录.
---@type fun(whichUnit:unit,itemId:integer,itemSlot:integer,):boolean
_F.UnitAddItemToSlotById = jc["UnitAddItemToSlotById"]

---@type fun(whichUnit:unit,add:boolean,):nothing
_F.UnitAddSleep = jc["UnitAddSleep"]

---控制单位睡眠状态
---使${单位}${Sleep/RemainAwake}
---使用该功能前必须用触发为单位添加'一直睡眠'技能.
---@type fun(whichUnit:unit,add:boolean,):nothing
_F.UnitAddSleepPerm = jc["UnitAddSleepPerm"]

---添加类别[R]
---为${单位}添加${Classification}类别
---已去除所有无效类别.
---@type fun(whichUnit:unit,whichUnitType:unittype,):boolean
_F.UnitAddType = jc["UnitAddType"]

---设置生命周期[R]
---为${单位}设置${BuffType}类型的生命周期,持续时间为${Duration}秒
---@type fun(whichUnit:unit,buffId:integer,duration:real,):nothing
_F.UnitApplyTimedLife = jc["UnitApplyTimedLife"]

---@type fun(whichUnit:unit,):boolean
_F.UnitCanSleep = jc["UnitCanSleep"]

---@type fun(whichUnit:unit,):boolean
_F.UnitCanSleepPerm = jc["UnitCanSleepPerm"]

---拥有Buff数量[R]
---${单位}的附带Buff数量,(${Include/Exclude}正面Buff,${Include/Exclude}负面Buff${Include/Exclude}魔法Buff,${Include/Exclude}物理Buff${Include/Exclude}生命周期,${Include/Exclude}光环效果${Include/Exclude}不可驱散Buff)
---@type fun(whichUnit:unit,removePositive:boolean,removeNegative:boolean,magic:boolean,physical:boolean,timedLife:boolean,aura:boolean,autoDispel:boolean,):integer
_F.UnitCountBuffsEx = jc["UnitCountBuffsEx"]

---伤害区域[R]
---命令${单位}在${Seconds}秒后对半径为${Size}圆心为(${X},${Y})的范围造成${Amount}点伤害(${是}攻击伤害,${是}远程攻击)攻击类型:${AttackType}伤害类型:${DamageType}装甲类型:${WeaponType}
---该动作不会打断单位动作.由该动作伤害/杀死单位同样正常触发'受到伤害'和'死亡'单位事件.
---@type fun(whichUnit:unit,delay:real,radius:real,x:real,y:real,amount:real,attack:boolean,ranged:boolean,attackType:attacktype,damageType:damagetype,weaponType:weapontype,):boolean
_F.UnitDamagePoint = jc["UnitDamagePoint"]

---伤害目标[R]
---命令${单位}对${Target}造成${Amount}点伤害(${是}攻击伤害,${是}远程攻击)攻击类型:${AttackType}伤害类型:${DamageType}武器类型:${WeaponType}
---该动作不会打断单位动作.由该动作伤害/杀死单位同样正常触发'受到伤害'和'死亡'单位事件.
---@type fun(whichUnit:unit,target:widget,amount:real,attack:boolean,ranged:boolean,attackType:attacktype,damageType:damagetype,weaponType:weapontype,):boolean
_F.UnitDamageTarget = jc["UnitDamageTarget"]

---发布丢弃物品命令(指定坐标)[R]
---命令${单位}丢弃物品${物品}到坐标:(${X},${Y})
---@type fun(whichUnit:unit,whichItem:item,x:real,y:real,):boolean
_F.UnitDropItemPoint = jc["UnitDropItemPoint"]

---移动物品到物品栏[R]
---命令${单位}移动${物品}到物品栏#${Index}
---只有当单位持有该物品时才有效.注意:该函数中物品栏编号从0-5,而不是1-6.
---@type fun(whichUnit:unit,whichItem:item,slot:integer,):boolean
_F.UnitDropItemSlot = jc["UnitDropItemSlot"]

---@type fun(whichUnit:unit,whichItem:item,target:widget,):boolean
_F.UnitDropItemTarget = jc["UnitDropItemTarget"]

---@type fun(whichUnit:unit,removePositive:boolean,removeNegative:boolean,magic:boolean,physical:boolean,timedLife:boolean,aura:boolean,autoDispel:boolean,):boolean
_F.UnitHasBuffsEx = jc["UnitHasBuffsEx"]

---持有物品
---${Hero}拥有${物品}
---@type fun(whichUnit:unit,whichItem:item,):boolean
_F.UnitHasItem = jc["UnitHasItem"]

---@type fun(:string,):integer
_F.UnitId = jc["UnitId"]

---@type fun(unitId:integer,):string
_F.UnitId2String = jc["UnitId2String"]

---@type fun(whichUnit:unit,flag:boolean,):boolean
_F.UnitIgnoreAlarm = jc["UnitIgnoreAlarm"]

---@type fun(whichUnit:unit,):boolean
_F.UnitIgnoreAlarmToggled = jc["UnitIgnoreAlarmToggled"]

---@type fun(whichUnit:unit,):integer
_F.UnitInventorySize = jc["UnitInventorySize"]

---@type fun(whichUnit:unit,):boolean
_F.UnitIsSleeping = jc["UnitIsSleeping"]

---单位持有物品
---${单位}物品栏第${Index}格的物品
---第一个单位格的位置为0.
---@type fun(whichUnit:unit,itemSlot:integer,):item
_F.UnitItemInSlot = jc["UnitItemInSlot"]

---设置技能永久性[R]
---设置${单位}${是否}${技能}永久性
---如触发添加给单位的技能就是非永久性的,非永久性技能在变身并回复之后会丢失掉.这类情况就需要设置技能永久性.
---@type fun(whichUnit:unit,permanent:boolean,abilityId:integer,):boolean
_F.UnitMakeAbilityPermanent = jc["UnitMakeAbilityPermanent"]

---添加剩余技能点[R]
---增加${英雄}${Value}点剩余技能点
---@type fun(whichHero:unit,skillPointDelta:integer,):boolean
_F.UnitModifySkillPoints = jc["UnitModifySkillPoints"]

---暂停/恢复生命周期[R]
---使${单位}${Pause/Unpause}生命周期
---只有召唤单位有生命周期.
---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.UnitPauseTimedLife = jc["UnitPauseTimedLife"]

---添加单位类型[R]
---在${单位池}中添加一个${单位}比重为${数值}
---比重越高被选择的机率越大
---@type fun(whichPool:unitpool,unitId:integer,weight:real,):nothing
_F.UnitPoolAddUnitType = jc["UnitPoolAddUnitType"]

---删除单位类型[R]
---从${单位池}中删除${单位}
---@type fun(whichPool:unitpool,unitId:integer,):nothing
_F.UnitPoolRemoveUnitType = jc["UnitPoolRemoveUnitType"]

---删除技能[R]
---为${单位}删除${技能}
---@type fun(whichUnit:unit,abilityId:integer,):boolean
_F.UnitRemoveAbility = jc["UnitRemoveAbility"]

---@type fun(whichUnit:unit,removePositive:boolean,removeNegative:boolean,):nothing
_F.UnitRemoveBuffs = jc["UnitRemoveBuffs"]

---@type fun(whichUnit:unit,removePositive:boolean,removeNegative:boolean,magic:boolean,physical:boolean,timedLife:boolean,aura:boolean,autoDispel:boolean,):nothing
_F.UnitRemoveBuffsEx = jc["UnitRemoveBuffsEx"]

---@type fun(whichUnit:unit,whichItem:item,):nothing
_F.UnitRemoveItem = jc["UnitRemoveItem"]

---@type fun(whichUnit:unit,itemSlot:integer,):item
_F.UnitRemoveItemFromSlot = jc["UnitRemoveItemFromSlot"]

---删除类别[R]
---为${单位}删除${Classification}类别
---已去除所有无效类别.
---@type fun(whichUnit:unit,whichUnitType:unittype,):boolean
_F.UnitRemoveType = jc["UnitRemoveType"]

---重置技能CD
---重置${单位}的所有技能冷却时间
---如果要重置单一技能的CD,可以通过删除技能+添加技能+设置技能等级来完成.
---@type fun(whichUnit:unit,):nothing
_F.UnitResetCooldown = jc["UnitResetCooldown"]

---设置建筑建造进度条
---设置${Building}的建造进度条为${Progress}%
---只作用于正在建造的建筑.
---@type fun(whichUnit:unit,constructionPercentage:integer,):nothing
_F.UnitSetConstructionProgress = jc["UnitSetConstructionProgress"]

---设置建筑升级进度条
---设置${Building}的升级进度条为${Progress}%
---只作用于正在升级的建筑.是建筑A升级为建筑B的升级,不是科技的研究.
---@type fun(whichUnit:unit,upgradePercentage:integer,):nothing
_F.UnitSetUpgradeProgress = jc["UnitSetUpgradeProgress"]

---@type fun(whichUnit:unit,flag:boolean,):nothing
_F.UnitSetUsesAltIcon = jc["UnitSetUsesAltIcon"]

---共享视野[R]
---设置${单位}的视野对${Player}${on/off}
---@type fun(whichUnit:unit,whichPlayer:player,share:boolean,):nothing
_F.UnitShareVision = jc["UnitShareVision"]

---降低等级[R]
---降低${Hero}${Level}个等级
---只能降低等级.英雄经验将重置为该等级的初始值.
---@type fun(whichHero:unit,howManyLevels:integer,):boolean
_F.UnitStripHeroLevel = jc["UnitStripHeroLevel"]

---暂停尸体腐烂[R]
---设置${单位}的尸体腐烂状态:${Suspend/Resume}
---只对已完成死亡动作的尸体有效.
---@type fun(whichUnit:unit,suspend:boolean,):nothing
_F.UnitSuspendDecay = jc["UnitSuspendDecay"]

---使用物品(无目标)
---命令${单位}使用${物品}
---@type fun(whichUnit:unit,whichItem:item,):boolean
_F.UnitUseItem = jc["UnitUseItem"]

---使用物品(指定坐标)
---命令${单位}使用${物品},目标坐标:(${X},${Y})
---@type fun(whichUnit:unit,whichItem:item,x:real,y:real,):boolean
_F.UnitUseItemPoint = jc["UnitUseItemPoint"]

---使用物品(对单位)
---命令${单位}使用${物品},目标:${单位}
---@type fun(whichUnit:unit,whichItem:item,target:widget,):boolean
_F.UnitUseItemTarget = jc["UnitUseItemTarget"]

---@type fun(whichUnit:unit,):nothing
_F.UnitWakeUp = jc["UnitWakeUp"]

---@type fun(soundHandle:sound,byPosition:boolean,rectwidth:real,rectheight:real,):nothing
_F.UnregisterStackedSound = jc["UnregisterStackedSound"]

---@type fun(whichVersion:version,):boolean
_F.VersionCompatible = jc["VersionCompatible"]

---@type fun():version
_F.VersionGet = jc["VersionGet"]

---@type fun(whichVersion:version,):boolean
_F.VersionSupported = jc["VersionSupported"]

---@type fun():nothing
_F.VolumeGroupReset = jc["VolumeGroupReset"]

---设置多通道音量[R]
---设置${VolumeChannel}的音量为${Volume}
---音量取值范围0-1.
---@type fun(vgroup:volumegroup,scale:real,):nothing
_F.VolumeGroupSetVolume = jc["VolumeGroupSetVolume"]

---@type fun(waygate:unit,activate:boolean,):nothing
_F.WaygateActivate = jc["WaygateActivate"]

---传送门目的地X坐标
---${传送门}的目的地X坐标
---@type fun(waygate:unit,):real
_F.WaygateGetDestinationX = jc["WaygateGetDestinationX"]

---传送门目的地Y坐标
---${传送门}的目的地Y坐标
---@type fun(waygate:unit,):real
_F.WaygateGetDestinationY = jc["WaygateGetDestinationY"]

---@type fun(waygate:unit,):boolean
_F.WaygateIsActive = jc["WaygateIsActive"]

---设置传送门目的坐标[R]
---设置${传送门}的目的地为(${X},${Y})
---@type fun(waygate:unit,x:real,y:real,):nothing
_F.WaygateSetDestination = jc["WaygateSetDestination"]


