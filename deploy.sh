#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
cd /root/vuepress/wiki
npm run build

# 进入生成的文件夹
cd /root/vuepress/wiki/docs/.vuepress/dist

rm -rf /root/nginx/html/wiki/*
cp -R * /root/nginx/html/wiki

# git init
# git add -A
# git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:dwanda/dwanda.github.io.git master

cd -
