# Java动态代理

## 代理的概念
代理是一种设计模式，代理的定义是：给某个对象提供一个代理对象，并由代理对象控制对于原对象的访问，即客户不直接操控原对象，而是通过代理对象间接地操控原对象。

通俗的解释是这样的：如果我们要买一瓶饮料，我们不会直接找生产厂家买，而是到商店去买，这个过程中，生产厂家就是`委托类`，商店就是`代理类`。使用代理的优点是可以隐藏委托类的实现，可以减小客户和委托类之间的`耦合性`，可以在不修改委托类代码的情况下做一些额外的处理。

## 静态代理
我们用一个典型的例子来展示Java静态代理。

一个实现对数据库进行增删改查的程序，有一个UserService接口：
```java
public interface UserService {
	void save();
	void delete();
	void update();
	void find();
}
```

这是接口的实现类，也就是委托类：
```java
public class UserServiceImpl implements UserService {
	@Override
	public void save() { System.out.println("保存用户"); }
	@Override
	public void delete() { System.out.println("删除用户"); }
	@Override
	public void update() { System.out.println("更新用户"); }
	@Override
	public void find() { System.out.println("查找用户"); }
}
```

这是代理类：
```java
public class UserServiceProxy {
	private UserService us;
	// 构造方法要求必需把要执行方法的对象传进来
	public UserServiceProxy(UserService us) { this.us = us; }
	public void save() {
		System.out.println("打开事务");
		us.save();
		System.out.println("提交事务");
	}
	// ...
}
```
代理类要用委托类的对象来的调用方法，为确保代理类一定可以获取委托类的对象，代理类重写了构造方法，参数是实现了代理类接口的类（这里使用了向上转型）。

代理类的save()方法中调用了委托类的save()方法，同时还增强了原有的方法，这就是在不修改委托类代码的情况下做额外处理的体现。`System.out.println("打开事务");`和`System.out.println("提交事务");`只是增强原有方法的一个简单展示，在实际应用中会用更复杂的代码代替。

代理类还可以增强委托类的delete()、update()、find()方法，代码与增强save()方法是类似的，为了简洁，这里就不写出来了。


使用单元测试验证代理类的功能：
```java
public class Demo {
	@Test
	public void test1() {
		UserService us = new UserServiceImpl();
		UserServiceProxy usProxy = new UserServiceProxy(us);
		usProxy.save();
	}
}
```
执行test1()方法，控制台显示：
```
打开事务
保存用户
提交事务
```
这说明代理类确实执行了委托类的save()方法，并且为其增加了额外的功能，降低了耦合性，这就是Java中的静态代理。

## 动态代理
前面所讲的静态代理存在一定的不足，使用静态代理，如果我们要为多个委托类方法增加额外的功能，就要在代理类中为每一个委托类的方法增加额外的代码。

Java的动态代理比静态代理的思想向前迈进了一步，因为它可以动态地创建代理并动态地处理对所代理方法的调用。

使用动态代理之前需要先了解一个方法：
```java
public static Object newProxyInstance(ClassLoader loader,
                                          Class<?>[] interfaces,
                                          InvocationHandler h)
```
这个方法是一个静态方法，可以直接通过类来调用，其功能是生成动态代理对象，第一个参数是类加载器，用来加载动态代理类，可以传入`动态代理类class.getClassLoader()`；第二个参数是一个要实现的接口的数组，可以传入`委托类.class.getInterfaces()`，这个方法返回的是类的接口组成的数组；第三个参数指定动态代理要增强的内容，要求传一个InvocationHandler接口，我们可以传入`this`，让动态代理类实现这个接口。

我们使用原有的接口UserService和委托类UserServiceImpl，然后编写新的动态代理方法：

```java
public class UserServiceDynamicProxy implements InvocationHandler {
	private UserService us;
	// 构造方法要求必需把要执行方法的对象传进来
	public UserServiceDynamicProxy(UserService us) { this.us = us; }

	// 调用这个方法返回UserService的代理对象
	public UserService getUserServiceProxy() {
		UserService usProxy = (UserService) Proxy.newProxyInstance(UserServiceDynamicProxy.class.getClassLoader(),
				UserServiceImpl.class.getInterfaces(),
				this);
		return usProxy;
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		// 增强
		System.out.println("打开事务");
		Object invoke = method.invoke(us, args);
		// 增强
		System.out.println("关闭事务");
		return invoke;
	}
}

```
动态代理类同样要求在构造方法中传入委托类的对象，以便执行委托类的方法。
动态代理类中有一个getUserServiceProxy()方法，这个方法使用Proxy.newProxyInstance()方法返回一个委托类的代理对象。
前面讲到Proxy.newProxyInstance()方法的第三个参数是一个InvocationHandler接口，动态代理类实现了这个接口，重写invoke()方法，这个方法很关键，为委托类方法添加额外功能的代码就在这个方法中体现。
invoke()方法自动接收三个参数，不需要修改。第一个参数proxy是代理对象，第二个参数method是委托类的方法，第三个参数是委托类方法执行时的参数。
invoke()方法内部要通过`method.invoke(us, args);`方法来执行委托类的方法，第一个参数是委托类对象，第二个参数是委托类方法执行时的参数，也就是invoke()方法的第三个参数。`method.invoke(us, args);`方法的返回值要作为invoke()方法方法的返回值。
`method.invoke(us, args);`前后执行的语句，就是对委托类方法的加强，我们使用两条简单的语句来代替，实际应用中回避这里复杂。

使用单元测试验证动态代理类的功能：
```java
public class Demo {
	@Test
	public void test2() {
		// 被代理对象
		UserService us = new UserServiceImpl();
		// 用被代理对象动态代理类
		UserServiceDynamicProxy userServiceDynamicProxy = new UserServiceDynamicProxy(us);
		// 用动态代理类创建代理对象
		UserService usProxy = userServiceDynamicProxy.getUserServiceProxy();
		// 用代理对象调用方法
		usProxy.save();
		usProxy.delete();
	}
}
```
执行test2方法，控制台显示：
```
打开事务
保存用户
关闭事务
打开事务
删除用户
关闭事务
```
可以发现委托类的所有方法都得到了加强，不需要为每一个方法委托类的方法编写额外的代码。

动态代理看似比静态代理麻烦，这只是因为我们举的例子太简单，当要增强的方法很多时，动态代理的优势就明显体现出来了。

## Spring中的动态代理
如果完全不了解Spring，建议不看。
Spring中的动态代理同时整合了Java动态代理和CGLib技术，比Java动态代理更简单且灵活。
动态代理也是Spring aop（面向切面编程思想）的体现要使用Spring的aop，首先要导入4个Spring所需的基本包+2个日志包+2个Spring aop包+2个第三方aop包，建议使用maven。


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
<!-- https://mvnrepository.com/artifact/org.springframework/spring-aop -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-aop</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.springframework/spring-aspects -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-aspects</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
<!-- https://mvnrepository.com/artifact/aopalliance/aopalliance -->
<dependency>
	<groupId>aopalliance</groupId>
	<artifactId>aopalliance</artifactId>
	<version>1.0</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.aspectj/aspectjweaver -->
<dependency>
	<groupId>org.aspectj</groupId>
	<artifactId>aspectjweaver</artifactId>
	<version>1.6.8</version>
</dependency>
```

准备好需要加强的目标对象，我们仍然使用前面静态代理中的接口UserService和委托类UserServiceImpl。

接下来要准备通知类：
```java
public class MyAdvice {
	// 前置通知
	public void before() {
		System.out.println("这是前置通知");
	}
	// 后置通知（无异常）
	public void afterReturning() {
		System.out.println("这是后置通知（出现异常不调用）");
	}
	// 环绕通知
	public Object around(ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("这是环绕通知（前）");
		Object proceed = pjp.proceed();
		System.out.println("这是环绕通知（后）");
		return proceed;
	}
	// 后置通知（异常）
	public void afterException() {
		System.out.println("这是后置通知（出现异常才调用）");
	}
	// 后置通知
	public void after() {
		System.out.println("这是后置通知（无论是否出现异常都调用）");
	}
}
```
所谓通知，就是要在切入点前后织入的方法，这些方法的名称是任意的，只需要在配置文件中写清楚即可。
Spring中的通知有五种，前置通知在目标方法调用前执行；后置通知有三种，有出现异常后执行的通知、不出现异常返回后的通知、无论是否出现异常，返回后都执行的通知；除了前置通知和后置通知，还有比较特殊的环绕通知，环绕通知在目标方法执行前后都执行，环绕通知需要接收一个参数，通过参数手动调用方法，并把返回值作为环绕通知的返回值，这是比较固定的写法。

准备好通知类后，要进行配置，我们使用配置文件（一般是applicationContext.xml）来配置（也可以使用注解）。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--配置目标对象-->
    <bean name="userService" class="com.wangshaogang.b_proxy.UserServiceImpl" />
    <!--配置通知对象-->
    <bean name="myAdvice" class="com.wangshaogang.b_proxy.MyAdvice" />
    <!--将通知织入目标对象-->
    <aop:config>
        <!--配置切入点（确定要增强的方法）-->
        <aop:pointcut id="pc" expression="execution(* com.wangshaogang.b_proxy.*ServiceImpl.*(..))" />
        <!--描述通知类型-->
        <aop:aspect ref="myAdvice">
            <aop:before method="before" pointcut-ref="pc" />
            <aop:after-returning method="afterReturning" pointcut-ref="pc" />
            <aop:around method="around" pointcut-ref="pc" />
            <aop:after-throwing method="afterException" pointcut-ref="pc" />
            <aop:after method="after" pointcut-ref="pc" />
        </aop:aspect>
    </aop:config>

</beans>
```
配置目标对象的地方，name可以随便取，在获取代理对象的时候会用到，class是委托类的完整类名。
配置通知对象的地方，name可以随便取，在描述通知类型的时候会用到，class是通知类的完整类名。
配置切入点的地方，id可以随便取，在描述通知类型的时候会用到，expression中是一种表达式，用来限定要增强的方法，这里的`execution(* com.wangshaogang.b_proxy.*ServiceImpl.*(..))`是指，任意返回值、ServiceImpl结尾的类、所有方法、参数任意。
描述通知类型的地方，ref是通知对象在Spring对象中的名称。其子标签顾名思义，就是五种通知的名称，method是通知对应的方法，只需要写名称，pointcut-ref指向切入点的id。

这样就完成了所有的配置，接下来我们使用整合Sping后的单元测试来进行验证，需要先导入test包。
```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-test</artifactId>
	<version>4.2.4.RELEASE</version>
	<scope>compile</scope>
</dependency>
```
测试类：
```java
// 用于创建容器
@RunWith(SpringJUnit4ClassRunner.class)
// 指定创建容器时使用的配置
@ContextConfiguration("classpath:applicationContext2.xml")
public class Demo {
	@Resource(name = "userService")
	// 将userService对象注入变量us中
	// 注意：UserService是接口而不是实现类
	private UserService us;

	@Test
	public void test3() {
		us.save();
	}
}
```
单元测试整合Sping后，可以用注解自动从Sping容器中获取对象，减少测试方法中的重复代码。
执行test3()方法，控制台显示：
```
这是前置通知
这是环绕通知（前）
保存用户
这是后置通知（无论是否出现异常都调用）
这是环绕通知（后）
这是后置通知（出现异常不调用）
```
这说明通知已经织入到了目标对象中，如果还要验证委托类方法出现异常的情况，可以在委托了的方法中加一行`int i = 1 / 0;`，这样可以让异常通知得到调用。

## Reference
《Java编程思想》第14章
《Spring实战》第4章
黑马32期视频-sping-day02
[设计模式之代理模式（Proxy）](http://www.cnblogs.com/BeyondAnyTime/archive/2012/07/04/2576865.html)
[代理模式及Java实现动态代理](https://www.jianshu.com/p/6f6bb2f0ece9)
[Java动态代理-掘金](https://juejin.im/post/5ad3e6b36fb9a028ba1fee6a)