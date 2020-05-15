# CentOS7安装Nginx

## 下载解压
```shell
wget https://oss-file.wangshaogang.com/Develop/Linux/nginx-1.16.1.tar.gz
tar -zxvf nginx-1.16.1.tar.gz
cd nginx-1.16.1
```

## 安装依赖
```shell
yum install -y gcc-c++
yum install -y pcre pcre-devel
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel

yum -y install pcre-devel openssl openssl-devel
```

## 配置
```shell
./configure --prefix=/root/nginx --with-http_ssl_module --with-http_sub_module --user=root
```
（顺便配置了SSL和sub filter模块，指定了user）
## 编译安装
```shell
make install
```


如果只需要编译，可以
```shell
make
```
编译好的文件在`nginx-1.16.1/objs`中

## 添加软链接
```
ln /root/nginx/sbin/nginx /usr/bin/nginx
```

## 启动、停止nginx
```shell
启动		./nginx
停止		./nginx -s stop
重启		./nginx -s reload
```

## 解决403 Forbidden
这是因为没有访问权限。
```
chmod 777 [dir]
```