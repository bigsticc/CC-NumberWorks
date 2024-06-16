return {
    -- Arithmetic operations
    ["+"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a + b)
    end,
    ["-"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a - b)
    end,
    ["*"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a * b)
    end,
    ["/"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a / b)
    end,
    ["%"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a % b)
    end,
 
    -- Comparison
    [">"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a > b)
    end,
    ["<"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a < b)
    end,
    [">="] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a >= b)
    end,
    ["<="] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a <= b)
    end,
    ["="] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, a == b)
    end,
 
    -- Lua math library functions
    ["abs"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.abs(a))
    end,
    ["acos"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.acos(a))
    end,
    ["asin"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.asin(a))
    end,
    ["atan"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.atan(a))
    end,
    ["ceil"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.ceil(a))
    end,
    ["cos"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.cos(a))
    end,
    ["deg"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.deg(a))
    end,
    ["exp"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.exp(a))
    end,
    ["floor"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.floor(a))
    end,
    ["log"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.log(a))
    end,
    ["max"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, math.max(a, b))
    end,
    ["min"] = function(s)
        local b = table.remove(s)
        local a = table.remove(s)
        table.insert(s, math.min(a, b))
    end,
    ["rad"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.rad(a))
    end,
    ["sin"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.sin(a))
    end,
    ["sqrt"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.sqrt(a))
    end,
    ["tan"] = function(s)
        local a = table.remove(s)
        table.insert(s, math.tan(a))
    end,
 
    -- Stack manipulation functions
    ["swap"] = function(s)
        local a = table.remove(s)
        local b = table.remove(s)
        table.insert(s, a)
        table.insert(s, b)
    end,
    ["dup"] = function(s)
        local a = s[#s]
        table.insert(s, a)
    end,
    ["drop"] = function(s)
        table.remove(s)
    end,
 
    -- Word definition
    ["define"] = function(s)
        local body = table.remove(s)
        local name = table.remove(s)
 
        Dictionary[name] = body
    end,
    ["undef"] = function(s)
        local name = table.remove(s)
        Dictionary[name] = nil
    end,
 
    -- Control flow
    ["if"] = function(s)
        local ifTrue = table.remove(s)
        local condition = table.remove(s)
 
        eval(condition)
 
        if table.remove(s) then eval(ifTrue) end
    end,
    ["ifelse"] = function(s)
        local ifFalse = table.remove(s)
        local ifTrue = table.remove(s)
        local condition = table.remove(s)
 
        eval(condition)
 
        if table.remove(s) then eval(ifTrue) else eval(ifFalse) end
    end,
 
    -- Utility 
    ["."] = function(s)
        local a = table.remove(s)
        write(a)
        write("\n")
    end,
    [".s"] = function(s)
        write(textutils.serialize(s))
        write("\n")
    end,
    ["clear"] = function(s)
        term.clear()
        term.setCursorPos(1, 1)
    end,
}