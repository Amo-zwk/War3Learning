@echo off
setlocal

set SCRIPT_DIR=%~dp0
set DEFAULT_SDK=%SCRIPT_DIR%..\h-lua-sdk

if "%H_LUA_SDK%"=="" (
    set H_LUA_SDK=%DEFAULT_SDK%
)

if not exist "%H_LUA_SDK%\depend\w3x2lni\w2l.exe" (
    echo [ERROR] Cannot find w2l.exe under %H_LUA_SDK%\depend\w3x2lni
    echo [HINT] Set H_LUA_SDK to your h-lua-sdk root path before running this script.
    exit /b 1
)

if not exist "%H_LUA_SDK%\depend\YDWE\bin\YDWEConfig.exe" (
    echo [ERROR] Cannot find YDWEConfig.exe under %H_LUA_SDK%\depend\YDWE\bin
    echo [HINT] Set H_LUA_SDK to your h-lua-sdk root path before running this script.
    exit /b 1
)

set PATH=%PATH%;%H_LUA_SDK%\depend\w3x2lni
set PATH=%PATH%;%H_LUA_SDK%\depend\YDWE\bin

pushd "%SCRIPT_DIR%"

@REM Pack object data and load map
w2l.exe obj .
if errorlevel 1 (
    popd
    exit /b 1
)

YDWEConfig.exe -launchwar3 -loadfile ..\mylua.w3x
set EXIT_CODE=%ERRORLEVEL%

popd
exit /b %EXIT_CODE%
