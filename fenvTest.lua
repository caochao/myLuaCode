function test_load2G()
	print( _G )		-- 当前环境, loadfile默认加载到全局环境_G
	local func = loadfile( "test1.lua" )
	func()
	print( _G.test1, _G.test2, _G.a, _G.b )
	print( test1, test2, a, b )
end

function test_load2env()
	-- 加载到table
	local env = {}
	local func = loadfile( "test1.lua" )
	func = setfenv( func, env )
	func()
	print( env.test1, env.test2, env.a, env.b )
	print( _G.test1, _G.test2, _G.a, _G.b )
end

--test_load2G()
test_load2env()