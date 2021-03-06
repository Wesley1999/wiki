# IDEA编译器的使用

[toc]

## 快捷键
1. 自动补全变量名称 : Ctrl + Alt + V
2. 剪切当前行：Ctrl + X
3. 删除当前行：Ctrl + Y
4. 复制当前行：Ctrl + D
5. 调整缩进(格式化)：Ctrl + Alt + L
6. 生成get/set/构造方法等：Alt + Insert
7. 光标移到下一行：Shift + Enter
8. 加强for循环：fore
 
## 优点
1. 添加返回值可以自动确定名称，甚至复数形式还能正确变换。
2. 写jsp只有IDEA可以自动导包
3. 导入jstl标签库方便很多
4. 双引号复制到双引号中自动转义
5. spring配置文件自动导入约束
6. 自带eclipse安装sts插件才有的功能
7. 自动管理命名空间
 
## 缺点
1. jsp要手动添加Tomcat的依赖
2. 与mybatis支持的不好：起了别名不使用完整类名依然提示有错误，pojo中的属性有时候读取不到提示有错误，但实际上能通过编译且正常运行。