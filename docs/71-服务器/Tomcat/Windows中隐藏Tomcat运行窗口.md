# Windows中隐藏Tomcat运行窗口

打开bin文件夹
打开setclasspath.bat文件

修改
```
set _RUNJAVA="%JRE\_HOME%\bin\java.exe"
```
为
```
set _RUNJAVA="%JRE_HOME%\bin\javaw.exe"
```