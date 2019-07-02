---
title: STL的熟悉与使用
date: 2018-05-30 20:38:51
tags: 数据结构与算法
categories: 数据结构与算法
---


## 练习 vector和 list 的使用

### vector

要使用vector，要先include

```c++
#include<vector>
```

并且要设置命名空间std

```c++
using namespace std;
```

- 定义一个空的 vector，元素类型为 int

```c++
vector<int> v;
```

- 生成 10 个随机数插入到 vector 中

生成随机数使用`rand()`函数，要`#include<stdlib.h>`

但是这样生成的伪随机数每次运行都是相同的，所以要改变随机数种子

```c++
srand((unsigned)time(NULL));
```

上面的代码使用了程序运行的时间作为随机数种子，可以保证生成不同的随机数序列

由于使用了`time`函数，要`#include<time.h>`

```c++
    for(int i=0;i<10;i++)
    {
        int r=rand()%1000;  //生成0到999的随机数
        v.push_back(r);     //将r添加到数组尾部
    }
```

- 用迭代器遍历vector并输出其中的元素值。


```c++
    for(vector<int>::iterator it=v.begin();it!=v.end();it++)
    {
        cout<<*it<<" ";
    }
    cout<<endl;
```

这里可以认为`vector<int>`是一个类，这个类里面有一个`iterator`类，这个类重载了`++`运算符,可以方便的实现将迭代器指向下一个元素。

迭代器可以像指针一样解引用。也可以使用`->`运算符。可以和指针用法对应着记忆。

`v.begin()`返回指向第一个元素的迭代器，`v.end()`是返回指向最后一个元素后面一个位置的迭代器，不是最后一个元素。所以不要对`end()`进行解应用。

访问最后一个元素可以使用`*(v.end()-1)`。

上面的代码太麻烦了，特别是迭代器的定义，可以使用c++的`auto`关键字来代替复杂的类型声明。

```
    for(auto it=v.begin();it!=v.end();it++)    {        cout<<*it<<" ";    }    cout<<endl;
上面的代码可能在codeblocks上面报错，解决方法是`Setting->Compiler`,然后在“Have g++ follow the C++11 ISO C++ language standard [-std=c++11]” 选项上打勾 保存就可以了。
```

- 在vector头部插入一个随机数， 用迭代器遍历vector并输出其中的元素值。

```c++
    int r=rand()%1000;
    v.insert(v.begin(),r);
    for(vector<int>::iterator it=v.begin();it!=v.end();it++)
    {
        cout<<*it<<" ";
    }
    cout<<endl;
```

vector的insert() 函数有以下三种用法: 

在指定位置loc前插入值为val的元素,返回指向这个元素的迭代器, 
在指定位置loc前插入num个值为val的元素 
在指定位置loc前插入区间[start, end)的所有元素 .

这里使用了第一种重载形式，在第一个元素的位置`v.begin()`前面加一个数字。

- 用泛型算法 find 查找某个随机数，如果找到便输出，否则将此数插入 vector尾部。

`find()`可以查找一个元素在容器的位置，如果存在，会返回指向这个元素的迭代器，如果没有找到，会返回`end()`.

```c++
    r=rand()%1000;
    cout<<"查找"<<r<<endl;
    vector<int>::iterator result=find(v.begin(),v.end(),r);
    if(result==v.end())
    {
        cout<<"没有找到"<<endl;
        v.push_back(r);
    }else
    {
        cout<<"找到了元素"<<*result<<endl;
    }
```

是不是报错了？因为你忘记了`#include<algorithm>`

find函数有3个参数，前两个是查找区间的开始和结束迭代器，区间是左闭右开`[)`。也就是在查找前9个元素的时候，要使用`[0,10)`。

- 用泛型算法 sort将 vector排序，用迭代器遍历 vector并输出其中的元素值

`sort`函数可以将区间内的元素按升序排序。如果要实现降序排序，需要自定义排序函数或者使用反向迭代器。

```c++
    sort(v.begin(),v.end());    //升序
    out(v);
    sort(v.begin(),v.end(),less <int>());   //升序
    out(v);
    sort(v.begin(),v.end(),greater<int>()); //降序
    out(v);
    sort(v.rbegin(),v.rend());              //降序
    out(v);
```

out是定义的一个输出vector<int>函数

```c++
void out(vector<int>& v)
{
    for(auto it=v.begin();it!=v.end();it++)
    {
        cout<<*it<<" ";
    }
    cout<<endl;
}
```

反向迭代器可以从末尾元素为起点`begin()`，第一个元素前面一个地方为终点遍历。
升序排序只要将其替换为反向迭代器就可以实现降序排序。

- 删除 vector尾部的元素

```c++
v.pop_back();
```

说了输出尾部，说一下删除任意位置的方法。

```c++
    std::vector<int>::iterator it = v.begin()+5; //得到下标为5的元素迭代器
    v.erase(it);        //删除下标为5的元素
```

都是vector是顺序存储结构，插入或者删除中间元素需要将后面的元素都移动。所以效率较低，对于需要频繁插入删除的情况，不适合使用vector，应该选用链表存储结构的list。

- 将 vector清空

```c++
v.clear();
```

### list

- 定义一个空的 list，元素类型为 int

```c++
list<int> l;
```

- 生成 10 个随机数插入到 list 中，

```c++
for(int i=0;i<10;i++)
    {
        l.push_back(rand()%1000);
    }
```

- 用迭代器遍历list并输出其中的元素值

```c++
void out(list<int> l)
{
    for(list<int>::iterator it=l.begin();it!=l.end();it++)
    {
        cout<<*it<<" ";
    }
    cout<<endl;
}
```

重载一个out

- 在list头部插入一个随机数

```c++
l.insert(l.begin(),rand()%1000);
```

顺便说一下在指定位置插入，如在下标为5的元素的位置前插入一个数。

```c++
    list<int>::iterator it=l.begin();
    for(int i=0;i<5;i++) ++it;
    l.insert(it,100);
```

vector的迭代器重载了`+`运算符，所以可以直接`v.begin()+5`

而list是没有重载这个运算符的，只能循环`++`

这里是因为线性表的随机访问复杂度是O(1)，而链表的随机访问是O(n)的，线性表迭代器+一个数只要计算一次就行了，而链表+n就要循环n次。可能是防止有人把链表当线性表用，才没有写这些复杂度O(n)的方法吧。

- 用泛型算法 find 查找某个随机数，如果找到便输出，否则将此数插入 list尾部

```c++
int r=rand()%1000;
    list<int>::iterator result=find(l.begin(),l.end(),r);
    if(it==l.end())
    {
        cout<<"没有找到"<<endl;
        l.push_back(r);
    }else
    {
        cout<<"找到了"<<*result<<endl;
    }
```

- 用泛型算法 sort将 list排序

```c++
l.sort();   //升序
```

list降序

```c++
l.sort(greater<int>());
```

也可以先定义一个函数

```c++
bool cmp(int a,int b)
{
    return a>b;
}
```

然后将函数名作为`sort`的参数传递进去

```c++
l.sort(cmp);
```

这种可以用于类或者结构体的排序，如实现多级排序，一个属性相同，根据另一个属性排序。

- 删除 list尾部的元素

```c++
l.pop_back();
```

- 将 list清空

```c++
l.clear();
```

## 练习泛型算法的使用

- 定义一个 vector，元素类型为 int，插入 10 个随机数

```c++
    vector<int> v;
    for(int i=0;i<10;i++)
    {
        v.push_back(rand()%1000);
    }
```

- 使用 sort 按升序排序

```c++
sort(v.begin(),v.end());
```

- 按降序排序

```c++
sort(v.begin(),v.end(),greater<int>());
```

- find 查找元素

```c++
    r=rand()%1000;
    cout<<"查找"<<r<<endl;
    vector<int>::iterator result=find(v.begin(),v.end(),r);
    if(result==v.end())
    {
        cout<<"没有找到"<<endl;
    }else
    {
        cout<<"找到了元素"<<*result<<endl;
    }
```

- 用 min 和max 找出容器中的最小元素个最大元素

如果排序了，最大值最小值那就是头尾

没有排序：

```c++
    int maxNum=-999999999;
    int minNum=999999999;
    for(vector<int>::iterator it=v.begin();it!=v.end();it++)
    {
        maxNum=max(maxNum,*it);
        minNum=min(minNum,*it);
    }
    cout<<"min:"<<minNum<<endl;
    cout<<"max:"<<maxNum<< endl;
```



