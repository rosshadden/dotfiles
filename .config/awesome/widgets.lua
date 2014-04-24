local wibox = require("wibox")
local lain = require("lain")
local awful = require("awful")

local util = require("util")

local markup = lain.util.markup
local widgets = {}

-- Coretemp
	if (util.fileExists("/sys/class/thermal/thermal_zone0/temp")) then
		tempIcon = wibox.widget.imagebox(theme.temp)
		tempWidget = lain.widgets.temp({
			settings = function()
				tempWidget:set_text(coretemp_now .. "°C ")
			end
		})

		table.insert(widgets, {
			icon = tempIcon,
			widget = tempWidget,
			screen = 1
		})
	end

-- Net
	netIcon = wibox.widget.imagebox(theme.net)
	netIcon:buttons(awful.util.table.join(awful.button({}, 1, function() awful.util.spawn_with_shell(iptraf) end)))
	netWidget = lain.widgets.net({
		settings = function()
			netWidget:set_markup(
				markup("#7AC82E", net_now.received)
				.. "/" ..
				markup("#46A8C3", net_now.sent)
				.. " "
			)
		end
	})

	table.insert(widgets, {
		icon = netIcon,
		widget = netWidget,
		screen = 1
	})

-- MEM
	memIcon = wibox.widget.imagebox(theme.mem)
	memWidget = lain.widgets.mem({
		settings = function()
			memWidget:set_text(mem_now.used .. "MB ")
		end
	})

	table.insert(widgets, {
		icon = memIcon,
		widget = memWidget,
		screen = 1
	})

-- CPU
	cpuIcon = wibox.widget.imagebox(theme.cpu)
	cpuWidget = lain.widgets.cpu({
		settings = function()
			cpuWidget:set_text(cpu_now.usage .. "% ")
		end
	})

	table.insert(widgets, {
		icon = cpuIcon,
		widget = cpuWidget,
		screen = 1
	})

-- Battery
	if (util.fileExists("/sys/class/power_supply/BAT0")) then
		batIcon = wibox.widget.imagebox(theme.battery)
		batWidget = lain.widgets.bat({
			settings = function()
				if bat_now.status ~= "Discharging" then
					batWidget:set_markup(bat_now.perc .. "% [" .. bat_now.status .. "] ")
					batIcon:set_image(theme.ac)
					return
				end

				batWidget:set_markup(bat_now.perc .. "% ")
				if tonumber(bat_now.perc) <= 5 then
					batIcon:set_image(theme.battery_empty)
				elseif tonumber(bat_now.perc) <= 15 then
					batIcon:set_image(theme.battery_low)
				else
					batIcon:set_image(theme.battery)
				end
			end
		})

		table.insert(widgets, {
			icon = batIcon,
			widget = batWidget
		})
	end

-- Volume
	volIcon = wibox.widget.imagebox(theme.vol)
	volWidget = lain.widgets.alsa({
		settings = function()
			local icon = ""
			if volume_now.status == "off" then
				icon = ""
				volIcon:set_image(theme.vol_mute)
			elseif tonumber(volume_now.level) == 0 then
				icon = ""
				volIcon:set_image(theme.vol_no)
			elseif tonumber(volume_now.level) <= 50 then
				icon = ""
				volIcon:set_image(theme.vol_low)
			else
				icon = ""
				volIcon:set_image(theme.vol)
			end

			-- widget:set_text(markup.font("FontAwesome", icon .. " " .. volume_now.level .. "% "))
			widget:set_text(volume_now.level .. "% ")
		end
	})

	table.insert(widgets, {
		icon = volIcon,
		widget = volWidget
	})

-- Clock
	local dateformat = markup.font("FontAwesome", "") .. " %a %b %d"
	local timeformat = markup.font("FontAwesome", "") .. " %H:%M"
	clockIcon = wibox.widget.imagebox(theme.widget_clock)
	clockWidget = awful.widget.textclock(" " .. dateformat .. "  " .. timeformat .. " ")

	table.insert(widgets, {
		icon = clockIcon,
		widget = clockWidget
	})

-- Calendar
	lain.widgets.calendar:attach(clockWidget, { font_size = 12 })

return widgets
