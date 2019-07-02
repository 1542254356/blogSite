---
title: 用C语言画一个心
date: 2018-04-15 13:46:39
tags: c++
categories: c++
---

<h1 style="text-align: center;">用C语言图形库画一个心</h1>
<p style="text-align: center;">--环家伟</p>
<p>这次我教大家用代码画一个心，这样你们就可以送给你们的女（男）朋友了。没找到对象的也可以用来表白啊。</p>
<p>1.首先，我去百度找了心形线的函数，如下：</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/c++/%E7%94%A8C%E8%AF%AD%E8%A8%80%E5%9B%BE%E5%BD%A2%E5%BA%93%E7%94%BB%E4%B8%80%E4%B8%AA%E5%BF%83/1hs.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>2. &nbsp;联系高中的数学知识，我们知道：f(x)&gt;0和f(x)&lt;0的点分别在图形线两边</p>
<p>这样我们可以通过</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/c++/%E7%94%A8C%E8%AF%AD%E8%A8%80%E5%9B%BE%E5%BD%A2%E5%BA%93%E7%94%BB%E4%B8%80%E4%B8%AA%E5%BF%83/2gs.png?raw=true" alt="" /></p>
<p><img src="http://images2017.cnblogs.com/blog/1273811/201711/1273811-20171114125249452-519245010.png" alt="" /></p>
<p>这两个公式筛选出在心里面或者外面的点，然后对他们进行不同的操作。</p>
<p>&nbsp;</p>
<p>3. 这样就简单了，只要遍历所有的点，然后判断点是在线上（=）还是在里面或者外面（&lt;或者&gt;)，然后对他们进行不同的操作。</p>
<p>如果想画一个红心就可以这样写：</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">for</span> (i = <span style="color: #800080;">0</span>; i&lt;H; i++<span style="color: #000000;">)　　　　　　　　　　//H为画板高
    {
        </span><span style="color: #0000ff;">for</span> (j = <span style="color: #800080;">0</span>; j&lt;W; j++<span style="color: #000000;">)　　　　　　//W为画板宽
        {
            </span><span style="color: #008000;">//</span><span style="color: #008000;">此处得到的(i,j)为屏幕每一个点的坐标
                        
            </span><span style="color: #008000;">//</span><span style="color: #008000;">对图形进行平移与放大操作</span>
            <span style="color: #0000ff;">double</span> t1 = j/<span style="color: #800080;">150.0</span>-<span style="color: #800080;">2</span>, t2 =-(i/<span style="color: #800080;">100.0</span>-<span style="color: #800080;">2.5</span><span style="color: #000000;">);
            </span><span style="color: #008000;">//</span><span style="color: #008000;">在这里判断每一个点是否满足在心图像里面的条件</span>
            <span style="color: #0000ff;">if</span> (pow(t1, <span style="color: #800080;">2</span>) + pow(t2 - pow(t1*t1, <span style="color: #800080;">1</span> / <span style="color: #800080;">3.0</span>), <span style="color: #800080;">2</span>) &lt;= <span style="color: #800080;">1</span><span style="color: #000000;">)
                putpixel(j, i, RED);</span><span style="color: #008000;">//</span><span style="color: #008000;">如果这个点在xin里面，就画一个红点（putpixel函数为图形库easyx画点函数）</span>
<span style="color: #000000;">        }
    }                                        </span></pre>
</div>
<p>&nbsp;</p>
<p>这样运行后就是这个样子：</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/c++/%E7%94%A8C%E8%AF%AD%E8%A8%80%E5%9B%BE%E5%BD%A2%E5%BA%93%E7%94%BB%E4%B8%80%E4%B8%AA%E5%BF%83/3xg.png?raw=true" alt="" /></p>
<p>&nbsp;如果把代码改成这样：</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">for</span> (i = <span style="color: #800080;">0</span>; i&lt;H; i++<span style="color: #000000;">)
    {
        </span><span style="color: #0000ff;">for</span> (j = <span style="color: #800080;">0</span>; j&lt;W; j++<span style="color: #000000;">)
        {
            </span><span style="color: #0000ff;">double</span> t1 = j/<span style="color: #800080;">150.0</span>-<span style="color: #800080;">2</span>, t2 =-(i/<span style="color: #800080;">100.0</span>-<span style="color: #800080;">2.5</span><span style="color: #000000;">);
            </span><span style="color: #0000ff;">if</span> (fabs(pow(t1, <span style="color: #800080;">2</span>) + pow(t2 - pow(t1*t1, <span style="color: #800080;">1</span> / <span style="color: #800080;">3.0</span>), <span style="color: #800080;">2</span>)-<span style="color: #800080;">1</span>)&lt;<span style="color: #800080;">0.1</span><span style="color: #000000;">)
                putpixel(j, i, RED);
        }
    }</span></pre>
</div>
<p>结果就是这样：</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/c++/%E7%94%A8C%E8%AF%AD%E8%A8%80%E5%9B%BE%E5%BD%A2%E5%BA%93%E7%94%BB%E4%B8%80%E4%B8%AA%E5%BF%83/4xg.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>&nbsp;好了，大概的思路就是这个样子，大家还可以通过这种办法画各种函数的图形</p>
<p>如果没有图形库，请自己去easyx.cn下载安装，里面有详细教程。</p>
<p>附完整代码：</p>
<p>1.&nbsp;</p>
<div class="cnblogs_code">
<pre>#include &lt;stdio.h&gt;<span style="color: #000000;">
#include</span>&lt;easyx.h&gt;<span style="color: #000000;">
#include</span>&lt;math.h&gt;
<span style="color: #0000ff;">#define</span> W 640
<span style="color: #0000ff;">#define</span> H 480

<span style="color: #0000ff;">int</span><span style="color: #000000;"> main()
{
    </span><span style="color: #0000ff;">int</span><span style="color: #000000;"> i, j;
    initgraph(</span><span style="color: #800080;">W</span>, <span style="color: #800080;">H</span><span style="color: #000000;">);
    setbkcolor(WHITE);
    cleardevice();
    </span><span style="color: #0000ff;">for</span> (i = <span style="color: #800080;">0</span>; i&lt;H; i++<span style="color: #000000;">)
    {
        </span><span style="color: #0000ff;">for</span> (j = <span style="color: #800080;">0</span>; j&lt;W; j++<span style="color: #000000;">)
        {
            </span><span style="color: #0000ff;">double</span> t1 = j/<span style="color: #800080;">150.0</span>-<span style="color: #800080;">2</span>, t2 =-(i/<span style="color: #800080;">100.0</span>-<span style="color: #800080;">2.5</span><span style="color: #000000;">);
            </span><span style="color: #0000ff;">if</span> (pow(t1, <span style="color: #800080;">2</span>) + pow(t2 - pow(t1*t1, <span style="color: #800080;">1</span> / <span style="color: #800080;">3.0</span>), <span style="color: #800080;">2</span>) &lt;= <span style="color: #800080;">1</span><span style="color: #000000;">)
                putpixel(j, i, RED);
        }
    }
    getchar();
    </span><span style="color: #0000ff;">return</span> <span style="color: #800080;">0</span><span style="color: #000000;">;
}</span></pre>
</div>
<p>&nbsp;2.&nbsp;</p>
<div class="cnblogs_code">
<pre>#include &lt;stdio.h&gt;<span style="color: #000000;">
#include</span>&lt;easyx.h&gt;<span style="color: #000000;">
#include</span>&lt;math.h&gt;
<span style="color: #0000ff;">#define</span> W 640
<span style="color: #0000ff;">#define</span> H 480

<span style="color: #0000ff;">int</span><span style="color: #000000;"> main()
{
    </span><span style="color: #0000ff;">int</span><span style="color: #000000;"> i, j;
    initgraph(W, H);
    setbkcolor(WHITE);
    cleardevice();
    </span><span style="color: #0000ff;">for</span> (i = <span style="color: #800080;">0</span>; i&lt;H; i++<span style="color: #000000;">)
    {
        </span><span style="color: #0000ff;">for</span> (j = <span style="color: #800080;">0</span>; j&lt;W; j++<span style="color: #000000;">)
        {
            </span><span style="color: #0000ff;">double</span> t1 = j/<span style="color: #800080;">150.0</span>-<span style="color: #800080;">2</span>, t2 =-(i/<span style="color: #800080;">100.0</span>-<span style="color: #800080;">2.5</span><span style="color: #000000;">);
            </span><span style="color: #0000ff;">if</span> (fabs(pow(t1, <span style="color: #800080;">2</span>) + pow(t2 - pow(t1*t1, <span style="color: #800080;">1</span> / <span style="color: #800080;">3.0</span>), <span style="color: #800080;">2</span>)-<span style="color: #800080;">1</span>)&lt;<span style="color: #800080;">0.1</span><span style="color: #000000;">)
                putpixel(j, i, RED);
        }
    }
    getchar();
    </span><span style="color: #0000ff;">return</span> <span style="color: #800080;">0</span><span style="color: #000000;">;
}</span></pre>
</div>
<p>&nbsp;</p>
