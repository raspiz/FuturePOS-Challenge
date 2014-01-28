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




local function PopBubble(event) -- user touches screen to try to pop a bubble
	
	if (event.phase == "began") then
		event.target:setFillColor(255,255,255) -- turns the touched bubble white
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




local function DropBubble() -- initially fill the screen with bubbles based on the timer tr
    --print (number)
	
	local setX = math.random(0, 300) -- lower, upper parameters
	--local setY = math.random(-25, 25) -- lower, upper parameters
	
	local bubble = display.newCircle( setX, 10, 15 ) --xloc, yloc, radius(size)

	local bubColor = math.random(0, 3)-- will assign one of four colors to each bubble


	
	
	if (bubColor == 0) then
		bubble:setFillColor(0, 0, 255)
		bubble.color = "blue"
	elseif (bubColor == 1) then
		bubble:setFillColor(0, 255, 0)
		bubble.color = "green"
	elseif (bubColor == 2) then
		bubble:setFillColor(255, 0, 0)
		bubble.color = "red"
	else-- (bubColor == 3) then
		bubble:setFillColor(237, 181, 28)	
		bubble.color = "orange"
	end
	
	
	--bubble.fill = { type="image", filename="bbub.png" }
	
	physics.addBody( bubble, { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better

	bubble.gravityScale = .25 -- they settle properly at .25 gravity

	bubble:addEventListener("touch", PopBubble)
	
	--bubble:addEventListener("collision", bubble)
	
	--bubble:addEventListener("accelerometer", onShake)
	
end


--function bubble:Collision(event)



--end









local tr = timer.performWithDelay (500, DropBubble, 100)	-- delay, function to call, iterations







