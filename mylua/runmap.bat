@echo off
@REM 设置临时环境
@set PATH=%Path%;D:\Code\war3Dev\h-lua-sdk\depend\w3x2lni
@set PATH=%Path%;D:\Code\war3Dev\h-lua-sdk\depend\YDWE\bin

@REM w2l.exe obj  目录 地图名
w2l.exe obj . 
@REM 加载这个地图
ydweconfig.exe -launchwar3 -loadfile ..\mylua.w3x