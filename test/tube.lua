-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

require("utils").using("utils")

-- Import the openscad module
local openscad = require("openscad")

-- circle(radius)
local outer = openscad.create("cylinder",{h=10, r1=2, r2=2})
local inner = openscad.create("cylinder",{h=12, r1=1.8, r2=1.8})
local inner = openscad.transform("translate", inner, {0, 0, -1})
local tube = openscad.boolean("difference", {outer, inner})
local result = openscad.encode(tube)

show(tube)
print(result)
assert(result == [[
difference() {
    cylinder(h=10, r1=10, r2=10);
    translate([0, 0, -1]) {
        cylinder(h=12, r1=5, r2=5);
    };
};]])

