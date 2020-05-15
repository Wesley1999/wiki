# CSS

## 简介
HTML的功能足以确定网页中有哪些内容，但如果仅用HTML中的table标签进行布局，页面会存在许多缺陷，表格是固定不变的，样式也不够丰富。
CSS的主要功能就是设置页面的布局，设置页面元素样式等，弥补了HTML的一些不足，也取代了HTML的一些不好用的功能。
<!-- more -->
## 定义
>层叠样式表（英语：Cascading Style Sheets，简写CSS），又称串样式列表、级联样式表、串接样式表、阶层式样式表，一种用来为结构化文档（如HTML文档或XML应用）添加样式（字体、间距和颜色等）的计算机语言，由W3C定义和维护。目前最新版本是CSS2.1，为W3C的推荐标准。CSS3现在已被大部分现代浏览器支持，而下一版的CSS4仍在开发中。
>
>——维基百科

## 基本语法
```HTML
选择器{
	属性名1:属性值1;
	属性名2:属性值2;
	属性名3:属性值3;
}
```
分号可以省略，但不建议省略。


## 常用标签
### div标签
div是HTML的一个标签，一个块级元素（单独显示一行），单独使用没有任何意义，必须结合CSS来使用，用于页面的布局。
### span标签
span是HTML的一个标签，一个内联元素（显示一行），单独使用没有任何意义，必须结合CSS来使用，用于对括起来的内容进行样式修饰。

## 选择器
### 元素选择器
```HTML
<style type="text/css">
	div{
		font-size: 30px;
		color: pink;
	}
</style>
<div>
	示例11
</div>
<div>
	示例22
</div>
```
### 类选择器
```HTML
<style>
	.div2{
		font-size: 30px;
		color: orange;
	}
</style>
<div class="div2">
	示例33
</div>
<div class="div2">
	示例44
</div>
```
### id选择器
```HTML
<style>
	#div5{
		font-size: 30px;
		color: burlywood;
	}
</style>
</div>
<div id="div5">
	示例55
</div>
```
### 层级选择器
```HTML
<style>
	div p{
		font-size: 30px;
		color: green;
	}
</style>
<div>
	<p>
		示例66			
	</p>
</div>
```
### 属性选择器
```HTML
<style>
	input[type="text"]{
		background-color: green;
	}
	input[type="password"]{
		background-color: orange;
	}
</style>
<form>
	账号：<input type="text" /><br />
	密码：<input type="password" /><br />
</form>
```

## CSS引入方式
### 内部引入
```HTML
<style type="text/css">
	div{
		font-size: 30px;
		color: gray;
	}
</style>
```
### 行内引入
```HTML
<div style="font-size: 30px;color: royalblue;" >
	示例
</div>
```
### 外部引入
跟Java导入包类似，需要在head中添加以下内容：
```HTML
<link rel="stylesheet" href="外部引入.css" type="text/css" />
```
外部引入.css文件内容为内部引入的style标签中的内容。

## CSS浮动
结束条件：碰到边缘或碰到另一个浮动框。
属性：
|属性|值|作用|
|::|::|::|
|float|left/right等|向左/向右浮动|
|clear|both|清除两边的浮动|
	
浮动的框可以向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止。
由于浮动框不在文档的普通流中，所以文档的普通流中的块框表现得就像浮动框不存在一样。


## 间距
|名称|含义|
|::|::|
|padding|内容与边框的间距|
|border|边框的宽度|
|margin|边框与边框的间距|

	
## 其他常用属性
方块左右居中：margin: auto;
内容左右居中：text-align: center;
内容上下居中：line-height: 高度px;

## 注意事项
在一般的HTML标签中，像素值后面的px写不写都可以，但CSS样式中px不能省略。
