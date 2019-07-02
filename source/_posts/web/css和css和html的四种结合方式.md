---
title: css和css和html的四种结合方式
date: 2018-04-29 14:25:19
tags: css
categories: web开发
---

## 使用html标签的style属性

每个html标签上面都有一个属性:style,把css和html结合在一起

示例：设置字体背景颜色为红色，字体颜色为黄色。
```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>结合方式一</title>
	</head>
	<body>
		<div style="background-color: red;color: yellow;">hjwblog.com</div>
	</body>
</html>
```

## 使用html的style标签

此标签写在`<head>`标签里面。

示例：

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>结合方式二</title>
		<style type="text/css">
			div
			{
				background-color: blue;
				color: yellow;
			}
		</style>
	</head>
	<body>
		<div>hjwblog.com</div>
	</body>
</html>
```

## 在style标签里面@import

先创建一个css文件，这里是`mycss.css`，在css文件夹下面。

```html
/*
 * 这是注释
 */

div{
	background-color: yellow;
	color: blue;
}
```

然后html这样写

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>结合方式三</title>
		<style type="text/css">
			@import url("css/mycss.css");
		</style>
	</head>
	<body>
		<div>hjwblog.com</div>
	</body>
</html>

```

## 使用头标签 link

使用`<link>`标签

```c++
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>结合方式四</title>
		<link rel="stylesheet" type="text/css" href="css/mycss.css"/>
	</head>
	<body>
		<div>hjwblog.com</div>
	</body>
</html>

```

## 注意

第三种方式在有些浏览器不能正常显示，一般用第四种方式。



