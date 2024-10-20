-- Define a module table
local openscad = {}

-- Helper function to convert parameters into a string
local function params_to_string(params)
    if not params or next(params) == nil then
        return "()" -- Ensure empty parentheses for nil or empty parameters
    elseif #params > 0 then
        -- If the parameters are a list (array)
        local parts = {}
        for _, v in ipairs(params) do
            table.insert(parts, tostring(v))
        end
        return "(" .. "[" .. table.concat(parts, ", ") .. "]" .. ")"
    else
        -- If the parameters are a key-value table
        local parts = {}
        for k, v in pairs(params) do
            table.insert(parts, k .. "=" .. tostring(v))
        end
        return "(" .. table.concat(parts, ", ") .. ")"
    end
end
                
-- The encode function to convert Lua tables into OpenSCAD code
local function encode(tbl, indent_level)
    indent_level = indent_level or 0
    local indent = string.rep("    ", indent_level) -- 4 spaces per indent

    -- Start building the OpenSCAD code string
    local openscad_code = ""

    for key, value in pairs(tbl) do
        local params = value.params or {}
        local inputs = value.inputs or {}

        -- Add the current OpenSCAD function with parameters
        local param_str = params_to_string(params)
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

    return openscad_code:sub(1, -2)  -- Remove the last extra newline
end

local function create(shape, params)
    if type(shape) ~= "string" then
        error("Shape must be a string.")
    end

    if type(params) ~= "table" then
        error("Params must be a table.")
    end

    obj = {[shape] = {params = params}}
    return obj
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

openscad.encode = encode
openscad.create = create
openscad.transform = transform
openscad.boolean = boolean

-- Export the module
return openscad
