-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

require("utils").using("utils")

-- Import the openscad module
local openscad = require("openscad")

local sphere = openscad.create("sphere",{radius=5})
local cube = openscad.create("cube",{size=5})
local transformed = openscad.boolean("difference", {sphere, cube})
local result = openscad.encode(transformed)

show(transformed)
print(result)

assert(result == [[difference() {
    sphere(radius=5);
    cube(size=5);
};]])