-- 使用local变量
-- local变量访问比全局变量快, 数据量大时尤为明显
-- 访问local变量快的原因, 查找变量声明时, 从local开始到全局
function testGlobalSin()
	local a = os.clock()
	for i = 1,10000000 do
	  local x = math.sin(i)
	end
	print( "testGlobalSin:", os.clock() - a )
end

function testLocalSin()
	local a = os.clock()
	local sin = math.sin
	for i = 1,10000000 do
	  local x = sin(i)
	end
	print( "testLocalSin:", os.clock() - a )
end

testGlobalSin()
testLocalSin()

-- table预先填值, 避免rehash
-- table分为数组和哈希部分. 
-- 只有3个元素的表会执行3次rehash, 然而有一百万个元素的表仅仅只会执行20次rehash而已，因为2^20 = 1048576 > 1000000
function testRehash()
	local a = os.clock()
	for i = 1,2000000 do
	    local a = {}
	    a[1] = 1 		-- 第1次设置值, rehash, 数组大小被设置为size=2^0
	    a[2] = 2 		-- 第2次设置值, rehash, 数组大小被设置为size=2^1
	    a[3] = 3 		-- 第3次设置值, rehash, 数组大小被设置为size=2^2
	end
	print( "testRehash:", os.clock() - a )
end

function testPreSetField()
	local a = os.clock()
	for i = 1,2000000 do
	    local a = { 0, 0, 0 }
	    a[1] = 1
	    a[2] = 2
	    a[3] = 3
	end
	print( "testPreSetField:", os.clock() - a )
end

testRehash()
testPreSetField()

-- 大数据量避免直接字符串连接
function testStrConcat()
	local a = os.clock()
	local s = ''
	for i = 1,300000 do
	    s = s .. 'a'
	end
	print( "testStrConcat:", os.clock() - a )
end

function testTableConcat()
	local a = os.clock()
	local s = ''
	local t = {}
	for i = 1,300000 do
	    t[#t + 1] = 'a'
	end
	s = table.concat( t, '')
	print( "testTableConcat:", os.clock() - a )
end

testStrConcat()
testTableConcat()