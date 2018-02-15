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
      data = "eJzt0cdBAlEAANFdCkFypiV1zaK2BJhzS+QcevA14JE9/cM7zmmSKIqSIAiCIAhSNWDIiDETpsyYs2DJijUbtuzYp9Bn4yg6IkeeAkVKlKlQpUadBk1atOPD98eccErCGedccMkV19xwS4c77nlIoe/So88jTzzzwitvvPPBJ19888NvCv2AISPGTJgyY86CJSvWbNiyY59Cn834T448BYqUKFOhSo06DZq0aGcO33fjIAj+8wdYxK+A"
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
      data = "eJztzjENAAAIwDA04AVp+McCCQ9Hm+xfBAAAsNV5q4758/f5bwCmJUBh"
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
      data = "eJztzcEJACEAA8FYwD3Uyq9jXzagIAozsM+QBAAA3vaXc1/1S9pifWM7g5sNPt4Ecw=="
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
          id = 1,
          name = "player_spawn",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 512,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "box",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "box_block",
          type = "",
          shape = "rectangle",
          x = 224,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "blob",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 544,
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
          x = 512,
          y = 512,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "vert_platform",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 512,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "switch",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 544,
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
