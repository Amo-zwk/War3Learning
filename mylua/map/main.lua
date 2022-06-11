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
---@param nesting number 输出时的嵌套层级，默认为 10
function dump(value, description, nesting)
    if type(nesting) ~= "number" then nesting = 10 end
    local lookup = {}
    local result = {}
    -- local traceback = string.explode("\n", debug.traceback("", 2))
    -- local str = "- dump from: " .. string.trim(traceback[3])
    local str  = "";
    local _format = function(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end
    local _dump
    _dump = function(val, desc, indent, nest, keyLen)
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
function char2id (idChar)
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
abilitDemo3();