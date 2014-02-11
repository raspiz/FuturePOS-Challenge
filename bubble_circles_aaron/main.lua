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

-- array for bubble objects and array counter. this will be incremented as new bubbles are added
local marble = {}
local marbCount = 0






local function DropMarble() -- initially fill the screen with bubbles based on the timer tr	

	marbCount = marbCount + 1
	
	local setX = math.random(0, 300) -- lower, upper parameters
	--local setY = math.random(-25, 25) -- lower, upper parameters
	
	--MakeMarble(setX)
	marble[marbCount] = display.newCircle( setX, 10, 19 ) --xloc, yloc, radius(size)
	
	marble[marbCount].name = marbCount
	
	local bubColor = math.random(0, 3)-- will assign one of four colors to each bubble

	--marble[marbCount].fill = { type="image", filename="bbub3.png" }
	
	if (bubColor == 0) then
		marble[marbCount].color = "blue"
		marble[marbCount].fill = { type="image", filename="bBub.png" }
	elseif (bubColor == 1) then
		marble[marbCount].color = "green"
		marble[marbCount].fill = { type="image", filename="gBub.png" }
	elseif (bubColor == 2) then
		marble[marbCount].color = "red"
		marble[marbCount].fill = { type="image", filename="rBub.png" }
	else-- (bubColor == 3) then
		marble[marbCount].color = "orange"
		marble[marbCount].fill = { type="image", filename="oBub.png" }
	end
		
	physics.addBody( marble[marbCount], { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better
	marble[marbCount].gravityScale = .5 -- they settle properly at .25 gravity

	marble[marbCount].touch = MatchMarbles
	marble[marbCount]:addEventListener("touch", marble[marbCount])

	--print (marble[marbCount].name)
	-- if ("blue" == "blue") then
		-- print("true")
	-- else
		-- print("false")
	-- end
	
	
	print(marbCount)
end

local tr = timer.performWithDelay (10, DropMarble, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100
