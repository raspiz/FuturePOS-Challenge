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



local function dropbub()

	local setX = math.random(0, 300) -- lower, upper parameters
	--local setY = math.random(-25, 25) -- lower, upper parameters
	
	local myCircle = display.newCircle( setX, 10, 10 ) --xloc, yloc, radius(size)
	myCircle:setFillColor( 0.5 )

	physics.addBody( myCircle, { density=1, friction=0, bounce=0 } )

	myCircle.gravityScale = .5


end

local tr = timer.performWithDelay (1000, dropbub, 100)	-- delay, function to call, iterations
