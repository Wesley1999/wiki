# Docker中安装vim等命令

在使用docker容器时，有时候里边没有安装vim，敲vim命令时提示说：`vim: command not found`，这个时候就需要安装vim，可是当你敲`apt-get install vim`命令时，提示：
```
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package vim
```
这时候需要敲：`apt-get update`，这个命令的作用是：同步 `/etc/apt/sources.list` 和 `/etc/apt/sources.list.d` 中列出的源的索引，这样才能获取到最新的软件包。
等更新完毕以后再敲命令：`apt-get install vim`命令即可。

## Reference
[https://blog.csdn.net/kiwi\_kid/article/details/51156241](https://blog.csdn.net/kiwi_kid/article/details/51156241)
