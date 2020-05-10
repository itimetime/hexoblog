---
title: Go的性能基准测试和性能调优
date: 2020-04-24 01:12:30
tags: Go语言
categories: Go语言
---

每一门编程语言，都有它的优势，每一门编程语言，都有它的设计哲学。因为觉得自己技术栈实在太窄，便开始学习新的语言。随尝试学习Go、Java，很是受用，自己也会不由自主的比较他们方法实现的异同，尽可能的多吸收一点各门语言的设计精华。

<!--more-->

再来说说最近的感悟吧，我的学习路线是 Python--> Go-->Java。现在回首过来，有那么一点不合理。选Python的时候，几行代码就实现了一个功能，感觉真好用（但那时已经在给自己挖坑了，Python相对来说学习者不用太关注底层的实现，是名副其实的“面向对象”，后面还要补习底层知识）。之后接触了Go，Go语言相对来说严格的控制内存，关注性能，但因为用的人数还是较少，优质教程还是比较少，但是已经慢慢接触内存之类的了。然后学习了Java，开始关注程序的运行过程，就开始接触堆内存和栈内存...，Java有完整的学习路线，对SQL优化、高并发处理等有比较成熟解决方案，在学习的过程中会让你明白底层的运行原理。以前觉得`System.out.println("")`又臭又长，现在觉得真香。

反正，自己从学"计算机“专业毕业的人，正在努力去达到计算机科班应有的专业素养，感恩遇到的事情，未来我会加油。

好了，说了那么多，开始进入文章主题，首先新建了一个`split.go`文件，实现了Go中split方法相同的功能，根据所给字符串分割相应的字符。代码如下：

```go
package split

import (
   "strings"
)

//切割字符串

func Split(str string,sep string) ([]string ){
   ret := make([]string,0) // 需要注意的地方，后面需要优化
   if sep == ""{
      for i := 0; i < len(str);i++{
         ret = append(ret, str[i:i+1])
      }
      return ret
   }
   for{
      index := strings.Index(str,sep)
      if index == -1{
         ret = append(ret, str)
         return ret
      }else {
         ret = append(ret,str[:index])
         str = str[index+len(sep):]
      }
   }

}
```

然后在同目录下新建了一个`split_test.go`文件进行测试。代码如下：

```go
package split

import (
   "reflect"
)

func BenchmarkSplit(b *testing.B) {
	for i :=0; i<b.N;i++{
		Split("a:b:c:f:f",":")
	}
}
```

在`cmd`终端输入，```test -bench=Split -benchmem```（可以添加 `-cpu 核心数`，指定几个cpu运行 ）,函数的性能测试结果如下：

```
goos: windows
goarch: amd64
pkg: golearnProject/day09/03test/split
BenchmarkSplit-4         2084618               534 ns/op             240 B/op          4 allocs/op
PASS
ok      golearnProject/day09/03test/split       1.991s
```

通过`BenchmarkSplit`这一行可以看出，运行的核心数、某个单位时间内函数运行的次数，函数单次运行的平均时间开销、内存开销及申请内存次数。结果显示内存申请了四次（**4 allocs/op**），让我们回到代码，发现每次append方法使用，就会进行一次内存的动态申请。换个思路我直接把内存一次申请够,把Split函数申请内存方式进行修改，修改后的代码如下：

```go
package split

import (
   "strings"
)

//切割字符串

func Split(str string,sep string) ([]string ){
   ret := make([]string,0,len(str)) //此部分进行了修改
   if sep == ""{
      for i := 0; i < len(str);i++{
         ret = append(ret, str[i:i+1])
      }
      return ret
   }
   for{
      index := strings.Index(str,sep)
      if index == -1{
         ret = append(ret, str)
         return ret
      }else {
         ret = append(ret,str[:index])
         str = str[index+len(sep):]
      }
   }

}
```

再对其进行测试，测试结果如下

```
goos: windows
goarch: amd64
pkg: golearnProject/day09/03test/split
BenchmarkSplit-4         3848565               317 ns/op             144 B/op          1 allocs/op
PASS
ok      golearnProject/day09/03test/split       1.889s
```

内存申请变为一次（**1 allocs/op**），单位时间内，**函数的运行次数接近之前的二倍（3848565）**。所以在程序运行过程中尽量不要去动态申请内存，这些都是编程中注意的地方，除此之外应该有很多编程技巧，养成良好的编程习惯是非常有必要的。

再通过斐波那契数列进行一次测试。 相关代码如下：

```go
// fib.go
package f

// Fib 是一个计算第n个斐波那契数的函数
func Fib1(n int) int {
   if n < 2 {
      return n
   }
   return Fib(n-1) + Fib(n-2)
}

func Fib2(n int) int {
   if n < 2{
      return n
   }
   n1 := 0
   n2 := 1
   var tmp int
   for ; n>=2;n--{
      tmp = n2
      n2 = n1 + n2
      n1 = tmp
   }
   return n2
}
```

Fib1()是利用递归算法, Fib2()是利用动态规划。

测试代码如下：

```go
package f

import "testing"

// fib_test.go

func benchmarkFib(b *testing.B, n int) {
   for i := 0; i < b.N; i++ {
      Fib1(n)   //修改为Fib2，将对Fib2进行测试。
   }
}

func BenchmarkFib1(b *testing.B)  { benchmarkFib(b, 1) }
func BenchmarkFib2(b *testing.B)  { benchmarkFib(b, 2) }
func BenchmarkFib3(b *testing.B)  { benchmarkFib(b, 3) }
func BenchmarkFib10(b *testing.B) { benchmarkFib(b, 10) }
func BenchmarkFib20(b *testing.B) { benchmarkFib(b, 20) }
func BenchmarkFib40(b *testing.B) { benchmarkFib(b, 40) }
```

命令行运行：`go test -bench=Fib.`,结果如下：

Fib1(递归):

```
goos: windows
goarch: amd64
pkg: golearnProject/day09/04benchmark
BenchmarkFib1-4         309472328                3.86 ns/op
BenchmarkFib2-4         100000000               10.2 ns/op
BenchmarkFib3-4         75043618                17.4 ns/op
BenchmarkFib10-4         2056074               587 ns/op
BenchmarkFib20-4           16606             72218 ns/op
BenchmarkFib40-4               1        1086326400 ns/op
PASS
ok      golearnProject/day09/04benchmark        9.040s

```

Fib2(动态规划):

```
goos: windows
goarch: amd64
pkg: golearnProject/day09/04benchmark
BenchmarkFib1-4         265650405                4.51 ns/op
BenchmarkFib2-4         224437544                5.33 ns/op
BenchmarkFib3-4         194610804                6.16 ns/op
BenchmarkFib10-4        100000000               11.9 ns/op
BenchmarkFib20-4        57182340                20.3 ns/op
BenchmarkFib40-4        27924770                43.2 ns/op
PASS
ok      golearnProject/day09/04benchmark        9.096s
```

相对于递归版，动态规划真的优秀好多，所以在相关编码过程中，选择合适的方法也是至关重要的，也渐渐理解刷一些LeetCode题目的重要性，以后要加强自己在编程思维能力上的训练。。



