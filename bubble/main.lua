local physics = require ( "physics" )
physics.start()
physics.setScale( 30 ) -- scale of the objects may need to change or remove this

local bottom = display.newImage("stones.png")
local leftSide = display.newImage("wall1.png")
local rightSide = display.newImage("wall2.png")
local bg = display.newImage("bg.png")
local bar = display.newImage("bar.png")
local pauseBtn = display.newImage("pauseBtn.png")


bg.x = 160; bg.y = 240;
rightSide.x = 318; rightSide.y = 20;
leftSide.x = 2; leftSide.y = 20;
bottom.x = 100; bottom.y = 500;
bottom:toFront()
bar.x = 100; bar.y = -20;
pauseBtn.x = 145; pauseBtn.y = -20;

physics.addBody( bottom, "static", {friction = 0, bounce = 0})
physics.addBody( leftSide, "static", {friction = 0, bounce = 0})
physics.addBody( rightSide, "static",{friction = 0, bounce =0})

-- array for bubble objects and array counter. this will be incremented as new bubbles are added
local marble = {}
local marbCount = 0
local setX = 40
local xUp = true

local levelBeat = false
local gameOn = false
local mute = false

local gameScore = 0

-- game parameters
local level = 1
local scoreToBeat = 500--1000
--local timeToBeat = 3000
local timeToBeat = 3000
local timeLeft = timeToBeat
local dropSpeed = 1000	
local marbleColors = 3

local blopSound = audio.loadSound("blop.mp3")
local dropSound = audio.loadSound("drop.mp3")
local winSound = audio.loadSound("win.mp3")
local twinkleSound = audio.loadSound("twinkle.mp3")
local backGroundMusic
local sdtrk = audio.loadStream("Pamgaea.mp3")


local function bgMusic()
	if(mute == false)then
		backGroundMusic = audio.play( sdtrk, {channel= 1, loops = -1 }  )
	else
		audio.pause(1)
	end
end

local function onLocalCollision( self, event )
    if ( event.phase == "began" and self.name == "circle" ) then
        local forcex = event.other.x-self.x
        local forcey = event.other.y-self.y
        if(forcex < 0) then
            forcex = 0-(80 + forcex)-12
        else
            forcex = 80 - forcex+12
        end
        event.other:applyForce( forcex, forcey, self.x, self.y )
		
		if(math.abs(forcex) > 60 or math.abs(forcey) > 60) then
			--local explosion = display.newImage( "explosion.png", event.other.x, event.other.y )
			event.other:removeSelf()
			print(event.other.name)
			--need to change this to make sure to remove them from the marble array
			local function removeExplosion( event )
				--explosion:removeSelf()
			end

			timer.performWithDelay( 50,  removeExplosion)
		end
		
		
		
    end
end


 
local function setBomb ( event )
    if(event.phase == "began") then
	--print("hello")
	
		local circle = ""--nil	
		local name = "circle"
		
		local blastX = event.target.x
		local blastY = event.target.y
	
		local function blast(event)
			--sound event
			-- can put explosion picture in too
			circle = display.newCircle( blastX, blastY, 80 )			
			circle.name = name
			circle:setFillColor(255,0,0, .5) -- make this invisible (0,0,0,0)
			physics.addBody( circle, "static", {isSensor = true} )
			circle.collision = onLocalCollision
			circle:addEventListener( "collision", circle )			
		end
	
		local function removeStuff(event)
			circle:removeSelf()
		end

        timer.performWithDelay(50, blast )
        timer.performWithDelay(110, removeStuff)

    end
        --if(event.phase == "ended") then
        --circle:removeSelf()
    --end
end
 
local function TouchCheck (marbNum, count)
	for j = 1, marbCount do	
		if (marble[j].color == marble[marbNum].color and marble[j].checked == false and marble[j].match == false) then -- checked good
			if (j ~= marbNum) then -- not self				
				local distX = marble[marbNum].x - marble[j].x
				local distY = marble[marbNum].y - marble[j].y				
				local distance = math.sqrt(distX * distX + distY * distY)
				
				if (distance <= 50) then--<= size) then				
					marble[j].match = true
					count = count + 1				
				end	
			end
		end		
	end
	
	return count	
end

local function MatchMarbles(event) -- user touches screen to try to pop a bubble	
	if (event.phase == "began") then	
		--print("this marble is"..event.target.name)
		local touchCount = 1
		local deleted = 1		
		local num = event.target.name
		
		--print("my name is "..event.target.name)
		event.target.match = true
		event.target.checked = true
		
		touchCount = TouchCheck(num, touchCount)

		if (touchCount > 1) then
			local loopDone = false
			while (loopDone == false) do
				loopDone = true
				
				for i = 1, marbCount do
					if (marble[i].match == true and marble[i].checked == false) then
						touchCount = TouchCheck(i, touchCount)
						marble[i].checked = true
						loopDone = false			
					end		
				end		
			end
		end
		
		-- deletion
		if (touchCount >= 3) then
			audio.play(blopSound)
			for i = 1, marbCount do			
				--print(marble[i].match)
				if (marble[i].match) then --and touchCount > 1) then
					if (i == num) then						
						event.target:removeSelf()
						marble[num] = nil
					else
						display.remove(marble[i])				
						marble[i] = nil
						deleted = deleted + 1
					end
				end		
			end
					
			local tempTable = {}		
			local newCount = 0			
			
			for i = 1, marbCount do
				if(marble[i] ~= nil) then
					newCount = newCount + 1					
					tempTable[newCount] = marble[i]
				end
			end
			
			for i = 1, marbCount do			
				marble[i] = nil			
			end
			
			marble = tempTable
			
			local newScore = 0
			local textOutput = ""
			
			if (deleted == 3) then
				newScore = deleted * 10				
			elseif (deleted < 6) then	
				newScore = deleted * 1.5 * 10
				textOutput = "X1.5 Multiplier!"
			elseif (deleted < 8) then
				newScore = deleted * 2 * 10
				textOutput = "X2 Multiplier!"
				audio.play(twinkleSound)
			elseif (deleted < 10) then
				newScore = deleted * 2.5 * 10
				textOutput = "X2.5 Multiplier!"
				audio.play(twinkleSound)
			else
				newScore = deleted * 3 * 10
				textOutput = "X3 Multiplier!"
				audio.play(twinkleSound)
			end
			
			--function ShowText()			
				local scoreText = display.newText(textOutput, event.target.x, event.target.y, "Arial", 20 )
			--end
			
			local function RemoveText(event)
				scoreText:removeSelf()
			end
			
			
			--timer.performWithDelay(50, ShowText)
			timer.performWithDelay(2000, RemoveText)
			
			gameScore = gameScore + newScore
			
			marbCount = marbCount - deleted
			--print(deleted.." marbles deleted")
		end
		
		--print(marbCount.." marbles left")	
		
		for i = 1, marbCount do		
			marble[i].checked = false
			marble[i].match = false
			marble[i].name = i
			--print(marble[i].name)
		end
	end
end
	




local function DropMarble() -- initially fill the screen with bubbles based on the timer tr	
-- stop at 104

	if (marbCount < 96) then--104) then
		
		marbCount = marbCount + 1
		
		--local setX = math.random(0, 300) -- lower, upper parameters	
		

		marble[marbCount] = display.newCircle( setX, -40, 19 ) --xloc, yloc, radius(size)
		
		
		if (xUp) then
			if (setX >= 240) then
				xUp = false
			end	
			
			setX = setX + 40
		else
			if (setX <= 80) then
				xUp = true
			end
			
			setX = setX - 40		
		end
		
		
		marble[marbCount].name = marbCount
		marble[marbCount].checked = false
		marble[marbCount].match = false
		
		local wildCard = math.random(0, 99)
		
		if (wildCard < 0) then--5) then
			marble[marbCount].color = "wild"
			marble[marbCount].fill = { type="image", filename="wbub.png" }	

			--marble[marbCount]:addEventListener("touch",setBomb)		
		else 
			--local marbColor = math.random(0, 3)-- will assign one of four colors to each bubble
			local marbColor = math.random(0, marbleColors - 1)
		
			if (marbColor == 0) then
				marble[marbCount].color = "blue"
				marble[marbCount].fill = { type="image", filename="bBub.png" }
				--marble[marbCount]:setFillColor(0, 0, 255)
			elseif (marbColor == 1) then
				marble[marbCount].color = "green"
				marble[marbCount].fill = { type="image", filename="gBub.png" }
				--marble[marbCount]:setFillColor(0, 255, 0)
			elseif (marbColor == 2) then
				marble[marbCount].color = "red"
				marble[marbCount].fill = { type="image", filename="rBub.png" }
				--marble[marbCount]:setFillColor(255, 0, 0)
			else-- (marbColor == 3) then
				marble[marbCount].color = "orange"
				marble[marbCount].fill = { type="image", filename="oBub.png" }
				--marble[marbCount]:setFillColor(239, 247, 24)
			end		
			
			marble[marbCount]:addEventListener("touch", MatchMarbles)--, marble[marbCount])			
		end
		
		

			
		physics.addBody( marble[marbCount], { density=2, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better
		marble[marbCount].gravityScale = .5 -- they settle properly at .25 gravity

		-- drop sound
		-- since there are only 32 audio channels and this sound may play rapidly,
		-- a variable to find a free channel is created, starting on channel 10.
		-- if no channel above the passed in number is found, it defaults to 0
		-- this allows other sounds to occupy the lower channels
		-- an if statement checks the value of availableChannel. if it is not 0,
		-- then there is a free channel for the audio, otherwise it doesn't play
		local availableChannel = audio.findFreeChannel(10)
		if (availableChannel ~= 0) then
			audio.play( dropSound, { channel=availableChannel } )
		end
	end
	
	--print(marbCount)

end

local function TickClock()
	
	--tick clock
	
	-- check for win
	
	
	timeLeft = timeLeft - 10
	
	
	
	-- if (gameScore >= scoreToBeat) then
		-- print("You win!")

	-- elseif (timeLeft == 0) then
		-- print("You lose")
	-- else
		print("Time left: "..timeLeft.." Score: "..gameScore.." Level: "..level)
	-- end
	

	
	-- change level

	
	
	

end

local drop = nil
local gameTimer = nil


local score = display.newText("",290, -9, native.systemFontBold, 18 )
local scoreLbl = display.newText("Score:",232, -9, native.systemFontBold, 18 )
local scoreToBeatVal = display.newText("",290, -30, native.systemFontBold, 18 )
scoreToBeatVal:setFillColor( 0, 255, 0 )
local scoreToBeatLbl = display.newText("Next Level:",215, -30, native.systemFontBold, 18 )

scoreToBeatLbl:setFillColor( 0, 255, 0 )
local levelVal = display.newText("",75,-30, native.systemFontBold, 18)
levelVal:setFillColor( 1, 0, 2 )
local levelLbl = display.newText("Level:",27, -30, native.systemFontBold, 18 )
levelLbl:setFillColor( 1, 0, 2 )
local timeLeftVal = display.newText("",100,-9, native.systemFontBold, 18 )
timeLeftVal:setFillColor( 70, 20, 0 )
local timeLeftLbl = display.newText("Time Left:",40,-9, native.systemFontBold, 18 )
timeLeftLbl:setFillColor( 70, 20, 0 )





local function StartGame()

	
	bar:toFront()
	score:toFront()
	scoreLbl:toFront()
	scoreToBeatLbl:toFront()
	scoreToBeatVal:toFront()
	levelLbl:toFront()
	levelVal:toFront()
	timeLeftVal:toFront()
	timeLeftLbl:toFront()
	pauseBtn:toFront()
	
	levelVal.text = level
	score.text = gameScore
	scoreToBeatVal.text = math.round(scoreToBeat)
	timeLeftVal.text = timeLeft/10
	
	if (level == 1 and gameScore == 0 and gameOn == false) then -- start game		
		
		gameTimer = timer.performWithDelay (1000, TickClock, timeToBeat) 
		drop = timer.performWithDelay (dropSpeed, DropMarble, -1)--, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100
		gameOn = true	
		bgMusic()
	elseif (gameScore >= scoreToBeat) then
	
		audio.play(winSound)

		timer.cancel(gameTimer)
		timer.cancel(drop)
		gameTimer = nil
		drop = nil	
		
		for i = 1, marbCount do	
			display.remove(marble[i])				
			marble[i] = nil				
		end

		marble = {}
		marbCount = 0
		


		dropSpeed = dropSpeed - 50
		if (dropSpeed <= 0) then
			dropSpeed = 1
		end

		level = level + 1

		--scoreToBeat = scoreToBeat * 2
		scoreToBeat = scoreToBeat * 1.4

		--timeToBeat = timeToBeat - 150
		-- if (timeToBeat <= 0) then
			-- timeToBeat = 1
		-- end
		
		timeLeft = timeToBeat
		

		if (level > 4) then
			marbleColors = 4
		end 		

		gameTimer = timer.performWithDelay (1000, TickClock, timeToBeat) 
		drop = timer.performWithDelay (dropSpeed, DropMarble, -1)--, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100
		

		
		
	end
		
end



local runGame = timer.performWithDelay (25, StartGame, -1)
