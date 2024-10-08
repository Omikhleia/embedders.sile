package = "embedders.sile"
version = "dev-1"
source = {
  url = "git+https://github.com/Omikhleia/embedders.sile.git",
}
description = {
  summary = "Graphviz, Lilypond (etc.) support for the SILE typesetting system.",
  detailed = [[
    This package for the SILE typesetter provides "embedders" for text formats that
    can be converted to an image, e.g. the DOT graph language (Graphviz) or
    the LilyPond musical notation.
  ]],
  homepage = "https://github.com/Omikhleia/embedders.sile",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
  "silex.sile",
}
build = {
  type = "builtin",
  modules = {
    ["sile.packages.embedders"] = "packages/embedders/init.lua",
    ["sile.embedders.base"]     = "embedders/base.lua",
    ["sile.embedders.dot"]      = "embedders/dot.lua",
    ["sile.embedders.lilypond"] = "embedders/lilypond.lua",
  }
}
