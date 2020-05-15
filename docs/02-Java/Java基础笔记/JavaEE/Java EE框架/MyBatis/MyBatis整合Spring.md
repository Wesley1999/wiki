# MyBatis整合Spring

## 整合思路
1. 将SqlSessionFactory对象放到Spring容器中作为单例存在。
2. Mapper代理形式中，从Spring容器中直接获得Mapper的代理对象。
3. 数据库的连接以及数据库连接池事务管理都交给Spring容器来完成。

## 准备工作
### 准备数据库
用MySQL创建一个名为mybatis的数据库，执行以下查询语句：
```sql
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL COMMENT '用户名称',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
INSERT INTO `user` VALUES ('1', '王五', null, '2', null);
INSERT INTO `user` VALUES ('2', '张三', '2018-11-29', '1', '北京市');
INSERT INTO `user` VALUES ('3', '张小明', null, '1', '上海市');
INSERT INTO `user` VALUES ('4', '陈小明', null, '1', '广东深圳');
INSERT INTO `user` VALUES ('5', '张三丰', null, '1', '湖北武汉');
INSERT INTO `user` VALUES ('6', '陈小明', null, '1', '浙江杭州');
```
### 创建项目
使用IDEA创建一个项目，然后鼠标右键点击项目名称，选择Add Framework Support...，勾选Maven，确定。

在pom.xml中添加以下插件和依赖，这里面也是SSM框架整合所需要用的包，尽管这个项目没用到Spring MVC。
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

<properties>
	<!-- spring版本号 -->
	<spring.version>4.0.2.RELEASE</spring.version>
	<!-- mybatis版本号 -->
	<mybatis.version>3.2.6</mybatis.version>
	<!-- log4j日志文件管理包版本 -->
	<slf4j.version>1.7.7</slf4j.version>
	<log4j.version>1.2.17</log4j.version>
</properties>

<dependencies>
	<dependency>
		<groupId>junit</groupId>
		<artifactId>junit</artifactId>
		<version>4.11</version>
		<!-- 表示开发的时候引入，发布的时候不会加载此包 -->
		<!--<scope>test</scope>-->
	</dependency>
	<!-- spring核心包 -->
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-core</artifactId>
		<version>${spring.version}</version>
	</dependency>

	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-web</artifactId>
		<version>${spring.version}</version>
	</dependency>
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-oxm</artifactId>
		<version>${spring.version}</version>
	</dependency>
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-tx</artifactId>
		<version>${spring.version}</version>
	</dependency>

	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-jdbc</artifactId>
		<version>${spring.version}</version>
	</dependency>

	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-webmvc</artifactId>
		<version>${spring.version}</version>
	</dependency>
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-aop</artifactId>
		<version>${spring.version}</version>
	</dependency>

	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-context-support</artifactId>
		<version>${spring.version}</version>
	</dependency>

	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-test</artifactId>
		<version>${spring.version}</version>
	</dependency>
	<!-- mybatis核心包 -->
	<dependency>
		<groupId>org.mybatis</groupId>
		<artifactId>mybatis</artifactId>
		<version>${mybatis.version}</version>
	</dependency>
	<!-- mybatis/spring包 -->
	<dependency>
		<groupId>org.mybatis</groupId>
		<artifactId>mybatis-spring</artifactId>
		<version>1.2.2</version>
	</dependency>
	<!-- 导入java ee jar 包 -->
	<dependency>
		<groupId>javax</groupId>
		<artifactId>javaee-api</artifactId>
		<version>7.0</version>
	</dependency>
	<!-- 导入Mysql数据库链接jar包 -->
	<dependency>
		<groupId>mysql</groupId>
		<artifactId>mysql-connector-java</artifactId>
		<version>5.1.30</version>
	</dependency>
	<!-- 导入dbcp的jar包，用来在applicationContext.xml中配置数据库 -->
	<dependency>
		<groupId>commons-dbcp</groupId>
		<artifactId>commons-dbcp</artifactId>
		<version>1.2.2</version>
	</dependency>
	<!-- JSTL标签类 -->
	<dependency>
		<groupId>jstl</groupId>
		<artifactId>jstl</artifactId>
		<version>1.2</version>
	</dependency>
	<!-- 日志文件管理包 -->
	<!-- log start -->
	<dependency>
		<groupId>log4j</groupId>
		<artifactId>log4j</artifactId>
		<version>${log4j.version}</version>
	</dependency>

	<!-- 格式化对象，方便输出日志 -->
	<dependency>
		<groupId>com.alibaba</groupId>
		<artifactId>fastjson</artifactId>
		<version>1.1.41</version>
	</dependency>

	<dependency>
		<groupId>org.slf4j</groupId>
		<artifactId>slf4j-api</artifactId>
		<version>${slf4j.version}</version>
	</dependency>

	<dependency>
		<groupId>org.slf4j</groupId>
		<artifactId>slf4j-log4j12</artifactId>
		<version>${slf4j.version}</version>
	</dependency>
	<!-- log end -->
	<!-- 映入JSON -->
	<dependency>
		<groupId>org.codehaus.jackson</groupId>
		<artifactId>jackson-mapper-asl</artifactId>
		<version>1.9.13</version>
	</dependency>
	<!-- 上传组件包 -->
	<dependency>
		<groupId>commons-fileupload</groupId>
		<artifactId>commons-fileupload</artifactId>
		<version>1.3.1</version>
	</dependency>
	<dependency>
		<groupId>commons-io</groupId>
		<artifactId>commons-io</artifactId>
		<version>2.4</version>
	</dependency>
	<dependency>
		<groupId>commons-codec</groupId>
		<artifactId>commons-codec</artifactId>
		<version>1.9</version>
	</dependency>

	<!--lombok-->
	<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
	<dependency>
		<groupId>org.projectlombok</groupId>
		<artifactId>lombok</artifactId>
		<version>1.18.4</version>
		<scope>provided</scope>
	</dependency>

</dependencies>
```
### 创建包
在src/main/Java目录下创建com.example.mybatis_spring包，然后在这个包下创建pojo包、mapper包。

### 创建并编写pojo
在pojo目录下，创建一个User类：
```java
package com.example.mybatis_spring.pojo;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String username;
	private String sex;
	private Date birthday;
	private String address;
}
```

### 创建log4j配置文件
在resources目录下，创建一个log4j.properties文件：
```properties
## Global logging configuration
log4j.rootLogger=DEBUG, stdout
## Console output...
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
```

### 创建连接池配置文件
在resources目录下，创建连接池配置文件db.properties：
```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/mybatis
jdbc.username=root
jdbc.password=123456
jdbc.maxActive=10
jdbc.maxIdle=5
```
其中的配置要与自己的实际情况相符。
之所以加上前缀jdbc，是为了防止与Spring配置冲突。

## 配置MyBatis
### 创建核心配置文件
在resources目录下创建MyBatis核心配置文件，名称为SqlMapConfig.xml：
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

</configuration>
```

### 配置别名
在`<configuration>`标签中，使用`<typeAliases>`标签配置别名，配置别名的作用是，可以在Mapper配置文件中用**别名**代替**类全名**，简化代码。
我们使用扫描包的方式来配置，用**类名**代替**类全名**，这样就不用为每一个pojo单独配置别名。
```xml
<typeAliases>
	<package name="com.example.mybatis_spring.pojo" />
</typeAliases>
```
如果pojo包下还有子包，子包也会得到扫描。

### 配置扫描的mapper
我们要使用的开发方式是Mapper动态代理开发，而不是原始Dao开发，Mapper动态代理开发需要把Mapper接口和Mapper配置文件放到同一个包中。
在`<configuration>`标签中，使用`<mappers>`标签配置扫描的Mapper所在的包，，也就是mapper包：
```xml
<mappers>
	<package name="com.example.mybatis_spring.mapper" />
</mappers>
```
如果mapper包下还有子包，子包也会得到扫描。

## 配置Spring
### 创建Spring配置文件
在resources目录下，创建Spring配置文件applicationContext.xml：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

</beans>
```
Spring对配置文件名称没有绝对的要求，叫做applicationContext.xml是比较规范的做法。

### 加载连接池配置文件
要在Spring配置文件中加载properties配置文件，需要先引入一个命名空间，在加载properties配置文件，完成后Spring的配置文件是这样的：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">

    <context:property-placeholder location="db.properties" />
</beans>
```
location属性指定的是连接池配置文件的位置，由于直接放在resources目录下，所以可以直接写文件名称。

### 配置连接池
在Spring配置文件的`<beans>`标签下，添加如下配置，就可以把连接池配置到Spring容器中。
```xml
<bean name="datasource" class="org.apache.commons.dbcp.BasicDataSource">
	<property name="driverClassName" value="${jdbc.driver}" />
	<property name="url" value="${jdbc.url}" />
	<property name="username" value="${jdbc.username}" />
	<property name="password" value="${jdbc.password}" />
	<property name="maxActive" value="${jdbc.maxActive}" />
	<property name="maxIdle" value="${jdbc.maxIdle}" />
</bean>
```
连接池主要注入一些参数，为防止硬编码问题，连接池的属性是用el表达式从db.properties配置文件中读取的。

### 配置MyBatis工厂
在Spring配置文件的`<beans>`标签下，添加如下配置，就可以把MaBatis工厂配置到Spring容器中。
```xml
<bean class="org.mybatis.spring.SqlSessionFactoryBean">
	<property name="configLocation" value="SqlMapConfig.xml" />
	<property name="dataSource" ref="datasource" />
</bean>
```
MyBatis工厂依赖MyBatis核心配置文件和连接池。
MyBatis工厂不需要用name或id指定在Spring容器中的名称，因为我们可以让Mapper自动态代理自动从Spring容器中找MyBatis工厂。

### 配置Mapper动态代理扫描包
Mapper自动态代理自动从Spring容器中找MyBatis工厂，自动扫描Mapper所在包下的所有Mapper，我们只需要为Mapper动态代理注入所有要扫描的基本包。
```xml
<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
	<property name="basePackage" value="com.example.mybatis_spring.mapper" />
</bean>
```

## 编写Mapper
### 编写Mapper接口
在maper目录下，创建一个接口UserMapper，为其添加一个用id查找用户的方法。
```java
package com.example.mybatis_spring.mapper;

import com.example.mybatis_spring.pojo.User;

public interface UserMapper {
	User findUserById(Integer id);
}
```
### 编写Mapper配置文件
在mapper目录下，创建一个Mapper配置文件UserMapper.xml。
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.example.mybatis_spring.mapper.UserMapper">
    <select id="findUserById" parameterType="Integer" resultType="User">
        select * from user where id = #{v}
    </select>

</mapper>
```
命名空间要与Mapper接口的完整路径完全一致，select标签的id要与接口方法名完全一致，入参和返回值类型要与方法完全一致。`Interger`是MyBatis内置的别名，`User`是在MyBatis核心配置文件中指定的别名。
`#{v}`是占位符，花括号中的内容可以随意写。

## 测试
在test目录下创建一个Demo类。
```java
import com.example.mybatis_spring.mapper.UserMapper;
import com.example.mybatis_spring.pojo.User;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Demo {
	@Test
	public void testMyBatis_Spring() {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserMapper userMapper = ac.getBean(UserMapper.class);
		User user = userMapper.findUserById(10);
		System.out.println(user);
	}
}
```
在此次测试方法中，首先用Spring配置文件获取Spring配置文件，然后从Spring容器中获取Mapper代理对象（Mapper代理对象再Spring容器中是没有名称的，只能用Mapper接口的class文件获取），再执行代理对象的方法打印结果。

## 补充说明
这个项目用最简单的方式演示了MyBatis和Spring的整合，实际上MyBatis和Spring的难点还有很多。许多地方使用了自动扫描，但不是任何情况下都能够自动扫描。本项目使用的查询语句，查询结果恰好与pojo中的字段完全一致，如果不完全一致，或者使用了关联查询，就只能手动封装结果集。
项目还有一些不完善的地方，例如在Maven项目中，Mapper配置文件是不推荐放在java文件夹中的，但我还没有学会如何解决，所以在pom.xml中配置build了，强制发布*.xml文件，这是不好的做‘法。

## Reference
[maven项目中mapper resource路径问题](https://blog.csdn.net/sakura_mio/article/details/66979776)
黑马32期视频-mybatis-day02

## 致谢
感谢jf，如果不是他今天游戏掉线，我可能要打一晚上游戏，也就不会完成这篇博客。