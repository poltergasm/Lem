local Entity = require "lib.entities.Entity"

local EntityWhoosh = Entity:extends()

function EntityWhoosh:new(...)
  EntityWhoosh.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/whoosh.png")
  self.is_exit = true

  self:add("Animate")
  self.Animate:add({
    normal = {
      "1-4", 1, 0.1, false, function()
        self.remove = true
      end
    }
  })
  self.state = self.Animate:state("normal")
end

return EntityWhoosh