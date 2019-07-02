---
title: python爬虫-html解析器BeautifulSoup
date: 2018-03-27 13:17:45
tags: 
- python
- 爬虫
categories: python
---

BeautifulSoup库是解析、遍历、维护“标签树”的功能库。
他的作用就是能获取到html里面的各个标签的内容。上次博客说的批量下载文件就可以靠它来解析页面批量获取url。

## 安装
ubuntu:
```shell
sudo pip install beautifulsoup4
```
windows:
```shell
pip install beautifulsoup4
```

## 使用
先看一个例子：
```python
# coding: UTF-8
import requests
url="http://www.baidu.com"
r=requests.get(url)
r.encoding=r.apparent_encoding
print(r.text)
```

结果：
![](http://img.blog.csdn.net/20180112230621192?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

上面的代码以前写过，就是获取百度的源代码。现在我们就通过这个源代码来学习beautifulsoup库的使用吧。

## soup.prettify()
对源代码进行美化（格式化）
```python
# coding: UTF-8
import requests
from bs4 import BeautifulSoup

url="http://www.baidu.com"
r=requests.get(url)
r.encoding=r.apparent_encoding
#将源代码保存到变量s里面
s=r.text
soup=BeautifulSoup(s,"html.parser")
s=soup.prettify()
print(s)
```

结果：（确实好看多了，有整齐的缩进了）

![](http://img.blog.csdn.net/20180112232112595?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

`from bs4 import ` 引入BeautifulSoup类

下面代码中构建了一个BeautifulSoup类型的对象，名为soup，参数为网页源代码和"html.parser"，表明是解析html的。它还可以解析xml。

```python
soup=BeautifulSoup(s,"html.parser")
```
上面的代码是通过字符串里面的源代码构建BeautifulSoup类对象,还可以像下面这样直接使用本地html文件创建BeautifulSoup类对象。

```python
soup=BeautifulSoup(open("a.html"),"html.parser")
```

## 基本元素说明
![](http://img.blog.csdn.net/20180112232707424?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 例子

*  title

标题标签

```python
print(soup.title)
```
结果：得到了title标签的文本内容

![](http://img.blog.csdn.net/20180112234121655?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

*  a

链接标签

```python
print(soup.a)
```

结果：
![](http://img.blog.csdn.net/20180112234401095?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

tips：有多个时只返回第一个

* name

显示标签的名字

```python
print(soup.a.name)
```

![](http://img.blog.csdn.net/20180112234847792?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

* parent

得到标签的父标签，是一个bs4.element.Tag对象。
我们可以通过获取子标签和父标签来遍历整个树。

```python
int soup.a.parent.name
print(soup.a.parent.parent.name)
print(soup.a.parent.parent.parent.parent.parent.name)
```

![](http://img.blog.csdn.net/20180112235157877?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

* attrs

得到标签属性，是一个字典

```python
print(soup.a.attrs)
```

![](http://img.blog.csdn.net/20180112235647871?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

如果要获取字典中的一个值，可以通过：

```python
print(soup.a.attrs["class"])
```

class是字典的一个key,返回它对应的value

![](http://img.blog.csdn.net/20180112235943811?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```python
print(soup.a.attrs["href"])
```

获取链接

`tips:在python里面可以用type()获取变量的类型`

* string

获取尖括号之间的字符串

```python
print(soup.a.string)
```

是一个bs4.element.NavigableString类型的对象

![](http://img.blog.csdn.net/20180113000642391?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

为了便于比较，附a的图：

![](http://img.blog.csdn.net/20180113000816811?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

* 小结

![](http://img.blog.csdn.net/20180113001536480?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

## html的遍历

![](http://img.blog.csdn.net/20180113001827560?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### contents

子节点的列表，list类型

```python
soup=BeautifulSoup("<body><p>1111</p><p>2222</p></body>","html.parser")
print(soup.body.contents)
```

![](http://img.blog.csdn.net/20180113002707264?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

得到列表元素：

```python
list=soup.body.contents
print(list[1])
```

![](http://img.blog.csdn.net/20180113003046485?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

`tips:index从0开始，list[0],list[1]`

### children

得到标签的子节点，为listiterator（迭代）类型

```python
for child in soup.body.children:
	print(child)
```

遍历儿子节点

![](http://img.blog.csdn.net/20180113003515253?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### parent

节点的父亲标签

### parents

先辈标签的迭代类型

### 平行遍历

（同一个父节点的标签之间）

![](http://img.blog.csdn.net/20180113004017403?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

* 总结

![](http://img.blog.csdn.net/20180113004422511?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

