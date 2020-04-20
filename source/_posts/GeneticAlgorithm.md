---
title: 【Algorithm】遗传算法的设计与实现
date: 2020-04-19 17:31:24
tags:
categories: Algorithm
---

遗传算法是在20世纪六七十年代由美国密歇根大学的 Holland教授创立。60年代初,Holland在设计人工自适应系统时提出应借鉴遗传学基本原理模拟生物自然进化的方法。

“物竞天择、适者生存”是达尔文进化论的核心观点，生物染色体上的基因会发生交换、变异，对适应环境有帮助的变异会较大概率被保留下来。

<!--more-->

本文探讨最简单的遗传变异算法。

其核心思想为：

1. 初始化种群， 种群的染色体用二进制数表示。
2. 根据具体问题构造相关函数。
3. 求出种群中个体的适应值。
4. 通过轮盘选择模拟环境的自然选择。
5. 模拟自然变异和基因交换。
6. 选择若干代后适应值最大的个体为最优解。

让我们来看这个题，用求导方式可求出当x为10的时候为最优解。那现在我们用遗传算法来求这道题。

{% asset_img image-20200419182508296.png This is an example image %}

相关代码如下：

Ps： 算法未通过随机数进行变异，且交换概率设置为1，有点懒，不改了。

```python
#!usr/bin/env python
# -*- coding:utf-8 _*-
"""
@version: v1.0
@author:Colin
@file: 遗传算法.py
@time: 2020/4/19/14:48
"""

import random


# 初始化原始种群  x 代表编码长度 y 代表初始种群数量
def originalPopulation(x, y):
    res = []
    tmp = ''
    for i in range(1, x * y + 1):
        t = random.randint(0, 1)
        tmp += str(t)
        if i % x == 0:
            res.append(tmp)
            tmp = ''
    return res


# 函数运算
def func(elem):
    if type(elem) == type('a'):
        elem = exchange(elem)
    return elem ** 3 - 60 * elem ** 2 + 900 * elem + 100


# 二分查找
def binarySearch(rate_list, t):
    res = rate_list
    left = 0
    right = len(res) - 1
    while left <= right:
        mid = int((left + right) / 2)
        if t <= res[mid]:
            if mid - 1 >= 0 and t > res[mid - 1] or not res[mid - 1]:
                return mid
            else:
                right = mid - 1
                continue
        if t > res[mid]:
            if mid + 1 <= len(res) - 1 and t <= res[mid + 1]:
                return mid + 1
            else:
                left = mid + 1
                continue
    return left


# 二进制转换为十进制
def exchange(ele):
    n = 0
    num = 0
    for i in ele[::-1]:
        num += int(i) * 2 ** n
        n += 1
    return num


# 生存概率转换
def rate(res):
    rate_list = []
    sum_num = 0
    for elem in res:
        sum_num += func(elem)
    for elem in res:
        rate_list.append(func(elem) / sum_num)
    for index in range(1, len(rate_list)):
        rate_list[index] = rate_list[index - 1] + rate_list[index]
    return rate_list


# 圆盘选择父母方
def roulette(res, rate_list):
    parents_res = []
    n = 2 * len(res)
    while n != 0:
        t = random.random()
        # 二分查找合适
        index = binarySearch(rate_list, t)
        parents_res.append(res[index])
        n -= 1
    new_res = reproduction(parents_res)
    return new_res


# 染色体基因交换，变异
def reproduction(parents_res):
    new_res = []
    # p1 交换概率  p2 突变概率
    p1 = 0.9
    p2 = 0.05
    #应该设置随机数 判断是否交换 变异
    #TODO随机变异
    for i in range(0, len(parents_res), 2):
        a = random.randint(0, len(parents_res[0]))
        new_res.append(parents_res[i][:a] + parents_res[i + 1][a:])
    return new_res


if __name__ == '__main__':
    res = originalPopulation(5, 500)
    print(res)
    print([exchange(x) for x in res])

    print("遗传算法运算后================")
    n = 200
    while n != 0:
        rate_list = rate(res)
        res = roulette(res, rate_list)
        n -= 1

    print([exchange(x) for x in res])
```

当初始种群设置为50的时候，经过200次繁衍，种群只剩10和11两种，通过带入10、11这两个元素，可得出在x = 10的情况下取得最优解。

```
#初始基因序列
['10100', '01100', '01010', '11110', '01000', '10011', '10000', '10010', '01011', '01011', '10110', '11001', '11001', '00011', '10011', '00010', '10000', '01010', '10011', '10000', '11001', '11111', '11101', '01011', '10110', '01100', '10111', '10100', '10010', '01011', '00100', '00010', '01000', '00000', '00001', '11110', '00100', '11001', '00000', '11001', '10010', '11001', '00110', '11001', '00000', '01001', '00110', '00011', '11110', '11110']
#初始种群
[20, 12, 10, 30, 8, 19, 16, 18, 11, 11, 22, 25, 25, 3, 19, 2, 16, 10, 19, 16, 25, 31, 29, 11, 22, 12, 23, 20, 18, 11, 4, 2, 8, 0, 1, 30, 4, 25, 0, 25, 18, 25, 6, 25, 0, 9, 6, 3, 30, 30]
遗传算法运算后================(200次繁衍)
[11, 10, 10, 11, 11, 10, 10, 10, 10, 11, 11, 10, 10, 11, 11, 10, 11, 11, 11, 10, 10, 11, 11, 10, 10, 10, 11, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 10, 10, 11, 10, 10, 10, 10, 10, 10, 10, 10, 11, 10]
```

但因为未设置突变，在经过多次繁衍有可能出现，全是9和全是11的情况，需要添加突变概率。且添加突变概率后上面的结果不会全是10和11，但是绝对包括10，求最优解依然是10。