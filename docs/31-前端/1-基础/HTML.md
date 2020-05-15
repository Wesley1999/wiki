# HTML

## 定义

>超文本标记语言（英语：HyperText Markup Language，简称：HTML）是一种用于创建网页的标准标记语言。 HTML是一种基础技术，常与CSS、JavaScript一起被众多网站用于设计令人赏心悦目的网页、网页应用程序以及移动应用程序的用户界面。
>
>——维基百科

## 简介
HTML代码比较简单，很快就能学会，可以轻松阅读。HTML的编辑工具起点很低，用记事本都可以完成。HTML文件有两种格式，分别是.html和.htm，目前后者更常用，.htm后缀的出现是因为以前有些软件仅支持三字节的后缀，但现在不存在这样的问题。
与JSP相比，HTML页面简单的多。JSP文件需要先编译成servlet程序，再编译成.class文件，再生成HTML文件返回给浏览器。而HTML页面则无需编译，可以直接让浏览器阅读。两者用途不同，没有好坏之分。

## 简单标签
HTML中所有的代码都是以标签的形式展现出来的，下面介绍一些常用的简单标签。
### 标题标签
```HTML
<hn></hn>
```
n为1到6的数字，1最大，6最小，超过6的数字会被当作6。

### 注释标签
```HTML
<!--注释内容--> 
```

### 换行标签
```HTML
<br /> 
```

### 水平线标签
```HTML
<hr />
```
水平线也可设置高度、颜色、阴影属性。

### 段落标签
```HTML
<p>段落内容</p>
```

### 字体标签
HTML的字体标签**不推荐**使用。
```HTML
<font color="颜色代码" size="尺寸代码" face="字体代码">文字</font>
```

### 斜体标签
```HTML
<i>斜体文字</i>
```

### 粗体标签
```HTML
<b>粗体文字</b>
```

### 图片标签
```HTML
<img src="图片地址" width="宽度" height="高度" alt="无法正常显示时的提示信息"/>
```
如果不设置width和height的大小，默认显示图片的真实大小；
如果只设置width或height其中的一个，另一个会按比例自动缩放；
如果设置width和height，指定图片的大小。
图片地址中，../表示当前目录的上级目录，./表示当前目录。

### 超链接标签
```HTML
<a href="超链接地址" target="当前页面or新页面or自定义">显示的文字</a>
```
超链接地址可以是绝对地址也可以是相对地址，绝对地址前面的http不能省略。


## 列表标签
### 无序列表标签
```HTML
<ur type="样式名称"></ur>
```
样式一般不在这里设计，在 css中设计。

### 有序列表标签
```HTML
<or type="序号样式名称" start="起始数字" reversed="顺序or倒序"></or>
```

### 列表的项
```HTML
<li></li>
```


## 表格标签
HTML的表格布局存在一定缺陷，现在一般使用DIV+CSS布局。
```HTML
<table border="边框宽度" width="宽度" height="高度" align="位置" bgcolor="背景色 "cellspacing="单元格与单元格间距" cellpadding="单元格与内容间距"></table>
```
没有border属性表示没有边框，没有width和height属性默认与内容一致。

### 行标签
```HTML
<tr></tr>
```

### 列标签
```HTML
<td></td>
```

tr标签在table标签中，td标签在tr标签中。tr和td属性也有与table类似的属性，内部的优先级高，也有些数值大的优先级高。


### 表格合并
#### 跨列
```HTML
colspan="跨列数"
```

#### 跨行
```HTML
rowspan="跨行数"
```

### 表头
表格也可以有更复杂的结构，有表头的表格是这样的：
```HTML
<table>
	<thead>
		<tr>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td></td>
		</tr>
	</tbody>
</table>
```

## 表单标签
```HTML
<form action="提交地址" method="提交方式"> <form>
```
### 隐藏字段
```HTML
<input type="hidden" name="名称" />
```
### 文本
```HTML
<input type="text" name="名称" size="宽度" maxlength="最大填充字数" placeholder="提示信息 " />
```
#### 文本的其他属性
|属性|功能|
|:--:|:--:|
|readonly="readonly"|只读|
|value="默认"|默认填充内容|
|required="required"|要求必填|
|id="值" |供js获取元素使用|


### 密码
```HTML
<input type="password" name="名称" />
```
### 单选
```HTML
<input type="radio" name="名称" value="值" checked="checked" />选项1
<input type="radio" name="名称" value="值" />选项2
```
checked="checked"属性的作用是默认勾选。

### 复选
```HTML
<input type="checkbox" name="名称" value="值" select="select" />选项1
<input type="checkbox" name="名称" value="值" select="select" />选项2
<input type="checkbox" name="名称" value="值" />选项3
```
select="select"属性的作用是默认勾选。

### 下拉
```HTML
<select name="名称">
	<option value="值" select="select">选项1</option>
	<option value="值">选项2</option>
	<option value="值">选项3</option>
	<option value="值">选项4</option>
</select>
```
select="select"属性的作用是默认选中。

### 文件
```HTML
input type="file" name="名称" />
```
### 长文本
```HTML
<textarea name="名称"></textarea>
```
### 提交按钮
```HTML
<input type="submit" value="按钮名称" />
```
### 重置按钮
```HTML
<input type="button" value="按钮名称" />
```
### 普通按钮
```HTML
<input type="reset" value="按钮名称" />
```


## 框架集结构标签(不常用)

框架集结构标签不能放在body标签中。
### 水平划分标签
```HTML
<frameset cols="左百分比,*">
    <frame src="左链接" />
    <frame src="右链接" />
    <!--或
	    <frame name="超链接target属性中的自定义" />
	-->
</frameset>
```

### 垂直划分标签
```HTML
<frameset rows="上百分比,*">
    <frame src="上链接" />
    <frame src="下链接" />
    <!--或
	    <frame name="超链接target属性中的自定义" />
	-->
</frameset>
```