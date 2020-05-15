# 基于layui封装的toast

参考：[https://www.layui.com/doc/modules/layer.html](https://www.layui.com/doc/modules/layer.html)
```js
function toast(msg, time=2000, parse=false) {
    if (!parse) {
        msg = msg.replaceAll("&", "&amp;");
        msg = msg.replaceAll(">", "&gt;");
        msg = msg.replaceAll("<", "&lt;")
    }
    msg = msg.replaceAll("\n", "<br>");
    layer.msg(msg, {
        time: time
        // btn: ['明白了', '知道了', '哦']
    });
}
```
