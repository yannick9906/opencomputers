--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 03.03.2016
-- Time: 17:48
-- To change this template use File | Settings | File Templates.
--

local pid = require("pid")
local shell = require("shell")
local component = require("component")

turbines = component.list("turbine")

print("Looking for Turbines on the network...")
for address, componentType in turbines do
    print("Found at: <<"..address..">> Type: "..componentType)
    shell.execute("pid run /pids/turbine.pid p=10 i=0.4 d=1 f=4 target=1820 --args "..address)
end
print("Finished")