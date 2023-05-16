push = require 'push'

Class = require 'class'


require 'Bird'
require 'Pipe'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local background_scroll = 0


local ground = love.graphics.newImage('base.png')
local ground_scroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local LOOPING_POINT = 313

local bird = Bird()
local pipes = {}

local spawnTimer = 0

function love.load()
	
	math.randomseed(os.time())
	
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Flappy')
	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	
	})
	
	love.keyboard.keysPressed = {}
	
end

function love.update(dt)
	background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	
	spawnTimer = spawnTimer + dt
	
	if spawnTimer > 2 then
		table.insert(pipes, Pipe())
		spawnTimer = 0
	end
	
	for k, pipe in pairs(pipes) do
		pipe:update(dt)
	end
	
	bird:update(dt)
	
	love.keyboard.keysPressed = {}
end




function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end




function love.resize(w, h)
	push:resize(w, h)
end

function love.draw()
	push:start()
	
	love.graphics.draw(background, -background_scroll, 0)
	
	for k, pipe in pairs(pipes) do
		pipe:render()
	end
	
	love.graphics.draw(ground, -ground_scroll, VIRTUAL_HEIGHT - 20)
	
	bird:render()
	
	push:finish()
end
