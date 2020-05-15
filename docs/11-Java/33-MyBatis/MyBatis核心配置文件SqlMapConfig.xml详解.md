# MyBatis核心配置文件SqlMapConfig.xml详解
[toc]

## 概述
配置的内容和顺序如下：
**properties（属性）**
settings（全局配置参数）（用于二级缓存，现在不用）
**typeAliases（类型别名）**
typeHandlers（类型处理器）
objectFactory（对象工厂）
plugins（插件）
environments（环境集合属性对象）
**mappers（映射器）**


## properties
```xml
<!--resource是properties文件的完整路径-->
<properties resource="db.properties" />
```

## typeAliases
别名可在mapper.xml中直接使用，用在执行入参和返回值类型的地方。
还有一些默认支持的别名，例如string可以自动映射为String。
有两种指定方式，常用的是用package指定。
```xml
<typeAliases>
	<!--指定单个类的别名-->
	<!--<typeAlias type="com.wangshaogang.e_test_config.pojo.User" alias="User" />-->
	<!--含后代包，包中的类自动使用类名作为别名，首字母大小写都可以-->
	<package name="com.wangshaogang.e_test_config.pojo" />
</typeAliases>
```
## mappers
指定mapper.xml文件的位置，有四种方式。
最常用的是用package指定，其次是用mapper的class属性指定。
这两种方式都要求mapper接口名称与mapper映射文件名称相同，且在同一目录中。
但maven项目默认只能把配置文件放到resources中，解决方式是在pom.xml中配置build，强制发布*.xml文件。[参考资料](https://blog.csdn.net/sakura_mio/article/details/66979776)
```xml
<mappers>
	<!--单独指定xml-->
	<!--<mapper resource="e/UserMapper.xml" />-->
	<!--指定类，此种方式要求mapper接口名称与mapper映射文件名称相同，且在同一目录中-->
	<!--<mapper class="com.wangshaogang.e_test_config.mapper.UserMapper" />-->
	<!--绝对路径，不合适-->
	<!--<mapper url="" />-->
	<!--指定包，此种方式要求mapper接口名称与mapper映射文件名称相同，且在同一目录中-->
	<package name="com.wangshaogang.e_test_config.mapper" />
</mappers>
```
```xml
<build>
	<plugins>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-compiler-plugin</artifactId>
			<configuration>
				<source>1.7</source>
				<target>1.7</target>
			</configuration>
		</plugin>
	</plugins>
	<resources>
		<resource>
			<directory>src/main/java</directory>
			<includes>
				<include>**/*.properties</include>
				<include>**/*.xml</include>
			</includes>
			<filtering>false</filtering>
		</resource>
	</resources>
</build>
```