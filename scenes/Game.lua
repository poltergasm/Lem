local Player = require "ents.Player"
local Label  = require "lib.ui.Label"
local Entity = require "lib.entities.Entity"
local EntityCrate    = require "ents.Crate"
local EntityBoxBlock = require "ents.BoxBlock"
local EnemyBlob      = require "ents.EnemyBlob"
local EnemySnail     = require "ents.EnemySnail"
local EnemyBuzzy     = require "ents.EnemyBuzzy"
local EntitySpring   = require "ents.Spring"
local EntitySwitch   = require "ents.Switch"
local EntityWhoosh   = require "ents.Whoosh"
local EntityBlocker  = require "ents.Blocker"
local LevelEnd       = require "ents.LevelEnd"
local EntityVertPlatform = require "ents.VertPlatform"
local PauseMenu = require "lib.ui.PauseMenu"
local Snow      = require "lib.effects.Snow"
local Rain      = require "lib.effects.Rain"

local Scene = require "lib.Scene"
local Game = Scene:extends()

local bump = require "lib.bump"
local sti  = require "lib.sti"

local GRAVITY = 14.8
local draw_name = false

function Game:setup_bump()
  self.entity_mgr.entities = {}
  self.world = bump.newWorld()
  self.entity_mgr:set_world(self.world)
  self.world.gravity = GRAVITY
end

function Game:load_assets()
  Jukebox:add_song({ file = "assets/audio/bgm/song_1.mp3" })
  Jukebox:add_song({ file = "assets/audio/bgm/song_2.mp3" })
  Jukebox:add_song({ file = "assets/audio/bgm/song_3.mp3" })
  Jukebox:add_song({ file = "assets/audio/bgm/song_4.mp3" })
  Jukebox:play()

  self.snd = {
    hurt = love.audio.newSource("assets/audio/sfx/hurt.wav"),
    jump = love.audio.newSource("assets/audio/sfx/jump.wav"),
    squash = love.audio.newSource("assets/audio/sfx/squash.wav"),
    spring = love.audio.newSource("assets/audio/sfx/spring.wav"),
    switch = love.audio.newSource("assets/audio/sfx/switch.wav"),
    boxblock = love.audio.newSource("assets/audio/sfx/boxblock.wav")
  }

  Snow:load(CANVAS_WIDTH, CANVAS_HEIGHT, 50)
  Rain:load(CANVAS_WIDTH, CANVAS_HEIGHT, 100)
end

function Game:new()
  Game.super.new(self)

  self:load_assets()
  self:load_level()
  draw_name = true
end

function Game:load_level(new_level)
  self:setup_bump()
  self.map = sti(MapManager:map(), { "bump" })
  self.map:bump_init(self.world)
  self:spawn_objects()
  self.map:removeLayer("Objects")

  local cx, cy = 0, 0

  if not Fullscreen then
    cx = love.graphics.getWidth() - Canvas:getWidth() * 0.6
    cy = love.graphics.getHeight() - Canvas:getHeight() * 0.6
  else
    cx = love.graphics.getWidth() / 4
    cy = love.graphics.getHeight() / 4
  end

  self.level_name = Label(cx, cy, 300, 60, MapManager:map_name())
  self.level_name.background = true

  self.enable_snow = false
  self.enable_rain = false
  if self.map.properties ~= nil and self.map.properties.snow == true then
    self.enable_snow = true
  end

  if self.map.properties ~= nil and self.map.properties.rain == true then
    self.enable_rain = true
  end

  if new_level then
    draw_name = true
  end
end

function Game:create_box(x, y)
  local box = EntityCrate("ent_crate", x, y, 32, 32, 200, 200, 10)
  self.entity_mgr:add(box)
end

function Game:create_whoosh(x, y, purple)
  local name = purple and "ent_whoosh_purple" or "ent_whoosh"
  local whoosh = EntityWhoosh(name, x, y, 32, 32, 200, 200, 10)
  self.entity_mgr:add(whoosh)
end

function Game:spawn_objects()
  for k, object in pairs(self.map.objects) do
    -- Player
    if object.name == "player_spawn" then
      self.player = Player("ent_player", object.x, object.y, 29, 44, 200, 200, 5)
      self.entity_mgr:add(self.player)

    -- Box
    elseif object.name == "box" then
      self:create_box(object.x, object.y)
    
    -- Box Block
    elseif object.name == "box_block" then
      local boxblock = EntityBoxBlock("ent_box_block", object.x, object.y, object.width, object.height)
      self.entity_mgr:add(boxblock)

    -- Spring
    elseif object.name == "spring" then
      local spring = EntitySpring("ent_spring", object.x, object.y, 25, 25, 200, 200, 10)
      self.entity_mgr:add(spring)

    -- Enemy Blob
    elseif object.name == "blob" then
      local blob = EnemyBlob("ent_blob", object.x, object.y, object.width, object.height, 200, 64, 2)
      self.entity_mgr:add(blob)

    -- Enemy Snail
    elseif object.name == "snail" then
      local snail = EnemySnail("ent_snail", object.x, object.y, object.width, object.height, 200, 64, 2)
      self.entity_mgr:add(snail)
    
    -- Buzzy
    elseif object.name == "buzzy" then
      local buzzy = EnemyBuzzy("ent_buzzy", object.x, object.y, object.width, object.height, 200, 200, 2)
      self.entity_mgr:add(buzzy)

    -- Vertical Moving Platform
    elseif object.name == "vert_platform" then
      local plat = EntityVertPlatform("ent_vert_platform", object.x, object.y, object.width, object.height)
      plat.orig_y = object.y
      if object.properties.stopped ~= nil and object.properties.stopped == true then plat.stopped = true end
      self.entity_mgr:add(plat)

    -- Switch
    elseif object.name == "switch" then
      local switch = EntitySwitch("ent_switch", object.x, object.y, object.width, object.height)
      self.entity_mgr:add(switch)

    -- Level End entity
    elseif object.name == "level_end" then
      local lvlend = LevelEnd("level_end", object.x, object.y, object.width, object.height)
      self.entity_mgr:add(lvlend)
    
    -- Spike / Environmental trap
    elseif object.name == "spike" then
      local spike = Entity("ent_spike", object.x, object.y, object.width, object.height)
      self.entity_mgr:add(spike)

    -- Blocker
    elseif object.name == "blocker" then
      local blocker = EntityBlocker("ent_blocker", object.x, object.y, object.width, object.height)
      self.entity_mgr:add(blocker)
    end
  end
end

function Game:check_blobs()
  local b = false
  for i = #self.entity_mgr.entities, 1, -1 do
    if self.entity_mgr.entities[i].name == "ent_blob" then
      if self.entity_mgr.entities[i].alive then
        b = true
        break
      end
    end
  end

  -- if no blobs left, then remove blockers
  if not b then
    for i = #self.entity_mgr.entities, 1, -1 do
    if self.entity_mgr.entities[i].name == "ent_blocker" then
      local blocker = self.entity_mgr.entities[i]
      blocker.remove = true
      self:create_whoosh(blocker.pos.x, blocker.pos.y)
      self:create_whoosh(blocker.pos.x, blocker.pos.y+32)
      self:create_whoosh(blocker.pos.x, blocker.pos.y+48)
      self:create_whoosh(blocker.pos.x, blocker.pos.y+64)
    end
  end
  end
end

function Game:player_movement(dt)
  if not draw_name then
    if Input:walk("right") then
      self.player:move_right(dt)
    elseif Input:walk("left") then
      self.player:move_left(dt);
    end

    if Input:jump() and self.player.grounded then
      self.player:jump(dt)
    end
  end
  
  if Input:reset() then
    self:load_level()
  end

  if Input:grab() then
    if draw_name then draw_name = false end
    if not self.player.is_gripping then
      for i=#self.entity_mgr.entities, 1, -1 do
        local ent = self.entity_mgr.entities[i]
        if self.player:is_ent_grippable(ent) then
          self.player.is_gripping = true
          self.player.gripped_ent = ent
          break
        end
      end
    end
  else
    self.player.is_gripping = false
    self.player.gripped_ent = nil
  end
end

local player_filter = function(item, other)
  if     other.is_collectable   then return "cross"
  elseif other.is_wall   then return "slide"
  elseif other.is_exit   then return "touch"
  elseif other.is_spring then return "bounce"
  else return "slide" end
end

function Game:check_cols(ent, cols, idx)
  ent.grounded = false
  for i,v in ipairs(cols) do
    local other = cols[i].other
    local this  = cols[i].normal

    if (ent.name == "ent_player" or ent.name == "ent_blob") and other.name == "ent_spike" then
      ent:die()
    end

    if ent.is_dynamic then
      if ent.collides ~= nil then ent:collides(this, other) end
      ent:check_cols(this, other)
    end
  end
end

function Game:update(dt)
  if self.enable_snow then Snow:update(dt) end
  if self.enable_rain then Rain:update(dt) end
  if not paused then
    Game.super.update(self, dt)
    
    self.map:update(dt)
    self:player_movement(dt)
    self.player:grip_check()

    if not draw_name then
      for i = #self.entity_mgr.entities, 1, -1 do
        local ent = self.entity_mgr.entities[i]

        if ent.is_dynamic then
          ent:update_physics(dt)
        end
        
        ent.pos.x, ent.pos.y, cols = self.world:move(ent, ent.pos.x, ent.pos.y, player_filter)

        self:check_cols(ent, cols, i)
      end
    end
  else
    PauseMenu:update(dt)
  end
end

function Game:draw()
  if self.enable_snow or self.enable_rain then love.graphics.setColor(169, 169, 169) end
  self.map:draw()
  Game.super.draw(self)

  if draw_name and not paused then self.level_name:draw() end
  if paused then PauseMenu:draw() end

  if self.enable_snow then Snow:draw() end
  if self.enable_rain then Rain:draw() end
end

return Game