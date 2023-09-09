-- 加载toc
_U.toc("UI\\path.toc");

function FDF_bg1()
    _U.create("BgDemo")
        .position(0.4, 0.3)
        .show()
end

function FDF_txt1()
    _U.create("txtDemo")
        .position(0.4, 0.3)
        .show()
end

function FDF_Btn()
    _U.create("BtnDemo")
        .position(0.2, 0.3)
        .show()


    _U.create("TextBtnDemo")
        .position(0.4, 0.3)
        .show()
end

function FDF_Frame()
    _U.create("FrameDemo")
        .position(0.2, 0.3)
        .show()
end

-- 从数组table随机取n个数据
function table.random(arr, n)
    if (type(arr) ~= "table") then
        return
    end
    n = n or 1
    if (n < 1) then
        return
    end
    if (n == 1) then
        return arr[math.random(1, #arr)]
    end
    local res = {}
    local l = #arr
    while (#res < n) do
        local rge = {}
        for i = 1, l do
            rge[i] = arr[i]
        end
        for i = 1, l do
            local j = math.random(i, #rge)
            table.insert(res, rge[j])
            if (#res >= n) then
                break
            end
            rge[i], rge[j] = rge[j], rge[i]
        end
    end
    return res
end


function FDF_RG()
    -- 准备技能数据
    local all = {
        {
            icon = "ReplaceableTextures\\CommandButtons\\BTNReturnGoods.blp",
            text = "向某个玩家收取固定数额的金子和木材"
        },
        {
            icon = "ReplaceableTextures\\PassiveButtons\\PASBTNGnollCommandAura.blp",
            text = "增加附近单位的攻击力。"
        },
        {
            icon = "ReplaceableTextures\\CommandButtons\\BTNAnimateDead.blp",
            text = "给周围单位提供荆棘光环的保护，如果近战型的敌人来攻击它们就会受到每次相当于自身<ACah,DataA1,%>%攻击力的伤害。"
        },
        {
            icon = "ReplaceableTextures\\CommandButtons\\BTNAntiMagicShell.blp",
            text = "使目标单位对所有魔法免疫。|n持续<ACam,Dur1>秒。"
        },
        {
            icon = "ReplaceableTextures\\PassiveButtons\\PASBTNTrueShot.blp",
            text = "提高周围友军单位<ACat,DataA1,%>%的远程攻击力。"
        },
        {
            icon = "ReplaceableTextures\\PassiveButtons\\PASBTNBrilliance.blp",
            text = "增加周围单位每秒<ACba,DataA1>点的魔法恢复速度"
        },
    }

    -- ui
    _U.create("RougeItem", 1)
        .position(0.2, 0.35)
        .show()

    _U.create("RougeItem", 2)
        .position(0.4, 0.35)
        .show()

    _U.create("RougeItem", 3)
        .position(0.6, 0.35)
        .show()


    -- 设置技能图标和文字
    function setData()
        local temp = table.random(all,3)
        -- 设置左边
        _U.find("RgIcon", 1).img(temp[1]["icon"], 0)
        _U.find("RgText", 1).text(temp[1]["text"])

        _U.find("RgIcon", 2).img(temp[2]["icon"], 0)
        _U.find("RgText", 2).text(temp[2]["text"])

        _U.find("RgIcon", 3).img(temp[3]["icon"], 0)
        _U.find("RgText", 3).text(temp[3]["text"])

    end
    setData()


    _U.create("RougeBtn")
        .position(0.75)
        .on(_C.MOUSE_ORDER_CLICK, function()
            echo(_F.GetLocalPlayer(), "点击")
            setData()
        end)
        .show()
end
