local items = {}
local last_item = 0

function item(item_def)
  local prop_name = string.lower(item_def.name):gsub(" ", "_")
  last_item = last_item + 1
  items[prop_name] = last_item
  return item_def
end


function remote_probe()
	return {
		request="f0 7e 7f 06 01 f7",
		response="F0 7E 7F 06 02 47 26 00 19 00 22 00 22 00 00 00 00 00 00 00 04 00 04 00 03 00 78 00 2C 2D 2E 2F 30 F7"
	}
end


function remote_prepare_for_use()
    return {
            --Write Reason settings to RAM.
			remote.make_midi("F0 47 00 26 64 00 6D 00 00 00 04 00 00 04 00 00 00 03 00 78 00 00 00 01 02 0B 01 24 00 14 00 25 01 15 00 26 02 16 00 27 03 17 00 28 04 18 00 29 05 19 00 2A 06 1A 00 2B 07 1B 00 2C 08 1C 00 2D 09 1D 00 2E 0A 1E 00 2F 0B 1F 00 30 0C 20 00 31 0D 21 00 32 0E 22 00 33 0F 23 00 02 00 7F 03 00 7F 04 00 7F 05 00 7F 06 00 7F 07 00 7F 08 00 7F 09 00 7F 0C F7"),                          
            --Change to preset 1.
            -- remote.make_midi("F0 47 7F 7C 62 00 01 01 F7")
        }
end


function remote_init()
	remote.define_items{
		item{ name = "Keyboard", input = "keyboard" },
		item{ name = "Knob 1", input = "value", min = 0, max = 127 },
		item{ name = "Knob 2", input = "value", min = 0, max = 127 },
		item{ name = "Knob 3", input = "value", min = 0, max = 127 },
		item{ name = "Knob 4", input = "value", min = 0, max = 127 },
		item{ name = "Knob 5", input = "value", min = 0, max = 127 },
		item{ name = "Knob 6", input = "value", min = 0, max = 127 },
		item{ name = "Knob 7", input = "value", min = 0, max = 127 },
		item{ name = "Knob 8", input = "value", min = 0, max = 127 },
		item{ name = "Pitch Bend", input = "value", min = 0, max = 16383 },
		item{ name = "Mod Up", input = "value", min = 0, max = 127 },
		item{ name = "Mod Down", input = "value", min = 0, max = 127 },
		item{ name = "Pedal", input = "value", min = 0, max = 127 },
		item{ name = "Stick Up", input = "value", min = 0, max = 127 }, -- b0 0c 00..7f
		item{ name = "Stick Down", input = "value", min = 0, max = 127 }, -- b0 02 00..7f
		item{ name = "Stick Left", input = "value", min = 0, max = 127 }, -- b0 0c 00..7f
		item{ name = "Stick Right", input = "value", min = 0, max = 127 }, -- b0 02 00..7f

		item{ name = "Pad 1A", input = "button" },
		item{ name = "Pad 2A", input = "button" },
		item{ name = "Pad 3A", input = "button" },
		item{ name = "Pad 4A", input = "button" },
		item{ name = "Pad 5A", input = "button" },
		item{ name = "Pad 6A", input = "button" },
		item{ name = "Pad 7A", input = "button" },
		item{ name = "Pad 8A", input = "button" },

		item{ name = "Pad 1B", input = "button" },
		item{ name = "Pad 2B", input = "button" },
		item{ name = "Pad 3B", input = "button" },
		item{ name = "Pad 4B", input = "button" },
		item{ name = "Pad 5B", input = "button" },
		item{ name = "Pad 6B", input = "button" },
		item{ name = "Pad 7B", input = "button" },
		item{ name = "Pad 8B", input = "button" },
		item{ name = "Rewind", input="button" },
		item{ name = "Fast Forward", input="button" },
		item{ name = "Stop", input="button" },
		item{ name = "Play", input="button" },
		item{ name = "Record", input="button" },
	}

	remote.define_auto_inputs{
		-- CC Pad Bank A
		{ pattern = "b? 10 xx", name = "Pad 1A" },
		{ pattern = "b? 11 xx", name = "Pad 2A" },
		{ pattern = "b? 12 xx", name = "Pad 3A" },
		{ pattern = "b? 13 xx", name = "Pad 4A" },
		{ pattern = "b? 14 xx", name = "Pad 5A" },
		{ pattern = "b? 15 xx", name = "Pad 6A" },
		{ pattern = "b? 16 xx", name = "Pad 7A" },
		{ pattern = "b? 17 xx", name = "Pad 8A" },
		-- CC Pad Bank B
		{ pattern = "b? 20 xx", name = "Pad 1B" },
		{ pattern = "b? 21 xx", name = "Pad 2B" },
		{ pattern = "b? 22 xx", name = "Pad 3B" },
		{ pattern = "b? 23 xx", name = "Pad 4B" },
		{ pattern = "b? 24 xx", name = "Pad 5B" },
		{ pattern = "b? 25 xx", name = "Pad 6B" },
		{ pattern = "b? 26 xx", name = "Pad 7B" },
		{ pattern = "b? 27 xx", name = "Pad 8B" },
		-- Delta Knobs
		{ pattern = "b? 46 xx", name = "Knob 1" },
		{ pattern = "b? 47 xx", name = "Knob 2" },
		{ pattern = "b? 48 xx", name = "Knob 3" },
		{ pattern = "b? 49 xx", name = "Knob 4" },
		{ pattern = "b? 4A xx", name = "Knob 5" },
		{ pattern = "b? 4B xx", name = "Knob 6" },
		{ pattern = "b? 4C xx", name = "Knob 7" },
		{ pattern = "b? 4D xx", name = "Knob 8" },
		-- Keyboard
		{ pattern = "b? 40 xx", name = "Pedal" },
		{ pattern = "e? xx yy", name = "Pitch Bend", value = "y*128 + x" },
		{ pattern = "b? 01 xx", name = "Mod Up" },
		{ pattern = "b? 02 xx", name = "Mod Down" },
		{ pattern = "8? xx yy", name = "Keyboard", value = "0", note = "x", velocity = "64" },
		{ pattern = "9? xx 00", name = "Keyboard", value = "0", note = "x", velocity = "64" },
		{ pattern = "<100x>? yy zz", name = "Keyboard" },
		{ pattern="b? 73 7f", name="Rewind", value="1" },
		{ pattern="b? 74 7f", name="Fast Forward", value="1" },
		{ pattern="b? 75 7f", name="Stop", value="1" },
		{ pattern="b? 76 7f", name="Play", value="1" },
		{ pattern="b? 77 7f", name="Record", value="1" },
	}
end
