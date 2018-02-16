local Entity = require "lib.entities.Entity"

local EntityBlocker = Entity:extends()

function EntityBlocker:new(...)
  EntityBlocker.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/blocker.png")
end

return EntityBlocker