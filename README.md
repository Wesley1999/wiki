# README

## 初始化与构建

```shell
# 安装nodeJS
# 参考https://wiki.wangshaogang.com/41-Linux/01-%E5%B8%B8%E7%94%A8%E8%BD%AF%E4%BB%B6%E7%9A%84%E5%AE%89%E8%A3%85%E4%B8%8E%E5%8D%B8%E8%BD%BD/CentOS7%E5%AE%89%E8%A3%85%E6%9C%80%E6%96%B0%E7%89%88Node.JS.html

# 安装vuepress
npm install -g vuepress

# 安装依赖
npm i

# 构建静态文件，放到./docs/.vuepress/dist目录下
npm run build

# 预览
npm run dev
```

## 添加百度统计

进入./docs/.vuepress/dist目录，用notepad++打开所有文件

```shell
notepad++ -r *
```



使用正则替换

```js
</body>
```

替换为


```js
<script>var _hmt = _hmt || [];(function() {var hm = document.createElement("script");hm.src = "https://hm.baidu.com/hm.js?ed34788f833fea14a48252aa81149d3f";var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(hm, s);})();</script></body>
```