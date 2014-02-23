---------------------------------------------------------------------------------
-- SCENE NAME
-- Scene notes go here
---------------------------------------------------------------------------------
 
 --globals
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
  
  local aaron = display.newText("Aaron Whitmer:", 0, 0, globals.font.regular, 24)
  aaron.x = display.contentCenterX
  aaron.y = display.contentCenterY - 50
  aaron:setFillColor(.8, .3, .3)
  
  local aaronJob = display.newText("Project lead, game logic programming", 0, 0, globals.font.regular, 14)
  aaronJob.x = display.contentCenterX
  aaronJob.y = display.contentCenterY - 30
  aaronJob:setFillColor(1, 1, 1)
  
  local eric = display.newText("Eric McDonald:", 0, 0, globals.font.regular, 24)
  eric.x = display.contentCenterX
  eric.y = display.contentCenterY
  eric:setFillColor(.3, .5, .8)
    
  local ericJob = display.newText("Concept, design, graphics, UI, programming", 0, 0, globals.font.regular, 14)
  ericJob.x = display.contentCenterX
  ericJob.y = display.contentCenterY + 20
  ericJob:setFillColor(1, 1, 1)
  
  local corbin = display.newText("Corbin Troup:", 0, 0, globals.font.regular, 24)
  corbin.x = display.contentCenterX
  corbin.y = display.contentCenterY + 50
  corbin:setFillColor(.3, .8, .3)
    
  local corbinJob = display.newText("Storyboard implementation, graphics, programming", 0, 0, globals.font.regular, 14)
  corbinJob.x = display.contentCenterX
  corbinJob.y = display.contentCenterY + 70
  corbinJob:setFillColor(1, 1, 1)
 
  local soundCredits = display.newText("Sound Credits:\nlevelup.wav -- Author: sepal\ngame over.wav -- Author: fins\nBeeping.wav -- Author: 0maukka\nWebsite: freesound.org\n\nPangaea -- Author: Kevin MacLeod\nWebsite: http://incompetech.com\n\nMario Jumping Sound  -- Author: Mike Koenig\nShooting Star Sound  -- Author: Mike Koenig\nBlop Sound -- Author: Mark DiAngelo\nWebsite: http://soundbible.com\n\nAll sounds used under\nCreative Commons Attribution 3.0 or 0 usage", 0, 0, globals.font.regular, 12)
  soundCredits.x = display.contentCenterX
  soundCredits.y = display.contentCenterY + 20
  soundCredits:setFillColor(1, 1, 1) 
 
  local menuBar = display.newRect(display.contentCenterX, display.contentCenterY + 210, 110, 30)
  menuBar:setFillColor(1, 1, 1)  
  
  local menuButton = display.newText( "Main Menu", 0, 0, globals.font.regular, 22 )
  menuButton.x = display.contentCenterX
  menuButton.y = display.contentCenterY + 210
  menuButton:setFillColor(45/255, 49/255, 52/255)
  
  local creditsBar = display.newRect(display.contentCenterX, display.contentCenterY + 150, 110, 30)
  creditsBar:setFillColor(1, 1, 1)  
  
  local gameCreditsButton = display.newText( "Game Credits", 0, 0, globals.font.regular, 16 )
  gameCreditsButton.x = display.contentCenterX
  gameCreditsButton.y = display.contentCenterY +150
  gameCreditsButton:setFillColor(45/255, 49/255, 52/255)
  
  local soundCreditsButton = display.newText( "Sound Credits", 0, 0, globals.font.regular, 16 )
  soundCreditsButton.x = display.contentCenterX
  soundCreditsButton.y = display.contentCenterY +150
  soundCreditsButton:setFillColor(45/255, 49/255, 52/255)
  
  local background = display.newRect(display.contentWidth/2,display.contentHeight/2, display.contentWidth, display.contentHeight)
  
  background:setFillColor(45/255, 49/255, 52/255)
  
  group:insert(background)
  group:insert(menuBar) 
  group:insert(menuButton)
  group:insert(creditsBar)
  group:insert(gameCreditsButton)
  group:insert(soundCreditsButton)
  group:insert(gameTitle)
  group:insert(title)
  group:insert(aaron)
  group:insert(aaronJob)
  group:insert(eric)
  group:insert(ericJob)
  group:insert(corbin)
  group:insert(corbinJob)
  group:insert(soundCredits)
  
  local function ToMenu( event )
    storyboard.gotoScene( "scene_splash" )
  end
  
  menuButton:addEventListener( "tap", ToMenu )
  
  local function ShowCredits( event )
    gameCreditsButton.isVisible = true
	soundCreditsButton.isVisible = false
	soundCredits.isVisible = true
	aaron.isVisible = false
	aaronJob.isVisible = false
	eric.isVisible = false
	ericJob.isVisible = false
	corbin.isVisible = false
	corbinJob.isVisible = false
  end
  
  soundCreditsButton:addEventListener( "tap", ShowCredits )
  
  local function ShowSoundCredits( event )
    soundCreditsButton.isVisible = true
	gameCreditsButton.isVisible = false
	soundCredits.isVisible = false	
	aaron.isVisible = true
	aaronJob.isVisible = true
	eric.isVisible = true
	ericJob.isVisible = true
	corbin.isVisible = true
	corbinJob.isVisible = true
  end
  
  gameCreditsButton:addEventListener( "tap", ShowSoundCredits )
  
  gameCreditsButton.isVisible = false
  soundCredits.isVisible = false
  
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