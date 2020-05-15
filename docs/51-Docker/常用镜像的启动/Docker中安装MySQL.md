# Docker中安装MySQL
```
docker pull mysql:latest
```
```
docker run --name some-mysql -p 13306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```
`name`参数指定要启动的实例名称，`MYSQL_ROOT_PASSWORD`指定ROOT密码。`tag`参数是MySQL的版本号，可以是`5.7`、`5.6`、`8.0`。