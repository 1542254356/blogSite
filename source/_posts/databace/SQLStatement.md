---
title: MySQL语句
date: 2018-08-26 02:14:23
tags: 数据库
categories: 数据库
---

## 登录

```
mysql -u root -p 123 -h localhost
```

- -u：后面的root是用户名，这里使用的是超级管理员root
- -p：后面的123是密码，这是在安装MySQL时就已经指定的密码
- -h：后面给出的localhost是服务器主机名，它是可以省略的，例如：`mysql -u root -p 123`

## 退出

`quit`或`exit`；

## 查看所有数据库

```
SHOW DATABASES;
```

## 切换数据库

```
USE mydb1;
```

切换到mydb1数据库

## 创建数据库

```
CREATE DATABASE [IF NOT EXISTS] mydb1
```

创建数据库，例如：CREATE DATABASE mydb1，创建一个名为mydb1的数据库。如果这个数据已经存在，那么会报错。例如CREATE DATABASE IF NOT EXISTS mydb1，在名为mydb1的数据库不存在时创建该库，这样可以避免报错。

## 删除数据库

```
DROP DATABASE [IF EXISTS] mydb1;
```

删除数据库，例如：DROP DATABASE mydb1，删除名为mydb1的数据库。如果这个数据库不存在，那么会报错。DROP DATABASE IF EXISTS mydb1，就算mydb1不存在，也不会的报错。

##  修改数据库编码

```
ALTER DATABASE mydb1 CHARACTER SET utf8;
```

修改数据库mydb1的编码为utf8。注意，在MySQL中所有的UTF-8编码都不能使用中间的“-”，即UTF-8要书写为UTF8。

## 数据类型

常用类型：

-  int：整型

-  double：浮点型，例如double(5,2)表示最多5位，其中必须有2位小数，即最大值为999.99；

-  decimal：泛型型，在表单钱方面使用该类型，因为不会出现精度缺失问题；

-  char：固定长度字符串类型；

-  varchar：可变长度字符串类型；

-  text：字符串类型；

-  blob：字节类型；

-  date：日期类型，格式为：yyyy-MM-dd；

-  time：时间类型，格式为：hh:mm:ss

-  timestamp：时间戳类型；


## 创建表

```
CREATE TABLE 表名(
  列名 列类型,
  列名 列类型,
  ......
);
```

例如：

```
CREATE TABLE stu(
	sid	    CHAR(6),
	sname	VARCHAR(20),
	age		INT,
	gender	VARCHAR(10) 
);


CREATE TABLE emp(
	eid		CHAR(6),
	ename	VARCHAR(50),
	age		INT,
	gender	VARCHAR(6),
	birthday	DATE,
	hiredate	DATE,
	salary	DECIMAL(7,2),
	resume	VARCHAR(1000)
);
```

## 查看当前数据库中所有表名称

```
SHOW TABLES;
```

## 查看指定表的创建语句

```
SHOW CREATE TABLE emp;
```

查看emp表的创建语句

## 查看表结构

```
DESC emp;
```

查看emp表结构

## 删除表

```
DROP TABLE emp;
```

删除emp表

## 修改表

### 添加列

给stu表添加classname列：

```
ALTER TABLE stu ADD (classname varchar(100));
```

### 修改列类型

修改stu表的gender列类型为CHAR(2)：

```
ALTER TABLE stu MODIFY gender CHAR(2);
```

### 修改列名

修改stu表的gender列名为sex：

```
ALTER TABLE stu change gender sex CHAR(2);
```

### 删除列

删除stu表的classname列：

```
ALTER TABLE stu DROP classname;
```

### 修改表名称

修改stu表名称为student：

```
ALTER TABLE stu RENAME TO student;
```

## 插入数据

`INSERT INTO 表名(列名1,列名2, …) VALUES(值1, 值2)`

如：

```
INSERT INTO stu(sid, sname,age,gender) VALUES('s_1001', 'zhangSan', 23, 'male');

INSERT INTO stu(sid, sname) VALUES('s_1001', 'zhangSan'); 
```

INSERT INTO 表名 VALUES(值1,值2,…)

因为没有指定要插入的列，表示按创建表时列的顺序插入所有列的值：

```
INSERT INTO stu VALUES('s_1002', 'liSi', 32, 'female');
```

注意：所有字符串数据必须使用单引用！

## 修改数据

`UPDATE 表名 SET 列名1=值1, … 列名n=值n [WHERE 条件];`

```
UPDATE stu SET sname=’zhangSanSan’, age=’32’, gender=’female’ WHERE sid=’s_1001’;

UPDATE stu SET sname=’liSi’, age=’20’ WHERE age>50 AND gender=’male’;

UPDATE stu SET sname=’wangWu’, age=’30’ WHERE age>60 OR gender=’female’;

UPDATE stu SET gender=’female’ WHERE gender IS NULL;

UPDATE stu SET age=age+1 WHERE sname=’zhaoLiu’;
```


## 删除数据

`DELETE FROM 表名 [WHERE 条件];`

```
DELETE FROM stu WHERE sid=’s_1001’003B;

DELETE FROM stu WHERE sname=’chenQi’ OR age > 30;

DELETE FROM stu; 
```

`TRUNCATE TABLE 表名;`

```
TRUNCATE TABLE stu; 
```

虽然TRUNCATE和DELETE都可以删除表的所有记录，但有原理不同。DELETE的效率没有TRUNCATE高！
TRUNCATE其实属性DDL语句，因为它是先DROP TABLE，再CREATE TABLE。而且TRUNCATE删除的记录是无法回滚的，但DELETE删除的记录是可以回滚的（回滚是事务的知识！）。


## 创建用户

`CREATE USER 用户名@地址 IDENTIFIED BY '密码';`

```
CREATE USER user1@localhost IDENTIFIED BY ‘123’; 

CREATE USER user2@’%’ IDENTIFIED BY ‘123’; 
```

## 给用户授权

`GRANT 权限1, … , 权限n ON 数据库.* TO 用户名;`

```
GRANT CREATE,ALTER,DROP,INSERT,UPDATE,DELETE,SELECT ON mydb1.* TO user1@localhost;

GRANT ALL ON mydb1.* TO user2@localhost;
```

## 撤销授权

`REVOKE权限1, … , 权限n ON 数据库.* FORM 用户名;`

```
REVOKE CREATE,ALTER,DROP ON mydb1.* FROM user1@localhost;
```

## 查看用户权限

`SHOW GRANTS FOR 用户名;`

```
SHOW GRANTS FOR user1@localhost;
```

## 删除用户

`DROP USER 用户名;`

```
DROP USER user1@localhost;
```

## 修改用户密码

```
USE mysql;
UPDATE USER SET PASSWORD=PASSWORD(‘密码’) WHERE User=’用户名’ and Host=’IP’;
FLUSH PRIVILEGES;
```

```
UPDATE USER SET PASSWORD=PASSWORD('1234') WHERE User='user2' and Host=’localhost’;
FLUSH PRIVILEGES;
```
