

function triggerDemo1()

    local player = _F.GetLocalPlayer()
    local u = _F.CreateUnit(player, char2id("A000"),
        0, 0, 270)
    local i = _F.CreateItem(char2id("i000"), 8, 8)

    -- 1 创建触发器
    local trg1 = _F.CreateTrigger();
    -- 2 注册动作
    _F.TriggerAddAction(trg1, function()
        local i = _F.GetManipulatedItem();
        local u = _F.GetTriggerUnit()
        local p = _F.GetTriggerPlayer()

       
        dump(_F.GetPlayerName(p), "evtData,玩家")
        dump(_F.GetUnitName(u), "evtData,单位")
        dump(_F.GetItemName(i), "evtData,物品")
    end)

    -- 3 注册事件
    -- 给玩家的所有单位注册事件
    -- EVENT_PLAYER_UNIT_PICKUP_ITEM
    _F.TriggerRegisterPlayerUnitEvent(
        trg1,
        player,
        _F.ConvertPlayerUnitEvent(49),
        nil
    )
end


-- 给玩家的单位注册拾取物品事件
function playerPickItemEvent(player, action)
    -- 1 创建触发器
    local trg1 = _F.CreateTrigger();
    -- 2 注册动作
    _F.TriggerAddAction(trg1, function()
        local i = _F.GetManipulatedItem();
        local u = _F.GetTriggerUnit()
        local p = _F.GetTriggerPlayer()


        echo(p,"【evtData,玩家】".._F.GetPlayerName(p))
        echo(p,"【evtData,单位】".._F.GetUnitName(u))
        echo(p,"【evtData,物品】".._F.GetItemName(i))

        if (type(action) == "function") then
            action({ player = p, unit = u, item = i })
        end
    end)
    -- 3 注册事件
    -- 给玩家的所有单位注册事件
    -- EVENT_PLAYER_UNIT_PICKUP_ITEM
    _F.TriggerRegisterPlayerUnitEvent(
        trg1,
        player,
        _C.EVENT_PLAYER_UNIT_PICKUP_ITEM,
        nil
    )
end

-- 丢弃物品事件
function playerDropItemEvent(player, action)
    -- 1 创建触发器
    local trg1 = _F.CreateTrigger();
    -- 2 注册动作
    _F.TriggerAddAction(trg1, function()
        local i = _F.GetManipulatedItem();
        local u = _F.GetTriggerUnit()
        local p = _F.GetTriggerPlayer()


        echo(p,"【evtData,玩家】".._F.GetPlayerName(p))
        echo(p,"【evtData,单位】".._F.GetUnitName(u))
        echo(p,"【evtData,物品】".._F.GetItemName(i))

        if (type(action) == "function") then
            action({ player = p, unit = u, item = i })
        end
    end)
    -- 3 注册事件
    -- 给玩家的所有单位注册事件
    -- EVENT_PLAYER_UNIT_DROP_ITEM
    _F.TriggerRegisterPlayerUnitEvent(
        trg1,
        player,
        _C.EVENT_PLAYER_UNIT_DROP_ITEM,
        nil
    )
end


-- 给玩家的单位注册拾取物品事件
function unitPickItemEvent(unit, action)
    -- 1 创建触发器
    local trg1 = _F.CreateTrigger();
    -- 2 注册动作
    _F.TriggerAddAction(trg1, function()
        local i = _F.GetManipulatedItem();
        local u = _F.GetTriggerUnit()
        local p = _F.GetTriggerPlayer()

        if (type(action) == "function") then
            action({ player = p, unit = u, item = i })
        end
    end)
    -- 3 注册事件
    -- 给单位注册事件
    -- EVENT_PLAYER_UNIT_PICKUP_ITEM
    _F.TriggerRegisterUnitEvent(
        trg1,
        unit,
        _C.EVENT_UNIT_PICKUP_ITEM
    )
end

-- 单位丢弃物品事件
function unitDropItemEvent(unit, action)
    -- 1 创建触发器
    local trg1 = _F.CreateTrigger();
    -- 2 注册动作
    _F.TriggerAddAction(trg1, function()
        local i = _F.GetManipulatedItem();
        local u = _F.GetTriggerUnit()
        local p = _F.GetTriggerPlayer()
        if (type(action) == "function") then
            action({ player = p, unit = u, item = i })
        end
    end)
    -- 3 注册事件
    -- 给单位注册事件
    -- EVENT_UNIT_DROP_ITEM
    _F.TriggerRegisterUnitEvent(
        trg1,
        unit,
        _C.EVENT_UNIT_DROP_ITEM
    )
end


function triggerDemo2()
    local player = _F.GetLocalPlayer()
    local u = _F.CreateUnit(player, char2id("A000"),
        0, 0, 270)
    local i = _F.CreateItem(char2id("i000"), 8, 8)

    playerPickItemEvent(player,function (evtData)
        echo(player,"执行物品自动合成")
    end)
end


function triggerDemo3()
    local player = _F.GetLocalPlayer()
    local u = _F.CreateUnit(player, char2id("A000"),
        0, 0, 270)
    local i = _F.CreateItem(char2id("i000"), 8, 8)

    playerPickItemEvent(player,function (evtData)
        echo(player,"执行物品自动合成")
    end)

    playerDropItemEvent(player,function (evtData)
        echo(player,"单位丢弃了物品")
    end)
end


function triggerDemo4()
    local player = _F.GetLocalPlayer()
    local u = _F.CreateUnit(player, char2id("A000"),
        0, 0, 270)
    local u2 = _F.CreateUnit(player,char2id("Edem"),10,10,270)

    for i = 1, 10, 1 do
       _F.CreateItem(char2id("i000"), 8, 8)
    end

    playerPickItemEvent(player,function (evtData)
        echo(player,"执行物品自动合成")
    end)

    playerDropItemEvent(player,function (evtData)
        echo(player,"单位丢弃了物品")
    end)
end



function triggerDemo5()
    local player = _F.GetLocalPlayer()
    local u = _F.CreateUnit(player, char2id("A000"),
        0, 0, 270)
    local u2 = _F.CreateUnit(player,char2id("Edem"),10,10,270)

    for i = 1, 10, 1 do
       _F.CreateItem(char2id("i000"), 8, 8)
    end

    playerPickItemEvent(player,function (evtData)
        echo(player,"执行物品自动合成")
    end)

    playerDropItemEvent(player,function (evtData)
        echo(player,"单位丢弃了物品")
    end)


    unitPickItemEvent(u,function (evtData)
        echo(player,"----拾取事件")
    end)
    unitDropItemEvent(u,function (evtData)
        echo(evtData.player,"-----丢弃事件")        
    end)
end
