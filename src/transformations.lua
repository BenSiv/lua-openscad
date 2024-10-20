local transformations = {}

local function translate(obj, x, y, z)
    local result = {
        translate = {
            params = {x, y, z},
            inputs = {obj}
        }
    }
    return result
end

local function rotate(obj, x, y, z)
    local result = {
        rotate = {
            params = {x, y, z},
            inputs = {obj}
        }
    }
    return result
end

local function scale(obj, x, y, z)
    local result = {
        scale = {
            params = {x, y, z},
            inputs = {obj}
        }
    }
    return result
end

local function mirror(obj, x, y, z)
    local result = {
        mirror = {
            params = {x, y, z},
            inputs = {obj}
        }
    }
    return result
end

transformations.translate = translate
transformations.rotate = rotate
transformations.scale = scale
transformations.mirror = mirror

return transformations


-- translate([x,y,z])
-- rotate([x,y,z])
-- rotate(a, [x,y,z])
-- scale([x,y,z])
-- resize([x,y,z],auto,convexity)
-- mirror([x,y,z])
-- multmatrix(m)
-- color("colorname",alpha)
-- color("#hexvalue")
-- color([r,g,b,a])
-- offset(r|delta,chamfer)
-- hull()
-- minkowski(convexity)