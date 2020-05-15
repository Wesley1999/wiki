# CentOS7安装配置JDK8

## 下载

```shell
wget https://oss-file.wangshaogang.com/Develop/Linux/jdk-8u231-linux-x64.tar.gz
```

## 创建安装目录

```shell
mkdir /usr/local/java/
```

## 解压

```shell
tar -zxvf jdk-8u231-linux-x64.tar.gz -C /usr/local/java/
```

## 设置环境变量

```shell
vim /etc/profile
```

在末尾添加：

```
export JAVA_HOME=/usr/local/java/jdk1.8.0_231
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```

使环境变量生效：

```shell
source /etc/profile
```

## 检查

```shell
java -version
```

## Reference
[CentOS 7 安装 JAVA环境（JDK 1.8）](https://www.cnblogs.com/stulzq/p/9286878.html)