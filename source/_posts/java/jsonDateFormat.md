---
title: json-lib字符串格式化
date: 2018-09-20 14:27:16
tags: java
categories: java
---


将Date对象导出为JSON时，会出现下面的格式

```
Sep 17, 2018 6:33:43 PM
```

或者直接将Date对象所有属性输出

```json
{"date":{"date":19,"day":3,"hours":9,"minutes":2,"month":8,"seconds":9,"time":1537318929506,"timezoneOffset":-480,"year":118},其他}
```

如果将时间格式化为`2018-09-19 09:02:10`的形式，方便了前端的解析，也让json比较简洁。

可以实现`JsonValueProcessor`接口，用来指定转换后的格式。

示例代码：

```java
package com.hjwblog.JSONtest;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.JSONUtils;


import java.util.Date;

public class FormatDate {
    public static void main(String[] args) {


        TestBeam testBeam = new TestBeam();
        System.out.println("原对象：" + testBeam);
        //将对象转为JSON字符串
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessorUtil());

        JSONObject newJsonObject = JSONObject.fromObject(testBeam, jsonConfig);

        String outString = newJsonObject.toString();
        System.out.println("JSON:" + outString);

        //将JSON字符串转为对象
        System.out.println("\n将JSON字符串转为对象-------------");

        String jsonString = "{\"date\":\"2016-09-19 09:23:26\",\"i\":1}";

        System.out.println("原字符串：" + jsonString);

        JsonConfig config = new JsonConfig();
        config.setRootClass(TestBeam.class);

        ////可转换的日期格式，即Json串中可以出现以下格式的日期与时间
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd HH:mm:ss"}));

        //从字符串构建JSONObject
        JSONObject toObj = JSONObject.fromObject(jsonString);

        //转Beam对象
        TestBeam fromJSON = (TestBeam) JSONObject.toBean(toObj, TestBeam.class);
        System.out.println("从字符串转过来的对象：" + fromJSON);
    }
}

```

输出：

```
原对象：date:Wed Sep 19 09:33:13 CST 2018  i:1
JSON:{"date":"2018-09-19 09:33:13","i":1}

将JSON字符串转为对象-------------
原字符串：{"date":"2016-09-19 09:23:26","i":1}
从字符串转过来的对象：date:Mon Sep 19 09:23:26 CST 2016  i:1
```



完整代码：


先随便写个Beam，用于转换

```java
package com.hjwblog.JSONtest;

import java.util.Date;

public class TestBeam {
    public TestBeam() {
        this.date = new Date();
        this.i = 1;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    @Override
    public String toString() {
        return "date:" + date + "  i:" + i;
    }

    Date date;
    int i;

}

```

实现`JsonValueProcessor`接口，用来指定转换后的格式。

```java
package com.hjwblog.JSONtest;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 时间转换器（将返回的json数据中的日期格式转换为指定格式）
 */
public class JsonDateValueProcessorUtil implements JsonValueProcessor {
    private String format = "yyyy-MM-dd HH:mm:ss";

    public JsonDateValueProcessorUtil() {
        super();
    }

    public JsonDateValueProcessorUtil(String format) {
        super();
        this.format = format;
    }

    @Override
    public Object processArrayValue(Object paramObject,
                                    JsonConfig paramJsonConfig) {
        return process(paramObject);
    }

    @Override
    public Object processObjectValue(String paramString, Object paramObject,
                                     JsonConfig paramJsonConfig) {
        return process(paramObject);
    }


    private Object process(Object value) {
        if (value instanceof Date) {
            SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.CHINA);
            return sdf.format(value);
        }
        return value == null ? "" : value.toString();
    }
}
```

