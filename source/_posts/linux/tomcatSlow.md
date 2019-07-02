---
title: 腾讯云服务器启动tomcat慢导致浏览器无法加载
date: 2018-08-26 02:16:51
tags: linux
categories: linux
---

## 系统环境

- 腾讯云服务器
- CentOS 7.2

## 问题描述

通过URL访问网站迟迟加载不出来，一直处于等待响应状态，通过命令查看tomcat的启动日志发现tomcat启动时间很长。

## 问题分析

通过仔细观察日志，tomcat启动主要是卡在了初始化 Session步骤。通过搜索和分析，Tomcat 的 SessionID 是通过 SHA1PRNG 算法计算得到的，SHA1 算法需要一个密钥，这个密钥在 Tomcat 启动的时候随机生成一个，生成是使用了 Linux 随机函数生成器/dev/random。读取它相当于生成随机数字。搜索/dev/random，大概知道是什么鬼了：/dev/random会根据 噪音 产生随机数，如果噪音不够它就会阻塞。Linux 是通过 I/O，键盘终端、内存使用量、CPU 利用率等方式来收集噪音的，如果噪音不够生成随机数的时候就会被阻塞，所以tomcat启动巨慢无比。

## 解决方案

### 方案一：使用伪随机函数生成器

使用伪随机函数生成器/dev/unrandom，/dev/urandom并不是真正的随机行为(其实一般不容易重复)，主要有两个地方可以修改。

- 通过修改 Tomcat 启动文件 -Djava.security.egd=file:/dev/urandom
- 通过修改 JRE 中的 java.security 文件 securerandom.source=file:/dev/urandom

### 方案二：加大/dev/random的熵池（推荐）

问题的原因是由于熵池不够大，所以增大它是最彻底的方法。我们可以通过软件的方法实现，下面是软件的安装和配置流程。

```
1.安装熵服务

yum install rng-tools


2.启动熵服务

systemctl start rngd


3.如果你的 CPU 不支持 DRNG 特性或者像我一样使用虚拟机，可以使用/dev/unrandom来模拟。

cp /usr/lib/systemd/system/rngd.service /etc/systemd/system   

vim /etc/systemd/system/rngd.service  

#以下是编辑内容

ExecStart=/sbin/rngd -f -r /dev/urandom


4.重新载入服务

systemctl daemon-reload

systemctl restart rngd
```

经过上面的修改，我们再观察 /proc/sys/kernel/random/entropy_avail 基本上在 3000 左右。这个时候重新启动 Tomcat，发现启动时间正常。


点击[查看原文](https://blog.csdn.net/qq_16313365/article/details/70799547)
