---
title: Mybatis主键自增
date: 2019-02-25 09:12:49
tags: java
categories: java
---

# Mybatis主键自增



```xml
<insert id="insertRole" parameterType="role" useGeneratedKeys="true" keyProperty="id">
   insert into t_role(role_name,note) values (#{roleName},#{note})
</insert>
```

我们使用keyProperty属性指定id为主键字段，同时使用useGeneratedKeys属性告诉MyBatis这个主键是否使用数据库的内置规则生成。



然后，记得还要在数据库中设置自增规则。



而Mybatis的insert语句在指定了主键的情况下会返回新插入记录的主键的值。在这个例子里面，可以直接通过返回值获取新插入记录的id。