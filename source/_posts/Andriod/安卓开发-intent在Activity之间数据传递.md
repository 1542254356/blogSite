---
title: 安卓开发-intent在Activity之间数据传递
date: 2018-03-22 22:07:01
tags: 安卓
categories: 安卓
---

## intent实现普通跳转
使用intent的setclass方法，示例（由此界面跳转到NewActivity界面）
```java
		//使用setOnClickListener方法设置点击事件
		Button button=(Button)findViewById(R.id.mainButton);
		button.setOnClickListener(new OnClickListener()
			{

				@Override
				public void onClick(View p1)
				{
					Intent intent=new Intent();
					intent.setClass(MainActivity.this,NewActivity.class);
					//新建一个Intent，使用setClass方法设置跳转的哪个界面
					startActivity(intent);
				}
				
			
		});
```
## 使用Bundle传递数据的跳转

### Bundle类

Bundle类用来携带数据，类似于map。里面存放键值对。Bundle类有putXXX()/getXXX()方法，如`putInt()`,`getInt()`,`putString()`,`getString()`.

putXXX()用来往Bundle对象存入数据。

getXXX()用来从Bundle对象取出数据。

其内部使用了`HashMap<String,Object>`类型的变量存储数据。

### 示例

如下代码实现将数据从当前Activity传递到另一个Activity：

(当前Activity)

```java
        Button button=(Button)findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Bundle data=new Bundle();
                //创建了一个Bundle对象用来存储在两个Activity之间传递的数据
                data.putString("website","hjwblog.com");
                data.putString("name","环家伟");
                data.putInt("age",20);
                //添加进Bundle对象里面两个String类型的数据和一个int类型的数据
                Intent gotoAnother=new Intent(MainActivity.this,Main2Activity.class);
                //创建了一个从MainActivity跳转到Main2Activity的Intent
                gotoAnother.putExtras(data);
                //将存储了数据的Bundle对象put进Intent里面
                startActivity(gotoAnother);
                //开始跳转
            }
        });
```

(目标Activity)

```java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        Bundle receive=getIntent().getExtras();
        //得到随Intent传递过来的Bundle对象
        String name=receive.getString("name");
        String website=receive.getString("website");
        int age=receive.getInt("age");
        //根据设定的String关键词得到对应的数据。
        ((TextView)findViewById(R.id.name)).setText("姓名："+name);
        ((TextView)findViewById(R.id.age)).setText("年龄："+age);
        ((TextView)findViewById(R.id.website)).setText("博客地址："+website);
        //将数据显示到TextView上面
    }
```

结果：

```
姓名：环家伟
年龄：20
博客地址：hjwblog.com
```

## 直接使用Intent传递数据

Intent自身也有一系列的`putExtra()`函数。( 这里与上面的`putExtras()`函数区分开，这里没有s )
这个函数有很多重载，如`putExtra(String name,String value)`,`putExtra(String name,int value)`等。
与上面的Bundle类操作方法相似，都是String-value键值对。
接收时，Intent对象有`getXXXExtra()`一系列函数得到传递过来的数据,如`getStringExtra()`等。

###  示例：

(当前Activity)

```java
                Intent gotoAnother=new Intent(MainActivity.this,Main2Activity.class);
                //创建了一个从MainActivity跳转到Main2Activity的Intent
                gotoAnother.putExtra("name","环家伟");
                gotoAnother.putExtra("age",20);
                gotoAnother.putExtra("website","hjwblog.com");
                //将数据put进Intent里面
                startActivity(gotoAnother);
                //开始跳转
```

(目标Activity)

```java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        Intent receiveIntent=getIntent();
        //得到Intent
        String name=receiveIntent.getStringExtra("name");
        int age=receiveIntent.getIntExtra("age",0);
        String website=receiveIntent.getStringExtra("website");
        ((TextView)findViewById(R.id.name)).setText("姓名："+name);
        ((TextView)findViewById(R.id.age)).setText("年龄："+age);
        ((TextView)findViewById(R.id.website)).setText("博客地址："+website);
        //将数据显示到TextView上面
    }

```

结果：

```
姓名：环家伟
年龄：20
博客地址：hjwblog.com
```

##  得到新Activity关闭后的数据

想象一下，你要做一个图像处理的app。你在当前actuvity点击了一个按钮，然后出现图片列表，选择图片后原activity要得到图片。这种情况在Windows里面经常出现，点击按钮打开文件管理器选择文件。

要想得到新Activity关闭后传过来的数据，只要在打开新Activity的跳转时使用`startActivityForResult(Intent intent,int requestCode)` 函数，而不是以前的`startActivity()`函数。

这样打开的Activity在关闭后会传回数据。

为了得到传回的数据，需要在前面的Activity里面重写`onActivityResult(int requestCode,int resultCode,Intent data)`函数。

### 示例

实现点击按钮`得到字符串时`，打开新界面，点击按钮关闭新界面后，Toast显示`环家伟`。

而点击按钮`得到整数`时，Toast内容为`20`。

```java
        Button stringButton=(Button)findViewById(R.id.stringButton);
        stringButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent gotoAnother=new Intent(MainActivity.this,Main2Activity.class);
                startActivityForResult(gotoAnother,1);
                //第二个参数是请求码，比如此Activity有两个按钮都是启动同一个新Activity
                //请求码就是用来区分到底是哪个按钮请求的
            }
        });
        Button intButton=(Button)findViewById(R.id.intButton);
        intButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent gotoAnother=new Intent(MainActivity.this,Main2Activity.class);
                startActivityForResult(gotoAnother,2);
                //此处请求码是2
            }
        });
```

重写onActivityResult方法用来接收传过来的信息

```java
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode==1)
            Toast.makeText(this,"按钮1得到字符串："+data.getStringExtra("name"),Toast.LENGTH_SHORT).show();
        if(requestCode==2)
            Toast.makeText(this,"按钮2得到整数："+data.getIntExtra("age",0),Toast.LENGTH_SHORT).show();
        //此处的requestCode就是startActivityForResult里面传递的requestCode
        // 可以用来区分是哪个按钮请求的
        /*
        提示：Toast不要忘记show()
         */
    }

```

新Activity中

```java
        Button closeButton=(Button)findViewById(R.id.close);
        closeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent();//数据通过Intent返回
                intent.putExtra("name","环家伟");
                intent.putExtra("age",20);
                Main2Activity.this.setResult(RESULT_OK,intent);
                //RESULT_OK是一个整数，此参数是结果码，可以用来区分是哪个Activity返回的数据
                //（如果原Activity可以打开多个新Activity）
                finish();//关闭新Activity
            }
        });

```

