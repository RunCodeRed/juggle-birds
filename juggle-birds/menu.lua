local Menu = {}

local function checkHover(mx, my, rectx, recty, rectw, recth)
    return mx < rectx + rectw and
        rectx < mx and
        my < recty + recth and
        recty < my
end

local gameWindow = {}
gameWindow.width = love.graphics.getWidth()
gameWindow.height = love.graphics.getHeight()

local button = {
    x = 260,
    y = gameWindow.height / 2,
    width = 300,
    height = 100,
    isHovered = false
}

function Menu:load()
    gameStart = false
    self.selectSound = love.audio.newSource("assets/sounds/select-sound.wav", "static")
    self.largeFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 40)
    self.mediumFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 30)
    self.normalFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 12)
end

function Menu:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()

    if gameStart == false then
        button.isHovered = checkHover(mouseX, mouseY, button.x, button.y, button.width, button.height)
    end
end

function Menu:draw()

    if gameStart == false then

        if button.isHovered then
            love.graphics.setColor(1, 0, 0.5)
        else
            love.graphics.setColor(1, 1, 0)
        end

        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

        love.graphics.setFont(self.largeFont)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Play", button.x, button.y, 0, 1, 1, -100, -20)
        love.graphics.setFont(self.mediumFont)

        love.graphics.print("Music by Adiutorium on opengameart.org", 10, 960)
    end

    love.graphics.setColor(1, 1, 1)
end

function Menu:mousepressed(x, y, mouseButton, istouch)
    if mouseButton == 1 then
        if gameStart == false then
            self.selectSound:play()
        end
        if button.isHovered then
            gameStart = true
        end
	end
end


return Menu
