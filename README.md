# Akai MPK mini plus codec for Reason Studio
This repo contains the files required to use the MPK mini plus with Reason.
The pads and keyboard both behave as normal midi keyboard controllers.
The knobs act as "infinite" knobs that increment/decrement the associated value.
The joystick is accessible but nothing is mapped to it (see below)
The transport controls are mapped to the master Reason controls

There is a program that must be uploaded to the MPK mini plus using the [Akai MPK mini plus Program Manager](https://www.akaipro.com/downloads#mpkminiplus)
and Lua codec and Reason Remote Map files that need to be placed in the appropriate folder in the Remote folder.

## Installation

1. Copy the contents of the `Lua Codecs` folder to `<Reason>/Remote/DefaultCodecs/Lua Codecs/Akai`
2. Copy `DefaultMaps/AkaiMPKmini_plus.remotemap` to `<Reason>/Remote/DefaultMaps/Akai`
3. Load `hardware_programs/Reason.mpkminiplus` in the Akai MPK mini plus Program Manager and then send it to the attached MPK mini plus controller (it's all in the File tab in the application)
4. Enjoy

## Usage

Open Reason and access the controller preferences (`Edit->Preferences...->Control Surfaces`).
Then in the `Remote keyboards and control surfaces` box select `Add manually` and choose the Akai MPK mini plus with the *in port* selected as 'MPK mini Plus'.
Everything should be working now!

## Notes

The joystick is available but it is not mapped in any devices.
To map it open the `AkaiMPKmini_plus.remotemap` file in your Reason directory and find the entry for the Reason Synth/Fx/whatever you wish to use it with.
The controller name is "Stick X" or "Stick Y" and central position values are 64 with extreme left as 0 and extreme down as 0 and right and top as 127.
For example
```
Scope	Propellerheads	THOR Polysonic Synthesizer

Map Stick X    Filter 3 Freq
Map Stick Y    Filter 3 Res

Map	Knob 1		Filter 1 Freq	
Map	Knob 2		Filter 1 Res	
...
```

There are two Lua functions in the codec which contain binary that I do not understand but it seems to work.
If you understand the `remote_probe` and `remote_prepare_for_use` functions and how to set them up please feel free to improve the script and raise a PR!

