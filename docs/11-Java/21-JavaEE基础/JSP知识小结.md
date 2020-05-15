# JSP知识小结

## 简介
jsp的本质是Servlet。
Servlet技术相当于在九java代码中嵌入html代码，确定是生成html页面的时候很繁琐。
jsp技术相当于在html中嵌入Java代码，输出html比较便捷，jsp可以完全代替servlet。

## jsp脚本和注释
### jsp脚本
`<%java代码%> `内部的java代码翻译到service方法的内部。
`<%=java变量或表达式>` 会被翻译到service方法out.print()的内部。
`<%!java代码%>` 会被翻译成servlet的成员的内容，Java方法必须写在这里，因为方法中不能有方法。
### jsp注释
不同的注释可见范围是不同。
Html注释：`<!--注释内容--> `可见范围：jsp源码、翻译后的servlet、HTML页面。                                                显示的html源码
java注释：`//单行注释`  `/*多行注释*/` 可见范围：jsp源码、翻译后的servlet。
jsp注释：`<%--注释内容--%>` 可见范围：jsp源码。

## jsp运行原理
第一次访问时，index.jsp被翻译成index_jsp.java(这个文件就是Servlet)，然后编译运行。
被翻译后的servlet在Tomcat的work目录中可以找到。
这个过程之所以能够完成，是因为Tomcat的配置文件把*.jsp后缀的请求映射给JspServlet处理。

## jsp指令
### page指令
格式：`<%@ page 属性名1= "属性值1" 属性名2= "属性值2" ...%>`
page指令的属性最多，但用的最少，实际开发中默认即可。
常用属性如下：

	language：jsp脚本中可以嵌入的语言种类
	pageEncoding：当前jsp文件的本身编码---内部可以包含contentType
	contentType：response.setContentType(text/html;charset=UTF-8)
	session：是否jsp在翻译时自动创建session
	import：导入java的包
	errorPage：指定当前页面出错后跳转到哪个页面
	isErrorPage：当前页面是一个处理错误的页面
	buffer：out缓冲区的大小
### include指令
include指令称为页面包含(静态包含)指令，可以将一个jsp页面包含到另一个jsp页面中，较常用。
格式：<%@ include file="被包含的文件地址"%>
### taglib指令
在jsp页面中引入标签库(jstl标签库、struts2标签库)，常用。
格式：`<%@ taglib uri="标签库地址" prefix="前缀"%>`
	
## jsp内置对象(隐式对象)
内置对象时能直接在脚本中使用的对象。
### out对象
out.write()方法，可以向页面输出内容。
向页面输出内容有以下四种方式：
```xml
<body>
	a
	<%
		out.write("b");
		response.getWriter().write("c");
	%>
	<%="d"%>
</body>
```
浏览器显示结果为：
```
c a b d
```
第1、2、4种方式都会把数据放到out缓冲区，第3种方式会把数据放到response缓冲区，交给Tomcat处理。Tomcat引擎会从response缓冲区获取内容，out缓冲区里的内容会被放到response缓冲区后面，所以用第三种方式输出的内容在前面。
out缓冲区的大小默认是8kb，可以通过修改page指令的buffer来修改out缓冲区的大小，如果修改为0kb，代表关闭out缓冲区，原本应该放到out缓冲区的内容会直接放到response缓冲区。
关闭out缓冲区后，对于上面的代码，浏览器会显示：

```
a b c d
```

### pageContext对象
pageContext对象是一个域对象，作用范围是当前页面，具有域对象共有的三个方法：

```java
setAttribute(String name, Object obj)
getAttribute(String name)
removeAttrbute(String name)
```

pageContext的内部维护着其他八大内置对象的索引，所以具有获得其他内置对象的方法，例如：

```java
pageContext.getRequest()
pageContext.getSession()
……
```
pageContext的强大之处不在于存取当前页面的属性，而在于可以向指定的其他域中存取数据。

```java
setAttribute(String name, Object obj, int scope)
getAttribute(String name, int scope)
removeAttrbute(String name, int scope)
```
这三个方法中，int scope是要操作的域，page域是PageContext.PAGE_SCOPE，request域是PageContext.REQUEST_SCOPE，session域是PageContext.SESSION_SCOPE，application域是PageContext.APPLICATION_SCOPE。

还有一个比较重要的方法：

```java
findAttribute(String name)
```
这个方法用来查询所有域中指定名称的数据，只会查询到一个数据，域作用范围小的优先级高，查询到一个数据就停止查询并将其作为返回值。

域作用范围排序：pageContext < request < session < application

示例：
```xml
<html>
<head>
	<title>context</title>
</head>
<body>
<%
	pageContext.setAttribute("name1","pageContext");
	request.setAttribute("name1","request");
	session.setAttribute("name2","session");
	request.getServletContext().setAttribute("name2","servletContext");

	out.println(pageContext.getAttribute("name1"));
	out.println(request.getAttribute("name1"));
	out.println(session.getAttribute("name2"));
	out.println(request.getServletContext().getAttribute("name2"));

	out.print("<br>------------------------------------------------------------------<br>");

	pageContext.setAttribute("name1","pageContext2",PageContext.PAGE_SCOPE);
	pageContext.setAttribute("name1","request2",PageContext.REQUEST_SCOPE);
	pageContext.setAttribute("name2","session2",PageContext.SESSION_SCOPE);
	pageContext.setAttribute("name2","servletContext2",PageContext.APPLICATION_SCOPE);

	out.println(pageContext.getAttribute("name1"));
	out.println(request.getAttribute("name1"));
	out.println(session.getAttribute("name2"));
	out.println(request.getServletContext().getAttribute("name2"));

	out.print("<br>------------------------------------------------------------------<br>");

	out.println(pageContext.findAttribute("name1"));
	out.println(pageContext.findAttribute("name2"));
%>
</body>
</html>
```
浏览器访问时显示：
```
pageContext request session servletContext 
------------------------------------------------------------------
pageContext2 request2 session2 servletContext2 
------------------------------------------------------------------
pageContext2 session2
```

### 其他内置对象
	request		   得到用户请求信息，与Servlet中基本相同
	response	   服务器向客户端的回应信息，与Servlet中基本相同
	config		   服务器配置，可以取得初始化参数，与Servlet中基本相同
	session		   用来保存用户的信息，与Servlet中基本相同
	application	   所有用户的共享信息，就是servletContext对象
	page	       当前页面转换后的Servlet类的实例，相当于this
	exception	   表示JSP页面所发生的异常，在错误页中才起作用，需要把page指令的isErrorPage属性设置为true

## jsp标签（动作）
### 页面包含（动态包含）
```xml
<jsp:include page="被包含的页面"/>
```
动态包含是分别编译的，在运行的阶段把输出的内容合并到一起，有两个文件。静态包含是将内容合并到一起，再编译运行，只有一个文件。
### 请求转发
```xml
<jsp:forward page="要转发的资源" />
```
与Servlet中基本相同。


​	
​	






