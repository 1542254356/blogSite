---
title: c语言贪吃蛇详解5.GameOver功能与显示成绩
date: 2018-04-16 12:56:52
tags: 
- 小游戏
- c++
categories: c++
---

以前我们已经做出来了一个能吃东西变长的蛇。不过它好像不会死。。。

现在就来实现一下game over的功能吧。

写个函数判断蛇是否撞到自己或者撞到墙：

```c++
bool gameOver()
{
    bool isGameOver=false;
    int sX=s[0][0],sY=s[0][1];      //蛇头的x坐标和y坐标
    if(sX==0||sX==H-1||sY==0||sY==W-1)
        isGameOver=true;
    for(int i=1; i<sLength; i++)    //判断有没有吃到自己
    {
        if(s[i][0]==sX&&s[i][1]==sY)
            isGameOver=true;
    }
    return isGameOver;
}
```

然后在main里面加这个实现gameOver

```c++
if(gameOver())
        {
            system("cls");          //清除屏幕内容
            printf("Game Over\n");  
            system("pause");
            break;
        }
```

看看效果

![](https://github.com/1542254356/FigureBed/blob/master/c++/c%E8%AF%AD%E8%A8%80%E8%B4%AA%E5%90%83%E8%9B%87%E8%AF%A6%E8%A7%A35.GameOver%E5%8A%9F%E8%83%BD%E4%B8%8E%E6%98%BE%E7%A4%BA%E6%88%90%E7%BB%A9/1xg.gif?raw=true)

![](https://github.com/1542254356/FigureBed/blob/master/c++/c%E8%AF%AD%E8%A8%80%E8%B4%AA%E5%90%83%E8%9B%87%E8%AF%A6%E8%A7%A35.GameOver%E5%8A%9F%E8%83%BD%E4%B8%8E%E6%98%BE%E7%A4%BA%E6%88%90%E7%BB%A9/2xg.gif?raw=true)

![](https://github.com/1542254356/FigureBed/blob/master/c++/c%E8%AF%AD%E8%A8%80%E8%B4%AA%E5%90%83%E8%9B%87%E8%AF%A6%E8%A7%A35.GameOver%E5%8A%9F%E8%83%BD%E4%B8%8E%E6%98%BE%E7%A4%BA%E6%88%90%E7%BB%A9/3xg.gif?raw=true)

到现在为止的代码：

```c++
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include<time.h>
#include<windows.h>

#define H 23
#define W 75
#define WAIT_TIME 500

//定义direction的每个值代表的方向
#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

int a[H][W];        //地图数组
int s[H*W][2];      //蛇身坐标数组
int sLength;        //蛇的长度
int direction;      //蛇的方向
bool eated=false;   //标记是否吃到食物

void init()         //程序开始时的初始化操作
{
    srand((unsigned)time(NULL));            //设置随机数种子为现在的时间
    CONSOLE_CURSOR_INFO cursor_info = {1, 0};
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &cursor_info);    //隐藏关标
    int i,j;
    for(i=0; i<H; i++)
    {
        a[i][0]=1;          //让第一列为1
        a[i][W-1]=1;        //让最后一列为1
    }
    for(j=0; j<W; j++)
    {
        a[0][j]=1;      //让第一行为1
        a[H-1][j]=1;    //让最后一行为1
    }
    sLength=4;          //让蛇的最初长度为4
    s[0][0]=H/2;
    s[0][1]=W/2;        //给蛇头坐标赋值
    for(i=1; i<4; i++)
    {
        s[i][0]=s[0][0]+i;
        s[i][1]=s[0][1];  //给刚开始的蛇身几个初始坐标
    }
    direction=UP;
}

void gotoxy(int i,int j)        //移动光标
{
    COORD position= {j,i};
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),position);
}

int check(int ii,int jj)        //判断这个点能不能放食物，可以放返回1，不能放返回0
{
    if(a[ii][jj]==1)        //如果有障碍物，返回0
        return 0;
    int i;
    for(i=0; i<sLength; i++)
    {
        if(ii==s[i][0]&&jj==s[i][1])      //如果和其中一个蛇身重合，就返回0
            return 0;
    }
    if(ii==0||ii==H-1||jj==0||jj==W-1)      //如果在边界上面，返回0
        return 0;
    return 1;                       //最后筛选 过后的是符合条件的点
}

void food()
{
    int i,j;
    do
    {
        i=rand()%H;                 //生成0~H-1之间的一个数
        j=rand()%W;
    }
    while(check(i,j)==0);           //生成点直到满足条件
    a[i][j]=-1;                     //标记为食物
    gotoxy(i,j);
    printf("$");                    //画出食物
}

void drawMap()                  //画地图
{
    gotoxy(0,0);
    int i,j;
    for(i=0; i<H; i++)
    {
        for(j=0; j<W; j++)          //两重for循环遍历数组
        {
            if(a[i][j]==0)          //为0输出空格
                printf(" ");
            else                    //为1输出#
                printf("#");
        }
        printf("\n");               //别忘了换行
    }
}

void move()
{
    int i;
    gotoxy(s[sLength-1][0],s[sLength-1][1]);
    printf(" ");                            //在尾巴上面画空格以擦除尾巴
    if(eated)               //如果吃到了食物
    {
        sLength++;
        eated=false;        //设置为false，不然无限变长
    }
    for(i=sLength-1; i>0; i--)  //从尾巴开始，每一个点的位置等于它前面一个点的位置
    {
        s[i][0]=s[i-1][0];
        s[i][1]=s[i-1][1];
    }
    switch(direction)
    {
    case UP:
        s[0][0]--;
        break;
    case DOWN:
        s[0][0]++;
        break;
    case LEFT:
        s[0][1]--;
        break;
    case RIGHT:
        s[0][1]++;
        break;
    }

}

void drawSnake()                //画蛇
{
    int i;
    for(i=0; i<sLength; i++)
    {
        gotoxy(s[i][0],s[i][1]);        //移动关标到蛇的坐标
        printf("@");                    //在这个位置画蛇
    }
}

void key()
{
    if(kbhit()!=0)          //如果有键盘输入
    {
        char in;
        while(!kbhit()==0)  //如果玩家输入了多个按键，以最后一个按键为准
            in=getch();
        switch(in)
        {
        case 'w':
        case 'W':
            if(direction!=DOWN)         //不能缩头吧。。。。
                direction=UP;
            break;
        case 's':
        case 'S':
            if(direction!=UP)
                direction=DOWN;
            break;
        case 'a':
        case 'A':
            if(direction!=RIGHT)
                direction=LEFT;
            break;
        case 'd':
        case 'D':
            if(direction!=LEFT)
                direction=RIGHT;
            break;
        case 'p':
        case 'P':
            gotoxy(H,0);        //将光标移动到下面
            system("pause");
            gotoxy(H,0);
            printf("                   ");  //消去下面的按任意键继续
            break;
        }
    }
}

bool gameOver()
{
    bool isGameOver=false;
    int sX=s[0][0],sY=s[0][1];      //蛇头的x坐标和y坐标
    if(sX==0||sX==H-1||sY==0||sY==W-1)
        isGameOver=true;
    for(int i=1; i<sLength; i++)    //判断有没有吃到自己
    {
        if(s[i][0]==sX&&s[i][1]==sY)
            isGameOver=true;
    }
    return isGameOver;
}

int main()
{
    init();                     //程序开始时的初始化操作
    drawMap();                  //画地图
    food();
    while(1)
    {
        drawSnake();                //画蛇
        Sleep(WAIT_TIME);           //等待一段时间
        key();
        move();                     //移动蛇（主要是修改蛇身数组的数据）
        if(gameOver())
        {
            system("cls");          //清除屏幕内容
            printf("Game Over\n");
            system("pause");
            break;
        }
        if(a[s[0][0]][s[0][1]]==-1) //如果蛇头碰到食物，就重新投放食物，并且把食物点重置为0
        {
            eated=true;             //标记已经吃到食物
            food();
            a[s[0][0]][s[0][1]]=0;  //去掉食物
        }

    }
    return 0;
}
```

接下来，我们来显示一下成绩。

声明一个变量来记录分数

```c++
int score=0;        //得分
```

然后当吃到食物时分数增加（main里面）

```c++
if(a[s[0][0]][s[0][1]]==-1) //如果蛇头碰到食物，就重新投放食物，并且把食物点重置为0
        {
            eated=true;             //标记已经吃到食物
            score+=10;
            food();
            a[s[0][0]][s[0][1]]=0;  //去掉食物
        }
```

然后写一个printScore函数来写分数

```c++
void printScore()
{
    gotoxy(0,W+2);
    printf("  贪吃蛇小游戏");
    gotoxy(1,W+2);
    printf("  环家伟制作");
    gotoxy(4,W+2);
    printf("  得分:%d",score);
}
```

记得在main里面调用啊。看看效果：

![](https://github.com/1542254356/FigureBed/blob/master/c++/c%E8%AF%AD%E8%A8%80%E8%B4%AA%E5%90%83%E8%9B%87%E8%AF%A6%E8%A7%A35.GameOver%E5%8A%9F%E8%83%BD%E4%B8%8E%E6%98%BE%E7%A4%BA%E6%88%90%E7%BB%A9/4xg.gif?raw=true)

 完整代码：

```c++
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include<time.h>
#include<windows.h>

#define H 23
#define W 75
#define WAIT_TIME 500

//定义direction的每个值代表的方向
#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

int a[H][W];        //地图数组
int s[H*W][2];      //蛇身坐标数组
int sLength;        //蛇的长度
int direction;      //蛇的方向
bool eated=false;   //标记是否吃到食物
int score=0;        //得分

void init()         //程序开始时的初始化操作
{
    srand((unsigned)time(NULL));            //设置随机数种子为现在的时间
    CONSOLE_CURSOR_INFO cursor_info = {1, 0};
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &cursor_info);    //隐藏关标
    int i,j;
    for(i=0; i<H; i++)
    {
        a[i][0]=1;          //让第一列为1
        a[i][W-1]=1;        //让最后一列为1
    }
    for(j=0; j<W; j++)
    {
        a[0][j]=1;      //让第一行为1
        a[H-1][j]=1;    //让最后一行为1
    }
    sLength=4;          //让蛇的最初长度为4
    s[0][0]=H/2;
    s[0][1]=W/2;        //给蛇头坐标赋值
    for(i=1; i<4; i++)
    {
        s[i][0]=s[0][0]+i;
        s[i][1]=s[0][1];  //给刚开始的蛇身几个初始坐标
    }
    direction=UP;
}

void gotoxy(int i,int j)        //移动光标
{
    COORD position= {j,i};
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),position);
}

int check(int ii,int jj)        //判断这个点能不能放食物，可以放返回1，不能放返回0
{
    if(a[ii][jj]==1)        //如果有障碍物，返回0
        return 0;
    int i;
    for(i=0; i<sLength; i++)
    {
        if(ii==s[i][0]&&jj==s[i][1])      //如果和其中一个蛇身重合，就返回0
            return 0;
    }
    if(ii==0||ii==H-1||jj==0||jj==W-1)      //如果在边界上面，返回0
        return 0;
    return 1;                       //最后筛选 过后的是符合条件的点
}

void food()
{
    int i,j;
    do
    {
        i=rand()%H;                 //生成0~H-1之间的一个数
        j=rand()%W;
    }
    while(check(i,j)==0);           //生成点直到满足条件
    a[i][j]=-1;                     //标记为食物
    gotoxy(i,j);
    printf("$");                    //画出食物
}

void drawMap()                  //画地图
{
    gotoxy(0,0);
    int i,j;
    for(i=0; i<H; i++)
    {
        for(j=0; j<W; j++)          //两重for循环遍历数组
        {
            if(a[i][j]==0)          //为0输出空格
                printf(" ");
            else                    //为1输出#
                printf("#");
        }
        printf("\n");               //别忘了换行
    }
}

void move()
{
    int i;
    gotoxy(s[sLength-1][0],s[sLength-1][1]);
    printf(" ");                            //在尾巴上面画空格以擦除尾巴
    if(eated)               //如果吃到了食物
    {
        sLength++;
        eated=false;        //设置为false，不然无限变长
    }
    for(i=sLength-1; i>0; i--)  //从尾巴开始，每一个点的位置等于它前面一个点的位置
    {
        s[i][0]=s[i-1][0];
        s[i][1]=s[i-1][1];
    }
    switch(direction)
    {
    case UP:
        s[0][0]--;
        break;
    case DOWN:
        s[0][0]++;
        break;
    case LEFT:
        s[0][1]--;
        break;
    case RIGHT:
        s[0][1]++;
        break;
    }

}

void drawSnake()                //画蛇
{
    int i;
    for(i=0; i<sLength; i++)
    {
        gotoxy(s[i][0],s[i][1]);        //移动关标到蛇的坐标
        printf("@");                    //在这个位置画蛇
    }
}

void key()
{
    if(kbhit()!=0)          //如果有键盘输入
    {
        char in;
        while(!kbhit()==0)  //如果玩家输入了多个按键，以最后一个按键为准
            in=getch();
        switch(in)
        {
        case 'w':
        case 'W':
            if(direction!=DOWN)         //不能缩头吧。。。。
                direction=UP;
            break;
        case 's':
        case 'S':
            if(direction!=UP)
                direction=DOWN;
            break;
        case 'a':
        case 'A':
            if(direction!=RIGHT)
                direction=LEFT;
            break;
        case 'd':
        case 'D':
            if(direction!=LEFT)
                direction=RIGHT;
            break;
        case 'p':
        case 'P':
            gotoxy(H,0);        //将光标移动到下面
            system("pause");
            gotoxy(H,0);
            printf("                   ");  //消去下面的按任意键继续
            break;
        }
    }
}

bool gameOver()
{
    bool isGameOver=false;
    int sX=s[0][0],sY=s[0][1];      //蛇头的x坐标和y坐标
    if(sX==0||sX==H-1||sY==0||sY==W-1)
        isGameOver=true;
    for(int i=1; i<sLength; i++)    //判断有没有吃到自己
    {
        if(s[i][0]==sX&&s[i][1]==sY)
            isGameOver=true;
    }
    return isGameOver;
}

void printScore()
{
    gotoxy(0,W+2);
    printf("  贪吃蛇小游戏");
    gotoxy(1,W+2);
    printf("  环家伟制作");
    gotoxy(4,W+2);
    printf("  得分:%d",score);
}

int main()
{
    init();                     //程序开始时的初始化操作
    drawMap();                  //画地图
    food();
    while(1)
    {
        drawSnake();                //画蛇
        printScore();
        Sleep(WAIT_TIME);           //等待一段时间
        key();
        move();                     //移动蛇（主要是修改蛇身数组的数据）
        if(gameOver())
        {
            system("cls");          //清除屏幕内容
            printf("Game Over\n");
            system("pause");
            break;
        }
        if(a[s[0][0]][s[0][1]]==-1) //如果蛇头碰到食物，就重新投放食物，并且把食物点重置为0
        {
            eated=true;             //标记已经吃到食物
            score+=10;
            food();
            a[s[0][0]][s[0][1]]=0;  //去掉食物
        }

    }
    return 0;
}
```

更多精彩：[hjwblog.com](hjwblog.com) 