local MapManager = {}

local MAPS = {
  {
    idx = 1,
    file = "map_01",
    name = "Elementary Fields"
  },

  {
    idx   = 2,
    file  = "map_02",
    name  = "The blob splatting theory"
  }
}

function MapManager:new()
  self.current = 1
  return self
end

function MapManager:map()
  return "assets/maps/" .. MAPS[self.current].file .. ".lua"
end

function MapManager:next_map()
  self.current = self.current + 1
end

function MapManager:prev_map()
  if self.current > 1 then 
    self.current = self.current - 1
  end
end

return MapManager