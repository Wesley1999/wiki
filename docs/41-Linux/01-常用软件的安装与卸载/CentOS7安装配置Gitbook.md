# CentOS7安装配置Gitbook

## 安装
```
npm install gitbook-cli -g
gitbook -V
```

控制台显示
```
CLI version: 2.3.2
Installing GitBook 3.2.3
-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
```
经过两三分钟的等待就安装好了

## 初始化
```
cd /home/apps/gitbook
mkdir demo
cd demo
## 初始化之后会看到两个文件，README.md ，SUMMARY.md
gitbook init
## 生成静态站点，当前目录会生成_book目录，即web静态站点
gitbook build ./
## 启动web站点，默认浏览地址：http://localhost:4000
gitbook serve ./
```

## Reference
[https://www.jianshu.com/p/ec1e7d2c76c6](https://www.jianshu.com/p/ec1e7d2c76c6)