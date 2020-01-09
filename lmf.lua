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
--                      Please click star to support my project, thank you.                       --
--                                                                                                --
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--

-------------------------------------- Framework built-in code -------------------------------------

lmf = {
	debug = false,
	monitor = {} -- 监听器列表
}

-- 监听动作
function lmf.on (k, f)
	local index = #lmf.monitor + 1
	local list = {
		'mounted'
	}

	if table.some(list, function (n, i)
		return n == k
	end) then
		lmf.monitor[index] = {
			event = k,
			handle = f
		}
	end

	return index
end

-- 取消监听
function lmf.off (i)
	-- lmf.monitor[i].handle = false
	lmf.monitor[i] = false
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
				local inline = false

				for i = 1, #val do
					local n = val[i]
					if type(n) == "table" then
						inline = true
						break
					end
				end

				if inline then
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
console = {}
function console.log (str)
	OutputLogMessage(table.print(str) .. "\n")
end

--[[ 入口方法 ]]
function OnEvent (event, arg, family)
	-- console.log("event = " .. event .. ", arg = " .. arg .. ", family = " .. family)

	-- Script activated event
	if event == "PROFILE_ACTIVATED" then
		table.forEach(lmf.monitor, function (n, i)
			-- if n.event == 'mounted' and n.handle then
			if n and n.event == 'mounted' then
				n.handle()
			end
		end)
	end

	-- Script deactivated event
	if event == "PROFILE_DEACTIVATED" then
		ClearLog()
	end
end

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--
--                                                                                                --
--                                     从这里开始写你的代码                                         --
--                                                                                                --
--                                Start writing your code here.                                   --
--                                                                                                --
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||--

-- Execute when the script is loaded
lmf.on('mounted', function ()
	console.log('hello world')
end)















---------------------------------------------- Code End --------------------------------------------
----------------------------------------------------------------------------------------------------
