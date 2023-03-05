@echo off
cd /d %~dp0../tool
rem 初期化

set ffv=
set yt=
set rem=
set nvv=
set qsv=
set ex=


rem メニュー
:rem
echo ffmpegバージョン確認(1)
echo NVEncバージョン確認(2)
echo QSVEncバージョン確認(3)
echo yt-dlpバージョン確認(4)
echo yt-dlpバージョンアップデート(5)
echo 詳細(6)
echo 終了(7)

choice /c 1234567

if %errorlevel% equ 1 goto ffv
if %errorlevel% equ 2 goto nvv
if %errorlevel% equ 3 goto qsv
if %errorlevel% equ 4 goto yt
if %errorlevel% equ 5 goto yt_u
if %errorlevel% equ 6 goto de
if %errorlevel% equ 7 goto ex

echo エラーが発生しました。
pause >nul
exit


:ffv
cls
ffmpeg -version

goto rem

:nvv
cls
cd NVEncC
NVEncC64 -v
cd..
goto rem

:qsv
cls
cd QSVEncC
QSVEncC64 -v
cd..
goto rem

:yt
cls
yt-dlp --version
goto rem

:yt_u
cls
yt-dlp -U
goto rem

:de
cls
echo 作成：みるもるの家
echo 最終更新：2023年3月5日
goto rem

:ex
exit