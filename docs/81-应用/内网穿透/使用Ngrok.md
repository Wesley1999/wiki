# 使用Ngrok

1. 注册并获取token
[https://dashboard.ngrok.com/auth/your-authtoken](https://dashboard.ngrok.com/auth/your-authtoken)
2. 下载客户端
[https://ngrok.com/download](https://ngrok.com/download)
3. 在Linux中使用
```
unzip /path/to/ngrok.zip
./ngrok authtoken xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
./ngrok http 8083
```
然后就可以通过`http://e28d132b.ngrok.io`或`https://e28d132b.ngrok.io`访问到客户端的`http://localhost:8081`
![](https://oss-pic.wangshaogang.com/1587737328318-30dee1a5-0a42-446a-bbc0-d9429b34e005.png)
4. 在Windows中使用
```
解压ngrok.zip
到ngrok目录下cmd
ngrok authtoken xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
ngrok http 8083
```
然后就能实现与Linux中相同的效果

---

免费版的ngrok使用起来并不方便，每次为一台设备的一个端口实现内网穿透，好像还不能在后台运行。