---
title: Python相关方法及功能介绍
date: 2020-03-23 20:24:36
tags:
 - Python
---

介绍装饰器、生成器、with关键字、sort()方法。

#### 装饰器

```python
# python 装饰器
def dec(func):
    def wrapper():
        print("最简单的装饰器")
        func()
    return wrapper
    
    
@dec
def test1():
    print("主函数运行")
    

test1()
```

    最简单的装饰器
    主函数运行

<!--more-->

```python
#带参数的装饰器
def dec(func):
    def wrapper(a, b):
        print("装饰器中获取到a,b分别是",a,b)
        func(a,b)
    return wrapper
    
    
@dec
def test1(a,b):
    print("主函数运行")
    print(a+b)

test1(4,5)
```

    装饰器中获取到a,b分别是 4 5
    主函数运行
    9

```python
#带不确定参数的装饰器
def dec(func):
    def wrapper(*args, **kwargs):
        
        func(*args, **kwargs)
    return wrapper
    
    
@dec
def test1(a, b, c = 6):
    print("a+b+c", a+b+c)
    

test1(1,2,3)
test1(1,2)
```

    a+b+c 6
    a+b+c 9

#### sort()方法

```python
# sort 排序 按照列表中首字母进行排序
res = [100,21,35,5,8,18,79,66]
def get_elem(elem):
    return str(elem)[0]

res.sort(key = get_elem)
print(res)

```

    [100, 18, 21, 35, 5, 66, 79, 8]

#### 生成器和迭代器

```python
# 生成器和迭代器
import random
def creat_random(n):
    i = 0
    while i < n: 
        b = random.randint(0,1000)
        i += 1
        yield b
#随机数列表生成器
def creat_random_list(n):
    return [x for x in creat_random(n)]

list_elem = (x for x in creat_random(3))
print(next(list_elem))
print(next(list_elem))
print(creat_random_list(5))
```

    560
    187
    [818, 606, 33, 435, 408]

#### with 关键词
```python
"""
with 语句实质是上下文管理。
1、上下文管理协议。包含方法__enter__() 和 __exit__()，支持该协议对象要实现这两个方法。
2、上下文管理器，定义执行with语句时要建立的运行时上下文，负责执行with语句块上下文中的进入与退出操作。
3、进入上下文的时候执行__enter__方法，如果设置as var语句，var变量接受__enter__()方法返回值。
4、如果运行时发生了异常，就退出上下文管理器。调用管理器__exit__方法。
"""
```


```python
# with 关键词
class Mycontex(object):
    def __init__(self,name):
        self.name=name
    def __enter__(self):
        print("进入enter")
        return self
    def do_self(self):
        print(self.name)
    def __exit__(self,exc_type,exc_value,traceback):
        print("退出exit")
        print(exc_type,exc_value)
if __name__ == '__main__':
    with Mycontex('test') as mc:
        mc.do_self()
```

    进入enter
    test
    退出exit
    None None


