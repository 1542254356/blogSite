---
title: 云服务器搭建java服务器运行环境
date: 2018-08-25 10:51:09
tags: linux
categories: linux
---

## 安装jdk

先下载jdk linux版本，[点击下载](http://www.oracle.com/technetwork/cn/java/javase/downloads/jdk8-downloads-2133151-zhs.html)

![](http://image.hjwblog.com/linux/buildJavaEnvironment/downloadJdk.jpg)

通过ftp上传文件到服务器。

![](http://image.hjwblog.com/linux/buildJavaEnvironment/UploadFtp.jpg)

### 解压jdk

```
tar -zxvf jdk-8u181-linux-x64.tar.gz
```

### 配置环境变量

如果你用的是服务器普通用户，编辑`~/.bashrc`文件，修改环境变量。

在文件的最后添加如下配置，将`JAVA_HOME`设置为jdk路径。



```
export JAVA_HOME=/home/hjw/app/jdk1.8.0_181
export PATH=$JAVA_HOME/bin:$PATH
export JAVA_BIN=$JAVA_HOME/bin
export JAVA_LIB=$JAVA_HOME/lib
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_LIB/tools.jar:$JAVA_LIB/dt.jar
```

然后运行`source ~/.bashrc`使得配置生效。

如果你用的是root用户，要修改`/etc/profile`文件，在最后添加上面的代码。

然后运行`source /etc/profile`使得配置生效。

然后运行`javac`或者`java`，如果没有出现`command not found`。则java就配置好了。


## 安装tomcat

点击此[地址](http://tomcat.apache.org/)下载tomcat。

![](http://image.hjwblog.com/linux/buildJavaEnvironment/downloadTomcat.jpg)

然后通过ftp上传到服务器，运行`tar -zxvf apache-tomcat-8.5.33.tar.gz`解压tomcat，根据自己下载的文件修改命令。

进入tomcat的bin目录，运行`./startup.sh`运行tomcat。



![](http://image.hjwblog.com/linux/buildJavaEnvironment/startTomcat.jpg)



此时在浏览器输入http://公网ip:8080 就可以打开tomcat页面了。
我这里使用了域名绑定了服务器公网ip。



![](http://image.hjwblog.com/linux/buildJavaEnvironment/testTomcat.jpg)



如果用的是阿里云，可能需要配置安全组策略来开发端口，可以参考阿里云文档。

### tomcat开机自启

修改脚本文件rc.local，这个脚本是使用者自定的开机启动程序，可以在里面添加想在系统启动之后执行的脚本或者脚本执行命令。

添加如下内容：

```
/home/hjw/app/apache-tomcat-8.5.33/bin/startup.sh 
```

授权

```
chmod 777 /etc/rc.d/rc.local
```


## 安装MySQL

### 安装MySQL

这里注意，腾讯云官方文档的安装命令安装出来的mysql是不能启动的，好像安装了mysql另一个分支，命令操作有区别

```
rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
```

```
yum -y install mysql-community-server
```

### 开机启动

```
systemctl enable mysqld
```

### 启动mysql服务

```
systemctl start mysqld
```

### 配置mysql

运行`mysql_secure_installation`

提示`Enter current password for root (enter for none):`由于是刚刚安装，直接按回车通过。

```
Set root password? [Y/n] y
```

输入y设置root密码

```
Remove anonymous users? [Y/n] y
```

删除匿名用户

```
Disallow root login remotely? [Y/n] y 
```

禁止root远程登录

```
Remove test database and access to it? [Y/n] y 
```

删除test数据库

```
Reload privilege tables now? [Y/n] y
```

刷新权限

### 如果运行上面的命令中途发生错误：`ERROR 1558 (HY000): Column count of mysql.user is wrong. Expected 43, found 39. `

运行`mysql_upgrade -uroot -p`

提示输入密码，刚刚安装直接回车。

### 进入mysql

```
mysql -uroot -p+密码
```

如密码为12345，输入

```
mysql -uroot -p12345
```

```
mysql> use mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
```

开启远程访问权限“%”代表所有人,12345是密码，root是用户名。


