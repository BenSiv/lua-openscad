local shapes = {}

-- 2d

local function circle(radius)
    local result = {
        circle = {
            params = {
                radius = radius
            }
        }
    }
    return result
end

local function square(size)
    -- Determine if size is a single value (for a square) or a table (for a rectangle)
    local width, height
    if type(size) == "number" then
        width = size
        height = size
    elseif type(size) == "table" and #size == 2 then
        width = size[1]
        height = size[2]
    else
        error("Invalid size parameter. Use a number for a square or a table for a rectangle.")
    end

    local result = {
        square = {
            params = {
                width = width,
                height = height
            }
        }
    }
    return result
end

-- 3d

local function sphere(radius)
    local result = {
        sphere = {
            params = {
                radius = radius
            }
        }
    }
    return result
end

local function cylinder(height, radius1, radius2)
    local result = {
        cylinder = {
            params = {
                h = height,
                r1 = radius1,
                r2 = radius2
            }
        }
    }
    return result
end

local function cube(size)
    -- Determine if size is a single value (for a cube) or a table (for a rectangular prism)
    local width, depth, height
    if type(size) == "number" then
        width = size
        depth = size
        height = size
    elseif type(size) == "table" and #size == 3 then
        width = size[1]
        depth = size[2]
        height = size[3]
    else
        error("Invalid size parameter. Use a number for a cube or a table for a rectangular prism.")
    end

    local result = {
        cube = {
            params = {
                width = width,
                depth = depth,
                height = height
            }
        }
    }
    return result
end

shapes.circle = circle
shapes.square = square
shapes.sphere = sphere
shapes.cylinder = cylinder
shapes.cube = cube

return shapes