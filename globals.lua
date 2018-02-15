Events   = require("lib.Events")()
Keyboard = require "lib.Keyboard"
GamePad  = require("lib.GamePad")({"assets/gamecontrollerdb.txt"})
Input    = require "lib.Input"
MapManager = require("lib.MapManager"):new()
Jukebox  = require("lib.Jukebox"):new()
Game = require "scenes.Game"()
SceneManager = require "lib.SceneManager"
Game.Canvas = love.graphics.newCanvas(1280, 736)