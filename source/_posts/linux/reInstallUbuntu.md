---
title: ubuntu重装后要做的事
date: 2018-09-21 11:37:04
tags: linux
categories: linux
---

前几天重装了ubuntu16.04，好多地方要修改，一个一个找太麻烦了。做个备份，以后方便。

## 换源

打开`系统设置`/`软件与更新`，下载自选择其他站点，选择阿里云的源或者选择最佳服务器。关闭时会更新。



## 删除libreoffice

```
sudo apt-get remove libreoffice-common 
```

## 删除Amazon的链接

```
sudo apt-get remove unity-webapps-common 
```

## 删掉基本不用的自带软件

```
sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install onboard deja-dup  
```

## 解决windows与ubuntu时间显示不一致

安装ubuntu后，会出现windows时间与真正时间相差8个小时。

```
#更新时间
sudo sudo apt-get install ntpdate
sudo ntpdate time.windows.com

#将时间更新到硬件上
sudo hwclock --localtime --systohc	
```

然后回windows，如果时间不对，设置好时间。下次切换系统时间就不会再变了。


## 截图

实现Ctrl+Alt+A选区截图功能。

进人系统设置/键盘/快捷键

![](http://image.hjwblog.com/linux/reInstallUbuntu/screenshot.png)

然后在如图所示的选区截图设置快捷键。

## typora安装

typora是很好用的markdown编辑器。

可以通过下面的命令安装，不过特别慢。我有个离线版的旧版本typora，急用的可以加qq或者email找我要。qq和邮箱在博客(hjwblog.com)页面左侧。

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

sudo add-apt-repository 'deb http://typora.io linux/'

sudo apt-get update

sudo apt-get install typora
```

安装后打开报错

```
FATAL:nss_util.cc(632)] NSS_VersionCheck("3.26") failed. NSS >= 3.26 is required. Please upgrade to the latest NSS, and if you still get this error, contact your distribution maintainer.
```

解决方法：

更新nss库

```
sudo apt-get install libnss3
```

## 安装搜狗输入法

自带的输入法联想功能有点弱。

先进人[此处](https://pinyin.sogou.com/linux/)下载安装包。

下载下来是deb包。

```
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
```

这时有报错

```
dpkg: 依赖关系问题使得 sogoupinyin 的配置工作不能继续：
 sogoupinyin 依赖于 libopencc2 | libopencc1；然而：
  未安装软件包 libopencc2。
  未安装软件包 libopencc1。
 sogoupinyin 依赖于 fcitx-libs (>= 4.2.7)；然而：
  未安装软件包 fcitx-libs。
 sogoupinyin 依赖于 libqtwebkit4 (>= 2.1.0~2011week13)；然而：
  未安装软件包 libqtwebkit4。

```

运行

```
sudo apt --fix-broken install
```

然后再重新安装就安装成功了。

重启后就切换到搜狗输入法了。可以点击右上角的输入法图标切换。


## 安装sublime-text 3

```
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer
```

不过有时候连不上，使用下面的deb包安装。

链接: http://pan.baidu.com/s/1kURLcZt 密码: acm6

```
sudo dpkg -i sublime-text_build-3126_amd64.deb
```

## 解决apt update很慢

安装了那么多软件，有些源的速度不稳定，很多时候卡在那些地址。比如`typora.io`,这样可以清空一下源。提高update的速度。

```
sudo gedit /etc/apt/sources.list
```

清空文件内容

然后打开` 系统设置`/`软件和更新` 。

在`ubuntu软件`选项卡里面，把`可从互联网下载`下面的选项勾选上，
然后在`下载自`选择`其他站点`，选择一个国内的服务器，比如阿里云。

然后在`其他软件`选项卡把下面的所有勾选取消。然后关闭 、更新。

## 安装wps

在[http://www.wps.cn/product/wpslinux/](http://www.wps.cn/product/wpslinux/)下载。

我下载了deb包。

```
sudo dpkg -i wps-office_10.1.0.6757_amd64.deb
```

### 修复字体库

打开wps后，提示字体库缺失。

下载地址：https://pan.baidu.com/s/1eS6xIzo

下载完成后，解压并进入目录中，继续执行：

```
sudo cp * /usr/share/fonts
```

执行以下命令,生成字体的索引信息：

```
sudo mkfontscale

sudo mkfontdir
```

运行fc-cache命令更新字体缓存。

```
sudo fc-cache
```

重启wps即可，字体缺失的提示不再出现。
