-- scene_menu.lua
 
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
 
  local levelsGrp = display.newGroup()
 
  -- add 3 levels
  for i=1, 3 do
 
    local loadButton = display.newText( "Load Level " .. i, 0, 0, globals.font.regular, 18 )
    loadButton.x = 0
    loadButton.y = 40 * i
 
    loadButton.levelNum = i
 
    loadButton:addEventListener( "tap", function( event )
        globals.levelNum = event.target.levelNum
        storyboard.gotoScene( "scene_game" )
    end )
 
    levelsGrp:insert( loadButton )
 
  end
 
  levelsGrp.x = display.contentCenterX
  levelsGrp.y = 180
 
  group:insert( levelsGrp )
 
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