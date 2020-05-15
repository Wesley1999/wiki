# Servlet与ServletContext

## Servlet概念
Servlet是运行在服务器端的Java小程序，是sun公司提供的一套规范
Servlet是运行在服务器端的Java小程序，是sun公司提供的一套规范(接口)，用来处理客户端请求、响应给浏览器的动态资源，但Servlet的实质就是Java代码，通过Java的API动态地向客户端输出内容。使用servlet需要导入jar包，tomcat自带。

## Servlet的API
### Servlet接口中的方法
	init(ServletConfig config)
Servlet对象创建的时候执行。
ServletConfig 代表该Servlet对象的配置信息(例如Servlet配置文件的name)
servletConfig.getServletName()可以获得获得该Servlet的name
servletConfig.getInitParameter()可以获得该Servlet的初始化参数
servletConfig.getServletContext()可以获得Servletcontext对象

	service(ServletRequest request, ServletResponse response)
上面的代码每次请求都会执行。
每次访问service()方法都和创建一对新的request和response
ServletRequest 代表请求，内部封装的是http请求信息
ServletResponse 代表响应，内部封装的是http响应信息

	destroy()
上面的代码再Servlet对象销毁时执行。

### HttpServlet类中的方法
	init(ServletConfig config)
	doGet()
	doPost()
	destroy()
与Servlet接口中的方法类似，实际上service()方法也会在doGet()和doPost()中执行。HttpServlet类中的方法比Servlet接口中的方法更常用。

## Setvlet的生命周期
### 创建
默认第一次访问Servlet时创建该对象。
### 销毁
服务器关闭。
### 每次访问必然执行的方法
service(ServletRequest request, ServletResponse response)方法。

## web.xml的配置
### servlet的类的配置
```XML
<servlet>
	<servlet-name>abc</servlet-name>
	<servlet-class>com.wangshaogang.servlet.QuickStartServlet</servlet-class>
	<init-param>
		<param-name>url</param-name>
		<param-value>jdbc:mysql:///mydb</param-value>
	</init-param>
</servlet>
```
### servlet的虚拟路径的配置
```XML
<servlet-mapping>
	<servlet-name>abc</servlet-name>
	<!--1.完全匹配-->
	<url-pattern>/QuickStartServlet</url-pattern>
	<!--2.目录匹配-->
	<url-pattern>/aaa/*</url-pattern>
	<!--3.扩展名匹配，不能与目录匹配混用-->
	<url-pattern>*.wsg</url-pattern>
</servlet-mapping>
```
### 欢迎页的配置
```XML
<welcome-file-list>
	<welcome-file>11111.html</welcome-file>
	<welcome-file>index.jsp</welcome-file>
</welcome-file-list>
```
越靠上优先级越高，如果不配置，会用tomcat的全局欢迎页配置，index.jsp优先级最高。
### 修改servlet对象创建次序
在servlet的类的配置中加上```<load-on-startup>3</load-on-startup>```，中间的数字是优先级，越小优先级越高。
### 缺省servlet
在servlet的虚拟路径的配置中加上```<url-pattern>/</url-pattern>```，代表该servlet时缺省的servlet，当访问资源地址所有的servlet都不匹配时，缺省的servlet负责处理。
配置了缺省servlet以后不能访问静态html，因为这里配置的缺省servlet会覆盖tomcat的全局缺省servlet，只能把.html当成一个字符串，tomcat的全局缺省servlet才能访问静态html。
	
## ServletContext
ServletContext是一个web应用的上下文对象，内部封装的是该web应用的信息，一个web应用有一个ServletContext对象，一个web应用有多Servlet对象。
### 生命周期
创建：该web应用被加载(服务器启动时或在服务器启动的状态下发布应用)
销毁：该web应用被卸载(服务器关闭或从服务器中移除该web应用)
### 获得
```JAVA
ServletContext servletContext = config.getServletContext();
ServletContext servletContext = this.getServletContext();
```
建议使用第二种。
### 作用
#### 获得web应用全局初始化参数
在web.xml中配置，与servlet同级，如：
```XML
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
	 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	 xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
	 version="3.1">
	<context-param>
		<param-name>abcd</param-name>
		<param-value>1111</param-value>
	</context-param>
</web-app>
```
获得参数：
```JAVA
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	ServletContext context = this.getServletContext();
	String initParameter = context.getInitParameter("abcd");
	System.out.println(initParameter);
}
```
#### 获得web应用中任何资源的绝对路径(重要)
参数是相对WEB应用的相对路径。
```JAVA
String realPath_a = context.getRealPath("/a.txt");
String realPath_b = context.getRealPath("/WEB-INF/b.txt");
String realPath_c = context.getRealPath("/WEB-INF/classes/c.txt");
System.out.println(realPath_a);
System.out.println(realPath_b);
System.out.println(realPath_c);
```
控制台输出：
```
D:\Program Files\Apache Software Foundation\apache-tomcat-7.0.52\webapps\WEB13_2\a.txt
D:\Program Files\Apache Software Foundation\apache-tomcat-7.0.52\webapps\WEB13_2\WEB-INF\b.txt
D:\Program Files\Apache Software Foundation\apache-tomcat-7.0.52\webapps\WEB13_2\WEB-INF\classes\c.txt
D:\Program Files\Apache Software Foundation\apache-tomcat-7.0.52\webapps\WEB13_2\d.txt
```
获得绝对路径的方式只有两种，另一种方式是通过类加载器获得。

#### ServletContext是一个域对象(重要)
存储数据的区域就是域对象。利用ServletContext存储的数据是全局数据，可以避免页面刷新时servlet数据重置的问题。
存数据：
```JAVA
context.setAttribute("name","张三");
```
取数据：
```JAVA
Stringname=(String)this.getServletContext().getAttribute("name");
System.out.println(name);
```
控制台输出：
```
张三
```