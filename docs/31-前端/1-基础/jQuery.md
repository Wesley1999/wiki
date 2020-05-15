# jQuery

## 简介
jQuery是目前最受欢迎的JavaScript库，也可以称为框架，兼容CSS3，简化HTML与JavaScript之间的操作，jQuery2.0之后不支持IE6/7/8。jQuery有详细的参考手册。
jQuery的加载比JavaScript的加载快，因为当整个dom树加载完毕就会加载jQuery，而当整个页面加载完毕才会加载JavaScript。

## 导入与加载函数
使用jQuery，第一步是导入jQuery的js文件，代码为：
```HTML
<script type="text/javascript" src="../../js/jquery-1.8.3.js"></script>
<!--第二个引号中是相对链接-->
```
所有的jQuery代码，都要写在加载函数中，加载函数的写法：
```HTML
$(function(){
	alert("hello jQuery")
});
```

## 选择器
### 基本选择器
jQuery的基本选择器跟CSS的基本选择器类似，有：

	id选择器：$("#id名称");
	元素选择器：$("element名称");
	类选择器：$(".class名称");
	所有元素选择器：$("*")
	
### 层级选择器
jQuery中的层级选择器很常用，有以下四种：

	所有后代节点：$("ancestor descendant")
	儿子节点：$("parent > child ")
	下一个相邻兄弟节点：$("prev + next")
	所有兄弟节点：$("prev ~ siblings")
### 属性选择器
	含有属性：$("元素[属性]")
	指定属性值：$("元素[属性=值]")
	不含指定属性值：$("元素[属性!=值]") //可以不含指定属性
	属性值以特定值开头：$("元素[属性^='开头值']")
	属性值以特定值结尾：$("元素[属性$='结尾值']")
	属性值中包含值：$("元素[属性*='包含的值']")
	复合属性：$("元素[属性条件1][属性条件2][...]")
		
## 过滤器
过滤器有些功能是重复的，也有些与选择器重复。
### 基本过滤器
	第一个元素：$('元素').first()
	最后一个元素：$('元素').last()
	去除指定元素：$("元素:not(:属性值)") //通常与其他过滤器嵌套
	第偶数个元素：$("元素:even")
	第奇数个元素：$("元素:odd")
	大于给定索引值的元素：$("元素:gt(值)")
	小于给定索引值的元素：$("元素:lt(值)")
	标题：$(":header")
### 内容过滤器
	元素包含给定文本：$("元素:contains('文本')")
	元素不包含文本：$("元素:empty")
	元素包含元素：$("元素:has(包含的元素)")
	元素包含子元素：$("元素:parent")
### 可见性过滤器
	元素可见：$("元素:visible")
	元素不可见：$("元素:hidden")
### 子元素过滤器
	第n个子或奇偶元素：$("元素:nth-child(n)") //n可以是数字也可以是even或odd
	唯一的子元素：$("元素:only-child") //只有当元素有位置子元素时才会匹配到
		
## 属性处理
	获取属性：$(元素).attr(属性)
	设置属性：$(元素).attr(属性,值)
	删除属性：$(元素).removeAttr(属性)
	添加类名：$(元素).removeAttr(类名)
	删除类名：$(元素).removeClass(类名) //可以不写参数，表示删除所有类
	获得属性的value值：$(元素).val()
	设置属性的value值：$(元素).val(值)
	获得属性的html代码：$(元素).html() //如果有标签，一并获得
	设置属性的html代码：$(元素).html(代码) //如果有标签，将其解析
	获得属性的文本：$(元素).text() //如果有标签，忽略
	设置属性的文本：$(元素).text(文本) //如果有标签，不解析直接输出
	
## 文档处理
	把元素B添加到元素A文本的末尾：$(元素A).append(元素B) //A可以匹配到多个
	把元素A添加到元素B文本的末尾：$(元素A).appendTo(元素B) //A可以匹配到多个
	把元素B添加到元素A文本的开头：$(元素A).prepend(元素B) //A可以匹配到多个
	把元素A添加到元素B文本的开头：$(元素A).prependTo(元素B) //A可以匹配到多个
	删除所有子节点：$(元 素).empty()
	删除元素：$(元素).remove() //标签也会被删除
	
## 事件
常用事件：

	blur( [fn] ) 
	focus( [fn] ) 
	change( [fn] ) 
	click( [fn] ) 
	dblcrlick( [fn] ) 
	mouseout(fn) 
	mouseover(fn) 
	submit( [fn] ) 
	
## 遍历
### 方式一
```javascript
$.each(数组, function(i, n){
	语句;
}); //i是索引，n是当前遍历到的对象
```
### 方式二
```javascript
$(元素).each(function(i){
	语句;
}); //i是索引，this是当前遍历到的对象，this是DOM对象而非jQuery对象
```
	
## 对象转换
JQ对象无法操作JS中的属性和方法，JS的DOM对象也无法操作JQ对象中的属性和方法，如果要使用，需要先转换。
### JQ对象转DOM对象
	方式一：$(this).get(0)
	方式二：$(this)[0]
以上两种方式等价，表示取得第0个元素
### DOM对象转JQ对象
	$(DOM对象)
	
## Validate插件
请参考：<https://github.com/wsg777/SearchStudents/blob/master/web/index.html>