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
  },

  {
    idx   = 4,
    file  = "map_4",
    name  = "Timing is everything"
  },

  {
    idx   = 5,
    file  = "map_5",
    name  = "Winter Wonderland"
  },

  {
    idx   = 6,
    file  = "map_6",
    name  = "Lem's little helper"
  },

  {
    idx   = 7,
    file  = "map_7",
    name  = "Yarr! A pirate's life 'fer me"
  }
}

function MapManager:new()
  self.current = 6
  return self
end

function MapManager:map()
  return "assets/maps/" .. MAPS[self.current].file .. ".lua"
end

function MapManager:map_name()
  return MAPS[self.current].name
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