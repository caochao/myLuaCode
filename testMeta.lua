function test_meta()
	local tab = {}
	local mt = {}

	print( "mt=", mt )

	-- 注意, 这里的t是tab, 而tab的元表mt
	mt.__index = function( t, k )
		print( "tab=", tab, "t=", t, "k=", k )
	end

	setmetatable( tab, mt )
	print(tab.name)
end

test_meta()