return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 23,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 10,
  properties = {},
  tilesets = {
    {
      name = "spritesheet",
      firstgid = 1,
      filename = "../tilesets/spritesheet.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../gfx/spritesheet.png",
      imagewidth = 2048,
      imageheight = 3456,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 6912,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Background",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt0V1SQQEYBuBTC5EkQraEIj/FloRCP2wJhRD20HPRDhpnMnMunpnv5p355n0LQRAUKXHDLWUq3FGlRp0G9zzQpEXnwNo8/t5dejzxTJ8BQ1545Y13RoxD+K8QRP39RdRf1F/U3/H2999NmDLjg0/mLFjyxYo1G77ZsmMfQj52EgRnxDknwQVJLkmR5ooMWXJckz85fL5AkRI33FKmwh1VatRpcM8DTVoh5Ns80qFLjyee6TNgyAuvvPHOiHEI+QlTZnzwyZwFS75YsWbDN1t27EPIx07tT5xzElyQ5JIUaa7IkCXHNfnTw+ejfaN9o32Pd98fGigHjw=="
    },
    {
      type = "tilelayer",
      name = "Background2",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBgFo2AUDBdwgUrmzGRCsKcD2TOYcKtFBhGM+OUFoPLTiDQPHZjwMzCY4sBm/KTrxaeGkHmjgDJgTGH4Uqp/KIJZBPLNVDLzFbUAvvw5mq9GwSgYBaNg5AAA3cgMgw=="
    },
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 40,
      height = 23,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJxjYBgFo2AUjIKhAYR48WNS9RJSMwpoBygN39H4GXyAUP4czVejYBSMglEwMgAAusMDhA=="
    },
    {
      type = "objectgroup",
      name = "Objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "player_spawn",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 160,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "spring",
          type = "",
          shape = "rectangle",
          x = 992,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "box",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "spring",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "spike",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 729.333,
          width = 1281.33,
          height = 6.66667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "level_end",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
