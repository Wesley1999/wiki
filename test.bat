cd D:\code\wiki
git add .
git commit -m "Windows commit on %date% %time%"
git pull
git push
echo '发布请求已提交到服务器，发布成功后，本窗口将自动关闭'

mshta vbscript:msgbox("发布请求已提交到服务器",6,"提示")(window.close)

exit
