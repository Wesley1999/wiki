#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
cd /root/vuepress/wiki
git pull
npm run build

# 挂载oss
# ossfs iclass-api-wsg-sz /oss/iclass-api -ourl=oss-cn-shenzhen-internal.aliyuncs.com
# 准备发布
rm -rf /oss/wiki/*
cp -R /root/vuepress/wiki/docs/.vuepress/dist/* /oss/wiki

# rm -rf /root/nginx/html/wiki/*
# cp -R /root/vuepress/wiki/docs/.vuepress/dist/* /root/nginx/html/wiki

# 提交到git
git add .
git commit -m "commit"
git push
