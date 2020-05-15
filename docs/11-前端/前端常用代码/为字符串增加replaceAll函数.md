# 为字符串增加replaceAll函数

```js
String.prototype.replaceAll = function(s1,s2){
    return this.replace(new RegExp(s1,"gm"),s2);
};
```