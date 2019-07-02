---
title: html常用标签
date: 2018-03-22 23:06:43
tags: html
categories: web开发
---


## 文字标签

`<font></font>`

属性

* size：文字大小 
  取值范围1-7，如果超过7，大小还是7
* color：文字颜色
  * 英文单词：如red, green, blue 
  * 使用16进制数表示：#ffffff  RGB颜色
```html
<font size="5" color="red">示例文字</font>
<font size="5" color="#66cc66">示例文字2</font>
```
## 注释

`<!--注释内容-->`

## 标题

`<h1></h1> <h2></h2> <h3></h3> ....<h6></h6>`

```html
 <h1>标题1</h1>
 <h2>标题2</h2> 
 <h3>标题3</h3>
```

## 水平线

`<hr/>`

### 属性

* size：水平线粗细 取值范围1-7

* color：颜色

  ```html
  <hr size="5" color="red"/>
  ```

## 特殊字符

想在网页上面显示html标签，如`<html>是网页的开始`

需要进行转义

| 符号   | 对应的转义字符    |
| ---- | ---------- |
| 小于号  | &amp;lt;   |
| 大于号  | &amp;gt;   |
| 和号   | &amp;amp;  |
| 空格   | &amp;nbsp; |

## 列表
### 定义列表

* `<dl></dl>`:列表范围

* `<dt></dt>`:上层内容

* `<dd></dd>`:下层内容

  ```html
  <dl>
    	<dt>环家伟</dt>
    	<dd>年龄：20</dd>
    	<dd>博客地址：cnblogs.con/hjw1</dd>
  </dl>
  ```
### 有序列表
*  `<ol></ol>`：有序列表范围
       属性：type：前面的序号类型，有数字，字母，罗马数字
   * type="1"数字（默认）
   * type="a" 字母
   * type="i" 罗马数字
*  `<li></li>`：里面是具体内容
```html
<ol>
	<li>第一点</li>
	<li>第二点</li>
	<li>第三点</li>
</ol>
```

### 无序列表
*   `<ul></ul>` 无序列表的范围
        属性：type
    * type="circle" 空心圆
    * type="disc" 实心圆（默认）
    * type="square" 实心方块
```html
<!--实心方块-->
<ul type="square">
	<li>第一点</li>
	<li>第二点</li>
	<li>第三点</li>
</ul>
```

## 图像

`<img src="图片路径"/>`

属性：

* src 图片路径

* width  图片宽度

* height 图片高度

* alt 图片显示的文字

  （鼠标移动到图片上面显示，或者图片打开失败显示。有些浏览器不支持）

```html
<img src="a.jpg" wifth="300" height="400" alt="图片上的文字"/>
```
##  超链接

* 链接资源：

  `<a href="链接资源路径">显示内容</a>`

  * href	：链接地址
    * 如果为"#",点击无效果
    * target：设置打开方式，默认在当前页面打开
    * _blank ：在新窗口打开
      * _self：在当前页面打开
  ```html
    <a href="http://cnblogs.com/hjw1">当前标签页打开</a><br/>
    <a href="http://cnblogs.com/hjw1" target="_blank">新标签页打开</a><br/>
   <a href="#">点击无反应超链接</a>
  ```
* 定位资源
  * 定义一个位置
    `<a name="top">顶部</a>`
  * 回到这个位置
    `<a href="#top">回到顶部</a>`
## 原样输出
  元素中的文本通常会保留空格和换行符。而文本也会呈现为等宽字体。
  每个制表符占据8个字符的位置，但并不推荐使用tab，因为在不同的浏览器中，tab的表现形式各不相同。在用<pre>标签格式化的文档段中使用空格，可以确保文本正确的水平位置。
## 表格
* `<table></table>` ：表格范围
* `<tr></tr>` ：表示一行
* `<td></td>` ：表示一个单元格
* `<th></th>` ：表示居中加粗的单元格
* `<caption></caption>` ：表格的标题（写在table和tr之间）
* 合并单元格：
  * rowspan:跨行 如：`rowspan="3"`
  * colspan:跨列
* `table`属性
  * `border` ：表格线
  * `bordcolor` ：表格线颜色
  * `cellspacing` ：单元格之间的距离
  * `width` ：表格宽度
  * `height` ：表格高度
  * `align` ：设置表格文字对齐方式 有left right center
* `tr`属性
  * `align` ：设置行对齐方式 有left right center
* `td`属性
  * `align` ：设置单元格对齐方式 有left right center
```html
<table border="1" cellspacing="0">
<tr>
  <th>姓名</th>
  <td>环家伟</td>
</tr>
<tr>
  <th rowspan="2">blog:</th>
  <td>cnblogs.com/hjw1</td>
</tr>
<tr>
  <td>cnblogs.com/hjw1</td>
</tr>
</table>
```
## 表单标签
* `<form></form>` ：定义表单范围
  * 输入项 :大多数：`<input></input>` 都要有name
    * 普通输入项：`<input type="text"/>`
    * 密码输入项：`<input type="password"/>`
    * 单选输入项：`<input type="radio"/ name="myName">`
      * name用来标记同一组单选框,同一组的name必须相同
      * 必须有value值
      * 默认选中：checked="checked"
    * 复选输入项：`<input type="checkbox"/>`
      * name用来标记同一组单选框,同一组的name必须相同
      * 必须有value值
      * 默认选中：在默认选项加checked="checked"
    * 文件输入项： `<input type="file"/>`
    * 下拉输入项：
      * 默认选中：selected="selected"
      ```html
      <select name="birth">
      	<option value="1997">1997</option>
      	<option value="1998">1998</option>
      	<option value="1999">1999</option>
      </select>
      ```
    * 文本域：`<textarea cols="10" rows="10"></textarea>`
      * cols：列数
      * rows：行数
    * 隐藏项：`<input type="hidden"/>`
    * 提交按钮：`<input type="submit"/>`
      * value:按钮上的文字，默认为提交
      * 通过url提交表单
        * 参数在?后面
        * 通过键值对提交
        * 键值对之间由&分开
        * 提交地址通过form的action属性设置
        * 实现点击按钮构建百度url示例
        ```html
        <form action="http://www.baidu.com/s">
        	<input type="hidden" name="ie" value="UTF-8" />
        	<input type="text" name="wd"  />
        	<input type="submit" value="百度一下" />
        </form>
        ```
* form 属性
  * action:提交到的地址，默认当前页面
  * method:表单提交方式。有get和post，默认get
    * get和post区别：
      1. get请求url会携带提交的数据，post不会携带
      2. get没有post安全
      3. get有数据大小限制，post没有限制
  * enctype：文件上传时需要，
* `<input type="image" src="图片路径" />` 可以实现图片提交按钮
* 重置按钮 `<input type="reset"/>`
* 普通按钮 ：`<input type="button" />` 

## 其他常用标签
* b :加粗
* u :下划线
* i :斜体
* s :删除线
* pre :原样输出
* sub :下标
* sup :上标
* div :自动换行，
* span :在同一行显示
* p :段落，比br标签多一行

## html头标签
头标签：head里面的标签
* title：表示在浏览器标签上面显示的内容
* base：设置超链接的基本设置
  `<base target="_blank"/>`统一设置超链接为在新标签页打开
  <a href="http://cnblogs.com/hjw1"></a>（设置后这样写会在新标签页打开））
* mata:提供设置页面一些相关内容
  * `<meta http-equiv="refresh" content="3,http://cnblogs.com/hjw1"/>`
    实现延时3秒自动跳转到指定页面
  * `<meta name="keywords" content="关键字">`
    提供给搜索引擎关键字
  * link标签：引入外部文件

## 框架标签
有点过时了
`<frameset>
* rows`:按行进行划分
  `<frameset rows="80,*"></frameset> `
* `cols`:cols：按列进行划分
  `<frameset cols="80, *></frameset>" `
* frame:具体显示的页面
  `<frame name="lower_left" src="链接">`
   不能写在`body标签里面
   在a标签的target属性填入frane的name，可实现在指定frame打开链接


