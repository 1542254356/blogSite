---
title: Robocup3D通信实例
date: 2018-04-26 10:51:48
tags: robocup
categories: robocup
---

Nao机器人有广播装置，可以在一定范围内实现交流。这里以约定传球位置为例演示通信的使用。

## 发消息
* 先在```/behaviors/naobehavior.h```里面加一个变量
```
VecPosition passPosition;           //假设为约定的传球位置
```
然后在```/servercomm/primitives.cc```的```string NaoBehavior::composeAction() ```函数里面加如下代码
```
double passX=passPosition.getX();
double passY=passPosition.getY();
```
由于没有vecposition转string的函数，所以要把它的x和y分开。

*  然后为```makeSayMessage```函数加两个参数passX与passY
```
bool makeSayMessage(const int &uNum, const double &currentServerTime, const double &ballLastSeenServerTime, const double &ballX, const double &ballY, const double &myX, const double &myY, const bool &fFallen,const double passX,const double passY,  std::string &message)
```
**audio.h和audio.cc都要改 **

* 同样的，为```dataToBits```函数加两个参数。

* 然后在```makeSayMessage```函数里面修改```dataToBits```函数的调用
```
if(!(dataToBits(currentServerTime, ballLastSeenServerTime, ballX, ballY, myX, myY,fFallen,passX,passY,  bits))) {
        return false;
}
```

* 在```dataToBits```函数里面加如下代码（模仿球的坐标写法）
```
    double clippedPassX = (passX < minBallX)? minBallX : ((ballX > maxBallX)? maxBallX : passX);
    int px = (((clippedPassX - minBallX) * 1023) / (maxBallX - minBallX)) + 0.5;
    vector<int> passXBits = intToBits(px, 10);
    
    double clippedPassY = (passY < minBallY)? minBallY : ((ballY > maxBallY)? maxBallY : passY);
    int py = (((clippedPassY - minBallY) * 1023) / (maxBallY - minBallY)) + 0.5;
    vector<int> passYBits = intToBits(py, 10);
```
上面的代码将double转为int存储，限制了double的范围，相当于用大范围的int存小范围的double。

同样的，在ballx与bally的相似代码后面加如下代码
```
bits.insert(bits.end(), passXBits.begin(), passXBits.end());//10
bits.insert(bits.end(), passYBits.begin(), passYBits.end());//10
```
这里代码的功能是将所有bits合并起来

## 接收消息
* 在/parser/parser.cc里面的```bool Parser::parseHear(const string &str)```函数里面加两个变量
```
    double passX;
    double passY;
```
* 然后在audio.h与audio.cc里面为```processHearMessage```加两个参数
  如下：
```
bool processHearMessage(const std::string &message, const double &heardServerTime, int &uNum, double &ballLastSeenServerTime, double &ballX, double &ballY, double &agentX, double &agentY, bool &fFallen,double&passX,double &passY, double &time)

```
**类型为引用 **

* 同样的，为```bitsToData```函数加两个参数，并且在调用时加上两个变量
```
bool bitsToData(const std::vector<int> &bits, double &time, double &ballLastSeenTime, double &ballX, double &ballY, double &agentX, double &agentY,double&passX,double &passY,  bool &fFallen)

```
```
    if(!(bitsToData(bits, time, ballLastSeenServerTime, ballX, ballY, agentX, agentY,passX,passY, fFallen))) {
        return false;
    }
```
**类型为引用 **

* 修改bitsToData函数
  这个函数有一个长度验证，由于刚才加了长度，所以要将if的条件加两个```+10```

```
if(bits.size() < (16 + 16 + 10 + 10 + 10 + 10 + 10 + 10 + 1)) {
        time = 0;
        ballLastSeenTime = 0,
        ballX = 0;
        ballY = 0;
        agentX = 0;
        agentY = 0;
        fFallen = false;
        passX=0;
        passY=0;
        return false;
    }
```
然后继续模仿ballx和y写解码passx和y的
```
    int px = bitsToInt(bits, ctr, ctr + 9);
    passX = minBallX + ((maxBallX - minBallX) * (px / 1023.0));
    ctr += 10;
    
    int py = bitsToInt(bits, ctr, ctr + 9);
    passY = minBallY + ((maxBallY - minBallY) * (py / 1023.0));
    ctr += 10;
```
这样就能接收了。
* 为了区分是谁发来的，在worlmodel类里面弄一个数组
```
vector<VecPosition> passBalls;          //接收到的传球位置
```
并且在WorldModel构造函数里面设置大小
```
passBalls.resize(TEAMMATE_NUM);
```
* 然后继续在/parser/parser.cc里面的```bool Parser::parseHear(const string &str)```函数里面解析函数之后加上
```
worldModel->passBalls[playerNum-1]=VecPosition(passX,passY,0);
```
* 这样就存起来了，在需要传球的时候就可以读取约定好的传球位置，传球的人往此点踢球，接球的人提前往此点跑
## 示例
```
SkillType NaoBehavior::selectSkill() {
    switch (worldModel->getUNum())
    {
        case 1:
        case 2:
        case 3:
            passPosition=VecPosition(worldModel->getUNum(),0,0);
            break;
        case 4:
            passPosition=VecPosition(worldModel->getUNum(),0,0);
            cout<<"我是4号，我听见："<<endl;
            for(int i=1;i<=3;i++)
            {
                cout<<i<<"号要向"<<worldModel->passBalls[i-1]<<"传球"<<endl;
            }
            cout<<"但是2,3号根本没球，我要去"<<worldModel->passBalls[0]<<"点接球"<<endl;
        default:
            break;
    }
    return demoKickingCircle();
}
```
结果：
![](http://image.hjwblog.com/robocup/CommunicationExample/result.png) 

by [hjwblog.com](http://hjwblog.com) 