Primitives = require "primitives"

Interpreter = {}

Interpreter.stack = {}
Interpreter.dict = {}

Interpreter.print = nil
Interpreter.sudo = false

function Interpreter:evaluate(code)
    for _, token in ipairs(code) do
        if type(token) == "table" then
            table.insert(self.stack, token)
        elseif tonumber(token) ~= nil then
            table.insert(self.stack, tonumber(token))
        elseif token:sub(1, 1) == "#" then
            table.insert(self.stack, token:sub(2))
        elseif token:sub(1, 1) == '"' then
            table.insert(self.stack, token:sub(2, #token - 1))
        elseif Primitives[token] ~= nil then
            Primitives[token](self)
        elseif self.dict[token] ~= nil then
            self:evaluate(self.dict[token])
        else
            print("Unknown token: "..token)
            return
        end
    end
end

function Interpreter:saveDict()
    local filename = "saves/_dict.lua"
    local file = fs.open(filename, "w")

    if file then
        local content = textutils.serialise(self.dict)
        file.write(content)
        file.close()
    else
        print("Could not open dictionary file.")
    end
end

function Interpreter:readDict()
    local filename = "saves/_dict.lua"
    local file = fs.open(filename, "r")
    if file then
        local content = file.readAll()
        self.dict = textutils.unserialise(content)
        file.close()
    else
        print("No dictionary file found for user.")
    end

end

function Interpreter:new(isSudo, printer)
    local out = {sudo = isSudo, print = printer}
    setmetatable(out, self)
    self.__index = self
    return out
end

return Interpreter