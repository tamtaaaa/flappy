PlayState = Class{__includes = BaseState}

PIPE_SCROLL = 60

function PlayState:init()
	self.bird = Bird()
	self.pipePairs = {}
	self.timer = 0
end

function PlayState:update(dt)
	
	self.timer = self.timer + dt
	
	if self.timer > 2 then
		local x = VIRTUAL_WIDTH
		local y = math.random(60, 200)
		table.insert(self.pipePairs, Pipes(x, y))
		self.timer = 0
	end
	
	
	for k, pair in pairs(self.pipePairs) do
		pair:update(dt)
		if pair.remove == true then
			table.remove(self.pipePairs, k)
		end
	end
	
	for k, pair in pairs(self.pipePairs) do
		for i, pipe in pairs(pair.pipes) do
			if self.bird:collides(pipe) then
				print("collided")
			end
		end
	end
	
	self.bird:update(dt)
end

function PlayState:render()
	for k, pair in pairs(self.pipePairs) do
		pair:render()
	end
	
	self.bird:render()
end
