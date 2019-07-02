---
title: windows汇编环境配置
date: 2018-03-28 00:34:15
tags: 汇编
categories: 汇编
---

## 软件下载
需要的软件已经打包，包括dosbox和MASM。如果没有这两个软件可以在下面的地址下载。
`http://hjwblog.com/game/汇编环境.zip`    
[点击下载](http://hjwblog.com/game/汇编环境.zip)

## 安装dosbox

安装压缩包里面的`DOSBox0.74-win32-installer.exe`。

## 安装MASM

将压缩包里面的`MASM`文件夹里面的东西复制到一个文件夹，尽量路径为`D:\masm`。其他路径也可以，但是路径不要有中文和空格。
如下图：

![](https://github.com/1542254356/FigureBed/blob/master/%E6%B1%87%E7%BC%96/windows%E6%B1%87%E7%BC%96%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/1masm%E6%96%87%E4%BB%B6%E5%A4%B9.png?raw=true)

现在打开dosbox安装目录，如果记不得，就右键dosbox快捷方式。选择打开文件所在位置。

![](https://github.com/1542254356/FigureBed/blob/master/%E6%B1%87%E7%BC%96/windows%E6%B1%87%E7%BC%96%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/2%E5%8F%B3%E9%94%AE%E5%88%97%E8%A1%A8.png?raw=true)

现在进入了dosbox安装目录

![](https://github.com/1542254356/FigureBed/blob/master/%E6%B1%87%E7%BC%96/windows%E6%B1%87%E7%BC%96%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/3dosbox%E5%AE%89%E8%A3%85%E7%9B%AE%E5%BD%95.jpeg?raw=true)

然后双击`DOSBox 0.74 Options.bat`文件。如果你的电脑不显示扩展名，就看文件类型，双击类型为`windows批处理文件`那个。注意：不是用记事本打开，不是用记事本打开，不是用记事本打开。有人这样做了。。。

这时会打开一个记事本文件`dosbox-0.74.conf`,在文件最后加上下面的代码：

```shell
mount C D:\masm
C:
```

![](https://github.com/1542254356/FigureBed/blob/master/%E6%B1%87%E7%BC%96/windows%E6%B1%87%E7%BC%96%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/4conf%E6%96%87%E4%BB%B6%E5%A4%B9.jpeg?raw=true)

如果刚才那些exe文件没有解压到`D:\masm`文件夹下，只要将其修改为自己的文件夹就行了。

现在，保存文件后关闭，打开dosbox，输入`dir`。看看有没有DEBUG,MASM等文件。如果有的话就说明成功了，可以开始写汇编了。

![](https://github.com/1542254356/FigureBed/blob/master/%E6%B1%87%E7%BC%96/windows%E6%B1%87%E7%BC%96%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE/5dosbox%E7%95%8C%E9%9D%A2.jpeg?raw=true)

如果没有的话，可以留言或者咨询qq：1542254356。

## 进阶内容

### 上面加入的代码意思

```shell
mount C D:\masm
C:
```

mount的作用是将pc目录映射到dos系统的目录。这里是将你电脑的`D:\masm`映射到了dos系统c盘，这样你对dos的c盘的操作就相当于是对`D:\masm`做的。

第二行命令是进入dos的c盘。
其实可以不修改conf文件，只要在每次运行时输入这两个命令就行了。

### 为什么要修改dosbox的conf文件

dosbox的conf文件的[autoexec]标签下面的代码会在dosbox启动时运行，这样就不用在dosbox中每次输入代码了。
