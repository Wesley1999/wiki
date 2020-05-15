# 读写Cookie

以下代码参考[https://www.jianshu.com/p/d5662cffbd03](https://www.jianshu.com/p/d5662cffbd03)
```js
function setCookie(key, value, maxAge=365*24*60*60*1000) {
    var d = new Date();
    d.setTime(d.getTime()+(maxAge));
    var expires = "expires="+d.toGMTString();
    document.cookie = key + "=" + value + "; " + expires;
}

function getCookie(key) {
    var name = key + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++)
    {
        var c = ca[i].trim();
        if (c.indexOf(name)==0) return c.substring(name.length,c.length);
    }
    return "";
}
```