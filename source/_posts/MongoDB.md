---

title: MongoDB初步探索
date: 2020-03-22 20:50:45
tags: 
 - MongoDB
 - Python
---

#### 前言

以前一直用的是MySQL数据库，最近有幸接触到MongoDB数据库，在我的眼里，MySQL就是类似与Excel表格的储存形式，MongoDB竟然储存的json数据，不得不惊叹设计的巧妙。数据库的增删改查都差不多，学习了一上午，略有上手，下面是一些心得和一道MongoDB操作题。

<!--more-->

#### MongDB简介

MongoDB 是一个基于分布式文件存储的数据库。由 C++ 语言编写。旨在为 WEB 应用提供可扩展的高性能数据存储解决方案。

MongoDB 是一个介于关系数据库和非关系数据库之间的产品，是非关系数据库当中功能最丰富，最像关系数据库的。

##### 基本操作语法

###### 1.创建数据库

`use DATABASE_NAME`,数据库不存在，则创建数据库。

###### 2.删除数据库

`drop DATABASE_NAME`

###### 3.创建集合 

`db.createCollection(name, options)`往集合插入数据的时候，集合不存在，会自动创建。

###### 4.删除集合

`db.collection.drop()`

###### 5.显示所有数据库、所有集合

`show dbs`

`show collections`

###### 6.插入文档

`db.COLLECTION_NAME.insert(document)`

###### 7.更新文档

```
db.collection.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)
```

**参数说明：**

- **query** : update的查询条件，类似sql update查询内where后面的。
- **update** : update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的
- **upsert** : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
- **multi** : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
- **writeConcern** :可选，抛出异常的级别。

###### 8.删除文档

```
db.collection.remove(
   <query>,
   <justOne>
)
```

- **query** :（可选）删除的文档的条件。
- **justOne** : （可选）如果设为 true 或 1，则只删除一个文档，如果不设置该参数，或使用默认值 false，则删除所有匹配条件的文档。
- **writeConcern** :（可选）抛出异常的级别。

###### 9.查询文档

```
db.collection.find(query, projection)
```

- **query** ：可选，使用查询操作符指定查询条件

- **projection** ：可选，使用投影操作符指定返回的键。查询时返回文档中所有键值， 只需省略该参数即可（默认省略）。

- 如果需要以易读的方式来读取数据，可以使用 pretty() 方法，语法格式如下：

  ```
  >db.col.find().pretty()
  ```

  pretty() 方法以格式化的方式来显示所有文档。

###### 10.条件查询

**MongoDB (>) 大于操作符 - $gt**

如果你想获取 "col" 集合中 "likes" 大于 100 的数据，你可以使用以下命令：

```
db.col.find({likes : {$gt : 100}})
```

类似于SQL语句：

```
Select * from col where likes > 100;
```

**MongoDB（>=）大于等于操作符 - $gte**

如果你想获取"col"集合中 "likes" 大于等于 100 的数据，你可以使用以下命令：

```
db.col.find({likes : {$gte : 100}})
```

类似于SQL语句：

```
Select * from col where likes >=100;
```

**MongoDB (<) 小于操作符 - $lt**

如果你想获取"col"集合中 "likes" 小于 150 的数据，你可以使用以下命令：

```
db.col.find({likes : {$lt : 150}})
```

类似于SQL语句：

```
Select * from col where likes < 150;
```

**MongoDB (<=) 小于等于操作符 - $lte**

如果你想获取"col"集合中 "likes" 小于等于 150 的数据，你可以使用以下命令：

```
db.col.find({likes : {$lte : 150}})
```

类似于SQL语句：

```
Select * from col where likes <= 150;
```

**MongoDB 使用 (<) 和 (>) 查询 - $lt 和 $gt**

如果你想获取"col"集合中 "likes" 大于100，小于 200 的数据，你可以使用以下命令：

```
db.col.find({likes : {$lt :200, $gt : 100}})
```

类似于SQL语句：

```Select * from col where likes>100 AND  likes<200;

```

**模糊查询**

查询 title 包含"教"字的文档：

```
db.col.find({title:/教/})
```

查询 title 字段以"教"字开头的文档：

```
db.col.find({title:/^教/})
```

查询 titl e字段以"教"字结尾的文档：

```
db.col.find({title:/教$/})
```

###### 11. Limit与Skip方法

imit()方法基本语法如下所示：

```
>db.COLLECTION_NAME.find().limit(NUMBER)
```

skip() 方法脚本语法格式如下：

```
>db.COLLECTION_NAME.find().limit(NUMBER).skip(NUMBER)
```

**注:**skip()方法默认参数为 0 。

###### 12.排序

sort()方法基本语法如下所示：

```
>db.COLLECTION_NAME.find().sort({KEY:1})
```

降序需要把1 改成 -1

###### 13.聚合

MongoDB中聚合(aggregate)主要用于处理数据(诸如统计平均值,求和等)，并返回计算后的数据结果。有点类似sql语句中的 count(*)。

------

aggregate() 方法

MongoDB中聚合的方法使用aggregate()

aggregate() 方法的基本语法格式如下所示：

```
>db.COLLECTION_NAME.aggregate(AGGREGATE_OPERATION)
```

实例集合中的数据如下：

```
{
   _id: ObjectId(7df78ad8902c)
   title: 'MongoDB Overview', 
   description: 'MongoDB is no sql database',
   by_user: 'runoob.com',
   url: 'http://www.runoob.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 100
},
{
   _id: ObjectId(7df78ad8902d)
   title: 'NoSQL Overview', 
   description: 'No sql database is very fast',
   by_user: 'runoob.com',
   url: 'http://www.runoob.com',
   tags: ['mongodb', 'database', 'NoSQL'],
   likes: 10
},
{
   _id: ObjectId(7df78ad8902e)
   title: 'Neo4j Overview', 
   description: 'Neo4j is no sql database',
   by_user: 'Neo4j',
   url: 'http://www.neo4j.com',
   tags: ['neo4j', 'database', 'NoSQL'],
   likes: 750
},
```

现在我们通过以上集合计算每个作者所写的文章数，使用aggregate()计算结果如下：

```
> db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
{
   "result" : [
      {
         "_id" : "runoob.com",
         "num_tutorial" : 2
      },
      {
         "_id" : "Neo4j",
         "num_tutorial" : 1
      }
   ],
   "ok" : 1
}
>
```

以上实例类似sql语句：

```
 select by_user, count(*) from mycol group by by_user
```

#### Python操作数据MongoDB数据库

连接mongodb

```
#!/usr/bin/env python
# -*- coding:utf-8 -*-

from pymongo import MongoClient

conn = MongoClient('192.168.0.113', 27017)
db = conn.mydb  #连接mydb数据库，没有则自动创建
my_set = db.test_set　　#使用test_set集合，没有则自动创建
```

插入数据（insert插入一个列表多条数据不用遍历，效率高， save需要遍历列表，一个个插入）

```
my_set.insert({"name":"zhangsan","age":18})
#或
my_set.save({"name":"zhangsan","age":18})
```

插入多条

```
#添加多条数据到集合中
users=[{"name":"zhangsan","age":18},{"name":"lisi","age":20}]  
my_set.insert(users) 
#或
my_set.save(users)  
```

查询数据（查询不到则返回None）

```
#查询全部
for i in my_set.find():
    print(i)
#查询name=zhangsan的
for i in my_set.find({"name":"zhangsan"}):
    print(i)
print(my_set.find_one({"name":"zhangsan"}))
```

更新数据

```
my_set.update(
   <query>,    #查询条件
   <update>,    #update的对象和一些更新的操作符
   {
     upsert: <boolean>,    #如果不存在update的记录，是否插入
     multi: <boolean>,        #可选，mongodb 默认是false,只更新找到的第一条记录
     writeConcern: <document>    #可选，抛出异常的级别。
   }
)
```

　　把上面插入的数据内的age改为20

```
my_set.update({"name":"zhangsan"},{'$set':{"age":20}})
```

删除数据

```
my_set.remove(
   <query>,    #（可选）删除的文档的条件
   {
     justOne: <boolean>,    #（可选）如果设为 true 或 1，则只删除一个文档
     writeConcern: <document>    #（可选）抛出异常的级别
   }
)
```

```
#删除name=lisi的全部记录
my_set.remove({'name': 'zhangsan'})

#删除name=lisi的某个id的记录
id = my_set.find_one({"name":"zhangsan"})["_id"]
my_set.remove(id)

#删除集合里的所有记录
db.users.remove()　
```

mongodb的条件操作符

```
#    (>)  大于 - $gt
#    (<)  小于 - $lt
#    (>=)  大于等于 - $gte
#    (<= )  小于等于 - $lte
#例：查询集合中age大于25的所有记录
for i in my_set.find({"age":{"$gt":25}}):
    print(i)
```

type(判断类型)

```
#找出name的类型是String的
for i in my_set.find({'name':{'$type':2}}):
    print(i)
```

类型队对照列表

排序

　　在MongoDB中使用sort()方法对数据进行排序，sort()方法可以通过参数指定排序的字段，并使用 1 和 -1 来指定排序的方式，其中 1 为升序，-1为降序。

```
for i in my_set.find().sort([("age",1)]):
    print(i)
```

limit和skip

```
#limit()方法用来读取指定数量的数据
#skip()方法用来跳过指定数量的数据
#下面表示跳过两条数据后读取6条
for i in my_set.find().skip(2).limit(6):
    print(i)
```

IN

```
#找出age是20、30、35的数据
for i in my_set.find({"age":{"$in":(20,30,35)}}):
    print(i)
```

OR

```
#找出age是20或35的记录
for i in my_set.find({"$or":[{"age":20},{"age":35}]}):
    print(i)
```

all

```
'''
dic = {"name":"lisi","age":18,"li":[1,2,3]}
dic2 = {"name":"zhangsan","age":18,"li":[1,2,3,4,5,6]}

my_set.insert(dic)
my_set.insert(dic2)'''
for i in my_set.find({'li':{'$all':[1,2,3,4]}}):
    print(i)
#查看是否包含全部条件
#输出：{'_id': ObjectId('58c503b94fc9d44624f7b108'), 'name': 'zhangsan', 'age': 18, 'li': [1, 2, 3, 4, 5, 6]}
```

push/pushAll

```
my_set.update({'name':"lisi"}, {'$push':{'li':4}})
for i in my_set.find({'name':"lisi"}):
    print(i)
#输出：{'li': [1, 2, 3, 4], '_id': ObjectId('58c50d784fc9d44ad8f2e803'), 'age': 18, 'name': 'lisi'}

my_set.update({'name':"lisi"}, {'$pushAll':{'li':[4,5]}})
for i in my_set.find({'name':"lisi"}):
    print(i)
#输出：{'li': [1, 2, 3, 4, 4, 5], 'name': 'lisi', 'age': 18, '_id': ObjectId('58c50d784fc9d44ad8f2e803')}
```

pop/pull/pullAll

```
#pop
#移除最后一个元素(-1为移除第一个)
my_set.update({'name':"lisi"}, {'$pop':{'li':1}})
for i in my_set.find({'name':"lisi"}):
    print(i)
#输出：{'_id': ObjectId('58c50d784fc9d44ad8f2e803'), 'age': 18, 'name': 'lisi', 'li': [1, 2, 3, 4, 4]}

#pull （按值移除）
#移除3
my_set.update({'name':"lisi"}, {'$pop':{'li':3}})

#pullAll （移除全部符合条件的）
my_set.update({'name':"lisi"}, {'$pullAll':{'li':[1,2,3]}})
for i in my_set.find({'name':"lisi"}):
    print(i)
#输出：{'name': 'lisi', '_id': ObjectId('58c50d784fc9d44ad8f2e803'), 'li': [4, 4], 'age': 18}
```

多级路径元素操作

　　先插入一条数据

```
dic = {"name":"zhangsan",
       "age":18,
       "contact" : {
           "email" : "1234567@qq.com",
           "iphone" : "11223344"}
       }
my_set.insert(dic)
```

```
#多级目录用. 连接
for i in my_set.find({"contact.iphone":"11223344"}):
    print(i)
#输出：{'name': 'zhangsan', '_id': ObjectId('58c4f99c4fc9d42e0022c3b6'), 'age': 18, 'contact': {'email': '1234567@qq.com', 'iphone': '11223344'}}

result = my_set.find_one({"contact.iphone":"11223344"})
print(result["contact"]["email"])
#输出：1234567@qq.com

#多级路径下修改操作
result = my_set.update({"contact.iphone":"11223344"},{"$set":{"contact.email":"9999999@qq.com"}})
result1 = my_set.find_one({"contact.iphone":"11223344"})
print(result1["contact"]["email"])
#输出：9999999@qq.com
```

 还可以对数组用索引操作

```
dic = {"name":"lisi",
       "age":18,
       "contact" : [
           {
           "email" : "111111@qq.com",
           "iphone" : "111"},
           {
           "email" : "222222@qq.com",
           "iphone" : "222"}
       ]}
my_set.insert(dic)
```

```
#查询
result1 = my_set.find_one({"contact.1.iphone":"222"})
print(result1)
#输出：{'age': 18, '_id': ObjectId('58c4ff574fc9d43844423db2'), 'name': 'lisi', 'contact': [{'iphone': '111', 'email': '111111@qq.com'}, {'iphone': '222', 'email': '222222@qq.com'}]}

#修改
result = my_set.update({"contact.1.iphone":"222"},{"$set":{"contact.1.email":"222222@qq.com"}})
print(result1["contact"][1]["email"])
#输出：222222@qq.com
```

####  MongoDB编程操作题

Set up a MongoDB inside a docker. Then write a script that has a counter that goes up every 0.5s in increments of 3 (0, 3, 6, 9, 12) and prints the value to the terminal. The script has to store the current value into the MongoDB per session. After closing the program and reopening it, the system has to continue at the number it was stopped at. The Database shall have 1 entry for every session, stating the first and last number of its session.

个人觉得以下两个是关键：

1. 是要查询到最新的数据，确定起始数字。
2. 起始时的处理逻辑

刚开始解决想直接存储个时间戳，查询相关资料后发现MongoDB的ID的前四位本身就是时间戳，那么问题更容易解决了。其实时候的处理逻辑，需要判断表是否为空，为空起始数字为0，不为空取最后插入的数字即可。

相关代码如下，Python编写。

```python
import time

from pymongo import MongoClient

conn = MongoClient('127.0.0.1', 27017)
db = conn.mydb  #连接mydb数据库，没有则自动创建
myset = db.site #使用site集合，没有则自动创建
if myset.count_documents({}) == 0:
    start_number = 0
else:
    find = myset.find({}).sort('_id', -1).limit(1)
    start_number = find[0]['end_number']
end_number = start_number
myset.insert_one({'start_number':start_number, 'end_number':end_number})
while True:
    time.sleep(0.5)
    print(end_number)
    end_number += 3
    myset.update_one({'start_number':start_number},{'$set':{'end_number':end_number}})
```