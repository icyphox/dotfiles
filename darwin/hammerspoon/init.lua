local function pressFn(mods, key)
  if key == nil then
    key = mods
    mods = {}
  end

  return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
  hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end

remap({'ctrl'}, 'd', pressFn('pagedown'))
remap({'ctrl'}, 'u', pressFn('pageup'))

remap({'ctrl', 'shift'}, 'd', pressFn({'shift'}, 'pagedown'))
remap({'ctrl', 'shift'}, 'u', pressFn({'shift'}, 'pageup'))

remap({'ctrl'}, 'y', pressFn('left'))
remap({'ctrl'}, 'n', pressFn('down'))
remap({'ctrl'}, 'e', pressFn('up'))
remap({'ctrl'}, 'o', pressFn('right'))

