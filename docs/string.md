# 罗技宏框架扩展方法(String篇)

方法列表：
* [string.split](#stringsplit)
* [string.join](#stringjoin)

### **string.split**
`string.split()` 方法通过指定的字符串切割一段字符串，返回切割后的字符串数组。

**参数列表**

* string - 原始字符串。
* string - 切割字符串。

**返回值**

* table - 切割后的字符串数组

**备注信息**

无

**代码示范**

```Lua
local str = "LMF is the best Logitech macro framework!"
local res = string.split(str, " ")
console.log(res) -- { "LMF", "is", "the", "best", "Logitech", "macro", "framework!" }
```

### **string.join**
`string.join()` 方法通过指定的字符串拼接一组字符串，返回最终拼接后的字符串。

**参数列表**

* table - 待拼接的字符串数组。
* string - 用于拼接的字符串。

**返回值**

* string - 最终拼接后的字符串

**备注信息**

无

**代码示范**

```Lua
local list = { "LMF", "is", "the", "best", "Logitech", "macro", "framework!" }
local res = string.join(list, " ")
console.log(res) -- "LMF is the best Logitech macro framework!" 
```
