#include <lua.h>  
#include <lualib.h>  
#include <lauxlib.h> 

static int l_cppAdd( lua_State *L )
{
	lua_Integer a = lua_tointeger( L, 1 );
	lua_Integer b = lua_tointeger( L, 2 );
	lua_pushinteger( L, a + b );
	return 1;
}

static const luaL_Reg module_funcs[] = {
	{"cppAdd", l_cppAdd},
	{NULL, NULL}
};

// lua代码中require "module"时会调用c库函数luaopen_module
static int luaopen_MyCModule( lua_State *L )
{
	luaL_register( L, "MyCModule", module_funcs );
	return 1;
}