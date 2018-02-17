require "globals"

function love.load()
  love.window.setTitle("Lem")
  MAIN_FONT = love.graphics.newFont("assets/fonts/Gamer.ttf", 58)
  love.graphics.setFont(MAIN_FONT)
  Canvas:setFilter("nearest", "nearest")
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
  love.graphics.setCanvas(Canvas)
  SceneManager:draw()
  love.graphics.setCanvas()

  love.graphics.draw(Canvas, 0, 0, 0, scale, scale)
end