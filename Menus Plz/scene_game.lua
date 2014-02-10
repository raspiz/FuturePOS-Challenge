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
local score = 0
local scoreText
local scoreForLevelComplete
 
local levelNum
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene.createDot()
 
  local dot = display.newCircle( 0, 0, 60 )
  dot.x = display.contentCenterX
  dot.y = display.contentCenterY
 
  function dot:tap( event )
 
    scene.updateScore()
 
    self.x = math.random( 60, display.contentWidth - 60 )
    self.y = math.random( 60, display.contentHeight - 60 )    
  end
  dot:addEventListener( "tap", dot )
 
  scene.view:insert( dot )
 
end
 
function scene.updateScore()
  score = score + 10
  scoreText.text = score
 
  if ( score >= scoreForLevelComplete ) then
    -- level over
    globals.score = score
    storyboard.gotoScene( "scene_results" )
  end
end
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
 
  levelNum = globals.levelNum
 
  scoreForLevelComplete = 50 * levelNum
 
  scoreText = display.newText( "0", 0, 0, globals.font.bold, 32 )
  scoreText.x = display.contentCenterX
  scoreText.y = 32
 
  group:insert( scoreText )
 
  self.createDot()
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