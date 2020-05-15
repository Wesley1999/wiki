# Docker中安装宝塔面板

## 下载CentOS镜像
```
docker pull centos
```

## 创建Docker容器
```
docker run -i -t -d --name baota -p 10020:20 -p 10021:21 -p 10043:443 -p 10080:80 -p 10088:8888 --privileged=true -v /root/docker/baota:/www centos
```
8888使宝塔面板的默认端口

## 进入容器
```
docker exec -it baota /bin/bash
```
## 安装依赖
宝塔的安装脚本是依赖python2的，而Docker的CentOS镜像缺少python2
```
yum install -y python2
cp  /usr/bin/python2 /usr/bin/python
yum install -y python2-devel
```
## 安装宝塔
```
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install.sh && sh install.sh
```
## 登录
安装完成后，就可以用浏览器访问了，主机的端口号是10088，映射到docker的8888端口
查询默认账号密码：
```
bt default
```
