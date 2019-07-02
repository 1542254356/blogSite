---
title: 在网页加入自动启动QQ加好友链接
date: 2018-03-30 18:15:22
tags: web开发
categories: web开发
---

有时候我们想在网页里面展示自己的QQ，这时候如果有个点击后自动启动QQ加好友的链接就更方便了。腾讯提供了一个这样的接口。比如加我QQ的链接：

```ht
<a target="blank" href="http://wpa.qq.com/msgrd?v=3&uin=1542254356&Site=&Menu=yes">加我qq</a> 
```

<a target="blank" href="http://wpa.qq.com/msgrd?v=3&uin=1542254356&Site=&Menu=yes">戳这里加我qq</a> 

只要把uin=后面的QQ号换成自己的就可以让别人点链接加QQ了。

