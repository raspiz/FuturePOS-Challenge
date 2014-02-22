--
--Splash screen for mmmPOP game.

local globals = require ("globals")
 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
-- Clear previous scene
storyboard.removeAll()
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
 
  local gameTitle = display.newImage("logo.png")
  gameTitle.x = display.contentCenterX
  gameTitle.y = 75
  
  gameTitle.width = display.contentWidth
 
  local startButton = display.newText( "Start", 0, 0, globals.font.regular, 28 )
  startButton.x = display.contentCenterX
  startButton.y = display.contentCenterY + 50
  
  local creditButton = display.newText( "Credits", 0, 0, globals.font.regular, 28 )
  creditButton.x = display.contentCenterX
  creditButton.y = display.contentCenterY +150
  
  local background = display.newRect(display.contentWidth/2,display.contentHeight/2, display.contentWidth, display.contentHeight)
  
  background:setFillColor(45/255, 49/255, 52/255)
  
   group:insert(background)
  group:insert(startButton)
  group:insert(creditButton)
  group:insert(gameTitle )

 
  local function onTap( event )
    storyboard.gotoScene( "bubble" )
  end
  startButton:addEventListener( "tap", onTap )
 
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