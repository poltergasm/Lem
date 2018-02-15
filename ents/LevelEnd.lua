local Entity = require "lib.entities.Entity"

local LevelEnd = Entity:extends()

function LevelEnd:new(...)
  LevelEnd.super.new(self, ...)
  
  self.is_exit = true
end

return LevelEnd