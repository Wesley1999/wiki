# Spring、SpringMVC、MyBatis的整合

## 概述
[toc]

## 准备数据库
使用MySQL，创建一个名为springmvc的数据库，执行下面的sql脚本：
```sql
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '商品名称',
  `price` float(10,1) NOT NULL COMMENT '商品定价',
  `detail` text COMMENT '商品描述',
  `pic` varchar(64) DEFAULT NULL COMMENT '商品图片',
  `createtime` datetime NOT NULL COMMENT '生产日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO `items` VALUES ('1', '台式机', '3000.0', '该电脑质量非常好！！！！', null, '2018-12-02 13:22:53');
INSERT INTO `items` VALUES ('2', '笔记本', '6000.0', '笔记本性能好，质量好！！！！！', null, '2018-12-02 13:22:57');
INSERT INTO `items` VALUES ('3', '背包', '200.0', '名牌背包，容量大质量好！！！！', null, '2018-12-02 13:23:02');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL COMMENT '用户名称',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

INSERT INTO `user` VALUES ('1', '王五', null, '2', null);
INSERT INTO `user` VALUES ('10', '张三', '2014-07-10', '1', '北京市');
INSERT INTO `user` VALUES ('16', '张小明', null, '1', '湖北武汉');
INSERT INTO `user` VALUES ('26', '王五', null, null, null);
```

## 初始化项目
创建一个普通的Java项目，名称任意。
### 添加web、maven支持
鼠标右键点击项目名称，选择Add Frameworks Support...
勾选web和maven，确定。
![](https://oss-pic.wangshaogang.com/1586691653968-bb06d84f-d913-4d38-b37c-42b12d9103dc.png)
检查web和resources文件夹的图标是否与下图一致，如果不一致，可以在Project Structural中修改，具体修改方式可以在本教程最后的常见问题中查看。
![](https://oss-pic.wangshaogang.com/1586691653969-d4f65e87-b185-4730-b251-df5d12d0b1f9.png)

### 添加依赖
在pom.xml的`<project>`标签中，添加下面的插件和jar包：
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
		<plugin>
			<groupId>org.mybatis.generator</groupId>
			<artifactId>mybatis-generator-maven-plugin</artifactId>
			<version>1.3.2</version>
			<configuration>
				<configurationFile>${basedir}/src/main/resources/generatorConfig.xml</configurationFile>
				<overwrite>false</overwrite>
				<verbose>true</verbose>
			</configuration>
			<dependencies>
				<dependency>
					<groupId>mysql</groupId>
					<artifactId>mysql-connector-java</artifactId>
					<version>5.1.6</version>
				</dependency>
			</dependencies>
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
这里面包含了整合SSM框架所需的所有依赖，以及MyBatis逆向工程依赖的插件，还有lombok等实用的工具。
这些代码复制粘贴即可，如果觉得复制粘贴都麻烦，可以编辑Live Templates，快速生成代码。
![](https://oss-pic.wangshaogang.com/1586691653970-e3e91a51-6092-40a4-bf91-c409210e4d78.png)

### 创建db.properties
在resources目录中，创建一个db.properties文件：
```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/springmvc
jdbc.username=root
jdbc.password=123456
jdbc.maxActive=10
jdbc.maxIdle=5
```
这是数据库连接相关的配置，要与自己的实际情况一致。

### 创建log4j.proerties
在resources目录中，创建一个log4j.proerties文件：
```properties
## Global logging configuration
log4j.rootLogger=DEBUG, stdout
## Console output...
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
```
这是日志配置文件，复制粘贴即可。

## 逆向工程
MyBatis逆向工程可以快速生成dao层的代码。
### 创建逆向工程配置文件
在resources目录中，创建一个generatorConfig.xml文件：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
    <context id="testTables" targetRuntime="MyBatis3">
        <commentGenerator>
            <!-- 是否去除自动生成的注释 true：是 ： false:否 -->
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>
        <!--数据库连接的信息：驱动类、连接地址、用户名、密码 -->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/springmvc" userId="root"
                        password="123456">
        </jdbcConnection>

        <!-- 默认false，把JDBC DECIMAL 和 NUMERIC 类型解析为 Integer，为 true时把JDBC DECIMAL 和
            NUMERIC 类型解析为java.math.BigDecimal -->
        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>

        <!-- targetProject:生成PO类的位置 -->
        <javaModelGenerator targetPackage="com.example.springmvc.pojo"
                            targetProject=".\src\main\java">
            <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false"/>
            <!-- 从数据库返回的值被清理前后的空格 -->
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>
        <!-- targetProject:mapper映射文件生成的位置 -->
        <sqlMapGenerator targetPackage="com.example.springmvc.dao"
                         targetProject=".\src\main\java">
            <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false"/>
        </sqlMapGenerator>
        <!-- targetPackage：mapper接口生成的位置 -->
        <javaClientGenerator type="XMLMAPPER"
                             targetPackage="com.example.springmvc.dao"
                             targetProject=".\src\main\java">
            <!-- enableSubPackages:是否让schema作为包的后缀 -->
            <property name="enableSubPackages" value="false"/>
        </javaClientGenerator>
        <!-- 指定数据库表 -->
        <table schema="" tableName="user"></table>
        <table schema="" tableName="items"></table>

    </context>
</generatorConfiguration>
```
数据库连接信息要与自己的实际情况一致，其他配置的功能，在注释中已经说的很清楚了。

### 使用Maven执行
双击Alt键点击右边的Maven Projects，展开Plugins/mybatis-generator。
![](https://oss-pic.wangshaogang.com/1586691653970-aa794239-6076-4e08-8206-0121fdf54b77.png)
双击mybatis-generator:generate，就会开始执行逆向工程。
如果一切正常，就会生成下面这些文件。
![](https://oss-pic.wangshaogang.com/1586691653971-0d607772-400a-450b-8df2-c774afa9b68c.png)
如果出现错误，可以在右键点击mybatis-generator:generate进入设置，检查路径、命令是否正确。
![](https://oss-pic.wangshaogang.com/1586691653971-b12dd802-08d4-4b89-a33d-490fbd3c600f.png)

## 创建mybatis配置文件
在resources目录中，创建SqlMapConfig.xml：
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    
    <typeAliases>
        <package name="com.example.springmvc.pojo"/>
    </typeAliases>
    
</configuration>
```
MyBatis配置文件只需要指定pojo的别名，而且是用包的形式来指定。因为MyBatis与Spring进行了整合，Mapper动态代理的事情交给Spring去做，所以不需要在MyBatis配置文件中指定Mapper。

## 创建spring配置文件
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
    <!--连接池->
    <context:property-placeholder location="classpath:db.properties"/>
    <bean name="dataSource" class="org.apache.commons.dbcp.BasicDataSource">
        <property name="driverClassName" value="${jdbc.driver}"/>
        <property name="url" value="${jdbc.url}"/>
        <property name="username" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
        <property name="maxActive" value="${jdbc.maxActive}"/>
        <property name="maxIdle" value="${jdbc.maxIdle}"/>
    </bean>

    <!--MyBatis工厂-->
    <bean class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="configLocation" value="classpath:SqlMapConfig.xml"/>
        <property name="dataSource" ref="dataSource"/>
    </bean>

    <!--Mapper动态代理-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="basePackage" value="com.example.springmvc.dao"/>
    </bean>

</beans>
```
Spring配置文件中所做的事情是配置连接池、配置MyBatis工厂、配置Mapper动态代理扫描的基本包。
连接池注入的属性中是从db.properties中读取的。Mybatis工厂依赖连接池和MyBatis配置文件，Mapper动态代理依赖要进行代理的基本包。
MyBatis工厂和Mapper动态代理是不需要指定名称的，因为动态代理会自动从Spring容器中找的MyBatis工厂，需要用到Mapper动态代理时，也是根据类型信息来获取的，而不是名称。

至此，MyBatis和Spring以及整合完毕。


## 创建视图
在web/WEB-INF目录下，创建一个jsp文件夹，在jsp文件夹中创建itemList.jsp文件，把下面的代码复制进去。
```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询商品列表</title>
</head>
<body> 
<form action="${pageContext.request.contextPath }/item/queryitem.action" method="post">
查询条件：
<table width="100%" border=1>
<tr>
<td><input type="submit" value="查询"/></td>
</tr>
</table>
商品列表：
<table width="100%" border=1>
<tr>
	<td>商品名称</td>
	<td>商品价格</td>
	<td>生产日期</td>
	<td>商品描述</td>
	<td>操作</td>
</tr>
<c:forEach items="${itemList }" var="item">
<tr>
	<td>${item.name }</td>
	<td>${item.price }</td>
	<td><fmt:formatDate value="${item.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	<td>${item.detail }</td>
	
	<td><a href="${pageContext.request.contextPath }/itemEdit.action?id=${item.id}">修改</a></td>

</tr>
</c:forEach>

</table>
</form>
</body>

</html>
```


## 创建springmvc配置文件
在resourecs目录中，创建springmvc.xml文件：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!--扫描@Controler等注解-->
    <context:component-scan base-package="com.example"/>

    <!--注解驱动-->
    <mvc:annotation-driven/>

    <!--视图解析器-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>
</beans>
```
springmvc配置文件中执行了要扫描的注解所在的包，这里扫描注解的范围比较大，所以不用为每个层单独配置。
配置视图解析器的目的是指定访问视图的前缀和后缀。

## 配置web.xml
在web.xml中，要配置Spring监听器和前端控制器。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>

    <!--Spring监听器-->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

    <!--前端控制器-->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
    </servlet>
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>*.action</url-pattern>
    </servlet-mapping>
    
</web-app>
```
前端控制器中制定了拦截的请求，本项目中要拦截的时以.action结尾的请求。

## 编写Service层
在com.example.springmvc包中，创建一个service包。
在service包中，创建ItemsServices接口：
```java
package com.example.springmvc.service;

import com.example.springmvc.pojo.Items;
import java.util.List;

public interface ItemsServices {
	List<Items> findAllItems();
}
```
在service包中，创建ItemsServicesImpl类，实现ItemsServices接口：
```java
package com.example.springmvc.service;

import com.example.springmvc.dao.ItemsMapper;
import com.example.springmvc.pojo.Items;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ItemsServicesImpl implements ItemsServices {
	@Autowired
	private ItemsMapper itemsMapper;
	public List<Items> findAllItems() {
		return itemsMapper.selectByExampleWithBLOBs(null);
	}
}
```
ItemsServicesImpl类要加上@Service注解，使其被添加到Spring容器中。
ItemsMapper动态代理对象是通过**自动装配**的方式获取的。

## 编写Controller层
在com.example.springmvc包中，创建一个controller包。
在controller包中，创建ItemsListController类：
```java
package com.example.springmvc.Controller;

import com.example.springmvc.pojo.Items;
import com.example.springmvc.service.ItemsServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ItemsListController {

	@Autowired
	private ItemsServices itemsServices;

	@RequestMapping(value = "/hello.action")
	public ModelAndView itemList() {
		List<Items> allItems = itemsServices.findAllItems();
		ModelAndView mav = new ModelAndView();
		mav.addObject("itemList", allItems);
		mav.setViewName("itemList");
		return mav;
	}
}
```
ItemsListController类要加上@Controller注解，使其被添加到Spring容器中。
ItemsServices对象是通过**自动装配**的方式获取的。

jsp中的itemList，是在这里查询数据库动态设置的。
完成后项目的目录是这样的：
![](https://oss-pic.wangshaogang.com/1586691653972-5cb4a6b6-565d-4518-a4e1-848a3932c253.png)


## 运行
把Artifacts添加到Tomcat中去，运行。
打开浏览器输入<http://localhost:8080/hello.action>，显示结果为：
![](https://oss-pic.wangshaogang.com/1586691653972-169bed9c-942c-41aa-86e8-06c5122395f8.png)

## 常见问题
这里记录了一些我在学习SSM过程中遇到的问题。
### 更改项目名后web目录识别错误
在IDEA的Project Structure中，可以通过选项Facets指定web文件夹的路径。
![](https://oss-pic.wangshaogang.com/1586691653972-9d9f58c0-a79c-4b09-b98d-4899fb8d115c.png)
如果项目是从eclipse导入的，无法识别web文件夹，也可以用此方法解决。
### jar包无法发布到tomcat
在Maven中导入了jar包，但是用tomcat运行时出现ClassNotFoundException，很可能是因为jar没有发布到tomcat中。查看out/arctfacts/[项目名]/WEB-INF下是否有lib目录，如果没有，就说明确实存在这个问题。
![](https://oss-pic.wangshaogang.com/1586691843411-eb58c8a1-bdad-4faa-936c-440d38cbc86d.png)
解决方式是进入Project Structure的Artifacts选项，点击当前Module的Artifacts，再展开右边的当前Module，选择所有的jar包，点击右键菜单中的Put into Output Root。
![](https://oss-pic.wangshaogang.com/1586691653974-d54a76b5-63c5-4239-a621-56ff247a7cf5.png)
然后从out目录下删除这个Module的artifacts，重新Buile Artifacts。
![](https://oss-pic.wangshaogang.com/1586691653974-20cc2f3a-fc0e-45be-92f9-c71e63e8bbfa.png)

参考：[【问题解决】IDEA-Maven下Tomcat发布Web项目，遇到Jar包无法找到](https://blog.csdn.net/qq_26525215/article/details/54313537)

### 无法识别Resources
有时候创建的Maven项目目录不正确，需要我们来手动标记目录。
![](https://oss-pic.wangshaogang.com/1586691653974-057b7b3a-9353-4739-9f0e-423aa7b1287e.png)
如果不进行这个操作，可能会出现无法读取配置文件的问题。

### 重复使用逆向工程
MyBatis逆向工程只能使用一次，如果不小心重复使用了，就要把生成的文件全部删除重来一遍。

### 自定义pojo构造方法
MyBatis逆向工程生成的pojo是没有构造方法的，如果我们手动编写了pojo的**有参**构造方法，默认的空参构造方法就会被覆盖。如果没有空参构造方法，使用逆向工程生成的Mapper执行查询语句就会报错。所以如果需要为pojo添加自定义有参构造方法，就要再添加一个空参构造方法。
参考：[Mybatis 报错:java.lang.NoSuchMethodException: java.lang.Long.()](https://blog.csdn.net/eatGood_wearWell/article/details/78549210)

### 更改包名
如果对pojo、dao包的父包名进行了rename，与包名相关的Java代码会自动修改，但Mapper中不会修改，如果一定要修改包名，建议重新使用逆向工程。

### jsp导入jstl约束
大多数配置文件的约束，IDEA都能很智能地帮我们自动导入，但jsp中要使用jstl，约束就不能自动导入，需要手动下载和导入约束文件，可以在设置中搜索DTDs。
![](https://oss-pic.wangshaogang.com/1586691653976-f3aa7dc2-3275-4eb0-beaa-1bb12a6d6d73.png)
参考：[IntelliJ IDEA 使用JSTL标签库(IDEA 加载 tld文件)](https://my.oschina.net/fdblog/blog/180602)