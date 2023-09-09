-- dump(package.loaded,"loaded")
-- 指定lua文件的查找目录
package.path = package.path .. ";D:/Code/war3Dev/lua基础作图/hotdemo/?.lua"

function RegHot()
    local tri = _F.CreateTrigger();

    _J.DzTriggerRegisterKeyEventByCode(
        tri, 116,1,false,
        function ()
            dump("重新加载demo.a",'dd')
            package.loaded["demo.a"] = nil
            require("demo.a")
        end
    )
end