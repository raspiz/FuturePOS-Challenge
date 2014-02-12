local physics = require ( "physics" )
physics.start()

physics.setScale( 30 ) -- scale of the objects may need to change or remove this

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
physics.addBody( rightSide, "static",{friction = 0, bounce =0})

-- array for bubble objects and array counter. this will be incremented as new bubbles are added
local marble = {}
local marbCount = 0






--circle.myName = "circle"




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
 
--background:addEventListener("touch",setBomb)






-- local function BlowUp(event)
	-- if (event.phase == "began") then
		-- local blastRadius = ""
		-- local explosion = ""
		-- local function Blast(event)
			-- blastRadius = display.newCircle (


		-- end
		

		-- event.target:applyForce( 500, 500, event.target.x, event.target.y )
		
	-- end
-- end

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
	
	local wildCard = math.random(0, 99)
	
	if (wildCard < 5) then
		marble[marbCount].color = "wild"
		marble[marbCount].fill = { type="image", filename="wbub.png" }	

		--marble[marbCount]:addEventListener("touch",setBomb)		
	else 
		local marbColor = math.random(0, 3)-- will assign one of four colors to each bubble
	
		if (marbColor == 0) then
			marble[marbCount].color = "blue"
			marble[marbCount].fill = { type="image", filename="bBub.png" }
		elseif (marbColor == 1) then
			marble[marbCount].color = "green"
			marble[marbCount].fill = { type="image", filename="gBub.png" }
		elseif (marbColor == 2) then
			marble[marbCount].color = "red"
			marble[marbCount].fill = { type="image", filename="rBub.png" }
		else-- (marbColor == 3) then
			marble[marbCount].color = "orange"
			marble[marbCount].fill = { type="image", filename="oBub.png" }
		end		
		
		marble[marbCount]:addEventListener("touch", MatchMarbles)--, marble[marbCount])			
	end
	
	

		
	physics.addBody( marble[marbCount], { density=1, friction=0, bounce=.5 } ) -- with .5 they seem to bouce and settle in better
	marble[marbCount].gravityScale = .5 -- they settle properly at .25 gravity


	
	print(marbCount)

end

local tr = timer.performWithDelay (10, DropMarble, 100)	-- delay, function to call, iterations -- was 500, DropMarble, 100
