@echo off
cd /d %~dp0../tool
rem 初期化

set ffv=
set rem=
set nvv=
set ex=

rem メニュー
:rem
echo ffmpegバージョン確認(1)
echo NVEncバージョン確認(2)
echo 詳細(3)
echo 終了(4)

choice /c 1234

if %errorlevel% equ 1 goto ffv
if %errorlevel% equ 2 goto nvv
if %errorlevel% equ 3 goto de
if %errorlevel% equ 4 goto ex
echo エラーが発生しました。
pause >nul
exit


:ffv
cls
ffmpeg -version

goto rem

:nvv
cls
NVEncC64 -v
goto rem

:de
cls
echo 作成：みるもるの家
echo 最終更新：2022年1月19日
goto rem

:ex
exit