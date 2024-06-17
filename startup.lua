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

-- main
 
term.setBackgroundColor(colors.blue)
readCode("clear")
 
 
while true do 
    write("$ ")
    local text = read()
    if text == "quit" then break end
 
    readCode(text)
end