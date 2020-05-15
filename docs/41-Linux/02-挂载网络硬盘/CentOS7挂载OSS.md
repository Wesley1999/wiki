# CentOS7挂载OSS

## OSS对象存储创建Bucket
创建Bucket一定要选择和服务器同样的地区：
![](https://oss-pic.wangshaogang.com/1586692795136-3cde49e5-4bc4-4dc5-a070-ff5c8261f934.png)
![](https://oss-pic.wangshaogang.com/1586692795136-2c468b52-32a9-4ec7-b657-a04366b48f55.png)

## 下载安装包
```
wget http://gosspublic.alicdn.com/ossfs/ossfs_1.80.6_centos7.0_x86_64.rpm
```
## 安装ossfs
```
sudo yum localinstall ossfs_1.80.6_centos7.0_x86_64.rpm
```
## 配置账号访问信息
将Bucket名称以及具有此Bucket访问权限的AccessKeyId/AccessKeySecret信息存放在/etc/passwd-ossfs文件中。注意这个文件的权限必须正确设置，建议设为640。
```
## 如需挂载多个存储空间，这一步需多次执行
echo my-bucket:my-access-key-id:my-access-key-secret >> /etc/passwd-ossfs
chmod 640 /etc/passwd-ossfs
```
`my-bucket:my-access-key-id:my-access-key-secret` 对应为 `bucket名称 : AccessKey ID : Access Key Secret`
## 将Bucket挂载到指定目录
`mkdir`创建好要挂载的目录，然后：
```
## 如需挂载多个存储空间，这一步需多次执行
ossfs my-bucket my-mount-point -ourl=my-oss-endpoint
```
`my-oss-endpoint`地址可以在OSS控制台找到 一定要选择内网地址，否则流量是要收费的。
![](https://oss-pic.wangshaogang.com/1586692795136-851a5a69-0db4-4631-ba84-8a4e013a5994.png)
## 查看
```shell
df -h
```
## 卸载
```
umount my-mount-point
```
## 开机启动
执行脚本挂载脚本即可，例如：
```
ossfs centos-wsg /oss -ourl=oss-cn-shenzhen-internal.aliyuncs.com
```
## Reference
[阿里云轻量应用服务器挂载OSS走内网流量40G存储9元/年](https://www.lxtx.tech/index.php/archives/18/)
[快速安装\_ossfs\_常用工具\_对象存储 OSS-阿里云](https://help.aliyun.com/document_detail/153892.html?spm=a2c4g.11186623.2.11.5a0321edm3pWzB)
[高级配置\_ossfs\_常用工具\_对象存储 OSS-阿里云](https://help.aliyun.com/document_detail/153893.html?spm=a2c4g.11186623.6.752.42ff7358mDPRYL)
