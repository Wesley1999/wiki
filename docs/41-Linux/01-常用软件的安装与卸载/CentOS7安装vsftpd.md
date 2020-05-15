# CentOS7安装vsftpd

## 安装
```shell
yum install -y ftp
yum install -y vsftpd
```

## 配置
### 避免连接过程中IP变化导致无法使用的问题
```shell
vim /etc/vsftpd/vsftpd.conf
```
添加下面的内容
```shell
pasv_promiscuous=YES
```
### 将root账户从禁止登录的用户列表中排除
编辑下面两个文件，将root注释掉
```shell
vim /etc/vsftpd/user_list
```
```shell
vim /etc/vsftpd/ftpusers
```


### 修改ftp访问的目录
```shell
vim /etc/vsftpd/vsftpd.conf
```
直接在配置文件中添加如下：
```shell
## 匿名用户
anon_root=/root/ftp
anon_upload_enable=NO
## 本地用户
local_root=/
```

修改任何配置后，都要重启服务。
```
service vsftpd restart
```

## 启动相关的命令
```shell
## 启动
service vsftpd start
## 重启
service vsftpd restart
## 检测是否启动
netstat -an | grep 21
## tcp        0      0 0.0.0.0:21        0.0.0.0:\*       LISTEN 
## 如果看到以上信息，证明ftp服务已经开启
```

## 连接
### linux下连接ftp
```shell
ftp [ip或域名]
```
### 在Windows中连接
略。

### 使用浏览器访问
在浏览器中输入`ftp:/[ip or 域名]/`或`ftp://[用户名]:[密码]@[ip or 域名]`即可访问，例如：
```shell
ftp://wangshaogang.com/
```
![](https://oss-pic.wangshaogang.com/1586691188540-7b2adaca-6e89-4f2d-b08a-38d05426e048.png)

## Reference
[Linux开启ftp服务及基本使用方法](https://www.jianshu.com/p/2f4d6f71b4c8)

[VSFTPD设置-允许root账户登录ftp](https://blog.csdn.net/zhanyongjia_cnu/article/details/50549127)

[更改vsftpd默认的/var/ftp/pub目录](https://blog.51cto.com/meiling/1927218)

[修改vsftpd的默认根目录]([https://blog.csdn.net/junglezax/article/details/11688789](https://blog.csdn.net/junglezax/article/details/11688789))