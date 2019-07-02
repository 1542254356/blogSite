---
title: linux设定文件权限
date: 2018-03-28 14:59:14
tags: linux
categories: linux

---

## 设置可读可写可执行权限

```shell
chmod 777 fileName
```

如果可执行文件或者sh脚本没有可执行权限,会提示权限不够。

![](https://i.loli.net/2018/03/28/5abb38a28d4f0.png)





## 其他等级的权限



| 权限 | 文件所有者 | 组用户 | 其他用户 |
| :--: | :--------: | :----: | :------: |
| 444 | r-- | r-- | r-- |
|600| rw-|---|---|
|644| rw-|r--|r--|
|666 |rw-|rw-|rw-|
|700 |rwx|---|---|
|744| rwx|r--|r--|
|755| rwx|r-x|r-x|
|777| rwx|rwx|rwx|



