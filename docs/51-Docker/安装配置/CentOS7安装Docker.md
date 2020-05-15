# CentOS7安装Docker

## 安装
~~~bash
#step1 安装依赖包
yum install -y yum-utils device-mapper-persistent-data lvm2 

#step2 添加yum源
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#step3 安装Docker社区版并启动
yum -y install docker-ce docker-ce-cli containerd 
systemctl start docker

#step4 配置Docker国内镜像加速
#由于国内网络问题，不修改后面拉取镜像的速度会太慢
vim /etc/docker/daemon.json 

{
    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}

#step5 重新启动服务
systemctl daemon-reload
systemctl restart docker 
~~~

## 卸载
参考[https://blog.csdn.net/liujingqiu/article/details/74783780](https://blog.csdn.net/liujingqiu/article/details/74783780)
如果`yum –y remove`不生效，试试`yum remove`

## Reference
[利用Nextcloud搭建私有同步云盘](https://zhuanlan.zhihu.com/p/62987726)
[Centos 7 如何卸载docker](https://blog.csdn.net/liujingqiu/article/details/74783780)
[docker和docker-compose安装教程](https://www.kowen.cn/2017/10/23/docker%E5%92%8Cdocker-compose%E5%AE%89%E8%A3%85/ "docker和docker-compose安装教程")


