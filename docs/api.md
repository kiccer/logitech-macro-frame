# 罗技宏框架API文档 | Logitech Macro Frame API Document

API列表:
* [lmf.on](#lmf.on)
* [getM](#getM)
* [setM](#setM)
* [sleep](#sleep)
* [logMsg](#logMsg)
* [lcdMsg](#lcdMsg)
* [debugMsg](#debugMsg)
* [getTime](#getTime)
* [getDate](#getDate)
* [keyDown](#keyDown)
* [keyUp](#keyUp)
* [keyTap](#keyTap)
* [mouseDown](#mouseDown)
* [mouseUp](#mouseUp)
* [mouseTap](#mouseTap)
* [move](#move)
* [moveTo](#moveTo)
* [moveToThis](#moveToThis)
* [wheel](#wheel)
* [getMouse](#getMouse)
* [onMacro](#onMacro)
* [offMacro](#offMacro)
* [setColor](#setColor)
* [setSpeed](#setSpeed)
* [getSpeed](#getSpeed)
* [addSpeed](#addSpeed)
* [isLock](#isLock)
* [isPressed](#isPressed)
* [setDpi](#setDpi)

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

### getM
`getM()` 方法返回当前 M Key 状态值。

### **setM**
`setM()` 方法可以设置当前 M keys 激活状态。

### **sleep**
`sleep()` 方法方法将导致脚本暂停并等待所设置的时间后再继续执行。(单位毫秒)

### **logMsg**
`logMsg()` 方法将输出日志消息至脚本编辑器的控制台操作窗中。

### **lcdMsg**
`lcdMsg()` 方法可被用于向LCD 添加单行文本。

**参数列表**

* text - 待显示字符串
* timeout - 超时时间为毫秒，等待超时后该消息将被删除。

**返回值**

nil

**备注信息**

您可以一次向设备添加并显示至多四条文本信息，默认超时时间为 1 秒。

**代码示范**

```Lua
-- 使用默认超时显示文本
lcdMsg("Hello world")

-- 显示文本并设置 2 秒超时时间
lcdMsg("Hello world", 2000)
```

### **debugMsg**
`debugMsg()` 方法将发送日志消息至 Windows 脚本调试器。

**参数列表**

* Message - 输出样式、包含格式化字符串的消息文本。

**返回值**

nil

**备注信息**

string.format() 方法镜像。

您需要手动在末尾插入回车符 "\n" 以结束该段文本。您可以使用类似于 Dbg 查看器等工具查看这些输出的消息。

**代码示范**

```Lua
-- 输出文本 "Hello World"

debugMsg("Hello World %d\n", 2007)
```

### **getTime**
`getTime()` 方法将返回以毫秒为单位的执行脚本总时间。

### **getDate**
`getDate()` 方法方法将获取已格式化的当前时间

### **keyDown**
`keyDown()` 方法可被用于模拟键盘按键按下动作。

### **keyUp**
`keyUp()` 方法可被用于模拟键盘按键释放动作。

### **keyTap**
`keyTap()` 方法可被用于模拟键盘按键按下动作并跟随按键释放动作。

### **mouseDown**
`mouseDown()` 方法可被用于模拟鼠标按键被按下。

### **mouseUp**
`mouseUp()` 方法可被用于模拟鼠标按键被释放。

### **mouseTap**
`mouseTap()` 方法可被用于模拟鼠标按键按下动作并跟随按键释放动作。

### **move**
`move()` 方法可被用于模拟鼠标相对当前坐标的偏移量。

### **moveTo**
`moveTo()` 方法可被用于移动鼠标指针至屏幕中的目标绝对坐标位置。

### **moveToThis**
`moveToThis()` 方法可被用于在多个屏幕中移动鼠标指针至当前屏幕中的目标绝对坐标位置。

### **wheel**
`wheel()` 方法可被用于模拟鼠标滚轮滚动。

### **getMouse**
`getMouse()` 方法可被用于获取鼠标指针当前相对标准坐标。

### **onMacro**
`onMacro()` 方法可被用于播放已存在宏脚本。

### **offMacro**
`offMacro()` 方法可被用于中断当前任何已在播放的宏脚本。

### **setColor**
`setColor()` 方法被用于设置自定义设备背光灯颜色（如果您的设备支持自定义背光灯）。

### **setSpeed**
`setSpeed()` 方法设置 **G13** 移动速度。

### **getSpeed**
`getSpeed()` 方法获取 **G13** 移动速度。

### **addSpeed**
`addSpeed()` 方法改变 **G13** 移动速度。

**参数列表**

* Speed change value - 若为正数，则增加指定移动速度。若为负数，则减少指定移动速度。

**返回值**

nil

**备注信息**

加快鼠标速度最大值将被限制至 255

或

降低鼠标速度最小值将被限制至 32

**代码示范**

```Lua
-- 增加 10 鼠标移动速度

addSpeed(10)

-- 降低 10 鼠标移动速度

addSpeed(-10)
```

### **isLock**
`isLock()` 方法可用于确定锁定键是否处于启用状态。

### **isPressed**
`isPressed()` 方法可用于确定某修饰键或某鼠标按键是否被按下。

**参数列表**

* Key Or Button - 若为字符型，则判断某修饰键是否按下。若为数字型，则判断某鼠标按键是否按下。数字仅支持1, 2, 3, 4, 5，字符支持"lalt", "ralt", "alt", "lshift", "rshift", "shift", "lctrl", "rctrl", "ctrl"。

**返回值**

true 或 false

**备注信息**

无

**代码示范**

```Lua
-- 左键是否被按下

isPressed(1)

-- 左 ctrl 键是否被按下

isPressed("lctrl")
```

### **setDpi**
`setDpi()` 方法可向已支持的游戏鼠标设置当前 DPI 表中的数值或向已支持的游戏鼠标通过DPI 表索引值设置 DPI。

**参数列表**

* Table Or Index - 若传入表，则将此DPI表设置到已支持的游戏鼠标，并默认使用第1个DPI。若为数字，则向已支持的游戏鼠标通过DPI 表索引值设置 DPI。

**返回值**

nil

**备注信息**

最多可以添加 16 条数值。

**代码示范**

```Lua
-- 设置初始 DPI数值为 { 500, 1000, 1500, 2000, 2500 }
setDpi({ 500, 1000, 1500, 2000, 2500 })

-- 设置当前 DPI 为表中第三项 (1500 DPI)
setDpi(3)
```
