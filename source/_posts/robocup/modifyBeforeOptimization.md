---
title: robocup-优化前修改
date: 2018-03-30 19:18:10
tags: robocup
categories: robocup
---

打开终端，输入

```shell
cd /usr/local/share/rcssserver3d/rsg/agent/nao/
sudo gedit naoneckhead.rsg
```

这时会打开一个文档，`ctrl+f`查找并修改`setSenseMyPos`,`setSenseMyOrien`,`setSenseBallPos`三个变量，全部修改为`true`.如图：

![](https://i.loli.net/2018/03/30/5abe1f9dded68.png)

保存后关闭gedit。

然后继续在终端输入：

```shell
cd ~
cd .simspark/
sudo gedit spark.rb
```

然后在打开的文件里面查找`agentSyncMode`,设为true。

![](https://i.loli.net/2018/03/31/5abefe915a24d.png)

保存并关闭。

然后继续在终端输入：

```shell
cd /usr/local/share/rcssserver3d/
sudo gedit rcssserver3d.rb 
```

然后在打开的文件里面查找`enableRealTimeMode`,设为false。



![](https://i.loli.net/2018/03/31/5abefd3524bf0.png)



保存并关闭。

然后继续在终端输入：

```shell
cd /usr/local/share/rcssserver3d/
sudo gedit naosoccersim.rb 
```

然后在打开的文件里面查找`BeamNoiseXY`和`BeamNoiseAngle`,设为0.

![](https://i.loli.net/2018/03/30/5abe2508604da.png)
