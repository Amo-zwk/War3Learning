-- dump(package.loaded,"loaded")
-- 指定lua文件的查找目录
package.path = package.path .. ";D:/Code/war3Dev/lua基础作图/hotdemo/?.lua"

function RegHot(file)
    function ReloadFile()
        dump("重新加载", file)
        package.loaded[file] = nil
        require(file)
    end

    local isReg = false

    if not isReg then
        isReg = true
        -- 实现首次加载
        require(file)
        -- 按键斧
        local tri = _F.CreateTrigger();

        _J.DzTriggerRegisterKeyEventByCode(
            tri, 116, 1, false,
            function()
                ReloadFile()
            end
        )
    end
end

function RegHotStage(file)
    function ReloadFile()
        local stage = package.loaded[file]
        -- 演员下台
        stage.onStop()

        package.loaded[file] = nil

        require(file)
        local stage = package.loaded[file]
        -- 演员上台
        stage.onStart();
    end

    local isReg = false

    if not isReg then
        isReg = true
        -- 实现首次加载
        require(file)
        local stage = package.loaded[file]
        -- dump(stage,"舞台内容")
        -- 演员上台
        stage.onStart();

        -- 按键斧
        local tri = _F.CreateTrigger();

        _J.DzTriggerRegisterKeyEventByCode(
            tri, 116, 1, false,
            function()
                ReloadFile()
            end
        )
    end
end
