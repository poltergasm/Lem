local PauseMenu = {}

local xoff = 40
local yoff = 50

local arrow_xoff = xoff-20
local arrow_yoff = yoff+150
local arrow_yoff_orig = arrow_yoff
local arrow_maxyoff = 260

local options = {
  music       = {
    text = "Disable Music",
    val  = false
  },

  fullscreen  = {
    text = "Enable Fullscreen",
    val  = false
  },

  exit        = {
    text = "Exit Game"
  }
}

function PauseMenu:draw()
  -- draw rectangle
  local cx = love.graphics.getWidth() - CANVAS_WIDTH * 0.8
  love.graphics.setColor(0, 0, 0, 200)
  love.graphics.rectangle("fill", 0, 0, cx, CANVAS_HEIGHT)

  -- throw in the title
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("Lem", xoff, yoff)

  -- the options
  love.graphics.setFont(SMALL_FONT)
  love.graphics.print(options.music.text, xoff, yoff+150)
  love.graphics.print(options.fullscreen.text, xoff, yoff+180)
  love.graphics.print(options.exit.text, xoff, yoff+210)
  
  -- arrow
  love.graphics.setColor(166, 226, 46, 255)
  love.graphics.print(">", arrow_xoff, arrow_yoff)

  -- reset everything
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setFont(MAIN_FONT)
end

local last_run = love.timer.getTime()
local opt = 1

function PauseMenu:update(dt)
  local gt = love.timer.getTime()
  if gt > last_run+.3 then
    if Input:down() then
      if arrow_yoff ~= arrow_maxyoff then
        arrow_yoff = arrow_yoff+30
        last_run = gt
        opt = opt + 1
      end
    elseif Input:up() then
      if arrow_yoff ~= arrow_yoff_orig then
        arrow_yoff = arrow_yoff-30
        last_run = gt
        opt = opt - 1
      end
    elseif Input:enter() then
      last_run = gt
      if opt == 1 then
        if options.music.val then
          options.music.val   = false
          options.music.text  = "Disable Music" 
          Jukebox:play()
        else
          options.music.val   = true
          options.music.text  = "Enable Music"
          Jukebox:pause()
        end
      elseif opt == 2 then
        -- enable/disable fullscreen
      elseif opt == 3 then
        love.event.quit()
      end
    end
  end
end

return PauseMenu