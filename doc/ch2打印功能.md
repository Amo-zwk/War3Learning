## 打印调试
1. 打印table
    1. dump函数
## ydLua的api
    1. [ydLua参考文档](https://github.com/actboy168/jass2lua/edit/master/lua-engine.md)
    2. [文档镜像](https://gitee.com/zmwcodediy/map-luamaker/blob/master/doc/api/lua-engine.md)
```lua
-- jass.runtime库可以在地图运行时获取lua引擎的信息或修改lua引擎的部分配置。
JassRuntime = require "jass.runtime"

JassDebug = require "jass.debug"
JassConsole = require "jass.console"


-- jass.common库包含common.j内注册的所有函数。 （不包括BJ）
JassCommon = require "jass.common"
-- jass.globals库可以让你访问到jass内的全局变量
JassGlobals = require "jass.globals"
-- jass.slk库可以在地图运行时读取地图内的slk/w3*文件。
-- unit
-- item
-- destructable
-- doodad
-- ability
-- buff
-- upgrade
-- misc
JassSlk = require "jass.slk"
-- jass.japi库当前已经注册的所有japi函数。（包含dz函数）
JassJapi = require "jass.japi"
```