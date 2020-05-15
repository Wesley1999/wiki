# Linux安装pip

下载pip-20.1.tar.gz

```shell
wget https://files.pythonhosted.org/packages/d1/05/059c78cd5d740d2299266ffa15514dad6692d4694df571bf168e2cdd98fb/pip-20.1.tar.gz
```

如果下载地址错误，请到这个网页上查找

<https://pypi.org/project/pip/#files>



下载完成后解压并进入相应目录

```shell
tar -zxvf pip-20.1.tar.gz
cd pip-20.1
```



安装

```shell
python setup.py install
```


