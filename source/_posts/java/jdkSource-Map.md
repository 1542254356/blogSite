---
title: jdk源码解析-Map
date: 2019-09-12 16:49:37
tags: java
categories: java
---

## 概述

`java.util.Map`是一个泛型接口。

```
public interface Map<K,V> {}
```

Map 接口可以将键映射到值，不能包含重复的键，每个键最多可以映射到一个值。

与之相似的是`Dictionary`抽象类，不过接口使用起来更灵活一些。每天被面试官问的`HashMap`实现了`Map`接口，而`HashTable`也实现了`Map`接口，并且继承了`Dictionary`抽象类。

`Map`接口是用来代替`Dictionary`抽象类的，接口更适合定义行为规范。

## 内部类

### Entry

`Map`接口有一个内部接口`Interface Map.Entry<K,V>`。

此接口主要定义了对key和value的读写操作。

## 遍历

`Map`提供了3种集合视图（键集，值集，键值对集）,可以通过下面的方法获取。Map接口对于集合顺序没有要求，不过像`TreeMap` 的集合是有序的，而`HashMap`的集合则无序。

```
Set<K> keySet();				// 不可重复
Collection<V> values();			// 可重复
Set<Map.Entry<K, V>> entrySet();// 不可重复
```

下面用`HashMap`举一个例子:

```
        HashMap<String, String> hashMap = new HashMap<String, String>() {{
            put("blog", "hjwblog.com");
            put("name", "hjw");
            put("time", "2019/09/11");
        }};

        System.out.println("键集:");
        Set<String> keySet = hashMap.keySet();
        for (String key : keySet) {
            System.out.println(key);
        }


        System.out.println("键集:");
        Collection<String> values = hashMap.values();
        for (String value : values) {
            System.out.println(value);
        }

        System.out.println("键值对集");
        Set<Map.Entry<String, String>> entrySet = hashMap.entrySet();
        for (Map.Entry<String, String> entry : entrySet) {
            System.out.println(entry.getKey() + ":" + entry.getValue());
        }
```

输出：

```
键集:
name
time
blog
键集:
hjw
2019/09/11
hjwblog.com
键值对集
name:hjw
time:2019/09/11
blog:hjwblog.com
```

## 方法

### size

```
int size();
```

此方法返回`Map`中键值对的数量，如果数量超过`Integer.MAX_VALUE`，返回`Integer.MAX_VALUE`。

### isEmpty

```
boolean isEmpty();
```

此方法返回`Map`里面是否有键值对。

### containsKey

```
boolean containsKey(Object key);
```

判断是否包含对应的key。

此接口是可以把null当作键的，如果实现上不允许键为null，可以抛出`NullPointerException`。

当key的类型是map实现类不支持的时候，则抛出`ClassCastException`异常。

### containsValue

```
boolean containsValue(Object value);
```

判断是否包含对应的value值。

这个操作复杂度应该是O(n)的。

### get

```
V get(Object key);
```

此方法返回指定key映射到的 value，如果该 Map 不包含该 key 的映射，则返回null。

如果 value 可以为 null ，此方法不能区分是否包含该键，都可能返回 null 。需要用`containsKey`方法区分。

### put

```
V put(K key, V value);
```

插入一个键值对。

如果存在此键了，会替换该键对应的值，顺便看了一下`HashMap`的实现中，是会返回旧值的。

此处对于熟悉 C++ STL 的要注意了，C++ STL里面的 map 插入键值对如果键值对已存在，是不会更改旧值的，要判断返回值才知道是否插入成功，之前我在这里遇到了坑。

### remove

```
V remove(Object key);
```

移除 key 对应的键值对。

如果移除成功返回值，没有找到返回 null 。

### putAll

```
void putAll(Map<? extends K, ? extends V> m);
```

此方法可以将一个 Map 的全部键值对添加到本 Map 中。

作用相当于遍历 m ，对每一个键值对调用一次 put 方法。

这里`? extends K`指得是 K 或者 K 的子类。

相对的`? super K`指得是 K 或者 K 的父类。

### clear

```
void clear();
```

清空`Map`。

### keySet

```
Set<K> keySet();
```

返回此`Map`中包含的键的集合视图。

如果此时`Map`被改变，则此`Set`也会变，反之亦然，不过只支持移除操作，不能执行插入操作。

```
Set<String> keySet = hashMap.keySet();
keySet.remove("name");
```

如上，对`Set`执行remove方法，会导致`Map`里面的键值对被删除。

这里有个注意事项，在遍历过程中对Map执行remove是会报错的。(虽然没人会这样写，但是这对ArrayList之类的也一样)

```
Iterator<String> it = keySet.iterator();
        while (it.hasNext()){
            String key = it.next();
            if ("name".equals(key)){
                keySet.remove(key);
            }
        }
```

上面的代码会抛出`java.util.ConcurrentModificationException`异常。

正确写法：

```
        Iterator<String> it = keySet.iterator();
        while (it.hasNext()){
            String key = it.next();
            if ("name".equals(key)){
                it.remove();
            }
        }
```

虽然对于`Map`删除元素只要调用remove方法，但是这里写这个例子主要是说明迭代过程中修改Map的正确方法。

### values

```
Collection<V> values();
```

返回此`Map`中包含的值的集合视图。

类似`keySet`,如果此时`Map`被改变，`Set`也会变，反之亦然，不过只支持移除操作，不能执行插入操作。

其他方面和[`keySet`](https://github.com/1542254356/JDKSourceNotes/blob/master/java/util/Map.md#keySet)方法差不多。

### entrySet

```
Set<Map.Entry<K, V>> entrySet();
```

返回此`Map`中包含的映射的集合视图。

其他方面和[`keySet`](https://github.com/1542254356/JDKSourceNotes/blob/master/java/util/Map.md#keySet)方法差不多。

### equals

```
boolean equals(Object o);
```

就是比较两个`Map`是否相等的。

`Map`相等的定义是`m1.entrySet().equals(m2.entrySet())`。

### hashCode

```
int hashCode();
```

返回`Map`的hash码。

`Map`的哈希码定义为``entrySet()` `的所有entry的哈希码之和。

保证如果`m1.equals(m2)`则`m1.hashCode()==m2.hashCode()`。

### getOrDefault

```
default V getOrDefault(Object key, V defaultValue) {
        V v;
        return (((v = get(key)) != null) || containsKey(key))
            ? v
            : defaultValue;
    }
```

这里使用了jdk8的新特性——default。

可以在接口实现一个方法。

此方法可以通过`key`获取`value`，如果`key`不存在，则返回指定的默认值。

在某些特定时刻，此方法可以精简代码。

### forEach

```
    default void forEach(BiConsumer<? super K, ? super V> action) {
        Objects.requireNonNull(action);
        for (Map.Entry<K, V> entry : entrySet()) {
            K k;
            V v;
            try {
                k = entry.getKey();
                v = entry.getValue();
            } catch(IllegalStateException ise) {
                // this usually means the entry is no longer in the map.
                throw new ConcurrentModificationException(ise);
            }
            action.accept(k, v);
        }
    }
```

为`Map`中的每个`entry`执行给定的操作，直到处理完所有`entry`或操作引发异常为止。

相当于:

```
for (Map.Entry<K, V> entry : map.entrySet())
     action.accept(entry.getKey(), entry.getValue());
Objects.requireNonNull(action);
```

Objects 类是jdk7出现的，提供了一些对对象的常用操作静态方法。

`requireNonNull`如果判断参数是`null`，则会抛出`NullPointerException`。

```
hashMap.forEach(new BiConsumer<String, String>() {
            @Override
            public void accept(String key, String value) {
                System.out.println(key + ":" + value);
            }
        });
```

同样的，不要尝试在遍历时修改Map。

```
hashMap.forEach(new BiConsumer<String, String>() {
            @Override
            public void accept(String key, String value) {
                hashMap.remove(key);
            }
        });
```

这样会抛出`ConcurrentModificationException`。

### replaceAll

```
    default void replaceAll(BiFunction<? super K, ? super V, ? extends V> function) {
        Objects.requireNonNull(function);
        for (Map.Entry<K, V> entry : entrySet()) {
            K k;
            V v;
            try {
                k = entry.getKey();
                v = entry.getValue();
            } catch(IllegalStateException ise) {
                // this usually means the entry is no longer in the map.
                throw new ConcurrentModificationException(ise);
            }

            // ise thrown from function is not a cme.
            v = function.apply(k, v);

            try {
                entry.setValue(v);
            } catch(IllegalStateException ise) {
                // this usually means the entry is no longer in the map.
                throw new ConcurrentModificationException(ise);
            }
        }
    }
```

这个方法会对所有元素调用`apply`方法，并将`key`和`value`作为参数，将返回值作为新value。

等价于：

```
for (Map.Entry<K, V> entry : map.entrySet())
     entry.setValue(function.apply(entry.getKey(), entry.getValue()));
```

例子：

```
        hashMap.replaceAll(new BiFunction<String, String, String>() {
            @Override
            public String apply(String key, String value) {
                if ("hjw".equals(value)){
                    return "hjw1";
                }
                return value;
            }
        });
```

`BiFunction`泛型接口第一个参数是`key`的类型，第二个参数是`value`的类型，第三个参数是新`value`的类型，即为`apply`方法的返回值。

### putIfAbsent

```
    default V putIfAbsent(K key, V value) {
        V v = get(key);
        if (v == null) {
            v = put(key, value);
        }

        return v;
    }
```

如果此`key`对应的value为`null`，则插入`value`，否则不变。

### remove(Object key, Object value)

```
    default boolean remove(Object key, Object value) {
        Object curValue = get(key);
        if (!Objects.equals(curValue, value) ||
            (curValue == null && !containsKey(key))) {
            return false;
        }
        remove(key);
        return true;
    }
```

这个方法只有`key`和`value`都匹配时才会移除键值对。