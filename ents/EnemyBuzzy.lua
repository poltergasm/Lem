local DynamicEntity = require "lib.entities.Dynamic"

local EnemyBuzzy = DynamicEntity:extends()

function EnemyBuzzy:new(...)
  EnemyBuzzy.super.new(self, ...)
  
  self.image = love.graphics.newImage("assets/gfx/enemies.png")

  self:add("Animate")
  self.Animate:add({ fly = {"4-5", 6, 0.2, true} })
  self.state = self.Animate:state("fly_flipped")
  self.grounded = true
  self.speed = 20
end


function EnemyBuzzy:update(dt)
  EnemyBuzzy.super.update(self, dt)
  self.vel.x = self.vel.x + self.speed
  if self.grounded then
    self.vel.y = self.vel.y - (300 + self.speed)
  end
end

function EnemyBuzzy:collides(normal, other)
  if normal.x == -1 then
    self.dir = -1
    self.state = self.Animate:state("fly")
  elseif normal.x == 1 then
    self.dir = 1
    self.state = self.Animate:state("fly_flipped")
  end
end

return EnemyBuzzy