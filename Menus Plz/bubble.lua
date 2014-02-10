---------------------------------------------------------------------------------
-- SCENE NAME
-- Scene notes go here
---------------------------------------------------------------------------------
 
 --globals
 local globals = require ("globals")
 
local storyboard = require( "storyboard" )

local physics = require ( "physics" )
physics.start()

local scene = storyboard.newScene()
 
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
  
	--create the objects  
	local bottom = display.newImage("stones.png")
	local leftSide = display.newImage("wall1.png")
	local rightSide = display.newImage("wall2.png")
	local bg = display.newImage("bg.png")

	--give them a location on screen
	bg.x = 200; bg.y = 150;
	rightSide.x = 320; rightSide.y = 20;
	leftSide.x = 0; leftSide.y = 5;
	bottom.x = 100; bottom.y = 500;

	--make listener for overlay menu
	local function onTap( event )
    storyboard.showOverlay("scene_overlay")
	end
	
	--add the listener
	bottom:addEventListener("tap", onTap)
	
	--insert them into the scene
	group:insert(leftSide)
	group:insert(rightSide)
	group:insert(bg)
	group:insert(bottom)
	
	--add them to physics
	physics.addBody( bottom, "static", {friction = 0, bounce = 0})
	physics.addBody( leftSide, "static", {friction = 0, bounce = 0})
	physics.addBody( rightSide, "static",{friction = 0, bounce =0})

	--make 42 bubbles
	for i=1,42,2 do
	local rbub = display.newImage( "rbub.png", 150, 10 )
	local ybub = display.newImage( "ybub.png", 150, 10 )
	local gbub = display.newImage( "gbub.png", 150, 10 )
	local bbub = display.newImage( "bbub.png", 150, 10 )

	--add them to physics
	physics.addBody( rbub, { density=1, friction=0, bounce=0 } )
	physics.addBody( ybub, { density=1, friction=0, bounce=0 })
	physics.addBody( gbub, { density=1, friction=0, bounce=0 })
	physics.addBody( bbub, { density=1, friction=0, bounce=0 })

	--insert them into scene
	group:insert(rbub)
	group:insert(ybub)
	group:insert(gbub)
	group:insert(bbub)

	 
	end

end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  local group = self.view
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  local group = self.view
 
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
 
end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  local group = self.view
 
end
 
-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  local group = self.view
 
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene
