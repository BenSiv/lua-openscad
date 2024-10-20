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

-- 3d

shapes.circle = circle

return shapes