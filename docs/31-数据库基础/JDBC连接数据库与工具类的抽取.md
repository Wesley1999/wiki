# JDBC连接数据库与工具类的抽取

[toc]

## 连接数据库
JDBC连接数据库有两种方式，一种是传统方式，一种是预编译方式，前者快捷但不安全，不推荐使用，后者可以防止用户输入非法字符对数据库造成影响。
### 传统方法
```Java
 //1.注册驱动
Class.forName("com.mysql.jdbc.Driver");
//2.获取连接
Connection conn = DriverManager.getConnection("jdbc:mysql://地址:端口/数据库名","账户","密码");
//3.创建执行sql语句的对象
Statement stmt = conn.createStatement();
//4.书写一个sql语句
String sql = "语句";
System.out.println(sql);
//5.执行sql语句
ResultSet rs = stmt.executeQuery(sql);
//6.取值
if (rs.next()) {
	System.out.println(rs.getString("字段");
} 
//7.关闭结果集
if(rs!=null) rs.close();
//8.关闭创建执行sql语句的对象
if(stmt!=null) stmt.close();
//9.关闭数据库连接
if(conn!=null) conn.close();
```
### 预编译方法
```Java
//1.注册驱动
Class.forName("com.mysql.jdbc.Driver");
//2.获取连接
Connection conn = DriverManager.getConnection("jdbc:mysql://地址:端口/数据库名","账户","密码");
//3.书写一个sql语句
String sql = "select * from tbl_user where 字段1=? and 字段2=?";
//4.创建预处理对象
PreparedStatement pstmt = conn.prepareStatement(sql);
//5.设置参数
pstmt.setString(1, username); 
pstmt.setString(2, upassword);
//6.执行查询操作
ResultSet rs = pstmt.executeQuery();
//7.取值
if (rs.next()) {
	System.out.println(rs.getString("uname")+"，欢迎登录！");
}
//8.关闭结果集
if(rs!=null) rs.close();
//9.关闭创建执行sql语句的对象
if(pstmt!=null) pstmt.close();
//10.关闭数据库连接
if(conn!=null) conn.close();
```
## 工具类的抽取
工具类的抽取有三种方法。
### 编写工具类
缺陷：更换数据库需要改源码。
```Java
/**
 * 获取连接的方法
 */
public static Connection getConnection() {
	Connection conn = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://地址:端口/数据库名","账户","密码");
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("获取连接成功");
	return conn;
}
/**
 * 释放资源的方法
 */
public static void release(Connection conn,PreparedStatement pstmt,ResultSet rs) {
	if(rs != null){
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (pstmt != null){
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if(conn != null){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	System.out.println("释放资源成功");
}
```

### 使用ResourceBundle 读取properties配置文件
开发中获得连接的四个参数（驱动、URL、用户名、密码）通常都存放在配置文件中，方便后期维护，程序如果需要更换数据库，只需修改配置文件即可。
文件名称任意，扩展名必须为properties。
位置任意，非web项目建议放在src下。
内容：一行一组数据，格式是“key=value”，key名称自定义，多个单词 习惯用小数点分开，value不支持中文。
```Java
private static String driver;
private static String url;
private static String username;
private static String password;

/**
 * 静态代码块加载配置文件信息
 */
static {
	ResourceBundle bundle = ResourceBundle.getBundle("db"); //与第三种方法不同，这里不需要加后缀
	driver = bundle.getString("driver");
	url = bundle.getString("url");
	username = bundle.getString("username");
	password = bundle.getString("password");
}

/**
 * 获取连接的方法
 * @return
 */
public static Connection getConnection() {
	Connection conn = null;
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url,username,password);
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("获取连接成功");
	return conn;
}

/**
 * 释放资源的方法
 */
public static void release(Connection conn,PreparedStatement pstmt,ResultSet rs) {
	if(rs != null){
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (pstmt != null){
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if(conn != null){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	System.out.println("释放资源成功");
}
```
	
### 使用输入流读取properties配置文件
properties配置文件与上一种方法完全相同。
```Java
private static String driver;
private static String url;
private static String username;
private static String password;

/**
 * 静态代码块加载配置文件信息
 */
static {
	try {
		//1.通过当前类获得类加载器
		ClassLoader classLoader = JDBCUtils_V3.class.getClassLoader();
		//2.通过出类加载器的方法获得一个输入流
		InputStream is = ClassLoader.getSystemResourceAsStream("db.properties"); //与第二种方法不同，这里需要加后缀
		//3.创建一个properties对象
		Properties props = new Properties();
		//4.加载输入流
		props.load(is);
		//5.获取相关参数的值
		driver = props.getProperty("driver");
		url = props.getProperty("url");
		username = props.getProperty("username");
		password = props.getProperty("password");
	} catch (IOException e) {
		e.printStackTrace();
	}
}

/**
 * 获取连接的方法
 *
 * @return
 */
public static Connection getConnection() {
	Connection conn = null;
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, username, password);
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("获取连接成功");
	return conn;
}

/**
 * 释放资源的方法
 */
public static void release(Connection conn, PreparedStatement pstmt, ResultSet rs) {
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
	System.out.println("释放资源成功");
}
```