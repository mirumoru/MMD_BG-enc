@echo off

rem ==========================================================================================
rem 作成：みるもるの家　更新:2022年2月04日 『mp4からMMDの背景で読み込めるaviに変換するバッチ』v1.4.3+bate1.0
rem mp4からaviとwavに変換(MMD用)ファイル選択版
rem ==========================================================================================

rem ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

rem 動画ファイル選択ダイアログ
set "File=C:\Temp\*.mp4"
set "Filter=動画ファイル (*.mp4)|*.mp4|"
set "Title=動画ファイルの選択"

set dialog="about:<object id=HtmlDlgHelper classid=CLSID:3050f4e1-98b5-11cf-bb82-00aa00bdce0b></object>
set dialog=%dialog%<script language=vbscript>resizeTo 0,0:Sub window_onload():
set dialog=%dialog%Set reg=CreateObject("VBScript.RegExp"):reg.Pattern="\0.*":
set dialog=%dialog%Set Env=CreateObject("WScript.Shell").Environment("Process"):
set dialog=%dialog%ret=HtmlDlgHelper.object.openfiledlg(Env("File"),,Env("Filter"),Env("Title")):
set dialog=%dialog%CreateObject("Scripting.FileSystemObject").GetStandardStream(1).Write reg.Replace(ret,""):
set dialog=%dialog%Close:End Sub</script><hta:application caption=no showintaskbar=no />"

set file=
for /f "delims=" %%p in ('MSHTA.EXE %dialog%') do set "file=%%p"
echo selected  file is : "%file%"
set Filter=
set Title=
set dialog=


rem 動画のパス--バッチファイルの格納先パス
@echo off
set INPUT_FOLDER=

rem 動画サイズ--そのままでOK(動画と同じになります。
set PARAM=

rem ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
rem ====変更厳禁(分かる人のみ変更可)====

rem ユーザーサイズの変更
set /p PARAM="サイズは？（例:854*480,1280*720 デフォルトは動画と同じになります。）："
if not ""%PARAM%"" == """" (
  set SIZE=%PARAM%
  set PARAM=
)

rem サイズオプションの有無確認
if not ""%SIZE%"" == """" (
  echo %SIZE% | find "*" >NUL
  if NOT ERRORLEVEL 1 (
    set OUTPUT_OPTIONS=%OUTPUT_OPTIONS% -s %SIZE%
  ) ELSE (
    set CHEK_FLAG=F 
  )
)

rem ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
cd /d %~dp0
rem 出力オプションの作成
rem チェックフラグ
set CHEK_FLAG=T

set CURRENT_DIRECTORY=%cd%
if ""%INPUT_FOLDER%"" == """" (
  rem カレントディレクトリを設定
  set INPUT_FOLDER=%cd%
) else (
rem ディレクトリの有無
IF NOT EXIST "%INPUT_FOLDER%" (
set CHEK_FLAG=F
echo 変換対象の動画が存在しません。処理を中断しました。（%INPUT_FOLDER%）
  )
)


rem --------------------------------------------------------------------------------
rem 変換対象のフォルダから動画ファイルを抽出 
set OUTPUT_FOLDER=%INPUT_FOLDER%\Fi_out_MMD\
set OUTPUT_FILE=%file%
if %CHEK_FLAG%==T (
if not exist "%OUTPUT_FOLDER%" (
echo %OUTPUT_FOLDER%
rem 出力先フォルダが存在しない場合は作成
mkdir %OUTPUT_FOLDER%
  )

rem 遅延環境変数の展開
setlocal enabledelayedexpansion

rem 出力先のファイル一覧を取得
for /f "usebackq" %%i in (`dir %OUTPUT_FILE% /B`) do (
for /f "usebackq tokens=1 delims=." %%x in (`echo %%i`) do (

rem 動画変更処理を実行
cd /d %~dp0..\tool
echo 映像をデコードしています。
rem outの後の拡張子を変更する事が出来ます。(例:mp4からmp3)
ffmpeg -i %file% -r 30 -vcodec rawvideo %OUTPUT_OPTIONS%  -an %OUTPUT_FOLDER%%%x_MMD用Fi版.avi
echo %%iの動画処理が完了しました。
echo ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

call :setting2

rem 音声変更処理を実行
echo 音声をデコードしています。
ffmpeg -i %file% -sample_fmt s16 -ar 48000 %OUTPUT_FOLDER%%%x_MMD用Fi版.wav
echo %%iの音声処理が完了しました。
echo ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
rem --------------------------------------------------------------------------------
    )
  )

rem 遅延環境変数の終了
endlocal
  echo 変換が全て完了しました。
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
set SIZE=
set File=
set enc=
exit /b 1

:setting2
rem 変数初期化処理
set INPUT_FOLDER=
set OUTPUT_FOLDER=
set OUTPUT_FILE=
set CHEK_FLAG=
set CURRENT_DIRECTORY=
set SIZE=