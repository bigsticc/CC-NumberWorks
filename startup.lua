Functions = require "library"
Dictionary = {}
Stack = {}
 
function eval(source) 
    for _, token in ipairs(source) do
        if type(token) == "table" then
            table.insert(Stack, token)
        elseif tonumber(token) ~= nil then
            table.insert(Stack, tonumber(token))
        elseif token:sub(1, 1) == "#" then
            table.insert(Stack, token:sub(2))
        elseif token:sub(1, 1) == '"' then
            table.insert(Stack, token:sub(2, #token - 1))
        elseif Functions[token] ~= nil then
            Functions[token](Stack)
        elseif Dictionary[token] ~= nil then
            eval(Dictionary[token])
        else
            term.setTextColor(colors.red)
            print("Unknown token: "..token)
            term.setTextColor(colors.white)

            return
        end
    end
end
 
-- Reading raw text
local function parse(str)
    local stack = {}
    local current_list = {}
    local buffer = ""
    local inQuotes = false
    local quoteChar = nil

    local function append()
        if buffer ~= "" then
            table.insert(current_list, buffer)
            buffer = ""
        end
    end

    for c in str:gmatch "." do
        if inQuotes then
            if c == quoteChar then
                buffer = buffer .. c
                append()
                inQuotes = false
                quoteChar = nil
            else
                buffer = buffer .. c
            end
        else
            if c == '{' then
                append()
                table.insert(stack, current_list)
                current_list = {}
            elseif c == '}' then
                append()
                local last = table.remove(stack)
                table.insert(last, current_list)
                current_list = last
            elseif c == '"' or c == "'" then
                append()
                buffer = buffer .. c
                inQuotes = true
                quoteChar = c
            elseif c:match("[%w%p]") ~= nil then
                buffer = buffer .. c
            elseif c:match("%s") ~= nil then
                append()
            end
        end
    end
    append()

    -- Handle the case where the input string does not have balanced braces
    while #stack > 0 do
        local last = table.remove(stack)
        table.insert(last, current_list)
        current_list = last
    end

    return current_list
end
 
local function readCode(text)
    eval(parse(text))
end
 
-- main, to be changed before ported to ComputerCraft
 
term.setBackgroundColor(colors.blue)
readCode("clear")
 
 
while true do 
    write("$ ")
    local text = read()
    if text == "quit" then break end
 
    readCode(text)
end