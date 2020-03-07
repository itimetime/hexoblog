---
title: Hexo部署到腾讯云服务器
date: 2020-03-07 22:34:31
tags: 
- 腾讯云
- Linux
- Hexo
---

**本文主要介绍腾讯云服务器如何部署Hexo博客，包括Git，Nginx的一些安装配置教程。**

## 云服务器的准备

### 服务器介绍

淘宝买的服务机，性价比比较高，虽然自己也是学生，可以买学生机，但是腾讯云规定学生如果购买服务器，停止费续费不能以学生价格继续付费，不想浪费机会，就先淘宝购买试水。其配置如下：

|    操作系统     | CPU  | 内存 | 带宽  |
| :-------------: | :--: | :--: | :---: |
| CentOS 7.5 64位 | 1核  | 2GB  | 1Mbps |

### Git安装：

Linux安装Git相对简单，自己是CentOS系统，登录腾讯云终端直接`yum install git`，稍等片刻直接输入`y`即可安装，其他Linux版本见[Git下载页](https://git-scm.com/download/linux)，安装过程中自动配置好环境变量，无需手动配置。

<!--more-->

#### 检测

输入 `git --version`，出现相应的git版本即安装成功。

#### 创建Git仓库

在 `home/git` 的目录下，创建一个名为`hexoBlog`的裸仓库（bare repo）。如果没有 `home/git` 目录，需要先创建；然后修改目录的所有权和用户权限。

```bash
mkdir /home/git/
chown -R $USER:$USER /home/git/
chmod -R 755 /home/git/
```

切换到所创建的文件下，并初始化仓库，命令如下：

```bash
cd /home/git/
git init --bare hexoBlog.git
```

#### 创建钩子自动部署

* 在 `/home/git/hexoBlog.git` 下，有一个自动生成的 `hooks` 文件夹。我们需要在里边新建一个新的钩子文件 `post-receive`

  ```vim /home/git/hexoBlog.git/hooks/post-receive
  vim /home/git/hexoBlog.git/hooks/post-receive
  ```
  
* 按 `i` 键进入文件的编辑模式，在该文件中添加两行代码（将下边的代码粘贴进去)，指定 Git 的工作树（源代码）和 Git 目录（配置文件等）。

  ```bash
  #!/bin/bash
  git --work-tree=/home/hexoBlog --git-dir=/home/git/hexoBlog.git checkout -f
  ```

  然后，按 `Esc` 键退出编辑模式，输入`:wq` 保存退出。
  
* 修改文件权限，使得其可执行。

  ```bash
  chmod +x /home/git/hexoBlog.git/hooks/post-receive
  ```

### Nginx安装及配置

#### Nginx安装

安装 Nginx

```bash
yum install -y nginx
```

启动 Nginx

```bash
service nginx start
```

测试 Nginx 服务器

```bash
wget http://127.0.0.1
```

能够正常获取以下欢迎页面说明Nginx安装成功。

```bash
Connecting to 127.0.0.1:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 4833 (4.7K) [text/html]
Saving to: ‘index.html’
100%[=================================================================================================================================>] 4,833       --.-K/s   in 0s  
2020-03-07 23:44:22 (556 MB/s) - ‘index.html’ saved [4833/4833]
```

测试网页是否能打开在浏览器中输入服务器 IP 地址，就是服务器的公网 IP。

#### 配置 Nginx 托管文件目录

创建 `/home/hexoBlog`目录，用于 Nginx 托管。

   ```bash
mkdir /home/hexoBlog/
chown -R $USER:$USER /home/hexoBlog/
chmod -R 755 /home/hexoBlog/
   ```

查看 Nginx 的默认配置的安装位置

   ```bash
nginx -t
   ```

修改Nginx的默认配置，其中 cd 后边就是刚才查到的安装位置（每个人可能都不一样）   

   ```bash
vim /etc/nginx/nginx.conf
   ```

按方向键，找到如下位置

   ```bash
server {
       listen 80 default_server;
       listen [::]:80 default_server;
       root /home/hexoBlog;    #需要修改
       
       server_name www.itimetime.cn; #需要修改
       
       # Load configuration files for the default server block.
       include /etc/nginx/default.d/*.conf;
       location / {
       }
       error_page 404 /404.html;
           location = /40x.html {
       }
   ```

   按`i`键进入插入模式，将其中的 root 值改为 `/home/hexoBlog` （刚才创建的托管仓库目录）。
 将 server_name 值改成你的域名。

重启 Nginx 服务   

   ```bash
service nginx restart
   ```

至此，服务器端配置就结束了。接下来，就剩下本地 Hexo 的配置更改了。

## Hexo本地配置

打开你本地的 Hexo 博客所在目录下的站点配置文件`_config.yml`（不是主题配置文件），做以下修改。

```bash
deploy:
    type: git
    repo: root@CVM 你的云服务器的IP地址:/home/git/hexoBlog
    branch: master
```

在 Hexo 目录下执行部署，试试看。

```bash
cd 你的 hexo 目录
npm install --save hexo-deployer-git
hexo clean
hexo generate
hexo deploy
```

打开你的公网 IP，看是不是已经部署成功了。

