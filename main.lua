require "globals"

function love.load()
  Game.Canvas:setFilter("nearest", "nearest")
  Keyboard:hook_events()
  SceneManager:add({
    Game = Game
  })
  SceneManager:switch("Game")
end

function love.update(dt)
  GamePad:update(dt)
  SceneManager:update(dt)
end

function love.draw()
  love.graphics.setCanvas(Game.Canvas)
  SceneManager:draw()
  love.graphics.setCanvas()

  local scale = love.graphics.getWidth() / Game.Canvas:getWidth()
  love.graphics.draw(Game.Canvas, 0, 0, 0, scale, scale)
end