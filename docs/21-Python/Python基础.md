# Python基础

## 1.变量
Pyhton中，变量赋值前不需要定义，类型由值决定，值类型与变量类型不同也可以复赋值。
Python有五个数据类型：Numbers（数字）、String（字符串）、List（列表）、Tuple（元组）、Dictionary（字典）。
## 2.Numbers（数字）
数字有四种类型：int、long、float、complex，其中复数的实部和虚部都是float型。
浮点数直接运算像Java一样，会存在不精确的问题。
## 3.String（字符串）
用引号括起来的都是字符串，包括单引号、双引号、三引号。
### 3.1修改大小写
字符串.title()方法会字符串中每个单词的首字符改为大写。
### 3.2拼接
字符串拼接直接用加号，与Java相同。
字符串与数字不能直接拼接，需要使用函数str(数字)将其强制转换。
### 3.3转义符
\n \t 与Java相同。
### 3.4删除首尾空格
字符串.lstrip()
字符串.rstrip()
字符串.strip()
这三个方法返回值是操作后的字符串，如果不将返回值存储到变量中，得到的字符串就知识临时的。
## 4.运算
### 4.1运算符
+、-、*、/与Java类似，但整数用/相除，得到的是值，不是商
//：求商
%：求模（余数）
**：乘方

## 5.输入、输出、注释
### 5.1输入
#### 5.1.1接收输入
函数input()可以接受用户输入的数据，可以将输入提示作为该方法的参数，返回值是输入的值，例如：
```Python
name = input('Please enter your name: ')
```
#### 5.1.2类型转换
**input()函数的返回值类型是字符串**，如果要转换，可以用函数int()进行强制转换。
这个函数不能对input()方法的返回值直接强制转换接受，例如下面语句是错误的：
int(age) = input('Please enter your age: ')
需要注意，Python中，将字符串与数字进行==等布尔运算不会报错，但得不到想要的结果，这种错误难以发现如果需要的值不是字符串类型，接收后一定要将其转换。
### 5.2输出
print()函数的参数可以是字符串、数字、列表、字典等。
print()函数可接受的参数有很多，可以用逗号分隔，可以设置输入的分隔符，可以设置结尾符号（默认\n）等。
### 5.3注释
单行注释写在# 后面，多行注释写在三个引号中，例如：
```Python
'''
这是多行注释
这是多行注释
'''
```
```Python
"""
这是多行注释
这是多行注释
"""
```

## 6.List（列表）
### 6.1格式
```Python
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
```
### 6.2访问
bicycles[索引]
索引可以是负数，表示倒数第几个。
### 6.3修改
#### 6.3.1更新
例如：
```Python
bicycles[2] = 'blueline'
```
#### 6.3.2添加
使用append方法，可以将元素添加到列表末尾，例如：
```Python
bicycles.append("xxxx")
```
使用insert()方法，可以将元素插入到指定位置，第一个参数是索引，第二个参数是值，例如：
```Python
bicycles.insert(2, 'yyyy') 
```
表示插入到第三个元素的位置，后面的元素索引+1。
#### 6.3.3删除
##### 6.3.3.1del语句
可以删除列表的指定元素，例如：
```Python
del bicycles[1]
```
表示删除第二个元素，后面的元素索引-1。
##### 6.3.3.2pop()方法
可以从列表中弹出一个值，参数是索引，默认为-1，返回值是弹出的值，例如：
```Python
print(bicycles.pop(2))
```
表示删除第三个元素，同时打印这个元素。
##### 6.3.3.3方法remove()
可以根据值删除元素，参数是指定值，例如：
```Python
bicycles.remove('trek')
```
### 6.4组织列表
#### 6.4.1排序
##### 6.4.1.1sort()方法
可以将列表元素永久按字母顺序排序，再也无法恢复成原始顺序，也可以向sort()方法传递参数reverse=True将其改为逆序，例如：
```Python
bicycles.sort(reverse=True)
```
##### 6.4.1.2sorted()方法
临时排序，只在当前语句中生效，不影响列表中的原始顺序。
##### 6.4.1.3reverse()方法
将列表元素永久逆序，再次调用该方法可恢复原来的顺序。
#### 6.4.2确定长度
函数len(列表)可以快速获取列表的长度。
#### 6.4.3获取索引
index(值)可以获取值对应的索引。
### 6.5遍历列表
#### 6.5.1for循环
python中的for循环，与Java的加强for循环类似：
```Python
for bicycle in bicycles:
    print(bicycle)
```
#### 6.5.2使用数字列表
如果python要让for循环实现与Java标准for循环相同的功能，可以利用数值列表。
函数range()可以生成一系列数字，例如：
```Python
range(1,5)
```
生成的一系列数字由数字1~4组成。
如果要将range(...)的结果转换为列表，可以使用函数list()，例如：
```Python
numbers = list(range(1,5))
```
#### 6.5.3数字列表的计算
对于数字列表digits = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]，可以进行一些计算。
##### 6.5.3.1简单统计
min()，max()，sum()
##### 6.5.3.2列表解析
对遍历的列表通过一定的运算生成一个新的列表，可以用如下表达式：
```Python
squares = [value**2 for value in digits] 
```
这里的句尾没有冒号
### 6.6切片
#### 6.6.1格式
列表[起始索引:终止索引]，例如：
```Python
print(bicycles[2:6])
```
打印索引为2到5的元素，即第3个到第6个元素。
索引同样可以使用负数，起始索引或终止索引都可以省略，表示某一端没有限制。
#### 6.6.2复制列表
复制列表要使用切片的方式：
```Python
bicycles2 = bicycles[:] 
```
切片不指定索引。
复制列表**不能**使用这样的方式：
```Python
bicycles2 = bicycles
```
这样只是复制了列表的内存地址，并不是复制列表的值，操作其中一个列表，另一个列表也会改变。
## 7.Tuple（元组）
### 7.1简介
元组看起来跟列表比较相似，区别在于元组使用圆括号而不是方括号，元组的元素不可变。
### 7.2访问
可以通过索引访问，格式：
```Python
dimensions[索引]
```
遍历的方式也与列表相同。
### 7.3修改
虽然不能修改元组的元素，但可以给存储元组的变量赋值。因此，如果要达到休耕了元组的目的，可以重新定义整个元组。

## 8.Dictionary（字典）
字典与Java中的Map相似，以键值对的形式保存。
### 8.1定义
例如：
```Python
alien_0  = {'color': 'green', 'point': 5}
```
字典中元素是可修改的，所以也可以初始化为空字典{}。
### 8.2访问
字典[键]，例如：
```Python
alien_0['color']
```
### 8.3添加键值对
可以直接赋值，例如：
```Python
alien_0['x'] = 20
```
### 8.4修改值
同样是直接赋值：
```Python
alien_0['x'] = 10
```
### 8.5删除键值对
使用del语句：
```Python
del alien_0['point']
```
遍历
#### 8.5.1遍历键值对
遍历键值对要使用for循环和item()方法，item()方法的作用是返回一个键值对列表。遍历键值对的语句：
```Python
for key, value in alien_0.items():
	print('key: ' + key)
print('value: ' + str(value)+'\n')
```
#### 8.5.2遍历所有键
方法key()可以显式地 提取字典中的所有键，遍历所有键的语句：
```Python
for key in alien_0.keys():
	print('key: ' + key)
```
其中.key()也可以省略，但写出来更容易理解。
上面的语句便利的顺序是不可预测的，如果需要排序，可以使用方法sorted()，例如：
```Python
for key in sorted(alien_0.keys(),reverse=True):
	print('key: ' + key)
```
#### 8.5.3遍历所有值
```Python
for value in alien_0.values():
	print('value: ' + str(value))
```
还可以利用set()方法忽略重复值：
```Python
for value in set(alien_0.values()):
	print('value: ' + str(value))
```
### 8.6嵌套
#### 8.6.1列表嵌套字典
略。
#### 8.6.2字典嵌套列表
略。
#### 8.6.3字典嵌套字典
略。

## 9.流程控制
### 9.1条件
条件语句与Java基本相同，下面讲解不同之处和值得注意的地方。
#### 9.1.1多个条件
if语句检查多个条件，使用运算符and和or，而 Java中使用&&和||。
#### 9.1.2检查特定值是否在列表中
例如：
```Python
'mushrooms' in requested_things
```
in前面还可以用not修饰，表示不包含。
#### 9.1.3复杂条件语句
elif相当于Java中的else if，其他的相同。
### 9.2循环
while循环与Java基本相同。
for循环与Java的加强for循环基本相同。
for循环有一种语句可用于列表解析。对遍历的列表通过一定的运算生成一个新的列表，可以用如下表达式：
```Python
squares = [value**2 for value in digits] 
```
这里的句尾没有冒号。

## 10.函数
### 10.1定义函数
使用def定义函数，例如：
```Python
def greet(username='name'):
    print('Hello, ' + username + '!')
```
关于实参、形参、默认参数的概念，与Java一样。
定义函数，形参不用指定类型。
如果一个参数给出了默认值，那么后面的参数都要求给出默认值。
如果函数有返回值，不需要在定义时指定返回值的类型，返回值类型由实际返回值类型决定。
### 10.2调用函数
可以直接传参，也可以以等式的方式传参，后者没有顺序要求。
### 10.3禁止函数修改列表
如果直接向函数传递列表，函数修改列表时，这个列表在函数外也会被修改，因为共用了内存地址。
要解决这个问题，调用函数时可以向函数传递列表的副本，例如：
```Python
add(numbers[:])
```
### 10.4任意数量实参
定义函数的时候，形参的前面带上星号*，可以让程序创建一个空元组，并将接收到的所有值都封装到这个元组中，例如：
```Python
def add(*numbers):
	sum = 0
	for number in numbers:
		sum += number
	return sum
```
任意数量的实参，必需放到最后。
如果在形参的前面加上两个型号**，可以让程序创建一个空字典，并将接收到的所有键值对都封装到这个字典中，用法同上。
### 导入模块与函数
导入整个模块：import 模块名 as 别名
导入模块中特定函数：from 模块名 import 函数名 as 别名
导入模块中所有函数：from 模块名 import *

## 11.类
### 11.1类的创建
```Python
class 类名() :
	内容
```
类名首字母大写。
### 11.2类中的方法
类中的函数称为方法。
#### 11.2.1方法__init()__
这是一个特殊的方法，用类创建实例时会自动调用，相当于Java中的构造方法。
参数中self必不可少且位于第一个，用参数创建实例时不需要提供此参数。
例如：
```Python
class Dog():
	def __init__(self, name, age):
		self.name = name
		self.age = age
```
此例中，name和age相当于Java类中的常量，可以供类的其他方法调用。
self.name是类中的name，name是实参name，第三行的作用是将变量关联到当前创建的实例。
init()方法的其他参数可以有默认值。
#### 11.2.2修改属性的方法
可以参考Java中的set方法。

### 11.3创建实例
与Java基本相同，例如：
```Python
my_dog = Dog('willie', 6)
```
### 11.4继承
```Python
class 子类名(父类名):
	内容
```
例如：
```Python
class PetKind(Pet):
    def __init__(self, name, age, kind):
        super().__init__(name, age)
        self.kind = kind
my_petKind = PetKind('willie', 6, 'dog')
```
调用父类的__init()__方法或娶她方法，需要使用函数super()，这是一个特殊函数，可以将子类与父类关联起来。
### 11.5类中的属性
实例也可以作为属性，与Java 同理。
### 11.6导入类
Python中，一个.py文件就是一个模块，模块中既能有函数又能有类，导入类与前面导入函数的方式类似。
可以导入整个模块：import 模块名 as 别名
导入模块中特定的类：from 模块名 import 类名1, 类名2…
导入模块中所有的类：from 模块名 import *

## 12.文件
### 12.1读取
读取的所有文本，都会被始位字符串，如果要使用数字，就要将其强转位int或float类型。
#### 12.1.1读取整个文件

with open(r'M:\code\PycharmProjects\PythonStudy\chapter10\files\test.txt') as file_object:
    contents = file_object.read()
    print(contents)
文件路径，可以是绝对路径或相对路径。
在Linux和OS X中，目录通常用斜杠/表示，在Windows中，目录通常用反斜杠\表示，由于反斜杠是转义符，所以通常要在路径的引号前加上r。

#### 12.1.2逐行读取
可以采用循环的方式：
```Python
with open('files/test.txt') as file_object:
    for line in file_object:
        print(line)
```
### 12.2写入
#### 12.2.1写入文本
```Python
filename = 'files/test2.txt'
with open(filename, 'w') as file_object:
    file_object.write("This is a file...")
```
上面的代码中，open函数的第二个参数是文件打开模式，'w'方式会重建文件，常用的打开模式有以下几种：

	r	只读
	w	写入，重建文件
	a	写入，在为文末追加，不存在则创建之
	+	更新
	b	打开二进制文件，可与以上四种连用
	U	支持所有换行符。“\r”“\n”“\r\n”
write()函数会直接在末尾写入内容，可以多次使用该函数。
#### 12.2.2写入json数据
需要导入库json
函数json.dump()用来将json格式数据写入文件，参数是要写入的json数据和打开的文件，例如：
```Python
import json
numbers = [2, 3, 5, 7, 11, 13, 17, 19]
filename = 'numbers.json'
with open(filename, 'w') as f_obj:
    json.dump(numbers, f_obj)
```
函数json.load()用来读取包含json数据的文件，参数是打开的文件，返回值是json格式的数据，在python中对应的类型是list和dict。
```Python
filename = 'numbers.json'
with open(filename) as f_obj:
    numbers = json.load(f_obj)
```

## 13.异常
try-except-else-final语句与Java中的try-catch语句类似。
```Python
try:
    print(1/0)
except ZeroDivisionError:
    print('error')
```
except后面需要指出错误名称（不指出也可以，会有警告）。
在except语句中，可以些pass，表示出现错误直接跳过，什么都不做。
else只在不出现错误的情况下执行，不常用。
final无论是否出现愈长都会执行。

## 14.测试
### 14.1针对函数的测试
使用单元测试，首先要导入unittest库。
测试函数的代码要放在测试类中，编写的测试类需要继承unittest.TestCase类。
完成测试类后，通过unittest.main()方法运行单元测试，例如：
```Python
import unittest
from chapter11.divide import divide
class TestDivide(unittest.TestCase):
    def testDivide(selfself):
        print(divide(1, 2))
unittest.main()
```
### 14.2针对类的测试
进行针对类的测试需要用到unittest模块中的断言方法，这些断言方法可以核实返回的值是否满足预期。测试类的代码，同样要编写在一个继承unittest.TestCase类的类中。
常用的断言方法：

	assertEqual(a, b)	核实a == b
	assertNotEqual(a, b)	核实a != b
	assertTrue(x)	核实x为True
	assertFalse	核实x为False
	assertIn(item, list)	核实item在list中
	assertNotIn(item, list)	核实item不在list中
测试通过打印一个句点，测试引发错误打印一个E，测试导致断言失败打印一个F。