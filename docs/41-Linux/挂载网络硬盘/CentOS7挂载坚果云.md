# CentOS7挂载坚果云

## 安装davfs2

```shell
sudo yum install -y davfs2
```

## 配置davfs2

处理坚果云与davfs2的兼容问题

```shell
sudo bash -c 'echo ignore_dav_header 1 >> /etc/davfs2/davfs2.conf'
```

## 配置同步信息

WebDAV密码的获取方式：<http://help.jianguoyun.com/?p=2064>

```shell
sudo bash -c 'echo https://dav.jianguoyun.com/dav/【要同步的云端目录】/ 坚果云邮箱 WebDAV密码 > /etc/davfs2/secrets'
mkdir -p /webdav
```

下面的`/webdav`是要挂载到本地的目录，可以修改，不能与已有的目录重复，坚果云上的文件不会自动下载到这个目录，每次读写操作都要进行网络传输。


```shell
sudo bash -c 'echo https://dav.jianguoyun.com/dav/【要同步的云端目录】/ /webdav davfs user,noauto 0 0 > /etc/fstab'
sudo usermod -aG davfs2 $(whoami)
```

## 挂载

```shell
mount -o remount rw /
mount /webdav
```

重启后也要重新挂载。

## 卸载davfs2

```shell
umount /tmp/nutstore_cloud
sudo yum remove -y davfs2
rm -rf /etc/davfs2
rm -rf /etc/fstab
```



## Reference

[备份Linux系统的数据到坚果云]([https://blog.51cto.com/3331062/2306523](https://blog.51cto.com/3331062/2306523))

[可在linux字符界面使用的云盘](https://blog.csdn.net/qq_41961459/article/details/104659388)