---
title: 云服务器搭建ftp
date: 2018-08-09 11:52:53
tags: linux
categories: linux
---


本文搭建环境为CentOS 7.2 64位腾讯云服务器，建议使用xshell代替网页版shell，复制粘贴方便。便于查看历史记录。

## 安装 VSFTPD

使用 yum 安装 [vsftpd]：

`yum install vsftpd -y`

![](http://image.hjwblog.com/linux/setUpFtp/installComplete.jpg)


## 启动 VSFTPD

安装完成后，启动 FTP 服务：

`service vsftpd start`

![](http://image.hjwblog.com/linux/setUpFtp/startVsftpd.jpg)

此时，访问 ftp:// 服务器公网IP  即可浏览服务器上的 /var/ftp 目录了。

在浏览器或者文件管理器地址栏输入上面的地址也可以可。如果超时，先暂时把防火墙关掉试试。

![](http://image.hjwblog.com/linux/setUpFtp/accessFtp.jpg)

有时候使用文件管理器是打不开的，这时候我们要使用专用的ftp软件，这里使用xftp。这样可以解决防火墙导致的问题。

![](http://image.hjwblog.com/linux/setUpFtp/xftpInput.jpg)

## 配置 FTP 权限

目前 FTP 服务登陆允许匿名登陆，也无法区分用户访问，我们需要配置 FTP 访问权限

vsftpd 的配置目录为 /etc/vsftpd，包含下列的配置文件：

- vsftpd.conf 为主要配置文件
- ftpusers 配置禁止访问 FTP 服务器的用户列表
- user_list 配置用户访问控制

### 阻止匿名访问

匿名访问会给服务器带来安全风险，我们把这个功能关闭。

`vim /etc/vsftpd/vsftpd.conf`

按i进入编辑模式，修改下面：

```
# 禁用匿名用户
anonymous_enable=NO

```

修改完成后按`ESC`键退出编辑模式，然后输入`:wq`保存并关闭文件。

重新启动 FTP 服务

```
service vsftpd restart
```

现在没有用户名和密码就登录不上了。

## 创建 FTP 用户

创建一个用户 ftpuser：

```
useradd ftpuser
```

为用户 ftpuser 设置密码:

```
echo "Password" | passwd ftpuser --stdin
```

现在登录ftp后进进入了`/home/ftp用户名/`目录。并且可以上传下载了。

![](http://image.hjwblog.com/linux/setUpFtp/ok.jpg)
