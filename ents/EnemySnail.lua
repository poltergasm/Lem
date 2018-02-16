local Enemy = require "lib.entities.Enemy"

local EnemySnail = Enemy:extends()

function EnemySnail:new(...)
  EnemySnail.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ run = {"1-2", 7, 0.2, true} })
  self.state = self.Animate:state("run_flipped")
  self.is_snail = true
end

function EnemySnail:collides(normal, other)
  if other.name == "ent_crate" and normal.y ~= -1 then
    other.dir = self.dir
    other.vel.x = self.vel.x
  else
    EnemySnail.super.collides(self, normal, other)
  end
end

return EnemySnail