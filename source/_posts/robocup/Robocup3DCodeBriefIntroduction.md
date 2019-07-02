---
title: robocup3D代码简要分析
date: 2018-07-25 15:26:49
tags: robocup
categories: robocup
---

## 消息循环

消息循环位于main.cc的run函数里面，此处根据参数创建不同的`Behavior`子类。如比赛时用的`NaoBehavior`，参数优化时用的`OptimizationBehaviorFixedKick`和`OptimizationBehaviorWalkForward`。

下面是run函数里面的一个片段。从服务器读取了一个消息，然后使用刚刚创建的`Behavior`子类的`Think`进行解析和运算，并返回要发送给服务器的字符串数据。

```c++
while (gLoop)
    {
        GetMessage(msg);
        string msgToServer = behavior->Think(msg);
        // To support agent sync mode
        msgToServer.append("(syn)");
        PutMessage(msgToServer);
        if (mPort != -1) {
            PutMonMessage(behavior->getMonMessage());
        }
    }
```

后面的if语句内容是优化的时候用的，`mPort`变量由启动agent时的`--port`参数赋值。用于优化时向服务器发送一些控制指令。如将球移动到一个位置，控制比赛开始停止等。

## Think函数

Think函数原型为：

```c++
virtual std::string Think(const std::string& message) = 0;
```

它位于`Behavior`类，是一个纯虚函数，需要子类实现。

`Think`函数的实现在`NaoBehavior`类里面。`NaoBehavior`继承`Behavior`，然后其他的优化类等是继承的`NaoBehavior`。

`Think`函数参数是`string`，为服务器发送来的消息。返回值也是`string`，是发送给服务器的消息。

服务器发送过来的数据先进行了解码，获取了服务器发送过来的数据，然后进行计算和决策，之后发送给服务器。这个过程理论上是`20ms`发送一次。


## Parser类

`Parser`类是解析服务器发送过来的数据的类，位于`parser/parser.h`内。它的作用是将服务器发送过来的字符串解析为数据。字符串具体的语法可以参考实验室的文档。 解析过程在`parse`函数中, `Parser::parse` 函数在Think函数中被调用。

## composeAction函数

```c++
string NaoBehavior::composeAction()
```

`NaoBehavior::composeAction()`函数功能和`Parser::parse`是对应的，它将要发送的数据转为字符串发送给服务器。它位于`servercomm/primitives.cc`内。返回值就是发送给服务器的数据。

## selectSkill函数

```c++
 SkillType NaoBehavior::selectSkill()
```

`NaoBehavior::selectSkill()`应该是大家最熟悉的函数，这里写的是关于机器人高级决策的地方。位于`behaviors/strategy.cc`里面。比赛的时候都在写这个函数。这里决定机器人是要走路还是要踢球。它的返回值是`SkillType`，这是一个枚举变量。每一个都代表了一种Skill(如踢球，走路，摔倒后的起身)。

## act函数

```c++
void NaoBehavior::act() 
```

`NaoBehavior::act()`函数决定现在要做什么。这里通常处理更低级的动作，它调用了刚刚的`selectSkill`函数，获取一个`SkillType`，然后执行这个`Skill`。这里有一个摔倒判断，如果摔倒了，这里会自动调用起身的`Skill`。所以摔倒的时候是不会执行`selectSkill`函数的。

## Skill

### 简介

刚刚的`act`函数通过调用`selectSkill`函数决定自己该执行哪个`Skill`。这里就来解释一下`Skill`是什么。

`Skill`就是机器人的技能，可以是摔倒之后的起身动作，踢球的动作，走路的动作。技能可以通过技能描述语言来定义。注：起身的动作在`behaviors/checkfall.cc`中，这个动作没有使用`.skl`文件描述。

`skills`文件夹里面的`.skl`文件里面的就是定义skl的文件。

至于怎么添加一个`Skill`就可以看我以前写的文档。

### Skill文件的加载

Skill文件加载代码在`NaoBehavior`的构造函数里面，如下：

使用了`readSkillsFromFile`函数来从`.skl`文件载入Skill。

```c++
try {
        readSkillsFromFile( "./skills/stand.skl" );
        readSkillsFromFile( "./skills/kick.skl" );

        // ik skills
        readSkillsFromFile( "./skills/kick_ik_0.skl" );
        // end ik skills

    }
    catch( std::string& what ) {
        cerr << "Exception caught: " << what << endl;
        exit(1);
    }
    catch (std::exception& e)
    {
        cerr << e.what() << endl;
        exit(1);
    }
```



## Parameter Files

### 简介

参数文件在`paramfiles`文件夹里面，参数和前面的`.skl`文件可以配套使用，也可以直接在代码里面读取参数。比如我们在写踢球动作时，我们不知道要把每个关节转动多少度，以多快的速度转动。我们估计的基本不可能是最好的。所以可以把这些变量写在参数文件里面。程序运行时加载。

调整得好的参数会比原来的参数有更好的效果。比如提球的参数，原始参数可以踢6m，而经过优化的参数可以踢15m。

### 参数文件的加载

参数文件是在agent运行的时候通过`--paramsfile`c参数来加载。而`agent`可以加载多个参数文件，不同的文件里面可以出现同一个参数。由下面的代码可以看出，后面载入的文件的变量会覆盖之前加载的文件里面的同名变量。

```c++
void ReadOptions(int argc, char* argv[])
{

    teamName = "UTAustinVilla_Base";
    uNum = 0; // Value of 0 means choose next available number

    for( int i = 0; i < argc; i++)
    {
        if ( strcmp( argv[i], "--help" ) == 0 )
        {
            PrintHelp();
            exit(0);
        }
        else if ( strncmp( argv[i], "--host", 6 ) == 0 )
        {
            string tmp=argv[i];

            if ( tmp.length() <= 7 ) // minimal sanity check
            {
                PrintHelp();
                exit(0);
            }
            gHost = tmp.substr(7);
        }
        else if ( strncmp( argv[i], "--mhost", 7 ) == 0 )
        {
            string tmp=argv[i];

            if ( tmp.length() <= 8 ) // minimal sanity check
            {
                PrintHelp();
                exit(0);
            }
            mHost = tmp.substr(8);
        }
        else if ( strncmp( argv[i], "--port", 6) == 0 ) {
            if (i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            gPort = atoi(argv[i+1]);
        }
        else if ( strncmp( argv[i], "--mport", 7) == 0 ) {
            if (i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            mPort = atoi(argv[i+1]);
        }
        else if(strcmp(argv[i], "--team") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }

            teamName = argv[i + 1];
        }
        else if(strcmp(argv[i], "--unum") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            uNum = atoi(argv[i + 1]);
        }
        else if(strcmp(argv[i], "--paramsfile") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            string inputsFile = argv[i+1];
            LoadParams(inputsFile);
        }
        else if (strcmp(argv[i], "--experimentout") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            outputFile = argv[i+1];
        }
        else if (strcmp(argv[i], "--optimize") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            agentType = argv[i+1];
        }
        else if (strcmp(argv[i], "--type") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            rsg = "rsg/agent/nao/nao_hetero.rsg " + string(argv[i+1]);
            agentBodyType = atoi(argv[i+1]);
        }
        else if (strcmp(argv[i], "--rsg") == 0) {
            if(i == argc - 1) {
                PrintHelp();
                exit(0);
            }
            rsg = argv[i+1];
        }
        else if (strcmp(argv[i], "--pkgoalie") == 0) {
            agentType = "pkgoalie";
        }
        else if (strcmp(argv[i], "--pkshooter") == 0) {
            agentType = "pkshooter";
        }
        else if (strcmp(argv[i], "--gazebo") == 0) {
            agentType = "gazebo";
        }
        else if (strcmp(argv[i], "--recordstats") == 0) {
            agentType = "recordstats";
        }
    } // for-loop
}
```

hjwblog.com