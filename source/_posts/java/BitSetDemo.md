---
title: BitSetDemo
date: 2019-03-21 20:33:35
tags: java
categories: java
---

```java
package com.hjwblog;

import java.util.BitSet;

public class BitSetTest {
	public static void main(String[] args) {

		// 创建一个10亿个元素的BitSet
		BitSet bitSet = new BitSet(1000000000);

		// 将偶数位设置为true
		for (int i = 0; i < 1000000000; i++) {
			if ((i & 1) == 0) {
				bitSet.set(i);
			}
		}

		// 大小
		System.out.println("大小：:" + bitSet.size() + "bit"); // 大小：:1000000000bit
		System.out.println("大小：" + bitSet.size() / 8 / 1024 / 1024 + "m"); // 大小：119m

		// 返回此 BitSet中设置为 true的位数
		System.out.println(bitSet.cardinality()); // 500000000

		// 返回一个新的 BitSet，它由此 BitSet 中从 fromIndex（包括）到 toIndex（不包括）范围内的位组成
		BitSet bitSet2 = bitSet.get(0, 100);
		System.out.println(bitSet2);

		// 将此 BitSet 中的所有位设置为 false
		bitSet.clear();
		System.out.println(bitSet.cardinality()); // 0
	}
}
```

运行结果：

```
大小：:1000000000bit
大小：119m
500000000
{0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98}
0
```

