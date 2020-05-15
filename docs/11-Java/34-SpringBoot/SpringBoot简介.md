# SpringBoot基础

## SpringBoot简介
Spring团队开发于2014年，与Spring一同发布。
用来简化Spring开发，约定大于配置，去繁从简。无需配置XML。
SpringBoot着眼于整套JavaEE的解决方案，而不像SpringCore要整合MyBatis
自动配置SpringData、SpringSecurity等环境，不用一个个去学习。
掌握容易，精通难，只有对Spring底层的API非常熟悉以后，才能对SpringBoot做深度定制。

## 微服务
是一种架构风格（服务微化），一个应用是一个小服务，每个小服务通过HTTP的方式进行互通。

## 单体应用
将所有代码放到一个应用里，打成一个war包放到tomcat中，优点是开发测试简单，缺点是小小的修改要导致整个应用重新部署，牵一发而动全身，而且维护和分工协作比较麻烦。

## 场景启动器（starter）
spring-boot场景启动器；帮我们导入了web模块正常运行所依赖的组件；Spring Boot将所有的功能场景都抽取出来，做成一个个的starters（启动器），只需要在项目里面引入这些starter相关场景的所有依赖都会导入进来。要用什么功能就导入什么场景的启动器。
