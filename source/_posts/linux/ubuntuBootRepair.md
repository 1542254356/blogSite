---
title: ubuntu引导修复
date: 2018-10-17 15:08:25
tags: linux
categories: linux
---

过一段时间就要因为各种原因重装系统，每次都要修复ubuntu的引导。而启动盘进去没有中文输入法，有点不方便。并且有时候百度还不容易找到可以用的方法。整理一下，经常需要用。

首先，使用ubuntu启动盘进入试用模式。连接网络。

然后打开终端：

```
sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo apt-get update
sudo apt-get install -y boot-repair
boot-repair
```

点击Recommended repair

如果开机时grub出现了很多启动项。

可以编辑`/boot/grub/grub.cfg`

```
sudo gedit /boot/grub/grub.cfg
```

把以下的部分删除

```
### BEGIN /etc/grub.d/25_custom ###

menuentry "efi/EFI/Boot/bootx64.efi" {
search --fs-uuid --no-floppy --set=root d000ed6a-5303-40aa-a517-af50e807c0e9
chainloader (${root})/efi/EFI/Boot/bootx64.efi
}

menuentry "efi/EFI/ubuntu/MokManager.efi" {
search --fs-uuid --no-floppy --set=root d000ed6a-5303-40aa-a517-af50e807c0e9
chainloader (${root})/efi/EFI/ubuntu/MokManager.efi
}

menuentry "Windows UEFI recovery bootmgfw.efi" {
search --fs-uuid --no-floppy --set=root A603-846C
chainloader (${root})/EFI/Microsoft/Boot/bootmgfw.efi
}

menuentry "Windows Boot UEFI recovery" {
search --fs-uuid --no-floppy --set=root A603-846C
chainloader (${root})/EFI/Boot/bkpbootx64.efi
}

menuentry "EFI/ubuntu/MokManager.efi sda2" {
search --fs-uuid --no-floppy --set=root A603-846C
chainloader (${root})/EFI/ubuntu/MokManager.efi
}

menuentry "Windows UEFI recovery LrsBootmgr.efi" {
search --fs-uuid --no-floppy --set=root 7607-5674
chainloader (${root})/efi/Microsoft/Boot/LrsBootmgr.efi
}

menuentry "Windows Boot UEFI recovery bkpbootx64.efi" {
search --fs-uuid --no-floppy --set=root 7607-5674
chainloader (${root})/efi/Boot/bkpbootx64.efi
}
### END /etc/grub.d/25_custom ###
```

顺便可以修改`set default = "0"`来设置默认启动项，设置为默认启动windows