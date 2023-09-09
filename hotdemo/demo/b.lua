local Stage = {
    -- 演员表
    actors = {}
}

Stage.onStart = function()
    print("演员上台")
    -- 获取玩家
    local player = _F.GetLocalPlayer();
    -- id用的游戏自带的物编
    local commonUnit = _F.CreateUnit(player, char2id("Nbbc"), 0, 0, 270)
    
    Stage.actors['u1'] = commonUnit
end

Stage.onStop = function()
    print("演员下台")

    _F.RemoveUnit(Stage.actors["u1"])
end

return Stage
