---
title: Spring源码阅读-环境搭建
date: 2019-09-06 08:59:23
tags: spring
categories: spring
---



## 获取代码仓库链接

首先，我们找到 Spring 的 github 仓库`https://github.com/spring-projects/spring-framework`。

![img](springSourceNote-environment/1.1.jpg)

复制链接。

![1567522921028](springSourceNote-environment/1567522921028.png)

## 导入到idea

打开 IDEA , 如下图操作。

![1567523061167](springSourceNote-environment/1567610069060.png)

然后粘贴刚刚复制的仓库地址，选择一个位置

![1567525157658](springSourceNote-environment/1567525157658.png)

等待 clone 代码。

![1567524909579](springSourceNote-environment/1567524909579.png)

然后导入。

![1567524993860](springSourceNote-environment/1567524993860.png)

等待导入依赖。

![1567525092625](springSourceNote-environment/1567525092625.png)

我看的是5.0.x，checkout一下。

[![1567610401551](springSourceNote-environment/1567610401551.png)

这时候 gradle import 可能报下面的错误。

![1567610487024](springSourceNote-environment/1567610487024.png)

这是因为 Gradle 版本不兼容。

打开 `gradle/wrapper/gradle-wrapper.properties` 文件，这里显示 gradle 版本是4.4.1。

![1567610581071](springSourceNote-environment/1567610581071.png)

将设置里面 use Gradle from 改成 `gradle-wrapper.properties`,IDEA 会自动下载需要的 Gradle。

![1567610697188](springSourceNote-environment/1567610697188.png)

导入包的过程很慢，可以配一下国内仓库来加快下载速度。打开`build.gradle`文件。在`repositories`标签里面加入`maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }`。

![1567611009107](springSourceNote-environment/1567611009107.png)

耐心等待 build。

![1567611035050](springSourceNote-environment/1567611035050.png)

然后根目录有一个`import-into-idea.md`文件，需要运行一个任务。我们运行一下。

![1567651009518](springSourceNote-environment/1567651009518.png)

![1567651102527](springSourceNote-environment/1567651102527.png)

然后`Reimport`一下。

![1567651147950](springSourceNote-environment/1567651147950.png)

最后是这个样子的。

![1567651220319](springSourceNote-environment/1567651220319-1567991114930.png)