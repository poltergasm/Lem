local DynamicEntity = require "lib.entities.Dynamic"
local EntityCrate = DynamicEntity:extends()

function EntityCrate:new(...)
  EntityCrate.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/crate.png")
end

function EntityCrate:collides(normal, other)
  if other.name == "ent_crate" and normal.y ~= -1 then
    other.dir = self.dir
    other.vel.x = (self.vel.x)

  elseif (other.name == "ent_blob" or other.name == "ent_snail") and normal.y == -1 then
    other.remove = true
  end
end

return EntityCrate