local Class = require "lib.Class"

local EntityManager = Class:extends()

function EntityManager:new()
  self.entities = {}
  self.world = nil
end

function EntityManager:set_world(world)
  self.world = world
end

function EntityManager:add(ent)
  table.insert(self.entities, ent)
  self.world:add(ent, ent.pos.x, ent.pos.y, ent.w, ent.h)
end

function EntityManager:update(dt)
  for i = #self.entities, 1, -1 do
    if self.entities[i].remove then
      self.world:remove(self.entities[i])
      table.remove(self.entities, i)
    else
      self.entities[i]:update(dt)
    end
  end
end

function EntityManager:draw()
  for i = #self.entities, 1, -1 do
    self.entities[i]:draw()
  end
end

return EntityManager