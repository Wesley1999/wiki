# MyBatis配置文件Mapper.xml详解
[toc]
## 包装类入参
对于入参是包装类的情况，可以在mapper.xml中用`#{包装对象中的对象.属性}`获取。
```xml
<select id="findUserById" parameterType="QueryVo" resultType="User">
	select * from user where id = #{user.id}
</select>
```
## 输出简单类型
输入简单类型，指定返回值为简单类型即可。
```xml
<select id="selectCount" resultType="Integer">
	select count(*) from user
</select>
```
## ResultMap
当数据库中的列名于pojo不完全一致时，不能用ResultType完成自动映射，需要使用ResultMap代替ResultType，另外需要使用一个resultMap标签，在其中用result标签指定数据库列名映射的pojo变量的名称。
```xml
<resultMap id="orders" type="Orders">
	<result column="user_id" property="userId" />
</resultMap>

<select id="findOrders" resultMap="orders">
	select id, user_id, number, createtime, note from orders
</select>
```
在resultMap标签内部，id便签映射主键，result标签映射非主键。貌似也可以所有的都用result，但非主键不能都用id。
## sql片段
在sql中有繁多重复的部分，可以用sql标签 把重复的部分提取出来，然后在写完整sql的标签里用include标签引入。
```xml
<sql id="selector">
	select * from user
</sql>

<select id="findUserById" parameterType="QueryVo" resultType="User">
   <include refid="selector"/>
   where id = #{user.id}
</select>
```
## where&if
where标签和if标签通常一起使用。
if标签跟jstl类似，test属性值是布尔表达式，多个条件用and连接。
where标签中的第一个if标签可以省略前and。
```xml
<select id="selectUserBySexAndUserName" resultType="User">
	select * from user
	<where>
		<if test="sex != null and sex != ''">
			sex = #{sex}
		</if>
		<if test="username != null and username != ''">
			and username = #{username}
		</if>
	</where>
</select>
```
## foreach
foreach标签中，collection指定要遍历的对象名称，可以是数组、List，item是遍历过程中的每一项，separator是分隔符，添加在每一项的中间，open和close分别是开始和结束的字符串。
下面演示的使用一个QueryVo中的List，idsList是这个List的名称。
```xml
<select id="selectUserByIds" parameterType="QueryVo" resultType="User" >
	select * from user
	<where>
		id in
	</where>
	<foreach collection="idsList" item="id" separator=", " open="(" close=")">
		#{id}
	</foreach>
</select>
```
下面是遍历一个数组，遍历的对象是collection，而不是入参名称。
```xml
<select id="selectUserByIds" parameterType="Integer" resultType="User" >
	select * from user
	<where>
		id in
	</where>
	<foreach collection="array" item="id" separator=", " open="(" close=")">
		#{id}
	</foreach>
</select>
```
同理，如果遍历的是List，foreach标签的collection属性值就是list。