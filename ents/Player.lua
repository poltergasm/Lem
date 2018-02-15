local DynamicEntity = require "lib.entities.Dynamic"
local Player = DynamicEntity:extends()

function Player:new(...)
  Player.super.new(self, ...)

  self.is_player = true
  self.is_gripping = false
  self.gripped_ent = nil
  self.image = love.graphics.newImage("assets/gfx/player.png")

  self:add("Animate")
  self.Animate:add({
    idle = {"1-2", 1, 0.2, true},
    jump = {"3-3", 1, 0.2, true},
    walk = {"10-11", 1, 0.1, true},
  })

  self.state = self.Animate:state("idle")
end

function Player:move_right(dt)
  if self.grounded then self.state = self.Animate:state("walk") end
  if not self.grounded then self.state = self.Animate:state("jump") end
  self.vel.x = self.vel.x + self.speed

  self.dir = 1
  if self.dir == -1 then
    self.vel.x = 0
  end
end

function Player:move_left(dt)
  if self.grounded then self.state = self.Animate:state("walk_flipped") end
  if not self.grounded then self.state = self.Animate:state("jump_flipped") end
  self.vel.x = self.vel.x + self.speed
  self.dir = -1

  if self.dir == 1 then
    self.vel.x = 0
  end
end

function Player:jump(dt)
  if self.dir == 1 then
    self.state = self.Animate:state("jump")
  else
    self.state = self.Animate:state("jump_flipped")
  end

  if self.grounded then
    self.vel.y = self.vel.y - 400
    self.is_gripping = false
    self.gripped_ent = nil
  end
end

function Player:is_ent_grippable(ent)
  local yReq = math.abs(ent.h - self.h) + 3
  local xReq = math.abs(ent.w / 2 + self.w / 2) + 5
  local xDiff = ent.pos.x - self.pos.x
  local yDiff = ent.pos.y - self.pos.y
  
  if ent.name == "ent_crate" or ent.name == "ent_spring" then  
    if ((self.dir > 0 and xDiff < 0) or (self.dir < 0 and xDiff > 0)) then
      return false
    end
  end
  
  if (ent.name == "ent_crate" or ent.name == "ent_spring") and 
      math.abs(yDiff) <= yReq and math.abs(xDiff) <= xReq and self.grounded then
    return true
  end
end

function Player:collides(normal, other)
  if other.name == "ent_crate" and normal.y ~= -1 then
    other.dir = self.dir
    other.vel.x = (self.vel.x)
  
  elseif other.name == "ent_box_block" then
    if normal.y == 1 and not other.used then
      other.used = true
      --snd.boxblock:play()
      Game:create_box(other.pos.x, other.pos.y-48)
    end
  end
end

function Player:grip_check()
  if self.gripped_ent ~= nil and self.is_gripping then
    self.gripped_ent.dir = self.dir
    self.gripped_ent.max_vel.x = self.max_vel.x
    self.gripped_ent.vel.x = self.vel.x
  end
end

function Player:update(dt)
  Player.super.update(self, dt)

  if not self.grounded then
    self.is_gripping = false
    self.gripped_ent = nil
  else
    if not self.is_gripping and self.vel.x == 0 then
      if self.dir == 1 then
        self.state = self.Animate:state("idle")
      else
        self.state = self.Animate:state("idle_flipped")
      end
    end
  end
  
  if self.is_gripping then
    self.max_vel.x = self.orig_max_vel.x/1.7
  else 
    self.max_vel.x = self.orig_max_vel.x
  end
end

return Player
