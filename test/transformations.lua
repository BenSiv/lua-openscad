-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

-- Import the openscad module
local openscad = require("openscad")

local shape = openscad.circle(5)
local shape = openscad.translate(shape, 1, 2, 3)
local result = openscad.encode(shape)

-- print(result)

assert(result == [[translate([1, 2, 3]) {
    circle(radius=5);
};]])