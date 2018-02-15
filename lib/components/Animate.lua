local Class = require "lib.Class"
local anim8 = require "lib.anim8"
local Animate = Class:extends()

function Animate:new(ent)
  self.grid = anim8.newGrid(ent.w, ent.h, ent.image:getDimensions())
  self.animations = {}
end

function Animate:add(a)
  assert(a ~= nil and type(a) == "table", "Animate:anims expects a table as a parameter")

  -- Holy fuck. This needs fixing badly.
  for k,v in pairs(a) do
    if v[5] and type(v[5]) == "function" then
      self.animations[k] = anim8.newAnimation(self.grid(v[1], v[2]), v[3], v[5])
      if v[4] then
        self.animations[k .. "_flipped"] = anim8.newAnimation(self.grid(v[1], v[2]), v[3], v[5]):flipH()
      end
    else
      self.animations[k] = anim8.newAnimation(self.grid(v[1], v[2]), v[3])
      if v[4] then
        self.animations[k .. "_flipped"] = anim8.newAnimation(self.grid(v[1], v[2]), v[3]):flipH()
      end
    end
  end
end

function Animate:state(s)
  assert(self.animations[s], "The state '" .. s .. "' does not exist")
  return self.animations[s]
end

return Animate