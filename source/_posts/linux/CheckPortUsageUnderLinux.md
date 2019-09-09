---
title: 查看Linux端口占用
date: 2019-08-13 20:27:04
tags: linux
categories: linux
---

`sudo netstat -ntulp` 

![1567690423336](CheckPortUsageUnderLinux/1567690423336.png)



`-t` 显示TCP端口

`-u `显示UDP端口

`-l` 仅显示监听套接字

`-p` 显示进程标识符和程序名称

`-n` 不进行DNS轮询，显示IP

有时候公司 IDC 环境打开的端口数特别多，可以配合 `grep` 命令筛选。

 ![1567690848505](CheckPortUsageUnderLinux/1567690848505.png)

![1567690878929](CheckPortUsageUnderLinux/1567690878929.png)