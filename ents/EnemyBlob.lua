local DynamicEntity = require "lib.entities.Dynamic"

local EnemyBlob = DynamicEntity:extends()

function EnemyBlob:new(...)
  EnemyBlob.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ run = {"1-3", 3, 0.2, true} })

  self.state = self.Animate:state("run_flipped")
end

function EnemyBlob:update(dt)
  EnemyBlob.super.update(self, dt)
  if self.alive then
    self.vel.x = self.vel.x + self.speed
  end
end

function EnemyBlob:collides(normal, other)
  if normal.x == -1 then
    self.dir = -1
    self.state = self.Animate:state("run")
  elseif normal.x == 1 then
    self.dir = 1
    self.state = self.Animate:state("run_flipped")
  end
end

return EnemyBlob