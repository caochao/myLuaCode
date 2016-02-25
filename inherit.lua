-- 多重继承实现
function createClass( ... )
	local supers = {...}
	local class = {}

	setmetatable( class, { __index = function( t, k )
		for i = 1, #supers do
			local value = supers[i][k]
			if value ~= nil then
				return value
			end
		end
	end })

	function class:ctor( ... ) end

	function class:new( ... )
		local instance = {}
		setmetatable( instance, class )
		class.__index = class
		instance:ctor( ... )
		return instance
	end

	return class
end

function testMultiParent()
	local super1 = { name = 'cc' }
	local super2 = { age = 22 }

	-- 创建类
	local class = createClass( super1, super2 )
	function class:ctor( ... )
		print( ... )
	end

	-- 创建对象
	local obj = class:new( 1,2,3 )
	print( obj.name, obj.age )
end

testMultiParent();

-- 隐私性, data只能被函数内部访问
function createPrivateClass()
	local data = { name = 'cc' }
	local function setName( pName )
		data.name = pName
	end
	local function getName()
		return data.name
	end
	return { setName = setName, getName = getName }
end

function testPrivateClass()
	local o = createPrivateClass()
	o.setName( 'cy' )
	print( o.getName() )
end

testPrivateClass()