# Ajax技术

## Ajax

[toc]

### 概念
Ajax全称是Asynchronous JavaScript and XML，异步JavaScript 与XML技术。使用ajax技术，页面发起请求，会将请求发送给浏览器内核中的Ajax引擎，Ajax引擎会提交请求到服务器端，在这段时间里，客户端可以任意进行任意操作，直到服务器端将数据返回。如果不用ajax技术，客户端发送请求到服务器端，当服务器返回响应之前，客户端都处于等待，不能进行其他操作。

### JavaScript的原生Ajax技术
#### 步骤
##### 创建Ajax引擎对象
对于绝大多数浏览器，是：
```javascript
var xmlhttp = new XMLHttpRequest();
```
IE5、IE6与其他浏览器创建Ajax引擎对象的方式不同，是：
```javascript
variable=new ActiveXObject("Microsoft.XMLHTTP");
```
现在的开发一般不考虑IE5和IE6的特殊情况。我最初学JavaEE的教材，却是以IE5、IE6为主讲解的，坑死人。
#### 为Ajax引擎对象绑定监听
```javascript
xmlhttp.onreadystatechange = function () {
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		接受响应数据代码
	}
}
```
当readyState改变时，触发该事件，readyState有5种：

|readyState|含义|
|:------:|:------:|
|0|请求未初始化|
|1|服务器连接已建立|
|2|请求已接收|
|3|请求处理中|
|4|请求已完成，且响应已就绪|

##### 绑定提交地址
```javascript
xmlhttp.open("GET","${pageContext.request.contextPath}/ajax",true);
```
第一个参数是请求方式，第二个参数是请求提交地址，第三个参数true表示异步请求，false表示同步请求。
如果请求方式是get，参数应该放在第二个参数中，如果请求方式是post，参数应该放在发送请求的参数中。
#### 发送请求
如果是post请求，在发送请求前要设置一个头：
```javascript
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
```
发送请求代码：
```javascript
xmlhttp.send();
```
参数是post请求表单提交的参数。
#### 接受响应数据
接受响应数据代码要写在监听监听器触发的事件中，并且当readyState为4，状态码为200时执行，例如：
```javascript
var res = xmlhttp.responseText;
document.getElementById("span1").innerHTML=res;
```
#### 示例
```JavaScript
function clk1() {
	// 1.创建引擎对象
	var xmlhttp = new XMLHttpRequest();
	// 2.绑定监听
	xmlhttp.onreadystatechange = function () {
		//5. 接受响应数据
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var res = xmlhttp.responseText;
			document.getElementById("span1").innerHTML=res;
		}
	}
	// 3.绑定地址
	xmlhttp.open("GET","${pageContext.request.contextPath}/ajax",true);
	// 4.发送请求
	xmlhttp.send();
}
```
### 基于jQuery的Ajax技术
#### $.get()方法
`$.get(url, [data], [callback], [type])`方法有四个参数，第一个必需，后三个可选。
第一个参数是待载入页面的URL地址，就是要用Ajax把请求提交到的地址。
第二个参数是要提交的请求附带的参数，以键值对的形式书写，即json数据格式。
第三个参数是载入成功时的回调函数，该回调函数的参数是doget()方法的返回值，即本该向页面输出的内容。
第四个参数用于指定doget()方法的返回值默认为text，如果是json会自动解析。
需要注意，json中的双引号不能不能因放在Java字符串中而改成单引号，只能在双引号前加反斜杠将其转义。
```JavaScript
<script>
	//get异步访问
	function clk1(){
		$.get(
				"/ajax2",
				{"name":"王少刚","age":18},
				function(data){
					alert(data.name);
				},
				"json"
		);
	}
</script>
```

#### $.post()方法与编码问题
如果请求提交的参数是英文，那么$.post()与$.get()方法在实际应用中几乎没有区别。如果提交的参数包含中文，会有这样的现象：

	①. 请求和响应均不做任何处理时，post请求在控制台输出不乱码，在页面输出乱码；get请求在控制台输出乱码，在页面输出不乱码。
	②. 将请求用ios8859-1解码再用UTF-8编码，响应设置为UTF-8编码时，get请求在控制台和页面输出都无不乱码；post请求在控制台和页面都乱码。这说明对于get请求，这样的处理方式是正确的。
	③. 将请求用ios8859-1解码再用UTF-8编码，仅将get请求的响应设置都为UTF-8编码时，现象与第二种情况完全相同。
	④. 仅将get请求用ios8859-1解码再用UTF-8编码，将get请求和post请求的响应均设置为UTF-8编码时，所有的输出都不乱码。
以上现象出现的原因是jQuery的$.get()方法内部没有将请求处理为UTF-8编码，须要用常规的方式处理乱码问题。而$.post()方法内部已经将请求处理为UTF-8编码了，所以只需要把响应设置为UTF-8编码，自作多情地去对请求编码再解码反而会出现问题。
	
#### $.ajax()方法（常用）
$.ajax( { option1:value1,option2:value2... } )方法比前两个有更丰富的功能，参数以键值对的形式出现。
常用的option有如下：

|option|含义|
|:------:|:------:|
|async|是否异步，默认是true代表异步|
|data|发送到服务器的参数，建议使用json格式|
|dataType|服务器端返回的数据类型，常用text和json|
|success|成功响应执行的函数，对应的类型是function类型|
|success|请求方式，POST/GET|
|url|请求服务器端地址|

**value有些必须带引号，有些不能带引号。**

```JavaScript
<script>
	//ajax异步访问
	function clk3() {
		$.ajax(
			{
				async: true,
				data: {"name": "王少刚", "age": 18},
				type: "get",
				url:"/ajax2",
				dataType:"json",
				success: function(data){
					alert(data.name);
				},
				error: function(){
					alert("请求失败！");
				}
			}
		);
	}
</script>
```