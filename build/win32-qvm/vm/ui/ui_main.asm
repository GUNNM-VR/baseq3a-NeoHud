export vmMain
code
proc vmMain 12 8
file "..\..\..\..\code\q3_ui\ui_main.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:USER INTERFACE MAIN
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:/*
;16:================
;17:vmMain
;18:
;19:This is the only way control passes into the module.
;20:This must be the very first function compiled into the .qvm file
;21:================
;22:*/
;23:DLLEXPORT intptr_t vmMain( int command, int arg0, int arg1 ) {
line 24
;24:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $69
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $69
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $82
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $82
address $71
address $72
address $73
address $74
address $75
address $76
address $77
address $78
address $79
address $80
address $81
code
LABELV $71
line 26
;25:	case UI_GETAPIVERSION:
;26:		return UI_API_VERSION;
CNSTI4 4
RETI4
ADDRGP4 $68
JUMPV
LABELV $72
line 29
;27:
;28:	case UI_INIT:
;29:		UI_Init();
ADDRGP4 UI_Init
CALLV
pop
line 30
;30:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $73
line 33
;31:
;32:	case UI_SHUTDOWN:
;33:		UI_Shutdown();
ADDRGP4 UI_Shutdown
CALLV
pop
line 34
;34:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $74
line 37
;35:
;36:	case UI_KEY_EVENT:
;37:		UI_KeyEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_KeyEvent
CALLV
pop
line 38
;38:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $75
line 41
;39:
;40:	case UI_MOUSE_EVENT:
;41:		UI_MouseEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_MouseEvent
CALLV
pop
line 42
;42:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $76
line 45
;43:
;44:	case UI_REFRESH:
;45:		UI_Refresh( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_Refresh
CALLV
pop
line 46
;46:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $77
line 49
;47:
;48:	case UI_IS_FULLSCREEN:
;49:		return UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $68
JUMPV
LABELV $78
line 52
;50:
;51:	case UI_SET_ACTIVE_MENU:
;52:		UI_SetActiveMenu( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_SetActiveMenu
CALLV
pop
line 53
;53:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $79
line 56
;54:
;55:	case UI_CONSOLE_COMMAND:
;56:		return UI_ConsoleCommand( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $68
JUMPV
LABELV $80
line 59
;57:
;58:	case UI_DRAW_CONNECT_SCREEN:
;59:		UI_DrawConnectScreen( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 60
;60:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $81
line 63
;61:
;62:	case UI_HASUNIQUECDKEY:	// mod authors need to observe this
;63:		return qtrue;		// change this to qfalse for mods!
CNSTI4 1
RETI4
ADDRGP4 $68
JUMPV
LABELV $69
line 66
;64:	}
;65:
;66:	return -1;
CNSTI4 -1
RETI4
LABELV $68
endproc vmMain 12 8
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $84
address $85
byte 4 1
address ui_ffa_timelimit
address $86
address $87
byte 4 1
address ui_tourney_fraglimit
address $88
address $87
byte 4 1
address ui_tourney_timelimit
address $89
address $90
byte 4 1
address ui_team_fraglimit
address $91
address $87
byte 4 1
address ui_team_timelimit
address $92
address $85
byte 4 1
address ui_team_friendly
address $93
address $94
byte 4 1
address ui_ctf_capturelimit
address $95
address $96
byte 4 1
address ui_ctf_timelimit
address $97
address $98
byte 4 1
address ui_ctf_friendly
address $99
address $87
byte 4 1
address ui_arenasFile
address $100
address $101
byte 4 80
address ui_botsFile
address $102
address $101
byte 4 33
address ui_spScores1
address $103
address $101
byte 4 1
address ui_spScores2
address $104
address $101
byte 4 1
address ui_spScores3
address $105
address $101
byte 4 1
address ui_spScores4
address $106
address $101
byte 4 1
address ui_spScores5
address $107
address $101
byte 4 1
address ui_spAwards
address $108
address $101
byte 4 1
address ui_spVideos
address $109
address $101
byte 4 1
address ui_spSkill
address $110
address $111
byte 4 33
address ui_spSelection
address $112
address $101
byte 4 64
address ui_browserMaster
address $113
address $87
byte 4 1
address ui_browserGameType
address $114
address $87
byte 4 1
address ui_browserSortKey
address $115
address $116
byte 4 1
address ui_browserShowFull
address $117
address $94
byte 4 1
address ui_browserShowEmpty
address $118
address $94
byte 4 1
address ui_brassTime
address $119
address $120
byte 4 1
address ui_drawCrosshair
address $121
address $116
byte 4 1
address ui_drawCrosshairNames
address $122
address $94
byte 4 1
address ui_marks
address $123
address $94
byte 4 1
address ui_server1
address $124
address $101
byte 4 1
address ui_server2
address $125
address $101
byte 4 1
address ui_server3
address $126
address $101
byte 4 1
address ui_server4
address $127
address $101
byte 4 1
address ui_server5
address $128
address $101
byte 4 1
address ui_server6
address $129
address $101
byte 4 1
address ui_server7
address $130
address $101
byte 4 1
address ui_server8
address $131
address $101
byte 4 1
address ui_server9
address $132
address $101
byte 4 1
address ui_server10
address $133
address $101
byte 4 1
address ui_server11
address $134
address $101
byte 4 1
address ui_server12
address $135
address $101
byte 4 1
address ui_server13
address $136
address $101
byte 4 1
address ui_server14
address $137
address $101
byte 4 1
address ui_server15
address $138
address $101
byte 4 1
address ui_server16
address $139
address $101
byte 4 1
address ui_cdkeychecked
address $140
address $87
byte 4 64
align 4
LABELV cvarTableSize
byte 4 47
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 209
;67:}
;68:
;69:
;70:/*
;71:================
;72:cvars
;73:================
;74:*/
;75:
;76:typedef struct {
;77:	vmCvar_t	*vmCvar;
;78:	char		*cvarName;
;79:	char		*defaultString;
;80:	int			cvarFlags;
;81:} cvarTable_t;
;82:
;83:vmCvar_t	ui_ffa_fraglimit;
;84:vmCvar_t	ui_ffa_timelimit;
;85:
;86:vmCvar_t	ui_tourney_fraglimit;
;87:vmCvar_t	ui_tourney_timelimit;
;88:
;89:vmCvar_t	ui_team_fraglimit;
;90:vmCvar_t	ui_team_timelimit;
;91:vmCvar_t	ui_team_friendly;
;92:
;93:vmCvar_t	ui_ctf_capturelimit;
;94:vmCvar_t	ui_ctf_timelimit;
;95:vmCvar_t	ui_ctf_friendly;
;96:
;97:vmCvar_t	ui_arenasFile;
;98:vmCvar_t	ui_botsFile;
;99:vmCvar_t	ui_spScores1;
;100:vmCvar_t	ui_spScores2;
;101:vmCvar_t	ui_spScores3;
;102:vmCvar_t	ui_spScores4;
;103:vmCvar_t	ui_spScores5;
;104:vmCvar_t	ui_spAwards;
;105:vmCvar_t	ui_spVideos;
;106:vmCvar_t	ui_spSkill;
;107:
;108:vmCvar_t	ui_spSelection;
;109:
;110:vmCvar_t	ui_browserMaster;
;111:vmCvar_t	ui_browserGameType;
;112:vmCvar_t	ui_browserSortKey;
;113:vmCvar_t	ui_browserShowFull;
;114:vmCvar_t	ui_browserShowEmpty;
;115:
;116:vmCvar_t	ui_brassTime;
;117:vmCvar_t	ui_drawCrosshair;
;118:vmCvar_t	ui_drawCrosshairNames;
;119:vmCvar_t	ui_marks;
;120:
;121:vmCvar_t	ui_server1;
;122:vmCvar_t	ui_server2;
;123:vmCvar_t	ui_server3;
;124:vmCvar_t	ui_server4;
;125:vmCvar_t	ui_server5;
;126:vmCvar_t	ui_server6;
;127:vmCvar_t	ui_server7;
;128:vmCvar_t	ui_server8;
;129:vmCvar_t	ui_server9;
;130:vmCvar_t	ui_server10;
;131:vmCvar_t	ui_server11;
;132:vmCvar_t	ui_server12;
;133:vmCvar_t	ui_server13;
;134:vmCvar_t	ui_server14;
;135:vmCvar_t	ui_server15;
;136:vmCvar_t	ui_server16;
;137:
;138:vmCvar_t	ui_cdkeychecked;
;139:
;140:// bk001129 - made static to avoid aliasing.
;141:static cvarTable_t		cvarTable[] = {
;142:	{ &ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE },
;143:	{ &ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE },
;144:
;145:	{ &ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE },
;146:	{ &ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE },
;147:
;148:	{ &ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE },
;149:	{ &ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE },
;150:	{ &ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE },
;151:
;152:	{ &ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE },
;153:	{ &ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE },
;154:	{ &ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE },
;155:
;156:	{ &ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM },
;157:	{ &ui_botsFile, "g_botsFile", "", CVAR_ARCHIVE|CVAR_LATCH },
;158:	{ &ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE },
;159:	{ &ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE },
;160:	{ &ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE },
;161:	{ &ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE },
;162:	{ &ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE },
;163:	{ &ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE },
;164:	{ &ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE },
;165:	{ &ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE | CVAR_LATCH },
;166:
;167:	{ &ui_spSelection, "ui_spSelection", "", CVAR_ROM },
;168:
;169:	{ &ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE },
;170:	{ &ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE },
;171:	{ &ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE },
;172:	{ &ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE },
;173:	{ &ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE },
;174:
;175:	{ &ui_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;176:	{ &ui_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;177:	{ &ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;178:	{ &ui_marks, "cg_marks", "1", CVAR_ARCHIVE },
;179:
;180:	{ &ui_server1, "server1", "", CVAR_ARCHIVE },
;181:	{ &ui_server2, "server2", "", CVAR_ARCHIVE },
;182:	{ &ui_server3, "server3", "", CVAR_ARCHIVE },
;183:	{ &ui_server4, "server4", "", CVAR_ARCHIVE },
;184:	{ &ui_server5, "server5", "", CVAR_ARCHIVE },
;185:	{ &ui_server6, "server6", "", CVAR_ARCHIVE },
;186:	{ &ui_server7, "server7", "", CVAR_ARCHIVE },
;187:	{ &ui_server8, "server8", "", CVAR_ARCHIVE },
;188:	{ &ui_server9, "server9", "", CVAR_ARCHIVE },
;189:	{ &ui_server10, "server10", "", CVAR_ARCHIVE },
;190:	{ &ui_server11, "server11", "", CVAR_ARCHIVE },
;191:	{ &ui_server12, "server12", "", CVAR_ARCHIVE },
;192:	{ &ui_server13, "server13", "", CVAR_ARCHIVE },
;193:	{ &ui_server14, "server14", "", CVAR_ARCHIVE },
;194:	{ &ui_server15, "server15", "", CVAR_ARCHIVE },
;195:	{ &ui_server16, "server16", "", CVAR_ARCHIVE },
;196:
;197:	{ &ui_cdkeychecked, "ui_cdkeychecked", "0", CVAR_ROM }
;198:};
;199:
;200:// bk001129 - made static to avoid aliasing
;201:static int cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;202:
;203:
;204:/*
;205:=================
;206:UI_RegisterCvars
;207:=================
;208:*/
;209:void UI_RegisterCvars( void ) {
line 213
;210:	int			i;
;211:	cvarTable_t	*cv;
;212:
;213:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $145
JUMPV
LABELV $142
line 214
;214:		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 215
;215:	}
LABELV $143
line 213
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $145
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $142
line 216
;216:}
LABELV $141
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 223
;217:
;218:/*
;219:=================
;220:UI_UpdateCvars
;221:=================
;222:*/
;223:void UI_UpdateCvars( void ) {
line 227
;224:	int			i;
;225:	cvarTable_t	*cv;
;226:
;227:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $150
JUMPV
LABELV $147
line 228
;228:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 229
;229:	}
LABELV $148
line 227
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $150
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $147
line 230
;230:}
LABELV $146
endproc UI_UpdateCvars 8 4
export UI_VideoCheck
proc UI_VideoCheck 12 4
line 239
;231:
;232:
;233:/*
;234:=================
;235:UI_VideoCheck
;236:=================
;237:*/
;238:void UI_VideoCheck( int time ) 
;239:{
line 240
;240:	if ( abs( time - uis.lastVideoCheck ) > 1000 ) {
ADDRFP4 0
INDIRI4
ADDRGP4 uis+11472
INDIRI4
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1000
LEI4 $152
line 243
;241:
;242:		int oldWidth, oldHeight;
;243:		oldWidth = uis.glconfig.vidWidth;
ADDRLP4 4
ADDRGP4 uis+56+11304
INDIRI4
ASGNI4
line 244
;244:		oldHeight = uis.glconfig.vidHeight;
ADDRLP4 8
ADDRGP4 uis+56+11308
INDIRI4
ASGNI4
line 246
;245:
;246:		trap_GetGlconfig( &uis.glconfig );
ADDRGP4 uis+56
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 248
;247:
;248:		if ( uis.glconfig.vidWidth != oldWidth || uis.glconfig.vidHeight != oldHeight ) {
ADDRGP4 uis+56+11304
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $166
ADDRGP4 uis+56+11308
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $160
LABELV $166
line 249
;249:			uis.biasY = 0.0;
ADDRGP4 uis+11440
CNSTF4 0
ASGNF4
line 250
;250:			uis.biasX = 0.0;
ADDRGP4 uis+11436
CNSTF4 0
ASGNF4
line 252
;251:			// for 640x480 virtualized screen
;252:			if ( uis.glconfig.vidWidth * 480 > uis.glconfig.vidHeight * 640 ) {
ADDRGP4 uis+56+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 uis+56+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $169
line 254
;253:				// wide screen, scale by height
;254:				uis.scale = uis.glconfig.vidHeight * (1.0/480.0);
ADDRGP4 uis+11432
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 255
;255:				uis.biasX = 0.5 * ( uis.glconfig.vidWidth - ( uis.glconfig.vidHeight * (640.0/480.0) ) );
ADDRGP4 uis+11436
ADDRGP4 uis+56+11304
INDIRI4
CVIF4 4
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 256
;256:			} else {
ADDRGP4 $170
JUMPV
LABELV $169
line 258
;257:				// no wide screen, scale by width
;258:				uis.scale = uis.glconfig.vidWidth * (1.0/640.0);
ADDRGP4 uis+11432
ADDRGP4 uis+56+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 259
;259:				uis.biasY = 0.5 * ( uis.glconfig.vidHeight - ( uis.glconfig.vidWidth * (480.0/640.0) ) );
ADDRGP4 uis+11440
ADDRGP4 uis+56+11308
INDIRI4
CVIF4 4
ADDRGP4 uis+56+11304
INDIRI4
CVIF4 4
CNSTF4 1061158912
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 260
;260:			}
LABELV $170
line 262
;261:
;262:			uis.screenXmin = 0.0 - (uis.biasX / uis.scale);
ADDRGP4 uis+11448
CNSTF4 0
ADDRGP4 uis+11436
INDIRF4
ADDRGP4 uis+11432
INDIRF4
DIVF4
SUBF4
ASGNF4
line 263
;263:			uis.screenXmax = 640.0 + (uis.biasX / uis.scale);
ADDRGP4 uis+11452
ADDRGP4 uis+11436
INDIRF4
ADDRGP4 uis+11432
INDIRF4
DIVF4
CNSTF4 1142947840
ADDF4
ASGNF4
line 265
;264:
;265:			uis.screenYmin = 0.0 - (uis.biasY / uis.scale);
ADDRGP4 uis+11456
CNSTF4 0
ADDRGP4 uis+11440
INDIRF4
ADDRGP4 uis+11432
INDIRF4
DIVF4
SUBF4
ASGNF4
line 266
;266:			uis.screenYmax = 480.0 + (uis.biasY / uis.scale);
ADDRGP4 uis+11460
ADDRGP4 uis+11440
INDIRF4
ADDRGP4 uis+11432
INDIRF4
DIVF4
CNSTF4 1139802112
ADDF4
ASGNF4
line 268
;267:
;268:			uis.cursorScaleR = 1.0 / uis.scale;
ADDRGP4 uis+11444
CNSTF4 1065353216
ADDRGP4 uis+11432
INDIRF4
DIVF4
ASGNF4
line 269
;269:			if ( uis.cursorScaleR < 0.5 ) {
ADDRGP4 uis+11444
INDIRF4
CNSTF4 1056964608
GEF4 $205
line 270
;270:				uis.cursorScaleR = 0.5;
ADDRGP4 uis+11444
CNSTF4 1056964608
ASGNF4
line 271
;271:			}
LABELV $205
line 272
;272:		}
LABELV $160
line 274
;273:
;274:		uis.lastVideoCheck = time;
ADDRGP4 uis+11472
ADDRFP4 0
INDIRI4
ASGNI4
line 275
;275:	}
LABELV $152
line 276
;276:}
LABELV $151
endproc UI_VideoCheck 12 4
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
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
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
bss
export ui_cdkeychecked
align 4
LABELV ui_cdkeychecked
skip 272
import ui_cdkey
export ui_server16
align 4
LABELV ui_server16
skip 272
export ui_server15
align 4
LABELV ui_server15
skip 272
export ui_server14
align 4
LABELV ui_server14
skip 272
export ui_server13
align 4
LABELV ui_server13
skip 272
export ui_server12
align 4
LABELV ui_server12
skip 272
export ui_server11
align 4
LABELV ui_server11
skip 272
export ui_server10
align 4
LABELV ui_server10
skip 272
export ui_server9
align 4
LABELV ui_server9
skip 272
export ui_server8
align 4
LABELV ui_server8
skip 272
export ui_server7
align 4
LABELV ui_server7
skip 272
export ui_server6
align 4
LABELV ui_server6
skip 272
export ui_server5
align 4
LABELV ui_server5
skip 272
export ui_server4
align 4
LABELV ui_server4
skip 272
export ui_server3
align 4
LABELV ui_server3
skip 272
export ui_server2
align 4
LABELV ui_server2
skip 272
export ui_server1
align 4
LABELV ui_server1
skip 272
export ui_marks
align 4
LABELV ui_marks
skip 272
export ui_drawCrosshairNames
align 4
LABELV ui_drawCrosshairNames
skip 272
export ui_drawCrosshair
align 4
LABELV ui_drawCrosshair
skip 272
export ui_brassTime
align 4
LABELV ui_brassTime
skip 272
export ui_browserShowEmpty
align 4
LABELV ui_browserShowEmpty
skip 272
export ui_browserShowFull
align 4
LABELV ui_browserShowFull
skip 272
export ui_browserSortKey
align 4
LABELV ui_browserSortKey
skip 272
export ui_browserGameType
align 4
LABELV ui_browserGameType
skip 272
export ui_browserMaster
align 4
LABELV ui_browserMaster
skip 272
export ui_spSelection
align 4
LABELV ui_spSelection
skip 272
export ui_spSkill
align 4
LABELV ui_spSkill
skip 272
export ui_spVideos
align 4
LABELV ui_spVideos
skip 272
export ui_spAwards
align 4
LABELV ui_spAwards
skip 272
export ui_spScores5
align 4
LABELV ui_spScores5
skip 272
export ui_spScores4
align 4
LABELV ui_spScores4
skip 272
export ui_spScores3
align 4
LABELV ui_spScores3
skip 272
export ui_spScores2
align 4
LABELV ui_spScores2
skip 272
export ui_spScores1
align 4
LABELV ui_spScores1
skip 272
export ui_botsFile
align 4
LABELV ui_botsFile
skip 272
export ui_arenasFile
align 4
LABELV ui_arenasFile
skip 272
export ui_ctf_friendly
align 4
LABELV ui_ctf_friendly
skip 272
export ui_ctf_timelimit
align 4
LABELV ui_ctf_timelimit
skip 272
export ui_ctf_capturelimit
align 4
LABELV ui_ctf_capturelimit
skip 272
export ui_team_friendly
align 4
LABELV ui_team_friendly
skip 272
export ui_team_timelimit
align 4
LABELV ui_team_timelimit
skip 272
export ui_team_fraglimit
align 4
LABELV ui_team_fraglimit
skip 272
export ui_tourney_timelimit
align 4
LABELV ui_tourney_timelimit
skip 272
export ui_tourney_fraglimit
align 4
LABELV ui_tourney_fraglimit
skip 272
export ui_ffa_timelimit
align 4
LABELV ui_ffa_timelimit
skip 272
export ui_ffa_fraglimit
align 4
LABELV ui_ffa_fraglimit
skip 272
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
LABELV $140
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $139
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 54
byte 1 0
align 1
LABELV $138
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $137
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 52
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $134
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $133
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $132
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 57
byte 1 0
align 1
LABELV $131
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 56
byte 1 0
align 1
LABELV $130
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $128
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $127
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $126
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $125
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $124
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $123
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $120
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $119
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $118
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $117
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $116
byte 1 52
byte 1 0
align 1
LABELV $115
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $114
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $113
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $112
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $111
byte 1 50
byte 1 0
align 1
LABELV $110
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $109
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $108
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 53
byte 1 0
align 1
LABELV $106
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $105
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $104
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $103
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $102
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $101
byte 1 0
align 1
LABELV $100
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $99
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $98
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $97
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $96
byte 1 56
byte 1 0
align 1
LABELV $95
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $94
byte 1 49
byte 1 0
align 1
LABELV $93
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $92
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $91
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $90
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $89
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $88
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $87
byte 1 48
byte 1 0
align 1
LABELV $86
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $85
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $84
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
