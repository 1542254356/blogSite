---
title: python爬虫入门-开发环境与小例子
date: 2018-03-26 23:45:08
tags: 
- python
- 爬虫
categories: python
---



## 开发环境
* ubuntu 16.04
* sublime
* python3.6
  * 安装：`sudo apt install python`
* requests库
  * requests库安装：`sudo pip install requests`


## 第一个例子

```python
import requests
r=requests.get("http://www.baidu.com")
r.encoding="utf-8"
print(r.text)
```

运行结果如下，成功抓取了百度的源代码

![](http://img.blog.csdn.net/20180111221556494?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

现在来详细讲解

`import requests`
就是导入了requests库，这是一个爬虫库

`r=requests.get("http://www.baidu.com")`

 r是一个Response 对象。我们可以从这个对象中获取所有我们想要的信息。requests.get函数参数是url，返回值是一个Response 对象。

`r.encoding="utf-8"`

设置了网页编码，如果不加，汉字可能会乱码
![这里写图片描述](http://img.blog.csdn.net/20180111222621048?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

关于编码问题，`r.encoding`的值是通过解析html文本的编码声明得到的，而`r.apparent_encoding`是通过解析文本得到的，首选`r.encoding`，如果编码不对，则使用`r.apparent_encoding`的值。如下：

```python
r.encoding=r.apparent_encoding
```


`print r.text` :打印网页内容

## 获取请求状态码

```python
import requests
r=requests.get("http://hjwblog.com")
print(r.status_code)
```

运行结果

```
200
```

200表示访问成功,如果访问失败会抛出异常。



