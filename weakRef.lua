-- 弱引用. 如果table a中key或value为table t, 且t除a外没有其它引用, key或value将被回收
-- table默认不是弱引用, 利用元表设置弱引用
function test_weak_ref( mode )
    local t = {}

    -- 给t设置一个元表，增加__mode元方法，赋值为“k”
    -- 分别测试
    if mode then
        setmetatable( t, { __mode = mode } )
    end

    -- 使用一个table作为t的key值
    local key1 = { name = "key1" }
    local key2 = { name = "key2" }
    local key3 = { name = "key3" }
    local key4 = { name = "key4" }

    t[key1] = key2
    key1 = nil

    t[key3] = key4
    key4 = nil

    -- 强制进行一次垃圾收集
    collectgarbage()

    for k, v in pairs(t) do
        print( k.name .. ":" .. v.name )
    end
end

-- test_weak_ref()
test_weak_ref( "k" )
-- test_weak_ref( "v" )
-- test_weak_ref( "kv" )