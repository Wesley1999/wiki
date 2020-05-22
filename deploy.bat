mshta vbscript:msgbox("点击确定后开始发布",6,"提示")(window.close)
cd D:\code\wiki
git add .
git commit -m "Windows commit on %date% %time%"
git pull
git push
curl http://120.76.62.52:3000/wiki/deploy
exit