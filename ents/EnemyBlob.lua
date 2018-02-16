local Enemy = require "lib.entities.Enemy"

local EnemyBlob = Enemy:extends()

function EnemyBlob:new(...)
  EnemyBlob.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ run = {"1-3", 3, 0.2, true} })

  self.state = self.Animate:state("run_flipped")
end

return EnemyBlob