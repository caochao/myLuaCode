function test_metatable()
	local mt = {}
	mt.__index = function( t, k )
		print( "_index", k )
	end
	mt.__newindex = function( t, k, v )
		print( "_newindex", k, v )
	end

	local t = { name = "cc" }
	setmetatable( t, mt )

	print( "__index begin------------------------------")
	--读取表中存在的key, 直接对应的键值，不会调用元表中的__index元方法
	--读取表中不存在的key，先判断有无元表，无则返回nil，有则继续判断元表有无__index元方法，无则返回nil，有则调用元方法
	print( t.name )
	print( t.age )

	print( "__newindex begin--------------------------")
	--设置表中存在的key, 不会调用元表中的__newindex元方法
	--设置表中不存在的key, 会调用元表中的__newindex元方法
	t.name = 'cy'
	t.age = 1
end

test_metatable()

