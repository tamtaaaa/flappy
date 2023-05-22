Pipe = Class{}



function Pipe:init(identity, y)
	self.image = love.graphics.newImage('pipe.png')	
	
	self.x = VIRTUAL_WIDTH
	self.y = y
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	
	self.identity = identity
end

function Pipe:update(dt)
	--self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
	love.graphics.draw(
		self.image, 
		self.x, 
		(self.identity == 'top' and self.y + self.height or self.y), 
		0,
		1, 
		(self.identity == 'top' and -1 or 1))
end
