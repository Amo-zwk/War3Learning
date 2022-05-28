function SetPlayerState()
    -- 获取本地玩家 
    -- 多人地图 
    -- 同一份代码运行在多个电脑上
    -- 获取本地玩家返回不同的玩家
    -- 你和朋友开黑玩一个地图
    -- 你的电脑 getLocalPlayer读取的你(张三)
    -- 朋友的电脑 getLocalPlayer读取的朋友(李四)
    local locPlayer = _F.GetLocalPlayer();

    -- 金钱
    _F.SetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(1),
        202
    )
    -- 木材
    _F.SetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(2),
        302
    )
    -- 食物消耗
    _F.SetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(5),
        80
    )
    -- 食物总量
    _F.SetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(4),
        100
    )
end

function getPlayerState()
    local locPlayer = _F.GetLocalPlayer();
    -- 金钱
    local gold = _F.GetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(1)
    )
    -- 木材
    local mc = _F.GetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(2)
    )
    -- 食物消耗
    local c = _F.GetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(5)
    )
    -- 食物总量
    local d = _F.GetPlayerState(
        locPlayer,
        _F.ConvertPlayerState(4)
    )
    dump(gold,"金钱")
    dump(mc,"木材")
    dump(c,"食物消耗")
    dump(d,"食物总量")
    
end