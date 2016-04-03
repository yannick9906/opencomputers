--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 02.04.2016
-- Time: 02:16
-- To change this template use File | Settings | File Templates.
--
local component = require("component")
local event = require "event" -- load event table and store the pointer to it in event

local gpu = component.gpu -- get primary gpu component

local char_space = string.byte(" ") -- numerical representation of the space char

local foreground_primary  = 0x000000
local foreground_disabled = 0x000000
local background_primary  = 0x333366
local background_disabled = 0xC8C8C8

local running = true -- state variable so the loop can terminate
local WELCOME_TEXT = "Loading RedControl..."
local sreenSizeX, screenSizeY = gpu.getResolution()

function unknownEvent()
    -- do nothing if the event wasn't relevant
end

-- table that holds all event handlers, and in case no match can be found returns the dummy function unknownEvent
local myEventHandlers = setmetatable({}, { __index = function() return unknownEvent end })

-- Example key-handler that simply sets running to false if the user hits space
function myEventHandlers.key_up(adress, char, code, playerName)
    if (char == char_space) then
        running = false
    end
end

function myEventHandlers.click(adress, screenX, screenY, playerName)
    if (char == char_space) then
        running = false
    end
end

-- The main event handler as function to separate eventID from the remaining arguments
function handleEvent(eventID, ...)
    if (eventID) then -- can be nil if no event was pulled for some time
    myEventHandlers[eventID](...) -- call the appropriate event handler with all remaining arguments
    end
end

function load()
    gpu.setBackground(background_primary)
    gpu.fill(1, 1, w, h, " ")
    term.setCursor((w/2 - WELCOME_TEXT.len), h/2);
    term.write(WELCOME_TEXT)
end

event.listen("key_up", handleEvent)

while running do
end