local Player = {}


function Player:load()
    self.width = 200
    self.height = 40
    self.speed = 1400
    self.x = (gameWindow.width / 2) - (self.width / 2)
    self.y = gameWindow.height - 100

    local centerX = self.x + (self.width / 2)
    local centerY = self.y + (self.height / 2)

    self.physics = {}
    self.physics.body = love.physics.newBody(world, centerX, centerY, "kinematic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setFriction(100)
    self.physics.fixture:setUserData("player")

    --score values
    self.scoreCount = 0
    self.scorePlus = 100
    self.comboCount = 0
    self.comboPlus = 1
    self.highScoreCount = 0



    --sound when ball hits player
    self.hitPlayerSound = love.audio.newSource("assets/sounds/hit-player.wav", "static")
    self.hitPlayerSound:setVolume(0.5)

    --sound when combo multiply is applied
    self.MultiplySound = love.audio.newSource("assets/sounds/point-multi.wav", "static")
    self.MultiplySound:setVolume(0.3)

    --sound when ball hits walls point is added
    self.pointSound = love.audio.newSource("assets/sounds/hit-walls.wav", "static")
    self.pointSound:setVolume(0.5)
end

function Player:movement()
    local vx = 0

    if love.keyboard.isDown("d", "right") and self.x < gameWindow.width - (self.width / 2) then
        vx = self.speed
    end
    if love.keyboard.isDown("a", "left") and self.x > 0 + (self.width / 2) then
        vx = self.speed * -1
    end

    self.physics.body:setLinearVelocity(vx, 0)
end

function Player:comboMulti()
    if self.applyCombo == true then

        if self.comboCount > 0 then
            self.scoreCount = self.scoreCount * self.comboCount
            self.comboCount = 0
        end

        if self.comboCount > 1 then
            self.MultiplySound:play()
        end

        self.applyCombo = false
    end
end

function Player:bestScore()

end

function Player:update(dt)
    self:comboMulti()
    self:syncPhysics()
    self:movement()
end

function Player:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
end

function Player:draw()
    local drawX = self.x - (self.width / 2)
    local drawY = self.y - (self.height / 2)

    love.graphics.rectangle("fill", drawX, drawY, self.width, self.height)
end

function Player:keypressed(key)
	if key == "escape" then
        love.event.quit()
	end
end

function Player:beginContact(a, b, coll)
    local nameA = a:getUserData()
    local nameB = b:getUserData()


    if (nameA == "leftWall" and nameB == "ball") or (nameA == "ball" and nameB == "leftWall") then
        local pointSoundInstance = self.pointSound:clone()
        pointSoundInstance:play()
        self.scoreCount = self.scoreCount + self.scorePlus
        self.comboCount = self.comboCount + self.comboPlus

        print("hit left wall")
    end
    if (nameA == "rightWall" and nameB == "ball") or (nameA == "ball" and nameB == "rightWall") then
        local pointSoundInstance = self.pointSound:clone()
        pointSoundInstance:play()
        self.scoreCount = self.scoreCount + self.scorePlus
        self.comboCount = self.comboCount + self.comboPlus

        print("hit right wall")
    end
    if (nameA == "topWall" and nameB == "ball") or (nameA == "ball" and nameB == "topWall") then
        local pointSoundInstance = self.pointSound:clone()
        pointSoundInstance:play()
        self.scoreCount = self.scoreCount + self.scorePlus
        self.comboCount = self.comboCount + self.comboPlus

        print("hit top wall")
    end
    if (nameA == "player" and nameB == "ball") or (nameA == "ball" and nameB == "player") then
        self.applyCombo = true

        self.hitPlayerSound:play()

        print("hit player")
    end
end



return Player
