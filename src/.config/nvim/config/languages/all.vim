lua <<LUA
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'clojure',
    'cpp',
    'dockerfile',
    'gdscript',
    'go',
    'godotResource',
    'html',
    'javascript',
    'json',
    'lua',
    'php',
    'python',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
LUA
