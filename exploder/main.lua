local physics = require("physics")
physics.start()
physics.setGravity( -5, -5 )
display.setStatusBar(display.HiddenStatusBar)

local background = display.newImage ("m16.jpg", 0, 0, true)
background.x = display.contentWidth / 2 -- centers the image on xy axis
background.y = display.contentHeight / 2

local gravCollisionFilter = {categoryBits = 3, maskBits = 2 }
local gasCollisionFilter = {categoryBits = 2, maskBits = 1 }


--local floor = display.newImage ("floor.png", 0, 380, true)
--physics.addBody (floor, "static", {friction = 0.5 }) -- static means the object will interact with other objects but not be affected by inertial forces 


-- this will print hello world on the sccreen if a gas bubble is clicked
local function onObjectTouch( event )
    if event.phase == "began" then
		textX = math.random(0, display.contentWidth) -- lower, upper parameters
		textY = math.random(0, display.contentHeight)
		
		--physics.setGravity( -5, -5 )
		
		--event.target.setGravity(5, 5)
		
		-- refer to the object that has been touched		
		event.target.gravityScale = 1
		
		-- return location of touch event
		touchX = event.x
		touchY = event.y
		
	
		local myTextObject = display.newText( touchX.." "..touchY, textX, textY, "Arial", 60 )
        --print( "Touch event began on: " .. event.target.id )
    end
    --return true -- returning true here would prevent other touch events from occuring (like touching the background image)
end

local function bgImageTouched ( event )
	if (event.phase == "ended") then
		field:removeSelf()
		field = nil
		
		gravityOn = false
		--print("gravityoff")
	elseif (event.phase == "moved") then
		field:removeSelf()
		field = nil
		
		touchBGX = event.x
		touchBGY = event.y	
		
		field = display.newCircle( 0, 0, 160 ) ; field.alpha = 0.3
		field.name = "field"
		field.x = touchBGX ; field.y = touchBGY

		physics.addBody( field, "static", { isSensor=true, radius=160, filter=gravCollisionFilter } )

	elseif (event.phase == "began") then -- *BUG need to fix this so that event only begins if touching inside screen area	
		touchBGX = event.x
		touchBGY = event.y	
		--local bgText = display.newText( touchBGX.." "..touchBGY, touchBGX, touchBGY, "Arial", 60 )
		
		-- setting up a radial gravity field
		field = display.newCircle( 0, 0, 160 ) ; field.alpha = 0.3
		field.name = "field"
		field.x = touchBGX ; field.y = touchBGY

		physics.addBody( field, "static", { isSensor=true, radius=160, filter=gravCollisionFilter } )	
		
		gravityOn = true
		
	end	
	return true
end

local function gravityPull(self, event)
	
	
	--if (gravityOn == true) then
	
	
		local otherName = event.other.name
		--print("hello "..event.other.name)
		--print("location "..event.other.x.." "..event.other.y)
		
			local function onDelay(event)
				-- if (gravityOn == true) then
				-- print("gravon")
				-- else
				-- print("gravoff")
				-- end
			
				--print(event.phase)
				local action = ""
				
				if ( event.source ) then 
					action = event.source.action 
					timer.cancel( event.source ) 
				end
				
				
				if (action == "makeJoint") then
					self.hasJoint = true
					self.touchJoint = physics.newJoint ("touch", self, self.x, self.y)
					self.touchJoint.frequency = 0.25 -- the pull of the joint
					self.touchJoint.dampingRatio = 0.0
					--print("testing "..event.other.x.." "..event.other.y)
					if (field ~= nil) then
						self.touchJoint:setTarget (field.x, field.y)--(0,0)--(event.other.x, event.other.y)
					end
					--print("hello "..event.other.x.." "..event.other.y)						
				elseif (action == "leftField") then
					self.hasJoint = false
					if (self.touchJoint ~= nil) then
						self.touchJoint:removeSelf()
						self.touchJoint = nil	
					end
					
					--local vx, vy = self:getLinearVelocity()
					--print("out of field")--"velocity "..vx.." "..vy)
					--self:setLinearVelocity( vx, vy )
					--self.angularVelocity = math.random( -3,3 ) * 40
					--self:addEventListener("collision", self)
				--elseif (action == "") then
					--print("phase is "..event.phase)
					--if ( self.hasJoint == true ) then 
						--self.hasJoint = false 
						--self.touchJoint:removeSelf() 
						--self.touchJoint = nil 
					--end
					
					--self.x = 100 ; self.y = 100					
					--local vx, vy = self:getLinearVelocity()
					--print("velocity "..vx.." "..vy)
					--self:setLinearVelocity( vx, vy )
					--newPositionVelocity( self )
					--print("what what what")
				end
			end
				
		if (event.phase == "began" and otherName == "field" and self.hasJoint == false) then
			local tr = timer.performWithDelay (10, onDelay)
			tr.action = "makeJoint"	
		-- elseif (event.phase == "began" and otherName == "field" and self.hasJoint == true) then
			-- local tr = timer.performWithDelay (10, onDelay)
			-- tr.action = "makeJoint"	
			
		-- elseif (event.phase == "began" and self.hasJoint ==  and gravityOn == false) then -- test case???
			-- print("just die!")
		
		elseif (event.phase == "ended" and otherName == "field" and self.hasJoint == true) then
			local tr = timer.performWithDelay (10, onDelay)			
			tr.action = "leftField"
						
			
		-- elseif (gravityOn == false) then -- end collision manually
			-- event.phase = nil
			-- local tr = timer.performWithDelay (10, onDelay)
			-- tr.action = ""
			-- print("hello "..tr.action)
		-- else-- (event.phase == "ended") then
			--local tr = timer.performWithDelay (10, onDelay)
			--tr.action = ""
							 -- local vx, vy = self:getLinearVelocity()
					--print("velocity "..vx.." "..vy)
					 --self:setLinearVelocity( vx, vy )
		end
	--else
		--tr = nil
		--self.hasJoint = false
		--self.touchJoint:removeSelf()
		--self.touchJoint = nil
		--self.touchJoint = nil
		--local vx, vy = self:getLinearVelocity()
		--self:setLinearVelocity( vx, vy )
		--self:addEventListener("collision", self)	
	--end
	
	
	print("the end")
		self.hasJoint = false
		if (self.touchJoint ~= nil) then
			self.touchJoint:removeSelf()
			self.touchJoint = nil
		end
		
		local vx, vy = self:getLinearVelocity()
		print("velocity "..vx.." "..vy)
		--self:setLinearVelocity( vx, vy )
		self:setLinearVelocity( -1, -1 )
	

end




background:addEventListener("touch", bgImageTouched)


local function startGame()

	local gas = {}
	-- by giving all of the gas body objects the same negative groupIndex, they will pass through each other


	for i = 1, 400 do
		startX = math.random(0, display.contentWidth) -- lower, upper parameters
		startY = math.random(0, display.contentHeight)
		
		gas[i] = display.newImage ("gas10.png", startX,startY)--300, 100)--, 140 + (i*50), 220 - (j*50) ) --filename, top, left
		--gas[i].x = display.contentWidth / 2
		--gas[i].y = display.contentHeight / 2
		
		-- turns the object into a physics body so that additional physics based effects can take place
		-- the filter allows the objects to pass though one another
		physics.addBody( gas[i], {density=0.1, friction=0.1, bounce=0, filter=gasCollisionFilter} )
		gas[i].gravityScale = 0--.25  -- sets gravity of object
		
		moveX = math.random(-25, 25) -- lower, upper parameters
		moveY = math.random(-25, 25)
		
		gas[i]:setLinearVelocity( moveX, moveY ) -- x,y parameters in pixels per second
		
		-- stuff for radial grav
		gas[i].name = "gas"..i -- not sure if i need this
		gas[i].hasJoint = false

		
		-- event listeneer for the touch object
		gas[i]:addEventListener( "touch", onObjectTouch )
		gas[i].collision = gravityPull
		gas[i]:addEventListener("collision", gas[i])

	end




end

startGame()


