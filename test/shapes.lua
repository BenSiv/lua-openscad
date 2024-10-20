-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

require("utils").using("utils")

-- Import the openscad module
local openscad = require("openscad")

-- circle(radius)
local circle = openscad.create("circle",{radius=5})
local result = openscad.encode(circle)

-- show(circle)
-- print(result)
assert(result == "circle(radius=5);")

-- square(size)
local square = openscad.create("square",{size=5})
local result = openscad.encode(square)

-- show(square)
-- print(result)
assert(result == "square(size=5);")

-- square(width,height)
local rect = openscad.create("square",{width=5, height=6})
local result = openscad.encode(rect)

-- show(rect)
-- print(result)
assert(result == "square(height=6, width=5);")
