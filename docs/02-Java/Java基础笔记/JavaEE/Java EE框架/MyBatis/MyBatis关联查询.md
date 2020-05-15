# 关联查询

## 一对一关联
查询订单对应的用户，就是一对一关联查询。
关联查询分为内连接和外连接查询，内连接又分为做类，左连接和右连接，[参考](https://app.yinxiang.com/shard/s58/nl/19901883/e118f949-ccd9-42ac-8f78-22555d1af419)，下面以左连接为例。
左连接的特点是左表的数据全部查出连，右表只能查出跟左表关联的数据。
使用关联查询，就不能用原来的原始的表对应的pojo，修改pojo有两种方式，一种是在左表的pojo中添加一个成员变量，另一种是新建一个pojo，继承原来的pojo，这两种方式可以任意选择，不影响下面的代码。
使用关联查询，**所有字段必需手动映射**，手动映射需要使用**resultMap**。

```xml
<resultMap id="g_orders" type="com.wangshaogang.g_association.pojo.Orders">
	<id column="id" property="id" />
	<result column="user_id" property="userId" />
	<result column="number" property="number" />
	<result column="createtime" property="createtime" />
	<association property="user" javaType="com.wangshaogang.g_association.pojo.User">
		<result column="username" property="username" />
	</association>
</resultMap>

<select id="findOrders" resultMap="g_orders">
	select o.id, o.user_id, o.number, o.createtime, u.username
	from orders o
	left join user u
	on o.user_id = u.id
</select>
```
association标签用于将查到的字段，property属性是左表pojo中的成员变量名称（也就是右表的pojo类），javaType属性是这个变量的Java类。
association标签内部，就是对右表进行映射，方式与左表相同。

## 一对多关联
查询用户对应的订单，就是一对多关联查询。
需要在用户表中添加一个List，泛型为订单pojo。
```xml
<resultMap id="g_user" type="com.wangshaogang.g_association.pojo.User">
	<result column="user_id" property="id" />
	<result column="username" property="username" />
	<!--oftype是List集合中的泛型-->
	<collection property="orders" ofType="com.wangshaogang.g_association.pojo.Orders">
		<id column="id" property="id" />
		<result column="user_id" property="userId" />
		<result column="number" property="number" />
		<result column="createtime" property="createtime" />
	</collection>
</resultMap>
<select id="findUser" resultMap="g_user">
	select o.id, o.user_id, o.number, o.createtime, u.username
	from user u
	left join orders o
	on o.user_id = u.id
</select>
```
一对多关联查询用使用collection标签进行映射，javaType属性指定Java类型，而使用ofType指定List的泛型。
id属性容易出错。


