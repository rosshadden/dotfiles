-- TEMP
vim.opt.runtimepath:prepend("~/dotfiles/src/.config/nvim2")

require "lib.functions"
require "lib.modes"
require "core"

require "app"
require "buffers"
require "code"
require "files"
require "languages"
require "spans"
require "tabs"
require "ui"
require "vcs"
