# hexo

第一次使用的步骤
```
hexo init
npm install hexo-renderer-ejs --save
npm install hexo-renderer-stylus --save
npm install hexo-renderer-marked --save
hexo generate
hexo server
```
修改`_config.yml`，把最后的代码修改为：
```
deploy:
  type: git
  repository: https://github.com/wsg777/wsg777.github.io.git
  branch: master
```

执行如下命令才能使用git部署
```
npm install hexo-deployer-git --save
hexo clean #
hexo generate
hexo deploy

git clone https://github.com/iissnan/hexo-theme-next themes/next
```

注意：hexo clean 不能简写，其他两个命令可以  


每次更新：
```
hexo clean
hexo generate
hexo deploy
```
  

