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


for i=1,42,2 do
local rbub = display.newImage( "rbub.png", 150, 10 )
local ybub = display.newImage( "ybub.png", 150, 10 )
local gbub = display.newImage( "gbub.png", 150, 10 )
local bbub = display.newImage( "bbub.png", 150, 10 )

physics.addBody( rbub, { density=1, friction=0, bounce=0 } )
physics.addBody( ybub, { density=1, friction=0, bounce=0 })
physics.addBody( gbub, { density=1, friction=0, bounce=0 })
physics.addBody( bbub, { density=1, friction=0, bounce=0 })

end