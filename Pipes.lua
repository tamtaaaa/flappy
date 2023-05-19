Pipes = Class{}

local GAP = 100

function Pipes:init(x, y)
	self.x = x
	self.y = y
	
	self.pipes = {
		['top-pipe'] = Pipe('top', self.y),
		['bottom-pipe'] = Pipe('bottom', self.y - GAP)
	}
	
	self.remove = false
end

function Pipes:update(dt)
	if self.x > -self.pipes['top-pipe'].width then
		self.x = self.x - PIPE_SCROLL * dt
		self.pipes['top-pipe'].x = self.x
		self.pipes['bottom-pipe'].x = self.x
	else
		self.remove = true
	end
	
end

function Pipes:render()
	for k, pipe in pairs(self.pipes) do
		pipe:render()
	end
end
