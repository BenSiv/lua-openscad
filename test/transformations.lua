-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

require("utils").using("utils")

-- Import the openscad module
local openscad = require("openscad")

local circle = openscad.create("circle",{radius=5})
local transformed = openscad.transform("translate", circle, {1, 2, 3})
local result = openscad.encode(transformed)

-- show(transformed)
-- print(result)

assert(result == [[translate([1, 2, 3]) {
    circle(radius=5);
};]])