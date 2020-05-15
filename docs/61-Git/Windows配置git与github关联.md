# Windows配置git与github关联

原文：[Windows 配置 git 与 github 关联](https://juejin.im/post/5be10660f265da614e2b8be7)

## 配置 git 账户名和邮箱
```
~$ git config --global user.email "you@example.com"
~$ git config --global uesr.name "you Name"
```

## 配置 ssh
```
~$ ssh-keygen -t rsa -C "you@example.com"

Generating public/private rsa key pair.

Enter file in which to save the key (C:\Users\用户名/.ssh/id_rsa):

Created directory 'C:\Users\用户名/.ssh'.

Enter passphrase (empty for no passphrase):

Enter same passphrase again:
```
公钥生成的位置在 用户名/.ssh 文件夹。

## 将公钥配置到 github 上
登录到github上 ，点击头像，然后 Settings -> 左栏点击 SSH and GPG keys -> 点击 New SSH key 。 在title中输入一个名字，在key 文本域中输入你的公钥， 点击 Add SSH Key

## 验证 key是否正常工作
不用替换邮箱
```
~$ ssh -T git@github.com
```