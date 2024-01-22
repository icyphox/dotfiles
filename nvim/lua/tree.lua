-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require('nvim-tree').setup{
  sort = {
    sorter = 'case_sensitive',
  },
  renderer = {
    icons =  {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = false,
      },
      glyphs = {
        symlink = "L",
        git = {
          unstaged = "M",
          staged = "A",
          unmerged = "",
          renamed = "→",
          untracked = "?",
          deleted = "D",
          ignored = "",
        },
      },
    },
  },
}
