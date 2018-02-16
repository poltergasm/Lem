local MapManager = {}

local MAPS = {
  {
    idx = 1,
    file = "map_1",
    name = "Elementary Fields"
  },

  {
    idx   = 2,
    file  = "map_2",
    name  = "The blob splatting theory"
  },

  {
    idx   = 3,
    file  = "map_3",
    name  = "Hot Miami Nights"
  }
}

function MapManager:new()
  self.current = 3
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