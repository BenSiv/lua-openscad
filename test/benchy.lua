-- benchy.lua
package.path = "../src/?.lua;" .. package.path

local openscad = require("openscad")

-- Define base hull as a long cube with fillets (symbolic)
local hull = openscad.transform("translate", 
    openscad.transform("scale", 
        openscad.create("cube", {size = {1, 1, 1}, center = true}),
        {x = 60, y = 20, z = 10}
    ),
    {x = 0, y = 0, z = 5}
)

-- Define a simple cabin on top
local cabin = openscad.transform("translate", 
    openscad.create("cube", {size = {20, 10, 10}, center = true}),
    {x = 0, y = 0, z = 15}
)

-- Add a cylindrical chimney
local chimney = openscad.transform("translate", 
    openscad.create("cylinder", {h = 10, r = 3, center = true}),
    {x = 5, y = 0, z = 25}
)

-- Combine parts using union
local benchy_model = openscad.boolean("union", {hull, cabin, chimney})

-- Encode to OpenSCAD code
local scad_code = openscad.encode(benchy_model)

-- Write to file
openscad.write("3dbenchy.scad", scad_code, 100)
