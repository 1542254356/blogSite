---
title: robocup实验室培训-gcc的基本使用
date: 2018-09-02 12:47:35
tags: robocup
categories: robocup
---

写给robocup机器人实验室的新成员

## 简单实例
先写一个普通的c++程序，命名为`main.cpp`

```c++
#include<iostream>

using namespace std;

int main(int argc, char const *argv[])
{
	cout<<"hjwblog.com"<<endl;
	return 0;
}
```

然后在控制台输入

```
g++ main.cpp
```

然后会生成一个名为`a.out`的文件，运行它。

```
./a.out
```

输出：

```
hjwblog.com
```

这样就完成了一个简单的单文件c++程序的编译。

## -o 指定可执行文件名称

上面我们编译出来的可执行文件名字是`a.out`，如果要指定它的名字。要使用`-o`参数。

使用下面的命令：

```
g++  main.cpp -o main
```

这样就生成了一个名为`main`的可执行文件。

运行：

```
./main
```

## -c 只编译不链接

-c  选项表示只编译，不链接成为可执行文件，生成.o为后缀的目标文件。

```
g++ -c main.cpp
```

这样会生成一个名为`main.o`的文件。生成的文件名字可以通过`-o`指定。

## 链接.o文件为可执行

刚才我们编译了一个`main.o`文件，输入下面的命令：

```
g++ main.o -o main
```

生成了一个名为`main`的可执行文件。

## 编译多个cpp文件

先写一个类，声明放`.h`文件，定义放`.cpp`文件，再通过main.cpp使用这个类。要求包含构造函数，析构函数，和至少一个普通函数。在所有函数里面都输出一点东西。

例如：

头文件要用如下的格式写

Test.h

```
#ifndef _TEST_H
#define _TEST_H
//头文件内容
#endif
```

这样可以通过预处理命令防止重复包含或者循环包含头文件。

Test.h

```
#ifndef _TEST_H
#define _TEST_H

class Test
{
public:
	Test();
	~Test();
	void say();
	
};

#endif
```

Test.cpp

```
#include "Test.h"
#include <iostream>

using namespace std;

Test::Test(){
	cout<<"Test created"<<endl;
}

Test::~Test(){
	cout<<"Test destroyed"<<endl;
}

void Test::say(){
	cout<<"hjwblog.com"<<endl;
}


```

main.cpp

```
#include "Test.h"

int main(int argc, char const *argv[])
{
	Test test;
	test.say();
	return 0;
}
```

然后输入：

```
g++ -c main.cpp
g++ -c Test.cpp
```

编译`.cpp`文件为`.o`文件。

```
g++ main.o Test.o -o say
```

将两个编译好的`.o`文件链接成为一个可执行文件`say`

运行：

```
./say

Test created
hjwblog.com
Test destroyed
```

运行`rm *.o`命令删除所有编译出来的`.o`文件。

运行`rm say`删除可执行文件。

之后输入下面的命令。

```
g++ main.cpp Test.cpp -o say
```

此命令可以一次性编译链接生成可执行文件。
