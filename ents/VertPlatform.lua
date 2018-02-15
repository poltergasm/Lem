local Entity = require "lib.entities.Entity"

local EntityVertPlatform = Entity:extends()

function EntityVertPlatform:new(...)
  EntityVertPlatform.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/platform.png")
  self.stopped = false
end

function EntityVertPlatform:update(dt)
  EntityVertPlatform.super.update(self, dt)

  -- God help me.
  if not self.stopped then
    local ytop = self.orig_y - 128
    local yar
    if self.pos.y == ytop then
      self.ydir = "down"
    elseif self.pos.y == self.orig_y then
      self.ydir = "up"
    end

    if self.ydir == "up" and self.pos.y ~= ytop then yar = self.pos.y - 1 elseif self.ydir == "down" then yar = self.pos.y + 1 end
    local newY = yar
    Game.world:move(self, self.pos.x, newY)
    self.pos.y = newY
  end
end

return EntityVertPlatform