local Entity = require "lib.entities.Entity"

local EntitySwitch = Entity:extends()

function EntitySwitch:new(...)
  EntitySwitch.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/blue_switch.png")
  self.stopped = false
  self.pressed = false

  self:add("Animate")
  self.Animate:add({
    normal = {"1-1", 1, 0.2},
    pressed = {
      "1-2", 1, 0.2, false, function()
        self.state = self.Animate:state("normal")
      end
    }
  })
  self.state = self.Animate:state("normal")
end

function EntitySwitch:press()
  self.state = self.Animate:state("pressed")
  --snd.hit:play()
  for i = #Game.entity_mgr.entities, 1, -1 do
    local ent = Game.entity_mgr.entities[i]
    if ent.name ~= nil and ent.name == "ent_vert_platform" then
      ent.stopped = false
    end
  end
end

return EntitySwitch