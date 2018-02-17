local Entity = require "lib.entities.Entity"

local EntityWhoosh = Entity:extends()

function EntityWhoosh:new(...)
  EntityWhoosh.super.new(self, ...)
  
  local f = self.name == "ent_whoosh" and "whoosh.png" or "whoosh_purple.png"
  self.image = love.graphics.newImage("assets/gfx/" .. f)
  self.is_exit = true
  self.trigger = nil

  self:add("Animate")
  self.Animate:add({
    normal = {
      "1-4", 1, 0.1, false, function()
        self.remove = true
        if self.name == "ent_whoosh_purple" then
          Game:load_level()
        end
      end
    }
  })
  self.state = self.Animate:state("normal")
end

return EntityWhoosh