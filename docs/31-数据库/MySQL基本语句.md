# MySQL基本语句

[toc]

## 简介
MySQL是Oracle公司旗下免费小型关系型数据库，适合与Java搭配使用。
本文介绍MySQL数据库在命令行中的常用语句。


## 访问数据库
```SQL
mysql -u root -p
```

## 数据库操作语句
### 查看数据库
```SQL
show databases;
```
### 创建数据库
```SQL
create database 数据库名;
```
### 切换数据库
```SQL
use 数据库名;
```
### 删除数据库
```SQL
drop 数据库名;
```
	
## 表操作语句
### 创建表
```SQL
create table 表名(
	字段名 类型(长度) [约束],
	字段名 类型(长度) [约束]
);
```
### 查看表
```SQL
show tables;
```
### 查看表结构
```SQL
desc 表名;
```
### 删除表
```SQL
drop 表名;
```
### 修改表
#### 添加列
```SQL
alter table 表名 add 列名 类型(长度)  [约束];
```
#### 修改类型及约束
```SQL
alter table 表名 modify 列名 类型(长度) 约束;
```
#### 修改列名
```SQL
alter table 表名 change 旧列名 新列名  类型(长度) [约束];
```
#### 删除列
```SQL
alter table 表名 drop 列名;
```
#### 修改表名
```SQL
rename table 表名 to 新表名;
```
#### 修改字符集
```SQL
alter table 表名 character set 字符集;
```
		
## 数据操作语句
### 插入记录
```SQL
insert into 表 (列名1,列名2,...) values (值1,值2,...); --如果不写列名，表示向所有列插入值
```
### 更新记录
```SQL
update 表名 set 字段名=值,字段名=值...; --无条件
update 表名 set 字段名=值,字段名=值... where 条件; --有条件
```
### 删除记录
```SQL
delete from 表名 [where 条件];
```
	
## 单表查询 
### 简单查询
```SQL
select [distinct] 列名1,列名2,... from 表名;
```
### 条件查询
```SQL
select 列名1,列名2,... from 表名 where 条件;
```
### 排序
```SQL
select 列名1,列名2,... from 表名 order by 列名 asc|desc;
```
### 聚合
```SQL
select 聚合函数(列名) from 表名;
```
常用聚合函数
	
	求和：sum()
	平均：avg()
	最大：max()
	最小：min()
	计数：count()
		
### 分组
```SQL
select 分组名 from 表名 having 分组条件;
```
添加分组名：
```SQL
alter table 表名 add 分组名 类型(长度);
```
### 分页查询
```SQL
select * from 表名 参数m,参数n --第一个参数表示最先显示第m+1条记录，第二个参数表示显示n条记录
```
### 单表查询总结
```SQL
select [distinct] 字段
	from 表名
	where 条件
	group by 分组字段 having 分组条件
	order by 排序字段 asc|desc
```
	
## 外键
声明外键约束语句
```SQL
alter table 从表 add [constraint] [外键名称] foreign key(从表外键字段名) references 主表(主表的主键)
```
删除外键约束语句
```SQL
alter table 从表  drop foreign key 外键名称 -- 只有当声明外键约束指定了外键名称时才能用这种方法删除
```
从表不能添加主表中不存在的记录，主表不能删除从表中已经引用的记录。

## 多表连接查询
### 内连接查询
隐式内连接：
```SQL
select * from A,B where 条件;
```
显式内连接：
```SQL
select * from A inner join B on 条件; -- inner可以省略
```
### 外连接查询
左外连接：
```SQL
select * from A left outer join B on 条件;
```
右外连接：
```SQL
select * from A right outer join B on 条件;
```
左外连接查到的是左表的全部和两表的交集，右外连接查到的是右表的全部和两表的交集，内连接查到的是两表的交集。
数据完整时左连接和右连接相同；从表缺少外键时，使用右连接，右表的数据可以查到，左表数据为null；使用左连接，左表的数据可以查到，右表的数据为null。


## 子查询
一条select语句的结果作为另一条select语句的一部分，例如：
```SQL
select 字段1 from 表名 where 字段2=(select 字段3 from 表名 where 条件);
```