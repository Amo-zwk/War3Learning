-- dump(package.loaded,"loaded")

local function append_package_path(path)
    if not string.find(package.path, path, 1, true) then
        package.path = package.path .. ";" .. path
    end
end

local function normalize_path(path)
    return (path:gsub("\\", "/"))
end

local function setup_hotdemo_path()
    local source = debug.getinfo(1, "S").source
    if not source or source:sub(1, 1) ~= "@" then
        return
    end

    local script_path = normalize_path(source:sub(2))
    local script_dir = script_path:match("^(.*)/[^/]+$")
    if not script_dir then
        return
    end

    local repo_root = script_dir:match("^(.*)/mylua/map/demo$")
    if repo_root then
        append_package_path(repo_root .. "/hotdemo/?.lua")
        append_package_path(repo_root .. "/hotdemo/?/init.lua")
    end
end

setup_hotdemo_path()

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
