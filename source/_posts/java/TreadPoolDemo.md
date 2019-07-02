---
title: java四种线程池Demo
date: 2019-03-21 18:57:27
tags: java
categories: java
---

首先准备一个Runnable

```java
package com.hjwblog;

public class TaskRunnable implements Runnable {

	@Override
	public void run() {
		System.out.println(Thread.currentThread().toString());
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
```


```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class SingleThreadExecutorTest {

	public static void main(String[] args) {
		ExecutorService singleTreadExecutor = Executors.newSingleThreadExecutor();

		for (int i = 0; i < 10; i++) {
			singleTreadExecutor.execute(new TaskRunnable());
		}

		singleTreadExecutor.shutdown();
		System.out.println("shutdown");

		while (!singleTreadExecutor.isTerminated()) {

		}

		System.out.println("Finished all task");
	}

}
```

运行结果：

```
shutdown
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Finished all task
```



```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class FixedThreadPoolTest {

	public static void main(String[] args) {
		ExecutorService fixedThreadPool = Executors.newFixedThreadPool(5);

		for (int i = 0; i < 10; i++) {
			fixedThreadPool.execute(new TaskRunnable());
		}

		fixedThreadPool.shutdown();
		System.out.println("shutdown");

		// shutdown后再添加任务，会抛出RejectedExecutionException异常
		// fixedThreadPool.execute(new TaskRunnable());

		while (!fixedThreadPool.isTerminated()) {

		}

		System.out.println("Finished all tasks");
	}

}
```

运行结果：

```
shutdown
Thread[pool-1-thread-3,5,main]
Thread[pool-1-thread-2,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-4,5,main]
Thread[pool-1-thread-5,5,main]
Thread[pool-1-thread-3,5,main]
Thread[pool-1-thread-2,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-5,5,main]
Thread[pool-1-thread-4,5,main]
Finished all tasks
```



```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ChachedTreadPoolTest {

	public static void main(String[] args) {
		ExecutorService cachedThreadPool = Executors.newCachedThreadPool();

		for (int i = 0; i < 10; i++) {
			cachedThreadPool.execute(new TaskRunnable());
		}

		cachedThreadPool.shutdown();
		System.out.println("shutdown");

		// shutdown后再添加任务，会抛出RejectedExecutionException异常
		// cachedThreadPool.execute(new TaskRunnable());

		while (!cachedThreadPool.isTerminated()) {

		}
		System.out.println("Finished all tasks");

	}

}
```

运行结果：

```
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-2,5,main]
Thread[pool-1-thread-4,5,main]
shutdown
Thread[pool-1-thread-5,5,main]
Thread[pool-1-thread-6,5,main]
Thread[pool-1-thread-3,5,main]
Thread[pool-1-thread-7,5,main]
Thread[pool-1-thread-8,5,main]
Thread[pool-1-thread-9,5,main]
Thread[pool-1-thread-10,5,main]
Finished all tasks
```


```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

public class ScheduledTreadPoolTest {

	public static void main(String[] args) {
		ScheduledExecutorService scheduledTreadPool = Executors.newScheduledThreadPool(2);

		// 延迟3s后，每2s执行一次
		ScheduledFuture<?> scheduledFuture = scheduledTreadPool.scheduleAtFixedRate(new TaskRunnable(), 3, 2,
				TimeUnit.SECONDS);

		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		scheduledFuture.cancel(true);
		System.out.println("cancel");

	}

}
```

运行结果：

```
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-2,5,main]
Thread[pool-1-thread-2,5,main]
cancel
```

这里要注意，取消任务时如果任务在sleep，会抛出异常，可以将延迟时间改为1试试。

```
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
Thread[pool-1-thread-1,5,main]
cancel
java.lang.InterruptedException: sleep interrupted
	at java.lang.Thread.sleep(Native Method)
	at com.hjwblog.TaskRunnable.run(TaskRunnable.java:9)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:308)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301(ScheduledThreadPoolExecutor.java:180)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:294)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
```