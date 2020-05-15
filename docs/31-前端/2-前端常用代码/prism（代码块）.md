# prism（代码块）

用于展示代码块，在官方下载地址可以选择主题和插件：[https://prismjs.com/download.html](https://prismjs.com/download.html)
代码中的符号`<` `>`最好转换成`&lt;` `&gt;`，否则html标签会被浏览器解析。  
如果要显示`&`，可转换成`&amp;`。  
可使用此工具进行转换：[https://text.wangshaogang.com/](https://text.wangshaogang.com/)

参考代码：
```html
<pre class="line-numbers">
    <code class="language-html">
        &lt;!DOCTYPE html&gt;
        &lt;html lang="en"&gt;
        &lt;head&gt;
            &lt;meta charset="UTF-8"&gt;
            &lt;title&gt;Test&lt;/title&gt;
        &lt;/head&gt;
        &lt;body&gt;
        这是一个html
        &lt;/body&gt;
        &lt;/html&gt;
    </code>
</pre>
```
其显示效果为：
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Test</title>
</head>
<body>
这是一个html
</body>
</html>
```