---------------------------------------------------------------------------------
-- SCENE NAME
-- Scene notes go here
---------------------------------------------------------------------------------
 
local globals = require( "globals" )
 
local storyboard = require( "storyboard" )
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
 
  local score = globals.score
 
  local result = "New high score:\n" .. score .." Points!"
 
  local resultsText = display.newText( result, 0, 0, globals.font.regular, 32 )
  resultsText.x = display.contentCenterX
  resultsText.y = display.contentCenterY - 60
 
  group:insert( resultsText )
 
  local mainMenuButton = display.newText( "Main Menu", 0, 0, globals.font.regular, 18 )
  mainMenuButton.x = display.contentCenterX
  mainMenuButton.y = display.contentCenterY + 60
 
  local function onTap( event )
    storyboard.gotoScene( "scene_menu" )
  end
  mainMenuButton:addEventListener( "tap", onTap )
 
  group:insert( mainMenuButton )
 
  -- Check next level
  local levelNum = globals.levelNum
 
  levelNum = levelNum + 1
 
  if ( levelNum <= 3 ) then
    local nextLevelButton = display.newText( "Play Level " .. levelNum, 0, 0, globals.font.regular, 18 )
    nextLevelButton.x = display.contentCenterX
    nextLevelButton.y = display.contentCenterY + 100
 
    local function onTap( event )
      globals.levelNum = levelNum
      storyboard.gotoScene( "scene_game" )
    end
    nextLevelButton:addEventListener( "tap", onTap )
 
    group:insert( nextLevelButton )
  end
 
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