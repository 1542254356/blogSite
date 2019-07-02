---
title: 去掉快捷方式后面的快捷方式四个字
date: 2018-09-22 11:59:18
tags: windows
categories: windows
---


新装的系统，创建快捷方式的时候会在后面加四个字。

想去掉它只要修改注册表，在`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer`注册表项里面找到`link`。将其值改为`00 00 00 00`。没有的话可以新建一个。

![](http://image.hjwblog.com/windows/changeLink/changeLink.jpg)

也可以直接bat脚本：

```
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer /v link /t REG_BINARY /d "00000000" /f
taskkill /f /im explorer.exe
start explorer
```

新建一个txt，复制到里面，然后修改扩展名为bat。双击运行。

想改回来的话就运行这个：

```
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer /v link /t REG_BINARY /d "001A0000" /f
taskkill /f /im explorer.exe
start explorer
```

顺便附带两个写好的脚本。

[去掉快捷方式](http://image.hjwblog.com/windows/changeLink/%E5%8E%BB%E6%8E%89%E5%BF%AB%E6%8D%B7%E6%96%B9%E5%BC%8F.bat)

[加上快捷方式](http://image.hjwblog.com/windows/changeLink/%E5%8A%A0%E4%B8%8A%E5%BF%AB%E6%8D%B7%E6%96%B9%E5%BC%8F.bat)