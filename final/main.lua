--[[
MmmPop: Created by Aaron Whitmer, Eric McDonald, and Corbin Troup. 2014
This game challenges players to pop off sets of colored marbles from the screen. The marbles will
drop in randomly and increase in speed as the player progresses. Larger sets of marbles yield higher scores.

The game uses the Corona Storyboard to handle the phases and scenes of the game. The main.lua file will
call the scene_splash file upon loading. The main logic of the game is located in bubble.lua.

The game should be compatible with iOS, Android (2.6 and up), Kindle Fire, and Nook. It has only been build
tested on Android.
--]]
 
-- Hide the iPhone status bar
display.setStatusBar( display.HiddenStatusBar ) 
local storyboard = require "storyboard"

-- go to splash menu
storyboard.gotoScene("scene_splash")

