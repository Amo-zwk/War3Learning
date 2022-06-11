function abilitDemo1()
    -- 技能只有附加给单位或者物品才有意义
    -- 技能的数据都是固定的()
    -- 相同等级的技能属性都是相同的 升级后属性不同 
    -- 技能不需要创建 不需要保存状态

    local p = _F.Player(0);
    local u = _F.CreateUnit(p,char2id("hpea"),0,0,270)

    -- 通过函数附加技能
    _F.UnitAddAbility(u,char2id("ACac"))
end


function abilitDemo2()

    local p = _F.Player(0);
    local u = _F.CreateUnit(p,char2id("hpea"),0,0,270)
    -- 通过函数附加自定义技能
    _F.UnitAddAbility(u,char2id("C000"))
end


function abilitDemo3()
    local p = _F.Player(0);
    -- 通过物编附加技能
    local u = _F.CreateUnit(p,char2id("A001"),0,0,270)
end



