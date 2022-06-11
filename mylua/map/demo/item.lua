function itemDemo1()
    -- 物品id rat6 攻击之抓+6
    local i = _F.CreateItem(char2id("rat6"), 5, 5);
    -- 返回值是物品的这个handle(物品的内存地址值)
    dump(i, "item");
end

function itemDemo2()
    -- 物品id rat6 攻击之抓+6 游戏自带的物品
    local i = _F.CreateItem(char2id("rat6"), 5, 5);

    local p = _F.Player(0);
    local u = _F.CreateUnit(p, char2id("A000"), 0, 0, 270);

    --  将物品附加给单位
    _F.UnitAddItem(u, i);
end

function itemDemo3()
    
    local p = _F.Player(0);
    local u = _F.CreateUnit(p, char2id("A000"), 0, 0, 270);

    -- 物品id rat6 攻击之抓+6 游戏自带的物品
    local i = _F.CreateItem(char2id("i000"), 5, 5);
    --  将物品附加给单位
    _F.UnitAddItem(u, i);
end

function itemDemo4()

    local p = _F.Player(0);
    local u = _F.CreateUnit(p, char2id("A000"), 0, 0, 270);


    -- 创建物品附加给单位
    local i = _F.UnitAddItemById(u,char2id('i000'))
end

function itemDemo5()

    local p = _F.Player(0);
    local u = _F.CreateUnit(p, char2id("A000"), 0, 0, 270);


    -- 创建物品附加给单位的某个物品栏(0~5)
    local i = _F.UnitAddItemToSlotById(u,char2id("i000"),3)
end
