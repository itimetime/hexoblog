---
title: 优化Hexo博客的响应速度
date: 2020-03-10 19:21:53
tags: 
- Hexo
- Html
---

#### 写在前面

博客搭建了好几天，但是访问的时候，就会发现网页加载很慢，打开半分钟网页部分`js`文件还没有下载下来。电脑Chrome <kbd>F12</kbd>查看文件加载，很多文件加载特别慢<!--more-->，查看效果如这种：

{% asset_img 20200310203705957.png This is an example image %}

这是已经优化完成的，图中的`busuanzi`加载时间依然很长，服务商的问题，统计网站访问量的。准备过一段时间关闭。

#### next7发现的问题汇总

- `Valine.min.js `请求地址经历了两次重定向，且下载速度较慢。
- `av-min.js` 出现请求重定向
- `busuanzi.pure.mini.js` 下载速度慢

#### 解决方法

总的原则是把一些访问慢，下载速度慢的`js`文件放到服务器本地，把含有重定向的请求连接修改为最新的请求连接，减少请求速度。

1. 下载网页，把`Valine.min.js`、`busuanzi.pure.mini.js `放到`next\source\js`文件夹

2. 修改next主题`layout\_third-party\comments`文件下的`valine.swig` ，第一行替换为

   ```js
   {{- next_js('Valine.min.js') }}
   ```

3. 修改next主题`layout\_third-party\statistics`文件下的`busuanzi-counter.swig`，第三行替换为

   ```js
     {{- next_js('busuanzi.pure.mini.js')}}
   ```

4. 全局搜索`av-min.js` 请求地址，把请求地址更新为最新的地址。



之后访问速度变快，大功告成！