local module = {}
local angle = 0.0
local snowParticles = {}

local width, height, maxParticles

function module:load(width, height, maxParticles)
  self.width, self.height, self.maxParticles = width, height, maxParticles

  for i = 1, maxParticles do
    table.insert(snowParticles, {
      x = math.random() * width,
      y = math.random() * height,
      r = math.random() * 4 + 1,
      d = math.random() * maxParticles
    })
  end
end

function module:update(dt)
  angle = angle + 0.01

  for i, p in pairs(snowParticles) do
    p.y = p.y + math.cos(angle + p.d) + 1 + 5
    p.x = p.x + math.sin(angle) * 0.5

    if p.y > self.height then
      p.x = math.random() * self.width
      p.y = -10

    elseif p.x > self.width + 5 or p.x < -5 then
      -- Exit from right
      if (math.sin(angle) > 0) then p.x = -5

      -- Exit from left
      else p.x = self.width + 5
      end
    end
  end
end

function module:draw()
  love.graphics.setColor(255, 255, 255, 140)

  for i, p in pairs(snowParticles) do
    love.graphics.rectangle("fill", p.x, p.y, 2, 5)
  end

  love.graphics.setColor(255, 255, 255, 255)
end

return module