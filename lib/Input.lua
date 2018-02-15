local Input = {}

function Input:jump()
  if Keyboard:key_down("x") or GamePad:button(1, "a") then return true end
  return false
end

function Input:grab()
  if Keyboard:key_down("z") or GamePad:button(1, "x") then return true end
  return false
end

function Input:reset()
  if Keyboard:key_down("r") or GamePad:button(1, "back") then return true end
end

function Input:walk(d)
  if d then
    if d == "left" then
      if Keyboard:key_down("left") and not Keyboard:key_down("right") or GamePad:button(1, "dpleft") and not GamePad:button(1, "dpright") then return true end
      return false
    elseif d == "right" then
      if Keyboard:key_down("right") and not Keyboard:key_down("left") or GamePad:button(1, "dpright") and not GamePad:button(1, "dpleft") then return true end
      return false
    end
  else
    if Keyboard:key("left") or Keyboard:key("right") or GamePad:button(1, "dpleft") or GamePad:button(1, "dpright") then return true end
    return false
  end
end

return Input