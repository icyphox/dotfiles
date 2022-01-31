local vertical_tabs = require "vertical_tabs"
local editor = require "editor"
editor.editor_cmd = "st -e nvim {file} +{line}"

local modes = require "modes"
modes.add_binds("normal", {
    { "<Control-c>", "Copy selected text.", function ()
        luakit.selection.clipboard = luakit.selection.primary
    end},
})

modes.remap_binds("normal", {
  { "b", "<shift-h>", true },
})
