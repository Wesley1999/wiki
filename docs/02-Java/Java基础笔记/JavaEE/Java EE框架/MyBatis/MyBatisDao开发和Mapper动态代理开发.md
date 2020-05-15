# MyBatis Dao开发和Mapper动态代理开发

## MyBatis原始Dao开发
### 分析
步骤：
1. 编写SqlMapConfig.xml（略）
2. 编写pojo（略）
3. 编写Dao接口（略）
4. **编写DaoImpl**
    1. 注入SqlSessionFactory工厂
    2. 在方法中用工厂创建SqlSession对象
    3. 用SqlSession执行sql
5. 编写mapper.xml（略）
6. 编写service接口（跳过，直接测试）
7. 编写serviceImpl（跳过，直接测试）
8. **测试**
    1. 加载核心配置文件
    2. 用配置文件创建工厂
    3. 用工厂构造DaoImpl对象
    4. 用DaoImpl对象执行sql

### 代码
#### 编写DaoImpl
```java
public class UserDaoImpl implements UserDao {
	private SqlSessionFactory sqlSessionFactory;
	// 构造方法注入sqlSessionFactory
	public UserDaoImpl(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	public User findUserById(Integer id) {
		// 创建SqlSession
		SqlSession sqlSession = sqlSessionFactory.openSession();
		// 执行sql
		return sqlSession.selectOne("test.findUserById", id);
	}
}
```
#### 测试
```java
public class Demo {
	private SqlSessionFactory sqlSessionFactory;
	@Before
	public void before() throws IOException {
		// 加载核心配置文件
		InputStream in = Resources.getResourceAsStream("c/SqlMapConfig.xml");
		// 创建SqlSessionFactory工厂
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
	}
	@Test
	public void findUserByID() throws Exception {
		// 用工厂构造DaoImpl对象
		UserDao userDao = new UserDaoImpl(sqlSessionFactory);
		User user = userDao.findUserById(10);
		System.out.println(user);
	}
}
```

## Mapper动态代理开发
### 分析
使用Mapper动态代理开发，不再需要手动编写DaoImpl，自动生成实现类，实现类执行sql使用的方法也会自动选择。
要使用Mapper动态代理开发，Dao需要遵循四个原则：
1. 接口方法名与mapper中的id一致。
2. 接口方法返回值类型与mapper中指定的返回值类型一致。
3. 接口方法入参与mapper中指定的入参类型一致。
4. mapper命名空间与接口路径一致（完整包名.接口名）。

步骤：
1. 编写SqlMapConfig.xml（略）
2. 编写pojo（略）
3. **编写Dao接口**
4. **编写mapper.xml**
5. 编写service接口（跳过，直接测试）
6. 编写serviceImpl（跳过，直接测试）
7. **测试**
    1. 加载核心配置文件
    2. 创建SqlSessionFactory工厂.
    3. 创建SqlSession对象
    4. 获取代理对象
    5. 执行sql

### 代码
#### 编写Dao
```java
public interface UserDao {
	User findUserById(Integer id);
}
```
#### 编写mapper.xml
**注意遵循四个原则。**
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.wangshaogang.d_proxy.dao.UserDao">
    <!--查找一个-->
    <select id="findUserById" parameterType="Integer" resultType="com.wangshaogang.d_proxy.pojo.User">
        select * from user where id = #{v}
    </select>
</mapper>
```
#### 测试
```java
public class Demo {
	// mapper动态代理开发
	@Test
	public void findUserByID() throws Exception {
		// 加载核心配置文件
		InputStream in = Resources.getResourceAsStream("d/SqlMapConfig.xml");
		// 创建SqlSessionFactory工厂
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		// 创建SqlSession对象
		SqlSession sqlSession = sqlSessionFactory.openSession();
		// 获取代理对象
		UserDao mapper = sqlSession.getMapper(UserDao.class);
		// 执行sql
		User user = mapper.findUserById(10);
		System.out.println(user);
	}
}
```


