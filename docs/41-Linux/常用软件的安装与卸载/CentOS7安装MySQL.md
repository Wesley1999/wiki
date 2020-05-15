# CentOS7安装MySQL

## 删除MySQL相关文件

```shell
find / -name mysql|xargs rm -rf
```

## 下载

可以在<https://downloads.mysql.com/archives/community>下载文件，我下载的是mysql-5.5.62-linux-glibc2.12-x86_64.tar.gz

也可以用
```shell
wget https://oss-file.wangshaogang.com/Develop/Linux/mysql-5.5.62-linux-glibc2.12-x86_64.tar.gz
```

## 解压

```shell
tar -zxvf mysql-5.5.62-linux-glibc2.12-x86_64.tar.gz
```

解压完成后可以移动文件夹：

```shell
mv mysql-5.5.62-linux-glibc2.12-x86_64 /usr/local/mysql
```

## 添加用户组和用户

先检查是否有mysql用户组和mysql用户

```shell
groups mysql
```

若有，则跳过这一步；若无，则执行：

```shell
groupadd mysql
useradd -r -g mysql mysql
```

## 进入mysql目录更改权限

```shell
cd /usr/local/mysql
chown -R mysql:mysql ./
```

## 执行安装脚本

已安装一个依赖，如果已经安装，可以跳过：

```shell
yum install -y libaio
```

执行安装脚本：

```shell
./scripts/mysql_install_db --user=mysql
```

安装完之后修改当前目录拥有者为root用户，修改data目录拥有者为mysql

```shell
chown -R root:root ./
chown -R mysql:mysql data
```

## 启动mysql

先处理一个权限问题：

```shell
mkdir /var/log/mariadb 
touch /var/log/mariadb/mariadb.log 
chown -R mysql:mysql  /var/log/mariadb/
```

启动：

```shell
./support-files/mysql.server start
```

如果失败，可能需要杀进程：

```shell
ps aux|grep mysql|awk '{print $2}'|xargs kill -9
```


## 更改mysql密码

```shell
./bin/mysqladmin -u root -h localhost.localdomain password '123456'
```

密码更改后即可登录MySQL：

```shell
./bin/mysql -h127.0.0.1 -uroot -p123456
```

登录之后将其他用户的密码也可改为root：

```sql
update mysql.user set password=password('123456') where user='root';
flush privileges;
```

## 增加远程登录权限

```sql
grant all privileges on *.* to root@'%' identified by '123456';
flush privileges;
```

执行之后即可远程登录

## 将MySQL加入Service系统服务

```shell
cp support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on
service mysqld restart
```

## 配置到环境变量
```shell
export PATH=$PATH:/usr/local/mysql/bin
```

<!--
## 创建软链接
```shell
ln /usr/local/mysql/bin/mysql /usr/bin/mysql
```
-->


## 启动、停止、重启的命令

```shell
service mysqld start
service mysqld stop
service mysqld restart
```


## Reference

[Linux下安装MySQL](https://www.jianshu.com/p/f4a98a905011)
[Linux安装MySQL时候出现log-error set to '/var/log/mariadb/mariadb.log', however file don't exists.](https://blog.csdn.net/BertonYip/article/details/80829524)
[libaio.so.1: cannot open shared object file解决方法](https://blog.csdn.net/lzwglory/article/details/54808074)

