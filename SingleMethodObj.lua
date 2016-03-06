-- 单一方法对象. 完全的私密性控制
function newObject( value )
	return function( action, v )
		if action == "get" then return value
		elseif action == "set" then value = v
		else error("invalid action")
		end
	end
end

local d = newObject( 10 )
print( d("get") )
d("set", 11)
print( d("get") )
