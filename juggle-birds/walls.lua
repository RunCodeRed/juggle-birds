local Wall = {}

function Wall:load()
    self.physics = {}
    self.physics.body = love.physics.newBody(world, 0, 0, "static")
    --makes left wall
    self.physics.leftShape = love.physics.newEdgeShape(0, 0, 0, gameWindow.height)
    self.physics.leftFixture = love.physics.newFixture(self.physics.body, self.physics.leftShape)
    self.physics.leftFixture:setUserData("leftWall")
    --makes right wall
    self.physics.rightShape = love.physics.newEdgeShape(gameWindow.width, 0, gameWindow.width, gameWindow.height)
    self.physics.rightFixture = love.physics.newFixture(self.physics.body, self.physics.rightShape)
    self.physics.rightFixture:setUserData("rightWall")
    --makes top wall
    self.physics.topShape = love.physics.newEdgeShape(0, 0, gameWindow.width, 0)
    self.physics.topFixtures = love.physics.newFixture(self.physics.body, self.physics.topShape)
    self.physics.topFixtures:setUserData("topWall")
end

function Wall:update(dt)

end

function Wall:draw()

end

return Wall
