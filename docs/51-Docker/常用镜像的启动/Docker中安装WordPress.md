# Docker中安装WordPress

## 安装WordPress
```
docker pull wordpress:latest
```

## 安装MySQL
如果在Docker中安装，请参考上一篇
如果使用外部mysql，如果使用外部mysql，可跳过这一步

## 配置WordPress
```
docker run --name some-wordpress --link some-mysql:mysql -p 10180:80 -v /root/docker/wordpress:/var/www/html -d wordpress
```
`name`参数指定要启动的WordPress实例名称，`link`参数指定要使用的Docker MySQL实例名称，`p`参数将Docker内部的10080端口映射到本地的8080端口上。

如果使用docker外部数据库：
```
docker run --name wordpress -p 12080:80 -v /root/docker/wordpress:/var/www/html -e WORDPRESS_DB_NAME=wordpress -e WORDPRESS_DB_HOST=888.888.888.888:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=123456 -d wordpress
```
`WORDPRESS_DB_HOST`参数是MySQL的数据库端口号，`WORDPRESS_DB_NAME`是数据库实例名称，`WORDPRESS_DB_USER`是数据库用户名，`WORDPRESS_DB_PASSWORD`是数据库密码。这里的`WORDPRESS_DB_HOST`参数不能填写`localhost`或`127.0.0.1`，因为这样会重定向到WordPress镜像内部的`localhost`，而这个镜像中实际上没有安装MySQL。所以这里需要填写本机IP地址，才能正确访问到Docker外部的本机的数据库。

然后，就可以通过指定的端口访问了。

## Reference
[用Docker搭建WordPress博客](https://www.jianshu.com/p/47310fe571b5)
关于创建容器时的更多参数，详见：[https://www.cnblogs.com/52fhy/p/5962287.html](https://www.cnblogs.com/52fhy/p/5962287.html)



