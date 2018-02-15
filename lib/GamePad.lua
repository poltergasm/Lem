local Class = require "lib.Class"
local Event = require "lib.Events"
local GamePad = Class:extends()

local DEADZONE = 0.1

local function hook_love_events(self)
  function love.joystickadded(joystick)
    local id = joystick:getID()
    assert(self.connected_sticks[id] == nil, "Joystick ID " .. id .. " already exists!")
    self.connected_sticks[id] = joystick
    self.is_connected[id] = true
    self.button_map[id] = {}
    self.event:invoke("gamepad_added", id)
  end

  function love.joystickremoved(joystick)
    local id = joystick:getID()
    self.connected_sticks[id] = nil
    self.is_connected[id] = false
    self.button_map[id] = {}
    self.event:invoke("gamepad_removed", id)
  end
  
  function love.gamepadpressed(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = true
  end

  function love.gamepadreleased(joystick, button)
    local id = joystick:getID()
    self.button_map[id][button] = false
  end
end

function GamePad:new(db_files, ad_enabled)
  if db_files then
    for i = 1, #db_files do
      love.joystick.loadGamepadMappings(db_files[i])
    end
  end
  
  self.event = Event()
  self.event:add("gamepad_removed")
  self.event:add("gamepad_added")
  hook_love_events(self)
  -- convert left analog joystick to dpad
  self.ad_enabled = ad_enabled or false
  
  self.connected_sticks = {}
  self.is_connected = {}
  self.button_map = {}
end

function GamePad:exists(joy_id)
  return self.is_connected[joy_id] == nil and self.is_connected[joy_id] == false
end

function GamePad:get_stick(joy_id)
  return self.connected_sticks[joy_id]
end

function GamePad:button_down(joy_id, button)
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then
    return false
  else
    return self.button_map[joy_id][button] == true
  end
end

function GamePad:button_up(joy_id, button)
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then
    return false
  else
    return self.button_map[joy_id][button] == false
  end
end

function GamePad:button(joy_id, button)
  local stick = self.connected_sticks[joy_id]
  if self.is_connected[joy_id] == nil or self.is_connected[joy_id] == false then return false end
  
  local is_down = stick:isGamepadDown(button)
  
  if self.ad_enabled and not is_down then
    local xaxis = stick:getGamepadAxis("leftx")
    local yaxis = stick:getGamepadAxis("lefty")
    if button == "dpright" then
      is_down = xaxis > DEADZONE
    elseif button == "dpleft" then
      is_down = xaxis < -DEADZONE
    elseif button == "dpup" then
      is_down = yaxis < -DEADZONE
    elseif button == "dpdown" then
      is_down = yaxis > DEADZONE
    end
  end

  return is_down
end

function GamePad:update(dt)
  for i = 1, #self.is_connected do
    if self.button_map[i] then
      for k,_ in pairs(self.button_map[i]) do
        self.button_map[i][k] = nil
      end
    end
  end
end

return GamePad