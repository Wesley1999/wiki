mshta vbscript:msgbox("���ȷ����ʼ����",6,"��ʾ")(window.close)
cd D:\code\wiki
git add .
git commit -m "Windows commit on %date% %time%"
git pull
git push
curl http://120.76.62.52:3000/wiki/deploy
exit