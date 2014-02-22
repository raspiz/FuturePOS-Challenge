
-- volume
local gameVolume = audio.getVolume()

--audio.setVolume(.25)

local function VolumeUp(event)
	if (event.phase == "began") then
	   -- volume up
		if (gameVolume <= 0.9) then
			gameVolume = gameVolume + 0.1
			audio.setVolume(gameVolume)
			-- image
	    end
	elseif (event.phase == "ended")
		--image
	end	
end

local function VolumeDown(event)
	if (event.phase == "began") then
	   -- volume down
	    if (gameVolume >= 0.1) then
			gameVolume = gameVolume - 0.1
			audio.setVolume(gameVolume)
			-- image
	    end
	elseif (event.phase == "ended")
		--image	
	end	
end

local function MuteSound(event)
	if (event.phase == "began") then
		if (mute == false) then
			mute = true
			bgMusic()
		else
			mute = false
			bgMusic()
		end
	end
end

-- listener
volUp = display.newImage("")
volDown = display.newImage("")
volUp:addEventListener("touch", VolumeUp)
volDown:addEventListener("touch", VolumeDown)










