# MyBatis基础

## 介绍
MyBatis本是apache的y一个开源项目iBatis，2010年迁移到google code，改名为MyBatis，2013年由google迁移到Github。
Mybatis是一个优秀得多的持久层框架，对JDBC的操作进行了封装。
## 架构
核心配置文件：SqlMapConfig.xml
配置文件还有：Mapper1.xml、Mapper2.xml、Mapper3.xml
sql写在配置文件中。
## 依赖
核心包
```xml
<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.2.7</version>
</dependency>
```
依赖包：
```xml
<!--MyBatis依赖包-->
<!-- https://mvnrepository.com/artifact/asm/asm -->
<dependency>
	<groupId>asm</groupId>
	<artifactId>asm</artifactId>
	<version>3.3.1</version>
</dependency>
<!-- https://mvnrepository.com/artifact/cglib/cglib -->
<dependency>
	<groupId>cglib</groupId>
	<artifactId>cglib</artifactId>
	<version>2.2.2</version>
</dependency>
<!-- https://mvnrepository.com/artifact/commons-logging/commons-logging -->
<dependency>
	<groupId>commons-logging</groupId>
	<artifactId>commons-logging</artifactId>
	<version>1.1.1</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.javassist/javassist -->
<dependency>
	<groupId>org.javassist</groupId>
	<artifactId>javassist</artifactId>
	<version>3.17.1-GA</version>
</dependency>
<!-- https://mvnrepository.com/artifact/log4j/log4j -->
<dependency>
	<groupId>log4j</groupId>
	<artifactId>log4j</artifactId>
	<version>1.2.17</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-api -->
<dependency>
	<groupId>org.apache.logging.log4j</groupId>
	<artifactId>log4j-api</artifactId>
	<version>2.0-rc1</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-core -->
<dependency>
	<groupId>org.apache.logging.log4j</groupId>
	<artifactId>log4j-core</artifactId>
	<version>2.0-rc1</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
<dependency>
	<groupId>org.slf4j</groupId>
	<artifactId>slf4j-api</artifactId>
	<version>1.7.5</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-log4j12 -->
<dependency>
	<groupId>org.slf4j</groupId>
	<artifactId>slf4j-log4j12</artifactId>
	<version>1.7.5</version>
	<scope>test</scope>
</dependency>
```
mysql驱动
```xml
<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<version>5.1.6</version>
</dependency>
```
## log4j配置
```properties
# Global logging configuration
log4j.rootLogger=DEBUG, stdout
# Console output...
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
```

## JDBC回顾
### 依赖
mysql驱动。

### 代码
```java
public class Demo {
	@Test
	public void test1() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mybatis", "root", "123456");
			String sql = "select * from user where username = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "王五");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("id") + " " + rs.getString("username"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
```
### 存在的问题
1. 频繁获取连接和释放资源
2. 硬编码问题，改sql要改大量代码
3. 结果需要手动遍历


## 入门程序
### 分析
使用MyBatis完成最基本的功能。
步骤：
1. 编写SqlMapConfig.xml
2. 编写pojo（略）
3. 编写mapper.xml
4. **测试**
    1. 加载核心配置文件
    2. 创建SqlSessionFactory工厂对象
    3. 创建SqlSession对象
    4. 执行sql

### 代码
#### 核心配置文件SqlMappper.xml
要使用jdbc连接池和jdbc事务管理。
`<mappers>`中要指定写sql的配置文件的路径。
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!-- 和spring整合后 environments配置将废除 -->
    <environments default="development">
        <environment id="development">
            <!-- 使用jdbc事务管理 -->
            <transactionManager type="JDBC"/>
            <!-- 数据库连接池 -->
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/mybatis"/>
                <property name="username" value="root"/>
                <property name="password" value="123456"/>
            </dataSource>
        </environment>
    </environments>

    <mappers>
        <mapper resource="b/user.xml" />
    </mappers>
</configuration>
```


#### 编写user.xml
namespace是命名空间，用于区分各个mapper.xml文件。
parameterType是入参类型，resultType是返回值类型。
`#{v}`是预编译地占位符，当入参是值类型值时，花括号中的内容任意，当填充的值是从入参对象中取出的值时，花括号中的内容是对象的成员变量名称。如果使用模糊查找，可以写成`"%"#{v}"%"`。
`${value}`是字符串拼接，花括号中只能写value，不能防注入。
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<!--写sql-->
<mapper namespace="test">
    <!--resultType是自动映射，前提是pojo与数据库列名完全对应-->
    <select id="findUserById" parameterType="Integer" resultType="com.wangshaogang.b_mybatis.pojo.User">
        select * from user where id = #{v}
    </select>
</mapper>
```

#### 测试
```java
public class Demo {
	@Test
	public void test1() throws Exception {
		// 加载核心配置文件
		InputStream in = Resources.getResourceAsStream("b/SqlMapConfig.xml");
		// 创建SqlSessionFactory工厂
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		// 创建SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession();
		//执行sql
		User user = sqlSession.selectOne("test.findUserById", 10);
		System.out.println(user);
	}
}
```
