# 黑马Spring Day03


## 直接使用JdbcTemplate
步骤：
1. 导包
4基本+2日志+测试+aop+c3p0+mysql驱动+事务+Spring jdbc一共12个包，下面的依赖不包含前六个。
```xml
<!--测试-->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-test</artifactId>
	<version>4.2.4.RELEASE</version>
	<scope>compile</scope>
</dependency>

<!--aop-->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-aop -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-aop</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>

<!--c3p0-->
<!-- https://mvnrepository.com/artifact/com.mchange/c3p0 -->
<dependency>
	<groupId>com.mchange</groupId>
	<artifactId>c3p0</artifactId>
	<version>0.9.2</version>
</dependency>

<!--mysql驱动-->
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.6</version>
</dependency>

<!--事务-->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-tx -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-tx</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>

<!--Spring jdbc-->
<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
<dependency>
	<groupId>org.springframework</groupId>
	<artifactId>spring-jdbc</artifactId>
	<version>4.2.4.RELEASE</version>
</dependency>
```
2. 创建并配置连接池
3. 创建JdbcTemplate
4. JdbcTemplate获取连接池
5. 执行sql
```java
@Test
public void test1() throws PropertyVetoException {
	// 配置连接池
	ComboPooledDataSource dataSource = new ComboPooledDataSource();
	dataSource.setDriverClass("com.mysql.jdbc.Driver");
	dataSource.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/spring");
	dataSource.setUser("root");
	dataSource.setPassword("123456");
	// 创建JDBC模板
	JdbcTemplate jt = new JdbcTemplate();
	// 模板对象获取连接池
	jt.setDataSource(dataSource);
	// 执行sql
	String sql = "insert into t_user values(null, 'rose')";
	jt.update(sql);
}
```

## 在Spring中使用JdbcTemplate
依赖关系：
1. 连接池需要注入属性
2. JdbcTemplate依赖连接池
3. Dao实现类依赖JdbcTemplate

步骤：
1. 编写Bean
2. 编写Dao
3. 编写Dao实现类
六种常见的dao方法中，增删改都用`JdbcTemplate`类的`update()`方法，参数是sql语句和注入的值（可变）；
查询一组记录，要用`JdbcTemplate`类的`queryForObject()`方法，第一个参数是是sql语句，第三个参数是注入的值（可变），第二个参数是一个RowMapper<>对象，泛型是查询结果要封装的类型，必需手动封装，完整的方法如下：
```java
public User getById(Integer id) {
	String sql = "select * from t_user where id = ?";
	User user = jt.queryForObject(sql,
			new RowMapper<User>() {
				public User mapRow(ResultSet resultSet, int i) throws SQLException {
					User user = new User();
					user.setId(resultSet.getInt("id"));
					user.setName(resultSet.getString("name"));
					return user;
				}
			},
			id);
	return user;
}
```
查询单个数据，也用`JdbcTemplate`类的`queryForObject()`方法，但参数与前面不同，第二个参数是执行返回值的类型，例如`Integer.class`。
查询多组记录，要用`JdbcTemplate`类的`query()`方法，与查询多组记录的方法是类似的，只不过返回的是一个List<>。
4. 配置
根据依赖关系将对象置于Spring容器，并注入相应的值，例如：
```xml
<!--配置连接池-->
<bean name="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
	<property name="driverClass" value="com.mysql.jdbc.Driver" />
	<property name="jdbcUrl" value="jdbc:mysql://127.0.0.1:3306/spring" />
	<property name="user" value="root" />
	<property name="password" value="123456" />
</bean>

<!--配置JdbcTemplate-->
<bean name="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
	<property name="dataSource" ref="dataSource" />
</bean>

<!--配置DaoImpl-->
<bean name="userDaoImpl" class="com.wangshaogang.b_springjdbctemplate.UserDaoImpl">
	<property name="jt" ref="jdbcTemplate" />
</bean>
```
5. 测试
直接中Spring容器中获取Dao实现类的对象，然后就可以用Dao实现类的对象执行方法了。
6. 我出现过的错误：
    1. 连接池属性中用户名后面多打了空格
    2. sql语句from写成form
    3. slq语句占位符顺序写错
    
## 在Spring中使用JdbcTemplate-补充
依赖关系实际上是可以减少一层的，我们可以让Dao实现类继承JdbcDaoSupport类，这个父类会根据连接池自动创建JdbcTemplate对象，Dao实现类这个类以后，就不需要手动创建JdbcTemplate对象，而是用`super.getJdbcTemplate()`去获取。
这样一来，Dao实现类就不再依赖JdbcTemplate对象，而是直接依赖连接池，原本依赖连接池的JdbcTemplate对象可以从Spring容器中删掉。

注意：Dao实现类中，不能让JdbcTemplate对象作为类的成员变量，智能在方法中实用`super.getJdbcTemplate()`获取JdbcTemplate对象。原因参考：[Spring整合JDBC不能把JdbcTemplate对象作为Dao实现类成员变量的原因分析](https://blog.csdn.net/weixin_43477312/article/details/84197477)（这是我自己分析解决问题后写的）

## Spring读取properties配置文件
连接池的属性最好从配置文件读取，先创建一个配置文件db.properties：
```
jdbc.driverClass=com.mysql.jdbc.Driver
jdbc.jdbcUrl=jdbc:mysql://127.0.0.1:3306/spring
jdbc.user=root
jdbc.password=123456
```
Spring中使用porperties配置文件，最好在前面加上一个前缀，以免跟Spring中的关键字重复。
要在Spring配置文件中读取porperties配置文件，需要在Spring配置文件中添加：
```xml
<context:property-placeholder location="db.properties" />
```
location属性是文件的位置。
这要为连接池注入properties配置文件中的值，可以实用`${键}`这样的表达式，完整的配置就是：
```xml
<!--执行Spring读取properties配置-->
<context:property-placeholder location="db.properties" />

<!--配置连接池-->
<bean name="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
	<property name="driverClass" value="${jdbc.driverClass}" />
	<property name="jdbcUrl" value="${jdbc.jdbcUrl}" />
	<property name="user" value="${jdbc.user}" />
	<property name="password" value="${jdbc.password}" />
</bean>
```
我在编写的时候，表达式的位置提示有错误，但运行不会出错，可以发现配置确实是从properties配置文件中读取的，这可能是IDEA的bug。

## aop事务（xml配置）
步骤：
1. 准备Dao接口、实现类
2. 准备Service接口、实现类
3. 在xml中配置连接池、Dao实现类、Service实现类。
```xml
<!--执行Spring读取properties配置-->
<context:property-placeholder location="db.properties" />

<!--配置连接池-->
<bean name="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
    <property name="driverClass" value="${jdbc.driverClass}" />
    <property name="jdbcUrl" value="${jdbc.jdbcUrl}" />
    <property name="user" value="${jdbc.user}" />
    <property name="password" value="${jdbc.password}" />
</bean>

<!--配置DaoImpl-->
<bean name="accountDaoImpl" class="com.wangshaogang.c_tx.dao.AccountDaoImpl">
    <property name="dataSource" ref="dataSource" />
</bean>

<!--配置ServiceImpl-->
<bean name="serviceImpl" class="com.wangshaogang.c_tx.service.ServiceImpl">
    <property name="accountDao" ref="accountDaoImpl" />
</bean>
```

---
以上只是使用JdbcTemplate的步骤，下面结合aop事务。
4. 首先需要导入四个aop相关的包：
```xml
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

5. Spring不需要手动编写通知，只需要直接在xml中配置事务核心管理器、事务模板对象、织入通知，具体解释在注释中。
```xml
<!-- 事务核心管理器，封装了所有事务操作，依赖于连接池 -->
<bean name="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager" >
    <property name="dataSource" ref="dataSource" ></property>
</bean>

<!-- 事务模板对象 -->
<bean name="transactionTemplate" class="org.springframework.transaction.support.TransactionTemplate" >
    <property name="transactionManager" ref="transactionManager" ></property>
</bean>

<!-- 配置事务通知 -->
<tx:advice id="txAdvice" transaction-manager="transactionManager" >
    <tx:attributes>
        <!-- 以方法为单位,指定方法应用什么事务属性
            isolation:隔离级别
            propagation:传播行为
            read-only:是否只读
         -->
        <tx:method name="save*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="persist*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="update*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="modify*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="delete*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="remove*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
        <tx:method name="get*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="true" />
        <tx:method name="find*" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="true" />
        <tx:method name="transfer" isolation="REPEATABLE_READ" propagation="REQUIRED" read-only="false" />
    </tx:attributes>
</tx:advice>

<!-- 配置织入 -->
<aop:config  >
    <!-- 配置切点表达式 -->
    <aop:pointcut expression="execution(* com.wangshaogang.c_tx.service.*Impl.*(..))" id="txPc"/>
    <!-- 配置切面 : 通知+切点
             advice-ref:通知的名称
             pointcut-ref:切点的名称
     -->
    <aop:advisor advice-ref="txAdvice" pointcut-ref="txPc" />
</aop:config>
```

6. 测试
```java
// 用于创建容器
@RunWith(SpringJUnit4ClassRunner.class)
// 指定创建容器时使用的配置
@ContextConfiguration("classpath:applicationContext2.xml")
public class Demo {
	@Resource(name = "serviceImpl")
	// 这里一定要使用接口而不是类！
	//! private ServiceImpl service;
	private Service service;

	@Test
	public void test() {
		// 要用接口对象调用方法而不是类的对象！
		service.transfer(1, 2, 10.00);
	}
```
**加强方法，并不是直接委托类的方法被修改，而是我们要使用加强的方法，就要用接口对象调用。**

## aop事务（注解配置）
事务相关的配置如下：
```xml
<!-- 事务核心管理器，封装了所有事务操作，依赖于连接池 -->
<bean name="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager" >
    <property name="dataSource" ref="dataSource" ></property>
</bean>

<!-- 事务模板对象 -->
<bean name="transactionTemplate" class="org.springframework.transaction.support.TransactionTemplate" >
    <property name="transactionManager" ref="transactionManager" ></property>
</bean>

<!-- 开启使用注解配置事务 -->
<tx:annotation-driven />
```
与使用xml配置相比，注解配置配置事务通知和织入的代码要用`<tx:annotation-driven />`代替。

然后，要在Service方法的实现类前面加上注解，完整的实现类代码如下：
```java
@Setter
public class ServiceImpl implements Service {
	private AccountDaoImpl accountDao;

	@Transactional(isolation = Isolation.REPEATABLE_READ, propagation = Propagation.REQUIRED, readOnly = false)
	public void transfer(final Integer from, final Integer to, final Double money) {
		accountDao.decreaseMoney(from, money);
//		int i = 1 / 0;
		accountDao.increaseMoney(to, money);
	}

}
```