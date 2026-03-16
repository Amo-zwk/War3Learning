-- ydLua的api
--- 自启动调试
DEBUGGING = true
JassRuntime = require "jass.runtime"
JassRuntime.console = true
JassRuntime.sleep = false
JassRuntime.debug = 4279

JassRuntime.error_handle = function(msg)
    print("========lua-err========")
    print(tostring(msg))
    stack()
    print("=========================")
end
JassDebug = require "jass.debug"
JassConsole = require "jass.console"

print = function(...) JassConsole.write(...) end

--- 获取一个table的正确长度
--- 不建议使用，在不同的lua引擎可能会引起异步，但却没法保证平台提供的引擎是否可靠
---@protected
---@param table table
---@return number
function tlen(table)
    local len = 0
    for _, _ in pairs(table) do
        len = len + 1
    end
    return len
end

--- 打印栈
function stack(...)
    local out = { "[TRACE]" }
    local n = select("#", ...)
    for i = 1, n, 1 do
        local v = select(i, ...)
        out[#out + 1] = tostring(v)
    end
    out[#out + 1] = "\n"
    out[#out + 1] = debug.traceback("", 2)
    print(table.concat(out, " "))
end

--- 输出详尽内容
---@param value any 输出的table
---@param description string 调试信息格式
---@param nesting number | nil 输出时的嵌套层级，默认为 10
function dump(value, description, nesting)
    if type(nesting) ~= "number" then nesting = 10 end
    local lookup  = {}
    local result  = {}
    -- local traceback = string.explode("\n", debug.traceback("", 2))
    -- local str = "- dump from: " .. string.trim(traceback[3])
    local str     = "";
    local _format = function(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end
    local _dump
    _dump         = function(val, desc, indent, nest, keyLen)
        desc = desc or "<var>"
        local spc = ""
        if type(keyLen) == "number" then
            spc = string.rep(" ", keyLen - string.len(_format(desc)))
        end
        if type(val) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s", indent, _format(desc), spc, _format(val))
        elseif lookup[tostring(val)] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent, _format(desc), spc)
        else
            lookup[tostring(val)] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, _format(desc))
            else
                result[#result + 1] = string.format("%s%s = {", indent, _format(desc))
                local indent2 = indent .. "    "
                local keys = {}
                local kl = 0
                local vs = {}
                for k, v in pairs(val) do
                    if k ~= "___message" then
                        keys[#keys + 1] = k
                        local vk = _format(k)
                        local vkl = string.len(vk)
                        if vkl > kl then kl = vkl end
                        vs[k] = v
                    end
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for _, k in ipairs(keys) do
                    _dump(vs[k], k, indent2, nest + 1, kl)
                end
                result[#result + 1] = string.format("%s}", indent)
            end
        end
    end
    _dump(value, description, " ", 1)
    str = str .. "\n" .. table.concat(result, "\n")
    print(str)
end

function echo(player, msg)
    _F.DisplayTimedTextToPlayer(
        player,
        0, 0, 60,
        msg
    )
end

--- 错误调试
---@param val any
function err(val)
    print("=========sl-err=========")
    if (type(val) == "table") then
        dump(val)
    else
        print(val)
    end
    stack()
    print("=========================")
end

-- 字符串转id
function char2id(idChar)
    if (idChar == nil or type(idChar) ~= "string") then
        stack();
        return
    end
    return ('>I4'):unpack(idChar)
end

-- ydLua的api
-- JassCommon = require "jass.common"
-- JassGlobals = require "jass.globals"
-- JassSlk = require "jass.slk"
-- JassJapi = require "jass.japi"

print("Hello MyLua--------我的lua环境")
-- local heroTable = {name = "小熊",attack = 300}
-- dump(heroTable,"heroTable")


-- dump(JassCommon,"JassCommon")
-- dump(JassGlobals,"JassGlobals")
-- dump(JassSlk,"JassSlk")
-- dump(JassJapi,"JassJapi")


-- _F(unction)
require "ydlua.common"
-- _C(onst)
require "ydlua.const"
-- _J(Api)
require "ydlua.japi"
-- _A(LL)
_A = require "jass.globals"
-- _S(LK)
_S = require "jass.slk"

-- UI
_U = {
    id = 0,
    frameHandle = 0,
    mainUi = _J.DzGetGameUI(),

    -- 5步骤
    toc = function(path)
        _J.DzLoadToc(path)
        return _U
    end,
    -- 1 创建 纯代码创建ui 无法读取子Frame
    createTag = function(type, template, parent)
        local parent = parent or _U.mainUi;
        -- name
        _U.id = _U.id + 1
        local name = "ui" .. _U.id

        _U.frameHandle = _J.DzCreateFrameByTagName(
            type,
            name,
            parent,
            template,
            _U.id
        )
        return _U
    end,
    -- 2 定位
    position = function(x, y, point)
        if (_U.frameHandle > 0) then
            local point = point or _C.FRAME_ALIGN_CENTER
            _J.DzFrameSetAbsolutePoint(
                _U.frameHandle,
                point,
                x, y
            )
        end
        return _U

    end,
    -- 3 宽高
    size = function(w, h)
        if _U.frameHandle > 0 then
            _J.DzFrameSetSize(_U.frameHandle, w, h)
        end
        return _U

    end,
    -- 4 内容
    text = function(text)
        if _U.frameHandle > 0 then
            _J.DzFrameSetText(_U.frameHandle, text)
        end
        return _U

    end,
    img = function(path, flag)
        if _U.frameHandle > 0 then
            -- 0 拉伸  缩放适应
            -- 1 平铺  重复平铺
            local flag = flag or 1
            _J.DzFrameSetTexture(
                _U.frameHandle,
                path,
                flag
            )
        end
        return _U

    end,
    -- 5 事件
    on = function(evt, action, sync)
        if (_U.frameHandle > 0) then
            local sync = sync or false
            _J.DzFrameSetScriptByCode(
                _U.frameHandle,
                evt,
                action,
                sync
            )
        end
        return _U

    end,
    show = function()
        if _U.frameHandle > 0 then
            _J.DzFrameShow(_U.frameHandle, true)
        end

        return _U

    end,
    hide = function()
        if _U.frameHandle > 0 then
            _J.DzFrameShow(_U.frameHandle, false)
        end

        return _U
    end,
    -- 创建FDF中定义的frame 可以读取子Frame(重点)
    create = function(name,id,parent)

        local parent = parent or _U.mainUi;
        local id = id or _U.id + 1

        print(name,id)

        _U.frameHandle = _J.DzCreateFrame(
            name,
            parent,
            id
        )
        return _U
    end,

    -- 查找子Frame
    find = function (name,id)
        local frame = _J.DzFrameFindByName(name,id);
        if frame then
            _U.frameHandle = frame
        else
            dump(frame,"_U.find error")
        end

        return _U
    end,

}

-- dump(_F,"_F")


-- require "demo.player"
-- SetPlayerState()
-- getPlayerState()


require "demo.unit"

-- UnitDemo1();
-- UnitDemo2()

require "demo.item"
-- itemDemo1();
-- itemDemo2();
-- itemDemo3();
-- itemDemo4()
-- itemDemo5();


require "demo.ability"
-- abilitDemo1();
-- abilitDemo2();
-- abilitDemo3();


require "demo.trigger"
-- triggerDemo1()
-- triggerDemo2()
-- triggerDemo3()
-- triggerDemo4()
-- triggerDemo5()

local sky_rift_waltz = require "skill.sky_rift_waltz"
sky_rift_waltz.init()

local starfall_breach = require "skill.starfall_breach"
starfall_breach.init()

local moonshatter_tempest = require "skill.moonshatter_tempest"
moonshatter_tempest.init()

local eclipse_cataclysm_rite = require "skill.eclipse_cataclysm_rite"
eclipse_cataclysm_rite.init()

local chrono_singularity_throne = require "skill.chrono_singularity_throne"
chrono_singularity_throne.init()


require "demo.ui"
-- uiDemo1()
-- uiDemo2()
-- uiDemo3()
-- uiDemo4()
-- uiDemo5()


require "demo.fdf"
-- FDF_bg1()
-- FDF_txt1()
-- FDF_Btn()
-- FDF_Frame()
-- FDF_RG()

-- 
require 'demo.hotfix'

-- RegHot()

-- RegHot "demo.a"

RegHotStage "demo.b"
