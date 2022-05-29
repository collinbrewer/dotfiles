-- TODO: hotkey for placing app windows according to monitor config (laptop-only, laptop+external)

-- Some good examples:
-- https://github.com/scottcs/dot_hammerspoon
-- https://github.com/selectnull/hammerspoon-alttab
-- https://github.com/gwww/dotfiles/blob/main/.config/hammerspoon/hyper.lua
-- https://github.com/jpf/Zoom.spoon
-- https://developer.okta.com/blog/2020/10/22/set-up-a-mute-indicator-light-for-zoom-with-hammerspoon
-- https://github.com/oskarols/dotfiles/blob/master/hammerspoon/window_tracker.lua
-- https://chris.zarate.org/create-custom-macos-menu-bar-apps-using-hammerspoon

-- local timers = {}
-- local watcher
--
-- local function updateCaffeinateWatcher(state)
--   print('state', state)
--   if state == hs.caffeinate.watcher.systemDidWake then
--     print('systemDidWake')
--     for _, timer in timers do
--       print('timer')
--       -- hs.timer.doEvery(interval, fn)
--     end
--   end
-- end
--
-- local doForever = function(interval, fn)
--   if not watcher then
--     print('creating watcher')
--     watcher = hs.caffeinate.watcher.new(updateCaffeinateWatcher)
--     watcher:start()
--   end
--
--   table.insert(timers, { interval=interval, fn=fn })
--   hs.timer.doEvery(interval, fn)
-- end

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall.use_syncinstall = true


-- attempt to wire up all custom mappings to a hyper-esque keystroke
local hyper = { 'cmd', 'ctrl' }

--------------------------------------------------
-- Reload hammerspoon config
--------------------------------------------------
-- reload manually
hs.hotkey.bind(hyper, 'r', function()
  hs.reload()
end)

-- reload when the system wakes up
hs.caffeinate.watcher.new(function(state)
  print('state', state)
  if state == hs.caffeinate.watcher.systemDidWake then
    print('systemDidWake, reloading hs')
    hs.reload()
  end
end):start()


--------------------------------------------------
-- Window snapping
--------------------------------------------------
hs.window.animationDuration = 0
hs.hotkey.bind(hyper, 'h', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.left50)
end)
hs.hotkey.bind(hyper, 'j', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.maximized)
end)
hs.hotkey.bind(hyper, 'k', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToScreen(win:screen():next())
end)
hs.hotkey.bind(hyper, 'l', function()
  local win = hs.window.focusedWindow();
  if not win then return end
  win:moveToUnit(hs.layout.right50)
end)


--------------------------------------------------
-- Application hot keys
--------------------------------------------------
local applicationHotkeys = {
  ['1'] = 'Google Chrome',
  ['2'] = 'Alacritty',
  ['3'] = 'DataGrip',
  ['4'] = 'Slack',
  ['5'] = 'Mail',
  ['0'] = 'Spotify',

  ['b'] = 'Google Chrome',
  ['d'] = 'DataGrip',
  ['t'] = 'Alacritty',
  ['s'] = 'Slack',
  ['m'] = 'Spotify',
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

--------------------------------------------------
-- Consistent media keys
--------------------------------------------------
local bindSystemKey = function(systemKey)
  return function()
    hs.eventtap.event.newSystemKeyEvent(systemKey, true):post()
    hs.eventtap.event.newSystemKeyEvent(systemKey, false):post()
  end
end

-- repeating
hs.hotkey.bind(hyper, 'o', bindSystemKey('SOUND_DOWN'), nil, bindSystemKey('SOUND_DOWN'))
hs.hotkey.bind(hyper, 'p', bindSystemKey('SOUND_UP'), nil, bindSystemKey('SOUND_UP'))

-- non-repeating
hs.hotkey.bind(hyper, 'i', bindSystemKey('MUTE'))
hs.hotkey.bind(hyper, 'w', bindSystemKey('PLAY'))
hs.hotkey.bind(hyper, 'e', bindSystemKey('NEXT'))
hs.hotkey.bind(hyper, 'q', bindSystemKey('PREVIOUS'))


--------------------------------------------------
-- Caffeine
--------------------------------------------------
spoon.SpoonInstall:andUse('Caffeine', {
  start = true,
  hotkeys = {
    toggle = { hyper, "c" },
  },
})

--------------------------------------------------
-- Push to talk mic functionality
--------------------------------------------------
-- spoon.SpoonInstall:andUse('PushToTalk', {
--   start = true,
--   config = {
--     app_switcher = { ['zoom.us'] = 'push-to-talk' },
--   },
-- })

--------------------------------------------------
-- Now playing
--------------------------------------------------
hs.hotkey.bind(hyper, 'u', function()
  hs.spotify.displayCurrentTrack()
end)

--------------------------------------------------
-- Window switcher
--------------------------------------------------
local wf = hs.window.filter.new(function(w)
  return (
    hs.application.frontmostApplication():name() == w:application():name()
    and not w:isMinimized()
    and w:isStandard()
  )
end)
--
-- local switcher = hs.window.switcher.new(wf)
-- hs.hotkey.bind('cmd','`', nil, function()
--   switcher:next()
-- end)

local ws = require('./modules/window-switcher')
local switcher = ws.new(wf, {
  backgroundColor={0.1, 0.1, 0.1, 0.9},
  highlightColor={0.0, 0.0, 0.0, 0.7},

  -- showTitles = false,
  -- showThumbnails = false,
  showSelectedThumbnail = false,
  showIcons = false,
  thumbnailSize = 256,
})

hs.hotkey.bind('cmd','`', nil, function()
  switcher:next()
end)

require('./modules/fuzzy-window-switcher')

--------------------------------------------------
-- Homebrew
--------------------------------------------------
local homebrewMenubar = hs.menubar.new()
homebrewMenubar:setClickCallback(function()
  hs.applescript.applescript([[
    tell application "Terminal"
      do script "brew outdated; echo; echo 'Run `brew upgrade` to upgrade outdated packages'"
      activate
    end tell
  ]])
end)

function updateHomebrewMenubar()
  local outdated = hs.execute('/opt/homebrew/bin/brew outdated')
  local _, numOutdated = outdated:gsub('\n', '\n')

  if numOutdated > 0 then
    homebrewMenubar:setTitle(string.format('🍺 %s', numOutdated))
    homebrewMenubar:setTooltip(outdated)
  else
    homebrewMenubar:delete()
  end
end

updateHomebrewMenubar()
hs.timer.doEvery(3600, updateHomebrewMenubar)

--------------------------------------------------
-- Speak selected text
--------------------------------------------------
local speaker = hs.speech.new()
speaker:rate(220)

function toggleSpeakSelectedText()
  if speaker:speaking() then
    speaker:stop()
  else
    -- snatched from https://github.com/Hammerspoon/Spoons/blob/master/Source/LookupSelection.spoon/init.lua#L51
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(20000)
    sel=hs.pasteboard.getContents()

    if sel then
      speaker:speak(sel)
    end
  end
end

hs.hotkey.bind(hyper, 's', toggleSpeakSelectedText)
