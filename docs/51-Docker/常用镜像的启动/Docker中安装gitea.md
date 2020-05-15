# Docker中安装gitea

```
docker pull gitea/gitea:latest
sudo mkdir -p /root/docker/gitea
docker run -d --name=gitea -p 13022:22 -p 13000:3000 -v /root/docker/gitea:/data gitea/gitea:latest
```