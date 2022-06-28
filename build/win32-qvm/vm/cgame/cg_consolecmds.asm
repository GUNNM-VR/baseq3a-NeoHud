code
proc CG_TargetCommand_f 20 12
file "..\..\..\..\code\cgame\cg_consolecmds.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#ifdef MISSIONPACK
;8:#include "../ui/ui_shared.h"
;9:extern menuDef_t *menuScoreboard;
;10:#endif
;11:
;12:
;13:/*
;14:=================
;15:CG_TargetCommand_f
;16:=================
;17:*/
;18:static void CG_TargetCommand_f( void ) {
line 22
;19:	int		targetNum;
;20:	char	cmd[4];
;21:
;22:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 23
;23:	if ( targetNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $78
line 24
;24:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 27
;25:	}
;26:
;27:	trap_Argv( 1, cmd, sizeof( cmd ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 28
;28:	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( cmd ) ) );
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $80
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 29
;29:}
LABELV $77
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 40
;30:
;31:
;32:
;33:/*
;34:=================
;35:CG_SizeUp_f
;36:
;37:Keybinding command
;38:=================
;39:*/
;40:static void CG_SizeUp_f (void) {
line 41
;41:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
ADDRGP4 $83
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $82
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 42
;42:}
LABELV $81
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 52
;43:
;44:
;45:/*
;46:=================
;47:CG_SizeDown_f
;48:
;49:Keybinding command
;50:=================
;51:*/
;52:static void CG_SizeDown_f (void) {
line 53
;53:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
ADDRGP4 $83
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $82
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 54
;54:}
LABELV $85
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 64
;55:
;56:
;57:/*
;58:=============
;59:CG_Viewpos_f
;60:
;61:Debugging command to print the current position
;62:=============
;63:*/
;64:static void CG_Viewpos_f (void) {
line 65
;65:	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
ADDRGP4 $88
ARGP4
ADDRGP4 cg+109056+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109424+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 68
;66:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
;67:		(int)cg.refdefViewAngles[YAW]);
;68:}
LABELV $87
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 71
;69:
;70:
;71:static void CG_ScoresDown_f( void ) {
line 76
;72:
;73:#ifdef MISSIONPACK
;74:	CG_BuildSpectatorString();
;75:#endif
;76:	if ( cg.scoresRequestTime + 2000 < cg.time && !cg.demoPlayback ) {
ADDRGP4 cg+110472
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $100
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $100
line 79
;77:		// the scores are more than two seconds out of data,
;78:		// so request new ones
;79:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110472
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 80
;80:		trap_SendClientCommand( "score" );
ADDRGP4 $107
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 84
;81:
;82:		// leave the current scores up if they were already
;83:		// displayed, but if this is the first hit, clear them out
;84:		if ( !cg.showScores ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $101
line 85
;85:			cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 86
;86:			cg.numScores = 0;
ADDRGP4 cg+110476
CNSTI4 0
ASGNI4
line 87
;87:		}
line 88
;88:	} else {
ADDRGP4 $101
JUMPV
LABELV $100
line 91
;89:		// show the cached contents even if they just pressed if it
;90:		// is within two seconds
;91:		cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 92
;92:	}
LABELV $101
line 94
;93:
;94:	CG_SetScoreCatcher( cg.showScores );
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 95
;95:}
LABELV $99
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 4
line 98
;96:
;97:
;98:static void CG_ScoresUp_f( void ) {
line 100
;99:
;100:	if ( cgs.filterKeyUpEvent ) {
ADDRGP4 cgs+149824
INDIRI4
CNSTI4 0
EQI4 $116
line 101
;101:		cgs.filterKeyUpEvent = qfalse;
ADDRGP4 cgs+149824
CNSTI4 0
ASGNI4
line 102
;102:		return;
ADDRGP4 $115
JUMPV
LABELV $116
line 105
;103:	}
;104:
;105:	if ( cg.showScores ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
EQI4 $120
line 106
;106:		cg.showScores = qfalse;
ADDRGP4 cg+115356
CNSTI4 0
ASGNI4
line 107
;107:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 108
;108:	}
LABELV $120
line 110
;109:
;110:	CG_SetScoreCatcher( cg.showScores );
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 111
;111:}
LABELV $115
endproc CG_ScoresUp_f 0 4
proc CG_TellTarget_f 264 20
line 184
;112:
;113:
;114:#ifdef MISSIONPACK
;115:extern menuDef_t *menuScoreboard;
;116:void Menu_Reset( void );			// FIXME: add to right include file
;117:
;118:static void CG_LoadHud_f( void) {
;119:  char buff[1024];
;120:	const char *hudSet;
;121:  memset(buff, 0, sizeof(buff));
;122:
;123:	String_Init();
;124:	Menu_Reset();
;125:	
;126:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;127:	hudSet = buff;
;128:	if (hudSet[0] == '\0') {
;129:		hudSet = "ui/hud.txt";
;130:	}
;131:
;132:	CG_LoadMenus(hudSet);
;133:  menuScoreboard = NULL;
;134:}
;135:
;136:
;137:static void CG_scrollScoresDown_f( void) {
;138:	if (menuScoreboard && cg.scoreBoardShowing) {
;139:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
;140:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
;141:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
;142:	}
;143:}
;144:
;145:
;146:static void CG_scrollScoresUp_f( void) {
;147:	if (menuScoreboard && cg.scoreBoardShowing) {
;148:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
;149:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
;150:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
;151:	}
;152:}
;153:
;154:
;155:static void CG_spWin_f( void) {
;156:	trap_Cvar_Set("cg_cameraOrbit", "2");
;157:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;158:	trap_Cvar_Set("cg_thirdPerson", "1");
;159:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;160:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;161:	CG_AddBufferedSound(cgs.media.winnerSound);
;162:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;163:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
;164:}
;165:
;166:static void CG_spLose_f( void) {
;167:	trap_Cvar_Set("cg_cameraOrbit", "2");
;168:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;169:	trap_Cvar_Set("cg_thirdPerson", "1");
;170:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;171:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;172:	CG_AddBufferedSound(cgs.media.loserSound);
;173:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;174:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
;175:}
;176:
;177:#endif
;178:
;179:/*
;180:==================
;181:CG_TellTarget_f
;182:==================
;183:*/
;184:static void CG_TellTarget_f( void ) {
line 189
;185:	int		clientNum;
;186:	char	command[128];
;187:	char	message[128];
;188:
;189:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 190
;190:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $128
line 191
;191:		return;
ADDRGP4 $127
JUMPV
LABELV $128
line 194
;192:	}
;193:
;194:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 195
;195:	Com_sprintf( command, sizeof( command ), "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $130
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 196
;196:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 197
;197:}
LABELV $127
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 205
;198:
;199:
;200:/*
;201:==================
;202:CG_TellAttacker_f
;203:==================
;204:*/
;205:static void CG_TellAttacker_f( void ) {
line 210
;206:	int		clientNum;
;207:	char	command[128];
;208:	char	message[128];
;209:
;210:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 211
;211:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $132
line 212
;212:		return;
ADDRGP4 $131
JUMPV
LABELV $132
line 215
;213:	}
;214:
;215:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 216
;216:	Com_sprintf( command, sizeof( command ), "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $130
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 217
;217:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 218
;218:}
LABELV $131
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 227
;219:
;220:
;221:#if defined MISSIONPACK || defined NEOHUD
;222:/*
;223:==================
;224:CG_VoiceTellTarget_f
;225:==================
;226:*/
;227:static void CG_VoiceTellTarget_f( void ) {
line 232
;228:	int		clientNum;
;229:	char	command[128];
;230:	char	message[128];
;231:
;232:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 233
;233:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $135
line 234
;234:		return;
ADDRGP4 $134
JUMPV
LABELV $135
line 237
;235:	}
;236:
;237:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 238
;238:	Com_sprintf( command, sizeof( command ), "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $137
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 239
;239:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 240
;240:}
LABELV $134
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 248
;241:
;242:
;243:/*
;244:==================
;245:CG_VoiceTellAttacker_f
;246:==================
;247:*/
;248:static void CG_VoiceTellAttacker_f( void ) {
line 253
;249:	int		clientNum;
;250:	char	command[128];
;251:	char	message[128];
;252:
;253:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 254
;254:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $139
line 255
;255:		return;
ADDRGP4 $138
JUMPV
LABELV $139
line 258
;256:	}
;257:
;258:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 259
;259:	Com_sprintf( command, sizeof( command ), "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $137
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 260
;260:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 261
;261:}
LABELV $138
endproc CG_VoiceTellAttacker_f 264 20
proc CG_NextTeamMember_f 0 0
line 263
;262:
;263:static void CG_NextTeamMember_f( void ) {
line 264
;264:	CG_SelectNextPlayer();
ADDRGP4 CG_SelectNextPlayer
CALLV
pop
line 265
;265:}
LABELV $141
endproc CG_NextTeamMember_f 0 0
proc CG_PrevTeamMember_f 0 0
line 267
;266:
;267:static void CG_PrevTeamMember_f( void ) {
line 268
;268:	CG_SelectPrevPlayer();
ADDRGP4 CG_SelectPrevPlayer
CALLV
pop
line 269
;269:}
LABELV $142
endproc CG_PrevTeamMember_f 0 0
proc CG_NextOrder_f 16 0
line 273
;270:
;271:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;272://
;273:static void CG_NextOrder_f( void ) {
line 274
;274:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 275
;275:	if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $146
line 276
;276:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 0
NEI4 $148
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $148
line 277
;277:			return;
ADDRGP4 $143
JUMPV
LABELV $148
line 279
;278:		}
;279:	}
LABELV $146
line 280
;280:	if (cgs.currentOrder < TEAMTASK_CAMP) {
ADDRGP4 cgs+148692
INDIRI4
CNSTI4 7
GEI4 $152
line 281
;281:		cgs.currentOrder++;
ADDRLP4 4
ADDRGP4 cgs+148692
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 283
;282:
;283:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
ADDRGP4 cgs+148692
INDIRI4
CNSTI4 5
NEI4 $156
line 284
;284:			if (!CG_OtherTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $159
line 285
;285:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+148692
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 286
;286:			}
LABELV $159
line 287
;287:		}
LABELV $156
line 289
;288:
;289:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
ADDRGP4 cgs+148692
INDIRI4
CNSTI4 6
NEI4 $153
line 290
;290:			if (!CG_YourTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $153
line 291
;291:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+148692
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 292
;292:			}
line 293
;293:		}
line 295
;294:
;295:	} else {
ADDRGP4 $153
JUMPV
LABELV $152
line 296
;296:		cgs.currentOrder = TEAMTASK_OFFENSE;
ADDRGP4 cgs+148692
CNSTI4 1
ASGNI4
line 297
;297:	}
LABELV $153
line 298
;298:	cgs.orderPending = qtrue;
ADDRGP4 cgs+148696
CNSTI4 1
ASGNI4
line 299
;299:	cgs.orderTime = cg.time + 3000;
ADDRGP4 cgs+148700
ADDRGP4 cg+107604
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 300
;300:}
LABELV $143
endproc CG_NextOrder_f 16 0
proc CG_ConfirmOrder_f 8 12
line 303
;301:
;302:
;303:static void CG_ConfirmOrder_f (void ) {
line 304
;304:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
ADDRGP4 $173
ARGP4
ADDRGP4 cgs+148716
INDIRI4
ARGI4
ADDRGP4 $175
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 305
;305:	trap_SendConsoleCommand("+button5; wait; -button5");
ADDRGP4 $176
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 306
;306:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148708
INDIRI4
GEI4 $177
line 307
;307:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
ADDRGP4 $181
ARGP4
ADDRGP4 cgs+148712
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 308
;308:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+148708
CNSTI4 0
ASGNI4
line 309
;309:	}
LABELV $177
line 310
;310:}
LABELV $172
endproc CG_ConfirmOrder_f 8 12
proc CG_DenyOrder_f 4 12
line 312
;311:
;312:static void CG_DenyOrder_f (void ) {
line 313
;313:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
ADDRGP4 $173
ARGP4
ADDRGP4 cgs+148716
INDIRI4
ARGI4
ADDRGP4 $186
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 314
;314:	trap_SendConsoleCommand("+button6; wait; -button6");
ADDRGP4 $187
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 315
;315:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148708
INDIRI4
GEI4 $188
line 316
;316:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+148708
CNSTI4 0
ASGNI4
line 317
;317:	}
LABELV $188
line 318
;318:}
LABELV $184
endproc CG_DenyOrder_f 4 12
proc CG_TaskOffense_f 4 8
line 320
;319:
;320:static void CG_TaskOffense_f (void ) {
line 321
;321:	if (cgs.gametype == GT_CTF 
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $194
line 325
;322:#ifdef MISSIONPACK
;323:		|| cgs.gametype == GT_1FCTF
;324:#endif
;325:		) {
line 326
;326:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
ADDRGP4 $197
ARGP4
ADDRGP4 $198
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 327
;327:	} else {
ADDRGP4 $195
JUMPV
LABELV $194
line 328
;328:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
ADDRGP4 $197
ARGP4
ADDRGP4 $199
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 329
;329:	}
LABELV $195
line 330
;330:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
ADDRGP4 $181
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 331
;331:}
LABELV $193
endproc CG_TaskOffense_f 4 8
proc CG_TaskDefense_f 8 8
line 333
;332:
;333:static void CG_TaskDefense_f (void ) {
line 334
;334:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
ADDRGP4 $197
ARGP4
ADDRGP4 $201
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 335
;335:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
ADDRGP4 $181
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 336
;336:}
LABELV $200
endproc CG_TaskDefense_f 8 8
proc CG_TaskPatrol_f 8 8
line 338
;337:
;338:static void CG_TaskPatrol_f (void ) {
line 339
;339:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
ADDRGP4 $197
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 340
;340:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
ADDRGP4 $181
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 341
;341:}
LABELV $202
endproc CG_TaskPatrol_f 8 8
proc CG_TaskCamp_f 8 8
line 343
;342:
;343:static void CG_TaskCamp_f (void ) {
line 344
;344:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
ADDRGP4 $197
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 345
;345:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
ADDRGP4 $181
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 346
;346:}
LABELV $204
endproc CG_TaskCamp_f 8 8
proc CG_TaskFollow_f 8 8
line 348
;347:
;348:static void CG_TaskFollow_f (void ) {
line 349
;349:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
ADDRGP4 $197
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 350
;350:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
ADDRGP4 $181
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 351
;351:}
LABELV $206
endproc CG_TaskFollow_f 8 8
proc CG_TaskRetrieve_f 8 8
line 353
;352:
;353:static void CG_TaskRetrieve_f (void ) {
line 354
;354:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
ADDRGP4 $197
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 355
;355:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
ADDRGP4 $181
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 356
;356:}
LABELV $208
endproc CG_TaskRetrieve_f 8 8
proc CG_TaskEscort_f 8 8
line 358
;357:
;358:static void CG_TaskEscort_f (void ) {
line 359
;359:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
ADDRGP4 $197
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 360
;360:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
ADDRGP4 $181
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 361
;361:}
LABELV $210
endproc CG_TaskEscort_f 8 8
proc CG_TaskOwnFlag_f 4 8
line 363
;362:
;363:static void CG_TaskOwnFlag_f (void ) {
line 364
;364:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
ADDRGP4 $197
ARGP4
ADDRGP4 $213
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 365
;365:}
LABELV $212
endproc CG_TaskOwnFlag_f 4 8
proc CG_TauntKillInsult_f 0 4
line 367
;366:
;367:static void CG_TauntKillInsult_f (void ) {
line 368
;368:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
ADDRGP4 $215
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 369
;369:}
LABELV $214
endproc CG_TauntKillInsult_f 0 4
proc CG_TauntPraise_f 0 4
line 371
;370:
;371:static void CG_TauntPraise_f (void ) {
line 372
;372:	trap_SendConsoleCommand("cmd vsay praise\n");
ADDRGP4 $217
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 373
;373:}
LABELV $216
endproc CG_TauntPraise_f 0 4
proc CG_TauntTaunt_f 0 4
line 375
;374:
;375:static void CG_TauntTaunt_f (void ) {
line 376
;376:	trap_SendConsoleCommand("cmd vtaunt\n");
ADDRGP4 $219
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 377
;377:}
LABELV $218
endproc CG_TauntTaunt_f 0 4
proc CG_TauntDeathInsult_f 0 4
line 379
;378:
;379:static void CG_TauntDeathInsult_f (void ) {
line 380
;380:	trap_SendConsoleCommand("cmd vsay death_insult\n");
ADDRGP4 $221
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 381
;381:}
LABELV $220
endproc CG_TauntDeathInsult_f 0 4
proc CG_TauntGauntlet_f 0 4
line 383
;382:
;383:static void CG_TauntGauntlet_f (void ) {
line 384
;384:	trap_SendConsoleCommand("cmd vsay kill_gauntlet\n");
ADDRGP4 $223
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 385
;385:}
LABELV $222
endproc CG_TauntGauntlet_f 0 4
proc CG_TaskSuicide_f 136 16
line 387
;386:
;387:static void CG_TaskSuicide_f (void ) {
line 391
;388:	int		clientNum;
;389:	char	command[128];
;390:
;391:	clientNum = CG_CrosshairPlayer();
ADDRLP4 132
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
ASGNI4
line 392
;392:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $225
line 393
;393:		return;
ADDRGP4 $224
JUMPV
LABELV $225
line 396
;394:	}
;395:
;396:	Com_sprintf( command, 128, "tell %i suicide", clientNum );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $227
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 397
;397:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 398
;398:}
LABELV $224
endproc CG_TaskSuicide_f 136 16
proc CG_StartOrbit_f 1028 12
line 439
;399:
;400:
;401:
;402:/*
;403:==================
;404:CG_TeamMenu_f
;405:==================
;406:*/
;407:/*
;408:static void CG_TeamMenu_f( void ) {
;409:  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;410:    CG_EventHandling(CGAME_EVENT_NONE);
;411:    trap_Key_SetCatcher(0);
;412:  } else {
;413:    CG_EventHandling(CGAME_EVENT_TEAMMENU);
;414:    //trap_Key_SetCatcher(KEYCATCH_CGAME);
;415:  }
;416:}
;417:*/
;418:
;419:/*
;420:==================
;421:CG_EditHud_f
;422:==================
;423:*/
;424:/*
;425:static void CG_EditHud_f( void ) {
;426:  //cls.keyCatchers ^= KEYCATCH_CGAME;
;427:  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;428:}
;429:*/
;430:
;431:#endif
;432:
;433:/*
;434:==================
;435:CG_StartOrbit_f
;436:==================
;437:*/
;438:
;439:static void CG_StartOrbit_f( void ) {
line 442
;440:	char var[MAX_TOKEN_CHARS];
;441:
;442:	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
ADDRGP4 $229
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 443
;443:	if ( !atoi(var) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $230
line 444
;444:		return;
ADDRGP4 $228
JUMPV
LABELV $230
line 446
;445:	}
;446:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $232
line 447
;447:		trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $235
ARGP4
ADDRGP4 $236
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 448
;448:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $237
ARGP4
ADDRGP4 $236
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 449
;449:	} else {
ADDRGP4 $233
JUMPV
LABELV $232
line 450
;450:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $235
ARGP4
ADDRGP4 $238
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 451
;451:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $237
ARGP4
ADDRGP4 $239
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 452
;452:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $240
ARGP4
ADDRGP4 $236
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 453
;453:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $241
ARGP4
ADDRGP4 $242
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 454
;454:	}
LABELV $233
line 455
;455:}
LABELV $228
endproc CG_StartOrbit_f 1028 12
data
align 4
LABELV commands
address $244
address CG_TestGun_f
address $245
address CG_TestModel_f
address $246
address CG_TestModelNextFrame_f
address $247
address CG_TestModelPrevFrame_f
address $248
address CG_TestModelNextSkin_f
address $249
address CG_TestModelPrevSkin_f
address $250
address CG_Viewpos_f
address $251
address CG_ScoresDown_f
address $252
address CG_ScoresUp_f
address $253
address CG_ZoomDown_f
address $254
address CG_ZoomUp_f
address $255
address CG_SizeUp_f
address $256
address CG_SizeDown_f
address $257
address CG_NextWeapon_f
address $258
address CG_PrevWeapon_f
address $259
address CG_Weapon_f
address $260
address CG_TargetCommand_f
address $261
address CG_TellTarget_f
address $262
address CG_TellAttacker_f
address $263
address CG_VoiceTellTarget_f
address $264
address CG_VoiceTellAttacker_f
address $265
address CG_NextTeamMember_f
address $266
address CG_PrevTeamMember_f
address $267
address CG_NextOrder_f
address $268
address CG_ConfirmOrder_f
address $269
address CG_DenyOrder_f
address $270
address CG_TaskOffense_f
address $271
address CG_TaskDefense_f
address $272
address CG_TaskPatrol_f
address $273
address CG_TaskCamp_f
address $274
address CG_TaskFollow_f
address $275
address CG_TaskRetrieve_f
address $276
address CG_TaskEscort_f
address $277
address CG_TaskSuicide_f
address $278
address CG_TaskOwnFlag_f
address $279
address CG_TauntKillInsult_f
address $280
address CG_TauntPraise_f
address $281
address CG_TauntTaunt_f
address $282
address CG_TauntDeathInsult_f
address $283
address CG_TauntGauntlet_f
address $284
address CG_StartOrbit_f
address $285
address CG_LoadDeferredPlayers
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 541
;456:
;457:/*
;458:static void CG_Camera_f( void ) {
;459:	char name[1024];
;460:	trap_Argv( 1, name, sizeof(name));
;461:	if (trap_loadCamera(name)) {
;462:		cg.cameraMode = qtrue;
;463:		trap_startCamera(cg.time);
;464:	} else {
;465:		CG_Printf ("Unable to load camera %s\n",name);
;466:	}
;467:}
;468:*/
;469:
;470:
;471:typedef struct {
;472:	const char *cmd;
;473:	void	(*function)(void);
;474:} consoleCommand_t;
;475:
;476:static consoleCommand_t	commands[] = {
;477:	{ "testgun", CG_TestGun_f },
;478:	{ "testmodel", CG_TestModel_f },
;479:	{ "nextframe", CG_TestModelNextFrame_f },
;480:	{ "prevframe", CG_TestModelPrevFrame_f },
;481:	{ "nextskin", CG_TestModelNextSkin_f },
;482:	{ "prevskin", CG_TestModelPrevSkin_f },
;483:	{ "viewpos", CG_Viewpos_f },
;484:	{ "+scores", CG_ScoresDown_f },
;485:	{ "-scores", CG_ScoresUp_f },
;486:	{ "+zoom", CG_ZoomDown_f },
;487:	{ "-zoom", CG_ZoomUp_f },
;488:	{ "sizeup", CG_SizeUp_f },
;489:	{ "sizedown", CG_SizeDown_f },
;490:	{ "weapnext", CG_NextWeapon_f },
;491:	{ "weapprev", CG_PrevWeapon_f },
;492:	{ "weapon", CG_Weapon_f },
;493:	{ "tcmd", CG_TargetCommand_f },
;494:	{ "tell_target", CG_TellTarget_f },
;495:	{ "tell_attacker", CG_TellAttacker_f },
;496:#if defined MISSIONPACK || defined NEOHUD
;497:	{ "vtell_target", CG_VoiceTellTarget_f },
;498:	{ "vtell_attacker", CG_VoiceTellAttacker_f },
;499:
;500:	{ "nextTeamMember", CG_NextTeamMember_f },
;501:	{ "prevTeamMember", CG_PrevTeamMember_f },
;502:	{ "nextOrder", CG_NextOrder_f },
;503:	{ "confirmOrder", CG_ConfirmOrder_f },
;504:	{ "denyOrder", CG_DenyOrder_f },
;505:	{ "taskOffense", CG_TaskOffense_f },
;506:	{ "taskDefense", CG_TaskDefense_f },
;507:	{ "taskPatrol", CG_TaskPatrol_f },
;508:	{ "taskCamp", CG_TaskCamp_f },
;509:	{ "taskFollow", CG_TaskFollow_f },
;510:	{ "taskRetrieve", CG_TaskRetrieve_f },
;511:	{ "taskEscort", CG_TaskEscort_f },
;512:	{ "taskSuicide", CG_TaskSuicide_f },
;513:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;514:	{ "tauntKillInsult", CG_TauntKillInsult_f },
;515:	{ "tauntPraise", CG_TauntPraise_f },
;516:	{ "tauntTaunt", CG_TauntTaunt_f },
;517:	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
;518:	{ "tauntGauntlet", CG_TauntGauntlet_f },
;519:#endif
;520:#ifdef MISSIONPACK
;521:	{ "loadhud", CG_LoadHud_f },
;522:	{ "spWin", CG_spWin_f },
;523:	{ "spLose", CG_spLose_f },
;524:	{ "scoresDown", CG_scrollScoresDown_f },
;525:	{ "scoresUp", CG_scrollScoresUp_f },
;526:#endif
;527:	{ "startOrbit", CG_StartOrbit_f },
;528:	//{ "camera", CG_Camera_f },
;529:	{ "loaddeferred", CG_LoadDeferredPlayers }	
;530:};
;531:
;532:
;533:/*
;534:=================
;535:CG_ConsoleCommand
;536:
;537:The string has been tokenized and can be retrieved with
;538:Cmd_Argc() / Cmd_Argv()
;539:=================
;540:*/
;541:qboolean CG_ConsoleCommand( void ) {
line 545
;542:	const char	*cmd;
;543:	int		i;
;544:
;545:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 547
;546:
;547:	for ( i = 0 ; i < ARRAY_LEN( commands ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $290
JUMPV
LABELV $287
line 548
;548:		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $291
line 549
;549:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 550
;550:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $286
JUMPV
LABELV $291
line 552
;551:		}
;552:	}
LABELV $288
line 547
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $290
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 42
LTU4 $287
line 554
;553:
;554:	return qfalse;
CNSTI4 0
RETI4
LABELV $286
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 566
;555:}
;556:
;557:
;558:/*
;559:=================
;560:CG_InitConsoleCommands
;561:
;562:Let the client system know about all of our commands
;563:so it can perform tab completion
;564:=================
;565:*/
;566:void CG_InitConsoleCommands( void ) {
line 569
;567:	int		i;
;568:
;569:	for ( i = 0 ; i < ARRAY_LEN( commands ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $298
JUMPV
LABELV $295
line 570
;570:		trap_AddCommand( commands[i].cmd );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 571
;571:	}
LABELV $296
line 569
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $298
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 42
LTU4 $295
line 577
;572:
;573:	//
;574:	// the game server will interpret these commands, which will be automatically
;575:	// forwarded to the server after they are not recognized locally
;576:	//
;577:	trap_AddCommand ("kill");
ADDRGP4 $299
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 578
;578:	trap_AddCommand ("say");
ADDRGP4 $300
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 579
;579:	trap_AddCommand ("say_team");
ADDRGP4 $301
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 580
;580:	trap_AddCommand ("tell");
ADDRGP4 $302
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 582
;581:#if defined MISSIONPACK || defined NEOHUD
;582:	trap_AddCommand ("vsay");
ADDRGP4 $303
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 583
;583:	trap_AddCommand ("vsay_team");
ADDRGP4 $304
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 584
;584:	trap_AddCommand ("vtell");
ADDRGP4 $305
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 585
;585:	trap_AddCommand ("vtaunt");
ADDRGP4 $306
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 586
;586:	trap_AddCommand ("vosay");
ADDRGP4 $307
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 587
;587:	trap_AddCommand ("vosay_team");
ADDRGP4 $308
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 588
;588:	trap_AddCommand ("votell");
ADDRGP4 $309
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 590
;589:#endif
;590:	trap_AddCommand ("give");
ADDRGP4 $310
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 591
;591:	trap_AddCommand ("god");
ADDRGP4 $311
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 592
;592:	trap_AddCommand ("notarget");
ADDRGP4 $312
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 593
;593:	trap_AddCommand ("noclip");
ADDRGP4 $313
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 594
;594:	trap_AddCommand ("team");
ADDRGP4 $314
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 595
;595:	trap_AddCommand ("follow");
ADDRGP4 $315
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 596
;596:	trap_AddCommand ("levelshot");
ADDRGP4 $316
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 597
;597:	trap_AddCommand ("addbot");
ADDRGP4 $317
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 598
;598:	trap_AddCommand ("setviewpos");
ADDRGP4 $318
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 599
;599:	trap_AddCommand ("callvote");
ADDRGP4 $319
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 600
;600:	trap_AddCommand ("vote");
ADDRGP4 $320
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 601
;601:	trap_AddCommand ("callteamvote");
ADDRGP4 $321
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 602
;602:	trap_AddCommand ("teamvote");
ADDRGP4 $322
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 603
;603:	trap_AddCommand ("stats");
ADDRGP4 $323
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 604
;604:	trap_AddCommand ("teamtask");
ADDRGP4 $324
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 605
;605:	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $325
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 606
;606:}
LABELV $294
endproc CG_InitConsoleCommands 4 4
import trap_R_AddLinearLightToScene
import trap_R_AddRefEntityToScene2
import linearLight
import intShaderTime
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_inPVS
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddAdditiveLightToScene
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedCapsuleTrace
import trap_CM_TransformedBoxTrace
import trap_CM_CapsuleTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_RemoveCommand
import trap_AddCommand
import trap_RealTime
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_LoadVoiceChats
import CG_ShaderStateChanged
import CG_SetConfigValues
import CG_ParseSysteminfo
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_ScoreboardClick
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect_V
import CG_DrawWeaponSelect_H
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PlayDroppedEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_TrackClientTeamChange
import CG_ForceModelChange
import CG_ShowResponseHead
import CG_CheckOrderPending
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Draw3DModel
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_SelectFont
import CG_LoadFonts
import CG_DrawString
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColorTime
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawStringExt
import CG_DrawGradientPic
import CG_DrawPic
import CG_FillScreen
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_SetScoreCatcher
import CG_BuildSpectatorString
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import eventnames
import cg_followKiller
import cg_fovAdjust
import cg_deadBodyDarken
import cg_teamColors
import cg_teamModel
import cg_enemyColors
import cg_enemyModel
import cg_hitSounds
import cg_currentSelectedPlayer
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_drawSpeed
import cg_drawAttacker
import cg_drawPing
import cg_lagometer
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailRadius
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_drawWeaponSelect
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import CG_DrawAttacker_icon
import CG_DrawSelectedPlayerStatus
import HUD_color
import HUD_ItemCaptionValue
import CG_DrawTeamPlayerPowerup
import CG_Draw_Icon_Ammo
import CG_Draw_Icon_Armor
import CG_DrawStatusBarHead
import playerTeam
import getPlayerHealth
import getPlayerLocation
import getTeamPlayerName
import HUD_Update_finalRect
import HUD_DrawGradientBackground
import HUD_DrawBackground
import copyColor
import HUD_Draw_Text
import HUD_GradientValue
import FPS
import TeamOverlay_Sel_idx
import ServerMsg_idx
import ItemMsg_idx
import Attacker_idx
import KillMsg_idx
import WarmFightMsg_idx
import IcoPowerUp_idx
import WeapListSelName_idx
import IcoWeapListSel_idx
import IcoWeapList_idx
import HUD_Update_Valign
import HUD_Update_Margin
import HUD_Update_Anchors
import CG_HUDItemVisible
import CG_HUDShader
import item_Keywords
import dyn_itemCount
import dyn_itemArray
import itemCount
import itemArray
import CG_CheckHUD
import String_Init
import String_Alloc
import teams_colors
import ammo_colors
import armor_colors
import health_colors
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
LABELV $325
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $324
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $323
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $322
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $321
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $320
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $319
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $318
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $317
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $316
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $315
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $314
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $313
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $312
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $311
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $310
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $309
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $308
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $307
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $306
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $305
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $304
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $303
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $302
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $301
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $300
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $299
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $285
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $284
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $283
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $282
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $281
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $280
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 80
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $279
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $278
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 119
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $277
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 83
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $276
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 69
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $275
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $274
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $273
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 67
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $272
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 80
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $271
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $270
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $269
byte 1 100
byte 1 101
byte 1 110
byte 1 121
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $268
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $267
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $266
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $265
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $264
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $263
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $262
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $261
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $260
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $259
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $258
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $257
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $256
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $255
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $254
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $253
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $252
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $251
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $250
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $249
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $248
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $247
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $244
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $242
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $241
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $239
byte 1 49
byte 1 0
align 1
LABELV $238
byte 1 53
byte 1 0
align 1
LABELV $237
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $236
byte 1 48
byte 1 0
align 1
LABELV $235
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $229
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $227
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $223
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $221
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $219
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $217
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $213
byte 1 105
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $211
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $209
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $207
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $205
byte 1 111
byte 1 110
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $203
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $201
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $199
byte 1 111
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $198
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $197
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 0
align 1
LABELV $186
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $181
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 0
align 1
LABELV $175
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $137
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $130
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $88
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $83
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $82
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $80
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
