--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 03.03.2016
-- Time: 17:48
-- To change this template use File | Settings | File Templates.
--

require("pid")

turbines = component.list("turbine")

print("Looking for Turbines on the network...")
for address, componentType in turbines do
    print("Found at: <<"..address..">> Type: "..componentType)
end
print("Finished")