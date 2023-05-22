PlayState = Class{__includes = BaseState}

PIPE_SCROLL = 60

function PlayState:init()
	self.bird = Bird()
	self.pipePairs = {}
	self.timer = 0
	self.score = 0
end

function PlayState:update(dt)
	
	self.timer = self.timer + dt
	
	if self.timer > 2 then
		local x = VIRTUAL_WIDTH
		local y = math.random(-300, -140)
		table.insert(self.pipePairs, Pipes(x, y))
		self.timer = 0
	end
	
	
	for k, pair in pairs(self.pipePairs) do
		if pair.remove == true then
			table.remove(self.pipePairs, k)
		end
		
		if pair.scored == false and pair.x + pair.pipes['top-pipe'].width < self.bird.x then
			self.score = self.score + 1
			pair.scored = true
		end
		
		pair:update(dt)
	end
	
	for k, pair in pairs(self.pipePairs) do
		for i, pipe in pairs(pair.pipes) do
			if self.bird:collides(pipe) then
				stateMachine:change('score', {
					score = self.score
				})
			end
		end
	end
	
	if self.bird.y > VIRTUAL_HEIGHT then
		stateMachine:change('score', {
			score = self.score
		})
	end
	
	self.bird:update(dt)
end

function PlayState:render()

	for k, pair in pairs(self.pipePairs) do
		pair:render()
	end
	
	self.bird:render()
	
	love.graphics.setFont(scoreFont)
	love.graphics.print('Score: ' .. tostring(self.score), 10, 10)
end
