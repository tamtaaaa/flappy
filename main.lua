push = require 'push'

Class = require 'class'


require 'Bird'
require 'Pipe'
require 'Pipes'

require 'StateMachine'

require 'states/BaseState'
require 'states/StartState'
require 'states/PlayState'
require 'states/ScoreState'


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
local pipePairs = {}

local spawnTimer = 0

function love.load()
	
	math.randomseed(os.time())
	
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Flappy')
	
	
	mediumFont = love.graphics.newFont('font.ttf', 16)
	scoreFont = love.graphics.newFont('font.ttf', 28)
	
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	
	})
	
	
	stateMachine = StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end,
		['score'] = function() return ScoreState() end
	}
	
	stateMachine:change('start')
	
	love.keyboard.keysPressed = {}
	
end

function love.update(dt)
	background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % LOOPING_POINT
	stateMachine:update(dt)
	
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
	
	stateMachine:render()
	
	love.graphics.draw(ground, -ground_scroll, VIRTUAL_HEIGHT - 20)
	
	
	push:finish()
end
