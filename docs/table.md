# 罗技宏框架扩展方法(Table篇)

方法列表：
* [table.some](#tablesome)
* [table.every](#tableevery)
* [table.reduce](#tablereduce)
* [table.map](#tablemap)
* [table.forEach](#tableforEach)
* [table.createFill](#tablecreateFill)
* [table.print](#tableprint)

### **table.some**
`table.some()` 方法判断数组中是否存在符合条件的项。

**参数列表**

* table - 目标数组。
* function - 判断方法，接受两个参数(n, i)。
  - n - 数组中的每一项。
  - i - 当前项的下标。

**返回值**

* boolean - 满足则返回 true，否则返回 false

**备注信息**

无

**代码示范**

```Lua
local list = { 1, 2, 3, 4, 5 }
-- list 中存在比3大的数字
local res1 = table.some(list, function (n, i)
  return n > 3
end)
console.log(res1) -- true

-- list 中存在比5大的数字
local res2 = table.some(list, function (n, i)
  return n > 5
end)
console.log(res2) -- false
```

### **table.every**
`table.every()` 方法判断数组中是否所有项都满足条件。

**参数列表**

* table - 目标数组。
* function - 判断方法，接受两个参数(n, i)。
  - n - 数组中的每一项。
  - i - 当前项的下标。

**返回值**

* boolean - 满足则返回 true，否则返回 false

**备注信息**

无

**代码示范**

```Lua
local list = { 1, 2, 3, 4, 5 }
-- list 中所有数字都比10小
local res1 = table.every(list, function (n, i)
  return n < 10
end)
console.log(res1) -- true

-- list 中所有数字都比5小
local res2 = table.every(list, function (n, i)
  return n < 5
end)
console.log(res2) -- false
```

### **table.reduce**
`table.reduce()` 方法对数组中的每个元素执行一个由您提供的 **table.reduce** 函数(升序执行)，将其结果汇总为单个返回值。

**参数列表**

* table - 目标数组。
* function - 处理方法，接受两个参数(n, m)。
  - n - 第一轮循环为第一项，之后的循环为前一轮循环的返回值。
  - i - 当前循环数+1的下标项。

**返回值**

* any - 返回处理后的值。

**备注信息**

无

**代码示范**

```Lua
local list = { 1, 2, 3, 4, 5 }
-- 计算 list 数组中所有数字之和
local res1 = table.reduce(list, function (n, m)
  return n + m
end)
console.log(res1) -- 15

local strs = { "LMF", "is", "the", "best", "Logitech", "macro", "framework!" }
-- 连接 strs 中的字符串，字符串之间用空格连接
local res2 = table.reduce(strs, function (n, m)
  return n .. " " .. m
end)
console.log(res2) -- "LMF is the best Logitech macro framework!"
```

### **table.map**
`table.map()` 方法创建一个新数组，其结果是该数组中的每个元素都调用一个提供的函数后返回的结果。

**参数列表**

* table - 目标数组。
* function - 处理方法，接受两个参数(n, i)。
  - n - 数组中的每一项。
  - i - 当前项的下标。

**返回值**

* table - 处理后的新数组

**备注信息**

该方法不会改变原始数组。

**代码示范**

```Lua
local list = { 1, 2, 3, 4, 5 }
-- 返回一个项是 list 中每一项的平方的新数组
local res = table.map(list, function (n, i)
  return n * n
end)
console.log(res) -- { 1, 4, 9, 16, 25 }
```

### **table.forEach**
`table.forEach()` 方法对数组的每个元素执行一次提供的函数。

**参数列表**

* table - 目标数组。
* function - 处理方法，接受两个参数(n, i)。
  - n - 数组中的每一项。
  - i - 当前项的下标。

**返回值**

无

**备注信息**

无

**代码示范**

```Lua
local list = { 1, 2, 3, 4, 5 }
-- 输出 list 数组中的每一项
table.forEach(list, function (n, i)
  console.log(n) -- 1 [, 2, 3, 4, 5]
end)
```

### **table.createFill**
`table.createFill()` 方法用于快速创建一个指定长度且每一项值相同的数组。

**参数列表**

* number - 指定数组长度。
* any - 指定数组项的值。

**返回值**

* table - 创建的数组

**备注信息**

无

**代码示范**

```Lua
-- 创建一个长度是20值为0的数组
local res = table.createFill(20, 0)
console.log(res) -- { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
```

### **table.print**
`table.print()` 方法将任意类型变量格式化成字符串形式。

**参数列表**

* any - 任意类型的变量。

**返回值**

* string - 格式化后的字符串。

**备注信息**

console.log 方法会调用 table.print 方法处理传入的值，并自动在末尾加上换行符 **\n** ，然后使用 `logMsg` 方法将文本信息输出到控制台。

**代码示范**

```Lua
local v = { 1, 2, "", true, false }
console.log(v) -- { 1, 2, "", true, false }
```
