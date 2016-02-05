
local func = loadfile("test1.lua")
local tab = {}
setfenv( func, tab )()

for k, v in pairs( tab ) do
	print( k, v )
end