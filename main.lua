require "globals"

function love.load()
  love.window.setTitle("Lem")
  MAIN_FONT = love.graphics.newFont("assets/fonts/Gamer.ttf", 58)
  SMALL_FONT = love.graphics.newFont("assets/fonts/Gamer.ttf", 32)
  love.graphics.setFont(MAIN_FONT)
  Canvas:setFilter("nearest", "nearest")
  Keyboard:hook_events()
  SceneManager:add({
    Game = Game
  })
  SceneManager:switch("Game")
end

local last_paused = nil

function love.update(dt)
  GamePad:update(dt)
  Jukebox:update(dt)
  
  if Input:start() then
    if paused then
      local gt = love.timer.getTime()
      if last_paused and gt > last_paused+1 then
        last_paused = gt
        paused = false
      end
    else
      local gt = love.timer.getTime()
      if (last_paused and gt > last_paused+1) or last_paused == nil then
        last_paused = gt
        paused = true
      end
    end
  end

  SceneManager:update(dt)
end

function love.draw()
  love.graphics.setCanvas(Canvas)
  SceneManager:draw()
  love.graphics.setCanvas()

  local scale = love.graphics.getWidth() / Canvas:getWidth()
  love.graphics.draw(Canvas, 0, 0, 0, scale, scale)
end