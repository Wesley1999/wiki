# Cookie与Session

[toc]

## 会话的概念
从进入站点 ，到关闭客户端，称为一次会话。
个人经验：Chrome浏览器如果设置“启动时从上次停下的地方继续”，视为永远不结束会话。
会话技术分为Cookie和Session：
Cookie：数据存储在客户端本地，减少服务器端的存储的压力，安全性不好，客户端    可以清除cookie
Session：将数据存储到服务器端，安全性相对好，增加服务器的压力

## 操作cookie
### 创建与发送Cookie对象
```JAVA
// 创建cookie
Cookie cookie = new Cookie("name","zhangsan");
// 将cookie中存储的信息发送到客户端(在响应头中)
response.addCookie(cookie);
```
Cookie不支持中文。

### Cookie的持久化
Cookie默认是会话级别的，如果不设置持久化时间，Cookie会存储在浏览器的内存中，浏览器关闭，Cookie信息销毁，如果设置持久化时间，Cookie信息会被持久化到浏览器的磁盘文件里
设置Cookie的持久化时间：
```JAVA
cookie.setMaxAge(int seconds); 
```
参数单位是秒，但实际销毁时间不一定准确。

### 设置Cookie携带路径
如果不设置携带路径，那么该cookie信息会在访问产生该cookie的web资源所在的路径都携带Cookie信息(同级和同级的下级)。
```JAVA
cookie.setPath(String path); 
```
参数是指定要携带的路径，带项目名。如果只写项目名称，代表访问WEB应用中所有路径都携带Cookie。如果只写"/"，代表访问服务器中所有路径都携带cookie。

### 删除Cookie
如果要删除一个Cookie，可以设置一个同名Cookie，携带路径与创建的Cookie完全一致，持久化时间为0，再发送到客户端。
```JAVA
Cookie cookie = new Cookie("name","zhangsan");
cookie.setPath("/index.html");
cookie.setMaxAge(0);
response.addCookie(cookie);
```

### 获得Cookie
通过request获得所有的Cookie：
```JAVA
Cookie[] cookies = request.getCookies();
```
遍历Cookie数组，通过Cookie的名称获得我们想要的Cookie：
```JAVA
for(Cookie cookie : cookies){
	if(cookie.getName().equal(cookieName)){
		String cookieValue = cookie.getValue();
	}
}
```

## Session简介
Session技术是将数据存储在服务器端的技术，会为每个客户端都创建一块内存空间存储客户的数据，但客户端需要每次都携带一个标识ID去服务器中寻找属于自己的内存空间。所以说Session的实现是基于Cookie，Session需要借助于Cookie存储客户的唯一性标识JSESSIONID。
## 操作Session
### 获得Session对象
```JAVA
HttpSession session = request.getSession();
```
此方法看起来简单，其实底层很智能。调用该方法时，如果服务器端没有该会话的Session对象，会创建一个新的Session返回，如果已经有了属于该会话的Session，直接将已有的Session返回（实质就是根据JSESSIONID判断该客户端是否在服务器上已经存在session）。

### Session是域对象
session是一个域对象，具有域对象的三个共同方法：

	session.setAttribute(String name,Object obj)
	session.getAttribute(String name)
	session.removeAttribute(String name)

### 设置session过期时间
session的默认过期时间是30分钟，配置在Tomcat的全局配置文件中，不建议修改全局配置文件，如果要修改项目的session过期时间，可以在项目的web.xml中进行配置，中间的值单位是分钟。过期时间从不操作服务器端的资源开始计算。
```XML
<session-config>
	<session-timeout>30</session-timeout>
</session-config>
```

### Session对象的生命周期
#### 创建
第一次执行request.getSession()时创建。
#### 销毁
① 服务器非正常关闭时(停电、爆炸)
② session过期/失效（默认30分钟）
③ 手动销毁session：session.invalidate();
#### 作用范围
默认在一次会话中，也就是说在，一次会话中任何资源公用一个session对象。
### Session的持久化
Session编号的本质是Cookie，所以即使服务器上的Session对象不销毁，当用户结束会话时，JSESSIONID也会像Cookie一样默认被销毁，下次访问只能重新创建JSESSIONID。
如果要实现Session持久化，就要创建一个Cookie对象，存入JSESSIONID(名称必须完全一致)，并设置该Cookie对象的持久化时间，相应给客户端。
```JAVA
// 创建属于该客户端(回话)的私有的session区域
HttpSession session = request.getSession();
Cookie cookie = new Cookie("JSESSIONID", session.getId());
// 设置Cookie的持久化时间
cookie.setMaxAge(86400);    //一天
response.addCookie(cookie);
session.setAttribute("name","jerry");
```