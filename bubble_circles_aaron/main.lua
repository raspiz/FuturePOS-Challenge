local physics = require ( "physics" )
physics.start()

local bottom = display.newImage("stones.png")
local leftSide = display.newImage("wall1.png")
local rightSide = display.newImage("wall2.png")
local bg = display.newImage("bg.png")

bg.x = 200; bg.y = 150;
rightSide.x = 320; rightSide.y = 20;
leftSide.x = 0; leftSide.y = 5;
bottom.x = 100; bottom.y = 500;
physics.addBody( bottom, "static", {friction = 0, bounce = 0})
physics.addBody( leftSide, "static", {friction = 0, bounce = 0})
physics.addBody( rightSide, "static",{fricion = 0, bounce =0})

-- array for bubble objects and array counter. this will be incremented as new bubbles are added
local marble = {}
local marbCount = 0

local function TouchCheck (marbNum, count)

	for i = 1, marbCount do	
		if (marble[i].color == marble[marbNum].color and marble[i].checked == false and marble[i].match == false) then -- checked good
			if (i ~= marbNum) then -- not self				
				local distX = marble[marbNum].x - marble[i].x
				local distY = marble[marbNum].y - marble[i].y				
				local distance = math.sqrt(distX * distX + distY * distY)
				
				if (distance <= 45) then--<= size) then				
					marble[i].match = true
					count = count + 1				
				end	
			end
		end		
	end
	
	return count	
end


local function MatchMarbles(event) -- user touches screen to try to pop a bubble	
	if (event.phase == "began") then		
		local touchCount = 1
		local deleted = 1		
		local num = event.target.name
		
		print("my name is "..event.target.name)
		event.target.match = true
		event.target.checked = true
		
		touchCount = TouchCheck(num, touchCount)

		if (touchCount > 1) then
			for i = 1, marbCount do
				if (marble[i].match == true and marble[i].checked == false) then
					touchCount = TouchCheck(i, touchCount)
					marble[i].checked = true
					i = 0			
				end			
			end		
		end
		
		-- deletion
		if (touchCount >= 3) then
			for i = 1, marbCount do
				print(marble[i].match)
				if (marble[i].match and touchCount > 1) then
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
			
			marbCount = marbCount - deleted
			print(deleted.." marbles deleted")
		end
		
		print(marbCount.." marbles left")	
		
		for i = 1, marbCount do		
			marble[i].checked = false
			marble[i].match = false
			marble[i].name = i
			print(marble[i].name)
		end
	end
end
	




local function DropMarble() -- initially fill the screen with bubbles based on the timer tr	

	marbCount = marbCount + 1
	
	local setX = math.random(0, 300) -- lower, upper parameters	

	marble[marbCount] = display.newCircle( setX, 0, 19 ) --xloc, yloc, radius(size)
	
	marble[marbCount].name = marbCount
	marble[marbCount].checked = false
	marble[marbCount].match = false
	
	local bubColor = math.random(0, 3)-- will assign one of four colors to each bubble

	--marble[marbCount].fill = { type="image", filename="bbub3.png" }
	
	if (bubColor == 0) then
		marble[marbCount].color = "blue"
		marble[marbCount].fill = { type="image", filename="bBub.png" }
	elseif (bubColor == 1) then
		marble[marbCount].color = "green"
		marble[marbCount].fill = { type="image", filename="gBub.png" }
	elseif (bubColor == 2) then
		marble[marbCount].color = "red"
		marble[marbCount].fill = { type="image", filename="rBub.png" }
	else-- (bubColor == 3) then
		marble[marbCount].color = "orange"
		marble[marbCount].fill = { type="image", filename="oBub.png" }
	end
		
	physics.addBody( marble[marbCount], { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better
	marble[marbCount].gravityScale = .5 -- they settle properly at .25 gravity

	marble[marbCount]:addEventListener("touch", MatchMarbles)--, marble[marbCount])	
	
	print(marbCount)

end

local tr = timer.performWithDelay (250, DropMarble, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100
