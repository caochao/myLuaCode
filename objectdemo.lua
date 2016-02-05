Person = { age = 0 }

--setmetatable( Person, { __index = _G } )

-- Person.new = function()
-- 	local o = {}
-- 	setmetatable( o, { __index = Person } )
-- 	return o
-- end

function Person:new()
	local o = {}
	setmetatable( o, self )
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