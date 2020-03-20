---
title: Git基本操作
date: 2020-03-15 21:44:22
tags:
 - Git
---

git是一款强大的分布式版本控制系统。这个博客网站也是用的Git进行部署，同时在githup上进行的备份，下面是相关连接Git的基本操作。

1.先配钥匙（钥匙的作用是把你电脑上面的git和github连接）

```bash
ssh-keygen -t rsa -C "your_email@youremail.com" //双引号里面是你的邮箱
```

配钥匙的过程中不管你看到什么一路enter就好。然后你会在C:\Users\Administrator\\.ssh目录下面看到三个东西，其中一个是.pub格式的，用记事本打开它，复制。然后来到你的github，在setting里面找到ssh keys把你刚才复制的钥匙给粘贴了，title随便写一个。

<!--more-->

2.验证是否成功，在git bash里输入下面的命令

```bash
ssh -T git@github.com
```

​       如果初次设置的话，会出现如下界面，输入yes 同意即可

​      {% asset_img git-check.png This is an example image %}   

3.建仓库

```bash
git init
```

打完这个命令行敲回车，你会发现你的这个文件夹下面多了一个.git文件夹，没有的在查看里面把隐藏的文件给显示出来就好了。

4.设置用户名和邮箱。

```bash
git config --global user.name "your name"
git config --global user.email "your_email@youremail.com"
```

5.添加远程地址

```bash
git remote add origin git@github.com/你的github用户名/仓库名.git
```

6.add和commit

```bash
git add read.txt
git commit -m "The commit reason"push推送到你的github
```

7.首次推送需要加上 `-u` 之后不需要添加， `-f`为强制提交

```bash
git push -u origin master  
```

```bash
git push origin master 
```

8.其他操作

`git status ` : 追踪文件的变更

`git log`: 查看文件的变更

`git diff0`: 执行 git diff 来查看执行 git status 的结果的详细信息。

- 尚未缓存的改动：`git diff`
- 查看已缓存的改动： `git diff --cached`
- 查看已缓存的与未缓存的所有改动：`git diff HEAD`
- 显示摘要而非整个 diff：`git diff --stat`
`git reset --hard  b498237e6dc1fc4861c79d3314d07285995b`:版本回退

