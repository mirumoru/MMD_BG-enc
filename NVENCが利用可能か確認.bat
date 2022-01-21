@echo off
tool\NVEncC64.exe --check-hw

if errorlevel 0 (
    echo 利用可能です。
) else (
    echo 利用できません。
)
pause