# Docker基本命令

启动、关闭Docker服务
```
service docker start
service docker stop
```

列出所有的容器 ID
```
## 运行中的
docker ps
## 所有
docker ps -a
```

启动容器
```
docker start [容器名称或id]
```

进入、退出容器
```
## 进入
docker exec -it [容器名称或id] /bin/bash ## 这里也可以直接用 bash
## 退出
exit 或 Ctrl + D
```

停止所有的容器
```
docker stop $(docker ps -aq)
```
删除所有的容器
```
docker rm $(docker ps -aq)
```
删除所有的镜像
```
docker rmi $(docker images -q)
```

## Reference
[https://blog.csdn.net/dongdong9223/article/details/52998375](https://blog.csdn.net/dongdong9223/article/details/52998375)

[https://www.cnblogs.com/phpper/p/10844757.html](https://www.cnblogs.com/phpper/p/10844757.html)

