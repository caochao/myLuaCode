-- setmetatable( _G, {
-- 	__newindex = function( _, k, v )
-- 		error("attemp to write to undeclared variable")
-- 	end,
-- 	__index = function( _, k )
-- 		error("attemp to read undeclared variable")
-- 	end
-- })

-- print( a )

Person = { age = 0 }

Person.new = function()
	local o = {}
	-- setmetatable( o, Person )
	-- Person.__index = Person
	-- Person.__add = Person.add
	-- Person.__tostring = Person.tostring

	setmetatable( o, { __index = Person, __add = Person.add, __tostring = Person.tostring } ) --这一句等效以上4句

	return o
end

function Person:setAge( age )
	self.age = age
end

function Person:getAge()
	return self.age
end

function Person:tostring()
	return "age=" .. self.age	
end

Person.add = function( p1, p2 )
	return p1.age + p2.age
end

p1 = Person.new()
p2 = Person.new()
p1:setAge( 9 )
print( p1 + p2 )
print( p1 )

----------- __newindex

local tb1 = {}
local tb2 = {}

setmetatable( tb1, tb2 )
tb2.__newindex = function( t, k, v )
	print( "fuck:", t, k, v )
end

-- tb2.__newindex = tb2

tb1.name = 1
print( tb1.name )
print( tb2.name )
