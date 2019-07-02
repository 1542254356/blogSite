---
title: RoboCup分开载入不同type的skl文件
date: 2018-06-28 13:05:07
tags: robocup
categories: robocup
---


robocup的有些动作的skl文件是所以类型机器人公用的，为了让不同类型机器人有不同的性能，我们可以给每个类型机器人一个skl文件。

* 可以通过`main.cc`里面的`agentBodyType`全局变量查看机器人type。
* 动作文件在`naobehavior.cc`里面的`NaoBehavior`类构造函数里面，大约在第95行
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
* 要想分离每个type的skl文件，只要在这里修改path，载入每个type对应的skl文件。此处以修改ik的skl文件载入为例。
 ```c++
 #include <stdio.h>
 ```
 ```c++
     try {
        readSkillsFromFile( "./skills/stand.skl" );
        readSkillsFromFile( "./skills/kick.skl" );

        // ik skills
        char b[50];
        sprintf(b, "./skills/kick_ik_%d.skl", agentBodyType);
        readSkillsFromFile( b );
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

* 然后在skills文件夹里面加入`kick_ik_0.skl`~`kick_ik_4.skl`文件，这样叫你分别读取每个type的ik_skl文件。`stand.skl`和`kick.skl`文件实现skl文件分离与此类似。

*ps：agentBodyType变量依赖可执行的`--type`参数赋值，如果此处参数错误，会载入其他type的skl文件*
比如start.sh里面
```
	1|2)
	    echo "Running agent No. $i -- Type 0"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 0 --paramsfile paramfiles/defaultParams_t0.txt &#> /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 0 --paramsfile paramfiles/defaultParams_t0.txt > stdout$i 2> stderr$i &
	    ;;
	3|4)
	    echo "Running agent No. $i -- Type 1"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 1 --paramsfile paramfiles/defaultParams_t1.txt &#>  /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 1 --paramsfile paramfiles/defaultParams_t1.txt > stdout$i 2> stderr$i &
	    ;;
	5|6)
	    echo "Running agent No. $i -- Type 2"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 2 --paramsfile paramfiles/defaultParams_t2.txt &#> /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 2 --paramsfile paramfiles/defaultParams_t2.txt > stdout$i 2> stderr$i &
	    ;;
	7|8)
	    echo "Running agent No. $i -- Type 3"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 3 --paramsfile paramfiles/defaultParams_t3.txt &#> /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 3 --paramsfile paramfiles/defaultParams_t3.txt > stdout$i 2> stderr$i &
	    ;;
	*)
	    echo "Running agent No. $i -- Type 4"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 4 --paramsfile paramfiles/defaultParams_t4.txt &#> /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 4 --paramsfile paramfiles/defaultParams_t4.txt > stdout$i 2> stderr$i &
	    ;;
```
修改type必须同时修改`--type`与`--paramsfile`两个参数。

by [hjwblog.com](http://hjwblog.com) 

--2018.2.28