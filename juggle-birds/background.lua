local Background = {}

local gameWindow = {}
gameWindow.width = love.graphics.getWidth()
gameWindow.height = love.graphics.getHeight()

function Background:load()
    --background music
    self.music = love.audio.newSource("assets/sounds/daydream.mp3", "static")
    self.music:setLooping(true)
    self.music:play()

    gameBackground = love.graphics.newImage("assets/sprites/background.png")

    sun = {
        width = 200,
        height = 200,
    }

    listOfClouds = {}
    for i = 1, 15 do
        local cloud = {
            x = love.math.random(0, gameWindow.width),
            y = love.math.random(0, 500),
            width = love.math.random(50, 150),
            height = 40,
            speed = love.math.random(0.5, 1)
        }
        table.insert(listOfClouds, cloud)
    end
end

function Background:update(dt)
    for i, cloud in ipairs(listOfClouds) do
        cloud.x = cloud.x + cloud.speed
        if cloud.x > gameWindow.width then
            cloud.x = 0 - cloud.width
        end
    end

end

function Background:draw(dt)
    love.graphics.draw(gameBackground)

    local sunX = gameWindow.width - 270
    local sunY = 70

    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", sunX, sunY, sun.width, sun.height)
    love.graphics.setColor(1, 1, 1)

    for i, cloud in ipairs(listOfClouds) do
        love.graphics.rectangle("fill", cloud.x, cloud.y, cloud.width, cloud.height)
    end
end

return Background
