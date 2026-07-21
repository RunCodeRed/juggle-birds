love.graphics.setDefaultFilter("nearest", "nearest")
local Player = require("player")
local Ball = require("ball")
local Ball2 = require("ball2")
local Wall = require("walls")
local Hud = require("hud")
local Respawn = require("respawn")
local Background = require("background")
local Menu = require("menu")

function love.load()
    gameWindow = {}
    gameWindow.width = love.graphics.getWidth()
    gameWindow.height = love.graphics.getHeight()

    world = love.physics.newWorld(0, 300, true)
    world:setCallbacks(beginContact, endContact)

    Background:load()
    Player:load()
    Ball:load()
    Ball2:load()
    Wall:load()
    Hud:load()
    Respawn:load()
    Menu:load()
end

function love.update(dt)
    Menu:update(dt)
    Player:update(dt)
    Background:update(dt)

    if gameStart == true then
        world:update(dt)

        Ball:update(dt)
        Ball2:update(dt)
        Wall:update(dt)
        Hud:update(dt)
        Respawn:update(dt)
    end
end

function love.draw()
        Background:draw()
        Player:draw()
        Ball:draw()
        Ball2:draw()
        Wall:draw()
        Hud:draw()
        Menu:draw()
end

function love.mousepressed(x, y, mouseButton, istouch)
    Menu:mousepressed(x, y, mouseButton, istouch)
end

function love.keypressed(key)
	Player:keypressed(key)
end

function beginContact(a, b, coll)
    Player:beginContact(a, b, coll)
    Ball:beginContact(a, b, coll)
    Ball2:beginContact(a, b, coll)
end

function endContact(a, b, coll)

end
