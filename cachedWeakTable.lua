local results = {}
setmetatable( results, { __mode = "v" } )
function createRGB( r, g, b )
	local key = r .. "-" .. g .. "-" .. b
	local color = results[key]
	if color == nil then
		color = { red = r, green = g, blue = b }
		results[key] = color
	end
	return color
end

function printTable( tab )
	for k, v in pairs( tab ) do
		print( k, v )
	end
end

local rgb = createRGB( 10, 10, 10 )
printTable( results )
rgb = nil		-- { red = 10, green = 10, blue = 10 }除results table引用外再无其它引用, 会被垃圾收集
collectgarbage()
printTable( results )


-- 对象属性
local objAttrMap = {}
setmetatable( objAttrMap, { __mode = "k" } )
function setObjAttr( obj, attr )
	objAttrMap[obj] = attr
end

function func()
end

local tab = {}

setObjAttr( func, "funcName" )
setObjAttr( tab, "attrValue" )
printTable( objAttrMap)
func = nil
tab = nil
collectgarbage()
printTable( objAttrMap)