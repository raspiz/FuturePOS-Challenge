local physics = require("physics")
physics.start()
display.setStatusBar(display.HiddenStatusBar)

local background = display.newImage ("bricks.png", 0, 0, true)
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2

local floor = display.newImage ("floor.png", 0, 280, true)
physics.addBody (floor, "static", {friction = 0.5 }) -- static means the object will interact with other objects but not be affected by inertial forces 

local crates = {}
for i = 1, 5 do
	for j = 1, 5 do
		crates[i] = display.newImage ("crate.png", 140 + (i*50), 220 - (j*50) )
		physics.addBody( crates[i], {density=0.2, friction=0.1, bounce=0.5} )
	end
end