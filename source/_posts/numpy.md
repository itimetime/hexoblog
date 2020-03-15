---
title: NumPy学习日记
date: 2020-03-15 15:45:45
tags: 
 - NumPy
 - Python
---

学习相关的机器学习算法，需要相关的`NumPy`库进行数据处理，以下是自己的相关的学习日记。

```python
import numpy as np
array1 = np.array([[1,2,3],
                [2,3,4]])
print(array)
```

    [[1 2 3]
     [2 3 4]]

<!--more-->

```python
print('number of dim', array.ndim)
```

    number of dim 2



```python
print('shap',array.shape)
print('size',array.size)
```

    shap (2, 3)
    size 6



```python
array2 = np.array([[1,2,3],
                [2,3,4]], dtype = np.int)
print(array2.dtype)
array3 = np.array([[1,2,3],
                [2,3,4]], dtype = np.int64)
print(array3.dtype)
#同时可以float
```

    int32
    int64



```python
#生成全部为零的矩阵
array4 = np.zeros((3,4))
print("""array4
""",array4)

#生成全部为1的矩阵
array5 = np.ones((3,4), dtype = np.int16)
print("""array5
""",array5)

#生成空的矩阵
array6 = np.empty((3,4))
print("""array6
""",array6)

#生成有序的的矩阵 shart end step
array7 = np.arange(10, 20, 2)
print("""array7
""",array7)

#生成有序的矩阵，并重新定义形状
array8 = np.arange(12).reshape((3,4))
print("""array8
""",array8)


```

    array4
     [[0. 0. 0. 0.]
     [0. 0. 0. 0.]
     [0. 0. 0. 0.]]
    array5
     [[1 1 1 1]
     [1 1 1 1]
     [1 1 1 1]]
    array6
     [[0. 0. 0. 0.]
     [0. 0. 0. 0.]
     [0. 0. 0. 0.]]
    array7
     [10 12 14 16 18]
    array8
     [[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]



```python
#生成等分的矩阵，并重新定义形状
array9 = np.linspace(2.0, 3.0, num=5)
print("""array9
""",array9)
```

    array9
     [2.   2.25 2.5  2.75 3.  ]



```python
a = np.array([10, 20, 30, 40])
b = np.arange(4)
#array的加减法
c = a - b
print(c)
```

    [10 19 28 37]



```python
#array的乘除法
c = b ** 2
print(c)
```

    [0 1 4 9]



```python
#array 三角函数运算
c = 10 * np.sin(a)
print(c)
```

    [-5.44021111  9.12945251 -9.88031624  7.4511316 ]



```python
print(b<3)
```

    [ True  True  True False]



```python
#二维矩阵的运算
a = np.array([[1,1],
             [0,1]])
b = np.arange(4).reshape((2,2))
c = a * b
c_dot = np.dot(a,b)
c_dot_2 = a.dot(b)
print(c)
print("""矩阵的运算结果
"""
,c_dot)
```

    [[0 1]
     [0 3]]
    矩阵的运算结果
     [[2 4]
     [2 3]]



```python
a = np.random.random((2,4))
print(a)
print("求和运算", np.sum(a))
print("求和运算", np.sum(a))
print("求最大值", np.max(a))
print("求最小值", np.min(a))
print("求和运算", a.sum(axis =1))
# 1是行 0是列
```

    [[0.87951939 0.5848109  0.64063694 0.17805487]
     [0.55274668 0.37703839 0.54034611 0.40581276]]
    求和运算 4.158966048941433
    求和运算 4.158966048941433
    求最大值 0.8795193929533729
    求最小值 0.17805487136437548
    求和运算 [2.28302211 1.87594394]



```python
A = np.arange(2, 14).reshape((3,4))
print(A)
print("最小值索引",A.argmin())
print("最大值索引",A.argmax())
print("平均值",A.mean())
print("平均值",np.average(A))
print("中位数",np.median(A))
print("累加",np.cumsum(A))
print("累加",np.diff(A))
print("返回非零的位置",np.nonzero(A))
print("排序",np.sort(A))
print("矩阵的转置", A.T) #同np.transpose(A)
print("保留中间的数(滤波)", np.clip(A, 5, 9))
```

    [[ 2  3  4  5]
     [ 6  7  8  9]
     [10 11 12 13]]
    最小值索引 0
    最大值索引 11
    平均值 7.5
    平均值 7.5
    中位数 7.5
    累加 [ 2  5  9 14 20 27 35 44 54 65 77 90]
    累加 [[1 1 1]
     [1 1 1]
     [1 1 1]]
    返回非零的位置 (array([0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2], dtype=int64), array([0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3], dtype=int64))
    排序 [[ 2  3  4  5]
     [ 6  7  8  9]
     [10 11 12 13]]
    矩阵的转置 [[ 2  6 10]
     [ 3  7 11]
     [ 4  8 12]
     [ 5  9 13]]
    保留中间的数(滤波) [[5 5 5 5]
     [6 7 8 9]
     [9 9 9 9]]



```python
# 录入了四位同学的成绩，按照总分排序，总分相同时语文高的优先
math    = (10, 20, 50, 10)
chinese = (30, 50, 40, 60)
total   = (40, 70, 90, 70)
# 将优先级高的项放在后面
ind = np.lexsort((math, chinese, total))
#输出，是按总成绩排序，相同时语文成绩优先级更高:
for i in ind:
    print(total[i],chinese[i],math[i])
```

    40 30 10
    70 50 20
    70 60 10
    90 40 50



```python
A = np.arange(3, 15).reshape((3,4))
print(A[1][1])
print(A[1,1])
print(A[1,1:])
```

    8
    8
    [ 8  9 10]



```python
for i in A.T:
    print(i)
print("转置为列迭代")
for i in A:
    print(i)
```

    [ 3  7 11]
    [ 4  8 12]
    [ 5  9 13]
    [ 6 10 14]
    转置为列迭代
    [3 4 5 6]
    [ 7  8  9 10]
    [11 12 13 14]



```python
print(A.flatten())
for item in A.flat:
    print(item)
```

    [ 3  4  5  6  7  8  9 10 11 12 13 14]
    3
    4
    5
    6
    7
    8
    9
    10
    11
    12
    13
    14



```python
A = np.array([1,1,1])
B = np.array([2,2,2])
print("合并",np.vstack((A,B)))
print("合并",np.hstack((A,B)))
print(A[:,np.newaxis])
C = np.concatenate((A,B,A), axis = 0)
print(C)
```

    合并 [[1 1 1]
     [2 2 2]]
    合并 [1 1 1 2 2 2]
    [[1]
     [1]
     [1]]
    [1 1 1 2 2 2 1 1 1]



```python
A = np.arange(3, 15).reshape((3,4))
print(A)
print("横向分割",np.split(A,2, axis = 1))
print("横向不等分割",np.array_split(A,2, axis = 0))
print(np.vsplit(A,3))
print(np.hsplit(A,2))
```

    [[ 3  4  5  6]
     [ 7  8  9 10]
     [11 12 13 14]]
    横向分割 [array([[ 3,  4],
           [ 7,  8],
           [11, 12]]), array([[ 5,  6],
           [ 9, 10],
           [13, 14]])]
    横向不等分割 [array([[ 3,  4,  5,  6],
           [ 7,  8,  9, 10]]), array([[11, 12, 13, 14]])]
    [array([[3, 4, 5, 6]]), array([[ 7,  8,  9, 10]]), array([[11, 12, 13, 14]])]
    [array([[ 3,  4],
           [ 7,  8],
           [11, 12]]), array([[ 5,  6],
           [ 9, 10],
           [13, 14]])]