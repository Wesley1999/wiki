# CentOS7安装PHP7.2

## 安装PHP
安装 EPEL 软件包：

~~~
yum install -y epel-release
~~~

安装 remi 源：

~~~
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
~~~

安装 yum 扩展包：

~~~
yum install -y yum-utils
~~~

启用 remi 仓库：

~~~
yum-config-manager --enable remi-php72
yum update
~~~

安装 PHP7.2

~~~
yum install -y php72
~~~

安装`php-fpm`和一些其他模块

~~~
yum install -y php72-php-fpm php72-php-gd php72-php-json php72-php-mbstring php72-php-mysqlnd php72-php-xml php72-php-xmlrpc php72-php-opcache
~~~

输入`php72 -v`查看安装结果

复制软链接
```
cp /usr/bin/php72 /usr/bin/php
```


## php-fpm 服务

设置开机自启

~~~
systemctl enable php72-php-fpm.service
~~~

常用`php-fpm`命令

~~~
## 开启服务
systemctl start php72-php-fpm.service
## 停止服务
systemctl stop php72-php-fpm.service
## 查看状态
systemctl status php72-php-fpm.service
~~~

编辑`/etc/opt/remi/php72/php-fpm.d/www.conf`,修改执行`php-fpm`的权限：

~~~
vim /etc/opt/remi/php72/php-fpm.d/www.conf
~~~

设置用户和用户组为 root：

~~~
user = root
group = root
~~~

保存并关闭文件，重启`php-fpm`服务：

~~~
systemctl restart php72-php-fpm.service
~~~

### 路径整理

~~~
## php 安装路径
/etc/opt/remi/php72

## nginx 配置文件
/etc/nginx/nginx.conf

## nginx 默认项目路径
/usr/share/nginx/html
~~~

## Reference
[https://segmentfault.com/a/1190000015781413](https://segmentfault.com/a/1190000015781413)
