# 解决GitHub仓库语言识别错误的问题

如果一个Java项目被识别为html项目，是因为项目中的html文件过多。
解决方式是创建一个`.gitattributes`文件，内容写：
```
*.html linguist-language=java
```
这样就可让GitHub把html文件当作Java项目的文件，重新提交，仓库就会被准确地识别为Java项目了。
