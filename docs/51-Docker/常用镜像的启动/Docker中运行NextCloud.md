# Docker中运行NextCloud

~~~shell
docker run -d --name nextcloud -p 11080:80 -v /root/docker/nextcloud:/var/www/html nextcloud
~~~
然后访问主机的10180端口就可以了

以后再启动可以用：
```
docker start nextcloud
```