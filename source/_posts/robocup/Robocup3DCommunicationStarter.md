---
title: Robocup3D通信入门
date: 2018-04-25 17:36:54
tags: robocup
categories: robocup
---

Nao机器人有广播装置，可以在一定范围内实现交流。这里先介绍一下基本代码。

## 发消息
发消息代码在servercomm/primitives.cc里面的
```string NaoBehavior::composeAction()  ```
后部，如下：
```
	// Create say message
    double time = worldModel->getTime();
    bool fallen = worldModel->isFallen();
    VecPosition ball = worldModel->getLastBallSeenPosition()[0];
    double ballX = ball.getX();
    double ballY = ball.getY();
    double myX = worldModel->l2g(VecPosition(0, 0, 0)).getX();
    double myY = worldModel->l2g(VecPosition(0, 0, 0)).getY();
    bool seeingBall = worldModel->getWorldObject(WO_BALL)->currentlySeen;
    double timeBallLastSeen = worldModel->getLastBallSeenTime()[0];
    bool canTrust = worldModel->canTrustVision();
    int uNum = worldModel->getUNum();
    
    string message;
    if (canTrust || fallen)
    {
        if (makeSayMessage(uNum, time, timeBallLastSeen, ballX, ballY, myX, myY, fallen, message))
        {
            ss << message;		//ss是字符串流
        }
    }
```
* 通过```makeSayMessage```函数将所有信息转为字符串，然后拼接到ss里面

* 原代码通信发出的信息：

| 变量             | 类型   | 意义             |
| :--------------- | :----- | :--------------- |
| uNum             | int    | 自己的编号       |
| time             | double | 时间             |
| timeBallLastSeen | double | 上次看到球的时间 |
| ballX,ballY      | double | 球的x和y坐标     |
| myX,myY          | double | 我的x和y坐标     |
| fallen           | bool   | 自己是否摔倒     |

***注意：只在canTrust为true或者 fallen为true的时候才发消息***
## 接收消息
接收消息代码在parser/parser.cc里面的
```bool Parser::parseHear(const string &str)```
函数后部，如下
``` c++
	double timeBallLastSeen;
    bool fallen;
    double ballX;
    double ballY;
    double playerX;
    double playerY;
    int playerNum;
    double time;
    
    double deltaServerToGameTime = worldModel->getTime() - worldModel->getGameTime();
    
    if (processHearMessage(message, hearTime + deltaServerToGameTime, playerNum, timeBallLastSeen, ballX, ballY,playerX, playerY, fallen, time))
    {
        worldModel->setFallenTeammate(playerNum - 1, fallen);
        
        if (!self && !fallen)
        {
            static VecPosition lastHeardBallPos = VecPosition(0, 0, 0);
            VecPosition ballPos = VecPosition(ballX, ballY, 0);
            WorldObject *pBall = worldModel->getWorldObject(WO_BALL);
            if (timeBallLastSeen > worldModel->getLastBallSightingTime())
            {
                worldModel->setLastBallSightingTime(timeBallLastSeen);
                pBall->haveSighting = true;
                pBall->sighting = ballPos;
                pBall->sightingTime = timeBallLastSeen;
                pBall->sightingUNum = playerNum;
            }
            
            lastHeardBallPos = ballPos;
            
            WorldObject *pTeammate = worldModel->getWorldObject(WO_TEAMMATE1 + playerNum - 1);
            VecPosition teammatePos = VecPosition(playerX, playerY, 0);
            pTeammate->haveSighting = true;
            pTeammate->sighting = teammatePos;
            pTeammate->sightingTime = time;
            pTeammate->sightingUNum = playerNum;
        }
        
    }
```
* 接收到的信息字符串分割后通过```processHearMessage```函数解析.
* 其他人的摔倒状态每次都更新，其他数据在确定发消息的人不是自己并且发消息这个人没有摔倒的情况下才作为有效数据。否则丢弃
* ```processHearMessage```函数的第二个参数是接收到的字符串解析出来的时间hearTime加上deltaServerToGameTime。
  ```double deltaServerToGameTime = worldModel->getTime() - worldModel->getGameTime();```
  其中```worldModel->getGameTime()```里面的时间是另一部分字符串里面解析出来的。
* 
``` 
pBall->haveSighting = true;
pBall->sighting = ballPos;
pBall->sightingTime = timeBallLastSeen;
pBall->sightingUNum = playerNum;
```
里面haveSighting是WorldObject里面的一个变量，标记了球能不能被人看到。
sighting是Vecposition变量，是存储看到的球的位置。
sightingTime是看到球的时间。
sightingUNum是看到球的球员号



***下次计划，实现加通信数据项的功能***

by [hjwblog.com](http://hjwblog.com) 