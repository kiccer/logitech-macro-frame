# 罗技宏框架API文档 | Logitech Macro Frame API Document

API列表:
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
* [playMacro](#playMacro)
* [abortMacro](#abortMacro)
* [setColor](#setColor)
* [setSpeed](#setSpeed)
* [getSpeed](#getSpeed)
* [addSpeed](#addSpeed)
* [isLock](#isLock)
* [isPressed](#isPressed)
* [setDpi](#setDpi)
* [附录 A](#附录-a)

### getM
`getM()` 方法返回当前 M Key 状态值。

**参数列表**

* family - 当您希望区分多个输入设备时请使用该可选设备族属性，默认为 “kb”。

设备族 | 特定设备
-- | --
“kb” | 键盘设备 (G15, G11, G19, etc)
“lhc” | 左手用控制器 (G13, etc)

**返回值**

* mkey - 1 = M1, 2 = M2, 3 = M3

**备注信息**

无

**代码示范**

```Lua
-- 获取当前 M Key 状态
current_mkey = getM()
```

### **setM**
`setM()` 方法可以设置当前 M keys 激活状态。

**参数列表**

* mkey - 1 = M1, 2 = M2, 3 = M3
* family - 当您希望区分多个输入设备时请使用该可选设备族属性，默认为 “kb”。

设备族 |	特定设备
-- | --
“kb” | 键盘设备 (G15, G11, G19, etc)
“lhc”	| 左手用控制器 (G13, etc)

**返回值**

无返回值

**备注信息**

无

**代码示范**

```Lua
-- 当 G1 被按下时设置当前M Key 状态为 M1
lmf.on("gkeydown", function (e)
	if e.g == 1 then
		setM(1)
	end
end)
```

### **sleep**
`sleep()` 方法方法将导致脚本暂停并等待所设置的时间后再继续执行。(单位毫秒)

**参数列表**

* timeout - 以毫秒为单位的睡眠时间。

**返回值**

nil

**备注信息**

脚本运行于主程序性能分析器不同的线程，所以脚本暂停时不会对其产生影响。

您可以使用此功能模拟操作延时。

性能分析器将等待一秒以使脚本执行完毕，超过该时间脚本将被强制中断。请务必注意不要进行长时间的延时。

**代码示范**

```Lua
-- 睡眠 20 毫秒
sleep(20)
```

### **logMsg**
`logMsg()` 方法将输出日志消息至脚本编辑器的控制台操作窗中。

**参数列表**

* message - 输出样式、包含格式化字符串的消息文本。

**返回值**

nil

**备注信息**

string.format() 方法镜像。

您需要手动在末尾插入回车符 "\n" 以结束该段文本。

**代码示范**

```Lua
-- 输出文本 "Hello World"
logMsg("Hello World %d\n", 2007)
```

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

**参数列表**

无

**返回值**

* elapsed - 一个包含运行总毫秒时间的整数值。

**备注信息**

您可以使用此方法计算您脚本的运行时间。.

**代码示范**

```Lua
-- 显示脚本运行时间
logMsg("This script has been running for: %d ms", getTime())
```

### **getDate**
`getDate()` 方法方法将获取已格式化的当前时间

**参数列表**

* format - 可选的日期字符串格式。
* time - 可选的时间表。

**返回值**

* date - 返回一个包含用户计算机当前日期以及时间（或参考时间）的字符串或时间表，根据所给的字符串格式就行字符串格式化，如果您希望提供自有格式化字符串，该方法将使用与 strftime() 相同的解析规则。特殊字符串 *t 将使 date() 方法返回一个时间表。

**备注信息**

os.date() 方法镜像。

**代码示范**

```Lua
-- 显示当前日期与时间
logMsg("Today’s date/time is: %s\n", getDate())
```

### **keyDown**
`keyDown()` 方法可被用于模拟键盘按键按下动作。

**参数列表**

* scancode - 特定数值扫描码对应的按键将被按下。
* keyname - 特定预定义键值对应的按键将被按下。

**返回值**

nil

**备注信息**

如果提供了多个按键作为实际参数，所有按键将被模拟为同一时间按下。关于扫描码或键值对应列表您可以参考附录 A。

**代码示范**

```Lua
-- 使用扫描码模拟键值 "a" 被按下
keyDown(30)

-- 使用键值模拟键值 "a" 被按下
keyDown("a")

-- 模拟 "a" 与 "b" 同时按下
keyDown("a", "b")
```

### **keyUp**
`keyUp()` 方法可被用于模拟键盘按键释放动作。

**参数列表**

* scancode - 特定数值扫描码对应的按键将被释放。

* keyname - 特定数值键值对应的按键将被释放。

**返回值**

nil

**备注信息**

如果提供了多个按键作为实际参数，所有按键将被模拟为同一时间释放。关于扫描码或键值对应列表您可以参考附录 A。

**代码示范**

```Lua
-- 使用扫描码模拟键值 "a" 被释放
keyUp(30)

-- 使用键值模拟键值 "a" 被释放
keyUp("a")

-- 模拟 "a" 与 "b" 同时释放
keyUp("a", "b")
```

### **keyTap**
`keyTap()` 方法可被用于模拟键盘按键按下动作并跟随按键释放动作。

**参数列表**

* scancode - 特定数值扫描码对应的按键将被按下并随后被释放。
* keyname - 特定数值键值对应的按键将被按下并随后被释放。

**返回值**

nil

**备注信息**

如果提供了多个按键作为实际参数，所有按键将被模拟为同一时间按下并随后释放。关于扫描码或键值对应列表您可以参考附录 A。

**代码示范**

```Lua
-- 使用扫描码模拟键值 "a" 被按下并随后被释放
keyTap(30)

-- 使用键值模拟键值 "a" 被按下并随后被释放
keyTap("a")

-- 模拟 "a" 与 "b" 同时按下并随后释放
keyTap("a", "b")
```

### **mouseDown**
`mouseDown()` 方法可被用于模拟鼠标按键被按下。

**参数列表**

* button - 按键标识符，您可以使用下表中列出的值：

按键值 | 对应操作
-- | --
1 | 鼠标左键
2 | 鼠标中键
3 | 鼠标右键
4 | 鼠标按键 X1
5 | 鼠标按键 X2

**返回值**

nil

**备注信息**

无

**代码示范**

```Lua
-- 模拟鼠标左键被按下
mouseDown(1)

-- 模拟鼠标右键被按下
mouseDown(3)
```

### **mouseUp**
`mouseUp()` 方法可被用于模拟鼠标按键被释放。

**参数列表**

* button - 按键标识符，您可以使用下表中列出的值：

按键值 | 对应操作
-- | --
1 | 鼠标左键
2 | 鼠标中键
3 | 鼠标右键
4 | 鼠标按键 X1
5 | 鼠标按键 X2

**返回值**

nil

**备注信息**

无

**代码示范**

```Lua
-- 模拟鼠标左键单击（按下并释放）
mouseDown(1)
mouseUp(1)
```


### **mouseTap**
`mouseTap()` 方法可被用于模拟鼠标按键按下动作并跟随按键释放动作。

**参数列表**

* button - 按键标识符，您可以使用下表中列出的值：

按键值 | 对应操作
-- | --
1 | 鼠标左键
2 | 鼠标中键
3 | 鼠标右键
4 | 鼠标按键 X1
5 | 鼠标按键 X2

**返回值**

nil

**备注信息**

无

**代码示范**

```Lua
-- 模拟鼠标左键单击（按下并释放）
mouseTap(1)
```

### **move**
`move()` 方法可被用于模拟鼠标相对当前坐标的偏移量。

**参数列表**

* X - 沿 x 轴方向移动
* Y - 沿 y 轴方向移动

**返回值**

nil

**备注信息**

如果您输入的 x 轴偏移量为正数，那么将模拟向右移动，如果您输入的 x 轴偏移量为负数，那么将模拟向左移动。如果您输入的 y 轴偏移量为正数，那么将模拟向下移动，如果您输入的 y 轴偏移量为负数，那么将模拟向上移动。

**代码示范**

```Lua
-- 模拟鼠标相对当前坐标移动偏移量为 1 像素并重复 50 次
for i = 0, 50 do
	move(0, -1)
	sleep(8)
end
```

### **moveTo**
`moveTo()` 方法可被用于移动鼠标指针至屏幕中的目标绝对坐标位置。

**参数列表**

* X - 标准 x 极坐标介于 0（极左）至 65535（极右）。
* Y - 标准 y 极坐标介于 0（极左）至 65535（极右）。

**返回值**

nil

**备注信息**

如果您接入了多个显示器请使用 moveToThis 方法代替。

**代码示范**

```Lua
-- 移动鼠标至左上角
moveTo(0, 0)

-- 移动鼠标至屏幕中央
moveTo(32767, 32767)

-- 移动鼠标至右下角
moveTo(65535, 65535)
```

### **moveToThis**
`moveToThis()` 方法可被用于在多个屏幕中移动鼠标指针至当前屏幕中的目标绝对坐标位置。

**参数列表**

* X - 标准 x 极坐标介于 0（极左）至 65535（极右）。

* Y - 标准 y 极坐标介于 0（极左）至 65535（极右）。

**返回值**

nil

**备注信息**

如果您接入了多个显示器请使用 moveToThis 方法代替。

**代码示范**

```Lua
-- 移动鼠标至虚拟桌面中的左上角
moveToThis(0, 0)

-- 移动鼠标至虚拟桌面中的中央
moveToThis (32767, 32767)

-- 移动鼠标至虚拟桌面中的右下角
moveToThis (65535, 65535)
```

### **wheel**
`wheel()` 方法可被用于模拟鼠标滚轮滚动。

**参数列表**

* click - 鼠标滚轮滚动次数。

**返回值**

nil

**备注信息**

如果您输入的为正数，那么将模拟向上滚动（远离用户），如果您输入的为负数，那么将模拟向下滚动（面向用户）。

**代码示范**

```Lua
-- 模拟鼠标滚轮向上滚动 3 次
wheel(3)

-- 模拟鼠标滚轮向下滚动 1 次
wheel(-1)
```

### **getMouse**
`getMouse()` 方法可被用于获取鼠标指针当前相对标准坐标。

**参数列表**

无

**返回值**

* X - 标准 x 极坐标介于 0（极左）至 65535（极右）。

* Y - 标准 y 极坐标介于 0（极左）至 65535（极右）。

**备注信息**

无

**代码示例**

```Lua
-- 获取当前鼠标指针坐标
x, y = getMouse()
logMsg("Mouse is at %d, %d\n", x, y)
```

### **playMacro**
`playMacro()` 方法可被用于播放已存在宏脚本。

**参数列表**

* macroname - 您需要指定在当前配置文件中已存在的宏脚本名称。

**返回值**

nil

**备注信息**

如果该方法在其他宏脚本播放时被调用则不会采取任何操作。换而言之，在同一段时间内仅可播放一个宏脚本而无法同时播放数个宏脚本。

然而如果调用并播放相同的一个宏脚本那么该宏脚本将被排入队列并在稍后播放。

**代码示范**

```Lua
-- 播放已存在宏脚本
playMacro("my macro")
```

### **abortMacro**
`abortMacro()` 方法可被用于中断当前任何已在播放的宏脚本。

**参数列表**

无

**返回值**

nil

**备注信息**

在调用 PlayMacro 方法时播放宏脚本过程中按下的所有按键将被释放，然而由外部播放的宏脚本仍将继续运行而不受影响。

**代码示范**

```Lua
-- 播放宏脚本
playMacro("my macro")

-- 等待100 毫秒并将正在播放的宏脚本中断
abortMacro()
```

### **setColor**
`setColor()` 方法被用于设置自定义设备背光灯颜色（如果您的设备支持自定义背光灯）。

**参数列表**

* red - 红色阈值范围 (0 – 255)。
* green - 绿色阈值范围 (0 – 255)。
* blue - 蓝色阈值范围 (0 – 255)。
* family - 当您希望区分多个输入设备时请使用该可选设备族属性，默认为 “kb”。

设备族 | 特定设备
-- | --
“kb” | 键盘设备 (G15, G11, G19, etc)
“lhc” | 左手用控制器 (G13, etc)

**返回值**

nil

**备注信息**

无

**代码示范**

```Lua
-- 设置背光灯为红色
setColor(255, 0, 0)

-- 为所有左手用控制器设备设置背光灯为蓝色
setColor(0, 0, 255, “lhc”)
```

### **setSpeed**
`setSpeed()` 方法设置 **G13** 移动速度。

**参数列表**

* New mouse speed - 鼠标绝对移动速度由 32 至 255。

**返回值**

nil

**备注信息**

无

**代码示范**

```Lua
-- 设置鼠标移动速度至 128
SetMouseSpeed(128)
```

### **getSpeed**
`getSpeed()` 方法获取 **G13** 移动速度。

**参数列表**

* Current mouse speed - 当前鼠标的绝对移动速度。

**返回值**

当前模拟鼠标的移动速度

**备注信息**

无

**代码示范**

```Lua
-- 获取鼠标移动速度
logMsg("The Mouse Speeed is: %d\n", getSpeed())
```

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

### 附录 A
该表中所有键值以及扫描值可被用于 **PressKey()**, **ReleaseKey()**, **IsModifierPressed()** 方法。

键值 | 扫描值（十六进制）
-- | --
"escape" | 0x01
"f1" | 0x3b
"f2" | 0x3c
"f3" | 0x3d
"f4" | 0x3e
"f5" | 0x3f
"f6" | 0x40
"f7" | 0x41
"f8" | 0x42
"f9" | 0x43
"f10" | 0x44
"f11" | 0x57
"f12" | 0x58
"f13" | 0x64
"f14" | 0x65
"f15" | 0x66
"f16" | 0x67
"f17" | 0x68
"f18" | 0x69
"f19" | 0x6a
"f20" | 0x6b
"f21" | 0x6c
"f22" | 0x6d
"f23" | 0x6e
"f24" | 0x76
"printscreen" | 0x137
"scrolllock" | 0x46
"pause" | 0x146
"tilde" | 0x29
"1" | 0x02
"2" | 0x03
"3" | 0x04
"4" | 0x05
"5" | 0x06
"6" | 0x07
"7" | 0x08
"8" | 0x09
"9" | 0x0a
"0" | 0x0b
"minus" | 0x0c
"equal" | 0x0d
"backspace" | 0x0e
"tab" | 0x0f
"q" | 0x10
"w" | 0x11
"e" | 0x12
"r" | 0x13
"t" | 0x14
"y" | 0x15
"u" | 0x16
"I" | 0x17
"o" | 0x18
"p" | 0x19
"lbracket" | 0x1a
"rbracket" | 0x1b
"backslash" | 0x2b
"capslock" | 0x3a
"a" | 0x1e
"s" | 0x1f
"d" | 0x20
"f" | 0x21
"g" | 0x22
"h" | 0x23
"j" | 0x24
"k" | 0x25
"l" | 0x26
"semicolon" | 0x27
"quote" | 0x28
"enter" | 0x1c
"lshift" | 0x2a
"non_us_slash" | 0x56
"z" | 0x2c
"x" | 0x2d
"c" | 0x2e
"v" | 0x2f
"b" | 0x30
"n" | 0x31
"m" | 0x32
"comma" | 0x33
"period" | 0x34
"slash" | 0x35
"rshift" | 0x36
"lctrl" | 0x1d
"lgui" | 0x15b
"lalt" | 0x38
"spacebar" | 0x39
"ralt" | 0x138
"rgui" | 0x15c
"appkey" | 0x15d
"rctrl" | 0x11d
"insert" | 0x152
"home" | 0x147
"pageup" | 0x149
"delete" | 0x153
"end" | 0x14f
"pagedown" | 0x151
"up" | 0x148
"left" | 0x14b
"down" | 0x150
"right" | 0x14d
"numlock" | 0x45
"numslash" | 0x135
"numminus" | 0x4a
"num7" | 0x47
"num8" | 0x48
"num9" | 0x49
"numplus" | 0x4e
"num4" | 0x4b
"num5" | 0x4c
"num6" | 0x4d
"num1" | 0x4f
"num2" | 0x50
"num3" | 0x51
"numenter" | 0x11c
"num0" | 0x52
"numperiod" | 0x53
“calculator” | 0x121
“web” | 0x132
“media_prev_track” | 0x110
“media_next_track” | 0x119
“media_play_pause” | 0x122
“media_stop” | 0x124
“volume_up” | 0x130
“volume_down” | 0x12e
“volume_mute” | 0x120
