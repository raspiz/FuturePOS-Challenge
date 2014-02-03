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

--local function MakeMarble(setX)
		--marble[marbCount] = display.newCircle( setX, 10, 19 ) --xloc, yloc, radius(size)
		--marble[marbCount].name = "marble"..marbCount
		--marble[marbCount].color = "Undefined"
--end

-- the marble being checked is passed in as a parameter
local function TouchCheck(self, count, index)

		--touchX = event.x
		--touchY = event.y

	-- need the -1 here since DropMarble increments at the end. this could be rewritten to keep numbers the same
	for i = 1, marbCount do
		if (marble[i].color == self.color) then
			if (marble[i] ~= self and index[i] == nil) then					
				-- quick check to see if the bubble is close				
				if (marble[i].x + 50 >= self.x and marble[i].x - 50 <= self.x) and (marble[i].y + 50 >= self.y and marble[i].y - 50 <= self.y) then
					-- time to do distance calculation to see if they are close enough
				
					local distX = self.x - marble[i].x
					local distY = self.y - marble[i].y
					
					local distance = math.sqrt(distX * distX + distY * distY)
					
					-- might not need size calculation
					local size = (self.contentWidth/2) + (marble[i].contentWidth/2)
					
					--print("distance is "..distance)
					--print ("size is "..size)
					
					-- might need to adjust this to increase "touching" area to account for gaps
					if (distance <= 40) then--< size) then
						
						count = count + 1
						index[i] = i
						index[i] = {checked = "false"}
						--index[i].checked = "false"
						
						--display.remove(marble[i])
						--self:removeSelf()
					end
				

				
					--local myTextObject = display.newText( touchX.." "..touchY.." "..marble[i].name, touchX, touchY, "Arial", 20 )
					
				end
			end
		
		
		
		
		end

	end

	return count
		
end


local function MatchMarbles(self, event) -- user touches screen to try to pop a bubble
	
	if (event.phase == "began") then
	
		local touchCount = 1
		local touchers = {checked = "false"}
		touchers[self.name] = self.name
		--print(touchers[self.name])
		touchers[self.name] = {checked = "true"}
		
		-- touchCount might need adjusted if it is only passing by value. possibly call the function as an assignment
		touchCount = TouchCheck(self, touchCount, touchers)
		
		
		--print(touchCount.." are touching")
		
		if (touchCount > 1) then
			for i = 1, marbCount do			
				if (touchers[i] ~= nil) then
					if (touchers[i].checked == "false") then
						touchCount = TouchCheck(marble[i], touchCount, touchers)	
						touchers[i].checked = "true"
						i = 1
					end				
				
					--print("marble "..i.." is touching")
				end
			
			end				
		end
		
		-- marbles will be deleted and the table rebuilt to remove gaps
		if (touchCount >= 3) then
			local newTable = marbCount - touchCount -- size of new table
			local newCount = 1
			
			for i = 1, marbCount do	
				if (touchers[i] ~= nil) then -- this one is to be deleted
					display.remove(marble[i])
					marble[i] = nil
					-- if marble[i] == nil then
					--print("the value of marble"..i.." is "..marble[i])
					-- end
					--marbCount = marbCount - 1
			--self:removeSelf()		
				else--if (i <= newTable) then
					marble[newCount] = marble[i]
					newCount = newCount + 1
				--else 
				--	marble[i] = nil
				end
			
			-- decroemnt marbCount and redo array
			end
			
			marbCount = newTable
			print(marbCount)
			
		end
		

		
		-- might want to put this in a separate function and pass self in as a parameter
		

			
			-- skip self
			-- skip other colors
			-- skip same color if over 50px away on x or y access
		
			
		-- run through array and check to see if bubbles are close using distance formula
		-- ignore self
		-- keep track of bubbles that are within distance
			-- iterate through the rest of the bubbles that are within
			
		-- if there is a deletion, delete bubbles that are touching, reassign remaining bubbles to a new
		-- array and make the values of the original array nil so that once loop is complete, original array is gone
		
		
		
	
		
		
		-- check to see if contacting other bubbles of the same color
			-- if touching bubble of same color, have that bubble also do a check
				-- and etc
				
		-- if 3 or more bubbles of the same color are touching, destroy the bubbles
	end


end





local function DropMarble() -- initially fill the screen with bubbles based on the timer tr	

	marbCount = marbCount + 1
	
	local setX = math.random(0, 300) -- lower, upper parameters
	--local setY = math.random(-25, 25) -- lower, upper parameters
	
	--MakeMarble(setX)
	marble[marbCount] = display.newCircle( setX, 10, 19 ) --xloc, yloc, radius(size)
	
	marble[marbCount].name = marbCount
	
	local bubColor = math.random(0, 3)-- will assign one of four colors to each bubble

	--marble[marbCount].fill = { type="image", filename="bbub3.png" }
	
	if (bubColor == 0) then
		marble[marbCount].color = "blue"
		marble[marbCount].fill = { type="image", filename="bbub.png" }
	elseif (bubColor == 1) then
		marble[marbCount].color = "green"
		marble[marbCount].fill = { type="image", filename="gbub.png" }
	elseif (bubColor == 2) then
		marble[marbCount].color = "red"
		marble[marbCount].fill = { type="image", filename="rbub.png" }
	else-- (bubColor == 3) then
		marble[marbCount].color = "orange"
		marble[marbCount].fill = { type="image", filename="ybub.png" }
	end
		
	physics.addBody( marble[marbCount], { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better
	marble[marbCount].gravityScale = .5 -- they settle properly at .25 gravity

	marble[marbCount].touch = MatchMarbles
	marble[marbCount]:addEventListener("touch", marble[marbCount])

	--print (marble[marbCount].name)
	-- if ("blue" == "blue") then
		-- print("true")
	-- else
		-- print("false")
	-- end
	
	
	print(marbCount)
end

local tr = timer.performWithDelay (10, DropMarble, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100







