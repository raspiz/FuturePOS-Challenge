--Splash screen for mmmPOP game.
-- this screen will appear when the player loads the game with options to start game or view credits

local globals = require ("globals")
 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
-- Clear previous scene
storyboard.removeAll()
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
 
  local gameTitle = display.newImage("logo.png")
  gameTitle.x = display.contentCenterX
  gameTitle.y = 75  
  gameTitle.width = display.contentWidth
  
  local title = display.newText("mmmPop - 2014 Golden Eagles", 0, 0, globals.font.regular, 20)
  title.x = display.contentCenterX
  title.y = display.contentCenterY - 85
  title:setFillColor(1, 1, 1)
 
  local startBar = display.newRect(display.contentCenterX, display.contentCenterY + 50, 110, 30)
  startBar:setFillColor(1, 1, 1)
  
  local startButton = display.newText( "Start", 0, 0, globals.font.regular, 28 )
  startButton.x = display.contentCenterX
  startButton.y = display.contentCenterY + 50
  startButton:setFillColor(45/255, 49/255, 52/255)
  
  local creditBar = display.newRect(display.contentCenterX, display.contentCenterY + 150, 110, 30)
  creditBar:setFillColor(1, 1, 1)  
  
  local creditButton = display.newText( "Credits", 0, 0, globals.font.regular, 28 )
  creditButton.x = display.contentCenterX
  creditButton.y = display.contentCenterY +150
  creditButton:setFillColor(45/255, 49/255, 52/255)
  
  local background = display.newRect(display.contentWidth/2,display.contentHeight/2, display.contentWidth, display.contentHeight)
  
  background:setFillColor(45/255, 49/255, 52/255)
  
  group:insert(background)
  group:insert(startButton)
  group:insert(creditButton)
  group:insert(gameTitle)
  group:insert(title)
  group:insert(startBar)
  group:insert(creditBar)

  startButton:toFront()
  creditButton:toFront()
 
  local function onTap( event )
    storyboard.gotoScene( "bubble" )
  end
  
  startButton:addEventListener( "tap", onTap )
  
  local function ViewCredits( event )
    storyboard.gotoScene( "scene_credits" )
  end
  
  creditButton:addEventListener( "tap", ViewCredits )
 
end
 
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