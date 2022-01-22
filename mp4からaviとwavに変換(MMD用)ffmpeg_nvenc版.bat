@echo off
rem ==========================================================================================
rem 作成：みるもるの家 更新:2022年1月22日 『mp4からMMDの背景で読み込めるaviに変換するバッチ』v1.4.2
rem mp4からaviとwavに変換(MMD用)ffmpeg_nvenc版
rem ==========================================================================================


rem 動画のパス--バッチファイルの格納先パス
@echo off
set INPUT_FOLDER=%~dp0

rem -----変更厳禁(分かる人のみ変更可)-----

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
echo 変換対象の動画が存在しません。処理を中断しました。（%INPUT_FOLDER%）
  )
)


rem --------------------------------------------------------------------------------
rem 変換対象のフォルダから動画ファイルを抽出 
set OUTPUT_FOLDER=%INPUT_FOLDER%\ffnv_out_MMD\
set OUTPUT_FILE=%INPUT_FOLDER%\*.mp4
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
cd /d %~dp0tool
echo 映像をデコードしています。
rem outの後の拡張子を変更する事が出来ます。(例:mp4からmp3)
ffmpeg -i %INPUT_FOLDER%\%%i -r 30 -b:v 1500K -vcodec h264_nvenc -an %OUTPUT_FOLDER%%%x_MMD用FFNV版.avi
echo %%iの動画処理が完了しました。
echo ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

call :setting2

rem 音声変更処理を実行
echo 音声をデコードしています。
ffmpeg -i %INPUT_FOLDER%\%%i -sample_fmt s16 -ar 48000 %OUTPUT_FOLDER%%%x_MMD用FFNV版.wav
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
exit /b 1

:setting2
rem 変数初期化処理
set INPUT_FOLDER=
set OUTPUT_FOLDER=
set CHEK_FLAG=
set CURRENT_DIRECTORY=
