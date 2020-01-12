<h1 align="center">
  Logitech Macro Frame
</h1>
<div align="center">罗技宏框架，以降低开发成本、</div>
<div align="center">提高代码可维护性、可阅读性为宗旨，</div>
<div align="center">为开发者提供更方便的API和更实用的方法。</div>
<div align="center">欢迎Star⭐，您的支持就是我更新的最大动力！</div>
<br>
<p align="center">
  <img src="https://img.shields.io/badge/lua-5.1-00007F.svg" alt="lua-5.1">
  <img src="https://img.shields.io/badge/logitech-✔-A7F079.svg" alt="logitech-✔">
  <img src="https://img.shields.io/badge/lgs-9.02.65-00B8FC.svg" alt="lgs-9.02.65">
  <img src="https://img.shields.io/badge/version-latest-29D1E3.svg" alt="version-latest">
</p>

---

> 项目提炼自 kiccer/[Soldier76](https://github.com/kiccer/Soldier76)

### 前言
编写过罗技鼠标宏脚本的开发者都知道，罗技宏的开发过程十分坎坷，且进度缓慢：难以记忆的API、自相矛盾的设计、阉割的语言……
正是因为这些诸多不足，所以此框架才应运而生。在此框架中，完善了一些原生API的缺陷，甚至将多个API整合成一个，此外还提供了很多非常实用的方法。使用此框架后，你将获得全新的编写体验。

第一次写罗技宏脚本？没问题！你完全不需要去了解原始的编写方式，使用此框架就够了。

### 获取项目
点击右上角的 `Fork` 即可获取本项目。

`Fork` 之后进入自己的项目里，然后修改项目名，再使用 `git` 工具拉取到本地，即可上手开发。

开发时请注意编写区域，代码中有三块主要区域： **脚本使用者配置** 、 **框架核心代码** 以及 **脚本编写区**。开发时请看清注释提示。尽量不要改动 **框架核心代码**，**脚本使用者配置** 和 **脚本编写区** 可以自由修改。

### 开发技巧
在此脚本中，使用 `lmf.on` 来监听事件：

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

### 参考文档
* [框架API(基于原生重写/重命名)](./docs/api.md)
* [扩展方法(table篇)](./docs/table.md)
* [扩展方法(string篇)](./docs/string.md)

### 许可声明
* 本脚本使用 **MIT** 许可，允许商用，允许二次开发后出售。

### 交流群
* 欢迎加入技术交流QQ群：[![logitech 鼠标宏技术交流](https://github.com/kiccer/Soldier76/raw/master/static/img/group.png)](https://kiccer.github.io/Soldier76/static/join_group.html) ([768483124](https://kiccer.github.io/Soldier76/static/join_group.html))

### 问题反馈
* 使用脚本时有任何疑问，或脚本存在不足之处可以在 [`Issues`](https://github.com/kiccer/logitech-macro-frame/issues) 反馈给我

### 谁使用了此框架
* 暂无...

---

\* *另，作者Lua语言的水平仅有入门水准，如果发现代码中有任何可改进的地方，欢迎提交PR！*
