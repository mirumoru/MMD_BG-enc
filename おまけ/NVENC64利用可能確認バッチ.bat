@echo off
cd /d %~dp0../tool
NVEncC64 --check-hw

if errorlevel 0 (
    echo 利用可能です。
) else (
    echo 利用できません。
)
pause