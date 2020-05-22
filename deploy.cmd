cd D:\code\wiki
git add .
git commit -m "Windows commit on %date% %time%"
git pull
git push
echo '发布请求已提交到服务器，发布成功后，本窗口将自动关闭'
curl http://120.76.62.52:3000/wiki/deploy
exit