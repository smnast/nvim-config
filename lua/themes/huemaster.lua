local M = {}

M.base_30 = {
  white = "#ebd9f1",
  darker_black = "#000000",
  black = "#120715", --  nvim bg
  black2 = "#250f2c",
  one_bg = "#31143b",
  one_bg2 = "#441c52",
  one_bg3 = "#572468",
  grey = "#903cac",
  grey_fg = "#ada3b5",
  grey_fg2 = "#e6d9f1",
  light_grey = "#c085d4",
  red = "#f1a6a6",
  baby_pink = "#ffffff",
  pink = "#ffffff",
  line = "#f0b963", -- for lines like vertsplit
  green = "#a6f1a6",
  green1 = "#d2f8d2",
  vibrant_green = "#ffffff",
  blue = "#a6a6f1",
  nord_blue = "#d2d2f8",
  yellow = "#f1cca6",
  sun = "#f8e5d2",
  purple = "#f1a6e5",
  dark_purple = "#ea7ad9",
  teal = "#e1a2bf",
  orange = "#f38cb7",
  cyan = "#ebd9f1",
  statusline_bg = "#752c69",
  lightbg = "#9a3b8a",
  pmenu_bg = "#752c69",
  folder_bg = "#c285d3",
}

M.base_16 = {
  base00 = "#120715",
  base01 = "#250f2c",
  base02 = "#31143b",
  base03 = "#441c52",
  base04 = "#572468",
  base05 = "#e2c6eb",
  base06 = "#ebd9f1",
  base07 = "#ebd9f1",
  base08 = "#f1a6e5",
  base09 = "#e1a2bf",
  base0A = "#f38cb7",
  base0B = "#c285d3",
  base0C = "#e4a487",
  base0D = "#f2ae73",
  base0E = "#fbe8f8",
  base0F = "#f3dce7",
}

M.type = "dark"

M = require("base46").override_theme(M, "huemaster")

return M

