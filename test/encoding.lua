-- Adjust the package path to include the 'src' directory
package.path = "../src/?.lua;" .. package.path

-- Import the openscad module
local openscad = require("openscad")

-- Example test case for the 'encode' function
local input = {
    difference = {
        params = nil,
        inputs = {
            [1] = {
                cylinder = {
                    params = {h = 10, r1 = 10, r2 = 10},
                    inputs = nil
                }
            },
            [2] = {
                translate = {
                    params = {0, 0, -1},
                    inputs = {
                        [1] = {
                            cylinder = {
                                params = {h = 12, r1 = 5, r2 = 5},
                                inputs = nil
                            }
                        }
                    }
                }
            },
        }
    }
}

-- Run the encode function and print the result
local result = openscad.encode(input)
-- print(result)

-- Optionally, you can add assertions to verify the output (requires luaunit or similar)
assert(result == [[difference() {
    cylinder(h=10, r2=10, r1=10);
    translate([0, 0, -1]) {
        cylinder(h=12, r2=5, r1=5);
    };
};]])
