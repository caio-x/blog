---
title: Swift类型推导原理
date: 2025-04-14
tags: [Swift]
top: 402
categories: Swift
---

深入理解Swift编译原理 -- Swift类型推导

<!-- more -->

下面代码里 item 和 map["C"]的值分别是多少？

``` swift
var list:[String]? = ["A", "B"]
var item: Any? = (list ?? []).map{ str in 
    ["C" : str]
}
```

不难看到，从开发的角度来看，开发者的预期应该是 [["C": "A"], ["C": "B"]]。list解包后，执行map操作，每一个元素，都会返回一个字典，看起来一切都是顺理成章。

但是实际上，它的结果是 ["C": ["A", "B"]]

### 直接原因
如果在Xcode中，使用Map函数的 Jump To Definition,跳转过去的是Optional的map成员函数，而不是Array的。

反过来看，如果把map解释为Optional的成员函数，那么此时输出结果是["C": ["A", "B"]]也就显得合理了。

但为什么`list ?? []`的解包结果是个Optional类型呢？