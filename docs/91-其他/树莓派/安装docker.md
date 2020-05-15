# 安装docker

## 准备工作
```
#安装SSL相关，让apt通过HTTPS下载：
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common

## 添加docker的GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#检查key是否相符（9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88）
sudo apt-key fingerprint 0EBFCD88

#添加docker的apt下载源
sudo echo "deb-src [arch=amd64] https://download.docker.com/linux/debian wheezy stable" >> /etc/apt/sources.list

#更新源
sudo apt-get update
```

## 安装docker
```
sudo apt-get install docker-ce
```

但我这里出现了错误：
```
E: Package 'docker-ce' has no installation candidate
```

原因可能是没找到合适的更新源，解决方式：
```
sudo echo "deb https://download.docker.com/linux/ubuntu zesty edge" > /etc/apt/sources.list.d/docker.list
sudo apt update && sudo apt install docker-ce
```

## 测试


## Reference
<https://segmentfault.com/a/1190000018028887>
<https://www.cnblogs.com/zhaijiahui/p/6932820.html>
