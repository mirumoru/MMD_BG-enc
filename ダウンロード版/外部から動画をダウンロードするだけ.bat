@echo off
rem ==========================================================================================
rem 作成：みるもるの家 更新:2022年6月7日 v1.0.0
rem 『外部から動画をダウンロードするだけ』

rem ==========================================================================================

rem ======外部動画のダウンロード==============================================================
rem -----変更厳禁(分かる人のみ変更可)-----

rem 変数初期化
set OUTPUT_FOLDERDL=

cd /d %~dp0..\tool

rem 出力先フォルダ作成
set OUTPUT_FOLDERDL=%INPUT_FOLDER%\yt-dlp_dl\
if not exist "%OUTPUT_FOLDERDL%" (
echo %OUTPUT_FOLDER%
rem 出力先フォルダが存在しない場合は作成
mkdir %OUTPUT_FOLDERDL%
)
 

rem オプション設定
set OPTIONS= -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "%~dp0%OUTPUT_FOLDERDL%\dl_videos.%%(ext)s"

echo ========================================================================
echo 違法アップロードされている動画などはダウンロードしないでください！
echo 他人の動画を勝手にダウンロードすることは著作権法違反になります。
echo 権利者から許可を得ている、または自由に使えることを明言している動画でのダウンロードをお願いします。
echo ========================================================================
echo (例)YouTube:https://youtu.be/OZD1nLKz6o4 ニコニコ動画：https://www.nicovideo.jp/watch/sm37725706
rem URL入力
set /p URL=動画サイトのURL:

rem コマンド実行
yt-dlp %OPTIONS% "%URL%"

echo ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

pause




