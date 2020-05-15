# Docker中安装code-server

```
docker run --name code-server -p 17080:8080 -v "/root/docker/code-server:/home/coder/project" -e PASSWORD=[密码] -u "$(id -u):$(id -g)" codercom/code-server:latest --auth password
```