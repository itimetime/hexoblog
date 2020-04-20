---
title: Python re模块正则匹配
date: 2020-04-04 20:08:05
tags: Python
categories: Python
---

相关基础，更多可查看Python lib包中的re模块。

```
[abc]  一个中括号只能表示一个字符位置 只能匹配a ， 或者 b \ c

[a-z] [0-9] [A-Z] [A-z]   根据Ascii进行匹配
[a-zA-Z]
[0-9a-z]
[0-9a-zA-Z] 范围可以写多个
```
<!--more-->
```
[0-9]        --> \d 匹配一位数字  digit
[0-9a-zA-Z]  --> \w 匹配所有的数字 字母 下划线 word
空格 -->
tab --> \t
enter --> \n
空白（\tab \enter \space） -->  ( |\t|\n) --> \s 匹配任意空格

\W 非数字字母下划线
\D 非数字
\S 非空白

[\d\D] -->匹配数字和非数字 所有 [\w\W] [\s\S]
. 匹配非换行符的所有

[^\d] --> 匹配所有的非数字

[^1] -->匹配所有的非数字

^ -->匹配开始
$ --> 匹配结束

a|b 匹配a或者b中的内容
() 分组   \. 取消特殊意义  www\.(oldby|baidu|jd|taobao)\.com

两次

{n} 匹配n次
{n，} 至少n次

？ 匹配0次或一次
+ 表示1次或多次
* 表示0次或多次

判断用户输入的内容是否合法，如果用户输入的对就能查到结果，如果输入的部队就不能查到结果

^1[3-9]\d{9}

从一个大文件中找到所有符合规则的内容

1{3-9}\d{9}

贪婪匹配 尽可能多的匹配 \d{3,}6
惰性匹配  至匹配一次  \d{3,}?6 非贪婪
```

可简单总结为：

```
# 基础：
# . 任意字符
# [] 范围
# | 或者
# () 一组
#
# 量词：
# * >= 0
# + >= 1
# ? 0,1
# {m} = m
# {m,} >= m
# {m, n} >= m <=n
```

举例：判断邮箱是否合法

```python
import re

email = input("please enter the email: ").strip()
result = re.search("^[0-9A-z]+?@[0-9A-z]+\.com$",email)
if result:
    print("successed!")
else:
    print("faild")
```

判断手机号是否合法

```python
import re

number = input("please enter the mobliephone number: ").strip()
result = re.search("^1[3-9]\d{9}$",number)
if result:
    print("successed!")
else:
    print("faild")
```

判断区号，座机号

```python
import re

str1 = "fdfd021-54377032,0530-86080803"

tel = re.findall("(\d{3,4})-(\d{8})",str1)
for i in tel:
    print(f"区号：{i[0]}, 座机号：{i[1]}")
```

备注：re中有 findall() 、search() 、match()、sub()、subn()

分别代表匹配所有、查找一个、从首部匹配、替换。

sub()和subn()对比

```python
#re.sub()  替换
ret = re.sub("\d","H","alefdfdff889")
ret2 = re.sub("\d","H","alefdfdff889",1)
print(ret)
print(ret2)


#re.subn()  替换
ret = re.subn("\d","H","alefdfdff889")
ret2 = re.subn("\d","H","alefdfdff889",1)
print(ret)
print(ret2)
```

结果

```
alefdfdffHHH
alefdfdffH89
('alefdfdffHHH', 3)
('alefdfdffH89', 1)
```

