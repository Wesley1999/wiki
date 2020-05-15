# MyBatisPageHelper插件

## 依赖
```xml
<!--mybatis pagehelper-->
<dependency>
	<groupId>com.github.pagehelper</groupId>
	<artifactId>pagehelper</artifactId>
	<version>4.1.4</version>
</dependency>
```

## 配置
MyBatis核心配置文件中：
```xml
<!-- 配置分页插件 -->
<plugins>
	<plugin interceptor="com.github.pagehelper.PageHelper">
		<!-- 设置数据库类型 Oracle,Mysql,MariaDB,SQLite,Hsqldb,PostgreSQL六种数据库-->
		<property name="dialect" value="mysql"/>
	</plugin>
</plugins>
```

## 使用
这是Service层的一个方法：
```java
@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	AccountMapper accountMapper;

	@Override
	public ServerResponse<PageInfo> getAccountList(int pageNum, int pageSize) {
		// 记录开始
		PageHelper.startPage(pageNum, pageSize);
		// 填充查询逻辑
		List<Account> accounts = accountMapper.selectByExample(null);
		// 收尾
		PageInfo pageResult = new PageInfo(accounts);
		pageResult.setList(accounts);
		return ServerResponse.createBySuccess(pageResult);
	}
}
```
`PageInfo pageResult = new PageInfo(accounts);`的括号里面还可以传入navigatePages参数。

## 返回值
示例：
```json
{
    "status": 0,
    "data": {
        "pageNum": 1,
        "pageSize": 2,
        "size": 2,
        "orderBy": null,
        "startRow": 1,
        "endRow": 2,
        "total": 107,
        "pages": 54,
        "list": [
            {
                "id": 303,
                "guardian1Id": null,
                "guardian2Id": null,
                "username": "测试",
                "password": null,
                "birthday": 1548000000000,
                "identity": null,
                "sex": null,
                "email": null,
                "address": null,
                "creditCard": null,
                "basicWage": null,
                "commissionProportion": null,
                "userId": null,
                "passedReview": null
            },
            {
                "id": 304,
                "guardian1Id": null,
                "guardian2Id": null,
                "username": "测试",
                "password": null,
                "birthday": 1548000000000,
                "identity": null,
                "sex": null,
                "email": null,
                "address": null,
                "creditCard": null,
                "basicWage": null,
                "commissionProportion": null,
                "userId": null,
                "passedReview": null
            }
        ],
        "firstPage": 1,
        "prePage": 0,
        "nextPage": 2,
        "lastPage": 8,
        "isFirstPage": true,
        "isLastPage": false,
        "hasPreviousPage": false,
        "hasNextPage": true,
        "navigatePages": 8,
        "navigatepageNums": [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
        ]
    }
}
```

| 返回数据             | 含义                                                         |
| -------------------- | ------------------------------------------------------------ |
| pageNum              | 当前是第几页                                                 |
| pageSize             | 页的指定大小                                                 |
| size                 | 页的实际大小（最后一页的size与pageSize不一定相同，除最后一页以外都相同） |
| orderBy              | （不使用）                                                   |
| firstPage   lastPage | 导航页中的最小值和最大值（不是真正的第一页和最后一页）       |
| prePage   nextPage   | 上一页和下一页，不存在则为0                                  |
| navigatePages        | 导航页码总数                                                   |
| navigatepageNums     | 导航页码列表                                                   |
| **list**             | **分页列表信息**                                             |



