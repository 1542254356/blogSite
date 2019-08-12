---
title: Go获取代码当前位置
date: 2019-08-12 19:51:04
tags: Go
categories: Go
---

Go程序发生错误控制台不像java一样可以在控制台打印出错位置，有时候不知道错误发生的位置在哪里。

下面的函数可以获取出错位置。

```go
func fileLine() string {
	_, file, line, _ := runtime.Caller(1)
	return fmt.Sprintf("file:%s, line:%d \n", file, line)
}
```

效果如下

![效果](http://image.hjwblog.com/go/GoCurrentCodeLocation.png)