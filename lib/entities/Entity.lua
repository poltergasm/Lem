local Class = require "lib.Class"
local Vec2  = require "lib.Vector2"

local Entity = Class:extends()

function Entity:new(name, x, y, w, h)
  self.pos = Vec2(x or 0, y or 0)
  self.w   = w or 0
  self.h   = h or 0
  self.image = nil
  self.remove = false
  self.is_player = false
  self.state  = nil
  self.name   = name or "base_entity"
  self.is_dynamic = false

  -- for collision filters
  self.is_coin = false
  self.is_wall = false
  self.is_exit = false
  self.is_spring = false
end

function Entity:add(c, ...)
  local comp = require("lib.components." .. c)(self, ...)
  self[c] = comp
end

function Entity:remove()
  self.remove = true
  Game.world:remove(self)
end

function Entity:update(dt)
  if self.state then
    self.state:update(dt)
  end
end

function Entity:draw()
  if self.state then
    self.state:draw(self.image, self.pos.x, self.pos.y)
  else
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
  end
end

return Entity