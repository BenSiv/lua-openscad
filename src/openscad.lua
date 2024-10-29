require("utils").using("utils")

-- Define a module table
local openscad = {}

-- Helper function to convert parameters into an OpenSCAD-compatible string
local function params_to_string(params)
    local param_str = ""
    local parts = {}
    if not params or type(params) ~= "table" then
        -- do nothing
    elseif is_array(params) and length(params) > 0 then
        for _, value in ipairs(params) do
            if type(value) == "table" then
                table.insert(parts, params_to_string(value))
            else
                table.insert(parts, tostring(value))
            end
        end
        param_str = "[" .. table.concat(parts, ", ") .. "]"
    else
        for key, value in pairs(params) do
            table.insert(parts, key .. "=" .. tostring(value))
        end
        param_str = table.concat(parts, ", ")
    end
    return param_str
end

-- The encode function to convert Lua tables into OpenSCAD code
local function encode(tbl, indent_level)
    indent_level = indent_level or 0
    local indent = string.rep("    ", indent_level)

    local openscad_code = ""

    for key, value in pairs(tbl) do
        local params = value.params or {}
        local inputs = value.inputs or {}

        local param_str = "(" .. params_to_string(params) .. ")"

        openscad_code = openscad_code .. indent .. key .. param_str

        if next(inputs) then
            openscad_code = openscad_code .. " {\n"
            for _, input in ipairs(inputs) do
                openscad_code = openscad_code .. encode(input, indent_level + 1) .. "\n"
            end
            openscad_code = openscad_code .. indent .. "}"
        end

        openscad_code = openscad_code .. ";\n"
    end

    return openscad_code:sub(1, -2) -- Remove the last extra newline
end

-- Function to create a shape with parameters
local function create(shape, params)
    if type(shape) ~= "string" then
        error("Shape must be a string.")
    end

    if type(params) ~= "table" then
        error("Params must be a table.")
    end

    return {[shape] = {params = params}}
end

local function transform(action, obj, params)
    -- Ensure action is a valid string
    if type(action) ~= "string" then
        error("Action must be a string.")
    end

    if type(obj) ~= "table" then
        error("Object must be a table.")
    end

    return {
        [action] = {
            params = params,
            inputs = {obj}
        }
    }
end

local function boolean(action, objects)
    -- Ensure action is a valid string
    if type(action) ~= "string" then
        error("Action must be a string.")
    end

    if type(objects) ~= "table" then
        error("Objects must be a table.")
    end

    return {
        [action] = {
            inputs = objects
        }
    }
end

-- write openscad source code file
local function write(path, content, resolution)
    local file = io.open(path, "w")
    if file then
        if resolution then
            file:write("$fn = " .. resolution .. ";\n\n")
        end
        file:write(content)
        file:write("\n\n")
        file:close()
    else
        print("Failed to open " .. path)
    end
end

-- append openscad source code file
local function append(path, content, resolution)
    local file = io.open(path, "a")
    if file then
        if resolution then
            file:write("\n$fn = " .. resolution .. ";\n\n")
        end
        file:write(content)
        file:write("\n")
        file:close()
    else
        print("Failed to open " .. path)
    end
end

openscad.encode = encode
openscad.create = create
openscad.transform = transform
openscad.boolean = boolean
openscad.write = write
openscad.append = append

-- Export the module
return openscad
