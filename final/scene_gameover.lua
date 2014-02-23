---------------------------------------------------------------------------------
-- mmmPop game over scene overlay
-- this overlay will be shown when the timer reaches 0
-- the player's score and level reached are output to the screen
-- the player then has the option to either go to the main menu or quit the game
---------------------------------------------------------------------------------
 
local globals = require( "globals" )
 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 

 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
  
  local gameTitle = display.newImage("logo.png")
  gameTitle.x = display.contentCenterX
  gameTitle.y = 75
  gameTitle.width = display.contentWidth
  
  local overlayBg = display.newRect(display.contentCenterX,  display.contentCenterY, display.contentWidth, display.contentHeight)
  overlayBg:setFillColor(45/255, 49/255, 52/255)
  
   --screen wide rectangle to prevent clicks onto game beneath
  local tapSponge = display.newRect(display.contentCenterX,display.contentCenterY, display.contentWidth, display.contentHeight)
  tapSponge.alpha = 0;
  tapSponge.isHitTestable = true
  tapSponge:addEventListener("tap", function() return true end)
  tapSponge:addEventListener("touch", function() return true end)
 
  local result = "Game Over\nYou made it to Level "..level.."\nScore: "..gameScore .." Points!"
 
  local resultsText = display.newText( result, 0, 0, globals.font.regular, 24 )
  resultsText.x = display.contentCenterX
  resultsText.y = display.contentCenterY - 40
 
  local mainMenuButton = display.newText( "Main Menu", 0, 0, globals.font.regular, 22 )
  mainMenuButton.x = display.contentCenterX
  mainMenuButton.y = display.contentCenterY + 50
  mainMenuButton:setFillColor(45/255, 49/255, 52/255)  
  
  local mainMenuBar = display.newRect(display.contentCenterX, display.contentCenterY + 50, 110, 30)
  mainMenuBar:setFillColor(1, 1, 1)
  
  local quitBar = display.newRect(display.contentCenterX, display.contentCenterY + 150, 110, 30)
  quitBar:setFillColor(1, 1, 1)  
  
  local quitButton = display.newText( "Quit Game", 0, 0, globals.font.regular, 22 )
  quitButton.x = display.contentCenterX
  quitButton.y = display.contentCenterY +150
  quitButton:setFillColor(45/255, 49/255, 52/255)
 
  local function Restart( event )
	restart = true
    storyboard.gotoScene( "scene_splash" )
  end
  
  local function QuitGame(event)
	os.exit()
  end

  mainMenuButton:addEventListener("tap", Restart)
  quitButton:addEventListener("tap", QuitGame)
 
  group:insert(tapSponge)
  group:insert(overlayBg)
  group:insert(mainMenuBar)
  group:insert(mainMenuButton)
  group:insert(quitBar)
  group:insert(quitButton)
  group:insert(resultsText)
  group:insert(gameTitle)   
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