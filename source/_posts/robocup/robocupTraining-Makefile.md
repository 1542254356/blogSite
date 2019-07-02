---
title: robocup实验室培训-Makefile的使用
date: 2018-09-02 13:54:43
tags: robocup
categories: robocup
---

写给robocup机器人实验室的新成员

随着项目的增大，通过g++命令编译每一个源文件费时费力。于是出现了Makefile，使用Makefile，可以通过`make`命令直接编译出可执行文件。

## 一个简单的Makefile示例

创建一个源文件，名字随意，我这里是`main.cpp`。
新建一个名为`Makefile`的文件，里面写：

```
main: main.o
	g++ main.o -o main
main.o: main.cpp
	g++ -c main.cpp 
```

把终端切换Makefile目录下，运行命令`make`

生成了`main.o`和`main`可执行文件。

## Makefile基本格式

目标：依赖

【Tab】命令

以上称为一条规则

上面的Makefile中，有两条规则
- 冒号前的main和main.o是目标
- 冒号后的文件名代表依赖
  第一个规则的依赖是`main.o`，表示要生成`main`需要先生成`main.o`,第二个规则的依赖是`mian.cpp`。
- 目标和依赖下面这一行是命令
  通过这个命令得到目标


例子：

上次我们写了一个类，有3个文件。

在三个文件的目录下写如下Makefile:

```
say: main.o Test.o
	g++ main.o Test,o -o say
main.o: main.cpp
	g++ -c main.cpp
Test.o: Test.cpp
	g++ -c Test.cpp
```

运行`make`就能生成`say`可执行，以及两个`.o`编译文件。

## 伪目标

没有依赖只要执行动作的目标称为伪目标(phony targets)

```
.PHONY: clean
clean:
	rm -f say main.o Test.o
```

`.PHONY`将`clean`目标声明为伪目标。

添加伪目标后的完整makefile:

```
say: main.o Test.o
	g++ main.o Test,o -o say
main.o: main.cpp
	g++ -c main.cpp
Test.o: Test.cpp
	g++ -c Test.cpp
	
.PHONY: clean
clean:
	rm -f say main.o Test.o
```

此时运行`make`命令可以编译所有文件并生成可执行文件。
运行`make clean`命令可以删除生成的`.o`文件和可执行文件。
