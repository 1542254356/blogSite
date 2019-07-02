---
title: Robocup3d加入新的技能
date: 2018-07-16 23:27:19
tags: robocup
categories: robocup
---



Nao机器人技能除了现有的ik，大脚，走路，起身外，还可以加一些自定义技能。比如守门员可以有扑球的技能。这里用一个简单的挥挥手打招呼的技能为例，演示一下怎么加入一个技能吧。

* 首先，在`headers/headers.h`文件里面的`enum SkillType`的声明里面加入新技能的名字。这里以SKILL_HELLO为新技能的名字。
  ```c++
  //Skills
  enum SkillType {
    SKILL_WALK_OMNI,
  
    SKILL_STAND,
  
    SKILL_KICK_LEFT_LEG,
    SKILL_KICK_RIGHT_LEG,
  
    SKILL_KICK_IK_0_LEFT_LEG,
    SKILL_KICK_IK_0_RIGHT_LEG,
  
    SKILL_NONE,
    SKILL_HELLO
  ```

};
* 然后在`behaviors/naobehavior.cc`里面的`NaoBehavior::NaoBehavior(const std::string teamName, int uNum, const map<string, string>& namedParams_, const string& rsg_)`函数里面载入skl文件。大约在初始代码第95行。
  ```c++
  try {
        readSkillsFromFile( "./skills/stand.skl" );
        readSkillsFromFile( "./skills/kick.skl" );
        
        //hello skills
        readSkillsFromFile( "./skills/hello.skl" );
        //end hello skills
        
  
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
  注意：skl文件里面要定义skill的名字，例如此处的skl中skill的名字为SKILL_HELLO，在STARTSKILL后面定义
```shell
STARTSKILL SKILL_HELLO

#State 0
STARTSTATE

settar EFF_LL1 0 EFF_LL2 0 EFF_LL3 -10.0 EFF_LL4 -20.0 EFF_LL5 20.0 EFF_LL6 0 end
settar EFF_RL1 0 EFF_RL2 0 EFF_RL3 -10.0 EFF_RL4 -20.0 EFF_RL5 20.0 EFF_RL6 0 end

wait 0.2 end
ENDSTATE

#State 1
STARTSTATE

settar EFF_LA1 90 EFF_LA2 90 EFF_LL1 0 EFF_LL2 0 EFF_LL3 -10.0 EFF_LL4 -20.0 EFF_LL5 20.0 EFF_LL6 0 end

wait 2 end
ENDSTATE

#State 2
STARTSTATE

settar EFF_RA1 -90 EFF_LA2 -90 EFF_RL1 0 EFF_RL2 0 EFF_RL3 -10.0 EFF_RL4 -20.0 EFF_RL5 20.0 EFF_RL6 0 end

wait 2 end
ENDSTATE

ENDSKILL 
```
* 然后在`headers/headers.cc`里面的`EnumParser<SkillType>::EnumParser()`函数里面加入
  ```c++
  string2enum["SKILL_HELLO"] = SKILL_HELLO;
  enum2String[SKILL_HELLO] = "SKILL_HELLO";
  ```

* 最后，在`behaviors/strategy.cc`里面修改`SkillType NaoBehavior::selectSkill() `函数，让它`return SKILL_HELLO;`
  ```c++
  SkillType NaoBehavior::selectSkill() {
    return SKILL_HELLO;
  }
  ```

好了，运行代码。`PlayOn`,是不是看到你的新技能了呢。

--环家伟