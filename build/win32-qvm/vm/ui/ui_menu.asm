code
proc MainMenu_ExitAction 0 0
file "..\..\..\..\code\q3_ui\ui_menu.c"
line 58
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:MAIN MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ID_SINGLEPLAYER			10
;16:#define ID_MULTIPLAYER			11
;17:#define ID_SETUP				12
;18:#define ID_DEMOS				13
;19:#define ID_CINEMATICS			14
;20:#define ID_TEAMARENA			15
;21:#define ID_MODS					16
;22:#define ID_EXIT					17
;23:
;24:#define MAIN_BANNER_MODEL				"models/mapobjects/banner/banner5.md3"
;25:#define MAIN_MENU_VERTICAL_SPACING		34
;26:
;27:
;28:typedef struct {
;29:	menuframework_s	menu;
;30:
;31:	menutext_s		singleplayer;
;32:	menutext_s		multiplayer;
;33:	menutext_s		setup;
;34:	menutext_s		demos;
;35:	menutext_s		cinematics;
;36:	menutext_s		teamArena;
;37:	menutext_s		mods;
;38:	menutext_s		exit;
;39:
;40:	qhandle_t		bannerModel;
;41:} mainmenu_t;
;42:
;43:
;44:static mainmenu_t s_main;
;45:
;46:typedef struct {
;47:	menuframework_s menu;	
;48:	char errorMessage[4096];
;49:} errorMessage_t;
;50:
;51:static errorMessage_t s_errorMessage;
;52:
;53:/*
;54:=================
;55:MainMenu_ExitAction
;56:=================
;57:*/
;58:static void MainMenu_ExitAction( qboolean result ) {
line 59
;59:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $71
line 60
;60:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 62
;61:	}
;62:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 63
;63:	UI_CreditMenu();
ADDRGP4 UI_CreditMenu
CALLV
pop
line 64
;64:}
LABELV $70
endproc MainMenu_ExitAction 0 0
export Main_MenuEvent
proc Main_MenuEvent 8 12
line 73
;65:
;66:
;67:
;68:/*
;69:=================
;70:Main_MenuEvent
;71:=================
;72:*/
;73:void Main_MenuEvent (void* ptr, int event) {
line 74
;74:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $74
line 75
;75:		return;
ADDRGP4 $73
JUMPV
LABELV $74
line 78
;76:	}
;77:
;78:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 17
GTI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $91-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $91
address $79
address $80
address $81
address $82
address $83
address $85
address $84
address $89
code
LABELV $79
line 80
;79:	case ID_SINGLEPLAYER:
;80:		UI_SPLevelMenu();
ADDRGP4 UI_SPLevelMenu
CALLV
pop
line 81
;81:		break;
ADDRGP4 $77
JUMPV
LABELV $80
line 84
;82:
;83:	case ID_MULTIPLAYER:
;84:		UI_ArenaServersMenu();
ADDRGP4 UI_ArenaServersMenu
CALLV
pop
line 85
;85:		break;
ADDRGP4 $77
JUMPV
LABELV $81
line 88
;86:
;87:	case ID_SETUP:
;88:		UI_SetupMenu();
ADDRGP4 UI_SetupMenu
CALLV
pop
line 89
;89:		break;
ADDRGP4 $77
JUMPV
LABELV $82
line 92
;90:
;91:	case ID_DEMOS:
;92:		UI_DemosMenu();
ADDRGP4 UI_DemosMenu
CALLV
pop
line 93
;93:		break;
ADDRGP4 $77
JUMPV
LABELV $83
line 96
;94:
;95:	case ID_CINEMATICS:
;96:		UI_CinematicsMenu();
ADDRGP4 UI_CinematicsMenu
CALLV
pop
line 97
;97:		break;
ADDRGP4 $77
JUMPV
LABELV $84
line 100
;98:
;99:	case ID_MODS:
;100:		UI_ModsMenu();
ADDRGP4 UI_ModsMenu
CALLV
pop
line 101
;101:		break;
ADDRGP4 $77
JUMPV
LABELV $85
line 104
;102:
;103:	case ID_TEAMARENA:
;104:		trap_Cvar_Set( "fs_game", "missionpack");
ADDRGP4 $86
ARGP4
ADDRGP4 $87
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 105
;105:		trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $88
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 106
;106:		break;
ADDRGP4 $77
JUMPV
LABELV $89
line 109
;107:
;108:	case ID_EXIT:
;109:		UI_ConfirmMenu( "EXIT GAME?", NULL, MainMenu_ExitAction );
ADDRGP4 $90
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 MainMenu_ExitAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 110
;110:		break;
LABELV $76
LABELV $77
line 112
;111:	}
;112:}
LABELV $73
endproc Main_MenuEvent 8 12
export MainMenu_Cache
proc MainMenu_Cache 4 4
line 120
;113:
;114:
;115:/*
;116:===============
;117:MainMenu_Cache
;118:===============
;119:*/
;120:void MainMenu_Cache( void ) {
line 121
;121:	s_main.bannerModel = trap_R_RegisterModel( MAIN_BANNER_MODEL );
ADDRGP4 $95
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 s_main+896
ADDRLP4 0
INDIRI4
ASGNI4
line 122
;122:}
LABELV $93
endproc MainMenu_Cache 4 4
export ErrorMessage_Key
proc ErrorMessage_Key 0 8
line 125
;123:
;124:sfxHandle_t ErrorMessage_Key(int key)
;125:{
line 126
;126:	trap_Cvar_Set( "com_errorMessage", "" );
ADDRGP4 $97
ARGP4
ADDRGP4 $98
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 127
;127:	UI_MainMenu();
ADDRGP4 UI_MainMenu
CALLV
pop
line 128
;128:	return (menu_null_sound);
ADDRGP4 menu_null_sound
INDIRI4
RETI4
LABELV $96
endproc ErrorMessage_Key 0 8
data
align 4
LABELV $100
byte 4 1056964608
byte 4 0
byte 4 0
byte 4 1065353216
code
proc Main_MenuDraw 576 28
line 138
;129:}
;130:
;131:/*
;132:===============
;133:Main_MenuDraw
;134:TTimo: this function is common to the main menu and errorMessage menu
;135:===============
;136:*/
;137:
;138:static void Main_MenuDraw( void ) {
line 145
;139:	refdef_t		refdef;
;140:	refEntity_t		ent;
;141:	vec3_t			origin;
;142:	vec3_t			angles;
;143:	float			adjust;
;144:	float			x, y, w, h;
;145:	vec4_t			color = {0.5, 0, 0, 1};
ADDRLP4 552
ADDRGP4 $100
INDIRB
ASGNB 16
line 149
;146:
;147:	// setup the refdef
;148:
;149:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 151
;150:
;151:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 153
;152:
;153:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 155
;154:
;155:	x = 0;
ADDRLP4 536
CNSTF4 0
ASGNF4
line 156
;156:	y = 0;
ADDRLP4 540
CNSTF4 0
ASGNF4
line 157
;157:	w = 640;
ADDRLP4 544
CNSTF4 1142947840
ASGNF4
line 158
;158:	h = 120;
ADDRLP4 548
CNSTF4 1123024896
ASGNF4
line 159
;159:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 536
ARGP4
ADDRLP4 540
ARGP4
ADDRLP4 544
ARGP4
ADDRLP4 548
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 160
;160:	refdef.x = x;
ADDRLP4 0
ADDRLP4 536
INDIRF4
CVFI4 4
ASGNI4
line 161
;161:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 540
INDIRF4
CVFI4 4
ASGNI4
line 162
;162:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 544
INDIRF4
CVFI4 4
ASGNI4
line 163
;163:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 548
INDIRF4
CVFI4 4
ASGNI4
line 165
;164:
;165:	adjust = 0; // JDC: Kenneth asked me to stop this 1.0 * sin( (float)uis.realtime / 1000 );
ADDRLP4 520
CNSTF4 0
ASGNF4
line 166
;166:	refdef.fov_x = 60 + adjust;
ADDRLP4 0+16
ADDRLP4 520
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 167
;167:	refdef.fov_y = 19.6875 + adjust;
ADDRLP4 0+20
ADDRLP4 520
INDIRF4
CNSTF4 1100840960
ADDF4
ASGNF4
line 169
;168:
;169:	refdef.time = uis.realtime;
ADDRLP4 0+72
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 171
;170:
;171:	origin[0] = 300;
ADDRLP4 508
CNSTF4 1133903872
ASGNF4
line 172
;172:	origin[1] = 0;
ADDRLP4 508+4
CNSTF4 0
ASGNF4
line 173
;173:	origin[2] = -32;
ADDRLP4 508+8
CNSTF4 3254779904
ASGNF4
line 175
;174:
;175:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 179
;176:
;177:	// add the banner model
;178:
;179:	memset( &ent, 0, sizeof(ent) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 181
;180:
;181:	adjust = 5.0 * sin( (float)uis.realtime / 5000 );
ADDRGP4 uis+4
INDIRI4
CVIF4 4
CNSTF4 961656599
MULF4
ARGF4
ADDRLP4 568
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 520
ADDRLP4 568
INDIRF4
CNSTF4 1084227584
MULF4
ASGNF4
line 182
;182:	VectorSet( angles, 0, 180 + adjust, 0 );
ADDRLP4 524
CNSTF4 0
ASGNF4
ADDRLP4 524+4
ADDRLP4 520
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
ADDRLP4 524+8
CNSTF4 0
ASGNF4
line 183
;183:	AnglesToAxis( angles, ent.axis );
ADDRLP4 524
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 184
;184:	ent.hModel = s_main.bannerModel;
ADDRLP4 368+8
ADDRGP4 s_main+896
INDIRI4
ASGNI4
line 185
;185:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRLP4 508
INDIRB
ASGNB 12
line 186
;186:	VectorCopy( origin, ent.lightingOrigin );
ADDRLP4 368+12
ADDRLP4 508
INDIRB
ASGNB 12
line 187
;187:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 188
;188:	VectorCopy( ent.origin, ent.oldorigin );
ADDRLP4 368+84
ADDRLP4 368+68
INDIRB
ASGNB 12
line 190
;189:
;190:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 192
;191:
;192:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 194
;193:
;194:	if (strlen(s_errorMessage.errorMessage))
ADDRGP4 s_errorMessage+288
ARGP4
ADDRLP4 572
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 572
INDIRI4
CNSTI4 0
EQI4 $123
line 195
;195:	{
line 196
;196:		UI_DrawProportionalString_AutoWrapped( 320, 192, 600, 20, s_errorMessage.errorMessage, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
CNSTI4 320
ARGI4
CNSTI4 192
ARGI4
CNSTI4 600
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 s_errorMessage+288
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString_AutoWrapped
CALLV
pop
line 197
;197:	}
ADDRGP4 $124
JUMPV
LABELV $123
line 199
;198:	else
;199:	{
line 201
;200:		// standard menu drawing
;201:		Menu_Draw( &s_main.menu );		
ADDRGP4 s_main
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 202
;202:	}
LABELV $124
line 204
;203:
;204:	if (uis.demoversion) {
ADDRGP4 uis+11464
INDIRI4
CNSTI4 0
EQI4 $127
line 205
;205:		UI_DrawProportionalString( 320, 372, "DEMO      FOR MATURE AUDIENCES      DEMO", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 372
ARGI4
ADDRGP4 $130
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 552
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 206
;206:		UI_DrawString( 320, 400, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 $131
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 552
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 207
;207:	} else {
ADDRGP4 $128
JUMPV
LABELV $127
line 208
;208:		UI_DrawString( 320, 450, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 450
ARGI4
ADDRGP4 $131
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 552
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 209
;209:	}
LABELV $128
line 210
;210:}
LABELV $99
endproc Main_MenuDraw 576 28
proc UI_TeamArenaExists 2084 16
line 218
;211:
;212:
;213:/*
;214:===============
;215:UI_TeamArenaExists
;216:===============
;217:*/
;218:static qboolean UI_TeamArenaExists( void ) {
line 226
;219:	int		numdirs;
;220:	char	dirlist[2048];
;221:	char	*dirptr;
;222:  char  *descptr;
;223:	int		i;
;224:	int		dirlen;
;225:
;226:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $133
ARGP4
ADDRGP4 $98
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2068
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2068
INDIRI4
ASGNI4
line 227
;227:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 228
;228:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $137
JUMPV
LABELV $134
line 229
;229:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 230
;230:		descptr = dirptr + dirlen;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 231
;231:		if (Q_stricmp(dirptr, "missionpack") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $87
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $138
line 232
;232:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $132
JUMPV
LABELV $138
line 234
;233:		}
;234:	dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ADDRLP4 2080
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 235
;235:	}
LABELV $135
line 228
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $137
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $134
line 236
;236:	return qfalse;
CNSTI4 0
RETI4
LABELV $132
endproc UI_TeamArenaExists 2084 16
export UI_MainMenu
proc UI_MainMenu 36 12
line 249
;237:}
;238:
;239:
;240:/*
;241:===============
;242:UI_MainMenu
;243:
;244:The main menu only comes up when not in a game,
;245:so make sure that the attract loop server is down
;246:and that local cinematics are killed
;247:===============
;248:*/
;249:void UI_MainMenu( void ) {
line 251
;250:	int		y;
;251:	qboolean teamArena = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 252
;252:	int		style = UI_CENTER | UI_DROPSHADOW;
ADDRLP4 4
CNSTI4 2049
ASGNI4
line 254
;253:
;254:	trap_Cvar_Set( "sv_killserver", "1" );
ADDRGP4 $141
ARGP4
ADDRGP4 $142
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 256
;255:
;256:	if( !uis.demoversion && !ui_cdkeychecked.integer ) {
ADDRGP4 uis+11464
INDIRI4
CNSTI4 0
NEI4 $143
ADDRGP4 ui_cdkeychecked+12
INDIRI4
CNSTI4 0
NEI4 $143
line 259
;257:		char	key[17];
;258:
;259:		trap_GetCDKey( key, sizeof(key) );
ADDRLP4 12
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 trap_GetCDKey
CALLV
pop
line 260
;260:		if( trap_VerifyCDKey( key, NULL ) == qfalse ) {
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 32
ADDRGP4 trap_VerifyCDKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $147
line 261
;261:			UI_CDKeyMenu();
ADDRGP4 UI_CDKeyMenu
CALLV
pop
line 262
;262:			return;
ADDRGP4 $140
JUMPV
LABELV $147
line 264
;263:		}
;264:	}
LABELV $143
line 266
;265:	
;266:	memset( &s_main, 0 ,sizeof(mainmenu_t) );
ADDRGP4 s_main
ARGP4
CNSTI4 0
ARGI4
CNSTI4 900
ARGI4
ADDRGP4 memset
CALLP4
pop
line 267
;267:	memset( &s_errorMessage, 0 ,sizeof(errorMessage_t) );
ADDRGP4 s_errorMessage
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4384
ARGI4
ADDRGP4 memset
CALLP4
pop
line 270
;268:
;269:	// com_errorMessage would need that too
;270:	MainMenu_Cache();
ADDRGP4 MainMenu_Cache
CALLV
pop
line 272
;271:	
;272:	trap_Cvar_VariableStringBuffer( "com_errorMessage", s_errorMessage.errorMessage, sizeof(s_errorMessage.errorMessage) );
ADDRGP4 $97
ARGP4
ADDRGP4 s_errorMessage+288
ARGP4
CNSTI4 4096
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 273
;273:	if ( s_errorMessage.errorMessage[0] )
ADDRGP4 s_errorMessage+288
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $151
line 274
;274:	{	
line 275
;275:		s_errorMessage.menu.draw = Main_MenuDraw;
ADDRGP4 s_errorMessage+268
ADDRGP4 Main_MenuDraw
ASGNP4
line 276
;276:		s_errorMessage.menu.key = ErrorMessage_Key;
ADDRGP4 s_errorMessage+272
ADDRGP4 ErrorMessage_Key
ASGNP4
line 277
;277:		s_errorMessage.menu.fullscreen = qtrue;
ADDRGP4 s_errorMessage+280
CNSTI4 1
ASGNI4
line 278
;278:		s_errorMessage.menu.wrapAround = qtrue;
ADDRGP4 s_errorMessage+276
CNSTI4 1
ASGNI4
line 279
;279:		s_errorMessage.menu.showlogo = qtrue;		
ADDRGP4 s_errorMessage+284
CNSTI4 1
ASGNI4
line 281
;280:
;281:		trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 282
;282:		uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 283
;283:		UI_PushMenu ( &s_errorMessage.menu );
ADDRGP4 s_errorMessage
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 285
;284:		
;285:		return;
ADDRGP4 $140
JUMPV
LABELV $151
line 288
;286:	}
;287:
;288:	s_main.menu.draw = Main_MenuDraw;
ADDRGP4 s_main+268
ADDRGP4 Main_MenuDraw
ASGNP4
line 289
;289:	s_main.menu.fullscreen = qtrue;
ADDRGP4 s_main+280
CNSTI4 1
ASGNI4
line 290
;290:	s_main.menu.wrapAround = qtrue;
ADDRGP4 s_main+276
CNSTI4 1
ASGNI4
line 291
;291:	s_main.menu.showlogo = qtrue;
ADDRGP4 s_main+284
CNSTI4 1
ASGNI4
line 293
;292:
;293:	y = 134;
ADDRLP4 0
CNSTI4 134
ASGNI4
line 294
;294:	s_main.singleplayer.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_main+288
CNSTI4 9
ASGNI4
line 295
;295:	s_main.singleplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+288+44
CNSTU4 264
ASGNU4
line 296
;296:	s_main.singleplayer.generic.x			= 320;
ADDRGP4 s_main+288+12
CNSTI4 320
ASGNI4
line 297
;297:	s_main.singleplayer.generic.y			= y;
ADDRGP4 s_main+288+16
ADDRLP4 0
INDIRI4
ASGNI4
line 298
;298:	s_main.singleplayer.generic.id			= ID_SINGLEPLAYER;
ADDRGP4 s_main+288+8
CNSTI4 10
ASGNI4
line 299
;299:	s_main.singleplayer.generic.callback	= Main_MenuEvent; 
ADDRGP4 s_main+288+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 300
;300:	s_main.singleplayer.string				= "SINGLE PLAYER";
ADDRGP4 s_main+288+64
ADDRGP4 $177
ASGNP4
line 301
;301:	s_main.singleplayer.color				= color_red;
ADDRGP4 s_main+288+72
ADDRGP4 color_red
ASGNP4
line 302
;302:	s_main.singleplayer.style				= style;
ADDRGP4 s_main+288+68
ADDRLP4 4
INDIRI4
ASGNI4
line 304
;303:
;304:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 305
;305:	s_main.multiplayer.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+364
CNSTI4 9
ASGNI4
line 306
;306:	s_main.multiplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+364+44
CNSTU4 264
ASGNU4
line 307
;307:	s_main.multiplayer.generic.x			= 320;
ADDRGP4 s_main+364+12
CNSTI4 320
ASGNI4
line 308
;308:	s_main.multiplayer.generic.y			= y;
ADDRGP4 s_main+364+16
ADDRLP4 0
INDIRI4
ASGNI4
line 309
;309:	s_main.multiplayer.generic.id			= ID_MULTIPLAYER;
ADDRGP4 s_main+364+8
CNSTI4 11
ASGNI4
line 310
;310:	s_main.multiplayer.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+364+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 311
;311:	s_main.multiplayer.string				= "MULTIPLAYER";
ADDRGP4 s_main+364+64
ADDRGP4 $195
ASGNP4
line 312
;312:	s_main.multiplayer.color				= color_red;
ADDRGP4 s_main+364+72
ADDRGP4 color_red
ASGNP4
line 313
;313:	s_main.multiplayer.style				= style;
ADDRGP4 s_main+364+68
ADDRLP4 4
INDIRI4
ASGNI4
line 315
;314:
;315:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 316
;316:	s_main.setup.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+440
CNSTI4 9
ASGNI4
line 317
;317:	s_main.setup.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+440+44
CNSTU4 264
ASGNU4
line 318
;318:	s_main.setup.generic.x					= 320;
ADDRGP4 s_main+440+12
CNSTI4 320
ASGNI4
line 319
;319:	s_main.setup.generic.y					= y;
ADDRGP4 s_main+440+16
ADDRLP4 0
INDIRI4
ASGNI4
line 320
;320:	s_main.setup.generic.id					= ID_SETUP;
ADDRGP4 s_main+440+8
CNSTI4 12
ASGNI4
line 321
;321:	s_main.setup.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+440+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 322
;322:	s_main.setup.string						= "SETUP";
ADDRGP4 s_main+440+64
ADDRGP4 $213
ASGNP4
line 323
;323:	s_main.setup.color						= color_red;
ADDRGP4 s_main+440+72
ADDRGP4 color_red
ASGNP4
line 324
;324:	s_main.setup.style						= style;
ADDRGP4 s_main+440+68
ADDRLP4 4
INDIRI4
ASGNI4
line 326
;325:
;326:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 327
;327:	s_main.demos.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+516
CNSTI4 9
ASGNI4
line 328
;328:	s_main.demos.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+516+44
CNSTU4 264
ASGNU4
line 329
;329:	s_main.demos.generic.x					= 320;
ADDRGP4 s_main+516+12
CNSTI4 320
ASGNI4
line 330
;330:	s_main.demos.generic.y					= y;
ADDRGP4 s_main+516+16
ADDRLP4 0
INDIRI4
ASGNI4
line 331
;331:	s_main.demos.generic.id					= ID_DEMOS;
ADDRGP4 s_main+516+8
CNSTI4 13
ASGNI4
line 332
;332:	s_main.demos.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+516+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 333
;333:	s_main.demos.string						= "DEMOS";
ADDRGP4 s_main+516+64
ADDRGP4 $231
ASGNP4
line 334
;334:	s_main.demos.color						= color_red;
ADDRGP4 s_main+516+72
ADDRGP4 color_red
ASGNP4
line 335
;335:	s_main.demos.style						= style;
ADDRGP4 s_main+516+68
ADDRLP4 4
INDIRI4
ASGNI4
line 337
;336:
;337:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 338
;338:	s_main.cinematics.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+592
CNSTI4 9
ASGNI4
line 339
;339:	s_main.cinematics.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+592+44
CNSTU4 264
ASGNU4
line 340
;340:	s_main.cinematics.generic.x				= 320;
ADDRGP4 s_main+592+12
CNSTI4 320
ASGNI4
line 341
;341:	s_main.cinematics.generic.y				= y;
ADDRGP4 s_main+592+16
ADDRLP4 0
INDIRI4
ASGNI4
line 342
;342:	s_main.cinematics.generic.id			= ID_CINEMATICS;
ADDRGP4 s_main+592+8
CNSTI4 14
ASGNI4
line 343
;343:	s_main.cinematics.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+592+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 344
;344:	s_main.cinematics.string				= "CINEMATICS";
ADDRGP4 s_main+592+64
ADDRGP4 $249
ASGNP4
line 345
;345:	s_main.cinematics.color					= color_red;
ADDRGP4 s_main+592+72
ADDRGP4 color_red
ASGNP4
line 346
;346:	s_main.cinematics.style					= style;
ADDRGP4 s_main+592+68
ADDRLP4 4
INDIRI4
ASGNI4
line 348
;347:
;348:	if (UI_TeamArenaExists()) {
ADDRLP4 12
ADDRGP4 UI_TeamArenaExists
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $254
line 349
;349:		teamArena = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 350
;350:		y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 351
;351:		s_main.teamArena.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+668
CNSTI4 9
ASGNI4
line 352
;352:		s_main.teamArena.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+668+44
CNSTU4 264
ASGNU4
line 353
;353:		s_main.teamArena.generic.x				= 320;
ADDRGP4 s_main+668+12
CNSTI4 320
ASGNI4
line 354
;354:		s_main.teamArena.generic.y				= y;
ADDRGP4 s_main+668+16
ADDRLP4 0
INDIRI4
ASGNI4
line 355
;355:		s_main.teamArena.generic.id				= ID_TEAMARENA;
ADDRGP4 s_main+668+8
CNSTI4 15
ASGNI4
line 356
;356:		s_main.teamArena.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+668+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 357
;357:		s_main.teamArena.string					= "TEAM ARENA";
ADDRGP4 s_main+668+64
ADDRGP4 $269
ASGNP4
line 358
;358:		s_main.teamArena.color					= color_red;
ADDRGP4 s_main+668+72
ADDRGP4 color_red
ASGNP4
line 359
;359:		s_main.teamArena.style					= style;
ADDRGP4 s_main+668+68
ADDRLP4 4
INDIRI4
ASGNI4
line 360
;360:	}
LABELV $254
line 362
;361:
;362:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 363
;363:	s_main.mods.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+744
CNSTI4 9
ASGNI4
line 364
;364:	s_main.mods.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+744+44
CNSTU4 264
ASGNU4
line 365
;365:	s_main.mods.generic.x				= 320;
ADDRGP4 s_main+744+12
CNSTI4 320
ASGNI4
line 366
;366:	s_main.mods.generic.y				= y;
ADDRGP4 s_main+744+16
ADDRLP4 0
INDIRI4
ASGNI4
line 367
;367:	s_main.mods.generic.id				= ID_MODS;
ADDRGP4 s_main+744+8
CNSTI4 16
ASGNI4
line 368
;368:	s_main.mods.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+744+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 369
;369:	s_main.mods.string					= "MODS";
ADDRGP4 s_main+744+64
ADDRGP4 $287
ASGNP4
line 370
;370:	s_main.mods.color					= color_red;
ADDRGP4 s_main+744+72
ADDRGP4 color_red
ASGNP4
line 371
;371:	s_main.mods.style					= style;
ADDRGP4 s_main+744+68
ADDRLP4 4
INDIRI4
ASGNI4
line 373
;372:
;373:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 374
;374:	s_main.exit.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+820
CNSTI4 9
ASGNI4
line 375
;375:	s_main.exit.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+820+44
CNSTU4 264
ASGNU4
line 376
;376:	s_main.exit.generic.x					= 320;
ADDRGP4 s_main+820+12
CNSTI4 320
ASGNI4
line 377
;377:	s_main.exit.generic.y					= y;
ADDRGP4 s_main+820+16
ADDRLP4 0
INDIRI4
ASGNI4
line 378
;378:	s_main.exit.generic.id					= ID_EXIT;
ADDRGP4 s_main+820+8
CNSTI4 17
ASGNI4
line 379
;379:	s_main.exit.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+820+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 380
;380:	s_main.exit.string						= "EXIT";
ADDRGP4 s_main+820+64
ADDRGP4 $305
ASGNP4
line 381
;381:	s_main.exit.color						= color_red;
ADDRGP4 s_main+820+72
ADDRGP4 color_red
ASGNP4
line 382
;382:	s_main.exit.style						= style;
ADDRGP4 s_main+820+68
ADDRLP4 4
INDIRI4
ASGNI4
line 384
;383:
;384:	Menu_AddItem( &s_main.menu,	&s_main.singleplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 385
;385:	Menu_AddItem( &s_main.menu,	&s_main.multiplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+364
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 386
;386:	Menu_AddItem( &s_main.menu,	&s_main.setup );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+440
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 387
;387:	Menu_AddItem( &s_main.menu,	&s_main.demos );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+516
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 388
;388:	Menu_AddItem( &s_main.menu,	&s_main.cinematics );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+592
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 389
;389:	if (teamArena) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $315
line 390
;390:		Menu_AddItem( &s_main.menu,	&s_main.teamArena );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+668
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 391
;391:	}
LABELV $315
line 392
;392:	Menu_AddItem( &s_main.menu,	&s_main.mods );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+744
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 393
;393:	Menu_AddItem( &s_main.menu,	&s_main.exit );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+820
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 395
;394:
;395:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 396
;396:	uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 397
;397:	UI_PushMenu ( &s_main.menu );
ADDRGP4 s_main
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 399
;398:
;399:}
LABELV $140
endproc UI_MainMenu 36 12
bss
align 4
LABELV s_errorMessage
skip 4384
align 4
LABELV s_main
skip 900
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_HudMenu
import UI_Hud_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_LoadCachedServers
import trap_LAN_SaveCachedServers
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import UI_VideoCheck
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
import BigEndian
import replace1
import Q_stradd
import Q_strcpy
import BG_StripColor
import BG_CleanName
import DecodedString
import EncodedString
import strtok
import Q_stristr
import BG_sprintf
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_ValidateKeyValue
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import locase
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_ReadToken
import trap_PC_SourceFileAndLine
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import Com_Split
import COM_ParseSep
import Com_InitSeparators
import SkipTillSeparators
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import Q_sscanf
import ED_vsprintf
import atoi
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $305
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 0
align 1
LABELV $287
byte 1 77
byte 1 79
byte 1 68
byte 1 83
byte 1 0
align 1
LABELV $269
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 0
align 1
LABELV $249
byte 1 67
byte 1 73
byte 1 78
byte 1 69
byte 1 77
byte 1 65
byte 1 84
byte 1 73
byte 1 67
byte 1 83
byte 1 0
align 1
LABELV $231
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 83
byte 1 0
align 1
LABELV $213
byte 1 83
byte 1 69
byte 1 84
byte 1 85
byte 1 80
byte 1 0
align 1
LABELV $195
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $177
byte 1 83
byte 1 73
byte 1 78
byte 1 71
byte 1 76
byte 1 69
byte 1 32
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $142
byte 1 49
byte 1 0
align 1
LABELV $141
byte 1 115
byte 1 118
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $133
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $131
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 40
byte 1 99
byte 1 41
byte 1 32
byte 1 49
byte 1 57
byte 1 57
byte 1 57
byte 1 45
byte 1 50
byte 1 48
byte 1 48
byte 1 48
byte 1 44
byte 1 32
byte 1 73
byte 1 100
byte 1 32
byte 1 83
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 44
byte 1 32
byte 1 73
byte 1 110
byte 1 99
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 82
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $130
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 70
byte 1 79
byte 1 82
byte 1 32
byte 1 77
byte 1 65
byte 1 84
byte 1 85
byte 1 82
byte 1 69
byte 1 32
byte 1 65
byte 1 85
byte 1 68
byte 1 73
byte 1 69
byte 1 78
byte 1 67
byte 1 69
byte 1 83
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $98
byte 1 0
align 1
LABELV $97
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 47
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 53
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $90
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 63
byte 1 0
align 1
LABELV $88
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $87
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $86
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
