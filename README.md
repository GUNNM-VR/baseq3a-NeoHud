# Quake III arena Neo Hud

<a href="https://discord.gg/pAZCJ9pt"><img src="https://img.shields.io/discord/950865674505437214?color=7289da&logo=discord&logoColor=white" alt="Discord server" /></a>

This is a HUD parser for Quake III arena, based on Cyrax's baseq3a.

It is easy to use and highly customisable with preprocessors commands (kind of), and cvar setup from the HUD file.

The syntax is very close to cpma HUD syntax, and team arena/quake live HUD/menu.
Inspired by Q3plus, you can change the HUD from the game menu.

### Some HUD files are already included :
* defrag like
* quake live
* quake3 mission pack / Team Arena
* VR adapted HUD

The Team Arena HUD is fully fonctionnal, Team Arena orders are activated, so you will need to bind keys if you want to use them. 
For example, in your autoexec.cfg :
```
bind 	PGUP 	"prevTeamMember"
bind 	PGDN 	"nextTeamMember"
bind 	o 			"nextOrder"
```

# create a new HUD
Instructions are in the embeded document :
https://github.com/GUNNM-VR/baseq3a-NeoHud/blob/master/assets/hud/readme.txt

# baseq3a features:

 * new toolchain used (optimized q3lcc and q3asm)
 * upstream security fixes
 * floatfix
 * fixed vote system
 * fixed spawn system
 * fixed in-game crosshair proportions
 * fixed UI mouse sensitivity for high-resolution
 * fixed server browser + faster scanning
 * new demo UI (subfolders,filtering,sorting)
 * updated serverinfo UI
 * map rotation system
 * unlagged weapons
 * improved prediction
 * damage-based hitsounds
 * colored skins
 * high-quality proportional font renderer

# Documentation

See /docs/

# Compilation and installation

Look in /build/

## Links

* https://github.com/ec-/Quake3e
* https://github.com/ec-/baseq3a
* https://q3area.blogspot.com/
