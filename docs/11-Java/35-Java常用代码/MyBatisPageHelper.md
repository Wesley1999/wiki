# MyBatisPageHelper

```java
public PageInfo getAccountList(int pageNum, int pageSize) {
    // 记录开始
    PageHelper.startPage(pageNum, pageSize);
    // 填充查询逻辑
    List<Account> accounts = accountMapper.selectByExample(null);
    // 收尾
    PageInfo pageResult = new PageInfo(accounts);
    pageResult.setList(accounts);
    return pageResult;
}
```