-- https://github.com/ztomer/.hammerspoon/blob/master/init.lua

-- grid
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 7
hs.grid.GRIDHEIGHT = 3

-- animation
hs.window.animationDuration = 0

local mash = {"ctrl", "alt"}
local mash_app = {"cmd", "alt", "ctrl"}

appCuts = {
  i = 'iterm',
  c = 'Google chrome',
  v = 'MacVim'
}

-- Launch applications
for key, app in pairs(appCuts) do
  hs.hotkey.bind(mash_app, key, function () hs.application.launchOrFocus(app) end)
end

hs.hotkey.bind(mash, '.', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, ",", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-- hs.hotkey.bind(mash, "æ", function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end )
-- hs.hotkey.bind(mash, "ø", function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end )

-- hs.hotkey.bind(mash, "å", function()
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = max.x + (max.w * 0.1)
--  f.y = max.y
--  f.w = max.w * 0.8
--  f.h = max.h + 10
--  win:setFrame(f)
--end)

-- Reload config
function reloadConfig(paths)
    doReload = false
    for _,file in pairs(paths) do
        if file:sub(-4) == ".lua" then
            print("A lua file changed, doing reload")
            doReload = true
        end
    end
    if not doReload then
        print("No lua file changed, skipping reload")
        return
    end

    hs.reload()
end

-- Replace Caffeine.app with 18 lines of Lua :D
local caffeine = hs.menubar.new()

function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("caffeine-on.pdf")
    else
        result = caffeine:setIcon("caffeine-off.pdf")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hs.hotkey.bind(mash, 'c', caffeineClicked)

hs.hotkey.bind(mash, 'M', hs.grid.maximizeWindow)

-- multi monitor
hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)

-- move windows
hs.hotkey.bind(mash, 'Left', hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, 'Down', hs.grid.pushWindowDown)
hs.hotkey.bind(mash, 'Up', hs.grid.pushWindowUp)
hs.hotkey.bind(mash, 'Right', hs.grid.pushWindowRight)

-- resize windows
hs.hotkey.bind(mash, 'H', hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, 'L', hs.grid.resizeWindowWider)
hs.hotkey.bind(mash, 'K', hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash, 'J', hs.grid.resizeWindowTaller)


-- Show Date temporatily
hs.hotkey.bind(mash, 'T', function() hs.alert.show(os.date(), 3) end)

-- Countdown menu

local function countdown_update_menu()
      if countdown_time_left < 0 then
        countdown_timer:stop()
        countdown_timer = nil
        countdown_screen = nil
        countdown_text:delete()
        countdown_text = nil
        local tink_sound = hs.sound.getByName("Ping")
        tink_sound:play()
      else
        if countdown_text then
          countdown_text:hide(0.5)
          countdown_text = nil
        end

        countdown_screen = hs.screen.mainScreen():fullFrame()

        local Xrect = hs.geometry.rect(
          (countdown_screen.w / 2 - (countdown_screen.w * 0.1)),
          (countdown_screen.h / 2 - (countdown_screen.h * 0.2)),
          countdown_screen.w*0.2,
          countdown_screen.h*0.4)

        local rect = hs.geometry.rect(
          (countdown_screen.w / 2 - 400),
          (countdown_screen.h / 2 - 320),
          600,
          600)

        countdown_text = hs.drawing.text(rect, countdown_time_left)
        countdown_text:setTextColor{red=.3,blue=.3,green=.9, alpha=.8}
        countdown_text:setTextSize(420)
        countdown_text:setTextFont('Cousine')
        countdown_text:setTextStyle{alignment="center"}
        countdown_text:show()
        countdown_time_left = countdown_time_left-1
      end
end

function start_countdown(seconds)
  countdown_time_left = seconds
  countdown_update_menu()
  countdown_timer = hs.timer.new(1, countdown_update_menu)
  countdown_timer:start()
end

hs.hotkey.bind(mash, 'Y', function() start_countdown(30) end)

-- Start screensaver
hs.hotkey.bind(mash, 'escape', function()
    hs.caffeinate.startScreensaver()
end)

local function createpassword(len)
    math.randomseed(os.time())
    local a = {}
    for count = 1, len do
      a[#a+1] = string.char(math.random(33,126))
    end
    local pwd = table.concat(a)
    hs.alert.show("Copied password to clipboard: " .. pwd, 3)
    hs.pasteboard.setContents(pwd)
end

-- Generate secure password
pwd_gen = hs.hotkey.modal.new(mash, 'F10')
pwd_timeout = 10

function pwd_gen:entered()
    msg = [[Generate password
=================
[1] 8 characters
[2] 12 characters
[3] 16 characters
[4] 20 characters
[5] 32 characters
[ESC] Abort]]
-- hs.alert.show(msg, 10)
    local screen = hs.screen.mainScreen():fullFrame()
    --:frame()
    pwd_menu = hs.drawing.rectangle(hs.geometry.rect(
      (screen.w / 2 - (screen.w * 0.1)),
      (screen.h / 2 - (screen.h * 0.2)),
      screen.w*0.2,
      screen.h*0.4)
    )
    pwd_menu:setFillColor({["red"]=0,["blue"]=180,["green"]=40,["alpha"]=0.8}):setFill(true)
    pwd_menu:show()
    pwd_text = hs.drawing.text(hs.geometry.rect(
      (screen.w / 2 - (screen.w * 0.1))+20,
      (screen.h / 2 - (screen.h * 0.2))+20,
      screen.w*0.2,
      screen.h*0.4),
      msg
    )
    pwd_text:setTextStyle({["size"]=30,["color"]={["red"]=0,["blue"]=0,["green"]=0,["alpha"]=1},["alignment"]="left",["lineBreak"]="truncateMiddle"})
    pwd_text:orderAbove(pwd_menu)
    pwd_text:show()
end

function pwd_gen:exited()
    pwd_text:delete()
    pwd_menu:delete()
end

pwd_gen:bind({}, 'escape', function()
    hs.alert.show("Abort")
    pwd_gen:exit()
end)

pwd_gen:bind({}, '1', function()
  createpassword(8)
  pwd_gen:exit()
end)
pwd_gen:bind({}, '2', function()
  createpassword(12)
  pwd_gen:exit()
end)
pwd_gen:bind({}, '3', function()
  createpassword(16)
  pwd_gen:exit()
end)
pwd_gen:bind({}, '4', function()
  createpassword(20)
  pwd_gen:exit()
end)

pwd_gen:bind({}, '5', function()
  createpassword(30)
  pwd_gen:exit()
end)

-- Window Hints
-- hs.hotkey.bind(mash, '.', function() hs.hints.windowHints(hs.window.allWindows()) end)
hs.hotkey.bind(mash, '-', hs.hints.windowHints)

-- Show grid
hs.hotkey.bind(mash, 'g', hs.grid.show)

configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()

hs.notify.new({
      title='Hammerspoon',
        informativeText='Config loaded'
    }):send():release()

