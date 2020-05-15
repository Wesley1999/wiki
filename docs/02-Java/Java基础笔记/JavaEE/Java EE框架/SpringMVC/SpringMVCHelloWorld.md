# SpringMVCHelloWorld

1. 在IDEA的Project Structure中，可以通过选项卡Facets指定web文件夹的路径。
2. 修改项目名后，要用同上的方式指定web文件夹的路径。
3. IDEA使用jstl，要手动下载和导入约束文件，可以在设置中搜索DTDs，参考：<https://my.oschina.net/fdblog/blog/180602>
4. 要标记好resources
5. 无法发布lib的问题，需要在Atrifacts中Put into Output Root，参考<https://blog.csdn.net/qq_26525215/article/details/54313537>

## 导包
可以直接导入ssm框架需要的所有包。
## 配置前端控制器
web.xml中：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!-- 默认找 /WEB-INF/[servlet的名称]-servlet.xml -->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
    </servlet>

    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <!--
            1. /* 拦截所有，建议不使用
            2. *.action *.do 拦截以do action结尾的请求，可以使用
            3. / 拦截所有，不包括jsp，建议使用
         -->
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>
```



## 编写springmvc.xml配置文件
springmvc.xml：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
        http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd
        http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.0.xsd">


    <!-- 扫描@Controler  @Service   -->
    <context:component-scan base-package="com.wangshaogang"/>
    
    <!--注解驱动-->
    <mvc:annotation-driven/>

</beans>
```


## 编写一个jsp页面
/WEB-INF/jsp/hello.jsp
```html
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>拦截成功！</title>
</head>
<body>
<h1>拦截成功！</h1>
</body>
</html>
```

## 创建包
com.wangshaogang.springmvc.controller


## 测试
在controller包中创建Demo.java：
```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Demo {
	@RequestMapping(value = "/hello.action")
	public ModelAndView itemList(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/jsp/hello.jsp");
		return mav;
	}
}
```
