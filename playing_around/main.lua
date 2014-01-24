--local physics = require("physics")
--physics.start()
display.setStatusBar(display.HiddenStatusBar)

-- block dimensions
-- height 12px: 10 for block, 2 for nipple
-- width 8px: 4px for nipple

-- may need to make the bottom row individual blocks but idk?
-- perhaps keep a table of blocks that have been placed so undo can be used

local numBlocks = math.floor(display.contentWidth/24)

local bottomPadding = (display.contentWidth - (numBlocks * 24))/2

local bottom = display.newRect(bottomPadding, display.contentHeight - 30 ,numBlocks * 24, 30)

print(numBlocks)



-- local botnip = display.newRect(6, display.contentHeight - 36, 12, 6)
-- local botnip2 = display.newRect(30, display.contentHeight - 36, 12, 6)
-- local botnip3 = display.newRect(54, display.contentHeight - 36, 12, 6)
-- local botnip4 = display.newRect(78, display.contentHeight - 36, 12, 6)

local botnipStart = 6 + bottomPadding
local botnip = {}

for i = 1, numBlocks do
	botnip[i] = display.newRect(botnipStart, display.contentHeight - 36, 12, 6)
	botnipStart = botnipStart + 24

end



--local bottom = display.newRect(100,100 ,16, 20)

local block = display.newRect(50, 50, 24, 30) 
block.name = "hey"

local block2 = display.newRect(100, 100, 24, 30)

local nipple = display.newRect(56, 44, 12, 6)

block:setFillColor(255,255,255)


function moveBlock(self, event)
--print(self.name)
	if (event.phase == "began") then
	--print("hello")
		self.saveX = self.x
		self.saveY = self.y
	elseif (event.phase == "moved") then
		local x = (event.x - event.xStart) + self.saveX
		local y = (event.y - event.yStart) + self.saveY
		
		self.x, self.y = x, y
	end
	return true
end


block2.touch = moveBlock
block2:addEventListener( "touch", block2 )



-- display group, not sure if i want this
local group = display.newGroup()
group:insert( block )
group:insert( nipple )
group.touch = moveBlock
group:addEventListener( "touch", group )


--block = display.newImage ("gas10.png", 100, 100)



-- local myObject = display.newRect( 0, 0, 100, 100 )
-- myObject:setFillColor( 255 )
 
--touch listener function
-- function myObject:touch( event )
-- if event.phase == "began" then
-- self.markX = self.x -- store x location of object
-- self.markY = self.y -- store y location of object
-- elseif event.phase == "moved" then
-- local x = (event.x - event.xStart) + self.markX
-- local y = (event.y - event.yStart) + self.markY
-- self.x, self.y = x, y -- move object based on calculations above
-- end
-- return true
-- end
 
--make 'myObject' listen for touch events
-- myObject:addEventListener( "touch", myObject )