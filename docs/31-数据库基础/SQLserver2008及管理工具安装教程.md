# SQLserver2008及管理工具安装教程

本文于2018-06-11发布于我的博客，以下为原文。

---

学了一个学期数据库，到要做课程设计时，却发现班上很多同学还不会安装SQL server 2008，为此，我写了这篇SQL server 2008安装教程。

当然，我在安装这个软件时，也遇到过许多困难，而且在网上很难找到完整的教程。在此分享一下安装过程和常见的问题，希望能帮到大家。

本教适用于64位Windows操作系统。

如果你之前安装过SQL server 2008且安装失败，请确保已经彻底卸载(删除本地文件和删除注册表)，因为卸载不彻底下次安装出错的可能性很大。至于如何完美卸载，这篇博客写的很棒。
https://blog.csdn.net/u013058618/article/details/50265961

# 1.下载数据库引擎服务和数据库管理工具

**1.1** 到官网下载SQLEXPR_x64_CHS.exe，地址：<https://www.microsoft.com/zh-cn/download/details.aspx?id=1695>

**1.2** 到官网下载SQLManagementStudio_x64_CHS.exe，地址：<https://www.microsoft.com/en-us/download/details.aspx?id=7593>

# 2.安装SQLEXPR_x64_CHS.exe

**2.1** 打开下载好的SQLEXPR_x64_CHS.exe，界面如下图所示。
如果没有出现要求安装`.NET Framework 3.5`的弹窗，可以进行下一步。

如果出现要求安装`.NET Framework 3.5`的弹窗，按提示自动安装即可，如果不能自动安装，可能是因为用杀毒软件禁用了Windows Update服务，解决方式这里就不展开了，可以参考这篇百度经验。

<https://jingyan.baidu.com/article/6c67b1d6a8f2922787bb1ea5.html>

![](https://oss-pic.wangshaogang.com/1586692298658-231e72ca-abc7-4e93-89fd-bd0a74f387c9.png)

**2.2** 点击左边的安装，然后点击“全新SQL Server独立安装或向现有安装添加功能”。
![](https://oss-pic.wangshaogang.com/1586692298660-371e1367-8f10-4953-944f-5a6a8170698c.png)

**2.3** 点击确定
![](https://oss-pic.wangshaogang.com/1586692298660-52b74316-e21c-4f35-9101-fc845e937d79.png)

**2.4** 没什么好说的，下一步
![](https://oss-pic.wangshaogang.com/1586692298660-fdc76581-d4e0-4b5e-b81b-c5f0fcfdda4e.png)

**2.5** 点击安装
![](https://oss-pic.wangshaogang.com/1586692298661-ccf3e87b-1e57-4d16-8665-dcacd9a6d08d.png)

**2.6** 点击下一步

如果这里出现要求重启计算机的问题，那么就算你重启了计算机重新安装，依然达不到需要的效果，解决方式可以参考这篇博客。
https://blog.csdn.net/z10843087/article/details/24687367
![](https://oss-pic.wangshaogang.com/1586692298661-1ae43764-2832-437d-9a29-937e152a2487.png)


**2.7** 全选，然后点击下一步。如果你是第一次安装，可以修改共享功能目录，但是我建议使用默认目录。
![](https://oss-pic.wangshaogang.com/1586692298661-e37ea72b-f92b-443c-ac75-5fffccc25284.png)

**2.8** 点击命名实例，可以参考图中填写的SQLExpress，然后点击下一步，这样可以确保后面的操作与我一致。

实例名称也可以填写其他内容，但必须记住，因为后面连接到数据库的时候要用到。

如果你以前安装过同名的实例，就只能填写其他实例名了。
![](https://oss-pic.wangshaogang.com/1586692298662-49215c49-2f45-4b45-9ffd-851e9d2fe74c.png)

**2.9** 下一步
![](https://oss-pic.wangshaogang.com/1586692298662-0c09ef27-ba97-4294-9779-71cbf11d45bc.png)

**2.10** 这里需要展开上面账户名的下拉菜单，选择第一项NT AUTHORITY\NETWORK SERVICE，一定不要选择第二项。其他内容不用修改，点击下一步。
![](https://oss-pic.wangshaogang.com/1586692298662-3f997f42-ead9-477b-b38a-0b26dcd953bf.png)

**2.11** 点击添加当前账户，可能会有短时间的卡顿，然后点击下一步。至于上面的身份验证模式，可以修改为混合模式，也可以在安装完成后修改，我这里选择了默认的Windows身份验证模式。
![](https://oss-pic.wangshaogang.com/1586692298676-b39d34d2-9f49-437f-bb1b-70686a658d12.png)

**2.12** 后面的操作没什么好说的了，直接点击下一步。佩服我自己有耐心截这么多图。
![](https://oss-pic.wangshaogang.com/1586692298681-e94304cb-eb12-48c5-863f-a41ea1582a9c.png)
![](https://oss-pic.wangshaogang.com/1586692298686-3683e27f-2c90-4da3-822c-d55b780ac86a.png)
![](https://oss-pic.wangshaogang.com/1586692298692-3ff538a1-5daa-4439-9915-d8d5a4866558.png)

**2.13** 这一步需要的时间较长，请耐心等待。我曾经安装到这一步的时候报错，原因是之前卸载完没有删除注册表。关于安装失败后如何卸载，请上划到文章开头。
![](https://oss-pic.wangshaogang.com/1586692298694-3854a2e4-b465-4217-8b2b-95960b362707.png)
![](https://oss-pic.wangshaogang.com/1586692298703-3008582e-6171-48a0-8c35-e9aa62541fd4.png)
![](https://oss-pic.wangshaogang.com/1586692298706-fa4c8b03-190c-4c19-ba54-73d8050e5838.png)

# 3.安装SQLManagementStudio_x64_CHS.exe

**3.1** 这里与前面类似，打开下载好的SQLManagementStudio_x64_CHS.exe，点击左边的安装，然后点击“全新SQL Server独立安装或向现有安装添加功能”。
![](https://oss-pic.wangshaogang.com/1586692298709-5a42aef0-442f-4048-bf2f-d0ec66d9233b.png)

**3.2** 后面的操作没有难度，只要前面安装SQLEXPR_x64_CHS.exe没有出现问题，后面也不会有问题。
![](https://oss-pic.wangshaogang.com/1586692298712-90395abd-a574-44d7-b3f3-13764952f7e9.png)
![](https://oss-pic.wangshaogang.com/1586692298716-baf1d26a-74a2-4f2e-931b-ee3b401f2e1c.png)
![](https://oss-pic.wangshaogang.com/1586692498617-cffb1f25-91be-445f-b8b8-aa670c55d4a8.png)
![](https://oss-pic.wangshaogang.com/1586692498618-3c28ac7a-c10b-4995-8969-c254a01b88bf.png)
![](https://oss-pic.wangshaogang.com/1586692498618-773a9591-9b60-4f3e-8679-84fe55369764.png)
![](https://oss-pic.wangshaogang.com/1586692498618-caf89aa5-36e4-48d0-910e-e89a92bed5a2.png)


**3.3** 这里记得点击全选，然后下一步。
![](https://oss-pic.wangshaogang.com/1586692498619-83f5ae52-a444-4e8d-887c-174dd1c93aa8.png)
![](https://oss-pic.wangshaogang.com/1586692498624-9163b0d8-4e8f-4dea-aa82-10522d1dc83f.png)
![](https://oss-pic.wangshaogang.com/1586692498625-4d2c81ef-ee07-4fb3-ba23-e287772ffc85.png)
![](https://oss-pic.wangshaogang.com/1586692498627-30be1465-bae9-4704-9586-ee04d2cd314c.png)
![](https://oss-pic.wangshaogang.com/1586692498629-d73b49e5-4509-474c-8c99-1ee09638f568.png)
![](https://oss-pic.wangshaogang.com/1586692498630-8564aec9-e358-4a5d-a412-64bae41e6035.png)
![](https://oss-pic.wangshaogang.com/1586692498632-e4b50152-8546-4e88-ab7f-ed9126a7b70b.png)
![](https://oss-pic.wangshaogang.com/1586692498633-d22e9ee3-b98c-4533-b6ed-f6fe898f56a8.png)

完成后，点击关闭，至此，已经完成了数据库引擎服务和数据库管理工具的安装。

# 4.数据库的配置与连接

**4.1** 在开始菜单中找到SQL Server配置管理器，打开。
![](https://oss-pic.wangshaogang.com/1586692498635-ecc69f9a-4394-46e8-8099-11ca7f5e86af.png)

**4.2** 展开SQL Server网络配置，点击SQLEXPRESS的协议，然后右键单击TCP/IP协议，选择启动，然后会弹出要求重启服务的警告。不要怕，接下来就去重启服务。
https://oss-pic.wangshaogang.com/1586692498636-1e99dd3f-97d1-4944-8c90-d1c73e53ac66.png

**4.3** 直接在Win10搜索框输入“服务”，就可以打开服务了(如果不是win10，可以按Win+R，运行services.msc，回车)。

进入服务窗口后，找到SQL Server(SQLEXPRESS)（如果跟我不一样，就要找到你安装的实例对应的服务），右键单击选择启动或重新启动，如果启动类型不是自动启动，建议修改为自动启动，这样就不用每次开机后手动启动这项服务了。
![](https://oss-pic.wangshaogang.com/1586692621603-e0af4035-7e6b-4fbf-aa3f-2d2c4d3c56e6.png)
![](https://oss-pic.wangshaogang.com/1586692621604-d70a74c0-9030-4ffb-be5c-73079a4a7fe6.png)

**4.4** 完成服务的重启后，在开始菜单中找到SQL Server Management Studio，这个是数据库管理工具，可以把快捷方式复制到桌面，然后打开。
![](https://oss-pic.wangshaogang.com/1586692621606-f2f31929-1c13-429d-8df0-fc30442b6e40.png)

**4.5** 连接到服务器，身份验证方式选择Windows身份验证，服务器名称填“(local)\实例名”，如果前面的安装的实例跟我一样，就是“(local)\SQLEXPRESS”，填写完之后就可以连接到数据库服务器了。
![](https://oss-pic.wangshaogang.com/1586692621608-d0bd9b1f-ca6f-43c7-a3c7-6cbe88166710.png)
