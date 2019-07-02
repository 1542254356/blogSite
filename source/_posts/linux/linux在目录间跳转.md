---
title: linux在目录间跳转
date: 2018-03-26 20:04:27
tags: linux
categories: linux
---

示例：/home文件夹下面有USA和Tsinghua两个文件夹，假设当前工作目录为/home/USA，如何切换到Tsinghua呢?

- 切换目录使用`cd`命令，输入`cd ../`切换到上一层目录，这里是/home。
- 然后输入`cd Tsinghua`命令切换到Tsinghua文件夹里面。
- 总结：`cd + 目录名`进入指定目录，`cd ../`退出一层目录
