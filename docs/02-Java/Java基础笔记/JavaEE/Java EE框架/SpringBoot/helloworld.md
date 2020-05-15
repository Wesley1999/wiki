# helloworld

## Maven设置
给maven 的settings.xml配置文件的profiles标签添加
```xml
<profile>
  <id>jdk-1.8</id>
  <activation>
    <activeByDefault>true</activeByDefault>
    <jdk>1.8</jdk>
  </activation>
  <properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
  </properties>
</profile>
```

## 在IDEA中配置Maven
略

## 实现的功能
浏览器发送hello请求。服务器接受请求并处理，响应Hello World字符串。

## 依赖
```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>1.5.9.RELEASE</version>
</parent>
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```

## 编写主程序
主程序用于启动SpringBoot应用。
```java
/**
 * @SpringBootApplication 用来标注一个主程序类，说明这是一个SpringBoot应用
 */
@SpringBootApplication
public class HelloWorldMainApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelloWorldMainApplication.class, args);
	}

}
```


## 编写业务逻辑（cocntroller、service...）
```java
/**
 * @SpringBootApplication 用来标注一个主程序类，说明这是一个SpringBoot应用
 */
@SpringBootApplication
public class HelloWorldMainApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelloWorldMainApplication.class, args);
	}

}
```

## 运行
直接运行main方法，不需要像SpringMVC那样配置包扫描、前端控制器、视图解析器等等。

## 部署
不需要war包。
需要一个插件，用于将项目打成jar包。
```java
<!-- 这个插件，可以将应用打包成一个可执行的jar包；-->
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>
```
然后可以执行maven-Lifecycle-package，打成的包默认放在了target目录下。
jar包可以通过命令`java -jar [文件名]`执行