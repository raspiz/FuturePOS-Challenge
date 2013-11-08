local physics = require("physics")
physics.start()
--display.setStatusBar(display.HiddenStatusBar)

local background = display.newImage ("m16.jpg", 0, 0, true)
background.x = display.contentWidth / 2 -- centers the image on xy axis
background.y = display.contentHeight / 2

--local floor = display.newImage ("floor.png", 0, 380, true)
--physics.addBody (floor, "static", {friction = 0.5 }) -- static means the object will interact with other objects but not be affected by inertial forces 

local gas = {}
for i = 1, 20 do
	for j = 1, 20 do
		startX = math.random(0, display.contentWidth) -- lower, upper parameters
		startY = math.random(0, display.contentHeight)
		
		gas[i] = display.newImage ("gas10.png", startX,startY)--300, 100)--, 140 + (i*50), 220 - (j*50) ) --filename, top, left
		--gas[i].x = display.contentWidth / 2
		--gas[i].y = display.contentHeight / 2
		physics.addBody( gas[i], {density=0.1, friction=0.1, bounce=0.5} )
		gas[i].gravityScale = 0--.25  -- sets gravity of object
		
		moveX = math.random(-25, 25) -- lower, upper parameters
		moveY = math.random(-25, 25)
		
		gas[i]:setLinearVelocity( moveX, moveY ) -- x,y parameters in pixels per second
		
		

	end	
end



