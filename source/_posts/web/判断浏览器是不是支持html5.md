---
title: 判断浏览器是不是支持html5
date: 2018-04-29 14:28:08
tags: html
categories: web开发
---

在html文件里面加入下面的代码：

```html
<script>
  window.onload=function()
  {
    if(window.applicationCache)
      {
        alert("浏览器支持html5");
      }
    else
      alert("浏览器不支持html5");
    
  }
</script>
```

