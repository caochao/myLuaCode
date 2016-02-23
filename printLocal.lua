function printCallStack()
    local startLevel = 2 --0表示getinfo本身,1表示调用getinfo的函数(printCallStack),2表示调用printCallStack的函数,可以想象一个getinfo(0级)在顶的栈.
    local maxLevel = 10 --最大递归10层
 
    for level = startLevel, maxLevel do
        -- 打印堆栈每一层
        local info = debug.getinfo( level, "nSl") 
        if info == nil then break end
        print( string.format("[ line : %-4d]  %-20s :: %s", info.currentline, info.name or "", info.source or "" ) )
 
        -- 打印该层的参数与局部变量
        local index = 1 --1表示第一个参数或局部变量, 依次类推
        while true do
            local name, value = debug.getlocal( level, index )
            if name == nil then break end
 
            local valueType = type( value )
            local valueStr
            if valueType == 'string' then
                valueStr = value
            elseif valueType == "number" then
                valueStr = string.format("%.2f", value)
            end
            if valueStr ~= nil then
                print( string.format( "\t%s = %s\n", name, value ) )
            end
            index = index + 1
        end
    end
end

printCallStack()