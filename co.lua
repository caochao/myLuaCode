function printCallStack()
	local startLevel = 2 --0表示getinfo本身,1表示调用getinfo的函数(printCallStack),2表示调用printCallStack的函数,可以想象一个getinfo(0级)在顶的栈.
	local maxLevel = 10	--最大递归10层

	for level = startLevel, maxLevel do
		-- 打印堆栈每一层
		local info = debug.getinfo( level, "nSl") 
		if info == nil then break end
		print( string.format("[ line : %-4d]  %-20s :: %s", info.currentline, info.name or "", info.source or "" ) )

		-- 打印该层的参数与局部变量
		local index = 1 --1表示第一个参数或局部变量, 依次类推
		while true do
			local name, value = debug.getlocal( level, index )
			if name == nil then break end

			local valueType = type( value )
			local valueStr
			if valueType == 'string' then
				valueStr = value
			elseif valueType == "number" then
				valueStr = string.format("%.2f", value)
			end
			if valueStr ~= nil then
				print( string.format( "\t%s = %s\n", name, value ) )
			end
			index = index + 1
		end
	end
end

function serialize( pTable )
	local tp = type( pTable )
	if tp == 'string' then
		return string.format( '%q', pTable )
	elseif tp ~= 'table' then
		return tostring( pTable )
	end
	local kvPairs = {}
	local ks, vs
	for k, v in pairs( pTable ) do
		tp = type( k )
		vs = serialize( v )
		if vs == nil then return end
		ks = tp == 'number' and string.format( '[%d]', k ) or string.format( '["%s"]', k )
		table.insert( kvPairs, ks .. '=' .. vs )
	end
	return "{" .. table.concat( kvPairs, ',' ) .. "}"
end

function TabToStr( tab )
	if tab == nil then
		return nil
	end
	local result = "{"
	local fmtK
	for k,v in pairs(tab) do
		fmtK = type(k) == "number" and '%d' or '"%s"'
		if type(v) == "table" then
			result = string.format( "%s[" .. fmtK .. "]=%s,", result, k, TabToStr( v ) )
		elseif type(v) == "number" then
			result = string.format( "%s[" .. fmtK .. "]=%d,", result, k, v )
		elseif type(v) == "string" then
			result = string.format( "%s[" .. fmtK .. "]=%q,", result, k, v )
		elseif type(v) == "boolean" then
			result = string.format( "%s[" .. fmtK .. "]=%s,", result, k, tostring(v) )
		else
			result = string.format( "%s[" .. fmtK .. "]=%q,", result, k, type(v) )
		end
	end
	result = result .. "}"
	return result
end

print( serialize( { cc = { name="cc", 21 }, ["age"] = 21, 'coder' } ) )
print( TabToStr( { cc = { name="cc", 21 }, ["age"] = 21, 'coder' } ) )

function touch( path )
	local start = 1
	while true do
		local fstart, fend = string.find(path, "%/", start )
		if not fstart or not fend then break end
		local subPath = string.sub( path, 1, fend )
		print( subPath )
		start = fend + 1
	end
end
local path = "E:/workspace/webgame/program/client"
touch( path )



-- create
-- function foo( a )
-- 	print( 'foo', a )
-- 	return coroutine.yield( 2 * a )
-- end

-- co = coroutine.create( function( a, b )
-- 	print( 'co-body', a, b )
-- 	local r = foo( a + 1 )

-- 	print( 'co-body', r )
-- 	local r, s = coroutine.yield( a + b, a - b )

-- 	print( 'co-body', r, s )
-- 	return b, 'end'
-- end )

-- print( 'main', coroutine.resume( co, 1, 10 ) )
-- print( 'main', coroutine.resume( co, 'r' ) )
-- print( 'main', coroutine.resume( co, 'x', 'y' ) )
-- print( 'main', coroutine.resume( co, 'x', 'y' ) )

-- wrap
function foo( a )
	print( 'foo', a )
	printCallStack()	
	return coroutine.yield( 2 * a )
end

resume = coroutine.wrap( function( a, b )
	print( 'co-body', a, b )
	local r = foo( a + 1 )
	print( 'co-body', r )
	local r, s = coroutine.yield( a + b, a - b )

	print( 'co-body', r, s )
	return b, 'end'
end )

print( 'main', resume( 1, 10 ) )
-- print( 'main', resume( 'r' ) )
-- print( 'main', resume( 'x', 'y' ) )
-- print( 'main', resume( 'x', 'y' ) )