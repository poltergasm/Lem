local DynamicEntity = require "lib.entities.Dynamic"
local EntitySpring = DynamicEntity:extends()

function EntitySpring:new(...)
  EntitySpring.super.new(self, ...)
  
  self.is_spring = true
  self.image = love.graphics.newImage("assets/gfx/spring.png")

  self:add("Animate")
  self.Animate:add({
    ready   = {"3-3", 1, 0.2},
    pressed = {
      "1-3", 1, 0.1, false, function()
        self.state = self.Animate:state("ready")
      end
    } 
  })
  self.state = self.Animate:state("ready")
end

function EntitySpring:pressed(ent)
  self.state = self.Animate:state("pressed")
  ent:bounce()
end

return EntitySpring