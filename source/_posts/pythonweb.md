---
title: Python Scoket 搭建简易web 服务器
date: 2020-03-21 22:00:57
tags:
 - Python
---

也是面试的一个题目，题目真的好，学会了不少东西，原来Web服务器是这样玩的。

题：搭建web服务器，`GET`方法返回Yes，`Post`方法返回json数据。

同时搭建个客户端，往服务器传递图片信息，图片需转化为64位字符串。当然POST请求的json数据也应该返回图片的`json`信息。

<!--more-->

由于`Scoket`编程，不怎么熟悉，鼓捣了好长的时间。相关代码如下：

##### 服务端

```python
import socket
import json

def get_headers(data):
    """
    将请求头格式化成字典
    :param data:
    :return:
    """
    header_dict = {}
    data = str(data, encoding='utf-8')

    header, body = data.split('\r\n\r\n', 1)
    header_list = header.split('\r\n')
    for i in range(0, len(header_list)):
        if i == 0:
            if len(header_list[i].split(' ')) == 3:
                header_dict['method'], header_dict['url'], header_dict['protocol'] = header_list[i].split(' ')
        else:
            k, v = header_list[i].split(':', 1)
            header_dict[k] = v.strip()
    print(header_dict)
    return header_dict



def web_server():
    json_answer = {'name': 'string', 'img': 'b64image', 'dict': {'a': 0, 'b': 1}}
    text_content = '''HTTP/1.x 200 OK 
    Content-Type: text/html

    Yes
    '''
    HOST = '127.0.0.1'
    PORT = 8000
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((HOST, PORT))
    sock.listen(100)
    # infinite loop
    while True:
        # maximum number of requests waiting
        conn, addr = sock.accept()
        request = conn.recv(1024)
        method = str(request)[2:].split(' ')[0]
        # deal wiht GET method
        data = get_headers(request)
        if data['method'] == 'GET':
            print("GET")
            content = text_content.encode()
        elif data['method'] == 'POST':
            data = data['url'][2:].split('&')
            # json_data = {}
            for item in data:
                # json_data[item.split('=')[0]] = item.split('=')[1]
                if item.split('=')[0] == 'name':
                    json_answer['name'] == item.split('=')[1]


            content = ("HTTP/1.1 200 OK\r\nContent-type: text/html\r\n\r\n" + json.dumps(json_answer)).encode('utf-8')
        else:
            continue
        conn.sendall(content)
        conn.close()
```

##### 客户端

客户端实在不想用`Scoket`写了，用python的`request`库也就几句话的事。就仅列出相关的转化图片代码吧。

```python
import base64

with open('image.jpg', 'rb') as f:
    image = f.read()
    image_base64 = str(base64.b64encode(image), encoding='utf-8')

```

