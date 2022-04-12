## lua基础作图环境
- 作图环境lua的搭建

## 软件下载
1. 魔兽争霸客户端
    1. 登录账户
    2. 下载1.27版本客户端
2. 下载[h-lua-sdk](https://gitee.com/zmwcodediy/h-lua-sdk)
    1. ydwe     地图编辑器
    2. w3x2lni  地图解包打包软件
3. ydweconfig.exe 
    1. 配置客户端路径

## 创建一个新地图
0. 使用ydwe创建新地图
1. 添加一个触发器
    1. 事件 地图初始化
    2. 动作 输入作弊码(exec-lua:main)
2. 使用w3x2lni解包地图
    1. 将单个地图文件解包成目录结构
    2. 拖动地图到`w3x2lni.exe`
    3. 转换为`Lni`格式
3. 添加`main.lua`
4. 运行`runmap.bat`
    1. 注意地图名称