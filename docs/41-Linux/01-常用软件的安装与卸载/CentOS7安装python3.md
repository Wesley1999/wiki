# CentOS7安装python3

## 下载

```shell
wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
tar -zxvf Python-3.8.2.tgz
```

## 安装
```shell
cd Python-3.8.2
./configure --prefix=/usr/local/python3
make && make install
```

## 配置软连接
### 删除python2的软连接
```shell
mv /usr/bin/python /usr/bin/python2.7
```
如果`/usr/bin/python2.7`已存在，可以直接删除`/usr/bin/python`
```shell
rm -rf /usr/bin/python
```
```shell
rm -rf /usr/bin/pip
```
### 添加python3的软链接
添加软连接必须使用绝对路径。
```shell
ln  -s  /usr/local/python3/bin/python3.8  /usr/bin/python
ln   -s  /usr/local/python3/bin/pip3 /usr/bin/pip
```

查看版本：
```shell
python  -V
```

## 修改yum相关设置
因yum的功能依赖于Python2.x，更改python默认版本后会导致 yum无法正常工作，所以要修改yum

```shell
vi  /usr/bin/yum
```
修改第一行
```shell
#！/usr/bin/python2.7
```

```shell
vi /usr/libexec/urlgrabber-ext-down
```

修改第一行
```shell
#! /usr/bin/python2.7
```

## Reference
[Centos7下安装Python3.x替代原生Python2.x](https://www.jianshu.com/p/e20c75618b2a)