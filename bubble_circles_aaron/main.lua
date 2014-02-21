--[[
MmmPop: Created by Aaron Whitmer, Eric McDonald, and Corbin Troup. 2014
This game challenges players to pop off sets of colored marbles from the screen. The marbles will
drop in randomly and increase in speed as the player progresses. Larger sets of marbles yield higher scores.

The main logic of the game is located in the MatchMarbles and TouchCheck functions. MatchMarbles is activated
by a touch event and runs through routines to check to see if enough marbles are touching to make a deletion, 
handles changes to the marble table, and figures up scoring. TouchCheck is called from MatchMarbles and is 
responsible for determining if 2 marbles are within proximity of one another to be considered a match.

The DropMarble function handles the creation of marbles and assigning physics properties, listener, and other attributes.

The StartGame function is called by a timer object when the program is loaded and handles calls to DropMarbles and the
game timer object as well as parameters for leveling up.
--]]


-- include and start Corona physics engine. needed for marble behavior.
local physics = require ( "physics" )
physics.start()

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight

local bottom = display.newImage("stones.png")
local leftSide = display.newImage("wall1.png")
local rightSide = display.newImage("wall2.png")
local bg = display.newImage("bg.png")
local bar = display.newImage("bar.png")

bg.x = 160; bg.y = 240;
rightSide.x = 318; rightSide.y = 20;
leftSide.x = 2; leftSide.y = 20;
bottom.x = 100; bottom.y = screenHeight--500;
bottom:toFront()
bar.x = 100; bar.y = 5---20;

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
local dropSpeed = 1	
local marbleColors = 3

local blopSound = audio.loadSound("blop.mp3")
local dropSound = audio.loadSound("drop.mp3")
local levelupSound = audio.loadSound("levelup.mp3")
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
 
--[[
TouchCheck: This function is called by the MatchMarbles function. The marble that called it will check
all other marbles to determine if they're close enough to be considered a match.

--The table index of the marble being checked against and the current amount of matching marbles 
are passed in as parameters.

--A loop will go through the marble table. An if statement will determine whether the marble being checked
is the right color and skip it if it has already been checked to prevent marbles with multiple matching neighbors
from being checked repeatedly.

--If the marble meets the conditions, the distance formula is performed with the two marble and if they are within the 
threshhold (50 pixels), they are marked as being a match and the count of matching marbles is incremented.
The marbles are 39 pixels wide, so the 50 pixel threshhold allows leeway to find matches between marbles that
are close but may not be physically touching. Diagonal matches are outside of this threshold and not considered 
a match.

--The count of matching marbles is returned at the end of the function.
--]]
local function TouchCheck (marbNum, count)
	for j = 1, marbCount do	
		if (marble[j].color == marble[marbNum].color) then -- do colors match?
			if (marble[j].checked == false and marble[j].match == false) then -- has this marble already been checked?
				if (j ~= marbNum) then -- ignores self	
					-- distance formula finds the proximity of the marbles in pixels
					local distX = marble[marbNum].x - marble[j].x
					local distY = marble[marbNum].y - marble[j].y				
					local distance = math.sqrt(distX * distX + distY * distY)
					
					-- if their centers are within 50 pixels we have a match
					if (distance <= 50) then				
						marble[j].match = true
						count = count + 1				
					end	
				end
			end
		end		
	end
	
	return count	
end

--[[
MatchMarbles: This is a touch event that is called when a player touches a marble on the screen. The event
is added to each marble as they are spawned. Marbles will check for neighbors by calling the TouchCheck function.
The result of TouchCheck is returned to a value representing the number of marbles that match.

--The main purpose of this function is to determine how many marbles of the same color are within proximity 
of the originally touched marble. 

--Each touching marble will be marked as such and will proceed to check for its own matching neighbors in a loop.
Each time new matches are found, the loop will restart at the first index in order to check matches that may have a
lower index than the marble that marked them. This process will continue until all marbles marked as a match have been checked.

--After all matches have been checked, an if statement will determine if the threshhold for deletion has been
met (3 matching marbles). The matching marbles will be removed from the screen and given a nil value in the table.

--An local temporary table will be created and filled with the marbles that were not deleted. The original marble
table will then be made nil. The marble table will then be refilled with the temp table's values. This process
keeps nil values out of the table and keeps the table size consistent.

--A score will be determined by the size of the deletion and added to the player's total. Sound and visual cues 
will alert the player upon a successful deletion.
--]]
local function MatchMarbles(event)	
	if (event.phase == "began") then	
		local touchCount = 1 -- marbles that are matches. starts at one to include the touched marble
		local deleted = 1 -- marbles to be removed if deletion occurs. this also helps determine score
		local num = event.target.name -- the table index of the marble that was touched
		
		-- the TouchCheck function will return any additional matches found. If more
		-- were found, addional checks will be performed on the matched marbles
		touchCount = TouchCheck(num, touchCount)

		-- the rest of the function will only execute if additional matches were found
		if (touchCount > 1) then		
			event.target.match = true
			event.target.checked = true	
		
			-- loopDone flag will not be to true when the table is able to be gone through
			-- without any new matches found
			local loopDone = false 
			while (loopDone == false) do
				loopDone = true
				
				-- nested loop to find more matches. marbles marked as being a match but not having been
				-- checked yet will call TouchCheck. New matches will set loopDone to false so that the 
				-- inner loop can start from the beginning again. Once all matched marbles have been checked,
				-- the outer loop will end
				for i = 1, marbCount do
					if (marble[i].match == true and marble[i].checked == false) then
						touchCount = TouchCheck(i, touchCount)
						marble[i].checked = true
						loopDone = false			
					end		
				end		
			end
			
			-- deletion will occur if a group of 3 or more marbles was found at the touch event
			-- the marble will be removed from the screen, and then set as nil in the table
			if (touchCount >= 3) then
				audio.play(blopSound)
				for i = 1, marbCount do	
					if (marble[i].match) then
						if (i == num) then	-- special case to remove the marble that was touched				
							event.target:removeSelf()
							marble[num] = nil
						else -- all other matched marbles deleted here
							display.remove(marble[i])				
							marble[i] = nil
							deleted = deleted + 1
						end
					end		
				end
						
				-- temporary table and count are created and the remaining marbles are placed inside		
				local tempTable = {}		
				local newCount = 0			
				
				for i = 1, marbCount do
					if(marble[i] ~= nil) then -- only marbles that have not been deleted are added
						newCount = newCount + 1					
						tempTable[newCount] = marble[i]
					end
				end
				
				-- explicitely make the original marble table nil
				for i = 1, marbCount do			
					marble[i] = nil			
				end
				
				-- assign the temp table to the original table
				marble = tempTable
				
				-- scoring data is computed and output to the screen
				local newScore = 0				
				
				-- multipliers applied to matches > 3
				if (deleted == 3) then
					newScore = deleted * 10
				else
					local multImage = nil						
					
					multX = event.target.x
					multY = event.target.y
					
					-- if the event x and y values are too close to the edge we will pull them in
					if (multX < 40) then
						multX = 40
					elseif (multX > screenWidth - 50) then
						multX = screenWidth - 50
					end
					
					if (multY < 40) then
						multY = 40
					elseif (multY > screenHeight - 50) then
						multY = screenHeight - 50
					end
				
					-- multiplier score computed and image displayed
					if (deleted < 6) then	
						newScore = deleted * 1.5 * 10
						multImage = display.newImage("x15.png", multX, multY)
					elseif (deleted < 8) then
						newScore = deleted * 2 * 10
						multImage = display.newImage("x2.png", multX, multY)
						audio.play(twinkleSound)
					elseif (deleted < 10) then
						newScore = deleted * 2.5 * 10
						multImage = display.newImage("x25.png", multX, multY)
						audio.play(twinkleSound)
					else
						newScore = deleted * 3 * 10
						multImage = display.newImage("x3.png", multX, multY)
						audio.play(twinkleSound)
					end					
					
					-- this function will be called by a timer event to remove the image indicator after a set amount of time
					local function RemoveMult(event)
						multImage:removeSelf()
						multImage = nil
					end
					
					timer.performWithDelay(1500, RemoveMult)					
				end
				
				gameScore = gameScore + newScore -- total score updated
				
				marbCount = marbCount - deleted -- table size variable adjusted
			end	
			
			-- if ANY matches were found, the table is run through and all marbles are explicitely 
			-- set to not checked and not a match so they are ready for the next touch event
			for i = 1, marbCount do		
				marble[i].checked = false
				marble[i].match = false
				marble[i].name = i
			end			
		end
	end
end
	
--[[
DropMarble: This function will be called by the StartGame function on a timer set by the game parameters.
Each time it is called, a new marble will be created, added to the table, and dropped into the game space

--A new marble will only be dropped if the screen is not full already.

--New marbles spawn along the x axis. it is incremented and decremented until the edge of the screen to help
prevent them from bunching up when dropping in rapidly

--Parameters and properties are added to each marble: 
name(index value), checked, match, touch listener, physics properties. color is randomly assigned.
--]]
local function DropMarble()
	if (marbCount < 88) then -- max number of marbles on the screen

		marbCount = marbCount + 1 -- starts at 0 when game is launched. the first marble will be index 1
		marble[marbCount] = display.newCircle( setX, -20, 19 ) --xloc, yloc, radius(size)		
		
		-- spawn location of marbles shifts left and right to let them fall clear of one another
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
		
		-- marble properties are assigned
		marble[marbCount].name = marbCount -- the name is set to the index value for future comparisons
		marble[marbCount].checked = false
		marble[marbCount].match = false		
		marble[marbCount]:addEventListener("touch", MatchMarbles)	-- touch event	
		physics.addBody( marble[marbCount], { density=2, friction=0, bounce=.5 } )
		marble[marbCount].gravityScale = .5		

		-- color is assigned. the random number uses a variable that is changed based on the current level
		-- the first few levels only feature 3 colors to familiarize the player with the game
		local marbColor = math.random(0, marbleColors - 1)
	
		if (marbColor == 0) then
			marble[marbCount].color = "blue"
			marble[marbCount].fill = { type="image", filename="bBub.png" }
		elseif (marbColor == 1) then
			marble[marbCount].color = "green"
			marble[marbCount].fill = { type="image", filename="gBub.png" }
		elseif (marbColor == 2) then
			marble[marbCount].color = "red"
			marble[marbCount].fill = { type="image", filename="rBub.png" }
		else
			marble[marbCount].color = "purple"
			marble[marbCount].fill = { type="image", filename="pBub.png" }
		end		

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
end

local function TickClock()	
	timeLeft = timeLeft - 10
end

local drop = nil
local gameTimer = nil

local score = display.newText("",290, 20, native.systemFontBold, 18 )
local scoreLbl = display.newText("Score:",232, 20, native.systemFontBold, 18 )
local scoreToBeatVal = display.newText("",150, 20, native.systemFontBold, 18 )
scoreToBeatVal:setFillColor( 0, 255, 0 )
local scoreToBeatLbl = display.newText("Score To Beat:",62, 20, native.systemFontBold, 18 )
scoreToBeatLbl:setFillColor( 0, 255, 0 )
local levelVal = display.newText("",75, 7, native.systemFontBold, 18)
levelVal:setFillColor( 1, 0, 2 )
local levelLbl = display.newText("Level:",27, 7, native.systemFontBold, 18 )
levelLbl:setFillColor( 1, 0, 2 )
local timeLeftVal = display.newText("",290, 7, native.systemFontBold, 18 )
timeLeftVal:setFillColor( 70, 20, 0 )
local timeLeftLbl = display.newText("Time Left:",220, 7, native.systemFontBold, 18 )
timeLeftLbl:setFillColor( 70, 20, 0 )

--[[
StartGame: This function will be called by a timer object when the game loads. It will then be called indefinitely in
order to check for 
Initial game conditions are set
--]]
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
	
		

		timer.cancel(gameTimer)
		timer.cancel(drop)
		--gameTimer = nil
		--drop = nil	
		
		for i = 1, marbCount do	
			display.remove(marble[i])				
			marble[i] = nil				
		end

		marble = {}
		marbCount = 0
		
		local LevelUpImage = display.newImage("levelComplete.png", screenWidth/2, screenHeight/2)
		
		dropSpeed = dropSpeed - 50
		if (dropSpeed <= 0) then
			dropSpeed = 1
		end

		level = level + 1

		--scoreToBeat = scoreToBeat * 2
		scoreToBeat = math.ceil(scoreToBeat * 1.4)

		--timeToBeat = timeToBeat - 150
		-- if (timeToBeat <= 0) then
			-- timeToBeat = 1
		-- end
		
		timeLeft = timeToBeat
		

		if (level > 4) then
			marbleColors = 4
		end 		

		local function ShowLevelUp(event)
			LevelUpImage:removeSelf()
			LevelUpImage = nil
			
			gameTimer = timer.performWithDelay (1000, TickClock, timeToBeat) 
			drop = timer.performWithDelay (dropSpeed, DropMarble, -1)
		end
			
		audio.play(levelupSound)	
		timer.performWithDelay(3000, ShowLevelUp)
	end
		
end

local runGame = timer.performWithDelay (25, StartGame, -1)