---
title: ubuntu添加新分辨率
date: 2019-07-14 21:05:35
tags: ubuntu
categories: ubuntu
---

有时候ubuntu会没有某个分辨率，比如我在接入显示器时，和在虚拟机中都遇到过没有对应分辨率的问题。

环境是Ubuntu 16.04。



```shell
cvt 1920 1080
xrandr --newmode "1920X1080_60.00" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 "1920X1080_60.00"
xrandr --output Virtual1 --mode "1920X1080_60.00"
```

运行上面的命令就可以加一个1920X1080的分辨率。

重新启动可能会出现分辨率又没了，可以在`/etc/profile`文件最后加入上面的命令。



参考资料:[https://www.jianshu.com/p/6d32b166f47d](https://www.jianshu.com/p/6d32b166f47d)