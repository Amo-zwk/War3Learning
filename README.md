## lua基础作图

- [h-lua-sdk](https://gitee.com/zmwcodediy/h-lua-sdk)
- [lua基础作图](https://gitee.com/zmwcodediy/map-luamaker)

## Windows 安装与运行

本项目适合在 Windows + Warcraft III 1.27 + YDWE + w3x2lni 环境下运行。

### 1. 准备工具

先准备以下内容：

1. Warcraft III 1.27 客户端
2. `h-lua-sdk`
3. YDWE
4. w3x2lni

注意：`h-lua-sdk` 不在本仓库里，需要你单独下载。

推荐下载地址：

- `https://gitee.com/zmwcodediy/h-lua-sdk`

如果你直接使用本仓库配套的目录结构，`h-lua-sdk` 与 `map-luamaker` 放在同一级目录即可。

推荐目录结构：

```text
your-workspace/
  h-lua-sdk/
  map-luamaker/
```

如果你的项目目录是：

```text
D:\War3Learning\mylua
```

那么脚本默认会去查找：

```text
D:\h-lua-sdk
```

所以最省事的放法就是把 `h-lua-sdk` 放到：

```text
D:\h-lua-sdk
```

### 2. 下载仓库

如果你还没有把仓库下载到 Windows，本项目建议直接用 Git 克隆。

先安装 Git for Windows，然后在你要存放项目的目录打开命令行，执行：

```bash
git clone https://github.com/Amo-zwk/War3Learning.git
```

进入项目目录：

```bash
cd War3Learning
```

如果你后续已经下载过一次，只需要更新到最新版本：

```bash
git pull
```

### 3. 配置 Warcraft 路径

打开 `YDWEConfig.exe`，先配置好 Warcraft III 客户端路径。

如果这一步没做好，后面运行脚本时无法自动拉起游戏。

### 4. 检查 SDK 路径

运行脚本是：`mylua/runmap.bat`

这个脚本会优先读取环境变量 `H_LUA_SDK`。

- 如果你没有设置 `H_LUA_SDK`，它会默认查找：

```text
..\..\h-lua-sdk
```

- 如果你的 `h-lua-sdk` 不在默认位置，请先在命令行设置：

```bat
set H_LUA_SDK=D:\your-path\h-lua-sdk
```

然后再运行：

```bat
mylua\runmap.bat
```

例如你的 `h-lua-sdk` 如果放在：

```text
D:\tools\h-lua-sdk
```

那么可以这样运行：

```bat
set H_LUA_SDK=D:\tools\h-lua-sdk
mylua\runmap.bat
```

### 5. 运行地图

在项目根目录执行：

```bat
mylua\runmap.bat
```

脚本会自动完成：

1. 调用 `w2l.exe obj .` 处理物编数据
2. 调用 `YDWEConfig.exe -launchwar3 -loadfile ..\mylua.w3x` 启动游戏并加载地图

### 6. 测试当前示例技能

当前仓库已经接入一发示例技能 `天隙回响`。

关键文件：

- 技能代码：`mylua/map/skill/sky_rift_waltz.lua`
- 入口注册：`mylua/map/main.lua`
- 技能物编：`mylua/table/ability.ini`
- 单位物编：`mylua/table/unit.ini`

伤害值只需要改这里：

```lua
local DAMAGE = 300 -- You may change this damage value only.
```

位置：`mylua/map/skill/sky_rift_waltz.lua`

### 7. 常见问题

如果运行失败，优先检查这些问题：

1. `YDWEConfig.exe` 是否已经配置 Warcraft 路径
2. `h-lua-sdk` 是否放在正确位置，或 `H_LUA_SDK` 是否设置正确
3. `mylua.w3x` 是否存在于仓库中的正确位置
4. 是否真的在 Windows 环境下执行，而不是 Linux 或 WSL
