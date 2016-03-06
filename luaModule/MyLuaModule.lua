-- 定义模块
local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M

--  导入依赖库
--setmetatable( M, { __index = _G } )
local table = table
local print = print
local string = string

-- 在此之后定义的方法和变量全部在环境M中
setfenv( 1, M )

-- 模块定义结束


-- 模块内容开始
function module_add( a, b )
	return a + b
end