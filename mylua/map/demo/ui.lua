_F.FogMaskEnable(false)
_F.FogEnable(false)

function uiDemo1()
    -- 1 创建
    local textDemo1 = _J.DzCreateFrameByTagName(
        "TEXT",
        "textDemo",
        _J.DzGetGameUI(), -- frame根节点
        "txt1",
        0
    )
    -- 2 定位
    -- 设置矩形的中心点FRAME_ALIGN_CENTER
    -- 坐标(0.3,0.3)
    _J.DzFrameSetAbsolutePoint(
        textDemo1,
        _C.FRAME_ALIGN_CENTER,
        0.3, 0.3
    )
    --  3 宽高
    _J.DzFrameSetSize(
        textDemo1,
        0.1, 0.1
    )
    --  4 内容
    _J.DzFrameSetText(textDemo1, "测试demo")
    --  5 注册事件
    _J.DzFrameSetScriptByCode(
        textDemo1,
        _C.MOUSE_ORDER_CLICK,
        function()
            echo(_F.GetLocalPlayer(), "点击ui")
        end,
        false
    )
    --  显示矩形
    _J.DzFrameShow(textDemo1, true)
end

function uiDemo2()
    local p = _F.GetLocalPlayer()
    _U.createTag("TEXT", "txt2")
        .position(0.2, 0.2)
        .size(0.1, 0.1)
        .text("测试demo2")
        .on(_C.MOUSE_ORDER_CLICK,function ()
            echo(p,"点击ui----|n")
        end)
        .on(_C.MOUSE_ORDER_ENTER,function ()
            echo(p,"鼠标进入----|n")
        end)
        .on(_C.MOUSE_ORDER_LEAVE,function ()
            echo(p,"鼠标离开----|n")
        end)
        .show()
end

function uiDemo3()
    local p = _F.GetLocalPlayer()
    _U.createTag("BACKDROP", "img")
        .position(0.2, 0.2)
        .size(0.1, 0.1)
        -- .img("ReplaceableTextures\\TeamColor\\TeamColor04.blp")
        .img("ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness.blp",0)
        .on(_C.MOUSE_ORDER_CLICK,function ()
            echo(p,"点击ui----|n")
        end)
        .on(_C.MOUSE_ORDER_ENTER,function ()
            echo(p,"鼠标进入----|n")
        end)
        .on(_C.MOUSE_ORDER_LEAVE,function ()
            echo(p,"鼠标离开----|n")
        end)
        .show()
end


function uiDemo4()
    _U.toc("UI\\path.toc")

    -- fdf的ui创建
    _U.createTag("BACKDROP","Demo_NoneBack")
    .position(0.1,0.5)
    .show()

    _U.createTag("BACKDROP","Demo_SizeBack")
    .position(0.2,0.5)
    .show()
end

function uiDemo5()
    _U.toc("UI\\path.toc")

    _U.createTag("BACKDROP", "Demo_NoneBack")
        .position(0.1, 0.5)
        .show()

    _U.createTag("BACKDROP", "Demo_SizeBack")
        .position(0.2, 0.5)
        .show()

    _U.createTag("BACKDROP", "Demo_BorderBack")
        .position(0.3, 0.5)
        .show()

    _U.createTag("BUTTON", "Demo_Button")
        .position(0.1, 0.4)
        .show()

    _U.createTag("TEXTBUTTON", "Demo_TextButton")
        .position(0.2, 0.4)
        .show()

    _U.createTag("EDITBOX", "Demo_EditBox")
        .position(0.1, 0.3)
        .show()

    _U.createTag("SPRITE", "Demo_Sprite")
        .position(0.35, 0.3)
        .show()

    _U.createTag("SLIDER", "Demo_Slider")
        .position(0.65, 0.3)
        .show()

    _U.createTag("BACKDROP", "Demo_TipsBck")
        .size(0.2, 0.2)
        .position(0.3, 0.2, _C.FRAME_ALIGN_TOP)
        .show()
end