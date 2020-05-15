# Python数据采集

## 1.Beautiful Soup
>Beautiful Soup是一个Python包，功能包括解析HTML、XML文档、修复含有未闭合标签等错误的文档（此种文档常被称为tag soup）。这个扩展包为待解析的页面建立一棵树，以便提取其中的数据，这在网络数据采集时非常有用。
>
>——维基百科

### 1.1一个简单的示例
```Python
from urllib.request import urlopen
from bs4 import BeautifulSoup
html = urlopen("http://pythonscraping.com/pages/page1.html")
bsObj = BeautifulSoup(html.read(), "html.parser")
print(bsObj.h1)
```
运行这段程序，会自动查找从bsObj查找h1标签打印出来。

### 1.2函数find()和findAll()
find()返回的是BeautifulSoup对象，而findAll()返回的是一个BeautifulSoup对象组成的列表，即使只有一个BeautifulSoup对象。
两者的参数如下：
```Python
findAll(tag, attributes, recursive, text, limit, keywords)
find(tag, attributes, recursive, text, keywords)
```
find()等价于findAll()的limit参数为1的情况。
在绝大多数时候，只需要使用前两个参数tag和attributes，指定标签和参数。
tag可以是一个值，也可以是一个列表，attributes是一个字典。

向这两个函数传参，有两种形式：
```Python
bsObj.findAll(id="text")
bsObj.findAll("", {"id": "test"})
```
但是，class是Python的保留字，不能以第一种形式给出。

### 1.3指定查找的标签属性
```Python
nameList = bsObj.findAll("span", {"class": "green"})
```
上面的代码表示查找所有满足条件的span标签，条件是有"class"属性，值为"green"。

### 1.4去掉标签只保留文本
可以使用函数get_text()
for name in nameList:
    print(name.get_text())
通常，在准备打印、存储和操作数据时，才使用get_text()，在此之前应该尽可能地保留HTML文档的标签结构。

### 1.5BeautifulSoup对象
下面简称bsObj。
bsObj对象是整个HTML文档，可以通过这个对象调用函数find()、findAll()等，也可以直接调取子标签（非后代标签）获取的一列或单个对象，例如：
```Python
bsObj.div.h1
```

### 1.6其他对象（不常用）
NavigableString对象
用来表示标签里的文字，不是标签。
Comment对象
用来查找HTML文档里的注释。
```HTML
<!--这是注释-->
```

### 1.7处理相关标签
#### 1.7.1子标签和其他后代标签
.children函数可以获取一个节点的所有子标签。例如：
```Python
imgs = bsObj.find("table", {"id": "giftList"}).children
```
.descendants函数可以获取所有后代标签。
这两种方式返回的都是列表(?)，不是BeautifulSoup对象，不能对其继续使用find()等方法。
#### 1.7.2兄弟标签
.next_siblings函数可以获取所有的兄弟标签，列表类型，适用于BeautifulSoup对象，这在收集表格数据的时候非常方便，因为表格通常带有表头。例如：
```Python
imgs = bsObj.find("table", {"id": "giftList"}).tr.next_siblings
```
这个函数获取的是后面的所有兄弟标签，不包含自己和前面的兄弟标签。
.previous_siblings函数返回的是前面的所有兄弟标签。
还有这两个函数的单数形式：
.next_sibling
.previous_sibling
返回的是单个标签。
#### 1.7.3父标签（不常用）
用到.parent和.parents，略。

### 1.8获取属性
对于bsObj对象，对象.attr函数可以获取标签的全部属性值，对象.attr["属性"]可以获取指定属性值。获取图片地址，就是后者的应用：
```Python
image.attrs["src"]
```
上面的代码中.attrs可以省略。

### 1.9正则匹配
需要导入re库
```Python
import re
images = bsObj.findAll("img", {"src": re.compile("\.\.\/img\/gifts\/img.*\.jpg")})
```
其中re.compile("正则表达式")的作用就是匹配满足条件的值。
#### 1.9.1用正则替换字符（数据清洗）
```Python
input = re.sub('\n+', " ", input)
```

### 1.10Lambda表达式
BeautifulSoup允许我们把特定函数类型作为findAll()函数的参数，唯一的限制条件是这些函数必须把一个标签作为参数并且返回结果是布尔类型。
Lambda表达式可以作为正则的替代方案。


## 2.存储文件
### 2.1下载媒体文件
函数urlretrieve()，可以下载文件保存到运行程序的文件夹，第一个参数是地址，第二个参数是要保存的路径和文件名。
```Python
urlretrieve(r, filename=str(i) + '.html')
```
为安全起见，最好不要随意下载文件。

### 2.2数据存储到CSV文件
与写文件的基本方式相同。
```Python
## 使用CSV
import csv
csvFile = open("2_CSV/test.csv", 'w', newline='')
try:
    writer = csv.writer(csvFile)
    writer.writerow(('number', 'number plus 2', 'number times 2'))
    for i in range(10):
        writer.writerow((i, i+2, i*2))
finally:
    csvFile.close()
```
注意writerow后面要有两个括号。newline=''的作用时直接回车不换行。

### 2.3整合MySQL
与Java类似，Python操作MySQL，首先要导入PyMySQL库，再注册驱动，创建连接，执行SQL语句，处理结果集，最后关闭相应的对象。
```Python
## 使用MySQL
import pymysql
## 创建连接对象conn
conn = pymysql.connect(host='127.0.0.1', user='root', passwd='123456', db='python')
## 创建光标对象cur
cur = conn.cursor()
sql = "SELECT URI FROM baike LIMIT 5"
## 执行sql语句
cur.execute(sql)
## 获取结果集
rs = cur.fetchall()
for (r,) in rs:
    print(r)
## 关闭光标对象
cur.close()
## 关闭连接对象
conn.close()
```
#### 2.3.1处理结果集
只有数据库查询语句是会产生结果集的，获取结果集的函数有：
	fetchone(): 该方法获取下一个查询结果集。结果集是一个对象
	fetchall(): 接收全部的返回结果行.
	rowcount: 这是一个只读属性，并返回执行execute()方法后影响的行数。
#### 2.3.2提交事务
如果是更新而不是查询，就要提交事务：
```Python
conn.commit()
```


## 3.处理表单
### 3.1Request库
Request库是一个擅长处理复杂HTTP请求、cookie、header、header等内容的第三方库。

### 3.2提交表单
#### 3.2.1简单表单
如果要模拟提交表单的行为，就要保证变量名与字段名完全一一对应，即使字段被隐藏了。
提交post请求需要使用post()函数，第一个参数是请求要提交到的地址，data参数是提交的参数，以字典的形式给出。
r.text可以获取响应的内容。
```Python
import requests
params = {'firstname': 'shaogang', 'lastname': 'wang'}
r = requests.post("http://pythonscraping.com/pages/files/processing.php", data=params)
print(r.text)
```
#### 3.2.2复杂表单
对于单选按钮、复选框、下拉选框，无论表单的字段看起来多么复杂，**只需要提交字段和值即可**。
有些表单需要提交文件，但对网络数据采集而言，不太实用。

### 3.3处理cookie
现在的网站大多数会用cookie跟踪用户的登录状态信息，如果提交表单后进行访问不回传cookie，那么登录状态就会丢失。
登陆后，可以通过r.cookies获取cookie。如果要打印，可以将cookie转为字典形式：r.cookies.get_dict()。
在使用post函数时，cooies参数可以同时提交。例如：
```Python
## 提交表单
import requests
params = {'username': '911', 'password': 'password'}
r = requests.post("http://www.pythonscraping.com/pages/cookies/welcome.php", data=params)
print("Cookie is set to: " + str(r.cookies.get_dict()))
print("------------")
r = requests.post("http://pythonscraping.com/pages/cookies/profile.php", cookies=r.cookies)
print(r.text)
```

### 3.4Request对象转为BeautifulSoup对象
将Request对象r转为BeautifulSoup对象，可以使用下面的方式：
```Python
bsObj = BeautifulSoup(r.text, "lxml")
```
转换以后，就可以用BeautifulSoup来解析网页内容了。


## 4.处理JavaScript
有些页面，如果我们用传统的方法采集，只能获取加载完成前的信息，而我们真正需要的信息，却抓取不到，这就是使用了Ajax技术。
### 4.1Selenium库
用Selenium库可以很简单的使用浏览器来为我们加载动态内容，从而获取采集结果。
#### 4.1.1下载
Selenium不仅要下载库，还要下载对应浏览器的驱动，Chrome驱动的下载地址是：
https://sites.google.com/a/chromium.org/chromedriver/downloads
下载的exe文件，可以放到任意文件夹。

### 4.2Selenium执行JavaScript
```Python
## Selenium
from selenium import webdriver
import time
driver = webdriver.Chrome(r'M:\library\chromedriver\chromedriver.exe')
driver.get("http://120.79.60.89")
time.sleep(3)
print(driver.find_element_by_tag_name('div').text)
driver.close()
```
上面的代码中，webdriver.Chrome()用来创建Selenium对象，参数是驱动的路径。
driver.get()的参数是请求的地址，返回值是Selenium对象，可以用Selenium的选择器选择页面的元素，也可以将Selenium对象转为BeautifulSoup对象进行操作。
driver.close()用来将Selenium窗口关闭。

### 4.3Selenium选择器
Selenium对象的常用选择器（名称与JavaScript相似）：

	find_element_by_tag_name('div')
	find_element_by_css_selector("#content")
	find_elements_by_tag_name('div')
	find_elements_by_css_selector("#content")
后两个选择器的返回值是列表。

### 4.4Selenium对象转为BeautifulSoup对象
将Selenium对象转为BeautifulSoup对象的作用，就是用强大的BeautifulSoup库来解析网页内容。
WebDriver的page_source函数返回页面内容。例如：
```Python
pageSource = driver.page_source
bsObj = BeautifulSoup(pageSource)
```

## 5.避免错误
### 5.1定制请求头
urllib标准库的请求头会轻易被发现，但我们可以定制请求头。
请求头是一个字典，在请求时可以使用headers参数指定请求头。
如果没有特殊要求，请求头的内容可以与自己的浏览器一致，请求头中真正重要的参数是User-Agent。

### 5.2增加时间间隔
有些网站会阻止表单迅速提交，或者快速地与网站交互，对此，我们可以设置一定的时间间隔：
```Python
time.sleep(3)
```
设置时间间隔，也是一种节省服务器资源的行为。

### 5.3注意隐藏字段
有些表单会有隐藏的字段，如果不提交就会被发现不是人在访问。
还有些表单，显示出来的内容并非提交的内容，爬虫有时候会陷入这样的蜜罐圈套。

### 5.4403错误
IP是唯一不能伪造的信息。
出现403错误，说明网站已经把爬虫的IP放到网站黑名单了，不接受任何请求，解决方式是更换IP地址或等待IP地址从黑名单种移除。

### 5.5递归
递归的默认层数限制是1000，超过这个层数会导致递归栈溢出。
在可能出现问题的地方，要放置检查语句。


## 6.从入门到入狱
现在的个人电脑性能都比较强大，如果持续进行数据采集，可能会对网站造成沉重负担。恶意消耗别人网站的服务器资源是一件不道德的事，这种行为甚至会导致严重的法律后果。
我认为使用爬虫之前，有必要了解[《网络安全法》](https://baike.baidu.com/item/%E4%B8%AD%E5%8D%8E%E4%BA%BA%E6%B0%91%E5%85%B1%E5%92%8C%E5%9B%BD%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8%E6%B3%95/16843044?fromtitle=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8%E6%B3%95&fromid=12291792&fr=aladdin)
### 6.1robot.txt
大型网站通常会有robots.txt文件，例如：https://www.baidu.com/robots.txt
robot.txt文件会指定允许那些机器人采集哪些内容，robot.txt的语法没有标准格式，也不是强制性约束，是否按要求写爬虫由自己决定，但最好遵守。


