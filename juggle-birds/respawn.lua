local Respawn = {}
local Player = require("player")
local Ball = require("ball")
local Ball2 = require("ball2")

function Respawn:load()
    --sound when ball respawns
    self.repawnSound = love.audio.newSource("assets/sounds/ball-respawn.wav", "static")
    self.repawnSound:setVolume(0.5)

    --sound for new highscore
    self.highscoreSound = love.audio.newSource("assets/sounds/powerup.wav", "static")
end

function Respawn:update(dt)
    self:resetPosition()
end

function Respawn:resetPosition()
    local ballX, ballY = Ball.physics.body:getPosition() --ball 1
    local ballX2, ballY2 = Ball2.physics.body:getPosition() --ball 2

    local posX = gameWindow.width / 2
    local posY = 50

    local posX2 = gameWindow.width / 2
    local posY2 = 130

    if ballY > gameWindow.height + 500 or ballY2 > gameWindow.height + 500 then
        if Player.scoreCount > Player.highScoreCount then
            Player.highScoreCount = Player.scoreCount
            self.highscoreSound:play()
        end

        --resets ball 1
        Ball.physics.body:setPosition(posX, posY)
        Ball.physics.body:setLinearVelocity(0, 0)
        Ball.physics.body:setAngularVelocity(1)
        --resets ball 2
        Ball2.physics.body:setPosition(posX2, posY2)
        Ball2.physics.body:setLinearVelocity(0, 0)
        Ball2.physics.body:setAngularVelocity(-1)

        Player.scoreCount = 0
        Player.comboCount = 0
        self.repawnSound:play()
    end
end

return Respawn
