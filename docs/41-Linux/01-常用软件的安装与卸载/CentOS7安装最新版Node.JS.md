# CentOS7安装最新版Node.JS

直接使用`yum install`安装的nodejs版本比较旧，使用过程中让已出现兼容性问题，所以安装新版nodejs是有必要的。

## 获取最新版的 bash
```
## 12可以修改为其他数字
curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -
```

## 执行安装

```
sudo yum install -y nodejs
```

## 查看版本

```
node --version
npm --version
```

## 换源
这里是淘宝的源
```
npm config set registry https://registry.npm.taobao.org
```

## Reference
[https://segmentfault.com/a/1190000010209661](https://segmentfault.com/a/1190000010209661)
[https://www.jianshu.com/p/f311a3a155ff](https://www.jianshu.com/p/f311a3a155ff)