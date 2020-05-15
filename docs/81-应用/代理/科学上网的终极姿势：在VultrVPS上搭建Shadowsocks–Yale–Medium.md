# 科学上网的终极姿势：在VultrVPS上搭建Shadowsocks–Yale–Medium

全文转载于[https://medium.com/@zoomyale/科学上网的终极姿势-在-vultr-vps-上搭建-shadowsocks-fd57c807d97e](https://medium.com/@zoomyale/%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91%E7%9A%84%E7%BB%88%E6%9E%81%E5%A7%BF%E5%8A%BF-%E5%9C%A8-vultr-vps-%E4%B8%8A%E6%90%AD%E5%BB%BA-shadowsocks-fd57c807d97e)
无删改。

---

作为一个离开 Google 生活就无法自理的人类，我曾经发帖、提问、翻遍各种网站，四处寻找靠谱的科学上网利器。结果，确实也找到过一些能满足当下需求的产品，但是不久后各种杯具就发生了。
![](https://oss-pic.wangshaogang.com/1586692120372-0dd29199-fd11-4f17-9be5-3ff86813eb5d.jpg)

(ノ ﾟДﾟ)ノ ＝＝ ┻━┻ 这是人民日益增长的物质文化需求同落后的社会生产之间的矛盾啊！

这些服务要么价格不低，要么稳定性太差，还可能随时被查封，实在让人很为难。这时候我想，反正都是通过海外服务器来提供建服务的，为什么不干脆自己租台呢？结果是，整个人都跟着网速起飞了下图是搭建完成后观看 YouTube 4K 视频的截图。

![](https://oss-pic.wangshaogang.com/1586692120374-0e3f7f24-546e-46e4-bef4-e81daafc3738.png)

所以，如果你和我一样不满足上述那些服务，又不怕麻烦的话，这里有一份详细而对小白友好的折腾指南。事先说明，如果你希望不花钱就能用上优质的服务──醒醒，别做梦了，免费和优质从来不可能划上等号。不过想要共享或建立多账户来出售的话，能赚钱也说不定

Medium 的排版还是不适合此类文章，为了获得更好的阅读体验，可以转至[我的 Blog](https://zoomyale.com/2016/vultr_and_ss/)。

## 一、一些背景和原理
因为整个折腾过程对没有技术背景的人来说，还是略显复杂的，所以有必要先粗浅地介绍一下所涉及的概念和原理。如果不感兴趣可以跳过，直接看操作步骤。
### 1.1什么是 Shadowsocks
![](https://oss-pic.wangshaogang.com/1586692120378-bb578607-1bcc-43d8-8fc3-aae70042633e.png)

Shadowsocks(ss) 是由 [Clowwindy](https://github.com/Clowwindy) 开发的一款软件，其作用本来是加密传输资料。当然，也正因为它加密传输资料的特性，使得 GFW 没法将由它传输的资料和其他普通资料区分开来（上图），也就不能干扰我们访问那些「不存在」的网站了。

### 1.2什么是 VPS 和 Vultr
VPS(Virtual private server) 译作虚拟专用伺服器。你可以把它简单地理解为一台在远端的强劲电脑。当你租用了它以后，可以给它安装操作系统、软件，并通过一些工具连接和远程操控它。

[Vultr](https://www.vultr.com/) 是一家 VPS 服务器提供商，有美国、亚洲、欧洲等多地的 VPS。它家的服务器以性价比高闻名，按时间计费，最低的资费为每月 $2.5。

![](https://oss-pic.wangshaogang.com/1586692120379-06d2c355-fb4f-4ce4-b1c7-bc3663f5a367.png)

比 Vultr 价格更低的服务商也有许多，最知名的莫过于[「搬瓦工」](https://bandwagonhost.com/)，和 V 家差不多的配置只要 $19.9 每年。不过后者过于出名，据说超售严重，实测夜间速度足以让人痛哭流涕。

### 1.3什么是 Linux 和 SSH

Linux 是免费开源的操作系统，大概被世界上过半服务器所采用。有大量优秀的开源软件可以安装，上述 Shadowsocks 就是其一。你可以通过命令行来直接给 Linux 操作系统「下命令」，比如 $ cd ~/Desktop 就是进入你根目录下的 Desktop 文件夹。

![](https://oss-pic.wangshaogang.com/1586692120382-7210a0db-523e-4547-8c75-18d025b7169e.png)

而 SSH 是一种网络协议，作为每一台 Linux 电脑的标准配置，用于计算机之间的加密登录。当你为租用的 VPS 安装 Linux 系统后，只要借助一些工具，就可以用 SSH 在你自己的 Mac/PC 电脑上远程登录该 VPS 了。

## 二、购买和连接 VPS
### 2.1注册 Vultr
首先，访问 [Vultr.com](https://www.vultr.com/) 注册帐号，网站目前还没有被墙，访问速度不错。Vultr 官网似乎常年有活动，目前是注册新用户后绑定 VISA 信用卡就送 $50，有效期2个月（活动暂已过期）。

如果需要，也可以使用我的 [推荐链接](http://www.vultr.com/?ref=7067859-3B) 注册，激活后一个月内有付费行为就可以获赠 $20。

### 2.2部署 VPS
注册完成后，在左边选择“Servers”标签，点击右边的加号部署新的服务器。

![](https://oss-pic.wangshaogang.com/1586692120389-56f257dd-7812-44de-9b31-a00c84384a99.png)

选择一个你想要的节点。推荐东京和洛杉矶，速度快，不过因为使用的人比较多，稳定性可能会受影响。

![](https://oss-pic.wangshaogang.com/1586692120396-cd7c0cb8-63cc-452a-b033-97374d737dd5.jpg)

为 VPS 选择安装系统。这里可以随自己喜欢，选择 Windows 以外的任意 Linux 系统。下面的教程以 CentOS 6x64 为例。

![](https://oss-pic.wangshaogang.com/1586692120401-a637ead8-1b6a-4687-9270-1a92b3ed37e1.jpg)

根据需求选择套餐。只供个人科学上网用的话，$5 绰绰有余（vultr 已新推出 $2.5 套餐）。

![](https://oss-pic.wangshaogang.com/1586692120405-2bad3c95-ae20-49b7-b855-10ddde3bb502.jpg)

剩下都可以使用默认值。最后一项你可以自定义服务器的名字和标签，以方便区分。

![](https://oss-pic.wangshaogang.com/1586692120409-584f9ec3-9902-42c6-985c-871a9e9c4d28.jpg)

另外，上图第 6 步中，SSH Keys 的作用是，可以让你登录 VPS 时不用每次手动输密码。若只将其用作 Shadowsocks 服务器，仅需要在配置时登录一次，可以完全忽略它。如果要同时作他用，可参考 [此文](https://www.vultr.com/docs/how-do-i-generate-ssh-keys/) 生成并添加 SSH Key。

等待系统安装完成。当显示“Running”时，就表示部署已完成。之后你可以随时停用、重启或销毁它。

![](https://oss-pic.wangshaogang.com/1586692120411-d2a99bc6-dad3-4e55-a975-7cfe335c2325.jpg)

### 2.3连接 VPS
如果你使用的是 PC，连接 VPS 需要借助一些工具，比如 [Putty](https://www.putty.org/)。你可以参考这篇[百度经验](http://jingyan.baidu.com/article/8ebacdf0d9e86549f75cd57b.html)完成安装，安装完成后步骤与下文 Mac 一致。

Mac 只要打开「终端」应用即可开始使用 SSH 连接 VPS。你的「终端」界面可能和下图略有差别，但是差不远──都有一个闪烁的光标，前面会有一个 $ 符号。

![](https://oss-pic.wangshaogang.com/1586692120415-38c5beb8-9e72-4da2-8aee-3cd7bd8369c8.jpg)

首先，在 Vultr 上你刚部署的服务器右边点“Manage”，找到服务器的 IP 地址（标黄部分）和密码。

![](https://oss-pic.wangshaogang.com/1586692120419-2e1908c9-9372-4baa-a701-eadef499bb89.jpg)

在「终端」或 Putty 等应用中，输入下面的命令并回车。注意把替换成你服务器的 IP 地址。

```
ssh root@<host>
```

接下来屏幕上会出现一连串提示，意为无法确认 host 主机的真实性，只知道它的公钥指纹，问你还想继续连接吗？直接输入 yes 并回车。

![](https://oss-pic.wangshaogang.com/1586692120419-2e1908c9-9372-4baa-a701-eadef499bb89.jpg)

然后输入密码，也就是把服务器状态页中密码那块复制一下，再 ⌘ + v 贴过来。这里不管是输入还是粘贴，屏幕上都不会显示字符，所以贴完后也是看不到字符的，回车就行。

![](https://oss-pic.wangshaogang.com/1586692120438-aa231919-99e2-4af1-aae4-bc6d7043a67d.jpg)

当出现上图那串 \[root@vultr ~\]## 时，说明已成功登录。

## 三、部署 Shadowsocks

Shadowsocks 需要同时具备客户端和服务器端，所以它的部署也需要分两步。

### 3.1部署 Shadowsocks 服务器端
这里使用 [teddysun](https://teddysun.com/342.html) 的一键安装脚本。

以下是3条命令，每次输入一行、回车，等待屏幕上的操作完成后再输入下一条。

```shell
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log
```

最后一步输完，你应该会看到下图中内容──是要你为 Shadowsocks 服务设置一个个人密码。
![](https://oss-pic.wangshaogang.com/1586692120442-aaed3a5a-81a9-4791-a0c3-46e03095d960.jpg)

输好回车后会让你选择一个端口，输入 1–65535 间的数字都行。

![](https://oss-pic.wangshaogang.com/1586692120446-430c9d5b-456d-4296-9810-9d91b38faf07.jpg)

之后可以选择加密方式，这个就看个人喜好了，默认是 aes-256-gcm。

![](https://oss-pic.wangshaogang.com/1586692120449-96b2df1f-f06e-41a1-9b24-697e83a4792e.png)

遵照上图指示，按任意键开始部署 Shadowsocks。这时你什么都不用做，只需要静静地等它运行完就好。结束后就会看到你所部署的 Shadowsocks 的配置信息。

![](https://oss-pic.wangshaogang.com/1586692120460-3951619e-0411-49ad-9bcc-b2ee85b965be.jpg)

记住其中黄框中的内容，也就是服务器 IP、服务器端口、你设的密码和加密方式。

### 3.2 TCP Fast Open

实际上只要具备上述四个信息，你就可以在自己的任意设备上进行登录使用了。但是为了更好的连接速度，你还需要多做几步。

首先是打开 TCP Fast Open，输入以下命令，意为用 nano 这个编辑器打开一个文件。

```shell
nano /etc/rc.local
```

你的「终端」会刷新一下，出现下图。

![](https://oss-pic.wangshaogang.com/1586692120464-576860d0-cb7d-4762-94d7-ea949a06dc27.jpg)

别慌张，它就是个文本编辑器。用方向键把光标移到最末端，粘贴下面这一行内容，然后按 Ctrl + X 退出。

```shell
echo 3 > /proc/sys/net/ipv4/tcp\_fastopen
```

输入“Y”并回车确认退出。

![](https://oss-pic.wangshaogang.com/1586692252330-dd5ebf9c-d43b-49bf-ab61-90b03e11b800.jpg)

然后依法炮制，输入：
```shell
nano /etc/sysctl.conf
```

在文末加上下面的内容，保存退出。
```shell
net.ipv4.tcp\_fastopen = 3
```

再打开一个 Shadowsocks 配置文件。
```shell
nano /etc/shadowsocks.json
```

把其中 “fast\_open” 一项的 false 替换成 true。
```shell
"fast\_open":true
```

如果你希望添加多用户的话，可以将 “password” 字段如下图修改。其中，“22345”:“password1”意为该用户使用 22345 端口、以“password1”为密码连接登录 Shadowsocks。

![](https://oss-pic.wangshaogang.com/1586692252332-dc645ab6-8077-413a-9d15-b25d0cce8037.jpg)

如果添加了多用户，需要更改防火墙规则，开放刚刚新增的端口。centOS 6 系统开放办法如下。保存退出后，输入以下命令，注意一次输入一行，并把  替换为刚添加的端口：

```shell
iptables -I INPUT -m state — state NEW -m tcp -p tcp — dport  -j ACCEPT
iptables -I INPUT -m state — state NEW -m udp -p udp — dport  -j ACCEPT
/etc/init.d/iptables save
/etc/init.d/iptables restart
```

保存退出。最后，输入以下命令重启 Shadowsocks。

```shell
/etc/init.d/shadowsocks restart
```

### 3.3安装 Shadowsocks 客户端
相比服务器端的安装，客户端的安装就简单了许多。首先，根据操作系统下载相应的客户端。

• [Mac 版客户端下载](https://sourceforge.net/projects/shadowsocksgui)
• [Win 版客户端下载](https://github.com/shadowsocks/shadowsocks-windows/releases)

打开客户端，在「服务器设定」里新增服务器。然后依次填入服务器 IP、服务器端口、你设的密码和加密方式。

![](https://oss-pic.wangshaogang.com/1586692252332-96e92467-1ad8-4202-b32c-702dc669b73e.png)

然后启用代理，就可以实现科学上网了。

## 四、开启 BBR
完成上述步骤后，使用过程中可能会发现连接速度有时不太令人满意。这就是加速工具们发挥功能的时候了。常用的加速工具有「锐速」、TCP BBR、kcptun，等等。原理虽各不相同，但都是通过一些技术手段，来实现连接和传输速度的提升。

### 4.1什么是 BBR
[TCP BBR](https://zh.wikipedia.org/wiki/TCP%E6%8B%A5%E5%A1%9E%E6%8E%A7%E5%88%B6) 是 Google 于 2016 年发布的，一种避免网络拥塞的算法。目的是要尽量跑满带宽, 并且尽可能避免排队的情况。

实际使用下来，BBR 的速度提升效果并不比「锐速」（据说已倒闭）、kcptun（多倍发包耗流量）等差。而且 BBR 已植入 Linux 4.9+ 版本的内核中，服务器开启后就能有显著的效果提升。

### 4.2安装 BBR

和 2.3 中的步骤一样，首先需要用 SSH 登录 VPS。
```shell
ssh root@<host>
```

这里依然使用 @teddysun 的一键安装[脚本](https://teddysun.com/489.html)，输入以下命令。
```shell
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
```

按任意键开始安装，安装需要一段时间，等待一会即可。

![](https://oss-pic.wangshaogang.com/1586692252333-001c6f1e-4159-4543-b79e-66a6720a4c78.png)

安装完成后，脚本会提示需要重启 VPS，输入 y 并回车后重启。

重新使用 SSH 登录 VPS，这时 BBR 应该已经开启了。你可以使用以下两行命令验证一下。

```shell
uname -r
lsmod | grep bbr
```

如果输出的内核版本为 4.9 以上版本，且返回值有 tcp\_bbr 模块的话，说明 bbr 已启动。

![](https://oss-pic.wangshaogang.com/1586692252333-595924f4-ce63-4b49-a13d-9e6efa6322b2.png)

至此，整个搭建过程就大功告成了！接下来，尽情地享受自由的网络吧

## 五、一些也许对你有用的教程
### 5.1关于浏览器
依然记得自己使用「红杏」的畅快体验──哪个网站不能访问了，按下图标添加到规则列表中，就可以「科学」地访问了。这种无缝的体验，靠 Shadowsocks 加另一款 Chrome 扩展 SwitchyOmega 也能实现，这里是[使用教程](https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList)。

### 5.2关于桌面应用
部署 Shadowsocks 完成后，浏览器就能实现科学上网了，但是像 Dropbox 等部分桌面应用的流量，还不能由 Shadowsocks 来代理。要实现桌面应用的代理，需要再借助其他应用，比如 [Proxifier](https://www.proxifier.com/)、[Surge for Mac](https://nssurge.com/)。

### 5.2关于手机
安卓手机只需要下载安装 [Shadowsocks 安卓版](https://github.com/shadowsocks/shadowsocks-android/releases)，并与桌面版一样，填入服务器 IP、端口、密码和加密方式，就可以设置全局或分应用代理。但是要实现「真正意义上」的 PAC 规则的话（也就是自定义哪些域名走代理、哪些不走），可以试试目前还在内测中的「Android 版 Surge」 — — [Surfboard](https://manual.getsurfboard.com/)。

iOS 可以通过类 [Surge](https://itunes.apple.com/us/app/surge-3-web-developer-tool/id1329879957?ls=1&mt=8) 的 App 实现 PAC 规则下的自动翻墙。

• [详尽版 Surge教程](https://medium.com/@scomper/surge-%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6-a1533c10e80b#.gub28k9hh)

• [简化版 Surge教程](http://www.jianshu.com/p/de1eb844915d)

Surge 目前定价 328 元，另有 Mac 版（另外收费）。作为一款兼具「科学上网」功能的网络开发调试利器，它完全值这个价。觉得太贵的话，可以使用相对便宜的 [Wingy](https://itunes.apple.com/us/app/wingy-smart-proxy-for-http/id1148026741?mt=8) 或者 [Potatso](https://itunes.apple.com/us/app/potatso-2/id1162704202?mt=8)，不过二者都没有前者来得稳定好用。

## 参考文章
• [SSH 原理与运用（一）：远程登录](http://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html)

• [Vultr 的 vps 搭建 shadowsocks 科学上网](http://mpc2008cn.github.io/2015/10/22/vps/)

• [写给非专业人士看的 Shadowsocks 简介](http://vc2tea.com/whats-shadowsocks/)

• [Shadowsocks Python 版一键安装脚本](https://teddysun.com/342.html)

• [teddysun’s GitHub: shadowsocks\_install](https://github.com/teddysun/shadowsocks_install)

![](https://oss-pic.wangshaogang.com/1586692252333-128ac622-a525-4e51-881e-8b9485225e56.png)




