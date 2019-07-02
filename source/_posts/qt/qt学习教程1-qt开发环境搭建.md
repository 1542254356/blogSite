---
title: qt学习教程1.qt开发环境搭建
date: 2018-04-15 23:24:27
tags: qt
categories: qt
---

<h1 style="text-align: center;">qt学习教程1.qt开发环境搭建</h1>
<h2>首先下载qt</h2>
<p>下载地址：<a href="http://download.qt.io/archive/qt/" target="_blank">http://download.qt.io/archive/qt/</a></p>
<p>此教程使用的版本为5.1.1</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/1xz.png?raw=true" alt="" /></p>
<p>下载好后，打开安装包，然后点下一步</p>
<p>选择一个位置来安装qt，系统盘不够用的就装在其他盘</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/2kshanzh.png?raw=true" alt="" /></p>
<p>选择同意</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/3ty.png?raw=true" alt="" /></p>
<p>然后接下来一路确定下一步。就安装好了。</p>
<h2>第一个项目</h2>
<p>&nbsp;打开qt</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/4dk.png?raw=true" alt="" /></p>
<p>点击左上角的文件-新建文件或项目</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/5newProject.png?raw=true" alt="" /></p>
<p>&nbsp;选择应用程序-Qt Gui应用，单击选择...</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/6selectQtGui.png?raw=true" alt="" /></p>
<p>填写名字，然后选择一个便于管理的地方，下一步</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/7inputName.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>一直下一步，最后点完成</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/8complete.png?raw=true" alt="" /></p>
<p>这样我们就建好一个工程了</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/9OK.png?raw=true" alt="" /></p>
<p>然后按左下角的运行按钮，或者直接Ctrl+F5运行，等待构建完成</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/10run.png?raw=true" alt="" /></p>
<p>构建好后，显示一个空白窗口</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/11xg.png?raw=true" alt="" /></p>
<h3>让我们为这个窗口加点东西</h3>
<p>打开界面文件里面的mainwindow.ui</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/12add.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>&nbsp;<img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/13doubleClick.png?raw=true" alt="" /></p>
<p>双击修改文字</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/14fixLable.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>&nbsp;hello world！</p>
<p>&nbsp;<img src="https://github.com/1542254356/FigureBed/blob/master/qt/qt%E5%AD%A6%E4%B9%A0%E6%95%99%E7%A8%8B1.qt%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA/15helloWorld.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
