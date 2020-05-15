# Tomcat启动时闪退原因分析

tomcat启动时闪退，很可能的原因是JAVA_HOME环境变量没有配置或配置错误，解决方式是：
**将JAVA_HOME的变量值配置为jdk文件夹**，例如我的是：

**C:\Program Files (x86)\Java\jdk1.7.0_72**

保存以后Tomcat就可以运行了，当然，前提是端口没有被占用。

如果Tomcat使用IDEA等编译器启动的，即使JAVA_HOME配置错误，Tomcat也该正常运行，所以这个问题不太容易被发现。
