
	=======================
	How to create an HUD
	=======================

	1- Preprocessor functions (kind of)
	2- Array definition (color, shader)
	3- SetCvar element
	4- Item definition
	5- Specific keyword:
	6- Item properties



1-Preprocessor functions (kind of)

	Even if the cfg file is not compiled, you can use some preprocessor's like functions (it's a standard feature of q3a) :
		#define
		eg: #define ICON_SIZE 48

		#include
		eg: #include "HUD/include/include.cfg"

		$evalfloat(xxx) to return the float result of an operation
		eg: $evalint(185.5 + GIANTCHAR_WIDTH*3.5 + TEXT_ICON_SPACE)

		$evalint(xxx) to return the integer result of an operation
		eg: $evalint(185 + GIANTCHAR_HEIGHT)

		Use them as often as you can, it permit avoiding "magic numer", and it's only free (calculated once).
		Because of this functionnality, you can't use # as a commentary marker anymore.
		For commentaries, use '//any commentary' or '/* any multiline commentary */


2- Arrays definition (color, shader )

	Some item can use different colors depending of their value. As the health counter who is red when low.
	Those arrays (HealthColors | ArmorColors | AmmoColors | TeamsColors) can be use as a color value, and the index of the color used will be set accordingly.
	eg: this item will use color array 'HealthColors' and the index will be choose according to the caption value, 'VAL_HEALTH' here, but any VAL_XXX works :
	itemDef
	{
		rect 50 50 - ICON_SIZE) 0 0
		font numbers
		fontsize 20 20
		forecolor HealthColors
		caption VAL_HEALTH
	}
	
	GameTypeIcons is an array of pictures, it will be use like an color array, but depending of the gameType, with the background property who must be set to ICON_GAME_TYPE
	eg:
 	// icon according to game type
	itemDef {
		rect 8 7 19 19
		backcolor 1 1 1 1
		background ICON_GAME_TYPE
	}


3- SetCvar element

	You can force some cvar in the SetCvar element. Console command have the last word, but this will be executed any begining of a match, so use them carrefully.
	Not all cvar can be used, only : TODO here, list the useable cvar.
	eg:
	// force horizontal weapon list
	SetCvar
	{
		cg_drawWeaponSelect 	2
	}
	The same cvar can be use as a visible option, see below.


4- Item definition

	Most of the item use itemDef. This item can be use to draw picture,text,counter,some dynamic element,gradient texture, etc.
 
	There is still some dynamic item, because they need another item to be drawn, or draw severall element at a time.
	TODO list & explanation:
	Crosshair/CrosshairNames/Icon_Flag/StatusBar_TeamBar
Icon_WeaponList/Icon_WeaponList_Selected/WeaponList/WeaponList_Vertical/WeaponList_SelectedName/Reward/TeamChat/VoteMessageArena/VoteMessageWorld/NetGraph/NetGraphPing/TeamOverlay/TeamOverlay_Selected/Icon_Attacker/Attacker/Score/PowerUpCounter/Icon_PowerUp/ItemPickup/Icon_ItemPickup/WarmupVersus/WarmupGametype/WarmupCount/KillMessage/ItemMessage/WarmupFightMessage/ServerMessage


5- Specific keyword:

	-VAL_XXX keywords:
		VAL_HEALTH, VAL_ARMOR, VAL_AMMO, VAL_WEAPON, VAL_SCORE, VAL_TIMER, VAL_HOLDABLE_ITEM,
		VAL_FPS, VAL_SPEED, VAL_FOLLOW_NAME, VAL_SNAPSHOT, VAL_CAPFRAG_LIMIT, VAL_FRAG_LIMIT,
		VAL_CAPTURE_LIMIT, VAL_TIME_LIMIT, VAL_LOCATION, VAL_NAME, VAL_PLAYERS_NB_TEAM
	(see param)
	Can be used in 'caption' and 'gradient' and 'visible'
	


6- Item properties

	The 'itemDef' element can use all of the listed properties.
	Some dynamic items (see above) don't use all properties like the standard itemDef, because sometime it just make no sense.
	(like adding a caption to the Icon_Flag. If you really want to do this, create a new item)

	-name
		eg : name "myname"
		No name are really required, this is mainly used to define a parent name. (see below)
		The double quote are required.
		Consider puting a name to each itemDef element, as it help remember the item function.
		Non-itemDef elements don't need name, as theirs element name can be use as a parent.
		eg: parent Score  // no double quote in this case!

	-rect
		syntax: rect x y width height
		eg : rect 100 100 20 20
		x and y position you element, width and height are for background, shader or color.
		Only one value is required. eg: rect 100
		The order is important, fill with 0 every not needed values. eg: rect 0 0 20 20
		When using a parent item, the final position will be change according to the parent, but also the item rect. These allow spacing between element.

	-background
		Draw a picture or a shader.
		You can add your picture, using path in double quote:
		eg: background "hud/misc/grad_vert"
	
		Or a dynamic shader with specific keyword from this list:
		ICON_GAME_TYPE, ICON_HOLDABLE_ITEM, ICON_BLUE_FLAG, ICON_RED_FLAG,
		ICON_HEAD, ICON_HEAD_ANIM, ICON_ARMOR, ICON_AMMO, ICON_ORDER, ICON_POWERUP
		eg: background ICON_HEAD
		TODO short explanation for those keywords

	-icon3D
		When cg_draw3dIcons is 0, you can force 3D of a specific item with this keyword.
		TODO list all 3D drawable item, (ICON_HEAD, ICON_HEAD_ANIM, ICON_ARMOR, ICON_AMMO, ICON_POWERUP ?)


	-gradient
		this allow to partially draw a background color or picture, depending of the value.
		eg: gradient VAL_HEALTH
		In this exemple, if you draw a background texture or color, and your health is 50% the background will only display 50% of the texture.
		This can be use with all VAL_XXX keywords, even if sometime it make no sense.
		Use the '!' operator if you need the opposite part of a value.
		eg: gradient !VAL_HEALTH // return 60% when your health is 40%
		For a vertical gradient, see the keyword 'verticalbar'


	-verticalbar
		Allow drawing of vertical gradient
		No parameters are required


	-forecolor
		syntax:  forecolor R G B A
		eg: forecolor 1 0 0 0.5 // red with transparency
		This keyword allow to define the text color.
		Can use specific keyword, like color arrays, HealthColors, ArmorColors, AmmoColors (see above); or specific color: T, E, BlueTeamColor, RedTeamColor
		eg: forecolor T // my team color
		eg: forecolor E // the opposite team color


	-backcolor
		syntax:  backcolor R G B A
		This can use for background color, with fill keyword, or as draw color of a shader.
		The keywords and functionnalities are the same than for the forecolor property. (see above)


	-caption
		syntax:  caption VAL_FPS   and    caption "Hello there"
		Allow printing of any string.
		a fontsize must be specified
		This can be used with keyword (see below) textalign, font, proportional, shadow
		It can be use to print dynamic VAL_XXX variable 
		The color of the text is set with the forecolor keyword.


	-fontsize
		syntax: fontsize width height
		Set the character size to a string defined by the 'caption' keyword.
		If height is not provide, the height will be equal to the width.
		eg: fontsize 10


	-textalign
		syntax: textalign Left|Center|Right or textalign L|C|R
		eg: textalign Center
		textalign Left is default.
		
		
	-font
		syntax: font Number
		Switch the string drawing into fancy number or standard letter
		Only Number allowed at the moment
		
		
	-shadow
		syntax: shadow
		Draw a shadowed text
		No parameters required
		
		
	-proportional
		syntax: proportional
		When not specified, all letters take the same width.
		No parameters required


	-param
		some value in 'caption' or 'gradient' needs integers parameters.
		VAL_AMMO / VAL_ARMOR / VAL_HEALTH for example, can use soft limit or hard limit. This can be selected with param keyword.
		eg:	caption VAL_HEALTH
			param 2 // this only show the health above the soft limit (when > 100).
		VAL_HEALTH VAL_ARMOR VAL_AMMO if param 1 : value below soft limit
		VAL_HEALTH VAL_ARMOR VAL_AMMO if param 2 : value above soft limit	
		VAL_SPEED if param 1: no unit
		VAL_TIMER if param 1: second:millisecond
		VAL_TIMER if param 2: countdown
		VAL_SCORE if param 1: red | 2: blue | 3: opposing team score | 0: own score (default)
		VAL_PLAYERS_NB_TEAM if param 1: red | 2: blue | 3: opposing team player number | 0: own team (default)
		ItemPickup if param 1: nb of items picked up
		ItemPickup if param 2: name of items picked up


	-parent
		When defined in an item, the item will be positionnate according to the parent item final position.
		When parent is not draw, not visible, the item will positionate according to the 'rect' parent (not the final position)
		When 'rect' parent is not defined, and the parent not draw, the parent of the parent will be used recursively.
	
	
	-anchors
		syntax: anchors <L|C|R> and <T|M|B>
		or:  	anchors <Left|Center|Right> and <Top|Middle|Bottom>
		eg: "anchor Top Right"
	
	
	-margin
		syntax: margin left right top bottom
		eg: margin 4 2 4 4
		Only one value is required. eg: margin 4
		The order is important, fill with 0 every not needed values. eg: margin 0 0 4 2
	
	
	-valign
		valign T | M | B or top | middle | bottom


	-visible
		Item are alsways drawn, except if dead or the scoreboard is being explicitly shown. But this can be change with following flag:
		Syntax: visible false | true | 0 | 1 | VIS_NEVER | VIS_IN_MENU | VIS_IN_SCORE
			=> VIS_TEAM_BLUE | VIS_TEAM_RED | VIS_TEAM_SPECTATOR | VIS_TEAM_PLAY | VIS_TEAM_BLUE_OR_RED | VIS_PMF_FOLLOW | VIS_LOW_AMMO_WARNING | VIS_WARMUP | VIS_LOCAL_SERVER
			=> VIS_GT_TOURNAMENT | VIS_GT_FFA | VIS_GT_TDM | VIS_GT_CTF | VIS_GT_1FCTF | VIS_GT_OBELISK | VIS_GT_HARVESTER | VIS_GT_FREEZE
		All VIS_XXX and VAL_XXX keywords can be used.
		If the '!' operator is present before the keyword, the visibility is reversed.
		For testing visibility according to a cvar, see property 'cvarTest' below.

	-cvarTest
		Visibility related keyword.
		The item will be visible if the cvar under double quote is not equal to zero.
		eg: cvarTest "cg_drawStatus"
		
		
	-fill
		No parameters are required
		Fill the background with the backcolor provided.
	
	
	-blink
		No parameters are required
		Just blink the item.
		It is used to blink the 'Connection Interrupted' message & icon
	
	-time
		eg: time 9000
		Depending of the item, this property can be a visibility counter, a fade color counter.
		
	
	-pulseScale
		eg: pulseScale 1.5
		Depending of the item, this property give the ammount to scale an icon or text, when player is hurt for example.

	-team_player
		It is possible to draw a property of a team player by selected the player with his index in the team overlay array.
		If team_player -1 the player drawn will be the selected one.
		To select a player, and give him a "team arena" order, you need to bind prevTeamMember, nextTeamMember and nextOrder:
		bind PGUP "prevTeamMember"
		bind PGDN "nextTeamMember"
		bind o "nextOrder"




