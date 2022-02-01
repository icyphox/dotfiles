local vertical_tabs = require "vertical_tabs"
local editor = require "editor"
local modes = require "modes"
local settings = require "settings"

-- edit in nvim
editor.editor_cmd = "st -e nvim {file} +{line}"

-- ctrl+c to copy
modes.add_binds("normal", {
    { "<Control-c>", "Copy selected text.", function ()
        luakit.selection.clipboard = luakit.selection.primary
    end},
})

-- b to go back
modes.remap_binds("normal", {
  { "b", "<shift-h>", true },
})

-- v to play in mpv
modes.add_binds("normal", {
  { "v", "Play video in page",
  function (w)
    local view = w.view
    local uri = view.hovered_uri or view.uri
    if uri then
      luakit.spawn(string.format("mpv --geometry=640x360 %s", uri ))
    end
  end },
})

-- default zoom for sites
local sites = {
  "news.ycombinator.com", "lobste.rs",
}
for _, s in ipairs(sites) do
  settings.on[s].webview.zoom_level = 120
end
