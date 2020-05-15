# XML与反射

## 概念
XML全称是Extensible Markup Languange，意思是可扩展的标记语言，XML语法与HTML类似，但HTML中的元素是固定的，而XML的标签是可以由用户自定义的。XML不是对HTML的体代，而是对HTML的补充。XML设计的宗旨是传输数据，但现在传输数据一般用JSON，XML主要用于配置文件，还有时候用于存放数据。XML有1.0和1.1版本，由于1.1版本不能向下兼容，所以没有得到推广，现在用的都是1.0版本。

## 语法
XML的属性值必须加引号，标签区分大小写。格式良好的xml文件，只有一个根元素。
在XML中，有五个预定义的实体引用：

|实体引用|含义|
|:-:|:-:|
|`&lt;`|`<`|
|`&gt;`|`>`|
|`&amp;`|`&`|
|`&apos;`|`'`|
|`&apos;`|`"`|


虽然只有<和&是非法的，但用实体引用来代替那些符号是个好习惯。
如果有大量非法符号，可以放在CDATA区：
```XML
<![CDATA[
	任意内容
]]>
```

XML文档声明：
```XML
<?xml version="1.0" encoding="UTF-8" ?>
```
version是必需的，encoding非必需。

## 约束
### DTD约束
DTD(Document Type Definition)，文档类型定义，用来约束XML文档。规定XML文档中元素的名称，子元素的名称及顺序，元素的属性等。
开发中通常采用框架提供的DTD约束文档编写对应的XML文档，常用框架使用DTD约束有：structs2、hibernate、spring等。
DTD中，用元素描述来限制元素出现的次数和顺序，有以下几种：

|符号|含义|
|:-:|:-:|
|`?`|最多出现一次|
|`*`|可以出现任意次|
|`+`|至少出现一次|
|`()`|用来给元素分组|
|`|`|两边任选其一，必须出现其中一个|
|`,`|按指定顺序出现|
|无|必须出现一次|


引入DTD有两种形式：

|形式|引入语法|存放位置|
|:--------:|:--------:|:------:|
|本地|```<!DOCTYPE web-app SYSTEM "文件名.dtd">```|存放在本地系统上|
|网络|```<!DOCTYPE web-app PUBLIC"地址">```|存放在网络上，一般由框架提供，一次联网就会缓存到项目中|

### Schema约束
Schema是新的XMl文档约束，是DTD的替代者，比DTD强大的多，数据类型很丰富，支持名称空间(可以区分同样的属性)，扩展名是xsd。
实际开发基本不需要看Scheme约束文档。

## XML解析
解析器：就是根据不同的解析方式提供的具体实现。有的解析器过于繁琐，为了方便开发人员，有提供易于操作的解析开发包。
解析方式(理论)有三种：DOM、SAX、PULL
常见的解析开发包：
|解析包|简介|
|:--------:|:--------:|
|JAXP|sun公司支持DOM和SAX开发包|
|JDom|dom4j兄弟，基本被替代|
|jsoup|一种处理HTML特定解析开发包|
|dom4j|比较常用的解析开发包，hibernate底层采用|

## dom4j
如果需要使用dom4j，必须导入jar包。
dom4j必须使用核心类SaxReader加载xml文档获得Document，通过Document对象获得文档的根元素，然后就可以操作了。这个步骤很重要。
常用API如下：
### SaxReader对象
	read(绝对路径) 加载xml文档
### Document对象
	getRootElement() 获得根节点
### Element对象
	elements(名称) 	  	 	 获得指定名称的所有子元素
	element(名称) 	  	 	 获得指定名称的第一个子元素
	attributeValue(属性名称)   获得指定属性名的属性值
	getName() 		  	 	  获得当前元素的元素名
	getText() 		  	 	  获得当前元素的文本内容

## 反射
JAVA反射机制是在运行状态中，对于任意一个类，都能够知道这个类的所有属性和方法，对于任意一个对象，都能够调用它的任意一个方法和属性。
应用程序已经在运行，代码加载到内存，不能再new对象。此时可以根据配置文件的类全名(带包名)找到对应的字节码文件，加载进内存，创建该类的实例，访问其中的属性和方法。
### 获取字节码文件
获取字节码文件Class对象的方式有三种：
```JAVA
// 1
Person p = new Person();
Class c1 = p.getClass;
// 2
Class c2 = Person.class;
// 3
Class c3 = Class.forName("com.wangshaogang.web.servlet1.MyServlet1");
```
前两种都不方便，因为要用到该类，而执行在运行过程中不能直接使用该类。第三种只需要知道类全名即可，JDBC操作中，注册驱动用到的就是第三种方法。
类全名可以写到配置文件(xml、properties等)中，解析配置文件获取，作为参数进行传递，这样提高了程序的扩展性。
	
### 创建对象
获得字节码后，可以用newInstance()方法完成对象的创建，参数是构造方法的参数，如：
```JAVA
MyServlet myServlet = (MyServlet) c3.newInstance();  // 这里使用的是无参构造方法
```
### 获取字节码中的字段和方法
getDeclaredField()方法可以获得所有属性，包括私有，getField()方法可以获得公共属性，如：
```JAVA
Field field = c3.getDeclaredField("age");
```
如果要操作私有字段，需要用setAccessible方法：
```JAVA
field.setAccessible(true); // 暴力访问，不建议使用
field.set(obj, 789);
```
getMethod()方法可以获得公共方法，参数为方法名和当前方法的参数，如：
```JAVA
Method method = c3.getMethod("staticShow",null);
```
invoke()可以让指定对象调用方法，参数是对象和参数组，如：
```JAVA
Object obj = c3.newInstance();
method.invoke(obj, null);
```