---
title: 函数闭包，以Python、Go语言为例
date: 2020-04-01 23:27:58
tags: 
 - Go语言 
 - Python
categories: 
 - Go语言
---

#### 闭包的概念

- 封闭的东西：保证数据的安全
- 内存函数对外层函数非全局变量的引用（使用），就会形成闭包
- 被引用的的全局变量也成为做自由变量，这个自由变量会与内层函数产生一个绑定关系
- 自由变量不会在内存中的消失

#### 举例

##### Python

需求：要求计算一只股票的平均历史收盘价格。

<!--more-->

1.刚开始，我们的代码是这样写的。

```Python
l1 = []

def make_averager(new_value):
    l1.append(new_value)
    total = sum(l1)
    average = total/len(l1)
    return average
print(make_averager(100000))
print(make_averager(110000))
print(make_averager(120000))
print(make_averager(90000))
```

运行此段代码：

```
100000.0
105000.0
110000.0
105000.0
```

得到正确结果，但是我们有另一只股票需要计算。

`print(make_averager(90))`得到的结果却是`84018.0`, 把上支股票的历史数据加载进来了。显然刚开始的代码是不可行的。然后我们又想办法，把`l1`全局变量放到函数内，作为内部变量。

修改后的代码如下：

```python
def make_averager(new_value):
    l1 = []
    l1.append(new_value)
    total = sum(l1)
    average = total/len(l1)
    return average

print(make_averager(100000))
print(make_averager(110000))
print(make_averager(120000))
print(make_averager(90000))
```

运行结果如下：

```
100000.0
110000.0
120000.0
90000.0
```

每次调用函数，`l1`均变为空，之前的历史数据无法记录。显然不可行，我们还必须修改方法，这次就需要引入闭包这个概念。

```python
def make_averager():
    l1 = []
    def averager(new_value):
        l1.append(new_value)
        total = sum(l1)
        return total/len(l1)
    return averager
```

我们对`make_averager()`函数，进行调用，并返回`averager()`函数，并用某个变量进行接受，此时的`l1`为`averager()`的“外部变量”。这样我们多次调用，就会产生多个“外部变量”，并且互不干涉。这样就可以计算多个股票的平均历史收盘价格。

```python
avg1 = make_averager()
avg2 = make_averager()
avg1 = make_averager()
avg2 = make_averager()
print(avg1(10000))
print(avg1(12000))
print(avg2(90))
```

结果如下,结果符合预期：

```
10000.0
11000.0
90.0
```

##### Go语言

Go语言，比Python健壮，对参数传入的值、返回的值、定义变量的类型都要求严格。

这次我们的需求时这样的，定义一个函数，包含加减算法。即传入一个值后我可以对他进行加减操作，且传入另一个值后之前的数据不会影响到当前的计算。这就要引入闭包的概念了，相关代码如下。

```go
package main

import "fmt"

func calc(base int) (func(int) int,func(int) int){
   add := func(i int) int {
      base += i
      return base
   }

   sub := func(i int) int {
      base -= i
      return base
   }
   return add, sub
}

func main()  {
   f1, f2 := calc(10)
   fmt.Println(f1(1),f2(2))
   fmt.Println(f1(3),f2(4))
   fmt.Println(f1(5),f2(6))
    
   f3, f4 := calc(100)
   fmt.Println(f1(1),f2(2))
   fmt.Println(f1(3),f2(4))
   fmt.Println(f1(5),f2(6)) 
}
```

结果如下,f1,f2分别对10进行的加减，f3,f4分别对100进行的加减，符合需求。

```
11 9
12 8
13 7
101 99
96 100
95 89
```

#### 闭包的判断

看内层函数有没有对外层函数变量的引用（使用）,其中Python可以用以下代码，返回变量名，即可确认为闭包。

```python
#如何判断闭包
ret = make_averager()
print(ret.__code__.co_freevars)
```

