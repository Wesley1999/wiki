# 黑马Spring Day01

## 把一个对象放到Spring容器中
1. 导入4个基本的包和两个日志包
```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-beans -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-beans</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-context</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.springframework/spring-core -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-core</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.springframework/spring-expression -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-expression</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/commons-logging/commons-logging -->
<dependency>
	<groupId>commons-logging</groupId>
	<artifactId>commons-logging</artifactId>
	<version>1.1.1</version>
</dependency>
<!-- https://mvnrepository.com/artifact/log4j/log4j -->
<dependency>
	<groupId>log4j</groupId>
	<artifactId>log4j</artifactId>
	<version>1.2.15</version>
</dependency>
```
2. 编写一个bean，内容任意。
3. 配置文件名称任意，建议applicationContext.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans 
       http://www.springframework.org/schema/beans/spring-beans.xsd">
       
    <bean name="user" class="com.wangshaogang.bean.User" />
    
</beans>
```
bean标签中的name在取出的对象时候会用到。

4. 测试
```java
@Test
public void fun1() {
	// 创建容器对象
	ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	// 从容器取对象
	User u = (User) ac.getBean("user");
	// 打印User对象
	System.out.println(u);
}
```

## IOC&DI
IOC（Inverse of Control）是反转控制。以前对象的创建是由开发人员自己维护，包括依赖关系也是自己注入。使用Spring之后，对象的创建以及依赖关系可以由Spring完成。反转控制就是反转了对象的创建方式，由自己创建转为由程序创建。
DI（Dependecy Injection）是依赖注入。实现IOC思想需要DI的支持。

## BeanFactory&ApplicationContext
### BeanFactory
BeanFactory是Spring最原始的接口，功能较为单一，特点是每次在或的对象时才会创建对象，这也与早期计算机硬件资源匮乏有关，现在在资源匮乏的时候也会使用BeanFactory接口。
### ApplicationContext
ApplicationContext是继承关系中处于比较末端的接口，每次启动时就会从容器中配置所有的对象，而且提供了更多丰富的功能，通常情况下使用ApplicationContext接口。
**从类路径加载配置文件：ClassPathXmlApplicationContext**
从绝对路径为了配置文件：FileSystemXmlApplicationContext

## 使用xml配置
### Bean元素基本属性
name：给被管理的对象取得名字，获得对象时使用。
class属性：被管理对象的完整类名。
id：与name属性功能一样，不可重复，不能用特殊字符，**已过时**。

### 三种创建方式相关配置
#### 空参创建对象（常用）
```xml
<bean name="user" 
	  class="com.wangshaogang.bean.User2" />
```
#### 静态工厂创建对象
factory-method指定创建对象的方法，必须为静态方法。
```xml
<bean name="user2" 
	  class="com.wangshaogang.bean.User2" 
	  factory-method="createUser2" />
```
#### 实例工厂创建对象
先创建工厂对象，再用工厂对象的方法创建对象。
factory-bean指定创建对象所用的工厂。
factory-method指定所用的工厂方法。
```xml
<bean name="factory"
	  class="com.wangshaogang.bean.UserFactory" />
<bean name="user3"
	  factory-bean="factory"
	  factory-method="createUser3" />
```

### scope属性
single：在容器中只存在一个实例。是默认值，绝大多数形况下使用。
prototype：每次在获得时创建，每次创建都是新的，整合structs2时要用。
request：web环境下，与request生命周期一致，没用。
session：同上。

### 生命周期
创建对象后和销毁对象前执行的方法。
```xml
<bean name="user3"
	  class="com.wangshaogang.b_create.User" 
	  init-method="init" 
	  destroy-method="destroy"/>
```
只有单例的对象才会在关闭Spring容器时销毁。

### 模块化配置
可以在一个主配置文件中引入其他配置文件，这样就不用把所有配置写到同一个配置文件中：
```xml
<import resource="applicationContext2.xml" />
```

### 属性注入
#### set注入（最常用）
用bean元素的property标签，其属性有name、value、ref。
name是属性名，value是值类型值，ref是引用类型值。
```xml
<bean name="user" class="com.wangshaogang.d_inject.User">
	<property name="name" value="Tom"/>
	<property name="age" value="18"/>
	<property name="car" ref="car"/>
</bean>
```

#### 构造方法注入
用bean元素中的constructor-arg标签，其属性有name、value、ref、index、type。
name是构造方法中的参数名，value是值类型值，ref是引用类型值。
index是参数索引，从0开始，type是参数类型的完整类名，例如java.lang.Integer。
后两个用于参数满足多个构造方法的时候准确定位。
```xml
<bean name="user2" class="com.wangshaogang.d_inject.User">
	<constructor-arg name="name" value="Jerry" type="java.lang.String" index="0" />
	<constructor-arg name="age" value="20" />
	<constructor-arg name="car" ref="car" />
</bean>
```

#### p名称空间注入（少用）
这种方式新且简单，但用的少，旧方式已经深入人心。
需要导入p名称空间，注入可以直接用bean元素的属性。
注入值类型：p:属性名=值
引用类型注入：p:属性名-ref=bean名称
这种方式本质上还是用set方法，简化了set注入。

#### spel注入（少用）
新，使用spel表达式，类似el表达式，略。

### 复杂属性注入（使用set注入）
#### 数组
```xml
<property name="arr">
	<array>
		<value>Tom</value>
		<value>Jerry</value>
		<ref bean="car"></ref>
	</array>
</property>
```
如果只有一个值，也可以直接在property中使用value或ref属性注入值。
#### List
List与数组是类似的。
```xml
<property name="list">
	<list>
		<value>Jack</value>
		<value>Rose</value>
		<ref bean="car"></ref>
	</list>
</property>
如果只有一个值，也可以直接在property中使用value或ref属性注入值。
```
#### Map
```xml
<property name="map">
	<map>
		<entry key="k" value="v" />
		<entry key="car" value-ref="car" />
	</map>
</property>
```
#### Properties
Properties与Map是类似的，但Properties的键和值不能是引用。
```xml
<property name="prop">
	<props>
		<prop key="k">v</prop>
		<prop key="car">car</prop>
	</props>
</property>
```











