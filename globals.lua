CANVAS_WIDTH  = 1280
CANVAS_HEIGHT = 736
Canvas = love.graphics.newCanvas(CANVAS_WIDTH, CANVAS_HEIGHT)

Events   = require("lib.Events")()
Keyboard = require "lib.Keyboard"
GamePad  = require("lib.GamePad")({"assets/gamecontrollerdb.txt"})
Input    = require "lib.Input"
MapManager = require("lib.MapManager"):new()
Jukebox  = require("lib.Jukebox"):new()
Game = require "scenes.Game"()
SceneManager = require "lib.SceneManager"
paused = false