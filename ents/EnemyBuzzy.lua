local Enemy = require "lib.entities.Enemy"

local EnemyBuzzy = Enemy:extends()

function EnemyBuzzy:new(...)
  EnemyBuzzy.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ run = {"4-5", 6, 0.2, true} })
  self.state = self.Animate:state("run_flipped")
  self.grounded = true
  self.speed = 20
end

function EnemyBuzzy:update(dt)
  EnemyBuzzy.super.update(self, dt)
  if self.grounded then
    self.vel.y = self.vel.y - (300 + self.speed)
  end
end

return EnemyBuzzy