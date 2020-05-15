# 远程连接阿里云服务器MySQL数据库

为了远程连接阿里云服务器MySQL数据库，查找过许多资料，步骤大致都是这样的：

1. 进入MySQL数据库，然后输入下面两条命令：
```
grant all privileges on *.* to 'root'@'%' identified by 'password';
flush privileges;
```
第一条命令的作用是应许所有用户连接到所有数据库（**这是不安全的，请谨慎使用**），第二条命令的作用是刷新权限，使其立即生效。

2. 重启MySQL服务
在Linux下，可以执行下面的命令重启：
```
service mysql restart
```
在Windows下，可以以管理员身份执行下面两条命令：
```
net stop mysql
net start mysql
```

3. 开启3306端口
如果不在意安全性，也可以直接关闭防火墙。

4. 按照一般的教程， 完成上述步骤就可以使用下面的命令连接远程MySQL数据库了：
```
mysql -u 用户名 -p密码 -h 服务器IP地址 -P 服务器端MySQL端口号 -D 数据库名
```

**但是，阿里云的服务器，需要在控制台的防火墙中开放端口，才能正常使用。**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20181107205640110.png)