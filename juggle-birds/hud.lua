local Hud = {}
local Player = require("player")


function Hud:load()
    self.largeFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 60)
    self.mediumFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 30)
    self.normalFont = love.graphics.newFont("assets/fonts/Tiny5/Tiny5-Regular.ttf", 12)
end



function Hud:update(dt)

end



function Hud:draw()
    if gameStart == true then
        love.graphics.setColor(1, 1, 0)
        love.graphics.setFont(self.largeFont)
        love.graphics.print("SCORE: " .. Player.scoreCount, 10, 0) --draws score
        love.graphics.setFont(self.normalFont)
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(1, 0, 0)
        love.graphics.setFont(self.mediumFont)
        love.graphics.print("x" .. Player.comboCount .. " COMBO MULTIPLIER", 10, 60) --draws combo multi
        love.graphics.setFont(self.normalFont)
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(0, 1, 0)
        love.graphics.setFont(self.mediumFont)
        love.graphics.print("HIGHSCORE: " .. Player.highScoreCount, 10, 120)
        love.graphics.setFont(self.normalFont)
        love.graphics.setColor(1, 1, 1)
    end
end




return Hud
