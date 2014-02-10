-- main.lua
 
-- Hide the iPhone status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Add a global background
local bg = display.newRect( display.screenOriginX,
                            display.screenOriginY, 
                            display.pixelWidth, 
                            display.pixelHeight)
 
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor( 137/255, 168/255, 254/255 )
 
-- Initialize our global variables
local globals = require( "globals" )
globals.levelNum = 1
globals.score = 0
 

local storyboard = require "storyboard"

-- go to splash menu
storyboard.gotoScene("scene_splash")


-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):