return {
    -- Arithmetic operations
    ["+"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a + b)
    end,
    ["-"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a - b)
    end,
    ["*"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a * b)
    end,
    ["/"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a / b)
    end,
    ["%"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a % b)
    end,
 
    -- Boolean
    ["and"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, (a and b))
    end,
    ["or"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, (a or b))
    end,
    ["not"] = function(int)
        local a = table.remove(int.stack)
    end,

    -- Comparison
    [">"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a > b)
    end,
    ["<"] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a < b)
    end,
    [">="] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a >= b)
    end,
    ["<="] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a <= b)
    end,
    ["="] = function(int)
        local b = table.remove(int.stack)
        local a = table.remove(int.stack)
        table.insert(int.stack, a == b)
    end,
 
    -- Stack manipulation functions
    ["swap"] = function(int)
        local a = table.remove(int.stack)
        local b = table.remove(int.stack)
        table.insert(int.stack, a)
        table.insert(int.stack, b)
    end,
    ["dup"] = function(int)
        local a = int.stack[#(int.stack)]
        table.insert(int.stack, a)
    end,
    ["drop"] = function(int)
        table.remove(int.stack)
    end,
 
    -- Word definition
    ["define"] = function(int)
        local body = table.remove(int.stack)
        local name = table.remove(int.stack)
 
        int.dict[name] = body

        print("Added word '" .. name .. "' to private dictionary")
    end,
    ["undef"] = function(int)
        local name = table.remove(int.stack)
        int.dict[name] = nil

        print("Removed word '" .. name .. "' from private dictionary")
    end,
    ["list-words"] = function(int)
        local result = ""
        for k, v in pairs(int.dict) do
            result = result .. k .. ", "
        end
        print(result)
    end,
    -- Control flow
    ["if"] = function(int)
        local ifTrue = table.remove(int.stack)
        local condition = table.remove(int.stack)
 
        int:eval(condition)
 
        if table.remove(int.stack) then int:eval(ifTrue) end
    end,
    ["ifelse"] = function(int)
        local ifFalse = table.remove(int.stack)
        local ifTrue = table.remove(int.stack)
        local condition = table.remove(int.stack)
 
        int:eval(condition)
 
        if table.remove(int.stack) then int:eval(ifTrue) else int:eval(ifFalse) end
    end,
    ["while"] = function(int)
        local body = table.remove(int.stack)
        local condition = table.remove(int.stack)

        while int:evaluate(condition) or table.remove(int.stack) do
            int:evaluate(body)
        end
    end,
 
    -- Utility 
    ["."] = function(int)
        local a = table.remove(int.stack)
        print(a)
    end,
    [".s"] = function(int)
        print(textutils.serialize(int.stack))
    end,
    ["clear"] = function(int)
        term.setCursorPos(1, 1)
        term.clear()
    end, 
}