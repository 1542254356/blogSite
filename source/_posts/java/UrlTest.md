---
title: java Url类Demo
date: 2018-12-29 15:30:06
tags: java
categories: java
---

```java
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;

public class URLTest {
    public static void main(String[] args)  {
        InputStream inputStream=null;
        InputStreamReader inputStreamReader=null;
        BufferedReader bufferedReader=null;
        try {
            URL url=new URL("http://hjwblog.com/index.html?name=hjw");
            //获取url主机地址     hjwblog.com
            System.out.println(url.getHost());
            //获取url路径       /index.html
            System.out.println(url.getPath());
            //获取查询部分        name=hjw
            System.out.println(url.getQuery());

            //获取字节输入流
            inputStream=url.openStream();
            //将字节输入流转换为字符输入流，并指定编码
            inputStreamReader=new InputStreamReader(inputStream,"UTF-8");
            //为字符输入流添加缓冲，提高读取效率
            bufferedReader=new BufferedReader(inputStreamReader);

            //按行读取并输出数据
            StringBuffer stringBuffer=new StringBuffer();
            String line=null;
            while ((line=bufferedReader.readLine())!=null){
                stringBuffer.append(line);
                stringBuffer.append("\n");      //输出网页源代码
            }
            String result=stringBuffer.toString();
            System.out.println(result);


        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            //记得关闭
            try {
                if(bufferedReader!=null)
                    bufferedReader.close();
                if(inputStreamReader!=null)
                    inputStreamReader.close();
                if(inputStream!=null)
                    inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }
}


```