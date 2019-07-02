---
title: ubuntu开机自动挂载硬盘
date: 2018-10-16 14:14:50
tags: linux
---

ubuntu开机时是不会自动挂载硬盘的，需要我们手动挂载。这样我们为其他硬盘文件创建的桌面快捷方式就会找不到文件。要先手动进文件管理里面挂载一下才行。

要配置开机自动挂载硬盘，可以修改`/etc/fstab`文件。

```
sudo vim /etc/fstab
```

文件结构如下：

```
# <file system> <mount point>   <type>  <options>       <dump>  <pass>

UUID=118b6eaa-3128-48f0-8786-a2400ee0a336 /            ext4    errors=remount-ro 0       1
UUID=273a0f48-731e-44b2-ad62-2f6d6a88dcce /home        ext4    defaults        0       2
UUID=73b73739-c846-435f-a211-b5d56273f83c none         swap    sw              0       0
UUID=90f9fe49-d6a0-4916-ab92-2288ec38c47c       /boot   ext4    defaults        0       2
UUID=0003-C6B8  /boot/efi       vfat    defaults        0       1
```

上面是一个表格有6列：

- file system ：设备文件名称
可以是设备文件名称（即/dev/xxx），也可以是设备的label或uuid。
- mount point：挂载点
就是在硬盘在系统中的位置
- type ：文件系统类型
ubuntu上用的一般是ext4，windows的一般的ntfs
- options：挂载选项
一般设置为defaults
- dump：是否备份
一般设置为0，即不备份
- pass：开机时是否对文件系统进行自检
一般设置为2。如果不想自检，那就设置为0，挂载点为根目录的设备，设置为1，其它需要自检的设备，设置为2

然后我们只要把要挂载的硬盘信息填入上面的表就可以了。

查看分区信息

```
sudo blkid
```

```
/dev/sda8: UUID="73b73739-c846-435f-a211-b5d56273f83c" TYPE="swap" PARTUUID="81c794bb-c515-45f5-96c1-1b0dcf1524ff"
/dev/sda1: SEC_TYPE="msdos" UUID="0003-C6B8" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="ca6e015b-a379-4930-9638-3bca7970ff23"
/dev/sda2: PARTLABEL="Microsoft reserved partition" PARTUUID="1f1a5dc8-d569-4272-8d36-3f475e5cf45c"
/dev/sda3: LABEL="win8" UUID="48A40E03A40DF3EA" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="037858a6-9ae4-4030-ab88-e773a5d8c616"
/dev/sda4: UUID="9E82F6C682F6A1C7" TYPE="ntfs" PARTUUID="cc0f63e3-c0ca-47c5-b634-3a1e15c2d093"
/dev/sda5: LABEL="E" UUID="3CB4EABBB4EA7734" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="739fdf96-7c61-469b-9e97-12131fc2a476"
/dev/sda6: UUID="A2E63146E6311C4B" TYPE="ntfs" PARTUUID="2b73b3f1-cd65-47db-8b8f-0a94cd71a2e0"
/dev/sda7: LABEL="software" UUID="0006F5E7000D7807" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="46144c1a-0844-4206-ad8a-5d6ca4c43d90"
```

通过这里的信息找到自己要挂载的盘，这里我是通过LABEL找到的。

如果找不到，也可以使用`sudo fdisk -l`通过容量来找。

新建一个文件夹用于挂载硬盘：

```
sudo mkdir /media/E
```

这里我挂载E盘这样填：

```
LABEL="E" /media/E ntfs defaults 0 2
```

没有设置label可以用uuid

修改完/etc/fstab文件后

```
sudo mount -a
```
