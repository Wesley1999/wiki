# EL与JSTL

## el简介
EL（Express Lanuage）表达式可以嵌入在jsp页面内部，减少jsp脚本的编写，EL出现的目的是替代jsp页面中脚本的编写，但逻辑代码无法通过el实现。使用el不需要导入jar包。
## el从域中取数据
EL最主要的作用是获得四大域中的数据，格式：

	${EL表达式}
EL获得pageContext域中的值：${pageScope.key}
EL获得request域中的值：${requestScope.key}
EL获得session域中的值：${sessionScope.key}
EL获得application域中的值：${applicationScope.key}
EL从四个域中获得某个值，从小到大查找，找到一个后不在查找：${key}
测试：
```JSP
<body>
	<%--存域中的数据--%>
	<%
		//存储字符串
		request.setAttribute("company","wsg");
		//存储一个对象
		User user = new User();
		user.setId(1);
		user.setName("zhangsan");
		user.setPassword("123");
		session.setAttribute("user", user);
		//存储一个集合
		List<User> list = new ArrayList<User>();
		User user1 = new User();
		user1.setId(2);
		user1.setName("lisi");
		user1.setPassword("123");
		list.add(user1);
		User user2 = new User();
		user2.setId(3);
		user2.setName("wangwu");
		user2.setPassword("123");
		list.add(user2);
		application.setAttribute("list", list);

	%>
	<%--用jsp脚本取域中的值--%>
	<%=request.getAttribute("company")%>
	<%
		User user3 = (User) session.getAttribute("user");
		out.write(user3.getName());
	%>
	<hr>

	<%--用el表达式取域中的值--%>
	${requestScope.company}
	${sessionScope.user.name}
	${applicationScope.list[1].name}    <%--取第二个元素的name--%>
	<hr>
	<%--使用el表达式全域查找--%>
	${company}
	${user.name}
	${list[1].name}
	<hr>
</body>
```
浏览器输出：
```
wsg zhangsan
wsg zhangsan wangwu
wsg zhangsan wangwu
```

## el的内置对象
jsp诞生初期，完全替代了servlet，el的作用就是弥补jsp传输数据的不便。但现在的web开发，jsp退化为显示工具，不传输数据，所以除pageContext外的el内置对象不常用。
el共有11个内置对象：

|内置对象|作用|
|:------:|:------:|
|pageScope，requestScope，sessionScope，applicationScope|用于获取JSP中域中的数据|
|param，paramValues|用于接收参数，相当于request.getParameter()和rquest.getParameterValues()|
|header，headerValues|用于获取请求头信息，相当于request.getHeader(name)|
|initParam|获取全局初始化参数，相当于this.getServletContext().getInitParameter(name)|
|cookie|用于获取cookie，比脚本中遍历获取cookie简单得多，但依然不常用|
|pageContext|相当于jsp的内置对象pageContext，可以获得jsp的其他八大内置对象，较重要|

**${pageContext.request.contextPath}是获取项目名称的表达式，可以写在提交表单或跳转的链接中，避免修改项目名导致链接失效的问题，这个表达式很常用。**

### EL执行表达式
el可以执行有结果的表达式运算，例如：
`${1+1} `输出运算结果
`${user==null?true:false} `输出三目运算结果
`${empty user} `判断对象是否为null，是：true，否：flase，空串视为null。

## jstl简介
JSTL（JSP Standard Tag Library)，JSP标准标签库，可以嵌入在jsp页面中使用标签的形式完成业务逻辑等功能。JSTL标准标签库有5个子库，目前常使用的是核心库Core。使用jstl1.1.2版本需要导入jstl.jar和standard.jar两个jar包，1.2版本只用导一个包。
## jstl的if标签
```xml
<c:if test="布尔对象">
	满足条件显示的内容
</c:if>
```
if标签模拟的就是java中的if语句，test中是布尔类的的值，可以是true或flase。布尔表达式不能直接解析，解析布尔表达式主要借助el表达式，jstl表达式一般都会配合el表达式使用。
用于页面显示判断，例如未登录的用户显示注册和登录，登录的用户显示昵称和注销。

## jstl的foreach标签
```xml
<c:forEach begin="" end="" var="">
	循环体
</c:forEach>
```
foreach标签有两种形式，这种形式模拟的是普通for循环，begin中是初始值，end中是结束值，var中是当前值。
下面是更常用的另一种形式：
```xml
<c:forEach items="" var="">
	循环体
</c:forEach>
```
这种形式模拟加强for循环，items中是一个集合或数据，通常与el表达式结合，var代表集合或数组中的某一个元素。