# Response知识小结

[toc]

## 设置响应行
	setStatus(int sc)
这个方法用来设置状态码，设置以后，tomcat不会再自动生成状态码。
## 设置响应头
### 方法
	addHeader(String name, String value) 
	addIntHeader(String name, int value) 
	addDateHeader(String name, long date) 
	setHeader(String name, String value) 
	setDateHeader(String name, long date) 
	setIntHeader(String name, int value)
其中，add表示添加，set表示设置，最常用的是setHeader()。
### 应用
#### 重定向
当状态码未302时，设置响应头的Location值，可以自动跳转，如：
```JAVA
response.setStatus(302);
response.setHeader("Location", "/Servlet3");
```
会自动跳转到Servlet3页面。
这段代码有一个封装好的方法，上面两行代码的功能是上面一行代码的功能完全相同：
```JAVA
response.sendRedirect("/Servlet3");
```
浏览器允许的重定向次数有限。
#### 定时刷新
设置响应头的refresh值，可以实现定时刷新或跳转，如：
```JAVA
response.setHeader("refresh", "5;url=https://www.wangshaogang.com");
```
这个方法只能完成服务器端的跳转，不常用，如果要实现页面的动态效果，需要使用jQuery。
## 设置响应体
### 解决中文乱码问题
默认编码是iso8859-1，该码表中没有中文字符。
建议修改成UTF-8，要在获得PrintWriter对象之前设置编码，但是浏览器默认使用本地编码解码，即GBK，所以设置完后，还要告知客户端用UTF-8解码：
```JAVA
//response.setCharacterEncoding("UTF-8");
response.setHeader("Content-Type","text/html;charset=UTF-8");
```
第一句可以省略，因为服务器会自动设置UTF-8编码。
上面的第二行代码与下面这一行代码等价：
```JAVA
response.setContentType("text/html;charset=UTF-8");
```
### 打印文本
```JAVA
response.setContentType("text/html;charset=UTF-8");
PrintWriterwriter = response.getWriter();
writer.write("hello response!");
writer.write("你好！");
```
### 打印图片
```JAVA
// 获得字节输出流
ServletOutputStream outputStream = response.getOutputStream();
// 获得服务器上的图片
String realPath = this.getServletContext().getRealPath("a.jpg");// 通过相对路径获得绝对路径
InputStream inputStream = new FileInputStream(realPath);        // 这里的参数是绝对路径
int len = 0;
byte[] buffer = new byte[1024]; //每次输出1024个字节
while ((len = inputStream.read(buffer))>0) {
	outputStream.write(buffer, 0, len);
}
inputStream.close();  //关闭资源
outputStream.close();
```
	
## 文件下载
如果用a标签指向文件地址，当浏览器不能解析时会下载，不同的浏览器情况不一样，例如Firefox、Chrome可以解析mp3、mp4，而IE不能，相同浏览器的不同版本情况也不一样。
在实际开发中，只要是下载的文件都要把链接指向Servlet，参数是文件名称，在Servlet中编写下载代码。
```JAVA
// 获取要下载的文件名称
String filename = request.getParameter("filename");
// 告诉客户端要下载的文件的类型，客户端通过文件的MIME类型去区分类型，MIME在Tomcat的全局配置文件中，也可以通过下面这种方法获取
response.setContentType(this.getServletContext().getMimeType(filename));    // getMimeType()方法的作用是通过我文件名获得MIME
// 告诉客户端该文件不是直接解析，而是以附件形式打开(下载)
response.setHeader("Content-Disposition", "attachment;filename="+filename); // 引号内是固定写法，引号内外filename意义不同
// 获得文件的绝对路径
String realPath = this.getServletContext().getRealPath("/download/" + filename);
// 获得该文件的输入流
InputStream inputStream = new FileInputStream(realPath);
// 通过response获得输出流，用于相对客户端写内容
ServletOutputStream outputStream = response.getOutputStream();
//文件拷贝的模板代码(可以封一个方法)
int len = 0;
byte[] buffer = new byte[1024];
while ((len = inputStream.read(buffer))>0) {
	outputStream.write(buffer, 0, len);
}
inputStream.close();    // 关闭资源
outputStream.close();
```
这段代码依然存在一定问题，当文件名存在中文时，由于编码问题，找不到下载地址。不同浏览器的解决方式不同，可以通过request获得请求头判断浏览器版本。
	
## 注意事项
①. response获得的流不需要手动关闭，Tomcat会帮我们关闭，但自己创建的流必须手动关闭。
②. getWriter和getOutputStream不能同时调用。
③. 重定向语句后面的代码不会被执行。