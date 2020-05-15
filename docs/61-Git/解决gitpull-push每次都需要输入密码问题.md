# 解决gitpull-push每次都需要输入密码问题

如果我们git clone的下载代码的时候是连接的`https://`而不是`git@git (ssh)`的形式，当我们操作`git pull/push`到远程的时候，总是提示我们输入账号和密码才能操作成功，频繁的输入账号和密码会很麻烦。

解决办法：

进入你的项目目录，输入：

```shell
git config --global credential.helper store
```


然后你会在你本地生成一个文本，上边记录你的账号和密码。当然这些你可以不用关心。

然后你使用上述的命令配置好之后，再操作一次`git pull`，然后它会提示你输入账号密码，这一次之后就不需要再次输入密码了。

---

原文链接：https://blog.csdn.net/nongweiyilady/java/article/details/77772602