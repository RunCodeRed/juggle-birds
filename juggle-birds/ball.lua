local Ball = {}
local Player = require("player")

function Ball:load()
    --ball values
    self.sprite = love.graphics.newImage("assets/sprites/bird-ball.png")
    self.radius = self.sprite:getWidth()
    self.x = gameWindow.width / 2
    self.y = 50
    self.applyForce = false
    self.changeDirection = false
    self.changeDirectionForce = 1000


    --ball physics
    self.physics = {}
    self.physics.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.physics.shape = love.physics.newCircleShape(self.radius)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setRestitution(1)
    self.physics.body:setAngularVelocity(1)
    self.physics.fixture:setUserData("ball")
end

function Ball:update(dt)
    self:syncPhysics()
    self:applyPower()
    self:applyeOffset()
end



function Ball:applyPower()
    if self.applyForce == true then
        local vx, vy = self.physics.body:getLinearVelocity()
        local speedMulti = 1.5
        local speedMax = 500

        if vx > speedMax then
            vx = speedMax
        end
        if vy > speedMax then
            vy = speedMax
        end

        vx = vx * speedMulti
        vy = vy * speedMulti

        self.physics.body:setLinearVelocity(vx, vy)
        self.applyForce = false
    end
end

function Ball:applyeOffset()
    local ballX = self.physics.body:getX()

    if self.changeDirection == true  and ballX > gameWindow.width / 2 then
        self.physics.body:applyLinearImpulse(-self.changeDirectionForce, 0)
        self.changeDirection = false
    elseif self.changeDirection == true then
        self.physics.body:applyLinearImpulse(self.changeDirectionForce, 0)
        self.changeDirection = false
    end
end



function Ball:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
end

function Ball:draw()
    local rot = self.physics.body:getAngle()
    local ox = self.sprite:getWidth() / 2
    local oy = self.sprite:getHeight() / 2

    love.graphics.draw(self.sprite, self.x, self.y, rot, 2, 2, ox, oy)
end

function Ball:beginContact(a, b, coll)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

    if (nameA == "ball" and nameB == "ball") or (nameA == "ball" and nameB == "ball") then
        self.applyForce = true
    end
    if (nameA == "player" and nameB == "ball") or (nameA == "ball" and nameB == "player") then
        self.changeDirection = true
    end
end



return Ball
