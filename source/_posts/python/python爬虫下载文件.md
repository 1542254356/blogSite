---
title: python爬虫下载文件
date: 2018-03-27 13:09:06
tags: 
- python
- 爬虫
categories: python
---

有时候大家遇到很多喜欢的图片或者音乐，想下载下来。但是一个个点多麻烦，要是能用爬虫下载下来就方便了。今天我们先来学习一下怎么在已有url的情况下下载文件。这也是批量下载的第一步。
下载东西和访问网页差不多,这里以下载我以前做的一个安卓小游戏为例
地址为:http://hjwachhy.site/game/only_v1.1.1.apk

## 首先下载到内存
```python
# coding: UTF-8
import requests
url="http://hjwachhy.site/game/only_v1.1.1.apk"
r=requests.get(url)
print ("ok")
print len(r.content)
```

![](http://img.blog.csdn.net/20180112220816743?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

这里是下载到内存,由于是二进制.所以是不能输出text的，`requests.content`返回的是二进制响应内容。`len`函数得到它的大小。

## 保存文件

```python
# coding: UTF-8
import requests
url="http://hjwachhy.site/game/only_v1.1.1.apk"
path="only.apk"
r=requests.get(url)
print("ok")
with open(path,"wb") as f:
	f.write(r.content)
f.close()
```

![](http://img.blog.csdn.net/20180112221350536?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
这里是保存到代码目录了,文件名为only.apk

然后看一下文件夹
![](http://img.blog.csdn.net/20180112221455992?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
下载成功了!

## 下首歌听听
写了这么久代码,是时候放松一下了,让我们来下载一首歌听听。只要修改上面代码的url和path变量就行了。
如下：

```python
# coding: UTF-8
import requests
url="http://hjwachhy.site/music.mp3"
path="music.mp3"
r=requests.get(url)
print ("ok")
with open(path,"wb") as f:
	f.write(r.content)
f.close()
```

好了，现在可以打开文件夹听下音乐了。
在以后的内容里，我会写关于批量获取url的内容，这样结合这里的下载文件内容。就能一次性下载很多东西了。
