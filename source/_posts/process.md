---
title: Python多进程、多线程详解(含代码实现)
date: 2020-04-04 22:07:10
tags: Python
categories: Python
---

### 多任务介绍

- 单核CPU实现多任务：操作系统轮流让各个任务交替执行。但因为CPU调度速度块，感觉任务在同时执行。

- 多核CPU实现多任务：任务会分配到每个多核CPU上，当任务多于核心数，操作系统也会自动把很多任务轮流调度到每个核心上执行。

- 并发和并行

  -  **并行**（Concurrent）：当多个线程在进行操作的时候，如果系统只有一个CPU，则它根本不可能同时真正同时进行一个以上的线程，则它只能把CPU运行时间划分若干个时间段，再把时间段分配给各个线程执行。

  - **并发**（Parallel）：系统有一个以上CPU时，当一个CPU执行一个线程的时候，另一个CPU也可以执行另一个线程，两个线程互不抢占CPU资源。


<!--more-->

- 实现多任务的方式

  - 多进程模式
  - 多线程模式
  - 协程

- 包含关系

  进程 -->  线程 --> 携程



### 多进程（process）

*进程*（Process）是计算机中的程序关于某数据集合上的一次运行活动，是系统进行资源分配和调度的基本单位，是操作系统结构的基础。在早期面向进程设计的计算机结构中，进程是程序的基本执行实体；在当代面向线程设计的计算机结构中，进程是线程的容器。程序是指令、数据及其组织形式的描述，进程是程序的实体。

- 优点
  - 稳定性高，一个进程崩溃了，不会影响到其它进程。
- 缺点
  - 创建进程开销巨大
  - 操作系统能同时运行进程数目有限

#### 进程创建

Linux使用fork()函数，Windows上引用multiprocessing模块中的Process类创建新的进程。

Windows下代码写法

```
from multiprocessing import Process
Process(target = 函数, name = 进程的名字, args = (给函数传递的参数))
得到process对象
#调用的方法
process.start()
process.run()#执行任务，没有启动进程
terminate()#终止
```

举例

```python
from multiprocessing import Process
from time import sleep
import os


def task1():
    while True:
        sleep(1)
        #得到进程id和父id
        print(f"这是任务1,进程id{os.getpid()},父进程id{os.getppid()}")


def task2(time, name):
    while True:
        sleep(time)
        print(f"这是任务2,进程id{os.getpid()},父进程id{os.getppid()},{name}")

number = 0
if __name__ == '__main__':
    print(f"这是主进程,进程id{os.getpid()}")
    p1 = Process(target=task1, name="任务1")#子进程
    p1.start()
    print(p1.name)
    p2 = Process(target=task2, name="任务2",args=(2,"进程2"))#子进程
    p2.start()
    print(p2.name) #主进程

    while True:
        sleep(0.5)
        number += 1
        if number == 100:
            p1.terminate()
            p2.terminate()
        else:
            print("-------",number)
```

运行结果

```
这是主进程,进程id1424
任务1
任务2
------- 1
------- 2
这是任务1,进程id13384,父进程id1424
------- 3
------- 4
这是任务1,进程id13384,父进程id1424
这是任务2,进程id10048,父进程id1424,进程2
------- 5
------- 6
这是任务1,进程id13384,父进程id1424
```

#### 自定义进程

原理新建类继承Process类，添加新的方法。举例代码如下。

```python
from multiprocessing import Process


class MyProcess(Process):
    def __init__(self, name):
        self.name = name
        super().__init__()

    # 重写run方法
    def run(self) -> None:
        print("进程名字", self.name)


if __name__ == '__main__':
    p = MyProcess("小明")
    p.start()
```

#### 进程池

#####  同步（Sync）和异步（Async）

**同步：**所谓同步，就是发出一个功能调用时，在没有得到结果之前，该调用就不返回或继续执行后续操作。简单来说，同步就是必须一件一件事做，等前一件做完了才能做下一件事。

**异步：**异步与同步相对，当一个异步过程调用发出后，调用者在没有得到结果之前，就可以继续执行后续操作。当这个调用完成后，一般通过状态、通知和回调来通知调用者。对于异步调用，调用的返回并不受调用者控制。

对于通知调用者的三种方式，具体如下：

- 状态:即监听被调用者的状态（轮询），调用者需要每隔一定时间检查一次，效率会很低。

- 通知:当被调用者执行完成后，发出通知告知调用者，无需消耗太多性能。

- 回调与通知类似，当被调用者执行完成后，会调用调用者提供的回调函数。

例如：B/S模式中的ajax请求，具体过程是：客户端发出ajax请求->服务端处理->处理完毕执行客户端回调，在客户端（浏览器）发出请求后，仍然可以做其他的事。

**同步和异步的区别：**总结来说，同步和异步的区别：请求发出后，是否需要等待结果，才能继续执行其他操作。

##### 阻塞和非阻塞

阻塞和非阻塞这两个概念与程序（线程）等待消息通知(无所谓同步或者异步)时的状态有关。也就是说阻塞与非阻塞主要是程序（线程）等待消息通知时的状态角度来说的。

阻塞和非阻塞关注的是程序在等待调用结果（消息，返回值）时的状态.

阻塞调用是指调用结果返回之前，当前线程会被挂起。调用线程只有在得到结果之后才会返回。非阻塞调用指在不能立刻得到结果之前，该调用不会阻塞当前线

##### 非阻塞式进程

```python
#!usr/bin/env python
# -*- coding:utf-8 _*-
"""
@version: v1.0
@author:Colin
@file: 异步进程.py
@time: 2020/4/4/23:13
"""

from multiprocessing import Pool
import time, random
import os


def task(task_name):
    print(f"start process {task_name},process id {os.getpid()}")
    start = time.time()
    time.sleep(random.random() * 2)
    end = time.time()
    print(f"resume time {end - start},process id {os.getpid()}")
    return task_name

#任务结束调用的方法
def callback_func(n):
    print(f"Complete task{n}")


if __name__ == '__main__':
    pool = Pool(5)
    for i in range(8):
        pool.apply_async(task, args=(i,), callback=callback_func)  # 异步
		#改成pool.apply()改成同步
    pool.close()  # 添加任务结束
    pool.join()  # 让主进程等待子进程
```

运行结果

```
start process 0,process id 7548
start process 1,process id 16276
start process 2,process id 18208
start process 3,process id 5220
start process 4,process id 5012
resume time 0.21154093742370605,process id 5012
start process 5,process id 5012
Complete task4
resume time 0.5643634796142578,process id 18208
Complete task2
start process 6,process id 18208
resume time 0.756005048751831,process id 7548
Complete task0
start process 7,process id 7548
resume time 0.45174264907836914,process id 18208
Complete task6
resume time 1.0329792499542236,process id 5220
Complete task3
resume time 1.8463575839996338,process id 16276
Complete task1
resume time 1.595834493637085,process id 5012
Complete task5
resume time 1.8610379695892334,process id 7548
Complete task7
```

#### 进程间通信

通过消息队列，实现通信，代码如下：

```python
from multiprocessing import Process, Queue
import time


def download(q):
    files = ["1.jpg", "5.exe", "6.csv"]
    for i in files:
        print("正在下载：", i)
        q.put(i)
        time.sleep(0.5)


def getfile(q):
    while True:
        try:
            file = q.get(timeout=5)
            print("保存文件成功：", file)
        except:
            break
            
            
if __name__ == '__main__':
    q = Queue(5)
    p1 = Process(target=download,args = (q,))
    p2 = Process(target=getfile, args= (q,))
    p1.start()
    p2.start()
    p1.join()
    p2.join()
```

运行结果

```
正在下载： 1.jpg
保存文件成功： 1.jpg
正在下载： 5.exe
保存文件成功： 5.exe
正在下载： 6.csv
保存文件成功： 6.csv
```

### 多线程（multithreading）

指从软件或者硬件上实现多个线程并发执行的技术。具有多线程能力的计算机因有硬件支持而能够在同一时间执行多于一个线程，进而提升整体处理性能。具有这种能力的系统包括对称多处理机、多核心处理器以及芯片级多处理（Chip-level multithreading）或同时多线程（Simultaneous multithreading）处理器。在一个程序中，这些独立运行的程序片段叫作“线程”（Thread），利用它编程的概念就叫作“多线程处理（Multithreading）”。

代码示例

```python
import threading
import time


def listenMusic():
    musics = ["李白","说好不哭","稻香","告白气球"]

    for music in musics:
        time.sleep(0.5)
        print(f"正在听{music}歌")

def download():
    files = ["1.jpg", "5.exe", "6.csv"]
    for i in files:
        print("正在下载：", i)
        time.sleep(0.5)


if __name__ == '__main__':
    t1 = threading.Thread(target=download, name="aa")
    t2 = threading.Thread(target=listenMusic, name="bb")
    t1.start()
    t2.start()
```

运行结果

```
正在下载： 1.jpg
正在听李白歌
正在下载： 5.exe
正在听说好不哭歌
正在下载： 6.csv
正在听稻香歌
正在听告白气球歌
```

线程的状态： 新建 就绪 运行 阻塞 结束

当遇到阻塞，阻塞完毕后会回到就绪状态。

#### 线程通信

线程可以共享变量，代码如下

```python
import threading
import time

# 线程可以共享变量

ticket = 1000


def run1():
    global ticket
    for i in range(100):
        ticket -= 1


def run2():
    global ticket
    for i in range(100):
        ticket -= 1
```

 运行结果

```
800
```

#### 线程同步

多个线程对同一个数据进行修改，则可能出现不可预料的结果，为了保证数据的正确性，需要对多个线程进行同步。

使用Thread对象的Lock和Rlock可以实现简单的线程同步，这两个对象都有acquire和release方法。

举例代码：

```python
import threading, random, time

lock = threading.Lock()

list1 = [0 for i in range(3)]


def task1():
    # 获取线程锁。如果已经上锁、则等待锁的释放。
    lock.acquire()  # 阻塞
    for i in range(3):
        list1[i] = i
        print(f"插入数据{i}")
        time.sleep(0.5)
    lock.release()


def task2():
    # 获取线程锁。如果已经上锁、则等待锁的释放。
    lock.acquire()  # 阻塞
    for i in range(3):
        print(f"读取值{list1[i]}")
        time.sleep(0.5)
    lock.release()


if __name__ == '__main__':
    t1 = threading.Thread(target=task1, name="aa")
    t2 = threading.Thread(target=task2, name="bb")
    t1.start()
    t2.start()
    t1.join()
    t2.join()
    print(list1)
```

运行结果

```
插入数据0
插入数据1
插入数据2
读取值0
读取值1
读取值2
[0, 1, 2]
```

### 生产者消费者模型

本质为进程间的通信，相关代码如下

```python
#!usr/bin/env python
# -*- coding:utf-8 _*-
"""
@version: v1.0
@author:Colin
@file: 生产者消费者.py
@time: 2020/4/5/0:35
"""

import threading
import queue
import random
import time


def produce(q):
    i = 0
    while i < 100:
        num = random.randint(1, 100)
        q.put(f"生产者生产数据{num}")
        print(f"生产者生产数据{num}")
        time.sleep(1)
        i += 1
    q.put(None)
    q.task_done()

def consume(q):
    while True:
        item = q.get()
        if item is None:
            break
        print(f"消费者获取到：{item}")
        time.sleep(4)

    q.task_done()


if __name__ == '__main__':
    q = queue.Queue(10)
    arr = []
    t1 = threading.Thread(target=produce, name="生产者",args=(q,))
    t2 = threading.Thread(target=consume, name="消费者",args=(q,))
    t1.start()
    t2.start()
    t1.join()
    t2.join()
```

程序部分运行结果

```
生产者生产数据57
消费者获取到：生产者生产数据57
生产者生产数据93
生产者生产数据74
生产者生产数据76
消费者获取到：生产者生产数据93
生产者生产数据13
生产者生产数据14
生产者生产数据37
生产者生产数据6
消费者获取到：生产者生产数据74
```

还有协程部分，目前还未涉及到，先不写了。

<end!>

