# CentOS7卸载PHP5.4.16

```
yum remove php
```
这个命令是卸不干净的。
```
php -v
```
仍然能看到版本信息。

```
rpm -qa|grep phpx
```
提示如下
```
php-pdo-5.4.16-46.1.el7_7.x86_64
php-mysql-5.4.16-46.1.el7_7.x86_64
php-cli-5.4.16-46.1.el7_7.x86_64
php-fpm-5.4.16-46.1.el7_7.x86_64
php-common-5.4.16-46.1.el7_7.x86_64
```
因为存在依赖关系，要按顺序卸载：
```
rpm -e php-mysql-5.4.16-46.1.el7_7.x86_64
rpm -e php-pdo-5.4.16-46.1.el7_7.x86_64
rpm -e php-cli-5.4.16-46.1.el7_7.x86_64
rpm -e php-fpm-5.4.16-46.1.el7_7.x86_64
rpm -e php-common-5.4.16-46.1.el7_7.x86_64
```

完成！

## Reference
[https://blog.csdn.net/qq\_34432348/article/details/74626151](https://blog.csdn.net/qq_34432348/article/details/74626151)