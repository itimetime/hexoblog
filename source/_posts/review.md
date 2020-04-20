---
title: 题目：对比两个文件夹中两个文件
date: 2020-03-21 21:45:14
tags:
 - Python
---

记录一次面试题吧，题目如下：

Write a script that reads all files from a folder (A), compares the files with another folder (B) and sorts files into 3 folders.

1. “Files only exist in folder A” 

2. “Files only exist in folder B”

3. “Files exist in both folders

翻译成中文大约是，写一个脚本，A，B两个文件夹，找出仅存在与A的文件，仅存在于B的文件，两个都同时存在的文件，并把分别放到三个文件夹中。

看这个题目，涉及到文件的获取、拷贝，文件夹的创建，这样肯定要用到python自带的OS库，同时要判断文件是否相同，必须找着文件的唯一辨识码，仅通过名称绝对是不可行的，这里选择通过MD5进行校验。相关代码如下：

<!--more-->

```python
import os,shutil
import hashlib
def getHash(filepath):
    with open(filepath,'r',encoding='utf-8') as f:
        data = f.read()
        file_md5 = hashlib.md5(data.encode('utf-8')).hexdigest()
        return file_md5


def getFileData(path):
    allfilelist = os.listdir(path)
    dic = {}
    for i in allfilelist:
        filepath = os.path.join(path, i)
        md5_str = getHash(filepath)
        dic[md5_str] = i
    return dic

if __name__ == '__main__':
    path_A,  path_B= './A', './B'
    dict_A = getFileData(path_A)
    dict_B = getFileData(path_B)
    only_A,only_B,Both_AB = './OnlyA','./OnlyB','BothAB'
    if not os.path.exists(only_A):
        os.mkdir(only_A)
    if not os.path.exists(only_B):
        os.mkdir(only_B)
    if not os.path.exists(Both_AB):
        os.mkdir(Both_AB)
    for i in dict_A:
        if i not in dict_B:
            shutil.copyfile(os.path.join(path_A, dict_A[i]),os.path.join(only_A, dict_A[i]))
        else:
            shutil.copyfile(os.path.join(path_A, dict_A[i]), os.path.join(Both_AB, dict_A[i]))
    for j in dict_B:
        if j not in dict_A:
            shutil.copyfile(os.path.join(path_B, dict_B[j]),os.path.join(only_B, dict_B[j]))
```

