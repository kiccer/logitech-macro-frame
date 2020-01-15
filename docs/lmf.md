# 罗技宏框架内置方法

方法列表：
* [lmf.on](#lmfon)
* [lmf.off](#lmfoff)
* [lmf.loop](#lmfloop)

### **lmf.on**
`lmf.on()` 方法用于监听事件。
```Lua
lmf.on("load", function (e)
	console.log("hello world")
end)
```

这段代码的效果其实就是相当于：

```Lua
function OnEvent (event, arg, family)
  if event == "PROFILE_ACTIVATED" then
    OutputLogMessage("hello world\n")
  end
end
```

`lmf.on` 方法接受两个参数： **eventName** 、 **callback**

可供选择的监听事件(**eventName**)有：
* `load` - 监听 **脚本加载** 事件
* `unload` - 监听 **脚本退出** 事件
* `mousedown` - 监听 **鼠标按下** 事件
* `mouseup` - 监听 **鼠标弹起** 事件
* `gkeydown` - 监听 **G键按下** 事件
* `gkeyup` - 监听 **G键弹起** 事件
* `mkeydown` - 监听 **M键按下** 事件
* `mkeyup` - 监听 **M键弹起** 事件

第二个参数(**callback**)是一个回调函数，该函数将会在监听的事件触发时被调用，并获得一个参数(e)，参数内容如下：

```Lua
{
     capslock = false, -- 大写锁定键是否开启
     scrolllock = false, -- 滚动锁定是否开启
     numlock = true, -- 小键盘锁定是否开启
     modifier = {}, -- 哪些修饰键是按住的状态 (lalt、lctrl、lshift、ralt、rctrl、rshift)
     family = "other", -- 触发事件的设备 (鼠标或其他)
     g = 0, -- 触发事件的 G 键，包括鼠标、键盘、耳机等
     event = "load", -- 触发的事件
     pressed = {} -- 哪些 G 键是按住的状态 (仅支持判断 g1、g2、g3、g4、g5 五个鼠标 G 键)
}
```

### **lmf.off**
`lmf.off()` 方法用于取消监听。
```Lua
local md = lmf.on("mousedown", function (e)
	console.log(e)
end)

lmf.off(md)
```

将 `lmf.on` 的返回值传入 `lmf.off` 即可取消对应的事件监听。

### lmf.loop
`lmf.loop()` 方法按指定时间间隔循环一段代码。

**参数列表**

* function - 需要循环的代码。
* number - 循环间隔

**返回值**

* nil

**备注信息**

此方法提供防死循环功能
循环总时长 ≥ lmf._for_protect_time (默认20000ms)
到达上限后循环会自动跳出，防止出现死循环卡死程序

**代码示范**

```Lua
local a = 0
lmf.loop(function ()
	console.log(a)
	a = a + 1
	return a < 5 -- 返回 true 则继续循环，返回 false 则到此为止
end, 1000)
```
