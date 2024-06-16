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
        elseif Functions[token] ~= nil then
            Functions[token](Stack)
        elseif Dictionary[token] ~= nil then
            eval(Dictionary[token])
        end
    end
end
 
-- Reading raw text
local function tokenize(str)
    local tokens = {}
    local buffer = ""
    
    local function append()
       if buffer ~= "" then
            table.insert(tokens, buffer)
            buffer = ""
        end 
    end
    
    for c in str:gmatch "." do
        if c == '{' or c == '}' then
            append()
            table.insert(tokens, c)
            
        elseif c:match("[%w%p]") ~= nil then
            buffer = buffer .. c
        elseif c:match("%s") ~= nil then
            append()
        end
    end
    append()
 
    return tokens
end
 
local function parse(str)
    local stack = {}
    local current_list = {}
    local tokens = tokenize(str)
 
    for _, token in ipairs(tokens) do
        if token == "{" then
            table.insert(stack, current_list)
            current_list = {}
        elseif token == "}" then
            local last = table.remove(stack)
            table.insert(last, current_list)
            current_list = last
        else 
            table.insert(current_list, token)
        end
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