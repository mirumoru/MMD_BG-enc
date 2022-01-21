@echo off

rem ==========================================================================================
rem 更新：みるもるの家 2022年01月19日 『mp4からMMDの背景で読み込めるaviに変換するバッチ』v1.4.1
rem mp4を圧縮
rem ==========================================================================================

rem 動画のパス--そのままでOK
set INPUT_FOLDER=

rem -----変更厳禁(分かる人のみ変更可)----

rem 出力オプションの作成
rem チェックフラグ
set CHEK_FLAG=T
set CURRENT_DIRECTORY=%CD%
if ""%INPUT_FOLDER%"" == """" (
  rem カレントディレクトリを設定
  set INPUT_FOLDER=%CD%
) else (
rem ディレクトリの有無
IF NOT EXIST "%INPUT_FOLDER%" (
set CHEK_FLAG=F
echo 圧縮対象の動画が存在しません。（%INPUT_FOLDER%）
  )
)

rem 圧縮対象のフォルダから動画ファイルを抽出 
set OUTPUT_FOLDER=%INPUT_FOLDER%\out_mp4\
set OUTPUT_FILE=%INPUT_FOLDER%\*.mp4
if %CHEK_FLAG%==T (
if not exist "%OUTPUT_FOLDER%" (
echo %OUTPUT_FOLDER%
rem 出力先フォルダが存在しない場合は作成
mkdir %OUTPUT_FOLDER%
  )

setlocal enabledelayedexpansion

rem 出力先のファイル一覧を取得
for /f "usebackq" %%i in (`dir %OUTPUT_FILE% /B`) do (
for /f "usebackq tokens=1 delims=." %%x in (`echo %%i`) do (

rem 圧縮処理を実行
cd /d %~dp0tool
echo ...
rem outの後の拡張子を変更する事が出来ます。(例:mp4からmp3)
ffmpeg -i %INPUT_FOLDER%\%%i %OUTPUT_FOLDER%%%x_out_.mp4
echo %%iの動画圧縮処理が完了しました。
echo ----------
    )
  )

endlocal
  echo 圧縮処理が全て正常に完了しました。
) else (
  echo 処理を中断しました。
)

rem 初期化 
call :setting
pause >nul

:setting
rem 変数初期化処理
set INPUT_FOLDER=
set OUTPUT_FOLDER=
set OUTPUT_FILE=
set CHEK_FLAG=
set CURRENT_DIRECTORY=
exit /b 1