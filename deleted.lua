a = 1
setfenv( 1, { g = _G } )
g.print( a )
g.print( g.a )