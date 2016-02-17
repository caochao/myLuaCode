Person = { age = 0 }

-- setmetatable( Person, { __index = _G } )
-- setmetatable( Person, { __index = Person } ) -- 这样写后, 取Person不存在的属性时会导致无限循环

function Person:new()
	local o = {}
	setmetatable( o, self )		-- 这两句等价于setmetatable( o, { __index = self } )
	self.__index = self
	return o
end

function Person:getAge()
	return self.age
end

function Person:setAge( age )
	self.age = age
end

local p = Person:new()
-- p:setAge( 21 )
print( p:getAge() )
print( p.print )