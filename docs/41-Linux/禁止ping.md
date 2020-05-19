## 禁止ping

编辑

```shell
vim /etc/sysctl.conf
```

添加

```shell
# 禁止ping，改为0表示允许
net.ipv4.icmp_echo_ignore_all=1
```

使新配置生效

```shell
sysctl -p
```



## Reference

<https://www.cnblogs.com/chenshoubiao/p/4781016.html>