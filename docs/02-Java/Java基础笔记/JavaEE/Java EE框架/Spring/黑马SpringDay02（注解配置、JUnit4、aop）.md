# 黑马Spring Day02

## 使用注解配置
首先需要导入需要导入aop包。
```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-aop -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-aop</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
```
还要在xml中添加命名空间。
```
xmlns:content="http://www.springframework.org/schema/context"
```

### 扫描注解
```xml
<content:component-scan base-package="com.wangshaogang.a" />
```
base-package属性指定要扫描的注解所在的包，也会扫描所有后代包。
写了注解以后就不要在xml中添加相同名称的对象了，xml中的配置会覆盖注解。

### 注入值
```java
@Component("user")
@Service("user")
@Controller("user")
@Repository("user")
```
上面的任意一行相当于xml中的`<bean name="user" class="com.wangshaogang.a.User" />`
这四种注解有相同的功能。
@Component泛指组件
@Service用于业务层组件
@Controller用于控制层
@Repository用于数据访问层
value值是Spring容器中放入的对象的名称。在注解中，当只有一个名为value的参数时，可以省略名称。


### 作用域
```java
@Scope(scopeName = "prototype")
```
不多说了。

### 生命周期
```java
@PostConstruct
```
写在初始化方法前面，在对象被创建后调用。
```java
@PreDestroy
```
写在销毁方法前面，在对象被销毁前调用。

### 注入值
@Value("Tom")
相当于xml中的`<property name="name" value="Tom" />`
这个注解**通常放在成员变量上**，也可以放在set方法上。两种位置，功能相同，技术不同。
放在成员变量上更简洁更常用，省略了set方法，底层原理是反射，破坏了类的封装性。放在set方法上更准确，但复杂一些。

### 注入引用
```java
@Resource(name = "car2")
```
这是一种推荐使用的方式，手动注入，指定注入的对象的名称。

```java
@Autowired
@Qualifier("car2")
```
这是自动装配，可以不写第二行，如果不写就会自动从容器中找相应的对象。有多个相同类型的对象时会冲突，配合@Qualifier("car2")可以避免冲突，但这种自动装配的方式反而比手动装配复杂。

## 整合JUnit4
需要导入junit4包。
```xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-test</artifactId>
	<version>4.2.4.RELEASE</version>
	<scope>compile</scope>
</dependency>
```
以下为整合JUnit4的固定写法：
```java
// 用于创建容器
@RunWith(SpringJUnit4ClassRunner.class)
// 指定创建容器时使用的配置
@ContextConfiguration("classpath:applicationContext1.xml")
public class Demo {
    // 将user对象注入变量u中
	@Resource(name = "user")
	private User u;

	@Test
	public void test() {
		System.out.println(u);
	}
}
```
整合JUnit4的好处是不需要在每个测试方法中创建Spring容器和获取容器中的对象。

## Spring实现aop（xml配置）
具体的步骤请参考[Spring中的动态代理](https://www.wangshaogang.com/2018/11/16/Java%E5%8A%A8%E6%80%81%E4%BB%A3%E7%90%86/#Spring%E4%B8%AD%E7%9A%84%E5%8A%A8%E6%80%81%E4%BB%A3%E7%90%86)或[动态代理](https://app.yinxiang.com/shard/s58/nl/19901883/ef227bf6-3698-45a6-b5f0-2d5d08573125)
下面是简要步骤简要步骤：
1. 导包
2. 准备目标对象
3. 准备通知类MyAdvice（环绕通知比较特殊）
4. 将目标对象和通知对象配置到Spring容器中
5. 织入通知
    1. 配置切入点（表达式）
    2. 描述通知类型
6. 测试

动态代理是aop思想的体现，两者不能划等号，aop思想的典型应用还有过滤器、拦截器等。

## Spring实现aop（注解配置）
1. 导包，同上
2. 在xml中声明扫描注解和用注解完成织入
```xml
<content:component-scan base-package="com.wangshaogang.c_proxy_annotation" />
<aop:aspectj-autoproxy />
```
3. 准备目标对象，同上
4. 把目标对象放到Spring容器中，也就是在目标对象的类前面加上注解：
```java
@Component("userService")
```
5. 准备通知类，同上
6. 把通知类放到Spring容器中，也就是在通知类前加上注解：
```java
@Component("myAdvice")
```
7. 声明通知类，也就是在通知类前加上注解：
```java
@Aspect
```
8. 为每个通知方法添加注解，根据通知类型的不同，有@Before、@AfterReturning、@Around、@AfterThrowing、@After，这几个注解都有参数，value值是切入点表达式，为防止存在过多重复的代码，可以在通知类中额外添加一个方法：
```java
@Pointcut("execution(* com.wangshaogang.c_proxy_annotation.*ServiceImpl.*(..))")
public void pc() { }
```
然后把`"MyAdvice.pc()"`作为通知注解的参数，完整的通知类如下：
```java
@Component("myAdvice")
// 声明是通知类
@Aspect
public class MyAdvice {
	@Pointcut("execution(* com.wangshaogang.c_proxy_annotation.*ServiceImpl.*(..))")
	public void pc() { }

	// 声明是前置通知
	@Before("MyAdvice.pc()")
	public void before() {
		System.out.println("这是前置通知");
	}

	// 声明是后置通知（无异常）
	@AfterReturning("MyAdvice.pc()")
	public void afterReturning() {
		System.out.println("这是后置通知（出现异常不调用）");
	}

	// 声明是环绕通知
	@Around("MyAdvice.pc()")

	public Object around(ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("这是环绕通知（前）");
		Object proceed = pjp.proceed();
		System.out.println("这是环绕通知（后）");
		return proceed;
	}

	// 声明是后置通知（异常）
	@AfterThrowing("MyAdvice.pc()")
	public void afterException() {
		System.out.println("这是后置通知（出现异常才调用）");
	}

	// 声明是后置通知
	@After("MyAdvice.pc()")
	public void after() {
		System.out.println("这是后置通知（无论是否出现异常都调用）");
	}
}
```
9. 测试