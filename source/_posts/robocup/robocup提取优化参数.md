---
title: robocup提取优化参数
date: 2018-05-30 00:52:39
tags: robocup
categories: robocup
---

robocup动作参数优化时需要将文件里面键值对的数字部分提取为数组格式，手动删除替换太麻烦，在这里分享一个脚本，可以提取数据并进行简单统计。

代码：

[点击下载脚本](http://file.hjwblog.com/robocup/cut.py)

```c++
#!/usr/bin/env python
#coding=utf-8

import sys
f=open("optimizing.txt","r")
lines = f.readlines()
print 'There are ',len(lines),' sets of parameters','\n'
params=[]
for i in lines:
	params.append(i.split('\t')[1].split('\n')[0])
f.close()

f=open('outParams.txt','w')
f.write('[')
for i in range(len(params)):
	f.write(params[i])
	if(i<len(params)-1):
		f.write(',')
	if(i%5==4):
		f.write('\n')
f.write(']')
f.close()

```


