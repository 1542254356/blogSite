---
title: linux压缩
date: 2018-03-28 14:20:12
tags: linux
categories: linux
---


## 压缩

### 压缩文件

```shell
tar -zcvf test3.tar.gz  test1 test2
```

此命令的作用是将文件test1和test2压缩为gz格式，并指定压缩后文件名为test3.tar.gz。

### 压缩目录

压缩目录，比如压缩名为test5的文件夹所有内容为test4.tar.gz。

```shell
tar -zcvf test4.tar.gz test5
```

### 混合压缩

```shell
tar -zcvf test4.tar.gz hh t1
```

![](https://i.loli.net/2018/03/28/5abb32718f5e3.png)

## 解压

```shell
tar -zxvf test4.tar.gz
```

解压了test4.tar.gz文件。
