Interpreter = require "interpreter"

function parse(str)
    local tokens = {}
    for token in str:gsub("{", " { "):gsub("}", " } "):gmatch("%S+") do
        table.insert(tokens, token)
    end

    local function reduce(tokens)
        local ast = {{}}
        for _, token in ipairs(tokens) do
            if token == "{" then
                table.insert(ast, {})
            elseif token == "}" then
                local current_expression = table.remove(ast)
                table.insert(ast[#ast], current_expression)
            else
                table.insert(ast[#ast], token)
            end
        end
        return ast[1]
    end

    return reduce(tokens)
end

-- main
local interp = Interpreter:new() 

interp:readDict()

term.setBackgroundColor(colors.blue)
interp:evaluate(parse("clear"))


while true do 
    write("$ ")
    local text = read()
    if text == "quit" then break end
 
    interp:evaluate(parse(text))
end
