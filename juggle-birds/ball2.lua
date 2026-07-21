local Ball2 = {}
local Player = require("player")

function Ball2:load()
    --ball values
    self.sprite = love.graphics.newImage("assets/sprites/bird-ball2.png")
    self.radius = self.sprite:getWidth()
    self.x = gameWindow.width / 2
    self.y = 130
    self.applyForce = false
    self.changeDirection = false
    self.changeDirectionForce = 1000


    --ball physics
    self.physics = {}
    self.physics.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.physics.shape = love.physics.newCircleShape(self.radius)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setRestitution(1)
    self.physics.body:setAngularVelocity(-1)
    self.physics.fixture:setUserData("ball")
end

function Ball2:update(dt)
    self:syncPhysics()
    self:applyPower()
    self:applyeOffset()
end



function Ball2:applyPower()
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

function Ball2:applyeOffset()
    local ballX = self.physics.body:getX()

    if self.changeDirection == true  and ballX > gameWindow.width / 2 then
        self.physics.body:applyLinearImpulse(-self.changeDirectionForce, 0)
        self.changeDirection = false
    elseif self.changeDirection == true then
        self.physics.body:applyLinearImpulse(self.changeDirectionForce, 0)
        self.changeDirection = false
    end
end

function Ball2:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
end

function Ball2:draw()
    local rot = self.physics.body:getAngle()
    local ox = self.sprite:getWidth() / 2
    local oy = self.sprite:getHeight() / 2

    love.graphics.draw(self.sprite, self.x, self.y, rot, 2, 2, ox, oy)
end

function Ball2:beginContact(a, b, coll)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

    if (nameA == "ball" and nameB == "ball") or (nameA == "ball" and nameB == "ball") then
        self.applyForce = true
    end
    if (nameA == "player" and nameB == "ball") or (nameA == "ball" and nameB == "player") then
        self.changeDirection = true
    end
end



return Ball2
