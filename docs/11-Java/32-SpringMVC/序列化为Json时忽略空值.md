# 序列化为Json时忽略空值

在pojo前面添加：
```java
@JsonSerialize(include= JsonSerialize.Inclusion.NON\_NULL)
```

导入的包：
```java
import org.codehaus.jackson.map.annotate.JsonSerialize;
```