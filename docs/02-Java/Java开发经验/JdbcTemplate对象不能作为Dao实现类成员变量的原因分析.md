# JdbcTemplate对象不能作为Dao实现类成员变量的原因分析

现在有一个Dao实现类：
```java
public class UserDaoImpl extends JdbcDaoSupport implements UserDao {
	public void addUser(User user) {
		String sql = "insert into t_user values (null, ?, ?)";
		super.getJdbcTemplate().update(sql, user.getName(), user.getPassword());
	}
```

这个Dao实现类继承自JdbcDaoSupport，我们可以在方法中用super.getJdbcTemplate()获取JdbcTemplate对象。
Spring容器中的配置是这样的：
```xml
<bean name="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
    <property name="driverClass" value="${jdbc.driverClass}" />
    <property name="jdbcUrl" value="${jdbc.jdbcUrl}" />
    <property name="user" value="${jdbc.user}" />
    <property name="password" value="${jdbc.password}" />
</bean>
<bean name="userDaoImpl" class="src.controller.daoImpl.UserDaoImpl">
    <property name="dataSource" ref="dataSource" />
</bean>
```
Dao实现类UserDaoImpl直接依赖连接池。
这样我们就可以获取Spring容器中的userDaoImpl对象，来调用addUser()方法了。

---
现在对UserDaoImpl类做一个简单的修改：
```java
public class UserDaoImpl extends JdbcDaoSupport implements UserDao {
	JdbcTemplate jdbcTemplate = super.getJdbcTemplate();
	public void addUser(User user) {
		String sql = "insert into t_user values (null, ?, ?)";
		jdbcTemplate.update(sql, user.getName(), user.getPassword());
	}
```
方法中不再用super.getJdbcTemplate()获取JdbcTemplate，这样写看起来结构更清晰，如果有多个方法的话还能减少更多代码。
看起来没有问题，编译写不会报错，但是一旦运行就会发现抛出了异常：
```
java.lang.NullPointerException
	at src.controller.daoImpl.UserDaoImpl.addUser(UserDaoImpl.java:31)
	at src.test.Demo.test1(Demo.java:35)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:606)
	at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
	at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
	at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
	at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
	at org.springframework.test.context.junit4.statements.RunBeforeTestMethodCallbacks.evaluate(RunBeforeTestMethodCallbacks.java:75)
	at org.springframework.test.context.junit4.statements.RunAfterTestMethodCallbacks.evaluate(RunAfterTestMethodCallbacks.java:86)
	at org.springframework.test.context.junit4.statements.SpringRepeat.evaluate(SpringRepeat.java:84)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:325)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:254)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:89)
	at org.junit.runners.ParentRunner$3.run(ParentRunner.java:290)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:71)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:288)
	at org.junit.runners.ParentRunner.access$000(ParentRunner.java:58)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:268)
	at org.springframework.test.context.junit4.statements.RunBeforeTestClassCallbacks.evaluate(RunBeforeTestClassCallbacks.java:61)
	at org.springframework.test.context.junit4.statements.RunAfterTestClassCallbacks.evaluate(RunAfterTestClassCallbacks.java:70)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:363)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.run(SpringJUnit4ClassRunner.java:193)
	at org.junit.runner.JUnitCore.run(JUnitCore.java:137)
	at com.intellij.junit4.JUnit4IdeaTestRunner.startRunnerWithArgs(JUnit4IdeaTestRunner.java:68)
	at com.intellij.rt.execution.junit.IdeaTestRunner$Repeater.startRunnerWithArgs(IdeaTestRunner.java:47)
	at com.intellij.rt.execution.junit.JUnitStarter.prepareStreamsAndStart(JUnitStarter.java:242)
	at com.intellij.rt.execution.junit.JUnitStarter.main(JUnitStarter.java:70)
```
这个异常是典型的空指针异常，分析发现UserDaoImpl类addUser()方法中的jdbcTemplate对象为`null`，原因如下：

**Spring容器尝试调用空参构造方法来初始化UserDaoImpl对象，而UserDaoImpl（以下简称子类）继承自JdbcDaoSupport（以下简称父类），想要初始化初始化子类对象就要先构造父类对象。父类对象的成员变量`jdbcTemplate`无法在父类中完成注入，需要子类完成构造后用set方法为父类注入。在子类调用set方法方法为父类注入值前，父类的`jdbcTemplate`仍然是`null`。根据对象的初始化顺序，构造方法在成员变量初始化完成之后才调用，set方法又要在子类构造完成后调用。所以子类初始化成员变量时，子类没有完成构造，还没有为父类注入值，所以子类无法获取父类注入值后的成员变量。**

<!--
这个过程就好比一个父亲，他的事业需要儿子的帮助才能完成，假如他的儿子一出生就要父亲的成果，不肯提供帮助，就无法达到目的。
-->

补充：
在继承关系中，初始化顺序是这样的：
父类静态代码块->子类静态代码块->父类普通代码块->父类构造方法->子类main()方法->子类普通代码块->子类构造方法
构造方法在完成构造前的最后一步才执行。