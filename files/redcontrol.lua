--
-- Created by IntelliJ IDEA.
-- User: yanni
-- Date: 02.04.2016
-- Time: 02:16
-- To change this template use File | Settings | File Templates.
--
local component = require("component")
local term = require("term")
local event = require "event" -- load event table and store the pointer to it in event

local gpu = component.gpu -- get primary gpu component
local screen = component.screen
screen.setTouchModeInverted(true)
gpu.setResolution(80,40)

local char_space = string.byte(" ") -- numerical representation of the space char

local foreground_primary  = 0xFFFFFF
local foreground_disabled = 0xDDDDDD
local background_primary  = 0x333366
local background_disabled = 0x777777

local tab_width = 0.2

local running = true -- state variable so the loop can terminate
local WELCOME_TEXT = "Loading RedControl..."
local screenSizeX, screenSizeY = gpu.getResolution()

local currentTab = 0

local data = {
    tabs = {
        ME = {
            id = 0,
            tabname = "ME",
            active = true
        },
        Strom = {
            id = 1,
            tabname = "Strom",
            active = false
        }
    }
}

function unknownEvent()
    -- do nothing if the event wasn't relevant
end

-- table that holds all event handlers, and in case no match can be found returns the dummy function unknownEvent
local myEventHandlers = setmetatable({}, { __index = function() return unknownEvent end })
local myTabs = setmetatable({})
local myTabNames = {"ME", "Strom"}

-- Example key-handler that simply sets running to false if the user hits space
function myEventHandlers.key_up(adress, char, code, playerName)
    if (char == char_space) then
        running = false
    end
end

function writeCenteredText(text, y)
    term.setCursor((screenSizeX/2) - (string.len(text)/2), screenSizeY/2);
    term.write(text)
end

function load()
    gpu.setBackground(background_primary)
    gpu.fill(1, 1, screenSizeX, screenSizeY, " ")
    writeCenteredText(WELCOME_TEXT, screenSizeY/2)
end

function drawTab(tab)
    print(tab)
    tab_posY = tab["id"]*3 + 1
    if tab["active"] then
        gpu.setBackground(background_primary)
        gpu.setForeground(foreground_primary)
    else
        gpu.setBackground(background_disabled)
        gpu.setForeground(foreground_disabled)
    end
    gpu.fill(1,tab_posY,screenSizeX*tab_width,3," ")
    term.setCursor(2,tab_posY + 1)
    term.write(tab["tabname"])
end

function handleTabTouchSel(tab, touch_posY)
    tab_posY = tab["id"]*3 + 1
    if touch_posY <= tab_posY+3 and touch_posY >= tab_posY then
        currentTab = tab["id"]
        tab["active"] = true
    end
end

function myEventHandlers.touch(adress, screenX, screenY, playerName)
    if screenX <= screenSizeX*tab_width then
        for i, v in ipairs(data["tabs"]) do
            handleTabTouchSel(v, screenY)
        end
    end
end

-- The main event handler as function to separate eventID from the remaining arguments
function handleEvent(eventID, ...)
    if (eventID) then -- can be nil if no event was pulled for some time
    myEventHandlers[eventID](...) -- call the appropriate event handler with all remaining arguments
    end
end

function update()
    gpu.setBackground(background_disabled)
    gpu.fill(1, 1, screenSizeX, screenSizeY, " ")
    for i, v in ipairs(data["tabs"]) do
        print(i..": "..v)
        drawTab(v)
    end
end

load()

while running do
    handleEvent(event.pull(1))
    update()
end