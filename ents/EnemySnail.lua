local DynamicEntity = require "lib.entities.Dynamic"

local EnemySnail = DynamicEntity:extends()

function EnemySnail:new(...)
  EnemySnail.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ run = {"1-2", 7, 0.2, true} })
  self.state = self.Animate:state("run_flipped")
end

function EnemySnail:update(dt)
  EnemySnail.super.update(self, dt)
  self.vel.x = self.vel.x + self.speed
end

function EnemySnail:collides(normal, other)
  if other.name == "ent_crate" and normal.y ~= -1 then
    other.dir = self.dir
    other.vel.x = self.vel.x
  else
    if normal.x == -1 then
      self.dir = -1
      self.state = self.Animate:state("run")
    elseif normal.x == 1 then
      self.dir = 1
      self.state = self.Animate:state("run_flipped")
    end
  end
end

return EnemySnail