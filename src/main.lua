require 'lib/strict'
-- require 'socket'

function pos(x, y)
  return x .. ',' .. y
end

rng = math.random

class          = require 'lib.middleclass'
Serpent        = require 'lib.serpent'
Timer          = require 'lib.hump.timer'
Terebi         = require 'lib.terebi.terebi'

require 'system.constants'

Util     = require 'system.util'
Input    = require 'system.input'
Pathfind = require 'system.pathfind'
Sprite   = require 'system.sprite'

Map  = require 'map.map'

Tile          = require 'map.tile.tile'
Crystal       = require 'map.tile.crystal'
Mine          = require 'map.tile.mine'
Mountain      = require 'map.tile.mountain'
SteelMountain = require 'map.tile.steel_mountain'
VrilHarvester = require 'map.tile.vril_harvester'

Unit             = require 'map.unit.unit'
Agarthan         = require 'map.unit.agarthan'
AgarthanMonolith = require 'map.unit.agarthan_monolith'
Panzer           = require 'map.unit.panzer'

Button = require 'ui.button'

-- HasComponents = require 'entity.trait.has_components'

-- Base   = require 'entity.base'

-- BaseFrill = require 'entity.frill.base_frill'
-- Frill     = require 'entity.frill.frill'
-- Particles = require 'entity.frill.particles'

-- Seibutsu = require 'entity.seibutsu.seibutsu'
-- Player   = require 'entity.seibutsu.player'

-- Component         = require 'entity.component.component'
-- -- AiPace            = require 'entity.component.ai_pace'
-- -- AiSleep           = require 'entity.component.ai_sleep'
-- Living            = require 'entity.component.living'
-- Motion            = require 'entity.component.motion'
-- Touches           = require 'entity.component.touches'

-- React             = require 'entity.component.react.react'
-- Touchable         = require 'entity.component.react.touchable'

Scene = require 'scene.scene'
Game  = require 'scene.game'
Ui    = require 'scene.ui'

-- canvas_debug = nil
game = nil
player = nil
-- util = Util
ui = nil
world = nil

screen = nil
local scenes = {}

function love.load(arg)
  initGraphics()
  initInput()
  initScenes()
end

function initGraphics()
  Terebi.initializeLoveDefaults()

  screen = Terebi.newScreen(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_SCALE)
  -- canvas_debug = love.graphics.newCanvas(CAMERA_WIDTH, CAMERA_HEIGHT)
end

function initInput()
  Input.initialize()
end

function initScenes()
  table.insert(scenes, Game({running = true, display = true}))
  table.insert(scenes, Ui({running = true, display = true}))
end

function love.update(dt)
  Input.handle()
  Timer.update(dt)

  for _,scene in pairs(scenes) do
    if scene:isRunning() then
      scene:update(dt)
    end
  end
end

function love.draw()
  lg.setCanvas(screen:getCanvas())

  for _,scene in pairs(scenes) do
    if scene:isDisplay() then
      scene:draw()
    end
  end

  screen:draw()
end
