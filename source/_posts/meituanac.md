---

title: 吐槽下3月26日的美团笔试第二题(震惊，一个π的取值引发的血案)
date: 2020-03-26 21:55:02
category: Algorithm
tags:
 - Algorithm
---

美团第二题是类似于靶子，这个样子吧，最外面的圆蓝色，依次白色。按照这个逻辑下面的图最里面为蓝色(网上找的图不准确)。

<img src =  'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1417202375,2333811820&fm=26&gp=0.jpg'  width="200" height="200">

输入n 代表几个圆。

输入圆的半径

输出：蓝色的面积

题目给的输入为：

```
5
1 2 3 4 5
```
输出：
```
47.12388
```

<!--more-->

用了二十分钟（吐槽下，有点长）把程序敲出来了。可是AC通过率只有18% ？？？

然后稀里糊涂的开始改代码，也不知道怎么变成27%。

笔试结束后，看大家发帖，蒙了。

1. 用π=3.1415926535 不够精确。

2. 第二个输入需要排序。 ？？？what  那你用例不要给1 2 3 4 5 了吧

   有人统计 π精确后通过率45%

   排序后 100%

   还是太年少。。。。。。。 
