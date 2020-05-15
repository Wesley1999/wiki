# Linux配置git与github关联

## 生成ssh key

```shel
ssh-keygen -t rsa -C "a13207123727@gmail.com"
```

之后按三次回车，默认将key文件存在`~/.ssh/id_rsa.pub`中。

## 配置用户名和邮箱

```shell
git config --global user.email "a13207123727@gmail.com"
git config --global user.name "Wesley"
```

## 查看ssh key

```shell
cat ~/.ssh/id_rsa.pub
```

## 配置到Github

略


