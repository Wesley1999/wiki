# mapper中的模糊查询```xml
<select id="getMaintainersByBranchSchoolIdAndMaintainerName" resultMap="BaseResultMap" parameterType="com.iclass.vo.QueryVo">
  select
  <include refid="Base_Column_List" />
    from account left join maintainer_association on account.user_id = maintainer_association.maintainer_id
    <where>
        name like "%"#{name}"%"
    </where>
</select>
```

```
"%"#{name}"%"
```