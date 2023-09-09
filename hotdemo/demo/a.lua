print("231321")
-- 每次按键都会创建英雄 
-- 测试的时候 只希望保留一个英雄
 -- 获取玩家
 local player = _F.GetLocalPlayer();
 -- id用的游戏自带的物编
 local commonUnit = _F.CreateUnit(player,char2id("Nbbc"),0,0,270)

