hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

hsreload_keys = { { "cmd", "shift", "ctrl" }, "R" }
if string.len(hsreload_keys[2]) > 0 then
	hs.hotkey.bind(hsreload_keys[1], hsreload_keys[2], "Reload Configuration", function()
		hs.reload()
	end)
end

hs.loadSpoon("ModalMgr")
hs.loadSpoon("CountDown")
hs.loadSpoon("WinWin")

-- countdownM modal environment
if spoon.CountDown then
	spoon.ModalMgr:new("countdownM")
	local cmodal = spoon.ModalMgr.modal_list["countdownM"]
	cmodal:bind("", "escape", "Deactivate countdownM", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "Q", "Deactivate countdownM", function()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)
	cmodal:bind("", "0", "1 Minute Countdown", function()
		spoon.CountDown:startFor(1)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "0", "5 Minutes Countdown", function()
		spoon.CountDown:startFor(5)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	for i = 1, 9 do
		cmodal:bind("", tostring(i), string.format("%s Minutes Countdown", 10 * i), function()
			spoon.CountDown:startFor(10 * i)
			spoon.ModalMgr:deactivate({ "countdownM" })
		end)
	end
	cmodal:bind("", "return", "25 Minutes Countdown", function()
		spoon.CountDown:startFor(25)
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)
	cmodal:bind("", "space", "Pause/Resume CountDown", function()
		spoon.CountDown:pauseOrResume()
		spoon.ModalMgr:deactivate({ "countdownM" })
	end)

	-- Register countdownM with modal supervisor
	hscountdM_keys = hscountdM_keys or { "alt", "I" }
	if string.len(hscountdM_keys[2]) > 0 then
		spoon.ModalMgr.supervisor:bind(hscountdM_keys[1], hscountdM_keys[2], "Enter countdownM Environment", function()
			spoon.ModalMgr:deactivateAll()
			-- Show the keybindings cheatsheet once countdownM is activated
			spoon.ModalMgr:activate({ "countdownM" }, "#FF6347", true)
		end)
	end
end

if spoon.WinWin then
	spoon.ModalMgr:new("resizeM")
	local cmodal = spoon.ModalMgr.modal_list["resizeM"]
	cmodal:bind("", "escape", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "Q", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)
	cmodal:bind(
		"",
		"A",
		"Move Leftward",
		function()
			spoon.WinWin:stepMove("left")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("left")
		end
	)
	cmodal:bind(
		"",
		"D",
		"Move Rightward",
		function()
			spoon.WinWin:stepMove("right")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("right")
		end
	)
	cmodal:bind(
		"",
		"W",
		"Move Upward",
		function()
			spoon.WinWin:stepMove("up")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("up")
		end
	)
	cmodal:bind(
		"",
		"S",
		"Move Downward",
		function()
			spoon.WinWin:stepMove("down")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("down")
		end
	)
	cmodal:bind("", "H", "Lefthalf of Screen", function()
		-- spoon.WinWin:mtash()
		spoon.WinWin:moveAndResize("halfleft")
	end)
	cmodal:bind("", "L", "Righthalf of Screen", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfright")
	end)
	cmodal:bind("", "K", "Uphalf of Screen", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfup")
	end)
	cmodal:bind("", "J", "Downhalf of Screen", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("halfdown")
	end)
	cmodal:bind("", "Y", "NorthWest Corner", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNW")
	end)
	cmodal:bind("", "O", "NorthEast Corner", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerNE")
	end)
	cmodal:bind("", "U", "SouthWest Corner", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSW")
	end)
	cmodal:bind("", "I", "SouthEast Corner", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("cornerSE")
	end)
	cmodal:bind("", "F", "Fullscreen", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("fullscreen")
	end)
	cmodal:bind("", "M", "Maximize", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("maximize")
	end)
	cmodal:bind("", "C", "Center Window", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveAndResize("center")
	end)
	cmodal:bind("", "6", "60% H 100% vert", function()
		-- spoon.WinWin:stash()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()
		f.x = max.x
		f.y = max.y
		f.w = max.w * 0.6
		f.h = max.h
		win:setFrame(f)
		spoon.WinWin:moveAndResize("center")
	end)
	cmodal:bind("", "8", "80% H 100% vert", function()
		-- spoon.WinWin:stash()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()
		f.x = max.x
		f.y = max.y
		f.w = max.w * 0.8
		f.h = max.h
		win:setFrame(f)
		spoon.WinWin:moveAndResize("center")
	end)
	cmodal:bind(
		"",
		"=",
		"Stretch Outward",
		function()
			spoon.WinWin:moveAndResize("expand")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("expand")
		end
	)
	cmodal:bind(
		"",
		"-",
		"Shrink Inward",
		function()
			spoon.WinWin:moveAndResize("shrink")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("shrink")
		end
	)
	cmodal:bind(
		"shift",
		"H",
		"Move Leftward",
		function()
			spoon.WinWin:stepResize("left")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("left")
		end
	)
	cmodal:bind(
		"shift",
		"L",
		"Move Rightward",
		function()
			spoon.WinWin:stepResize("right")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("right")
		end
	)
	cmodal:bind(
		"shift",
		"K",
		"Move Upward",
		function()
			spoon.WinWin:stepResize("up")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("up")
		end
	)
	cmodal:bind(
		"shift",
		"J",
		"Move Downward",
		function()
			spoon.WinWin:stepResize("down")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("down")
		end
	)
	cmodal:bind("", "left", "Move to Left Monitor", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("left")
	end)
	cmodal:bind("", "right", "Move to Right Monitor", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("right")
	end)
	cmodal:bind("", "up", "Move to Above Monitor", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("up")
	end)
	cmodal:bind("", "down", "Move to Below Monitor", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("down")
	end)
	cmodal:bind("", "space", "Move to Next Monitor", function()
		-- spoon.WinWin:stash()
		spoon.WinWin:moveToScreen("next")
	end)
	cmodal:bind("", "[", "Undo Window Manipulation", function()
		spoon.WinWin:undo()
	end)
	cmodal:bind("", "]", "Redo Window Manipulation", function()
		spoon.WinWin:redo()
	end)
	cmodal:bind("", "`", "Center Cursor", function()
		spoon.WinWin:centerCursor()
	end)

	-- Register resizeM with modal supervisor
	hsresizeM_keys = hsresizeM_keys or { "alt", "0" }
	if string.len(hsresizeM_keys[2]) > 0 then
		spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter resizeM Environment", function()
			-- Deactivate some modal environments or not before activating a new one
			spoon.ModalMgr:deactivateAll()
			-- Show an status indicator so we know we're in some modal environment now
			spoon.ModalMgr:activate({ "resizeM" }, "#B22222")
		end)
	end
end

spoon.ModalMgr.supervisor:enter()
