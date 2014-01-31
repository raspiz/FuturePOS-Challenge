local physics = require ( "physics" )
physics.start()

local bottom = display.newImage("stones.png")
local leftSide = display.newImage("wall1.png")
local rightSide = display.newImage("wall2.png")
local bg = display.newImage("bg.png")

bg.x = 200; bg.y = 150;
rightSide.x = 320; rightSide.y = 20;
leftSide.x = 0; leftSide.y = 5;
bottom.x = 100; bottom.y = 500;
physics.addBody( bottom, "static", {friction = 0, bounce = 0})
physics.addBody( leftSide, "static", {friction = 0, bounce = 0})
physics.addBody( rightSide, "static",{fricion = 0, bounce =0})



--totalWidth = display.contentWidth -- width of screen
--bubSize = totalWidth / 20


for i=1,100 do
-- local rbub = display.newImage( "rbub.png", 150, 10 )
-- local ybub = display.newImage( "ybub.png", 150, 10 )
-- local gbub = display.newImage( "gbub.png", 150, 10 )
-- local bbub = display.newImage( "bbub.png", 150, 10 )

-- local myCircle = display.newCircle( 100, 100, 10 )
-- myCircle:setFillColor( 0.5 )

-- physics.addBody( myCircle, { density=1, friction=1, bounce=0 } )

-- myCircle.gravityScale = .5

-- physics.addBody( rbub, { density=1, friction=0, bounce=0 } )
-- physics.addBody( ybub, { density=1, friction=0, bounce=0 })
-- physics.addBody( gbub, { density=1, friction=0, bounce=0 })
-- physics.addBody( bbub, { density=1, friction=0, bounce=0 })

end

local bubble = {}
local bubCount = 1

local function PopBubble(self, event) -- user touches screen to try to pop a bubble
	
	if (event.phase == "began") then
	
		
		touchX = event.x
		touchY = event.y
		
	
		--local myTextObject = display.newText( touchX.." "..touchY.." "..self.name, touchX, touchY, "Arial", 20 )
		
		
		for i=1, bubCount do
			
			--local myTextObject = display.newText( touchX.." "..touchY.." "..bubble[bubCount].name, touchX, touchY, "Arial", 20 )
			
			 if (bubble[bubCount].color == self.color) then--self.color) then
				-- if (bubble[bubCount].name ~= self.name) then
					
				
				-- end
			
			
			
			
			 end
			
			-- skip self
			-- skip other colors
			-- skip same color if over 50px away on x or y access
		
			
		-- run through array and check to see if bubbles are close using distance formula
		-- ignore self
		-- keep track of bubbles that are within distance
			-- iterate through the rest of the bubbles that are within
			
		-- if there is a deletion, delete bubbles that are touching, reassign remaining bubbles to a new
		-- array and make the values of the original array nil so that once loop is complete, original array is gone
		
		
		
		end
		
		
		-- check to see if contacting other bubbles of the same color
			-- if touching bubble of same color, have that bubble also do a check
				-- and etc
				
		-- if 3 or more bubbles of the same color are touching, destroy the bubbles
	end


end


-- local function onShake (event)
	-- if event.isShake then
	--Device was shaken, so do something.
	-- bubble.gravityScale = -0.5
	-- end
-- end

-- local function theyHit(self, event)
	-- if event.phase == "began" then
		-- textX = math.random(0, display.contentWidth) -- lower, upper parameters
		-- textY = math.random(0, display.contentHeight)
		
		-- physics.setGravity( -5, -5 )
		
		-- event.target.setGravity(5, 5)
		
		-- refer to the object that has been touched		
		-- event.target.gravityScale = 1
		
		-- return location of touch event
		-- touchX = event.x
		-- touchY = event.y
		
	
		-- local myTextObject = display.newText( touchX.." "..touchY, textX, textY, "Arial", 20 )
	
	-- end



-- end



-- array for bubble objects and array counter. this will be incremented as new bubbles are added



local function DropBubble() -- initially fill the screen with bubbles based on the timer tr
 
	

	
	local setX = math.random(0, 300) -- lower, upper parameters
	--local setY = math.random(-25, 25) -- lower, upper parameters
	
	bubble[bubCount] = display.newCircle( setX, 10, 19 ) --xloc, yloc, radius(size)
	--bubble[bubCount] = display.newImage( "bbub3.png", setX, 10 )
	
	bubble[bubCount].name = "bubble"..bubCount

	
	local bubColor = math.random(0, 3)-- will assign one of four colors to each bubble

	--bubble[bubCount]:setFillColor(0, 0, 255)
	bubble[bubCount].fill = { type="image", filename="bbub3.png" }
	
	--bubble[bubCount].strokeWidth = 2
	--bubble[bubCount].stroke = { 0.6, 0.08, 0.16 }
	
	-- local testArray = {}
	-- testArray[1] = 5
	-- testArray[2] = "Steve"
	-- testArray["Bill"] = 0.5
	
	
	if (bubColor == 0) then
		--bubble:setFillColor(0, 0, 255)
		bubble[bubCount].color = "blue"
	elseif (bubColor == 1) then
		--bubble:setFillColor(0, 255, 0)
		bubble[bubCount].color = "green"
	elseif (bubColor == 2) then
		--bubble:setFillColor(255, 0, 0)
		bubble[bubCount].color = "red"
	else-- (bubColor == 3) then
		--bubble:setFillColor(237, 181, 28)	
		bubble[bubCount].color = "orange"
	end
	
	
	
	
	physics.addBody( bubble[bubCount], { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better

	bubble[bubCount].gravityScale = .5 -- they settle properly at .25 gravity

	bubble[bubCount].touch = PopBubble
	bubble[bubCount]:addEventListener("touch", bubble[bubCount])
	
	--bubble[bubCount]:addEventListener("touch", PopBubble)
	
	--bubble[bubCount].collision = theyHit
	--bubble[bubCount]:addEventListener("collision", bubble[bubCount])
	

	--bubble:addEventListener("accelerometer", onShake)
	
	bubCount = bubCount + 1
	print (bubCount)
	
end


--function bubble:Collision(event)



--end



local tr = timer.performWithDelay (500, DropBubble, 100)	-- delay, function to call, iterations







