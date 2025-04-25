---@diagnostic disable:undefined-global

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }
hs.alert.defaultStyle.fillColor = { white = 0.05, alpha = 0.75 }
hs.alert.defaultStyle.radius = 5
-- hs.alert.defaultStyle.fadeOutDuration = 0.5
-- hs.alert.defaultStyle.textFont = "FiraCode Nerd Font"
-- hs.alert.defaultStyle.atScreenEdge = 2
-- hs.alert.defaultStyle.textSize = 18

hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "R", "Reload Configuration", function()
	hs.reload()
end)

local function axHotfix(win)
	if not win then
		win = hs.window.frontmostWindow()
	end

	local axApp = hs.axuielement.applicationElement(win:application())
	local wasEnhanced = axApp.AXEnhancedUserInterface
	axApp.AXEnhancedUserInterface = false

	return function()
		hs.timer.doAfter(hs.window.animationDuration * 2, function()
			axApp.AXEnhancedUserInterface = wasEnhanced
		end)
	end
end

-- See https://github.com/Hammerspoon/hammerspoon/issues/3224
local function withAxHotfix(fn, position)
	if not position then
		position = 1
	end
	return function(...)
		local revert = axHotfix(select(position, ...))
		fn(...)
		revert()
	end
end

local windowMT = hs.getObjectMetatable("hs.window")
windowMT.setFrame = withAxHotfix(windowMT.setFrame, 1)
windowMT.setFrameInScreenBounds = withAxHotfix(windowMT.setFrameInScreenBounds)

local wm = hs.hotkey.modal.new("alt", "0")
local wmActive = false

local function exitWm()
	if wmActive then
		wm:exit()
		hs.alert.closeAll()
		hs.alert("🙅", hs.alert.defaultStyle, hs.screen.mainScreen(), 0.5)
	end
end

wm:bind({}, "escape", function()
	exitWm()
end)

wm:bind({}, "q", function()
	exitWm()
end)

local wmTimer = hs.timer

local function resetTimer()
	wmTimer = hs.timer.doAfter(2, exitWm)
end

function wm:entered()
	wmActive = true
	resetTimer()
	hs.alert.closeAll()
	hs.alert("🤔")
end

function wm:exited()
	hs.alert.closeAll()
	wmActive = false
end

local function center(xfactor, yfactor)
	if yfactor == nil then
		yfactor = 1
	end
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local sf = win:screen():frame()

	f.w = sf.w * xfactor
	f.h = sf.h * yfactor
	f.x = sf.x + (sf.w - f.w) / 2
	f.y = sf.y + (sf.h - f.h) / 2

	win:setFrame(f, 0)
end

local centerXNextIdx = 1
local centerXFractions = { 0.8, 0.6, 0.5, 0.4 }
wm:bind({}, "x", function()
	wmTimer:stop()
	center(centerXFractions[centerXNextIdx])
	centerXNextIdx = centerXNextIdx + 1
	if centerXNextIdx > #centerXFractions then
		centerXNextIdx = 1
	end
	resetTimer()
end)

local centerNextIdx = 1
local centerFractions = { { 0.8, 0.9 }, { 0.6, 0.8 }, { 0.4, 0.6 } }
wm:bind({}, "c", function()
	wmTimer:stop()
	center(centerFractions[centerNextIdx][1], centerFractions[centerNextIdx][2])
	centerNextIdx = centerNextIdx + 1
	if centerNextIdx > #centerFractions then
		centerNextIdx = 1
	end
	resetTimer()
end)

wm:bind({}, "0", function()
	center(0.8)
	exitWm()
end)

local function move(direction, distance)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	if direction == "l" then
		f.x = f.x - distance
	elseif direction == "r" then
		f.x = f.x + distance
	elseif direction == "u" then
		f.y = f.y - distance
	elseif direction == "d" then
		f.y = f.y + distance
	end
	win:setFrame(f, 0)
end

wm:bind({}, "h", function()
	wmTimer:stop()
	move("l", 10)
	resetTimer()
end)

wm:bind({}, "l", function()
	wmTimer:stop()
	move("r", 10)
	resetTimer()
end)

wm:bind({}, "j", function()
	wmTimer:stop()
	move("d", 10)
	resetTimer()
end)

wm:bind({}, "k", function()
	wmTimer:stop()
	move("u", 10)
	resetTimer()
end)

wm:bind({}, "space", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()

	win:moveToScreen(screen:next())
end)

wm:bind({}, "i", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()
	local f = win:frame()
	local stepw = res.w / 30
	local steph = res.h / 30

	win:setFrame({ x = f.x + stepw, y = f.y + steph, w = f.w - (stepw * 2), h = f.h - (steph * 2) })
end)

wm:bind({}, "o", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()
	local f = win:frame()
	local stepw = res.w / 30
	local steph = res.h / 30

	win:setFrame({ x = f.x - stepw, y = f.y - steph, w = f.w + (stepw * 2), h = f.h + (steph * 2) })
end)

wm:bind({ "shift" }, "h", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()

	win:setFrame({ x = res.x, y = res.y, w = res.w / 2, h = res.h })
	exitWm()
end)

wm:bind({ "shift" }, "k", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()

	win:setFrame({ x = res.x, y = res.y, w = res.w, h = res.h / 2 })
	exitWm()
end)

wm:bind({ "shift" }, "j", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()

	win:setFrame({ x = res.x, y = res.y + res.h / 2, w = res.w, h = res.h / 2 })
	exitWm()
end)

wm:bind({ "shift" }, "l", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()

	win:setFrame({ x = res.x + res.w / 2, y = res.y, w = res.w / 2, h = res.h })
	exitWm()
end)

wm:bind({}, "f", function()
	local win = hs.window.focusedWindow()
	if win:isFullScreen() then
		win:setFullScreen(false)
		hs.timer.usleep(999999)
		exitWm()
		return
	end
	win:setFullScreen(true)
	exitWm()
end)

local winhist = {}
wm:bind({}, "m", function()
	local win = hs.window.focusedWindow()
	if winhist[win:id()] ~= nil then
		win:setFrame(winhist[win:id()])
	else
		if win:isMaximizable() then
			winhist[win:id()] = win:frame()
			win:maximize()
		end
	end
	exitWm()
end)

local cornerNextID = 1
wm:bind({}, "a", function()
	wmTimer:stop()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local res = screen:frame()
	if cornerNextID == 1 then
		win:setFrame({ x = res.x, y = res.y, w = res.w / 2, h = res.h / 2 })
	elseif cornerNextID == 2 then
		win:setFrame({ x = res.x + res.w / 2, y = res.y, w = res.w / 2, h = res.h / 2 })
	elseif cornerNextID == 3 then
		win:setFrame({ x = res.x, y = res.y + res.h / 2, w = res.w / 2, h = res.h / 2 })
	elseif cornerNextID == 4 then
		win:setFrame({ x = res.x + res.w / 2, y = res.y + res.h / 2, w = res.w / 2, h = res.h / 2 })
	end
	cornerNextID = cornerNextID + 1
	if cornerNextID > 4 then
		cornerNextID = 1
	end
	resetTimer()
end)
