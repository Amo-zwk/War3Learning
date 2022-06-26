## FDF
- UI布局描述

- [教程2](https://www.hiveworkshop.com/pastebin/e23909d8468ff4942ccea268fbbcafd1.20598)
- 参考重置版1.3的FDF教程

- Backdrop
- Text
- Button
- Frame

- 安装vscode的FDF插件(War3Fdf)
- 安装vscode的blp预览插件(diy-wc3-vs)
- 游戏自带素材(MPQ解压)获得游戏自带素材
 
## FDF的内容
- Frame开头的UI布局描述
- Frame FrameType Name  Frame标签 标签名称Name大写开头
- {} 属性设置
```fdf
Frame FrameType Name {
    FrameAction,
    FrameAction
}
```
```html
<div id ="name" width="" height="">
```

- toc文件导入fdf文件
```
// path.toc

UI\template.fdf
UI\demo.fdf
```

```
// .imp.ini
import = {
    "UI\\path.toc",
    "UI\\template.fdf",
    "UI\\demo.fdf",
}
```
```lua
_U.toc("UI\\path.toc");
```

## UI坐标系
- 原点左下角(0,0)
- 垂直|     [0,0.6]
- 水平_____ [0,0.8]
## BackDrop 图片显示
- 显示图片的标签(背景图片 边框图片)
- 背景图片
    - BackdropBackground 背景图片文件
    - BackdropTileBackground, 开启贴图魔兽
    - BackdropBackgroundSize  每个贴图的大小
- 边框图片
    - BackdropCornerFlags 设置显示的边框 
        - TOP LEFT RIGHT BOTTOM
        - UPLEFT UPRIGHT BOTTOMLEFT BOTTOMRIGHT
    - BackdropCornerSize 边框的宽度
    - BackdropTop|Right|Bottom|Left|CornerFile 分别设置边框文件
    - BackdropEdgeFile 同一边框文件 与上面的不能同时存在
## Text 文本显示
- 使用方法见Button
- FrameFont          文本字体与文本大小
- FontFlags   文本样式
- FontColor   文本颜色
- FontJustificationH 水平对齐方式
- FontJustificationV 垂直对齐

## Button
- BUTTON,TEXTBUTTON           
- GLUEBUTTON,GLUETEXTBUTTON
    - Text的可以显示一个文字
    - GLUE点击的时候会有个声音
    - 一般使用TEXTBUTTON就可以 

- ControlBackdrop       按钮默认背景图片
- ControlPushedBackdrop 按钮点击背景图片
- ControlMouseOverHighlight 鼠标悬浮高亮
    - ControlStyle "HIGHLIGHTONMOUSEOVER"
- ButtonText   按钮文本


## Frame
- 没有具体意义的容器

## 做一个简单Demo
- Frame,Button,BackDrop,Text