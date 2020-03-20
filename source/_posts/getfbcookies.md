---
title: Python获取facebook cookies 模拟登录
date: 2020-03-19 12:13:07
tags:
 - Python
 - Selenium
---

受网友委托，帮忙协助开发定时爬取脸书、推特、reddit的相关关键词搜索信息（我猜是舆论监控系统，逃），要求，定时检索，并邮箱发送检索到的新的信息。本来以为是一件很简单的事情，以为直接截取发过来的json数据即可，当打开Facebook网站后发现，发现没那么简单。

问题如下：

- 脸书反馈回来的是加密的数据块，说是chunk技术。
- 必须登录才能搜索
- 页面不断下滑才能加载搜索结果
- 并不能自定义搜索排序，即判断最新的数据变得困难。

既然如此，就不能用相关的request请求直接获取，想了想通过Selenium进行手动模拟，手动模拟必须登录，本问主要介绍注入cookies登录脸书功能。

<!--more-->

首先我们需要获取cookies，相关代码如下：

```python
def get_cookies():
    print("="*50)
    print("Geting Cookies!")
    print("="*50)
    browser = webdriver.Chrome(executable_path = optionPath)
    # browser.implicitly_wait(10)
    # browser.set_window_size(0,0)
    browser.get('https://www.facebook.com/')
    browser.find_element_by_id('email').clear()
    browser.find_element_by_id('email').send_keys(config.fb_account_number)
    browser.find_element_by_id('pass').clear()
    browser.find_element_by_id('pass').send_keys(config.fb_password)
    time.sleep(2)
    browser.find_element_by_xpath('//*[@id="u_0_b"]').click()
    browser.get('https://www.facebook.com/')
    # 获取cookie并通过json模块将dict转化成str
    dictCookies = browser.get_cookies()
    jsonCookies = json.dumps(dictCookies)
    # 登录完成后，将cookie保存到本地文件
    with open('cookies.json', 'w') as f:
        f.write(jsonCookies)
```

Facebook的cookies有30天时间期限，所以只需要写个定时任务，每半个月运行一次获取cookies就可以。

下一步 cookies添加进浏览器，进行登录。这里有个坑，因为注入cookies的时候，必须有这个网站的访问记录，而往往Selenium自动控制浏览器是一个全新的浏览器，要求我们在注入前必须先访问一下需要注入的网站，相关代码如下。

```python
def get_fb_cracker_browser():
    browser = webdriver.Chrome(executable_path=optionPath)
    # browser.implicitly_wait(10)
    # browser.set_window_size(0,0)
    # 读取登录时存储到本地的cookie
    with open('cookies.json', 'r', encoding='utf-8') as f:
        cookies_list = json.loads(f.read())

    print("="*50)
    print('正在加载cookies...')
    browser.get('https://www.facebook.com/')
    for cookie in cookies_list:
        if 'expiry' in cookie:
            del cookie['expiry']
        browser.add_cookie(cookie)
    print('加载完成，启动中...')
    print("="*50)
    return browser
```

此时的浏览器可以正常登录网站并获取相关信息了。

其他问题注：

1.当然如果你想用postman测试，此时获取的cookies是不能直接使用的，需要进行相关转化，代码如下。

```python
#Postman调试用
cookies = ''
for i in browser.get_cookies():
    cookies_name = i['name']
    cookies_value = i['value']
    cookies += (str(cookies_name) + '=' + str(cookies_value) + ';')
print('已获取到cookies', cookies)
with open("cookies_postman.txt", "w") as fp:
    fp.write(cookies)
browser.close()
```

2.必须进行不断滑动页面获取信息，可以通过js注入，不断滑动。

```python
js = 'var q=document.documentElement.scrollTop=80000'
browser.execute_script(js)
print("#",end='')
time.sleep(1)
```

3.获取内容唯一辨识

因为要求只记录最新的，这就要求相关信息要有唯一辨识性，查看页面可以看到post有个id唯一，通过记录ID即可解决。