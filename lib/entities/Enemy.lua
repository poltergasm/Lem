local DynamicEntity = require "lib.entities.Dynamic"

local Enemy = DynamicEntity:extends()

function Enemy:new(...)
  Enemy.super.new(self, ...)
  self.is_enemy = true
end

function Enemy:update(dt)
  Enemy.super.update(self, dt)
  if self.alive then
    self.vel.x = self.vel.x + self.speed
  end
end

function Enemy:hit_edge_left()
  self.dir = 1
  self.state = self.Animate:state("run_flipped")
end

function Enemy:hit_edge_right()
  self.dir = 1
  self.state = self.Animate:state("run")
end

function Enemy:collides(normal, other)
  if other.is_player then
    if self.is_snail and normal.y == -1 then return end
    other:die()
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

return Enemy