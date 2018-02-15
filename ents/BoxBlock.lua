local Entity = require "lib.entities.Entity"

local EntityBoxBlock = Entity:extends()

function EntityBoxBlock:new(...)
  EntityBoxBlock.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/boxblock.png")
end

return EntityBoxBlock