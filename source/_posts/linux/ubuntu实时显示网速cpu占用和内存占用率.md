---
title: ubuntu实时显示网速cpu占用和内存占用率
date: 2018-04-15 13:50:55
tags: linux
categories: linux
---

<h1 style="text-align: center;">　　ubuntu实时显示网速cpu占用和内存占用率</h1>
<p>　　大家在使用ubuntu的时候，有没有想让它实时显示网速，内存占用率，或者cpu占用率呢？现在我就教大家怎么实现，就像下面这样</p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/1xm.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>　　1. 添加indicator-sysmonitor的下载源，右键打开终端，复制后在终端按shift+ctrl+V粘贴下面的命令</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">sudo</span> add-apt-repository ppa:fossfreedom/indicator-sysmonitor</pre>
</div>
<p>　　2. 更新apt-get</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">sudo</span> apt-get update</pre>
</div>
<p>　　3. 安装indicator-sysmonitor</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">sudo</span> apt-get <span style="color: #0000ff;">install</span> indicator-sysmonitor</pre>
</div>
<p>　　4.启动</p>
<div class="cnblogs_code">
<pre>indicator-sysmonitor &amp;</pre>
</div>
<p>&nbsp;</p>
<p>这个时候通知栏就会出现cpu占用率和内存占用率，然后现在我们来设置显示网速与开机自启，注意，现在不要关闭终端，一关上面的显示就没了。</p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/2ml.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>点击显示的文字，选择preferences</p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/3pre.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>勾选开机自启</p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/4kjzq.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>然后切换到advanced，修改编辑框为这样，在文字后面加入net{net}</p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/5adv.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>&nbsp;点击Test，然后网速就出来了。</p>
<p>&nbsp;</p>
<p>&nbsp;<img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/6chl.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
<p>然后关闭终端，它会不见了，但是下次开机，它就会一直显示了。<strong>但是记住要点保存。</strong></p>
<p>&nbsp;</p>
<p><img src="https://github.com/1542254356/FigureBed/blob/master/linux/ubuntu%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA%E7%BD%91%E9%80%9Fcpu%E5%8D%A0%E7%94%A8%E5%92%8C%E5%86%85%E5%AD%98%E5%8D%A0%E7%94%A8%E7%8E%87/7bc.png?raw=true" alt="" /></p>
<p>&nbsp;</p>
