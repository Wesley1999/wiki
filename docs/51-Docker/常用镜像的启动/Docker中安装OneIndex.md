# Docker中安装OneIndex

```
docker run -d --name oneindex -p 18080:80 --restart=always -v ~/docker/oneindex/config:/var/www/html/config -v ~/docker/oneindex/cache:/var/www/html/cache -e REFRESH_TOKEN='0 * * * *' -e REFRESH_CACHE='*/10 * * * *' setzero/oneindex
```

or

```
docker run -d --name oneindex -p 18080:80 --restart=always -v ~/docker/oneindex/config:/var/www/html/config -v /temp/docker/oneindex/cache:/var/www/html/cache setzero/oneindex
```