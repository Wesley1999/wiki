# JavaScript

## 简介
JavaScript在网页中的作用就是让整个页面具有动态效果。

## 组成部分
ECMAScript：它是整个JavaScript的核心，包含基本语法、变量、关键字、保留字、数据类型、语句、函数等。
DOM：文档对象模型，包含整个html页面的内容。
BOM：浏览器对象模型，包含整个浏览器相关内容。

## ECMAScript
大部分内容和Java相同，例如大小写、注释等，下面主要列举不同之处。
### 变量
JavaScript中的变量是弱类型，定义变量只用var运算符。定义后没有类型，初始化后才有类型，重新赋值可以改变类型。
变量定义不是必须的，在函数作用域内用var定义的变量是局部变量，不定义直接使用的变量全局变量。
### 数据类型
JavaScript的数据类型有：string、number、boolean、null、undefined、数组、对象，调用typeof运算符，null类型的返回值是object，这是JavaScript最初实现中的一个错误，但至今没有改正 ，为解释这一错误，null被认为是对象的占位符。创建的boolean类型默认值为false。
### 语法
JavaScript中每行最后的分号可有可无，建议写上。
### 等号
	=：赋值
	==：尝试转换类型后相等返回true，例如"6"==6的返回值是true，相反运算符为!=
	===：不转换类型相等返回true，相反运算符为!==
此外JavaScript可以用 == 判断字符串是否相等，而Java中用 == 判断的是字符串地址是否相同。

## 内置对象
### Array对象
长度可变，长度=**最大角标**+1。
数组的创建：
```javascript
new Array();
new Array(size);
new Array(element0,element1,…,elementn);
```
数组的连接：
```javascript
var a= [1,2,3];
document.write(a.concat(4,5));
```
数组的分隔：
```javascript
arr.join(".");  //把小数点插入到每个元素之间
```
### Date对象
```javascript
getTime()
```
返回1970年1月1日至今的毫秒数。用于解决浏览器缓存问题。

### Math、Number对象
与Java基本一致。

### String对象
match() 	 用于正则匹配
substr() 	从起始索引号提取字符串中指定数目的字符
substring()  提起字符串中两个指定的索引号之间的字符，含头不含尾

### RegeExp对象(正则)
test() 	检索字符串中指定的值，返回true或false。

使用正则表达式的语句为：
```javascript
/正则表达式/.test(值)
```
满足条件则返回值为true。

## 全局函数
全局函数不用创建，可直接使用。

	decodeURI()				解码某个编码的 URI。
	decodeURIComponent()	解码一个编码的 URI 组件。
	encodeURI()				把字符串编码为 URl(斜杠、冒号不会转码)。
	encodeURIComponent()	把字符串编码为 URI 组件(斜杠、冒号会转码)。
	eval()					计算 JavaScript 字符串，并把它作为脚本代码来执行。
	parseFloat()			解析一个字符串并返回一个浮点数。
	parseInt()				解析一个字符串并返回一个整数(默认十进制，第二个参数可指定进制数)。


## DOM常用对象
	Document	整个html文件都成为一个document文档
	Element	    所有的标签都是Element元素
	Attribute	标签里面的属性
	Text		标签中间夹着的内容为text文本
	Node        document、element、attribute、text统称为节点node

### Document对象
每个载入浏览器的HTML文档都会成为Document对象。

	document.getElementById()		  返回对拥有指定 id 的第一个对象的引用。
	document.getElementsByName()	  返回带有指定名称的对象集合。
	document.getElementsByTagName()	  返回带有指定标签名的对象集合。
	
后面两个方法获取之后需要遍历。
以下两个方法很重要，但是在手册中查不到。

	document.createTextNode()	创建文本节点
	document.createElement()	创建元素节点

### Element对象
	element.appendChild()	 向元素添加新的子节点，作为最后一个子节点。
	element.firstChild		 返回元素的首个子节点。
	element.getAttribute()	 返回元素节点的指定属性值。
	element.innerHTML		 设置或返回元素的内容。
	element.insertBefore()	 在指定的已有的子节点之前插入新节点。
	element.lastChild		 返回元素的最后一个子元素。
	element.setAttribute()	 把指定属性设置或更改为指定值。
	element.removeChild()	 从元素中移除子节点。
	element.replaceChild()	 替换元素中的子节点。

### Attribute对象
	attr.value	设置或返回属性的值。

## BOM常用对象
### Window对象
	alert()			显示带有一段消息和一个确认按钮的警告框。
	clearInterval()	取消由 setInterval() 设置的 timeout。
	clearTimeout()	取消由 setTimeout() 方法设置的 timeout。
	confirm()		显示带有一段消息以及确认按钮和取消按钮的对话框。
	prompt()		显示可提示用户输入的对话框。
	setInterval()	按照指定的周期（以毫秒计）来调用函数或计算表达式。
	setTimeout()	在指定的毫秒数后调用函数或计算表达式。
定时操作方法setInterval()有返回值，返回值可以作为清除定时操作方法clearInterval()的参数setTimeout()类似。
使用Bowsers对象Window中的方法时，可以省略window。
### History对象
	back()	    加载 history 列表中的前一个 URL。
	forward()	加载 history 列表中的下一个 URL。
	go()	    加载 history 列表中的某个具体页面。
go()方法需要指定参数，可以跳转到前后任意一个页面。

### Location对象
跳转页面：location.href='跳转地址'

## 事件
	表单提交事件：onsubmit()，只能写在form标签中，必须有返回值，用来确定是否提交
	页面加载事件：onload()，只能写一直并且放在body标签中，
	点击事件：onclick()
	聚焦事件：onfacus()
	离焦事件：onblur()
	鼠标移上：onmouseover()
	鼠标移开：onmouseout()
	内容改变：onchange()

## 输出
	弹窗：alert();
	向页面指定位置写入内容：innerHTML();
	向页面写入内容：document.write(内容);

## 引入方式
### 内部引入
```HTML
<script>
	function clk2(){
		history.forward();
	}
</script>
```
### 行内引入
行内引入仅适用于代码很少的情况
```HTML
<input type="button" value="下一页" onclick="javascript:history.forward()" />
```

### 外部引入
跟Java导入包类似，需要在head中添加：
```HTML
<script type="text/javascript" src="外部引入.js"></script>
```
外部引入.js文件内容为内部引入的script标签中的内容。

## 应用
表单校验(实施校验和提交校验)、轮播图、弹出广告、列表动态添加、触碰高亮、表单二级联动等。