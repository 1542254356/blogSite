---
title: css的选择器
date: 2018-04-29 14:38:54
tags: css
categories: web开发
---

选择器：要对哪个标签里面的内容进行操作

## 基本选择器

### 标签选择器

使用标签名作为选择器的名称。

此示例对不同的标签设置了不同的字体颜色和背景颜色。

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>css基本选择器一</title>
		<style type="text/css" >
			div{
				background-color: yellow;
				color: blue;
			}
			
			p{
				background-color: red;
				color: gray;
			}
		</style>
	</head>
	<body>
		<div>hjwblog.com</div>
		<p>hjwblog.com</p>
	</body>
</html>
```

### class选择器

每个html标签都一个class属性

可以使用`标签名.类名{}`对指定标签里面的指定class进行格式设置

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>css基本选择器二</title>
		<style type="text/css" >
			div.hjw{
				background-color: black;
				color: red;
			}
		</style>
	</head>
	<body>
		<div class="hjw">hjwblog.com</div>
	</body>
</html>
```

可以通过`.类名{}`指定有相同class名的不同标签的格式。

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>css基本选择器二</title>
		<style type="text/css" >
			.hjw{
				background-color: black;
				color: red;
			}
		</style>
	</head>
	<body>
		<div class="hjw">hjwblog.com</div>
		<p class="hjw">hjwblog.com</p>
	</body>
</html>
```

### id选择器

每个html标签上面都有一个属性`id`

使用`标签名#id{}`来设置指定标签下指定id内容的格式

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>css基本选择器三</title>
		<style type="text/css" >
			div#hjw{
				background-color: yellow;
				color: red;
			}
		</style>
	</head>
	<body>
		<div id="hjw">hjwblog.com</div>
	</body>
</html>

```

使用`#id名{}`来设置所有指定id的标签格式。
