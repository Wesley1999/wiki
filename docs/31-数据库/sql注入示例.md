# sql注入示例

```sql
"select * from students where name like '" + name + "%' and sex = '" +  sex + "'"
name = "王", sex = "男"

"select * from students where name like '王%' and sex = '男'"

name = "王'-- ", sex = "男"
"select * from students where name like '王%'-- ' and sex = '男'"

```

