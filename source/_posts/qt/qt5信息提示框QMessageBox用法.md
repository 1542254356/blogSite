---
title: qt5信息提示框QMessageBox用法
date: 2018-04-24 10:37:38
tags: qt
categories: qt
---

## information

```c++
QMessageBox::information(NULL, "Title", "Content", 
                         QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
```

这是比较常用的一种用法，效果如下：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/information1.jpg)

information原型：

```c++
StandardButton QMessageBox::information(QWidget * parent, const QString & title, const QString & text, StandardButtons buttons = Ok, StandardButton defaultButton = NoButton) [static]
```

- 第一个参数是父控件指针
- 第二个参数是标题
- 第三个参数是内容
- 第四个参数是窗口里面要多少个按钮（默认为OK）
- 第五个参数指定按下Enter时使用的按钮。（默认为NoButton，此时QMessageBox会自动选择合适的默认值。）

示例1：

```c++
QMessageBox::information(NULL, "Title", "Content");
```

此时第四第五为默认参数，效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/information2.jpg)

示例2：

```c++
QMessageBox::information(NULL, "Title", "Content",QMessageBox::Yes|QMessageBox::No);
```

此时效果（与图1相同）：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/information1.jpg)

示例三：

```c++
QMessageBox::information(NULL, "Title", "Content",QMessageBox::Yes|QMessageBox::No|
                             QMessageBox::Abort);
```

添加多个按钮用|运算符连接，效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/information3.jpg)

按钮类型参考：

```c++
enum StandardButton {
        // keep this in sync with QDialogButtonBox::StandardButton
        NoButton           = 0x00000000,
        Ok                 = 0x00000400,
        Save               = 0x00000800,
        SaveAll            = 0x00001000,
        Open               = 0x00002000,
        Yes                = 0x00004000,
        YesToAll           = 0x00008000,
        No                 = 0x00010000,
        NoToAll            = 0x00020000,
        Abort              = 0x00040000,
        Retry              = 0x00080000,
        Ignore             = 0x00100000,
        Close              = 0x00200000,
        Cancel             = 0x00400000,
        Discard            = 0x00800000,
        Help               = 0x01000000,
        Apply              = 0x02000000,
        Reset              = 0x04000000,
        RestoreDefaults    = 0x08000000,

        FirstButton        = Ok,                // internal
        LastButton         = RestoreDefaults,   // internal

        YesAll             = YesToAll,          // obsolete
        NoAll              = NoToAll,           // obsolete

        Default            = 0x00000100,        // obsolete
        Escape             = 0x00000200,        // obsolete
        FlagMask           = 0x00000300,        // obsolete
        ButtonMask         = ~FlagMask          // obsolete
    };
```



会创建消息提示框后，我们怎么知道用户点了什么呢，看如下小例子：

```c++
    QMessageBox:: StandardButton result= QMessageBox::information(NULL, "Title", "Content",QMessageBox::Yes|QMessageBox::No);
    switch (result)
    {
    case QMessageBox::Yes:
        qDebug()<<"Yes";
        break;
    case QMessageBox::No:
        qDebug()<<"NO";
        break;
    default:
        break;
    }
```


## critical


critical	adj.	关键的; 批评的，爱挑剔的; 严重的; 极重要的;

```c++
QMessageBox::critical(NULL, "critical", "Content", QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
```

效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/critical1.jpg)

## warning

```c++
QMessageBox::warning(NULL, "warning", "Content", QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
```

效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/warning.jpg)

## question

```c++
QMessageBox::question(NULL, "question", "Content", QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
```

效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/question.jpg)

## about

原型：`static void about(QWidget *parent, const QString &title, const QString &text);`

```c++
QMessageBox::about(NULL, "About", "by hjwblog.com");
```

效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/about.jpg)

##  使用QMessageBox对象

如果是自己创建的QMessageBox对象，而不是用上面的static函数

示例1：

```c++
void MainWindow::on_pushButton_clicked()
{
    QMessageBox messageBox;
    messageBox.show();
}
```

这里在按钮的clicked槽里面创建了一个QMessageBox，但是这样会出现消息框一闪而过。这是因为c++局部变量的生命周期结束了，`QMessageBox messageBox`是函数局部变量,函数结束后它的生命周期也结束了。

示例2：

```c++
void MainWindow::on_pushButton_clicked()
{
    static QMessageBox messageBox;
    messageBox.show();
}
```

效果：

![](http://image.hjwblog.com/qt/qt5%E4%BF%A1%E6%81%AF%E6%8F%90%E7%A4%BA%E6%A1%86QMessageBox%E7%94%A8%E6%B3%95/static.jpg)

这样就好理解了，c++函数里面的static变量在函数结束时不会被回收。

示例3：

```c++
void MainWindow::on_pushButton_clicked()
{
    QMessageBox *messageBox=new QMessageBox;
    messageBox->show();
}
```

这样写也能显示提示框，但是这样会内存泄漏。

示例4：

前面的用法都不太完美，我们希望能方便的显示提示框并且获取用户点击了哪个按钮。因为`QMessageBox`继承`QDialog`，而`QDialog`有一个神奇的函数`exec()`，调用这个函数后，消息循环会在这个函数里面进行更新，而调用它的函数是被“暂停”的，就是说等用户点击按钮后，调用`exec()`的函数才继续执行。
直接上代码：



```c++
void MainWindow::on_pushButton_clicked()
{
    QMessageBox messageBox(QMessageBox::NoIcon,
                           "退出", "你确定要退出吗?",
                           QMessageBox::Yes | QMessageBox::No, NULL); ;
    int result=messageBox.exec();


    switch (result)
    {
    case QMessageBox::Yes:
        qDebug()<<"Yes";
        close();
        break;
    case QMessageBox::No:
        qDebug()<<"NO";
        break;
    default:
        break;
    }
}
```

上面的代码实现了点击按钮退出，并且在退出前确定的功能。
`exec()`的返回值和前面的`information()`一样，是整数（information()是枚举）。可以通过返回值来确定用户点击了哪个按钮。

QMessageBox对象调用`exec()`函数能实现与前面的几个静态函数相似的功能。




