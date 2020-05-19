#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
cd /root/vuepress/wiki
git pull
npm run build

# 发布
rm -rf /root/nginx/html/wiki/*
cp -R /root/vuepress/wiki/docs/.vuepress/dist/* /root/nginx/html/wiki

# 提交到git
git add .
git commit -m "commit"
git push
