--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 03.03.2016
-- Time: 18:25
-- To change this template use File | Settings | File Templates.
--
local shell = require("shell")

shell.execute("rm turbines.lua")
shell.execute("rm updater.lua")
shell.execute("rm redcontrol.lua")
shell.execute("wget https://bitbucket.org/yannick9906/opencomputers/raw/master/files/turbines.lua")
shell.execute("wget https://bitbucket.org/yannick9906/opencomputers/raw/master/files/updater.lua")
shell.execute("wget https://bitbucket.org/yannick9906/opencomputers/raw/master/files/redcontrol.lua")

