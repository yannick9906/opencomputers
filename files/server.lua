--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 10.10.2016
-- Time: 23:18
-- To change this template use File | Settings | File Templates.
--

local component = require("component")
local event = require("event")
local m = component.modem -- get primary modem component
m.open(123)
print(m.isOpen(123)) -- true
-- Send some message.
m.broadcast(321, "this is a test")
-- Wait for a message from another network card.
local _, _, from, port, _, message = event.pull("modem_message")
print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))