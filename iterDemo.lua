-- 用闭包保持状态, 实现迭代器
function values( t )
	local i = 0
	return function()
		i = i + 1
		return t[i]
	end
end

function testIter( t )
	local iter = values( t )
	while true do
		local val = iter()
		if not val then break end
		print( val )
	end
end

-- for循环调用迭代函数, 判断何时结束迭代
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
	i = i + 1
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