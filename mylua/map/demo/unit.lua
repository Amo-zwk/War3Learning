function UnitDemo1()
    -- 获取玩家
    local player = _F.GetLocalPlayer();
    -- id用的游戏自带的物编
    local commonUnit = _F.CreateUnit(player,char2id("Nbbc"),0,0,270)

    local enemyPlayer = _F.Player(1);
    local enemyUnit =  _F.CreateUnit(enemyPlayer,char2id("hpea"),0,0,270)
end

function UnitDemo2()
     -- 获取玩家
     local player = _F.GetLocalPlayer();
     -- id用的游戏自带的物编
     local commonUnit = _F.CreateUnit(player,char2id("A000"),0,0,270)
    
    --  敌人单位
    local enemyPlayer = _F.Player(1);
    _F.CreateUnit(enemyPlayer,char2id("ogru"),0,0,270)

    -- 定时器
    local trg = _F.CreateTrigger();
    _F.TriggerAddAction(trg,function ()
        _F.CreateUnit(enemyPlayer,char2id("ogru"),0,0,270)
    end)
    _F.TriggerRegisterTimerEvent(trg,10,true)
end