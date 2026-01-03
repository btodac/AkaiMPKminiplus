local items = {}
local last_item = 0

function item(item_def)
  local prop_name = string.lower(item_def.name):gsub(" ", "_")
  last_item = last_item + 1
  items[prop_name] = last_item
  return item_def
end

-- remote_probe and remote_prepare_for_use work but the details of how/why are lost on me!
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
		-- The keyboard and the pads will both send note information
		-- pads on 89/99 keyboard on 80/90. The pads must be set to NOTE
		item{ name = "Keyboard", input = "keyboard" },
		-- Knobs must be set to RELATIVE
		item{ name = "Knob 1", input = "delta" },
		item{ name = "Knob 2", input = "delta" },
		item{ name = "Knob 3", input = "delta" },
		item{ name = "Knob 4", input = "delta" },
		item{ name = "Knob 5", input = "delta" },
		item{ name = "Knob 6", input = "delta" },
		item{ name = "Knob 7", input = "delta" },
		item{ name = "Knob 8", input = "delta" },
		-- Standard modifiers
		item{ name = "Pitch Bend", input = "value", min = 0, max = 16383 },
		item{ name = "Mod Up", input = "value", min = 0, max = 127 },
		item{ name = "Mod Down", input = "value", min = 0, max = 127 },
		item{ name = "Pedal", input = "value", min = 0, max = 127 },
		-- The stick must be set up to use DUAL CC on both axes
		item{ name = "Stick Up", input = "value", min = 0, max = 127 }, 
		item{ name = "Stick Down", input = "value", min = 0, max = 127 },
		item{ name = "Stick Left", input = "value", min = 0, max = 127 },
		item{ name = "Stick Right", input = "value", min = 0, max = 127 },
		-- Transport controls
		item{ name = "Rewind", input="button" },
		item{ name = "Fast Forward", input="button" },
		item{ name = "Stop", input="button" },
		item{ name = "Play", input="button" },
		item{ name = "Record", input="button" },
	}

	remote.define_auto_inputs{
		-- Delta Knobs: When the MPKmini plus program uses 'RELATIVE' the knobs inc/dec the value sending
		-- the last byte with either 01 (INC) or 7F (DEC)
		{ pattern = "b? 46 <???y>?", name = "Knob 1", value="1-2*y" }, -- <???y> is a bit mask to obtain the last bit of the first nibble
		{ pattern = "b? 47 <???y>?", name = "Knob 2", value="1-2*y" }, -- for INC y = 0, for DEC y = 1
		{ pattern = "b? 48 <???y>?", name = "Knob 3", value="1-2*y" },
		{ pattern = "b? 49 <???y>?", name = "Knob 4", value="1-2*y" },
		{ pattern = "b? 4A <???y>?", name = "Knob 5", value="1-2*y" },
		{ pattern = "b? 4B <???y>?", name = "Knob 6", value="1-2*y" },
		{ pattern = "b? 4C <???y>?", name = "Knob 7", value="1-2*y" },
		{ pattern = "b? 4D <???y>?", name = "Knob 8", value="1-2*y" },
		-- Stick
		{ pattern = "b? 32 xx", name = "Stick Left"},
		{ pattern = "b? 33 xx", name = "Stick Right"},
		{ pattern = "b? 34 xx", name = "Stick Up"},
		{ pattern = "b? 35 xx", name = "Stick Down"},
		-- Keyboard
		{ pattern = "b? 40 xx", name = "Pedal" },
		{ pattern = "e? xx yy", name = "Pitch Bend", value = "y*128 + x" },
		{ pattern = "b? 01 xx", name = "Mod Up" },
		{ pattern = "b? 02 xx", name = "Mod Down" },
		{ pattern = "<100x>? yy zz", name = "Keyboard" },
		-- Transport
		{ pattern="b? 73 7f", name="Rewind", value="1" },
		{ pattern="b? 74 7f", name="Fast Forward", value="1" },
		{ pattern="b? 75 7f", name="Stop", value="1" },
		{ pattern="b? 76 7f", name="Play", value="1" },
		{ pattern="b? 77 7f", name="Record", value="1" },
	}
end
