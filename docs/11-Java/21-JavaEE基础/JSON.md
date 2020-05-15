# JSON

## 简介
json与语言无关，是一种数据交换的格式。json是js的原生内容，也就意味着js可以直接取出json对象中的数据。

## 格式
Json有两种格式。
### 对象格式
```json
{"key1":obj,"key2":obj,"key3":obj...}
```
### 数组/集合格式
```json
[obj,obj,obj...]例如：{"username":"zhangsan","age":28,"password":"123","addr":"北京"}[{"pid":"10","pname":"小米4C"},{},{}]
```

## 嵌套
对象格式和数组格式可以互相嵌套，例如：
```javascript
var person = {"wsg":{"age":18,sex:"男"},"zb":{"age":19,sex:"女"}};
alert(person.wsg.age);
alert(person.zb.sex);
var 数组形式六级分数 = [{"vb":700},{"ws":650},{"jf":600},{"sg":"不及格"}];
alert(数组形式六级分数[3].sg);
var 集合形式六级分数 = {"jf":{"成绩":600,"排名":3},"vb":{"成绩":700,"排名":1},"ws":{"成绩":650,"排名":4},"sg":{"成绩":"不及格","排名":4}}
alert(集合形式六级分数.jf.成绩);
```

## 注意事项
双引号不能换成单引号。