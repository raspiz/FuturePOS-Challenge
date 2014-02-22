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
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
  
  local overlayBg = display.newRect(display.contentCenterX,  display.contentCenterY, display.contentWidth /1.2, display.contentHeight/1.75)
  overlayBg:setFillColor(1,.5,.2)
  
  local overlayText = display.newText( "Game is paused", 0, 0, globals.font.bold, 25 )
  overlayText.x = display.contentCenterX
  overlayText.y = display.contentCenterY - 120
  
  --screen wide rectangle to prevent clicks onto game beneath
  local tapSponge = display.newRect(display.contentWidth/2,display.contentHeight/2, display.contentWidth, display.contentHeight)
  tapSponge.alpha = 0;
  tapSponge.isHitTestable = true
  tapSponge:addEventListener("tap", function() return true end)
  tapSponge:addEventListener("touch", function() return true end)
  
  local volumeLbl = display.newText("Volume (1-10)", 0,0, globals.font.regular, 18)
  volumeLbl.x = display.contentCenterX
  volumeLbl.y = display.contentCenterY - 70
  
  local gameVolumeString
  if(gameVolume < 0.1) then
  gameVolumeString = "0"
  else
  gameVolumeString = gameVolume*10
  end
  
	local volumeValue = display.newText(gameVolumeString, 0,0, globals.font.regular, 30)
	volumeValue.x = display.contentCenterX
	volumeValue.y = display.contentCenterY - 40

	volUpUp = display.newImage("volupup.png")
	volUpUp.x = display.contentCenterX + 40
	volUpUp.y = display.contentCenterY - 40

	volUpDown = display.newImage("volupdown.png")
	volUpDown.x = display.contentCenterX + 40
	volUpDown.y = display.contentCenterY - 40
	volUpDown.isVisible = false

	volDownUp = display.newImage("voldownup.png")
	volDownUp.x = display.contentCenterX - 40
	volDownUp.y = display.contentCenterY - 40


	volDownDown = display.newImage("voldowndown.png")
	volDownDown.x = display.contentCenterX - 40
	volDownDown.y = display.contentCenterY - 40
	volDownDown.isVisible = false

	local closeButton = display.newText("Resume", 0,0, globals.font.regular, 18)
	closeButton.x = display.contentCenterX
	closeButton.y = display.contentCenterY + 120
	
	local restartButton = display.newText("Restart", 0,0, globals.font.regular, 18)
	restartButton.x = display.contentCenterX
	restartButton.y = display.contentCenterY + 70
  
  
  --up volume listener
  local function VolumeUp(event)
	   -- volume up
		if (gameVolume <= 0.9) then
			gameVolume = gameVolume + 0.1
			audio.setVolume(gameVolume)
			volUpUp.isVisible = false
			volUpDown.isVisible = true
			volumeValue.text = ""..(gameVolume * 10)
			
			local function buttonSwap()
				volUpUp.isVisible = true
				volUpDown.isVisible = false
			end

			buttonSwitch = timer.performWithDelay(35, buttonSwap)
	    end
end

local function VolumeDown(event)
	    if (gameVolume >= 0.1) then
		
		
			gameVolume = gameVolume - 0.1
			
			audio.setVolume(gameVolume)
			volDownUp.isVisible = false
			volDownDown.isVisible = true
			if(gameVolume < 0.1) then
			volumeValue.text = "0"
			else
			volumeValue.text = ""..(gameVolume * 10)
			end
			
			local function buttonSwap()
				volDownUp.isVisible = true
				volDownDown.isVisible = false
			end

			buttonSwitch = timer.performWithDelay(35, buttonSwap)
		end
end

local function Restart(event)
	storyboard.gotoScene("scene_splash")
end
  
  --make listener for overlay menu
	local function onTap( event )
    storyboard.hideOverlay()
	end
	
	--add the listener
	closeButton:addEventListener("tap", onTap)
	volUpUp:addEventListener("tap", VolumeUp)
	volDownUp:addEventListener("tap", VolumeDown)
	restartButton:addEventListener("tap", Restart)
  
  group:insert(tapSponge)
  group:insert(overlayBg)
  group:insert(overlayText)
  group:insert(volumeLbl)
  group:insert(volumeValue)
  group:insert(volUpUp)
  group:insert(volUpDown)
  group:insert(volDownDown)
  group:insert(volDownUp)
  group:insert(closeButton)
  group:insert(restartButton)
  
 
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