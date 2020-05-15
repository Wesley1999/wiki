# JDBC连接数据库示例

本文于2018-06-13发布于我的博客，以下为原文。

---

本文结合我的Java课程设计经验，介绍IDEA用JDBC连接到SQL Server的过程。
然后通过一个实例，验证连接是否成功，所有源代码在本教程中已给出。

# 1.环境准备
**1.1** 配置Java环境这里就不详细写了，我用的Java版本是64位1.8.0_171，Java版本可以与我不同，能正常使用就行了。
**1.2** 安装Java编译器，我使用的编译器是IntelliJ IDEA 15.0.6，如果使用的编译器是eclipse或Myeclipse，导入JDBC的步骤可能与我不同，其他步骤差别不大。

**1.3** 安装SQL server 2008及管理工具，这个可以参考我的另一篇博客：SQL server 2008及管理工具安装教程

**1.4** 创建数据库用户并配置用户权限

列表左侧中展开“安全性”，右键点击“登陆名”，选择“新建登录名”，用SQL Server身份验证，登陆名填写test，密码填写123456，这样可以确保后面的Java代码与我一致，为了方便，不勾选“强制密码过期”，先别点确定。
![](https://oss-pic.wangshaogang.com/1586692655311-a697a450-eeed-4f13-aad6-fa817cb5dcb6.png)
点击选择页中的服务器角色，配置用户权限，权限根据实际使用来赋予，最后一个”sysadmin”是管理员权限，一般选这个就行，然后确定。
![](https://oss-pic.wangshaogang.com/1586692655313-d53920a1-8204-4b32-9dc2-9d794328163b.png)

**1.5** 建立ODBC数据源

打开SQL Server配置管理器，展开SQL Server的网络配置，选择SQLEXPRESS的协议(安装的实例名称与我不同这里的协议就不同，后文省略)。

打开TCP/IP的属性，点开IP地址选项卡，把IP6的IP地址改为127.0.0.1，把 IPAll的TCP动态端口改为1433，确定。
![](https://oss-pic.wangshaogang.com/1586692655313-6162a532-e9e1-4a35-9308-c7d2f7634d90.png)

进入控制面板\系统和安全\管理工具，打开ODBC数据源管理程序(64位)，点开系统DNS地址选项卡，再点击添加。
![](https://oss-pic.wangshaogang.com/1586692655317-46b0c1b5-14fd-4d95-91c7-13f1d5d02c3e.png)

选择SQL Server，点击完成。
![](https://oss-pic.wangshaogang.com/1586692655318-54c7e4e2-d159-404e-8a69-9ebcd2f6ad16.png)

名称随便取，描述可以不填，服务器就是你登录数据库时的服务器名称，我的是(local)\SQLEXPRESS，填好之后点击完成。
![](https://oss-pic.wangshaogang.com/1586692655318-1a730462-2fd0-4afe-9c7f-f4ab4a64ce59.png)

这里可以测试数据源，如果显示“测试成功！”，就说明建立ODBC数据源成功了！
![](https://oss-pic.wangshaogang.com/1586692655318-b7d9caed-d5a9-4e81-bce1-74a0ef210552.png)

**1.6** 到官网下载JDBC包，如果你的Java版本是64位Java 7/8/9，可以到这个地址下载：https://www.microsoft.com/zh-CN/download/details.aspx?id=56615
![](https://oss-pic.wangshaogang.com/1586692655319-a7c90e0a-9e08-47e4-a8ad-39f83b55fe02.png)

需要下载的文件是sqljdbc_6.4.0.0_chs.exe，下载完后打开，unzip到任意位置。
![](https://oss-pic.wangshaogang.com/1586692655325-31bb9750-4f9b-42aa-b684-161263bad3eb.png)

完成以上内容就做好了用JDBC连接数据库的准备工作，下面进行测试。

# 2.创建数据库

**2.1** 打开SQL Server Management Studio，连接到服务器。
![](https://oss-pic.wangshaogang.com/1586692655332-a0cb2452-49ff-4aa1-a3b5-54aca09b3a80.png)
**2.2** 直接新建查询，输入以下代码，执行
```sql
CREATE DATABASE student_management
GO
USE student_management
CREATE TABLE [dbo].[S](
	[SNO] [char](6) NOT NULL,
	[SN] [varchar](10) NOT NULL,
	[SD] [char](16) NULL,
	[SB] [datetime] NULL,
	[SEX] [char](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SNO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's01   ', N'王玲', N'计算机          ', CAST(0x0000811C00000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's02   ', N'李渊', N'计算机          ', CAST(0x000080B900000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's03   ', N'罗军', N'计算机          ', CAST(0x000082B400000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's04   ', N'赵泽', N'计算机          ', CAST(0x000085AE00000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's05   ', N'许若', N'指挥自动化      ', CAST(0x0000811900000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's06   ', N'王仙华', N'指挥自动化      ', CAST(0x0000826000000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's07   ', N'朱祝', N'指挥自动化      ', CAST(0x000086DB00000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's08   ', N'王明', N'数学            ', CAST(0x000082E800000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's09   ', N'王学之', N'物理            ', CAST(0x0000834200000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's10   ', N'吴谦', N'指挥自动化      ', CAST(0x0000822800000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's11   ', N'崔雪', N'数学            ', CAST(0x0000811D00000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's12   ', N'李想', N'英语            ', CAST(0x0000841B00000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's13   ', N'季然', N'数学            ', CAST(0x0000845300000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's14   ', N'顾梦莎', N'英语            ', CAST(0x000080D400000000 AS DateTime), N'女')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's15   ', N'费汉蒙', N'计算机          ', CAST(0x00007FE100000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's16   ', N'华庭', N'数学            ', CAST(0x0000817900000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's17   ', N'亨利', N'英语            ', CAST(0x0000832E00000000 AS DateTime), N'男')
INSERT [dbo].[S] ([SNO], [SN], [SD], [SB], [SEX]) VALUES (N's18   ', N'李爱民', N'英语            ', CAST(0x00007DDA00000000 AS DateTime), N'男')
```
![](https://oss-pic.wangshaogang.com/1586692655334-44314897-9538-46fe-8b53-d20ef12badfb.png)
数据库的创建完成。

# 3.在IDEA中测试

**3.1** 打开IDEA，选择菜单File–New–Project，直接next，next。
![](https://oss-pic.wangshaogang.com/1586692655336-e19d9343-8381-4e70-9708-3f653ee15ded.png)

项目名称随便填，我这里填的是test，然后finish。
![](https://oss-pic.wangshaogang.com/1586692655338-ed8d0761-fa28-4cda-9df4-b989b5ff1a8e.png)

展开test项目，在src文件夹中new一个Java Class。
![](https://oss-pic.wangshaogang.com/1586692655338-c62c6a8b-c69a-4f4d-901a-f0624efaaef8.png)

类名填Demo，确定。
![](https://oss-pic.wangshaogang.com/1586692655367-a661cd80-05ed-4b8f-812f-e1f83d635074.png)

**3.2** 导入jdbc包

打开File–Project Structure，按下图中的顺序先点击Modules选项卡，再点Dependncies选项卡，点右边绿色的加号，再点Library…
![](https://oss-pic.wangshaogang.com/1586692655368-0477c341-a511-4cc8-bada-660d0e6c5976.png)

在弹出的窗口中点击New Library…
![](https://oss-pic.wangshaogang.com/1586692655371-f9223198-132e-4293-90fd-9ee5c10acefe.png)

选择你在下载解压后的以.jar为后缀的jdbc包，点击OK。
![](https://oss-pic.wangshaogang.com/1586692655379-bc7b18d2-c1fc-4e5e-a6f4-6bfe3ec6c9de.png)

点击Add Selected，然后点击OK。
![](https://oss-pic.wangshaogang.com/1586692655381-8dbbe7bd-1439-4c03-9979-eabde8fffccc.png)

在左边的External Libraries中，可以看到你添加的jar包。
![](https://oss-pic.wangshaogang.com/1586692655383-fafb7f27-dea2-4cb4-80cc-a5df0758e225.png)

**3.3** 在Demo.java中，输入以下代码：

import java.sql.*;

```java
/**
 * Created by 王少刚 on 2018/6/13.
 */
public class Demo {
    public static void main(String args[]) throws SQLException, ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=student_management;user=test;password=123456";
        Connection con = DriverManager.getConnection(url);
        String SQL = "SELECT  * FROM S";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(SQL);
        while (rs.next()) {
            System.out.println(rs.getString(1) + " " + rs.getString(2)+ " " + rs.getString(3));
        }
        rs.close();
        con.close();
    }
}
```
按快捷键Alt+Shift+X，让程序跑起来。


出现这样的运行结果就说明用实例验证数据库的连接成功了。
```
"D:\Program Files\Java\jdk1.8.0_171\bin\java" -Didea.launcher.port=7544 "-Didea.launcher.bin.path=C:\Program Files\JetBrains\IntelliJ IDEA 15.0.6\bin" -Dfile.encoding=UTF-8 -classpath "D:\Program Files\Java\jdk1.8.0_171\jre\lib\charsets.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\deploy.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\access-bridge-64.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\cldrdata.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\dnsns.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\jaccess.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\jfxrt.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\localedata.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\nashorn.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\sunec.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\sunjce_provider.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\sunmscapi.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\sunpkcs11.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\ext\zipfs.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\javaws.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\jce.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\jfr.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\jfxswt.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\jsse.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\management-agent.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\plugin.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\resources.jar;D:\Program Files\Java\jdk1.8.0_171\jre\lib\rt.jar;M:\code\IdeaProjects\test\out\production\test;D:\Program Files\Microsoft JDBC Driver 6.4 for SQL Server\sqljdbc_6.4\chs\mssql-jdbc-6.4.0.jre8.jar;C:\Program Files\JetBrains\IntelliJ IDEA 15.0.6\lib\idea_rt.jar" com.intellij.rt.execution.application.AppMain Demo
s01    王玲 计算机          
s02    李渊 计算机          
s03    罗军 计算机          
s04    赵泽 计算机          
s05    许若 指挥自动化      
s06    王仙华 指挥自动化      
s07    朱祝 指挥自动化      
s08    王明 数学            
s09    王学之 物理            
s10    吴谦 指挥自动化      
s11    崔雪 数学            
s12    李想 英语            
s13    季然 数学            
s14    顾梦莎 英语            
s15    费汉蒙 计算机          
s16    华庭 数学            
s17    亨利 英语            
s18    李爱民 英语            

Process finished with exit code 0
```
