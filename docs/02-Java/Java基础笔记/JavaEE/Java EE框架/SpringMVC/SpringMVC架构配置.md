# SpringMVC架构配置

## 架构
1. 配置前端控制器，拦截指定的请求，拦截到Controller层（现在springmvc配置文件中指定扫描标签）
2. 处理器映射器可以从Spring容器中找符合条件的[拦截器和]处理器（包名类名方法名）
3. Controller层是处理器，ModelAndView可以放数据和视图路径。

真正需要书写的只有处理器，前端控制器只需要配。

![](https://oss-pic.wangshaogang.com/1586691188551-7ae66aca-9cdc-4f33-adef-98f3a69debb2.png)


## springmvc.xml
如下：
```xml
<!-- 扫描@Controler  @Service   -->
<context:component-scan base-package="com.wangshaogang"/>

<!--注解驱动-->
<!--
	相当于：
	处理器映射器
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping" />
	处理器适配器
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter" />
-->
<mvc:annotation-driven />

<!--视图解析器-->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<property name="prefix" value="/WEB-INF/jsp/" />
	<property name="suffix" value=".jsp" />
</bean>
```
可以用一行注解驱动代理处理器映射器和处理器适配器的配置。
可以在视图解析器中配置前缀和配置。