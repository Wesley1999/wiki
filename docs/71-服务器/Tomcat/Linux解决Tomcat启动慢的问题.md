# Linux解决Tomcat启动慢的问题

```
vim $JAVA_HOME/jre/lib/security/java.security
```
```
securerandom.source=file:/dev/random
```
改为   
```
securerandom.source=file:/dev/urandom
```

## Reference
[CentOS 7.2 tomcat启动慢3种解决办法](https://blog.csdn.net/Jenson_/article/details/77891562)