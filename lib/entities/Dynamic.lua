local Entity = require "lib.entities.Entity"
local Vec2   = require "lib.Vector2"
local DynamicEntity = Entity:extends()

local PHYSICS_MULT = 65

function DynamicEntity:new(name, x, y, w, h, max_vel_x, max_vel_y, mass, speed)
  DynamicEntity.super.new(self, name, x, y, w, h)

  self.max_vel = Vec2(max_vel_x or 64, max_vel_y or 100)
  self.orig_max_vel = Vec2(max_vel_x or 64, max_vel_y or 100)
  self.vel = Vec2(0, 0)
  self.dir = 1
  self.grounded = false
  self.mass = mass or 1
  self.speed = speed or 100
  self.is_dynamic = true
  self.alive = true
end

function DynamicEntity:update_physics(dt)
  if self.pos.x < 0 then
    if self.is_enemy then
      self:hit_edge_left()
    end
    self.pos.x = 5
  elseif self.pos.x > CANVAS_WIDTH-32 then
    if self.is_enemy then
      self:hit_edge_right()
    end
    self.pos.x = CANVAS_WIDTH-32
  end

  if self.grounded == true then
    self.vel.x = self.vel.x - 50 * dt * PHYSICS_MULT
  else
    self.vel.x = self.vel.x - (8 * self.mass) * dt * PHYSICS_MULT
  end
  
  self.vel.y = self.vel.y + (Game.world.gravity) * dt * PHYSICS_MULT

  if self.vel.x > self.max_vel.x then self.vel.x = self.max_vel.x end
  if self.vel.x < 0 then self.vel.x = 0 end

  self.pos.x = self.pos.x + self.dir*self.vel.x*dt
  self.pos.y = self.pos.y + (self.vel.y)*dt
end

function DynamicEntity:bounce()
  self.vel.y = self.vel.y - 800
  self.is_gripping = false
  self.gripped_ent = nil
end

function DynamicEntity:check_cols(this, other)
  if not other.is_spring then
    if self.vel.y ~= nil then
      if this.y == -1 then
        self.vel.y = 0
        self.grounded = true
      elseif this.y == 1 then
        self.vel.y = -self.vel.y/4
      end
      if this.x ~= 0 and other.name == nil then
        self.vel.x = 0
      end
    end
  end
end

return DynamicEntity