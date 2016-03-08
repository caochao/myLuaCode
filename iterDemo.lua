--[[
	泛型for循环等价于while循环, 形式转换如下:
	for var_list in exp_list do					-- 变量列表, 表达式列表
		loop_body								-- 表达式必须返回3个值, 即迭代函数, 恒定状态, 控制变量, 不足补nil, 过多丢弃
	end
	------>
	------>
	f, s, var = <exp_list>						-- 迭代函数, 恒定状态, 控制变量初值 = 调用迭代器工厂
	while true do
		var_1, var_2, ... var_n = f( s, var )	-- 以恒定状态, 控制变量调用迭代函数, 返回结果赋值给表达式列表
		var = var_1								-- 表达式列表第1个元素为控制变量, 为nil时结束循环
		if var == nil then break end
		<loop_body>
	end
]]

-- 迭代器工厂, 用闭包保持状态
function values( t )
	local i = 0
	return function()
		i = i + 1
		return t[i]
	end
end

-- while形式
function testIter( t )
	local iter = values( t )
	while true do
		local val = iter()
		if not val then break end
		print( val )
	end
end

-- for形式
function testIter2( t )
	for val in values( t ) do
		print( val )
	end
end

local t = { 2, 3, 4, 5 }
testIter( t )
testIter2( t )

-- 实现自己的ipairs函数
-- 3个重要概念, 迭代函数, 恒定状态, 控制变量
function iter( t, i )
	local i = i + 1
	local v = t[i]
	if v then
		return i, v
	end
end

function ipairs( t )
	return iter, t, 0
end

for i, v in ipairs( { 3, 4, 5, 6 } ) do
	print( i, v )
end