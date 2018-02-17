local Class = require "lib.Class"
local Vec2  = require "lib.Vector2"

local Label = Class:extends()

local gradImg = love.image.newImageData(1, 2)
gradImg:setPixel(0, 0, 249, 38, 114,255)
gradImg:setPixel(0, 1, 252, 159, 192)
local grad = love.graphics.newImage(gradImg)

function Label:new(x, y, w, h, text, color, align)
  self.pos = Vec2(x or 0, y or 0)
  self.w = w
  self.h = h
  self.text = text
  if color then
    self.color = color
  else
    local r,g,b,a = love.graphics.getColor()
    self.color = {r, g, b, a}
  end
  self.align = align or "center"
end

function Label:update(dt) end

function Label:draw()
  local font = love.graphics.getFont()
  local _, font_lines = font:getWrap(self.text, self.w)
  local font_h = font:getHeight()
  
  local r,g,b,a = love.graphics.getColor()
  if self.background then
    love.graphics.setColor(255, 255, 255, 255)
    local linew = love.graphics.getLineWidth()
    love.graphics.setLineWidth(10)
    love.graphics.rectangle("line", self.pos.x - 5, self.pos.y - (font_h / 2 * #font_lines) - 5, self.w + 20, (self.h * #font_lines) + 10, 5, 5)
    love.graphics.setColor(r, g, b, a)
    love.graphics.setLineWidth(linew)

    love.graphics.setColor(249, 38, 114,255)
    love.graphics.draw(grad, self.pos.x, self.pos.y - (font_h / 2 * #font_lines), 0, self.w + 10, self.h * #font_lines / 2)
    --love.graphics.rectangle("fill", self.pos.x, self.pos.y - (font_h / 2 * #font_lines), self.w + 10, self.h * #font_lines)
    love.graphics.setColor(r, g, b, a)
  end
  
  love.graphics.setColor(self.color)
  love.graphics.printf(self.text, self.pos.x + 5, self.pos.y - (font_h / 2 * #font_lines), self.w, self.align)
  love.graphics.setColor(r, g, b, a)
end

return Label