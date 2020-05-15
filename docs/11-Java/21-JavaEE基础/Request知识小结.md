# Request知识小结

[toc]

## 获得请求行
### 获得客户端的请求方式
方法：String getMethod()
返回值是get或post。
### 获得请求的资源
	String getRequestURI() 一般指所有资源地址，网络、磁盘、绝对 、相对地址都可以叫URI
	StringBuffer getRequestURL() 一般指网络资源地址
	String getContextPath() 获取web应用的名称(重要)
	String getQueryString() get提交url地址后的参数字符串(几乎不用)
```JAVA
// 获得请求方式
String method = request.getMethod();
System.out.println("请求方式: "+method);
// 获得请求的资源相关的内容
String requestURI = request.getRequestURI();
StringBuffer requestURL = request.getRequestURL();
System.out.println("URI: "+requestURI);
System.out.println("URL: "+requestURL);
// 获得WEB应用名称
String contextPath = request.getContextPath();
System.out.println("WEB应用名称："+contextPath);
// 获得参数字符串
String queryString = request.getQueryString();
System.out.println("参数字符串: "+queryString);
```
浏览器访问http://localhost:8080/WEB15/LineServlet?aaa=1&bbb=2，控制台输出：
```
请求方式: GET
URI: /WEB15/LineServlet
URL: http://localhost:8080/WEB15/LineServlet
WEB应用名称：/WEB15
参数字符串: aaa=1&bbb=2
```
### 获得用户机信息
最常用的是获得用户IP的方法：
```java
request.getRemoteAddr();
```
	
## 获得请求头
	long getDateHeader(String name)
	String getHeader(String name) 最常用，通过名称获取值
	Enumeration getHeaderNames() 获得所有响应头的所有名称
	Enumeration getHeaders(String name) 可以获得多个相同名称的值
	int getIntHeader(String name)
```JAVA
// 获得指定头
String host = request.getHeader("Host");
System.out.println("host:"+host);
System.out.println("-----------------------------");
// 获得所有头名称
Enumeration<String> headerNames = request.getHeaderNames();
while (headerNames.hasMoreElements()) {
	String headerName = headerNames.nextElement();
	String headerValue = request.getHeader(headerName);
	System.out.println(headerName+":"+headerValue);
}
```
提交表单控制台输出：
```
host:localhost:8080
-----------------------------
host:localhost:8080
connection:keep-alive
content-length:25
cache-control:max-age=0
origin:http://localhost:8080
upgrade-insecure-requests:1
dnt:1
content-type:application/x-www-form-urlencoded
user-agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36
accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
referer:http://localhost:8080/WEB15/
accept-encoding:gzip, deflate, br
accept-language:zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7
cookie:JSESSIONID=7C52E1C86C5FBA55D6D551CC77F3E16F
```
响应头中的referer是来源，可以用于防盗链，原理是获取referer，如果地址不是以当前域名开头，就不能访问指定内容。


## 获得请求体
不论是get请求还是post请求，下面的方法一样适用，但处理中文乱码问题，步骤不同。

	request.getParameter() 通过参数名获得单个值，常用
	request.getParameterValues() 通过参数名获得多个值
	Enumeration getParameterNames() 获得所有不同参数名称，不常用
	Map<String,String[]> getParameterMap() 获得所有参数，封装到一个Map<String, String[]>中，可以与BeanUtils配合，常用。
### 直接获取值
// 通过参数名获得单个值
```JAVA
String username = request.getParameter("username");
String password = request.getParameter("password");
System.out.println(username);
System.out.println(password);
// 通过参数名获得多个值
String[] hobbies = request.getParameterValues("hobby");
for (String hobby : hobbies){
	System.out.println(hobby);
}
```
提交表单控制台输出：
```
1111
2222
zq
pq
```
### 封装到May中获取值
```JAVA
//  获得所有参数，封装到一个Map<String, String[]>中
Map<String, String[]> parameterMap = request.getParameterMap();
for (Map.Entry<String, String[]> entry: parameterMap.entrySet()) {
	System.out.print(entry.getKey()+":");
	for (String str: entry.getValue()) {
		System.out.print(str+" ");
	}
	System.out.println();
}
```
提交表单控制台输出：
```
username:1111 
password:2222 
hobby:basketball football 
```
### 解决中文乱码问题
#### post请求
```JAVA
request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username");
```
使用第一行代码，设置编码方式为UTF-8，然后获取参数即可，但这种方式仅适用post请求。
#### get请求
```JAVA
String username = request.getParameter("username");
username = new String(username.getBytes("iso8859-1"),"UTF-8");
```
解决get请求的中文乱码问题，需要先用iso8869-1编码获取参数，再用UTF-8解码，这种方式也适用post请求。

## request的其他功能
### 转发
转发是服务器内部的一个过程，一个Servlet向另一个Servlet请求资源，再响应给客户端。转发比重定向快，少一次网络传输过程，地址不变。
获得请求转发器，path是转发服务器端地址，不带项目名：

	RequestDispatcher requestDispatcher = request.getRequestDispatcher(String path);

通过转发器对象转发：

	requestDispathcer.forward(ServletRequest request, ServletResponse response);
	
### request是一个域对象
域对象，就是存储数据的一块区域，不同域对象的作用范围不同。
request对象是一个域对象，所以也具有如下方法：

	setAttribute(String name, Object o)
	getAttribute(String name)
	removeAttribute(String name)
request的作用范围是一次用户请求，访问时创建，响应结束时销毁。
```JAVA
@(4Java EE)WebServlet(name = "Servlet1", urlPatterns = "/Servlet1")
public class Servlet1 extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("name","Tom");
		// Servlet1将请求转发给Servlet2
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Servlet2");//参数是服务器端的地址
		// 执行转发的方法
		requestDispatcher.forward(request, response);
	}
…
}

@WebServlet(name = "Servlet2", urlPatterns = "/Servlet2")
public class Servlet2 extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//从域中取数据
		Object name = request.getAttribute("name");
		response.getWriter().write("Hello Servlet! My name is "+name+".");
	}
…
}
```
访问Servlet1，会显示Servlet2的内容，并且显示的是Servlet1的地址，Servlet1中向requsest存储的数据，Servlet2也能获取到。
	
	

