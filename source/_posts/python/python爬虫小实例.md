---
title: python爬虫小实例
date: 2018-03-27 00:09:54
tags: 
- python
- 爬虫
categories: python
---

## 一个带异常处理的小例子
由于爬虫运行的时候可能会出现访问不成功，而获取失败程序就崩溃就不对了。也许我们可以忽略它或者发个通知呢。
代码如下：
```python
import requests
url="http://www.cnblogs.com/hjw1"
try:
	r=requests.get(url)
	r.raise_for_status()	
	print(r.encoding) 
	print(r.text) 
except:
	print("failed")
```

![](http://img.blog.csdn.net/20180112201530767?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

`r.raise_for_status()`的功能是判断返回的状态码，如果状态码不是200，则抛出异常

这里输出了一下网页编码，是utf-8可以正常输出，不用修改。如果编码不对造成中文乱码，可以用
`r.encoding=r.apparent_encoding`修改为解析的编码

## 解决网站爬虫限制
有些网站限制了网络请求的来源，来阻止爬虫。一般是通过`user-agent`属性来区分。
通过`print(r.request.headers)`来查看user-agent属性。

requests库写的代码默认user-agent是`python-requests/x.xx.x`(x表示版本号)。如果访问不成功，可尝试修改`user-agent`属性。
方法如下：
1. 先构建一个字典
`ua={"user-agent":"Mozilla/5.0"}`
其中"Mozilla/5.0"是浏览器的普遍标识。

2. 在get方法里面加一个参数
`r=requests.get(url,headers=ua)`
这时就可以模仿浏览器访问了。
完整代码：

```python
import requests
url="http://www.cnblogs.com/hjw1"
ua={"user-agent":"Mozilla/5.0"}
r=requests.get(url)
print(r.request.headers)
r=requests.get(url,headers=ua)
print(r.request.headers) 
```
结果：
![](http://img.blog.csdn.net/20180112204614722?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

## 爬虫获取百度搜索结果
### 方法一
百度搜索的搜索关键词是通过链接提交的，比如在百度搜索“环家伟”,答案页的链接为
```
https://www.baidu.com/s?wd=环家伟
```
这样就简单了，我们可以自己拼接url来实现百度搜索关键词提交
```python
# coding: UTF-8
import requests
url="http://www.baidu.com/s?wd="
wd="环家伟"
url=url+wd
r=requests.get(url)
print(r.text)
```
第一行里面`# coding: UTF-8`是声明编码的，不写的话编译器将不能识别中文。
重点是这句，字符串拼接一下
```python
url="http://www.baidu.com/s?wd="
wd="环家伟"
url=url+wd
```
这样就可以实现关键词提交
运行结果有点长，而且百度程序员还调皮的在代码代码加了很多换行。。。。

![](http://img.blog.csdn.net/20180112210555156?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

这样你打开就会很惊奇：百度程序员用两行代码写了一个网页？！！！
下面是运行结果：
![](http://img.blog.csdn.net/20180112210939066?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGp3MTU0MjI1NDM1Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 方法二
刚刚已经实现了百度关键词提交。现在讲另一个方法来提交关键词。
```python
 # coding: UTF-8
import requests
url="http://www.baidu.com/s"
kv={"wd":"环家伟"}
r=requests.get(url,params=kv)
r.encoding="utf-8"
print(r.text[:2000])
```

其中,这个网页不设置r.encoding是乱码的,所以设为utf-8
提交搜索词的方法也是构建一个字典键值对
```python
kv={"wd":"环家伟"}
```
然后通过get方法传进去
```python
r=requests.get(url,params=kv)
```
`r.text[:2000]`是取字符串0-2000的部分
`tips:可以通过r.request.url来查看生成的链接`
