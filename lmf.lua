----------------------------------------------------------------------------------------------------
--                                        使用者配置设置                                           --
--                                    User config settings                                        --
----------------------------------------------------------------------------------------------------

userConfig = {

}

























--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--
--                                                                                                --
--                                   >> Logitech Macro Frame <<                                   --
--                                                                                                --
--               Welcome to this script. If you have any questions, please visit:                 --
--                        https://github.com/kiccer/logitech-macro-frame                          --
--                    Please click [★ Star] to support my project, thank you.                    --
--                                                                                                --
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--

----------------------------------------------------------------------------------------------------
--                                     Framework built-in code                                    --
----------------------------------------------------------------------------------------------------

lmf = {
	debug = true,
	monitor = {}, -- 监听器列表
}

-- 重命名 API，整合个别 API 功能
getM = GetMKeyState
setM = SetMKeyState
sleep = Sleep
logMsg = OutputLogMessage
lcdMsg = OutputLCDMessage
debugMsg = OutputDebugMessage
getTime = GetRunningTime
getDate = GetDate
keyDown = PressKey
keyUp = ReleaseKey
keyTap = PressAndReleaseKey
mouseDown = PressMouseButton
mouseUp = ReleaseMouseButton
mouseTap = PressAndReleaseMouseButton
move = MoveMouseRelative
moveTo = MoveMouseTo
moveToThis = MoveMouseToVirtual
wheel = MoveMouseWheel
getMouse = GetMousePosition
onMacro = PlayMacro
offMacro = AbortMacro
setColor = SetBacklightColor
setSpeed = SetMouseSpeed
getSpeed = GetMouseSpeed
addSpeed = lmf.addSpeed
isLock = IsKeyLockOn
isPressed = lmf.isPressed
setDpi = lmf.setDpi


function lmf.isPressed (n)
	if type(n) == "number" then
		return IsMouseButtonPressed(n)
	elseif type(n) == "string" then
		return IsModifierPressed(n)
	else
		if lmf.debug then error("[lmf.isPressed] Wrong parameter data type: " .. tostring(n) .. " is not a \"number\" or \"string\".") end
	end
end

function lmf.setDpi (n)
	if type(n) == "table" then
		SetMouseDPITable(n, 1)
	elseif type(n) == "number" then
		SetMouseDPITableIndex(n)
	else
		if lmf.debug then error("[lmf.setDpi] Wrong parameter data type: " .. tostring(n) .. " is not a \"table\" or \"number\".") end
	end
end

function lmf.addSpeed (n)
	if type(n) ~= "number" then
		if lmf.debug then error("[lmf.addSpeed] Wrong parameter data type: " .. tostring(n) .. " is not a \"number\".") end
	elseif n > 0 then
		IncrementMouseSpeed(n)
	elseif n < 0 then
		DecrementMouseSpeed(-n)
	end
end


-- 监听动作
function lmf.on (k, f)
	local index = nil
	local list = {
		'load',
		'unload',
		'event',
	}

	if table.some(list, function (n, i)
		return n == k
	end) then
		if lmf.monitor[k] and #lmf.monitor[k] > 0 then
			index = #lmf.monitor[k] + 1
			lmf.monitor[k][index] = f
		else
			index = 1
			lmf.monitor[k] = { f }
		end
	end

	return index and {
		event = k,
		id = index
	} or index
end

-- 取消监听
function lmf.off (n)
	lmf.monitor[n.event][n.id] = false
end

-- 触发监听事件
function lmf.emit (k, d)
	if lmf.monitor[k] and #lmf.monitor[k] then
		table.forEach(lmf.monitor[k], function (n, i)
			if n then n(d) end
		end)
	end
end

--[[ tools ]]

-- split function
function string.split (str, s)
	if string.find(str, s) == nil then return { str } end

	local res = {}
	local reg = "(.-)" .. s .. "()"
	local index = 0
	local last_i

	for n, i in string.gfind(str, reg) do
		index = index + 1
		res[index] = n
		last_i = i
	end

	res[index + 1] = string.sub(str, last_i)

	return res
end

-- Javascript Array.prototype.some
function table.some (t, c)
	local res = false
	for i = 1, #t do
		if c(t[i], i) then
			res = true
			break
		end
	end
	return res
end

-- Javascript Array.prototype.every
function table.every (t, c)
	local res = true
	for i = 1, #t do
		if not c(t[i], i) then
			res = false
			break
		end
	end
	return res
end

-- Javascript Array.prototype.reduce
function table.reduce (t, c)
	local res = c(t[1], t[2])
	for i = 3, #t do res = c(res, t[i]) end
	return res
end

-- Javascript Array.prototype.map
function table.map (t, c)
	local res = {}
	for i = 1, #t do res[i] = c(t[i], i) end
	return res
end

-- Javascript Array.prototype.forEach
function table.forEach (t, c)
	for i = 1, #t do c(t[i], i) end
end

function table.createFill (n, v)
	local res = {}
	for i = 1, n do res[i] = v end
	return res
end

--[[
	* 打印 table
	* @param  {any} val     传入值
	* @return {str}         格式化后的文本
]]
function table.print (val)

	local function loop (val, keyType, _indent)
		_indent = _indent or 1
		keyType = keyType or "string"
		local res = ""
		local indentStr = "     " -- 缩进空格
		local indent = string.rep(indentStr, _indent)
		local end_indent = string.rep(indentStr, _indent - 1)
		local putline = function (...)
			local arr = { res, ... }
			for i = 1, #arr do
				if type(arr[i]) ~= "string" then arr[i] = tostring(arr[i]) end
			end
			res = table.concat(arr)
		end

		if type(val) == "table" then
			putline("{ ")

			if #val > 0 then
				local index = 0
				local block = false

				for i = 1, #val do
					local n = val[i]
					if type(n) == "table" or type(n) == "function" then
						block = true
						break
					end
				end

				if block then
					for i = 1, #val do
						local n = val[i]
						index = index + 1
						if index == 1 then putline("\n") end
						putline(indent, loop(n, type(i), _indent + 1), "\n")
						if index == #val then putline(end_indent) end
					end
				else
					for i = 1, #val do
						local n = val[i]
						index = index + 1
						putline(loop(n, type(i), _indent + 1))
					end
				end

			else
				putline("\n")
				for k, v in pairs(val) do
					putline(indent, k, " = ", loop(v, type(k), _indent + 1), "\n")
				end
				putline(end_indent)
			end

			putline("}, ")
		elseif type(val) == "string" then
			val = string.gsub(val, "\a", "\\a") -- 响铃(BEL)
			val = string.gsub(val, "\b", "\\b") -- 退格(BS),将当前位置移到前一列
			val = string.gsub(val, "\f", "\\f") -- 换页(FF),将当前位置移到下页开头
			val = string.gsub(val, "\n", "\\n") -- 换行(LF),将当前位置移到下一行开头
			val = string.gsub(val, "\r", "\\r") -- 回车(CR),将当前位置移到本行开头
			val = string.gsub(val, "\t", "\\t") -- 水平指标(HT),(调用下一个TAB位置)
			val = string.gsub(val, "\v", "\\v") -- 垂直指标(VT)
			putline("\"", val, "\", ")
		elseif type(val) == "boolean" then
			putline(val and "true, " or "false, ")
		elseif type(val) == "function" then
			putline(tostring(val), ", ")
		elseif type(val) == "nil" then
			putline("nil, ")
		else
			putline(val, ", ")
		end

		return res
	end

	local res = loop(val)
	res = string.gsub(res, ",(%s*})", "%1")
	res = string.gsub(res, ",(%s*)$", "%1")
	res = string.gsub(res, "{%s+}", "{}")

	return res
end

-- console
console = {
	clear = ClearLog
}

function console.log (str)
	OutputLogMessage(table.print(str) .. "\n")
end

----------------------------------------------------------------------------------------------------
--                                         Entry function                                         --
----------------------------------------------------------------------------------------------------

function OnEvent (event, arg, family)
	-- console.log("event = " .. event .. ", arg = " .. arg .. ", family = " .. family)

	-- Script activated event
	if event == "PROFILE_ACTIVATED" then
		if lmf.monitor.load and #lmf.monitor.load then
			table.forEach(lmf.monitor.load, function (n, i)
				if n then n() end
			end)
		end
	end

	-- Script deactivated event
	if event == "PROFILE_DEACTIVATED" then
		if lmf.monitor.unload and #lmf.monitor.unload then
			table.forEach(lmf.monitor.unload, function (n, i)
				if n then n() end
			end)
		end
		console.clear()
	end

	-- PRESSED event

	if event == "MOUSE_BUTTON_PRESSED" and family == "mouse" then
		if arg == 2 then arg = 3 elseif arg == 3 then arg = 2 end
		lmf._event(true, arg)
	elseif event == "G_PRESSED" then
		lmf._event(false, arg)
	end

end

function lmf._event (isMouse, arg)
	local eObj = {
		isMouse = isMouse,
		g = arg,
		isPressed = {},
		-- other = {},
		modifier = {}
	}
	local list = { "lalt", "lctrl", "lshift", "ralt", "rctrl", "rshift" }

	for i = 1, 5 do
		if IsMouseButtonPressed(i) then
			eObj.isPressed[#eObj.isPressed + 1] = "g" .. i
		end
	end

	for i = 1, #list do
		if IsModifierPressed(list[i]) then
			eObj.modifier[#eObj.modifier + 1] = list[i]
		end
	end

	lmf.emit('event', eObj)
end

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--
--                                                                                                --
--                                     从这里开始写你的代码                                         --
--                                Start writing your code here.                                   --
--                                                                                                --
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--

-- EnablePrimaryMouseButtonEvents(true)

-- Execute when the script is loaded
lmf.on('load', function ()
	console.log('hello world')
end)

lmf.on('event', function (e)
	console.log(e)
end)

-- console.log(lmf)














---------------------------------------------- Code End --------------------------------------------
----------------------------------------------------------------------------------------------------
