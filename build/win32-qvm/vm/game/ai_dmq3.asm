code
proc BotSetUserInfo 1024 12
file "..\..\..\..\code\game\ai_dmq3.c"
line 98
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmq3.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "botlib.h"
;16:#include "be_aas.h"
;17:#include "be_ea.h"
;18:#include "be_ai_char.h"
;19:#include "be_ai_chat.h"
;20:#include "be_ai_gen.h"
;21:#include "be_ai_goal.h"
;22:#include "be_ai_move.h"
;23:#include "be_ai_weap.h"
;24://
;25:#include "ai_main.h"
;26:#include "ai_dmq3.h"
;27:#include "ai_chat.h"
;28:#include "ai_cmd.h"
;29:#include "ai_dmnet.h"
;30:#include "ai_team.h"
;31://
;32:#include "chars.h"				//characteristics
;33:#include "inv.h"				//indexes into the inventory
;34:#include "syn.h"				//synonyms
;35:#include "match.h"				//string matching types and vars
;36:
;37:// for the voice chats
;38:#ifdef MISSIONPACK
;39:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;40:#endif
;41:
;42:// from aasfile.h
;43:#define AREACONTENTS_MOVER				1024
;44:#define AREACONTENTS_MODELNUMSHIFT		24
;45:#define AREACONTENTS_MAXMODELNUM		0xFF
;46:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;47:
;48:#define IDEAL_ATTACKDIST			140
;49:
;50:#define MAX_WAYPOINTS		128
;51://
;52:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;53:bot_waypoint_t *botai_freewaypoints;
;54:
;55://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;56:int gametype;		//game type
;57://int maxclients;	//maximum number of clients
;58:
;59:vmCvar_t bot_grapple;
;60:vmCvar_t bot_rocketjump;
;61:vmCvar_t bot_fastchat;
;62:vmCvar_t bot_nochat;
;63:vmCvar_t bot_testrchat;
;64:vmCvar_t bot_challenge;
;65:vmCvar_t bot_predictobstacles;
;66:vmCvar_t g_spSkill;
;67:
;68:extern vmCvar_t bot_developer;
;69:
;70:vec3_t lastteleport_origin;		//last teleport event origin
;71:float lastteleport_time;		//last teleport event time
;72:int max_bspmodelindex;			//maximum BSP model index
;73:
;74://CTF flag goals
;75:bot_goal_t ctf_redflag;
;76:bot_goal_t ctf_blueflag;
;77:#ifdef MISSIONPACK
;78:bot_goal_t ctf_neutralflag;
;79:bot_goal_t redobelisk;
;80:bot_goal_t blueobelisk;
;81:bot_goal_t neutralobelisk;
;82:#endif
;83:
;84:#define MAX_ALTROUTEGOALS		32
;85:
;86:int altroutegoals_setup;
;87:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;88:int red_numaltroutegoals;
;89:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;90:int blue_numaltroutegoals;
;91:
;92:
;93:/*
;94:==================
;95:BotSetUserInfo
;96:==================
;97:*/
;98:static void BotSetUserInfo( bot_state_t *bs, const char *key, const char *value ) {
line 101
;99:	char userinfo[MAX_INFO_STRING];
;100:
;101:	trap_GetUserinfo( bs->client, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 102
;102:	Info_SetValueForKey( userinfo, key, value );
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 103
;103:	trap_SetUserinfo( bs->client, userinfo );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 104
;104:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 105
;105:}
LABELV $55
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 113
;106:
;107:
;108:/*
;109:==================
;110:BotCTFCarryingFlag
;111:==================
;112:*/
;113:int BotCTFCarryingFlag(bot_state_t *bs) {
line 114
;114:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $57
CNSTI4 0
RETI4
ADDRGP4 $56
JUMPV
LABELV $57
line 116
;115:
;116:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5132
ADDP4
INDIRI4
CNSTI4 0
LEI4 $59
CNSTI4 1
RETI4
ADDRGP4 $56
JUMPV
LABELV $59
line 117
;117:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5136
ADDP4
INDIRI4
CNSTI4 0
LEI4 $61
CNSTI4 2
RETI4
ADDRGP4 $56
JUMPV
LABELV $61
line 118
;118:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $56
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 126
;119:}
;120:
;121:/*
;122:==================
;123:BotTeam
;124:==================
;125:*/
;126:int BotTeam(bot_state_t *bs) {
line 129
;127:	char info[1024];
;128:
;129:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LTI4 $66
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $64
LABELV $66
line 131
;130:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;131:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $63
JUMPV
LABELV $64
line 133
;132:	}
;133:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 135
;134:	//
;135:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $67
CNSTI4 1
RETI4
ADDRGP4 $63
JUMPV
LABELV $67
line 136
;136:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $70
CNSTI4 2
RETI4
ADDRGP4 $63
JUMPV
LABELV $70
line 137
;137:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $63
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 145
;138:}
;139:
;140:/*
;141:==================
;142:BotOppositeTeam
;143:==================
;144:*/
;145:int BotOppositeTeam(bot_state_t *bs) {
line 146
;146:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $77
ADDRGP4 $73
JUMPV
LABELV $76
line 147
;147:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $72
JUMPV
LABELV $77
line 148
;148:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $72
JUMPV
LABELV $73
line 149
;149:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $72
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 158
;150:	}
;151:}
;152:
;153:/*
;154:==================
;155:BotEnemyFlag
;156:==================
;157:*/
;158:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 159
;159:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $79
line 160
;160:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $78
JUMPV
LABELV $79
line 162
;161:	}
;162:	else {
line 163
;163:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $78
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 172
;164:	}
;165:}
;166:
;167:/*
;168:==================
;169:BotTeamFlag
;170:==================
;171:*/
;172:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 173
;173:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $82
line 174
;174:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $81
JUMPV
LABELV $82
line 176
;175:	}
;176:	else {
line 177
;177:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $81
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 472 8
line 187
;178:	}
;179:}
;180:
;181:
;182:/*
;183:==================
;184:EntityIsDead
;185:==================
;186:*/
;187:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 190
;188:	playerState_t ps;
;189:
;190:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
LTI4 $85
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
GEI4 $85
line 192
;191:		//retrieve the current client state
;192:		BotAI_GetClientState( entinfo->number, &ps );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 193
;193:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $87
CNSTI4 1
RETI4
ADDRGP4 $84
JUMPV
LABELV $87
line 194
;194:	}
LABELV $85
line 195
;195:	return qfalse;
CNSTI4 0
RETI4
LABELV $84
endproc EntityIsDead 472 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 203
;196:}
;197:
;198:/*
;199:==================
;200:EntityCarriesFlag
;201:==================
;202:*/
;203:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 204
;204:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $91
line 205
;205:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $91
line 206
;206:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $93
line 207
;207:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $93
line 212
;208:#ifdef MISSIONPACK
;209:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
;210:		return qtrue;
;211:#endif
;212:	return qfalse;
CNSTI4 0
RETI4
LABELV $90
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 220
;213:}
;214:
;215:/*
;216:==================
;217:EntityIsInvisible
;218:==================
;219:*/
;220:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 222
;221:	// the flag is always visible
;222:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $96
line 223
;223:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $95
JUMPV
LABELV $96
line 225
;224:	}
;225:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $98
line 226
;226:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $95
JUMPV
LABELV $98
line 228
;227:	}
;228:	return qfalse;
CNSTI4 0
RETI4
LABELV $95
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 236
;229:}
;230:
;231:/*
;232:==================
;233:EntityIsShooting
;234:==================
;235:*/
;236:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 237
;237:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $101
line 238
;238:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $100
JUMPV
LABELV $101
line 240
;239:	}
;240:	return qfalse;
CNSTI4 0
RETI4
LABELV $100
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 248
;241:}
;242:
;243:/*
;244:==================
;245:EntityIsChatting
;246:==================
;247:*/
;248:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 249
;249:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $104
line 250
;250:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
LABELV $104
line 252
;251:	}
;252:	return qfalse;
CNSTI4 0
RETI4
LABELV $103
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 260
;253:}
;254:
;255:/*
;256:==================
;257:EntityHasQuad
;258:==================
;259:*/
;260:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 261
;261:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $107
line 262
;262:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $106
JUMPV
LABELV $107
line 264
;263:	}
;264:	return qfalse;
CNSTI4 0
RETI4
LABELV $106
endproc EntityHasQuad 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 328
;265:}
;266:
;267:#ifdef MISSIONPACK
;268:/*
;269:==================
;270:EntityHasKamikze
;271:==================
;272:*/
;273:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
;274:	if (entinfo->flags & EF_KAMIKAZE) {
;275:		return qtrue;
;276:	}
;277:	return qfalse;
;278:}
;279:
;280:/*
;281:==================
;282:EntityCarriesCubes
;283:==================
;284:*/
;285:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
;286:	entityState_t state;
;287:
;288:	if (gametype != GT_HARVESTER)
;289:		return qfalse;
;290:	//FIXME: get this info from the aas_entityinfo_t ?
;291:	BotAI_GetEntityState(entinfo->number, &state);
;292:	if (state.generic1 > 0)
;293:		return qtrue;
;294:	return qfalse;
;295:}
;296:
;297:/*
;298:==================
;299:Bot1FCTFCarryingFlag
;300:==================
;301:*/
;302:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
;303:	if (gametype != GT_1FCTF) return qfalse;
;304:
;305:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
;306:	return qfalse;
;307:}
;308:
;309:/*
;310:==================
;311:BotHarvesterCarryingCubes
;312:==================
;313:*/
;314:int BotHarvesterCarryingCubes(bot_state_t *bs) {
;315:	if (gametype != GT_HARVESTER) return qfalse;
;316:
;317:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
;318:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
;319:	return qfalse;
;320:}
;321:#endif
;322:
;323:/*
;324:==================
;325:BotRememberLastOrderedTask
;326:==================
;327:*/
;328:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 329
;329:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $110
line 330
;330:		return;
ADDRGP4 $109
JUMPV
LABELV $110
line 332
;331:	}
;332:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ASGNI4
line 333
;333:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
line 334
;334:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 335
;335:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ASGNI4
line 336
;336:}
LABELV $109
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 156 12
line 343
;337:
;338:/*
;339:==================
;340:BotSetTeamStatus
;341:==================
;342:*/
;343:void BotSetTeamStatus(bot_state_t *bs) {
line 348
;344:#if defined MISSIONPACK || defined NEOHUD
;345:	int teamtask;
;346:	aas_entityinfo_t entinfo;
;347:
;348:	teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 350
;349:
;350:	switch(bs->ltgtype) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 1
LTI4 $113
ADDRLP4 144
INDIRI4
CNSTI4 13
GTI4 $113
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $130-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $130
address $114
address $117
address $120
address $121
address $122
address $123
address $124
address $124
address $125
address $126
address $127
address $128
address $129
code
line 352
;351:		case LTG_TEAMHELP:
;352:			break;
LABELV $117
line 354
;353:		case LTG_TEAMACCOMPANY:
;354:			BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 360
;355:#ifdef MISSIONPACK
;356:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
;357:				|| ( gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo) ) {
;358:#endif
;359:#ifdef NEOHUD
;360:			if ( (gametype == GT_CTF) && EntityCarriesFlag(&entinfo) ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $118
ADDRLP4 4
ARGP4
ADDRLP4 152
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $118
line 362
;361:#endif
;362:				teamtask = TEAMTASK_ESCORT;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 363
;363:			}
ADDRGP4 $114
JUMPV
LABELV $118
line 364
;364:			else {
line 365
;365:				teamtask = TEAMTASK_FOLLOW;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 366
;366:			}
line 367
;367:			break;
ADDRGP4 $114
JUMPV
LABELV $120
line 369
;368:		case LTG_DEFENDKEYAREA:
;369:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 370
;370:			break;
ADDRGP4 $114
JUMPV
LABELV $121
line 372
;371:		case LTG_GETFLAG:
;372:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 373
;373:			break;
ADDRGP4 $114
JUMPV
LABELV $122
line 375
;374:		case LTG_RUSHBASE:
;375:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 376
;376:			break;
ADDRGP4 $114
JUMPV
LABELV $123
line 378
;377:		case LTG_RETURNFLAG:
;378:			teamtask = TEAMTASK_RETRIEVE;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 379
;379:			break;
ADDRGP4 $114
JUMPV
LABELV $124
line 382
;380:		case LTG_CAMP:
;381:		case LTG_CAMPORDER:
;382:			teamtask = TEAMTASK_CAMP;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 383
;383:			break;
ADDRGP4 $114
JUMPV
LABELV $125
line 385
;384:		case LTG_PATROL:
;385:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 386
;386:			break;
ADDRGP4 $114
JUMPV
LABELV $126
line 388
;387:		case LTG_GETITEM:
;388:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 389
;389:			break;
ADDRGP4 $114
JUMPV
LABELV $127
line 391
;390:		case LTG_KILL:
;391:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 392
;392:			break;
ADDRGP4 $114
JUMPV
LABELV $128
line 394
;393:		case LTG_HARVEST:
;394:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 395
;395:			break;
ADDRGP4 $114
JUMPV
LABELV $129
line 397
;396:		case LTG_ATTACKENEMYBASE:
;397:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 398
;398:			break;
ADDRGP4 $114
JUMPV
LABELV $113
line 400
;399:		default:
;400:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 401
;401:			break;
LABELV $114
line 403
;402:	}
;403:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
ADDRGP4 $133
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 405
;404:#endif
;405:}
LABELV $112
endproc BotSetTeamStatus 156 12
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 60 16
line 412
;406:
;407:/*
;408:==================
;409:BotSetLastOrderedTask
;410:==================
;411:*/
;412:int BotSetLastOrderedTask(bot_state_t *bs) {
line 414
;413:
;414:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $135
line 416
;415:		// don't go back to returning the flag if it's at the base
;416:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 6
NEI4 $137
line 417
;417:			if ( BotTeam(bs) == TEAM_RED ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $139
line 418
;418:				if ( bs->redflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $140
line 419
;419:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 420
;420:				}
line 421
;421:			}
ADDRGP4 $140
JUMPV
LABELV $139
line 422
;422:			else {
line 423
;423:				if ( bs->blueflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $143
line 424
;424:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 425
;425:				}
LABELV $143
line 426
;426:			}
LABELV $140
line 427
;427:		}
LABELV $137
line 428
;428:	}
LABELV $135
line 430
;429:
;430:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $145
line 431
;431:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ASGNI4
line 432
;432:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 433
;433:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ASGNI4
line 434
;434:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 435
;435:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ASGNI4
line 436
;436:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 437
;437:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 439
;438:		//
;439:		if ( gametype == GT_CTF ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $147
line 440
;440:			if ( bs->ltgtype == LTG_GETFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $149
line 444
;441:				bot_goal_t *tb, *eb;
;442:				int tt, et;
;443:
;444:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 445
;445:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 446
;446:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 44
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 447
;447:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
ASGNI4
line 449
;448:				// if the travel time towards the enemy base is larger than towards our base
;449:				if (et > tt) {
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $151
line 451
;450:					//get an alternative route goal towards the enemy base
;451:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 452
;452:				}
LABELV $151
line 453
;453:			}
LABELV $149
line 454
;454:		}
LABELV $147
line 455
;455:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $134
JUMPV
LABELV $145
line 457
;456:	}
;457:	return qfalse;
CNSTI4 0
RETI4
LABELV $134
endproc BotSetLastOrderedTask 60 16
export BotRefuseOrder
proc BotRefuseOrder 4 8
line 465
;458:}
;459:
;460:/*
;461:==================
;462:BotRefuseOrder
;463:==================
;464:*/
;465:void BotRefuseOrder(bot_state_t *bs) {
line 466
;466:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $154
line 467
;467:		return;
ADDRGP4 $153
JUMPV
LABELV $154
line 469
;468:	// if the bot was ordered to do something
;469:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
CNSTF4 0
EQF4 $156
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $156
line 470
;470:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 474
;471:#ifdef MISSIONPACK
;472:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
;473:#endif
;474:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 475
;475:	}
LABELV $156
line 476
;476:}
LABELV $153
endproc BotRefuseOrder 4 8
export BotCTFSeekGoals
proc BotCTFSeekGoals 228 12
line 483
;477:
;478:/*
;479:==================
;480:BotCTFSeekGoals
;481:==================
;482:*/
;483:void BotCTFSeekGoals(bot_state_t *bs) {
line 490
;484:	float rnd, l1, l2;
;485:	int flagstatus, c;
;486:	vec3_t dir;
;487:	aas_entityinfo_t entinfo;
;488:
;489:	//when carrying a flag in ctf the bot should rush to the base
;490:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $159
line 492
;491:		//if not already rushing to the base
;492:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $161
line 493
;493:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 494
;494:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 495
;495:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 496
;496:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 497
;497:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 498
;498:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 500
;499:			//
;500:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $166
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $171
ADDRGP4 $163
JUMPV
LABELV $166
line 501
;501:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $164
JUMPV
LABELV $171
line 502
;502:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $164
JUMPV
LABELV $163
line 503
;503:				default: VectorSet(dir, 999, 999, 999); break;
ADDRLP4 160
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+4
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
LABELV $164
line 506
;504:			}
;505:			// if the bot picked up the flag very close to the enemy base
;506:			if ( VectorLength(dir) < 128 ) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $178
line 508
;507:				// get an alternative route goal through the enemy base
;508:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 509
;509:			} else {
ADDRGP4 $179
JUMPV
LABELV $178
line 511
;510:				// don't use any alt route goal, just get the hell out of the base
;511:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
CNSTI4 0
ASGNI4
line 512
;512:			}
LABELV $179
line 513
;513:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $133
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 517
;514:#ifdef MISSIONPACK
;515:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;516:#endif
;517:		}
ADDRGP4 $158
JUMPV
LABELV $161
line 518
;518:		else if (bs->rushbaseaway_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $158
line 519
;519:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $182
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $183
JUMPV
LABELV $182
line 520
;520:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ASGNI4
LABELV $183
line 522
;521:			//if the flag is back
;522:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $158
line 523
;523:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 524
;524:			}
line 525
;525:		}
line 526
;526:		return;
ADDRGP4 $158
JUMPV
LABELV $159
line 529
;527:	}
;528:	// if the bot decided to follow someone
;529:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $186
ADDRLP4 176
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $186
line 531
;530:		// if the team mate being accompanied no longer carries the flag
;531:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 532
;532:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $188
line 533
;533:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 534
;534:		}
LABELV $188
line 535
;535:	}
LABELV $186
line 537
;536:	//
;537:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $190
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $191
JUMPV
LABELV $190
line 538
;538:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $191
line 540
;539:	//if our team has the enemy flag and our flag is at the base
;540:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $192
line 542
;541:		//
;542:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $158
line 544
;543:			//if Not defending the base already
;544:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
NEI4 $200
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $158
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $158
LABELV $200
line 546
;545:					(bs->teamgoal.number == ctf_redflag.number ||
;546:					bs->teamgoal.number == ctf_blueflag.number))) {
line 548
;547:				//if there is a visible team mate flag carrier
;548:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 549
;549:				if (c >= 0 &&
ADDRLP4 200
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
LTI4 $158
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $203
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $158
LABELV $203
line 551
;550:						// and not already following the team mate flag carrier
;551:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 553
;552:					//
;553:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 555
;554:					//follow the flag carrier
;555:					bs->decisionmaker = bs->client;
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 208
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 556
;556:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 558
;557:					//the team mate
;558:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 560
;559:					//last time the team mate was visible
;560:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 562
;561:					//no message
;562:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 564
;563:					//no arrive message
;564:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 570
;565:					//
;566:#ifdef MISSIONPACK
;567:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;568:#endif
;569:					//get the team goal time
;570:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 571
;571:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 572
;572:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 573
;573:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 574
;574:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 575
;575:				}
line 576
;576:			}
line 577
;577:		}
line 578
;578:		return;
ADDRGP4 $158
JUMPV
LABELV $192
line 581
;579:	}
;580:	//if the enemy has our flag
;581:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $204
line 583
;582:		//
;583:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $158
line 585
;584:			//if enemy flag carrier is visible
;585:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 586
;586:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $208
line 588
;587:				//FIXME: fight enemy flag carrier
;588:			}
LABELV $208
line 590
;589:			//if not already doing something important
;590:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $158
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $158
line 596
;591:				bs->ltgtype != LTG_RETURNFLAG &&
;592:				bs->ltgtype != LTG_TEAMHELP &&
;593:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;594:				bs->ltgtype != LTG_CAMPORDER &&
;595:				bs->ltgtype != LTG_PATROL &&
;596:				bs->ltgtype != LTG_GETITEM) {
line 598
;597:
;598:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 599
;599:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 600
;600:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 602
;601:				//
;602:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $212
line 604
;603:					//go for the enemy flag
;604:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 605
;605:				}
ADDRGP4 $213
JUMPV
LABELV $212
line 606
;606:				else {
line 607
;607:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 608
;608:				}
LABELV $213
line 610
;609:				//no team message
;610:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 612
;611:				//set the time the bot will stop getting the flag
;612:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 614
;613:				//get an alternative route goal towards the enemy base
;614:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 616
;615:				//
;616:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 617
;617:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 618
;618:			}
line 619
;619:		}
line 620
;620:		return;
ADDRGP4 $158
JUMPV
LABELV $204
line 623
;621:	}
;622:	//if both flags Not at their bases
;623:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $214
line 625
;624:		//
;625:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $158
line 627
;626:			// if not trying to return the flag and not following the team flag carrier
;627:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $158
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $158
line 629
;628:				//
;629:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 631
;630:				// if there is a visible team mate flag carrier
;631:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $220
line 632
;632:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 634
;633:					//follow the flag carrier
;634:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 635
;635:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 637
;636:					//the team mate
;637:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 639
;638:					//last time the team mate was visible
;639:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 641
;640:					//no message
;641:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 643
;642:					//no arrive message
;643:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 649
;644:					//
;645:#ifdef MISSIONPACK
;646:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;647:#endif
;648:					//get the team goal time
;649:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 650
;650:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 651
;651:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 653
;652:					//
;653:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 654
;654:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 655
;655:				}
ADDRGP4 $158
JUMPV
LABELV $220
line 656
;656:				else {
line 657
;657:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 658
;658:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 659
;659:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 661
;660:					//get the enemy flag
;661:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 663
;662:					//get the flag
;663:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 665
;664:					//set the time the bot will stop getting the flag
;665:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 667
;666:					//get an alternative route goal towards the enemy base
;667:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 669
;668:					//
;669:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 670
;670:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 671
;671:				}
line 672
;672:			}
line 673
;673:		}
line 674
;674:		return;
ADDRGP4 $158
JUMPV
LABELV $214
line 677
;675:	}
;676:	// don't just do something wait for the bot team leader to give orders
;677:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $222
line 678
;678:		return;
ADDRGP4 $158
JUMPV
LABELV $222
line 681
;679:	}
;680:	// if the bot is ordered to do something
;681:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $224
line 682
;682:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 683
;683:	}
LABELV $224
line 685
;684:	// if the bot decided to do something on its own and has a last ordered goal
;685:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $226
ADDRLP4 196
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $226
line 686
;686:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 687
;687:	}
LABELV $226
line 689
;688:	//if already a CTF or team goal
;689:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $239
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $228
LABELV $239
line 699
;690:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;691:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;692:			bs->ltgtype == LTG_GETFLAG ||
;693:			bs->ltgtype == LTG_RUSHBASE ||
;694:			bs->ltgtype == LTG_RETURNFLAG ||
;695:			bs->ltgtype == LTG_CAMPORDER ||
;696:			bs->ltgtype == LTG_PATROL ||
;697:			bs->ltgtype == LTG_GETITEM ||
;698:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;699:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 700
;700:		return;
ADDRGP4 $158
JUMPV
LABELV $228
line 703
;701:	}
;702:	//
;703:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $240
line 704
;704:		return;
ADDRGP4 $158
JUMPV
LABELV $240
line 706
;705:	//
;706:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $242
line 707
;707:		return;;
ADDRGP4 $158
JUMPV
LABELV $242
line 709
;708:	//if the bot is roaming
;709:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $244
line 710
;710:		return;
ADDRGP4 $158
JUMPV
LABELV $244
line 712
;711:	//if the bot has enough aggression to decide what to do
;712:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 208
INDIRF4
CNSTF4 1112014848
GEF4 $246
line 713
;713:		return;
ADDRGP4 $158
JUMPV
LABELV $246
line 715
;714:	//set the time to send a message to the team mates
;715:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 212
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 212
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 717
;716:	//
;717:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $248
line 718
;718:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $250
line 719
;719:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 720
;720:		}
ADDRGP4 $251
JUMPV
LABELV $250
line 721
;721:		else {
line 722
;722:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 723
;723:		}
LABELV $251
line 724
;724:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 725
;725:	}
ADDRGP4 $249
JUMPV
LABELV $248
line 726
;726:	else {
line 727
;727:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 728
;728:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 729
;729:	}
LABELV $249
line 731
;730:	//get the flag or defend the base
;731:	rnd = random();
ADDRLP4 216
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 732
;732:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $252
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $252
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $252
line 733
;733:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 734
;734:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 735
;735:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 737
;736:		//set the time the bot will stop getting the flag
;737:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 739
;738:		//get an alternative route goal towards the enemy base
;739:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 740
;740:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 741
;741:	}
ADDRGP4 $253
JUMPV
LABELV $252
line 742
;742:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $256
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $256
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $256
line 743
;743:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 744
;744:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 746
;745:		//
;746:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 1
NEI4 $260
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $261
JUMPV
LABELV $260
line 747
;747:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $261
line 749
;748:		//set the ltg type
;749:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 751
;750:		//set the time the bot stops defending the base
;751:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 752
;752:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 753
;753:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 754
;754:	}
ADDRGP4 $257
JUMPV
LABELV $256
line 755
;755:	else {
line 756
;756:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 758
;757:		//set the time the bot will stop roaming
;758:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 759
;759:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 760
;760:	}
LABELV $257
LABELV $253
line 761
;761:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 765
;762:#ifdef DEBUG
;763:	BotPrintTeamGoal(bs);
;764:#endif //DEBUG
;765:}
LABELV $158
endproc BotCTFSeekGoals 228 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 772
;766:
;767:/*
;768:==================
;769:BotCTFRetreatGoals
;770:==================
;771:*/
;772:void BotCTFRetreatGoals(bot_state_t *bs) {
line 774
;773:	//when carrying a flag in ctf the bot should rush to the base
;774:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $263
line 776
;775:		//if not already rushing to the base
;776:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $265
line 777
;777:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 778
;778:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 779
;779:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 780
;780:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 781
;781:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 782
;782:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 783
;783:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 784
;784:		}
LABELV $265
line 785
;785:	}
LABELV $263
line 786
;786:}
LABELV $262
endproc BotCTFRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 0 4
line 1328
;787:
;788:#ifdef MISSIONPACK
;789:/*
;790:==================
;791:Bot1FCTFSeekGoals
;792:==================
;793:*/
;794:void Bot1FCTFSeekGoals(bot_state_t *bs) {
;795:	aas_entityinfo_t entinfo;
;796:	float rnd, l1, l2;
;797:	int c;
;798:
;799:	//when carrying a flag in ctf the bot should rush to the base
;800:	if (Bot1FCTFCarryingFlag(bs)) {
;801:		//if not already rushing to the base
;802:		if (bs->ltgtype != LTG_RUSHBASE) {
;803:			BotRefuseOrder(bs);
;804:			bs->ltgtype = LTG_RUSHBASE;
;805:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;806:			bs->rushbaseaway_time = 0;
;807:			bs->decisionmaker = bs->client;
;808:			bs->ordered = qfalse;
;809:			//get an alternative route goal towards the enemy base
;810:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;811:			//
;812:			BotSetTeamStatus(bs);
;813:#ifdef MISSIONPACK
;814:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
;815:#endif
;816:		}
;817:		return;
;818:	}
;819:	// if the bot decided to follow someone
;820:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;821:		// if the team mate being accompanied no longer carries the flag
;822:		BotEntityInfo(bs->teammate, &entinfo);
;823:		if (!EntityCarriesFlag(&entinfo)) {
;824:			bs->ltgtype = 0;
;825:		}
;826:	}
;827:	//our team has the flag
;828:	if (bs->neutralflagstatus == 1) {
;829:		if (bs->owndecision_time < FloatTime()) {
;830:			// if not already following someone
;831:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;832:				//if there is a visible team mate flag carrier
;833:				c = BotTeamFlagCarrierVisible(bs);
;834:				if (c >= 0) {
;835:					BotRefuseOrder(bs);
;836:					//follow the flag carrier
;837:					bs->decisionmaker = bs->client;
;838:					bs->ordered = qfalse;
;839:					//the team mate
;840:					bs->teammate = c;
;841:					//last time the team mate was visible
;842:					bs->teammatevisible_time = FloatTime();
;843:					//no message
;844:					bs->teammessage_time = 0;
;845:					//no arrive message
;846:					bs->arrive_time = 1;
;847:					//
;848:#ifdef MISSIONPACK
;849:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;850:#endif
;851:					//get the team goal time
;852:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;853:					bs->ltgtype = LTG_TEAMACCOMPANY;
;854:					bs->formation_dist = 3.5 * 32;		//3.5 meter
;855:					BotSetTeamStatus(bs);
;856:					bs->owndecision_time = FloatTime() + 5;
;857:					return;
;858:				}
;859:			}
;860:			//if already a CTF or team goal
;861:			if (bs->ltgtype == LTG_TEAMHELP ||
;862:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;863:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;864:					bs->ltgtype == LTG_GETFLAG ||
;865:					bs->ltgtype == LTG_RUSHBASE ||
;866:					bs->ltgtype == LTG_CAMPORDER ||
;867:					bs->ltgtype == LTG_PATROL ||
;868:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;869:					bs->ltgtype == LTG_GETITEM ||
;870:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;871:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;872:				return;
;873:			}
;874:			//if not already attacking the enemy base
;875:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
;876:				BotRefuseOrder(bs);
;877:				bs->decisionmaker = bs->client;
;878:				bs->ordered = qfalse;
;879:				//
;880:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;881:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;882:				//set the ltg type
;883:				bs->ltgtype = LTG_ATTACKENEMYBASE;
;884:				//set the time the bot will stop getting the flag
;885:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;886:				BotSetTeamStatus(bs);
;887:				bs->owndecision_time = FloatTime() + 5;
;888:			}
;889:		}
;890:		return;
;891:	}
;892:	//enemy team has the flag
;893:	else if (bs->neutralflagstatus == 2) {
;894:		if (bs->owndecision_time < FloatTime()) {
;895:			c = BotEnemyFlagCarrierVisible(bs);
;896:			if (c >= 0) {
;897:				//FIXME: attack enemy flag carrier
;898:			}
;899:			//if already a CTF or team goal
;900:			if (bs->ltgtype == LTG_TEAMHELP ||
;901:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;902:					bs->ltgtype == LTG_CAMPORDER ||
;903:					bs->ltgtype == LTG_PATROL ||
;904:					bs->ltgtype == LTG_GETITEM) {
;905:				return;
;906:			}
;907:			// if not already defending the base
;908:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
;909:				BotRefuseOrder(bs);
;910:				bs->decisionmaker = bs->client;
;911:				bs->ordered = qfalse;
;912:				//
;913:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;914:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;915:				//set the ltg type
;916:				bs->ltgtype = LTG_DEFENDKEYAREA;
;917:				//set the time the bot stops defending the base
;918:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;919:				bs->defendaway_time = 0;
;920:				BotSetTeamStatus(bs);
;921:				bs->owndecision_time = FloatTime() + 5;
;922:			}
;923:		}
;924:		return;
;925:	}
;926:	// don't just do something wait for the bot team leader to give orders
;927:	if (BotTeamLeader(bs)) {
;928:		return;
;929:	}
;930:	// if the bot is ordered to do something
;931:	if ( bs->lastgoal_ltgtype ) {
;932:		bs->teamgoal_time += 60;
;933:	}
;934:	// if the bot decided to do something on its own and has a last ordered goal
;935:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
;936:		bs->ltgtype = 0;
;937:	}
;938:	//if already a CTF or team goal
;939:	if (bs->ltgtype == LTG_TEAMHELP ||
;940:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;941:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;942:			bs->ltgtype == LTG_GETFLAG ||
;943:			bs->ltgtype == LTG_RUSHBASE ||
;944:			bs->ltgtype == LTG_RETURNFLAG ||
;945:			bs->ltgtype == LTG_CAMPORDER ||
;946:			bs->ltgtype == LTG_PATROL ||
;947:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;948:			bs->ltgtype == LTG_GETITEM ||
;949:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;950:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;951:		return;
;952:	}
;953:	//
;954:	if (BotSetLastOrderedTask(bs))
;955:		return;
;956:	//
;957:	if (bs->owndecision_time > FloatTime())
;958:		return;;
;959:	//if the bot is roaming
;960:	if (bs->ctfroam_time > FloatTime())
;961:		return;
;962:	//if the bot has enough aggression to decide what to do
;963:	if (BotAggression(bs) < 50)
;964:		return;
;965:	//set the time to send a message to the team mates
;966:	bs->teammessage_time = FloatTime() + 2 * random();
;967:	//
;968:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;969:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;970:			l1 = 0.7f;
;971:		}
;972:		else {
;973:			l1 = 0.2f;
;974:		}
;975:		l2 = 0.9f;
;976:	}
;977:	else {
;978:		l1 = 0.4f;
;979:		l2 = 0.7f;
;980:	}
;981:	//get the flag or defend the base
;982:	rnd = random();
;983:	if (rnd < l1 && ctf_neutralflag.areanum) {
;984:		bs->decisionmaker = bs->client;
;985:		bs->ordered = qfalse;
;986:		bs->ltgtype = LTG_GETFLAG;
;987:		//set the time the bot will stop getting the flag
;988:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
;989:		BotSetTeamStatus(bs);
;990:	}
;991:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
;992:		bs->decisionmaker = bs->client;
;993:		bs->ordered = qfalse;
;994:		//
;995:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
;996:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
;997:		//set the ltg type
;998:		bs->ltgtype = LTG_DEFENDKEYAREA;
;999:		//set the time the bot stops defending the base
;1000:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1001:		bs->defendaway_time = 0;
;1002:		BotSetTeamStatus(bs);
;1003:	}
;1004:	else {
;1005:		bs->ltgtype = 0;
;1006:		//set the time the bot will stop roaming
;1007:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1008:		BotSetTeamStatus(bs);
;1009:	}
;1010:	bs->owndecision_time = FloatTime() + 5;
;1011:#ifdef DEBUG
;1012:	BotPrintTeamGoal(bs);
;1013:#endif //DEBUG
;1014:}
;1015:
;1016:/*
;1017:==================
;1018:Bot1FCTFRetreatGoals
;1019:==================
;1020:*/
;1021:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
;1022:	//when carrying a flag in ctf the bot should rush to the enemy base
;1023:	if (Bot1FCTFCarryingFlag(bs)) {
;1024:		//if not already rushing to the base
;1025:		if (bs->ltgtype != LTG_RUSHBASE) {
;1026:			BotRefuseOrder(bs);
;1027:			bs->ltgtype = LTG_RUSHBASE;
;1028:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1029:			bs->rushbaseaway_time = 0;
;1030:			bs->decisionmaker = bs->client;
;1031:			bs->ordered = qfalse;
;1032:			//get an alternative route goal towards the enemy base
;1033:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1034:			BotSetTeamStatus(bs);
;1035:		}
;1036:	}
;1037:}
;1038:
;1039:/*
;1040:==================
;1041:BotObeliskSeekGoals
;1042:==================
;1043:*/
;1044:void BotObeliskSeekGoals(bot_state_t *bs) {
;1045:	float rnd, l1, l2;
;1046:
;1047:	// don't just do something wait for the bot team leader to give orders
;1048:	if (BotTeamLeader(bs)) {
;1049:		return;
;1050:	}
;1051:	// if the bot is ordered to do something
;1052:	if ( bs->lastgoal_ltgtype ) {
;1053:		bs->teamgoal_time += 60;
;1054:	}
;1055:	//if already a team goal
;1056:	if (bs->ltgtype == LTG_TEAMHELP ||
;1057:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1058:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1059:			bs->ltgtype == LTG_GETFLAG ||
;1060:			bs->ltgtype == LTG_RUSHBASE ||
;1061:			bs->ltgtype == LTG_RETURNFLAG ||
;1062:			bs->ltgtype == LTG_CAMPORDER ||
;1063:			bs->ltgtype == LTG_PATROL ||
;1064:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1065:			bs->ltgtype == LTG_GETITEM ||
;1066:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1067:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1068:		return;
;1069:	}
;1070:	//
;1071:	if (BotSetLastOrderedTask(bs))
;1072:		return;
;1073:	//if the bot is roaming
;1074:	if (bs->ctfroam_time > FloatTime())
;1075:		return;
;1076:	//if the bot has enough aggression to decide what to do
;1077:	if (BotAggression(bs) < 50)
;1078:		return;
;1079:	//set the time to send a message to the team mates
;1080:	bs->teammessage_time = FloatTime() + 2 * random();
;1081:	//
;1082:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1083:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1084:			l1 = 0.7f;
;1085:		}
;1086:		else {
;1087:			l1 = 0.2f;
;1088:		}
;1089:		l2 = 0.9f;
;1090:	}
;1091:	else {
;1092:		l1 = 0.4f;
;1093:		l2 = 0.7f;
;1094:	}
;1095:	//get the flag or defend the base
;1096:	rnd = random();
;1097:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1098:		bs->decisionmaker = bs->client;
;1099:		bs->ordered = qfalse;
;1100:		//
;1101:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1102:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1103:		//set the ltg type
;1104:		bs->ltgtype = LTG_ATTACKENEMYBASE;
;1105:		//set the time the bot will stop attacking the enemy base
;1106:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
;1107:		//get an alternate route goal towards the enemy base
;1108:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1109:		BotSetTeamStatus(bs);
;1110:	}
;1111:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1112:		bs->decisionmaker = bs->client;
;1113:		bs->ordered = qfalse;
;1114:		//
;1115:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1116:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1117:		//set the ltg type
;1118:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1119:		//set the time the bot stops defending the base
;1120:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1121:		bs->defendaway_time = 0;
;1122:		BotSetTeamStatus(bs);
;1123:	}
;1124:	else {
;1125:		bs->ltgtype = 0;
;1126:		//set the time the bot will stop roaming
;1127:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1128:		BotSetTeamStatus(bs);
;1129:	}
;1130:}
;1131:
;1132:/*
;1133:==================
;1134:BotGoHarvest
;1135:==================
;1136:*/
;1137:void BotGoHarvest(bot_state_t *bs) {
;1138:	//
;1139:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1140:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1141:	//set the ltg type
;1142:	bs->ltgtype = LTG_HARVEST;
;1143:	//set the time the bot will stop harvesting
;1144:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
;1145:	bs->harvestaway_time = 0;
;1146:	BotSetTeamStatus(bs);
;1147:}
;1148:
;1149:/*
;1150:==================
;1151:BotObeliskRetreatGoals
;1152:==================
;1153:*/
;1154:void BotObeliskRetreatGoals(bot_state_t *bs) {
;1155:	//nothing special
;1156:}
;1157:
;1158:/*
;1159:==================
;1160:BotHarvesterSeekGoals
;1161:==================
;1162:*/
;1163:void BotHarvesterSeekGoals(bot_state_t *bs) {
;1164:	aas_entityinfo_t entinfo;
;1165:	float rnd, l1, l2;
;1166:	int c;
;1167:
;1168:	//when carrying cubes in harvester the bot should rush to the base
;1169:	if (BotHarvesterCarryingCubes(bs)) {
;1170:		//if not already rushing to the base
;1171:		if (bs->ltgtype != LTG_RUSHBASE) {
;1172:			BotRefuseOrder(bs);
;1173:			bs->ltgtype = LTG_RUSHBASE;
;1174:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1175:			bs->rushbaseaway_time = 0;
;1176:			bs->decisionmaker = bs->client;
;1177:			bs->ordered = qfalse;
;1178:			//get an alternative route goal towards the enemy base
;1179:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
;1180:			//
;1181:			BotSetTeamStatus(bs);
;1182:		}
;1183:		return;
;1184:	}
;1185:	// don't just do something wait for the bot team leader to give orders
;1186:	if (BotTeamLeader(bs)) {
;1187:		return;
;1188:	}
;1189:	// if the bot decided to follow someone
;1190:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
;1191:		// if the team mate being accompanied no longer carries the flag
;1192:		BotEntityInfo(bs->teammate, &entinfo);
;1193:		if (!EntityCarriesCubes(&entinfo)) {
;1194:			bs->ltgtype = 0;
;1195:		}
;1196:	}
;1197:	// if the bot is ordered to do something
;1198:	if ( bs->lastgoal_ltgtype ) {
;1199:		bs->teamgoal_time += 60;
;1200:	}
;1201:	//if not yet doing something
;1202:	if (bs->ltgtype == LTG_TEAMHELP ||
;1203:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1204:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1205:			bs->ltgtype == LTG_GETFLAG ||
;1206:			bs->ltgtype == LTG_CAMPORDER ||
;1207:			bs->ltgtype == LTG_PATROL ||
;1208:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1209:			bs->ltgtype == LTG_HARVEST ||
;1210:			bs->ltgtype == LTG_GETITEM ||
;1211:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1212:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
;1213:		return;
;1214:	}
;1215:	//
;1216:	if (BotSetLastOrderedTask(bs))
;1217:		return;
;1218:	//if the bot is roaming
;1219:	if (bs->ctfroam_time > FloatTime())
;1220:		return;
;1221:	//if the bot has enough aggression to decide what to do
;1222:	if (BotAggression(bs) < 50)
;1223:		return;
;1224:	//set the time to send a message to the team mates
;1225:	bs->teammessage_time = FloatTime() + 2 * random();
;1226:	//
;1227:	c = BotEnemyCubeCarrierVisible(bs);
;1228:	if (c >= 0) {
;1229:		//FIXME: attack enemy cube carrier
;1230:	}
;1231:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
;1232:		//if there is a visible team mate carrying cubes
;1233:		c = BotTeamCubeCarrierVisible(bs);
;1234:		if (c >= 0) {
;1235:			//follow the team mate carrying cubes
;1236:			bs->decisionmaker = bs->client;
;1237:			bs->ordered = qfalse;
;1238:			//the team mate
;1239:			bs->teammate = c;
;1240:			//last time the team mate was visible
;1241:			bs->teammatevisible_time = FloatTime();
;1242:			//no message
;1243:			bs->teammessage_time = 0;
;1244:			//no arrive message
;1245:			bs->arrive_time = 1;
;1246:			//
;1247:#ifdef MISSIONPACK
;1248:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
;1249:#endif
;1250:			//get the team goal time
;1251:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
;1252:			bs->ltgtype = LTG_TEAMACCOMPANY;
;1253:			bs->formation_dist = 3.5 * 32;		//3.5 meter
;1254:			BotSetTeamStatus(bs);
;1255:			return;
;1256:		}
;1257:	}
;1258:	//
;1259:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
;1260:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
;1261:			l1 = 0.7f;
;1262:		}
;1263:		else {
;1264:			l1 = 0.2f;
;1265:		}
;1266:		l2 = 0.9f;
;1267:	}
;1268:	else {
;1269:		l1 = 0.4f;
;1270:		l2 = 0.7f;
;1271:	}
;1272:	//
;1273:	rnd = random();
;1274:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
;1275:		bs->decisionmaker = bs->client;
;1276:		bs->ordered = qfalse;
;1277:		BotGoHarvest(bs);
;1278:	}
;1279:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
;1280:		bs->decisionmaker = bs->client;
;1281:		bs->ordered = qfalse;
;1282:		//
;1283:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
;1284:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
;1285:		//set the ltg type
;1286:		bs->ltgtype = LTG_DEFENDKEYAREA;
;1287:		//set the time the bot stops defending the base
;1288:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
;1289:		bs->defendaway_time = 0;
;1290:		BotSetTeamStatus(bs);
;1291:	}
;1292:	else {
;1293:		bs->ltgtype = 0;
;1294:		//set the time the bot will stop roaming
;1295:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
;1296:		BotSetTeamStatus(bs);
;1297:	}
;1298:}
;1299:
;1300:/*
;1301:==================
;1302:BotHarvesterRetreatGoals
;1303:==================
;1304:*/
;1305:void BotHarvesterRetreatGoals(bot_state_t *bs) {
;1306:	//when carrying cubes in harvester the bot should rush to the base
;1307:	if (BotHarvesterCarryingCubes(bs)) {
;1308:		//if not already rushing to the base
;1309:		if (bs->ltgtype != LTG_RUSHBASE) {
;1310:			BotRefuseOrder(bs);
;1311:			bs->ltgtype = LTG_RUSHBASE;
;1312:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
;1313:			bs->rushbaseaway_time = 0;
;1314:			bs->decisionmaker = bs->client;
;1315:			bs->ordered = qfalse;
;1316:			BotSetTeamStatus(bs);
;1317:		}
;1318:		return;
;1319:	}
;1320:}
;1321:#endif
;1322:
;1323:/*
;1324:==================
;1325:BotTeamGoals
;1326:==================
;1327:*/
;1328:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1330
;1329:
;1330:	if ( retreat ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $268
line 1331
;1331:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $269
line 1332
;1332:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1333
;1333:		}
line 1345
;1334:#ifdef MISSIONPACK
;1335:		else if (gametype == GT_1FCTF) {
;1336:			Bot1FCTFRetreatGoals(bs);
;1337:		}
;1338:		else if (gametype == GT_OBELISK) {
;1339:			BotObeliskRetreatGoals(bs);
;1340:		}
;1341:		else if (gametype == GT_HARVESTER) {
;1342:			BotHarvesterRetreatGoals(bs);
;1343:		}
;1344:#endif
;1345:	}
ADDRGP4 $269
JUMPV
LABELV $268
line 1346
;1346:	else {
line 1347
;1347:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $272
line 1349
;1348:			//decide what to do in CTF mode
;1349:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1350
;1350:		}
LABELV $272
line 1362
;1351:#ifdef MISSIONPACK
;1352:		else if (gametype == GT_1FCTF) {
;1353:			Bot1FCTFSeekGoals(bs);
;1354:		}
;1355:		else if (gametype == GT_OBELISK) {
;1356:			BotObeliskSeekGoals(bs);
;1357:		}
;1358:		else if (gametype == GT_HARVESTER) {
;1359:			BotHarvesterSeekGoals(bs);
;1360:		}
;1361:#endif
;1362:	}
LABELV $269
line 1365
;1363:	// reset the order time which is used to see if
;1364:	// we decided to refuse an order
;1365:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 1366
;1366:}
LABELV $267
endproc BotTeamGoals 0 4
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1373
;1367:
;1368:/*
;1369:==================
;1370:BotPointAreaNum
;1371:==================
;1372:*/
;1373:int BotPointAreaNum(vec3_t origin) {
line 1377
;1374:	int areanum, numareas, areas[10];
;1375:	vec3_t end;
;1376:
;1377:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1378
;1378:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $275
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $274
JUMPV
LABELV $275
line 1379
;1379:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1380
;1380:	end[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1381
;1381:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1382
;1382:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $278
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $274
JUMPV
LABELV $278
line 1383
;1383:	return 0;
CNSTI4 0
RETI4
LABELV $274
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1028 12
line 1392
;1384:}
;1385:
;1386:
;1387:/*
;1388:==================
;1389:ClientName
;1390:==================
;1391:*/
;1392:char *ClientName( int client, char *name, int size ) {
line 1395
;1393:	char buf[ MAX_INFO_STRING ];
;1394:
;1395:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $281
line 1396
;1396:		BotAI_Print( PRT_ERROR, "ClientName: client out of range\n" );
CNSTI4 3
ARGI4
ADDRGP4 $283
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1397
;1397:		Q_strncpyz( name, "[client out of range]", size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $284
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1398
;1398:		return name;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $280
JUMPV
LABELV $281
line 1401
;1399:	}
;1400:
;1401:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1402
;1402:	Q_strncpyz( name, Info_ValueForKey( buf, "n" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1403
;1403:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1405
;1404:
;1405:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $280
endproc ClientName 1028 12
export ClientSkin
proc ClientSkin 1028 12
line 1414
;1406:}
;1407:
;1408:
;1409:/*
;1410:==================
;1411:ClientSkin
;1412:==================
;1413:*/
;1414:char *ClientSkin( int client, char *skin, int size ) {
line 1417
;1415:	char buf[ MAX_INFO_STRING ];
;1416:
;1417:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $287
line 1418
;1418:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $289
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1419
;1419:		return "[client out of range]";
ADDRGP4 $284
RETP4
ADDRGP4 $286
JUMPV
LABELV $287
line 1422
;1420:	}
;1421:
;1422:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1423
;1423:	Q_strncpyz( skin, Info_ValueForKey( buf, "model" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $290
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1425
;1424:
;1425:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $286
endproc ClientSkin 1028 12
export ClientFromName
proc ClientFromName 1036 12
line 1434
;1426:}
;1427:
;1428:
;1429:/*
;1430:==================
;1431:ClientFromName
;1432:==================
;1433:*/
;1434:int ClientFromName( const char *name ) {
line 1438
;1435:	int i;
;1436:	char buf[ MAX_INFO_STRING ];
;1437:
;1438:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $295
JUMPV
LABELV $292
line 1439
;1439:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1440
;1440:		Q_CleanStr( buf );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1441
;1441:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 0
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $297
line 1442
;1442:			return i;
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $291
JUMPV
LABELV $297
line 1443
;1443:	}
LABELV $293
line 1438
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $295
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $292
line 1444
;1444:	return -1;
CNSTI4 -1
RETI4
LABELV $291
endproc ClientFromName 1036 12
export ClientOnSameTeamFromName
proc ClientOnSameTeamFromName 1040 12
line 1453
;1445:}
;1446:
;1447:
;1448:/*
;1449:==================
;1450:ClientOnSameTeamFromName
;1451:==================
;1452:*/
;1453:int ClientOnSameTeamFromName( bot_state_t *bs, const char *name ) {
line 1457
;1454:	char buf[MAX_INFO_STRING];
;1455:	int i;
;1456:
;1457:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $303
JUMPV
LABELV $300
line 1458
;1458:		if ( !BotSameTeam( bs, i ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $305
line 1459
;1459:			continue;
ADDRGP4 $301
JUMPV
LABELV $305
line 1460
;1460:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1461
;1461:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1462
;1462:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 4
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $307
line 1463
;1463:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $299
JUMPV
LABELV $307
line 1464
;1464:	}
LABELV $301
line 1457
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $303
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $300
line 1466
;1465:
;1466:	return -1;
CNSTI4 -1
RETI4
LABELV $299
endproc ClientOnSameTeamFromName 1040 12
export stristr
proc stristr 12 4
line 1475
;1467:}
;1468:
;1469:
;1470:/*
;1471:==================
;1472:stristr
;1473:==================
;1474:*/
;1475:const char *stristr(const char *str, const char *charset) {
ADDRGP4 $311
JUMPV
LABELV $310
line 1478
;1476:	int i;
;1477:
;1478:	while(*str) {
line 1479
;1479:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $316
JUMPV
LABELV $313
line 1480
;1480:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $317
ADDRGP4 $315
JUMPV
LABELV $317
line 1481
;1481:		}
LABELV $314
line 1479
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $316
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $319
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $313
LABELV $319
LABELV $315
line 1482
;1482:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $320
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $309
JUMPV
LABELV $320
line 1483
;1483:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1484
;1484:	}
LABELV $311
line 1478
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $310
line 1485
;1485:	return NULL;
CNSTP4 0
RETP4
LABELV $309
endproc stristr 12 4
export EasyClientName
proc EasyClientName 192 12
line 1494
;1486:}
;1487:
;1488:
;1489:/*
;1490:==================
;1491:EasyClientName
;1492:==================
;1493:*/
;1494:char *EasyClientName(int client, char *buf, int size) {
line 1499
;1495:	int i;
;1496:	char *str1, *str2, *ptr, c;
;1497:	char name[128];
;1498:
;1499:	ClientName( client, name, sizeof( name ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1500
;1500:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $326
JUMPV
LABELV $323
ADDRLP4 148
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $324
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $326
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $323
line 1502
;1501:	//remove all spaces
;1502:	for (ptr = strchr(name, ' '); ptr; ptr = strchr(name, ' ')) {
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 152
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 152
INDIRP4
ASGNP4
ADDRGP4 $330
JUMPV
LABELV $327
line 1503
;1503:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1504
;1504:	}
LABELV $328
line 1502
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
LABELV $330
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $327
line 1506
;1505:	//check for [x] and ]x[ clan names
;1506:	str1 = strchr(name, '[');
ADDRLP4 5
ARGP4
CNSTI4 91
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 160
INDIRP4
ASGNP4
line 1507
;1507:	str2 = strchr(name, ']');
ADDRLP4 5
ARGP4
CNSTI4 93
ARGI4
ADDRLP4 164
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 164
INDIRP4
ASGNP4
line 1508
;1508:	if (str1 && str2) {
ADDRLP4 140
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
line 1509
;1509:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $333
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $334
JUMPV
LABELV $333
line 1510
;1510:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $334
line 1511
;1511:	}
LABELV $331
line 1513
;1512:	//remove Mr prefix
;1513:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 168
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 109
EQI4 $339
ADDRLP4 168
INDIRI4
CNSTI4 77
NEI4 $335
LABELV $339
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $340
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $335
LABELV $340
line 1514
;1514:			(name[1] == 'r' || name[1] == 'R')) {
line 1515
;1515:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 172
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1516
;1516:	}
LABELV $335
line 1518
;1517:	//only allow lower case alphabet characters
;1518:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $344
JUMPV
LABELV $343
line 1519
;1519:	while(*ptr) {
line 1520
;1520:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1521
;1521:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 172
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 97
LTI4 $349
ADDRLP4 172
INDIRI4
CNSTI4 122
LEI4 $350
LABELV $349
ADDRLP4 176
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 48
LTI4 $351
ADDRLP4 176
INDIRI4
CNSTI4 57
LEI4 $350
LABELV $351
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $346
LABELV $350
line 1522
;1522:				(c >= '0' && c <= '9') || c == '_') {
line 1523
;1523:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1524
;1524:		}
ADDRGP4 $347
JUMPV
LABELV $346
line 1525
;1525:		else if (c >= 'A' && c <= 'Z') {
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 65
LTI4 $352
ADDRLP4 180
INDIRI4
CNSTI4 90
GTI4 $352
line 1526
;1526:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1527
;1527:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1528
;1528:		}
ADDRGP4 $353
JUMPV
LABELV $352
line 1529
;1529:		else {
line 1530
;1530:			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1531
;1531:		}
LABELV $353
LABELV $347
line 1532
;1532:	}
LABELV $344
line 1519
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $343
line 1534
;1533:
;1534:	Q_strncpyz( buf, name, size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1536
;1535:
;1536:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $322
endproc EasyClientName 192 12
export BotSynonymContext
proc BotSynonymContext 8 4
line 1544
;1537:}
;1538:
;1539:/*
;1540:==================
;1541:BotSynonymContext
;1542:==================
;1543:*/
;1544:int BotSynonymContext(bot_state_t *bs) {
line 1547
;1545:	int context;
;1546:
;1547:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1549
;1548:	//
;1549:	if (gametype == GT_CTF
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $355
line 1553
;1550:#ifdef MISSIONPACK
;1551:		|| gametype == GT_1FCTF
;1552:#endif
;1553:		) {
line 1554
;1554:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $357
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $358
JUMPV
LABELV $357
line 1555
;1555:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $358
line 1556
;1556:	}
LABELV $355
line 1567
;1557:#ifdef MISSIONPACK
;1558:	else if (gametype == GT_OBELISK) {
;1559:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
;1560:		else context |= CONTEXT_OBELISKBLUETEAM;
;1561:	}
;1562:	else if (gametype == GT_HARVESTER) {
;1563:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
;1564:		else context |= CONTEXT_HARVESTERBLUETEAM;
;1565:	}
;1566:#endif
;1567:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $354
endproc BotSynonymContext 8 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1575
;1568:}
;1569:
;1570:/*
;1571:==================
;1572:BotChooseWeapon
;1573:==================
;1574:*/
;1575:void BotChooseWeapon(bot_state_t *bs) {
line 1578
;1576:	int newweaponnum;
;1577:
;1578:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
EQI4 $362
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
NEI4 $360
LABELV $362
line 1579
;1579:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1580
;1580:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1581
;1581:	}
ADDRGP4 $361
JUMPV
LABELV $360
line 1582
;1582:	else {
line 1583
;1583:		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1584
;1584:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $363
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $363
line 1585
;1585:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1587
;1586:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1587:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1588
;1588:	}
LABELV $361
line 1589
;1589:}
LABELV $359
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 76 12
line 1596
;1590:
;1591:/*
;1592:==================
;1593:BotSetupForMovement
;1594:==================
;1595:*/
;1596:void BotSetupForMovement(bot_state_t *bs) {
line 1599
;1597:	bot_initmove_t initmove;
;1598:
;1599:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1600
;1600:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1601
;1601:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1602
;1602:	VectorClear(initmove.viewoffset);
ADDRLP4 0+24
CNSTF4 0
ASGNF4
ADDRLP4 0+24+4
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
CNSTF4 0
ASGNF4
line 1603
;1603:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1604
;1604:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1605
;1605:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1606
;1606:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ASGNF4
line 1608
;1607:	//set the onground flag
;1608:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $377
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $377
line 1610
;1609:	//set the teleported flag
;1610:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $380
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $380
line 1611
;1611:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1612
;1612:	}
LABELV $380
line 1614
;1613:	//set the waterjump flag
;1614:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $383
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $383
line 1615
;1615:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1616
;1616:	}
LABELV $383
line 1618
;1617:	//set presence type
;1618:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $386
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $387
JUMPV
LABELV $386
line 1619
;1619:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $387
line 1621
;1620:	//
;1621:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $390
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $390
line 1623
;1622:	//
;1623:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRB
ASGNB 12
line 1625
;1624:	//
;1625:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1626
;1626:}
LABELV $365
endproc BotSetupForMovement 76 12
export BotCheckItemPickup
proc BotCheckItemPickup 0 0
line 1633
;1627:
;1628:/*
;1629:==================
;1630:BotCheckItemPickup
;1631:==================
;1632:*/
;1633:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1728
;1634:#ifdef MISSIONPACK
;1635:	int offence, leader;
;1636:
;1637:	if (gametype <= GT_TEAM)
;1638:		return;
;1639:
;1640:	offence = -1;
;1641:	// go into offence if picked up the kamikaze or invulnerability
;1642:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
;1643:		offence = qtrue;
;1644:	}
;1645:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
;1646:		offence = qtrue;
;1647:	}
;1648:	// if not already wearing the kamikaze or invulnerability
;1649:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
;1650:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
;1651:			offence = qtrue;
;1652:		}
;1653:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
;1654:			offence = qtrue;
;1655:		}
;1656:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
;1657:			offence = qfalse;
;1658:		}
;1659:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
;1660:			offence = qfalse;
;1661:		}
;1662:	}
;1663:
;1664:	if (offence >= 0) {
;1665:		leader = ClientFromName(bs->teamleader);
;1666:		if (offence) {
;1667:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
;1668:				// if we have a bot team leader
;1669:				if (BotTeamLeader(bs)) {
;1670:					// tell the leader we want to be on offence
;1671:#ifdef MISSIONPACK
;1672:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1673:#endif
;1674:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1675:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1676:				}
;1677:				else if (g_spSkill.integer <= 3) {
;1678:					if ( bs->ltgtype != LTG_GETFLAG &&
;1679:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;1680:						 bs->ltgtype != LTG_HARVEST ) {
;1681:						//
;1682:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1683:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1684:							// tell the leader we want to be on offence
;1685:#ifdef MISSIONPACK
;1686:							BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
;1687:#endif
;1688:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1689:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1690:						}
;1691:					}
;1692:				}
;1693:				bs->teamtaskpreference |= TEAMTP_ATTACKER;
;1694:			}
;1695:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
;1696:		}
;1697:		else {
;1698:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
;1699:				// if we have a bot team leader
;1700:				if (BotTeamLeader(bs)) {
;1701:					// tell the leader we want to be on defense
;1702:#ifdef MISSIONPACK
;1703:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1704:#endif
;1705:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1706:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1707:				}
;1708:				else if (g_spSkill.integer <= 3) {
;1709:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
;1710:						//
;1711:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
;1712:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
;1713:							// tell the leader we want to be on defense
;1714:#ifdef MISSIONPACK
;1715:							BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
;1716:#endif
;1717:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1718:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1719:						}
;1720:					}
;1721:				}
;1722:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
;1723:			}
;1724:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
;1725:		}
;1726:	}
;1727:#endif
;1728:}
LABELV $394
endproc BotCheckItemPickup 0 0
export BotUpdateInventory
proc BotUpdateInventory 1224 12
line 1735
;1729:
;1730:/*
;1731:==================
;1732:BotUpdateInventory
;1733:==================
;1734:*/
;1735:void BotUpdateInventory(bot_state_t *bs) {
line 1738
;1736:	int oldinventory[MAX_ITEMS];
;1737:
;1738:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1740
;1739:	//armor
;1740:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 1742
;1741:	//weapons
;1742:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $397
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $398
JUMPV
LABELV $397
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $398
ADDRLP4 1032
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1743
;1743:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $400
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $400
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $401
ADDRLP4 1040
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1744
;1744:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $403
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $404
JUMPV
LABELV $403
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $404
ADDRLP4 1048
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1745
;1745:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $406
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $407
JUMPV
LABELV $406
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $407
ADDRLP4 1056
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1746
;1746:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $409
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $410
JUMPV
LABELV $409
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $410
ADDRLP4 1064
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1747
;1747:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $412
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $413
JUMPV
LABELV $412
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $413
ADDRLP4 1072
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1748
;1748:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $415
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $416
JUMPV
LABELV $415
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $416
ADDRLP4 1080
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1749
;1749:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $418
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $419
JUMPV
LABELV $418
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $419
ADDRLP4 1088
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1750
;1750:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $421
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $422
JUMPV
LABELV $421
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $422
ADDRLP4 1096
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1751
;1751:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $424
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $425
JUMPV
LABELV $424
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $425
ADDRLP4 1104
INDIRP4
CNSTI4 5008
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1758
;1752:#ifdef MISSIONPACK
;1753:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;;
;1754:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;;
;1755:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;;
;1756:#endif
;1757:	//ammo
;1758:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1108
INDIRP4
CNSTI4 5024
ADDP4
ADDRLP4 1108
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1759
;1759:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 5028
ADDP4
ADDRLP4 1112
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1760
;1760:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1116
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1761
;1761:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1120
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1762
;1762:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1124
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1763
;1763:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1128
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1764
;1764:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1765
;1765:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1772
;1766:#ifdef MISSIONPACK
;1767:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
;1768:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
;1769:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
;1770:#endif
;1771:	//powerups
;1772:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5068
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1773
;1773:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $427
ADDRLP4 1144
CNSTI4 1
ASGNI4
ADDRGP4 $428
JUMPV
LABELV $427
ADDRLP4 1144
CNSTI4 0
ASGNI4
LABELV $428
ADDRLP4 1148
INDIRP4
CNSTI4 5072
ADDP4
ADDRLP4 1144
INDIRI4
ASGNI4
line 1774
;1774:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $430
ADDRLP4 1152
CNSTI4 1
ASGNI4
ADDRGP4 $431
JUMPV
LABELV $430
ADDRLP4 1152
CNSTI4 0
ASGNI4
LABELV $431
ADDRLP4 1156
INDIRP4
CNSTI4 5076
ADDP4
ADDRLP4 1152
INDIRI4
ASGNI4
line 1780
;1775:#ifdef MISSIONPACK
;1776:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
;1777:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
;1778:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
;1779:#endif
;1780:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $433
ADDRLP4 1160
CNSTI4 1
ASGNI4
ADDRGP4 $434
JUMPV
LABELV $433
ADDRLP4 1160
CNSTI4 0
ASGNI4
LABELV $434
ADDRLP4 1164
INDIRP4
CNSTI4 5092
ADDP4
ADDRLP4 1160
INDIRI4
ASGNI4
line 1781
;1781:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $436
ADDRLP4 1168
CNSTI4 1
ASGNI4
ADDRGP4 $437
JUMPV
LABELV $436
ADDRLP4 1168
CNSTI4 0
ASGNI4
LABELV $437
ADDRLP4 1172
INDIRP4
CNSTI4 5096
ADDP4
ADDRLP4 1168
INDIRI4
ASGNI4
line 1782
;1782:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $439
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $440
JUMPV
LABELV $439
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $440
ADDRLP4 1180
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1176
INDIRI4
ASGNI4
line 1783
;1783:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1188
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $442
ADDRLP4 1184
CNSTI4 1
ASGNI4
ADDRGP4 $443
JUMPV
LABELV $442
ADDRLP4 1184
CNSTI4 0
ASGNI4
LABELV $443
ADDRLP4 1188
INDIRP4
CNSTI4 5104
ADDP4
ADDRLP4 1184
INDIRI4
ASGNI4
line 1784
;1784:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1196
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $445
ADDRLP4 1192
CNSTI4 1
ASGNI4
ADDRGP4 $446
JUMPV
LABELV $445
ADDRLP4 1192
CNSTI4 0
ASGNI4
LABELV $446
ADDRLP4 1196
INDIRP4
CNSTI4 5108
ADDP4
ADDRLP4 1192
INDIRI4
ASGNI4
line 1785
;1785:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1204
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
ADDRLP4 1200
CNSTI4 1
ASGNI4
ADDRGP4 $449
JUMPV
LABELV $448
ADDRLP4 1200
CNSTI4 0
ASGNI4
LABELV $449
ADDRLP4 1204
INDIRP4
CNSTI4 5112
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
line 1792
;1786:#ifdef MISSIONPACK
;1787:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
;1788:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
;1789:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
;1790:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
;1791:#endif
;1792:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $451
ADDRLP4 1208
CNSTI4 1
ASGNI4
ADDRGP4 $452
JUMPV
LABELV $451
ADDRLP4 1208
CNSTI4 0
ASGNI4
LABELV $452
ADDRLP4 1212
INDIRP4
CNSTI4 5132
ADDP4
ADDRLP4 1208
INDIRI4
ASGNI4
line 1793
;1793:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1220
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $454
ADDRLP4 1216
CNSTI4 1
ASGNI4
ADDRGP4 $455
JUMPV
LABELV $454
ADDRLP4 1216
CNSTI4 0
ASGNI4
LABELV $455
ADDRLP4 1220
INDIRP4
CNSTI4 5136
ADDP4
ADDRLP4 1216
INDIRI4
ASGNI4
line 1805
;1794:#ifdef MISSIONPACK
;1795:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
;1796:	if (BotTeam(bs) == TEAM_RED) {
;1797:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
;1798:		bs->inventory[INVENTORY_BLUECUBE] = 0;
;1799:	}
;1800:	else {
;1801:		bs->inventory[INVENTORY_REDCUBE] = 0;
;1802:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
;1803:	}
;1804:#endif
;1805:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1806
;1806:}
LABELV $395
endproc BotUpdateInventory 1224 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1813
;1807:
;1808:/*
;1809:==================
;1810:BotUpdateBattleInventory
;1811:==================
;1812:*/
;1813:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1817
;1814:	vec3_t dir;
;1815:	aas_entityinfo_t entinfo;
;1816:
;1817:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1818
;1818:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1819
;1819:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1820
;1820:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1821
;1821:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5752
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1823
;1822:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1823:}
LABELV $456
endproc BotUpdateBattleInventory 160 8
export BotBattleUseItems
proc BotBattleUseItems 4 4
line 2050
;1824:
;1825:#ifdef MISSIONPACK
;1826:/*
;1827:==================
;1828:BotUseKamikaze
;1829:==================
;1830:*/
;1831:#define KAMIKAZE_DIST		1024
;1832:
;1833:void BotUseKamikaze(bot_state_t *bs) {
;1834:	int c, teammates, enemies;
;1835:	aas_entityinfo_t entinfo;
;1836:	vec3_t dir, target;
;1837:	bot_goal_t *goal;
;1838:	bsp_trace_t trace;
;1839:
;1840:	//if the bot has no kamikaze
;1841:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
;1842:		return;
;1843:	if (bs->kamikaze_time > FloatTime())
;1844:		return;
;1845:	bs->kamikaze_time = FloatTime() + 0.2;
;1846:	if (gametype == GT_CTF) {
;1847:		//never use kamikaze if the team flag carrier is visible
;1848:		if (BotCTFCarryingFlag(bs))
;1849:			return;
;1850:		c = BotTeamFlagCarrierVisible(bs);
;1851:		if (c >= 0) {
;1852:			BotEntityInfo(c, &entinfo);
;1853:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1854:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1855:				return;
;1856:		}
;1857:		c = BotEnemyFlagCarrierVisible(bs);
;1858:		if (c >= 0) {
;1859:			BotEntityInfo(c, &entinfo);
;1860:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1861:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1862:				trap_EA_Use(bs->client);
;1863:				return;
;1864:			}
;1865:		}
;1866:	}
;1867:	else if (gametype == GT_1FCTF) {
;1868:		//never use kamikaze if the team flag carrier is visible
;1869:		if (Bot1FCTFCarryingFlag(bs))
;1870:			return;
;1871:		c = BotTeamFlagCarrierVisible(bs);
;1872:		if (c >= 0) {
;1873:			BotEntityInfo(c, &entinfo);
;1874:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1875:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1876:				return;
;1877:		}
;1878:		c = BotEnemyFlagCarrierVisible(bs);
;1879:		if (c >= 0) {
;1880:			BotEntityInfo(c, &entinfo);
;1881:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1882:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1883:				trap_EA_Use(bs->client);
;1884:				return;
;1885:			}
;1886:		}
;1887:	}
;1888:	else if (gametype == GT_OBELISK) {
;1889:		switch(BotTeam(bs)) {
;1890:			case TEAM_RED: goal = &blueobelisk; break;
;1891:			default: goal = &redobelisk; break;
;1892:		}
;1893:		//if the obelisk is visible
;1894:		VectorCopy(goal->origin, target);
;1895:		target[2] += 1;
;1896:		VectorSubtract(bs->origin, target, dir);
;1897:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
;1898:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1899:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1900:				trap_EA_Use(bs->client);
;1901:				return;
;1902:			}
;1903:		}
;1904:	}
;1905:	else if (gametype == GT_HARVESTER) {
;1906:		//
;1907:		if (BotHarvesterCarryingCubes(bs))
;1908:			return;
;1909:		//never use kamikaze if a team mate carrying cubes is visible
;1910:		c = BotTeamCubeCarrierVisible(bs);
;1911:		if (c >= 0) {
;1912:			BotEntityInfo(c, &entinfo);
;1913:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1914:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
;1915:				return;
;1916:		}
;1917:		c = BotEnemyCubeCarrierVisible(bs);
;1918:		if (c >= 0) {
;1919:			BotEntityInfo(c, &entinfo);
;1920:			VectorSubtract(entinfo.origin, bs->origin, dir);
;1921:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
;1922:				trap_EA_Use(bs->client);
;1923:				return;
;1924:			}
;1925:		}
;1926:	}
;1927:	//
;1928:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
;1929:	//
;1930:	if (enemies > 2 && enemies > teammates+1) {
;1931:		trap_EA_Use(bs->client);
;1932:		return;
;1933:	}
;1934:}
;1935:
;1936:/*
;1937:==================
;1938:BotUseInvulnerability
;1939:==================
;1940:*/
;1941:void BotUseInvulnerability(bot_state_t *bs) {
;1942:	int c;
;1943:	vec3_t dir, target;
;1944:	bot_goal_t *goal;
;1945:	bsp_trace_t trace;
;1946:
;1947:	//if the bot has no invulnerability
;1948:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
;1949:		return;
;1950:	if (bs->invulnerability_time > FloatTime())
;1951:		return;
;1952:	bs->invulnerability_time = FloatTime() + 0.2;
;1953:	if (gametype == GT_CTF) {
;1954:		//never use kamikaze if the team flag carrier is visible
;1955:		if (BotCTFCarryingFlag(bs))
;1956:			return;
;1957:		c = BotEnemyFlagCarrierVisible(bs);
;1958:		if (c >= 0)
;1959:			return;
;1960:		//if near enemy flag and the flag is visible
;1961:		switch(BotTeam(bs)) {
;1962:			case TEAM_RED: goal = &ctf_blueflag; break;
;1963:			default: goal = &ctf_redflag; break;
;1964:		}
;1965:		//if the obelisk is visible
;1966:		VectorCopy(goal->origin, target);
;1967:		target[2] += 1;
;1968:		VectorSubtract(bs->origin, target, dir);
;1969:		if (VectorLengthSquared(dir) < Square(200)) {
;1970:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1971:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1972:				trap_EA_Use(bs->client);
;1973:				return;
;1974:			}
;1975:		}
;1976:	}
;1977:	else if (gametype == GT_1FCTF) {
;1978:		//never use kamikaze if the team flag carrier is visible
;1979:		if (Bot1FCTFCarryingFlag(bs))
;1980:			return;
;1981:		c = BotEnemyFlagCarrierVisible(bs);
;1982:		if (c >= 0)
;1983:			return;
;1984:		//if near enemy flag and the flag is visible
;1985:		switch(BotTeam(bs)) {
;1986:			case TEAM_RED: goal = &ctf_blueflag; break;
;1987:			default: goal = &ctf_redflag; break;
;1988:		}
;1989:		//if the obelisk is visible
;1990:		VectorCopy(goal->origin, target);
;1991:		target[2] += 1;
;1992:		VectorSubtract(bs->origin, target, dir);
;1993:		if (VectorLengthSquared(dir) < Square(200)) {
;1994:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;1995:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;1996:				trap_EA_Use(bs->client);
;1997:				return;
;1998:			}
;1999:		}
;2000:	}
;2001:	else if (gametype == GT_OBELISK) {
;2002:		switch(BotTeam(bs)) {
;2003:			case TEAM_RED: goal = &blueobelisk; break;
;2004:			default: goal = &redobelisk; break;
;2005:		}
;2006:		//if the obelisk is visible
;2007:		VectorCopy(goal->origin, target);
;2008:		target[2] += 1;
;2009:		VectorSubtract(bs->origin, target, dir);
;2010:		if (VectorLengthSquared(dir) < Square(300)) {
;2011:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2012:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2013:				trap_EA_Use(bs->client);
;2014:				return;
;2015:			}
;2016:		}
;2017:	}
;2018:	else if (gametype == GT_HARVESTER) {
;2019:		//
;2020:		if (BotHarvesterCarryingCubes(bs))
;2021:			return;
;2022:		c = BotEnemyCubeCarrierVisible(bs);
;2023:		if (c >= 0)
;2024:			return;
;2025:		//if near enemy base and enemy base is visible
;2026:		switch(BotTeam(bs)) {
;2027:			case TEAM_RED: goal = &blueobelisk; break;
;2028:			default: goal = &redobelisk; break;
;2029:		}
;2030:		//if the obelisk is visible
;2031:		VectorCopy(goal->origin, target);
;2032:		target[2] += 1;
;2033:		VectorSubtract(bs->origin, target, dir);
;2034:		if (VectorLengthSquared(dir) < Square(200)) {
;2035:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2036:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2037:				trap_EA_Use(bs->client);
;2038:				return;
;2039:			}
;2040:		}
;2041:	}
;2042:}
;2043:#endif
;2044:
;2045:/*
;2046:==================
;2047:BotBattleUseItems
;2048:==================
;2049:*/
;2050:void BotBattleUseItems(bot_state_t *bs) {
line 2051
;2051:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $467
line 2052
;2052:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $469
line 2053
;2053:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $471
line 2058
;2054:#ifdef MISSIONPACK
;2055:				&& !Bot1FCTFCarryingFlag(bs)
;2056:				&& !BotHarvesterCarryingCubes(bs)
;2057:#endif
;2058:				) {
line 2059
;2059:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2060
;2060:			}
LABELV $471
line 2061
;2061:		}
LABELV $469
line 2062
;2062:	}
LABELV $467
line 2063
;2063:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $473
line 2064
;2064:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 0
LEI4 $475
line 2065
;2065:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2066
;2066:		}
LABELV $475
line 2067
;2067:	}
LABELV $473
line 2072
;2068:#ifdef MISSIONPACK
;2069:	BotUseKamikaze(bs);
;2070:	BotUseInvulnerability(bs);
;2071:#endif
;2072:}
LABELV $466
endproc BotBattleUseItems 4 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 2079
;2073:
;2074:/*
;2075:==================
;2076:BotSetTeleportTime
;2077:==================
;2078:*/
;2079:void BotSetTeleportTime(bot_state_t *bs) {
line 2080
;2080:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $478
line 2081
;2081:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2082
;2082:	}
LABELV $478
line 2083
;2083:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 2084
;2084:}
LABELV $477
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2091
;2085:
;2086:/*
;2087:==================
;2088:BotIsDead
;2089:==================
;2090:*/
;2091:qboolean BotIsDead(bot_state_t *bs) {
line 2092
;2092:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $482
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $483
JUMPV
LABELV $482
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $483
ADDRLP4 0
INDIRI4
RETI4
LABELV $480
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2100
;2093:}
;2094:
;2095:/*
;2096:==================
;2097:BotIsObserver
;2098:==================
;2099:*/
;2100:qboolean BotIsObserver(bot_state_t *bs) {
line 2102
;2101:	char buf[MAX_INFO_STRING];
;2102:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $485
CNSTI4 1
RETI4
ADDRGP4 $484
JUMPV
LABELV $485
line 2103
;2103:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2104
;2104:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $487
CNSTI4 1
RETI4
ADDRGP4 $484
JUMPV
LABELV $487
line 2105
;2105:	return qfalse;
CNSTI4 0
RETI4
LABELV $484
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2113
;2106:}
;2107:
;2108:/*
;2109:==================
;2110:BotIntermission
;2111:==================
;2112:*/
;2113:qboolean BotIntermission(bot_state_t *bs) {
line 2115
;2114:	//NOTE: we shouldn't be looking at the game code...
;2115:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $490
CNSTI4 1
RETI4
ADDRGP4 $489
JUMPV
LABELV $490
line 2116
;2116:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
EQI4 $496
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
NEI4 $494
LABELV $496
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $494
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $495
ADDRLP4 0
INDIRI4
RETI4
LABELV $489
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2124
;2117:}
;2118:
;2119:/*
;2120:==================
;2121:BotInLavaOrSlime
;2122:==================
;2123:*/
;2124:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2127
;2125:	vec3_t feet;
;2126:
;2127:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2128
;2128:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2129
;2129:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $497
endproc BotInLavaOrSlime 16 4
data
align 4
LABELV $500
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $501
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2137
;2130:}
;2131:
;2132:/*
;2133:==================
;2134:BotCreateWayPoint
;2135:==================
;2136:*/
;2137:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2139
;2138:	bot_waypoint_t *wp;
;2139:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $500
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $501
INDIRB
ASGNB 12
line 2141
;2140:
;2141:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2142
;2142:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $502
line 2143
;2143:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $504
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2144
;2144:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $499
JUMPV
LABELV $502
line 2146
;2145:	}
;2146:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2148
;2147:
;2148:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2149
;2149:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2150
;2150:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2151
;2151:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2152
;2152:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2153
;2153:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2154
;2154:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2155
;2155:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $499
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2163
;2156:}
;2157:
;2158:/*
;2159:==================
;2160:BotFindWayPoint
;2161:==================
;2162:*/
;2163:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2166
;2164:	bot_waypoint_t *wp;
;2165:
;2166:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $509
JUMPV
LABELV $506
line 2167
;2167:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $510
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $505
JUMPV
LABELV $510
line 2168
;2168:	}
LABELV $507
line 2166
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $509
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $506
line 2169
;2169:	return NULL;
CNSTP4 0
RETP4
LABELV $505
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2177
;2170:}
;2171:
;2172:/*
;2173:==================
;2174:BotFreeWaypoints
;2175:==================
;2176:*/
;2177:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2180
;2178:	bot_waypoint_t *nextwp;
;2179:
;2180:	for (; wp; wp = nextwp) {
ADDRGP4 $516
JUMPV
LABELV $513
line 2181
;2181:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2182
;2182:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2183
;2183:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2184
;2184:	}
LABELV $514
line 2180
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $516
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $513
line 2185
;2185:}
LABELV $512
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2192
;2186:
;2187:/*
;2188:==================
;2189:BotInitWaypoints
;2190:==================
;2191:*/
;2192:void BotInitWaypoints(void) {
line 2195
;2193:	int i;
;2194:
;2195:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2196
;2196:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $518
line 2197
;2197:		botai_waypoints[i].next = botai_freewaypoints;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2198
;2198:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2199
;2199:	}
LABELV $519
line 2196
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $518
line 2200
;2200:}
LABELV $517
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 2207
;2201:
;2202:/*
;2203:==================
;2204:TeamPlayIsOn
;2205:==================
;2206:*/
;2207:int TeamPlayIsOn(void) {
line 2208
;2208:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $525
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $526
JUMPV
LABELV $525
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $526
ADDRLP4 0
INDIRI4
RETI4
LABELV $523
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 28 0
line 2216
;2209:}
;2210:
;2211:/*
;2212:==================
;2213:BotAggression
;2214:==================
;2215:*/
;2216:float BotAggression(bot_state_t *bs) {
line 2218
;2217:	//if the bot has quad
;2218:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $528
line 2220
;2219:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2220:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $532
ADDRLP4 0
INDIRP4
CNSTI4 5752
ADDP4
INDIRI4
CNSTI4 80
GEI4 $530
LABELV $532
line 2221
;2221:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2222
;2222:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $527
JUMPV
LABELV $530
line 2224
;2223:		}
;2224:	}
LABELV $528
line 2226
;2225:	//if the enemy is located way higher than the bot
;2226:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
INDIRI4
CNSTI4 200
LEI4 $533
CNSTF4 0
RETF4
ADDRGP4 $527
JUMPV
LABELV $533
line 2228
;2227:	//if the bot is very low on health
;2228:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $535
CNSTF4 0
RETF4
ADDRGP4 $527
JUMPV
LABELV $535
line 2230
;2229:	//if the bot is low on health
;2230:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $537
line 2232
;2231:		//if the bot has insufficient armor
;2232:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $539
CNSTF4 0
RETF4
ADDRGP4 $527
JUMPV
LABELV $539
line 2233
;2233:	}
LABELV $537
line 2235
;2234:	//if the bot can use the bfg
;2235:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $541
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $541
line 2236
;2236:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $527
JUMPV
LABELV $541
line 2238
;2237:	//if the bot can use the railgun
;2238:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $543
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $543
line 2239
;2239:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $527
JUMPV
LABELV $543
line 2241
;2240:	//if the bot can use the lightning gun
;2241:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $545
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $545
line 2242
;2242:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $527
JUMPV
LABELV $545
line 2244
;2243:	//if the bot can use the rocketlauncher
;2244:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $547
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $547
line 2245
;2245:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $527
JUMPV
LABELV $547
line 2247
;2246:	//if the bot can use the plasmagun
;2247:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $549
ADDRLP4 16
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 40
LEI4 $549
line 2248
;2248:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $527
JUMPV
LABELV $549
line 2250
;2249:	//if the bot can use the grenade launcher
;2250:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $551
ADDRLP4 20
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 10
LEI4 $551
line 2251
;2251:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $527
JUMPV
LABELV $551
line 2253
;2252:	//if the bot can use the shotgun
;2253:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 0
LEI4 $553
ADDRLP4 24
INDIRP4
CNSTI4 5024
ADDP4
INDIRI4
CNSTI4 10
LEI4 $553
line 2254
;2254:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $527
JUMPV
LABELV $553
line 2256
;2255:	//otherwise the bot is not feeling too good
;2256:	return 0;
CNSTF4 0
RETF4
LABELV $527
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2264
;2257:}
;2258:
;2259:/*
;2260:==================
;2261:BotFeelingBad
;2262:==================
;2263:*/
;2264:float BotFeelingBad(bot_state_t *bs) {
line 2265
;2265:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $556
line 2266
;2266:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $555
JUMPV
LABELV $556
line 2268
;2267:	}
;2268:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $558
line 2269
;2269:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $555
JUMPV
LABELV $558
line 2271
;2270:	}
;2271:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 2
NEI4 $560
line 2272
;2272:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $555
JUMPV
LABELV $560
line 2274
;2273:	}
;2274:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $562
line 2275
;2275:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $555
JUMPV
LABELV $562
line 2277
;2276:	}
;2277:	return 0;
CNSTF4 0
RETF4
LABELV $555
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 144 8
line 2285
;2278:}
;2279:
;2280:/*
;2281:==================
;2282:BotWantsToRetreat
;2283:==================
;2284:*/
;2285:int BotWantsToRetreat(bot_state_t *bs) {
line 2288
;2286:	aas_entityinfo_t entinfo;
;2287:
;2288:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $565
line 2290
;2289:		//always retreat when carrying a CTF flag
;2290:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $567
line 2291
;2291:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $564
JUMPV
LABELV $567
line 2292
;2292:	}
LABELV $565
line 2318
;2293:#ifdef MISSIONPACK
;2294:	else if (gametype == GT_1FCTF) {
;2295:		//if carrying the flag then always retreat
;2296:		if (Bot1FCTFCarryingFlag(bs))
;2297:			return qtrue;
;2298:	}
;2299:	else if (gametype == GT_OBELISK) {
;2300:		//the bots should be dedicated to attacking the enemy obelisk
;2301:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2302:			if (bs->enemy != redobelisk.entitynum &&
;2303:						bs->enemy != blueobelisk.entitynum) {
;2304:				return qtrue;
;2305:			}
;2306:		}
;2307:		if (BotFeelingBad(bs) > 50) {
;2308:			return qtrue;
;2309:		}
;2310:		return qfalse;
;2311:	}
;2312:	else if (gametype == GT_HARVESTER) {
;2313:		//if carrying cubes then always retreat
;2314:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
;2315:	}
;2316:#endif
;2317:	//
;2318:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $569
line 2320
;2319:		//if the enemy is carrying a flag
;2320:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2321
;2321:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $571
line 2322
;2322:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $564
JUMPV
LABELV $571
line 2323
;2323:	}
LABELV $569
line 2325
;2324:	//if the bot is getting the flag
;2325:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $573
line 2326
;2326:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $564
JUMPV
LABELV $573
line 2328
;2327:	//
;2328:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $575
line 2329
;2329:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $564
JUMPV
LABELV $575
line 2330
;2330:	return qfalse;
CNSTI4 0
RETI4
LABELV $564
endproc BotWantsToRetreat 144 8
export BotWantsToChase
proc BotWantsToChase 148 8
line 2338
;2331:}
;2332:
;2333:/*
;2334:==================
;2335:BotWantsToChase
;2336:==================
;2337:*/
;2338:int BotWantsToChase(bot_state_t *bs) {
line 2341
;2339:	aas_entityinfo_t entinfo;
;2340:
;2341:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $578
line 2343
;2342:		//never chase when carrying a CTF flag
;2343:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $580
line 2344
;2344:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $577
JUMPV
LABELV $580
line 2346
;2345:		//always chase if the enemy is carrying a flag
;2346:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2347
;2347:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $582
line 2348
;2348:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $577
JUMPV
LABELV $582
line 2349
;2349:	}
LABELV $578
line 2376
;2350:#ifdef MISSIONPACK
;2351:	else if (gametype == GT_1FCTF) {
;2352:		//never chase if carrying the flag
;2353:		if (Bot1FCTFCarryingFlag(bs))
;2354:			return qfalse;
;2355:		//always chase if the enemy is carrying a flag
;2356:		BotEntityInfo(bs->enemy, &entinfo);
;2357:		if (EntityCarriesFlag(&entinfo))
;2358:			return qtrue;
;2359:	}
;2360:	else if (gametype == GT_OBELISK) {
;2361:		//the bots should be dedicated to attacking the enemy obelisk
;2362:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
;2363:			if (bs->enemy != redobelisk.entitynum &&
;2364:						bs->enemy != blueobelisk.entitynum) {
;2365:				return qfalse;
;2366:			}
;2367:		}
;2368:	}
;2369:	else if (gametype == GT_HARVESTER) {
;2370:		//never chase if carrying cubes
;2371:		if (BotHarvesterCarryingCubes(bs))
;2372:			return qfalse;
;2373:	}
;2374:#endif
;2375:	//if the bot is getting the flag
;2376:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $584
line 2377
;2377:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $577
JUMPV
LABELV $584
line 2379
;2378:	//
;2379:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $586
line 2380
;2380:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $577
JUMPV
LABELV $586
line 2381
;2381:	return qfalse;
CNSTI4 0
RETI4
LABELV $577
endproc BotWantsToChase 148 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2389
;2382:}
;2383:
;2384:/*
;2385:==================
;2386:BotWantsToHelp
;2387:==================
;2388:*/
;2389:int BotWantsToHelp(bot_state_t *bs) {
line 2390
;2390:	return qtrue;
CNSTI4 1
RETI4
LABELV $588
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 8 16
line 2398
;2391:}
;2392:
;2393:/*
;2394:==================
;2395:BotCanAndWantsToRocketJump
;2396:==================
;2397:*/
;2398:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2402
;2399:	float rocketjumper;
;2400:
;2401:	//if rocket jumping is disabled
;2402:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $590
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $590
line 2404
;2403:	//if no rocket launcher
;2404:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
GTI4 $593
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $593
line 2406
;2405:	//if low on rockets
;2406:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 3
GEI4 $595
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $595
line 2408
;2407:	//never rocket jump with the Quad
;2408:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $597
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $597
line 2410
;2409:	//if low on health
;2410:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $599
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $599
line 2412
;2411:	//if not full health
;2412:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 90
GEI4 $601
line 2414
;2413:		//if the bot has insufficient armor
;2414:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $603
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $603
line 2415
;2415:	}
LABELV $601
line 2416
;2416:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2417
;2417:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $605
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $605
line 2418
;2418:	return qtrue;
CNSTI4 1
RETI4
LABELV $589
endproc BotCanAndWantsToRocketJump 8 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 32 0
line 2426
;2419:}
;2420:
;2421:/*
;2422:==================
;2423:BotHasPersistantPowerupAndWeapon
;2424:==================
;2425:*/
;2426:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2437
;2427:#ifdef MISSIONPACK
;2428:	// if the bot does not have a persistant powerup
;2429:	if (!bs->inventory[INVENTORY_SCOUT] &&
;2430:		!bs->inventory[INVENTORY_GUARD] &&
;2431:		!bs->inventory[INVENTORY_DOUBLER] &&
;2432:		!bs->inventory[INVENTORY_AMMOREGEN] ) {
;2433:		return qfalse;
;2434:	}
;2435:#endif
;2436:	//if the bot is very low on health
;2437:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $608
CNSTI4 0
RETI4
ADDRGP4 $607
JUMPV
LABELV $608
line 2439
;2438:	//if the bot is low on health
;2439:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $610
line 2441
;2440:		//if the bot has insufficient armor
;2441:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $612
CNSTI4 0
RETI4
ADDRGP4 $607
JUMPV
LABELV $612
line 2442
;2442:	}
LABELV $610
line 2444
;2443:	//if the bot can use the bfg
;2444:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $614
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $614
line 2445
;2445:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $614
line 2447
;2446:	//if the bot can use the railgun
;2447:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $616
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $616
line 2448
;2448:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $616
line 2450
;2449:	//if the bot can use the lightning gun
;2450:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $618
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $618
line 2451
;2451:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $618
line 2453
;2452:	//if the bot can use the rocketlauncher
;2453:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $620
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $620
line 2454
;2454:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $620
line 2456
;2455:	//
;2456:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $622
ADDRLP4 16
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 5
LEI4 $622
line 2457
;2457:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $622
line 2459
;2458:	//
;2459:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 5016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $624
ADDRLP4 20
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 5
LEI4 $624
line 2460
;2460:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $624
line 2462
;2461:	//
;2462:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $626
ADDRLP4 24
INDIRP4
CNSTI4 5064
ADDP4
INDIRI4
CNSTI4 40
LEI4 $626
line 2463
;2463:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $626
line 2465
;2464:	//if the bot can use the plasmagun
;2465:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $628
ADDRLP4 28
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 20
LEI4 $628
line 2466
;2466:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $607
JUMPV
LABELV $628
line 2467
;2467:	return qfalse;
CNSTI4 0
RETI4
LABELV $607
endproc BotHasPersistantPowerupAndWeapon 32 0
export BotGoCamp
proc BotGoCamp 16 16
line 2475
;2468:}
;2469:
;2470:/*
;2471:==================
;2472:BotGoCamp
;2473:==================
;2474:*/
;2475:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2478
;2476:	float camper;
;2477:
;2478:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2480
;2479:	//set message time to zero so bot will NOT show any message
;2480:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 2482
;2481:	//set the ltg type
;2482:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 7
ASGNI4
line 2484
;2483:	//set the team goal
;2484:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2486
;2485:	//get the team goal time
;2486:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2487
;2487:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $631
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $632
JUMPV
LABELV $631
line 2488
;2488:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
MULF4
ADDF4
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 972030432
MULF4
ADDF4
ASGNF4
LABELV $632
line 2490
;2489:	//set the last time the bot started camping
;2490:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2492
;2491:	//the teammate that requested the camping
;2492:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
CNSTI4 0
ASGNI4
line 2494
;2493:	//do NOT type arrive message
;2494:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 2495
;2495:}
LABELV $630
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 172 16
line 2502
;2496:
;2497:/*
;2498:==================
;2499:BotWantsToCamp
;2500:==================
;2501:*/
;2502:int BotWantsToCamp(bot_state_t *bs) {
line 2507
;2503:	float camper;
;2504:	int cs, traveltime, besttraveltime;
;2505:	bot_goal_t goal, bestgoal;
;2506:
;2507:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2508
;2508:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $634
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $634
line 2510
;2509:	//if the bot has a team goal
;2510:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 7
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $644
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
NEI4 $636
LABELV $644
line 2517
;2511:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2512:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2513:			bs->ltgtype == LTG_GETFLAG ||
;2514:			bs->ltgtype == LTG_RUSHBASE ||
;2515:			bs->ltgtype == LTG_CAMP ||
;2516:			bs->ltgtype == LTG_CAMPORDER ||
;2517:			bs->ltgtype == LTG_PATROL) {
line 2518
;2518:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $636
line 2521
;2519:	}
;2520:	//if camped recently
;2521:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
CNSTF4 1133903872
MULF4
ADDF4
LEF4 $645
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $645
line 2523
;2522:	//
;2523:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 124
INDIRF4
LEF4 $647
line 2524
;2524:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2525
;2525:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $647
line 2528
;2526:	}
;2527:	//if the bot isn't healthy enough
;2528:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $649
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $649
line 2530
;2529:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2530:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS] < 10) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $653
ADDRLP4 144
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 10
GEI4 $651
LABELV $653
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $654
ADDRLP4 148
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 10
GEI4 $651
LABELV $654
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $655
ADDRLP4 152
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 10
GEI4 $651
LABELV $655
line 2532
;2531:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2532:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2533
;2533:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $651
line 2536
;2534:	}
;2535:	//find the closest camp spot
;2536:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2537
;2537:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
ADDRGP4 $659
JUMPV
LABELV $656
line 2538
;2538:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 164
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 164
INDIRI4
ASGNI4
line 2539
;2539:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $661
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $661
line 2540
;2540:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2541
;2541:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2542
;2542:		}
LABELV $661
line 2543
;2543:	}
LABELV $657
line 2537
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
LABELV $659
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $656
line 2544
;2544:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $663
CNSTI4 0
RETI4
ADDRGP4 $633
JUMPV
LABELV $663
line 2546
;2545:	//ok found a camp spot, go camp there
;2546:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2547
;2547:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 2549
;2548:	//
;2549:	return qtrue;
CNSTI4 1
RETI4
LABELV $633
endproc BotWantsToCamp 172 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2557
;2550:}
;2551:
;2552:/*
;2553:==================
;2554:BotDontAvoid
;2555:==================
;2556:*/
;2557:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2561
;2558:	bot_goal_t goal;
;2559:	int num;
;2560:
;2561:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $667
JUMPV
LABELV $666
line 2562
;2562:	while(num >= 0) {
line 2563
;2563:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2564
;2564:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2565
;2565:	}
LABELV $667
line 2562
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $666
line 2566
;2566:}
LABELV $665
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2573
;2567:
;2568:/*
;2569:==================
;2570:BotGoForPowerups
;2571:==================
;2572:*/
;2573:void BotGoForPowerups(bot_state_t *bs) {
line 2576
;2574:
;2575:	//don't avoid any of the powerups anymore
;2576:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $671
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2577
;2577:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $672
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2578
;2578:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $673
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2579
;2579:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2580
;2580:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $675
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2584
;2581:	//BotDontAvoid(bs, "Flight");
;2582:	//reset the long term goal time so the bot will go for the powerup
;2583:	//NOTE: the long term goal type doesn't change
;2584:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
line 2585
;2585:}
LABELV $670
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 168 28
line 2592
;2586:
;2587:/*
;2588:==================
;2589:BotRoamGoal
;2590:==================
;2591:*/
;2592:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2598
;2593:	int pc, i;
;2594:	float len, rnd;
;2595:	vec3_t dir, bestorg, belowbestorg;
;2596:	bsp_trace_t trace;
;2597:
;2598:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $677
line 2600
;2599:		//start at the bot origin
;2600:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2601
;2601:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 2602
;2602:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $681
line 2604
;2603:			//add a random value to the x-coordinate
;2604:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $683
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $684
JUMPV
LABELV $683
line 2605
;2605:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $684
line 2606
;2606:		}
LABELV $681
line 2607
;2607:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $685
line 2609
;2608:			//add a random value to the y-coordinate
;2609:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $687
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $688
JUMPV
LABELV $687
line 2610
;2610:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $688
line 2611
;2611:		}
LABELV $685
line 2613
;2612:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2613:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1119879168
MULF4
ADDF4
ASGNF4
line 2615
;2614:		//trace a line from the origin to the roam target
;2615:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2617
;2616:		//direction and length towards the roam target
;2617:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2618
;2618:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 152
INDIRF4
ASGNF4
line 2620
;2619:		//if the roam target is far away enough
;2620:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $699
line 2622
;2621:			//the roam target is in the given direction before walls
;2622:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2623
;2623:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 160
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2625
;2624:			//get the coordinates of the floor below the roam target
;2625:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2626
;2626:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2627
;2627:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2628
;2628:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2630
;2629:			//
;2630:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $716
line 2631
;2631:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2632
;2632:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 164
INDIRI4
ASGNI4
line 2633
;2633:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $722
line 2634
;2634:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2635
;2635:					return;
ADDRGP4 $676
JUMPV
LABELV $722
line 2637
;2636:				}
;2637:			}
LABELV $716
line 2638
;2638:		}
LABELV $699
line 2639
;2639:	}
LABELV $678
line 2598
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $677
line 2640
;2640:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2641
;2641:}
LABELV $676
endproc BotRoamGoal 168 28
data
align 4
LABELV $726
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2648
;2642:
;2643:/*
;2644:==================
;2645:BotAttackMove
;2646:==================
;2647:*/
;2648:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2652
;2649:	int movetype, i, attackentity;
;2650:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2651:	float attack_dist, attack_range;
;2652:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $726
INDIRB
ASGNB 12
line 2657
;2653:	aas_entityinfo_t entinfo;
;2654:	bot_moveresult_t moveresult;
;2655:	bot_goal_t goal;
;2656:
;2657:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 2659
;2658:	//
;2659:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6124
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $727
line 2661
;2660:		//create the chase goal
;2661:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2662
;2662:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ASGNI4
line 2663
;2663:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 2664
;2664:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2665
;2665:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2667
;2666:		//initialize the movement state
;2667:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2669
;2668:		//move towards the goal
;2669:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2670
;2670:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $727
line 2673
;2671:	}
;2672:	//
;2673:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2675
;2674:	//
;2675:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2676
;2676:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2677
;2677:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2679
;2678:	//if the bot is really stupid
;2679:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $741
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $741
line 2681
;2680:	//initialize the movement state
;2681:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2683
;2682:	//get the enemy entity info
;2683:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2685
;2684:	//direction towards the enemy
;2685:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2687
;2686:	//the distance towards the enemy
;2687:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2688
;2688:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2690
;2689:	//walk, crouch or jump
;2690:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2692
;2691:	//
;2692:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $754
line 2693
;2693:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 340
INDIRF4
GEF4 $756
line 2694
;2694:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2695
;2695:		}
ADDRGP4 $757
JUMPV
LABELV $756
line 2697
;2696:		//wait at least one second before crouching again
;2697:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $758
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 344
INDIRF4
GEF4 $758
line 2698
;2698:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 344
INDIRF4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 2699
;2699:		}
LABELV $758
LABELV $757
line 2700
;2700:	}
LABELV $754
line 2701
;2701:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $760
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $760
line 2703
;2702:	//if the bot should jump
;2703:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $762
line 2705
;2704:		//if jumped last frame
;2705:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $764
line 2706
;2706:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2707
;2707:		}
ADDRGP4 $765
JUMPV
LABELV $764
line 2708
;2708:		else {
line 2709
;2709:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2710
;2710:		}
LABELV $765
line 2711
;2711:	}
LABELV $762
line 2712
;2712:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $766
line 2713
;2713:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2714
;2714:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2715
;2715:	}
ADDRGP4 $767
JUMPV
LABELV $766
line 2716
;2716:	else {
line 2717
;2717:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2718
;2718:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2719
;2719:	}
LABELV $767
line 2721
;2720:	//if the bot is stupid
;2721:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $768
line 2723
;2722:		//just walk to or away from the enemy
;2723:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $770
line 2724
;2724:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $772
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $772
line 2725
;2725:		}
LABELV $770
line 2726
;2726:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $774
line 2727
;2727:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $776
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $776
line 2728
;2728:		}
LABELV $774
line 2729
;2729:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $768
line 2732
;2730:	}
;2731:	//increase the strafe time
;2732:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 6116
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2734
;2733:	//get the strafe change time
;2734:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
CNSTF4 1045220557
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2735
;2735:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $778
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1053609165
MULF4
ADDF4
ASGNF4
LABELV $778
line 2737
;2736:	//if the strafe direction should be changed
;2737:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $780
line 2739
;2738:		//some magic number :)
;2739:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1064262697
LEF4 $782
line 2741
;2740:			//flip the strafe direction
;2741:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2742
;2742:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2743
;2743:		}
LABELV $782
line 2744
;2744:	}
LABELV $780
line 2746
;2745:	//
;2746:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $784
line 2747
;2747:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2748
;2748:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2749
;2749:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2750
;2750:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2752
;2751:		//get the sideward vector
;2752:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2754
;2753:		//reverse the vector depending on the strafe direction
;2754:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $791
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $791
line 2756
;2755:		//randomly go back a little
;2756:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1063675494
LEF4 $797
line 2757
;2757:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2758
;2758:		}
ADDRGP4 $798
JUMPV
LABELV $797
line 2759
;2759:		else {
line 2761
;2760:			//walk forward or backward to get at the ideal attack distance
;2761:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $805
line 2762
;2762:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2763
;2763:			}
ADDRGP4 $806
JUMPV
LABELV $805
line 2764
;2764:			else if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $813
line 2765
;2765:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2766
;2766:			}
LABELV $813
LABELV $806
line 2767
;2767:		}
LABELV $798
line 2769
;2768:		//perform the movement
;2769:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $821
line 2770
;2770:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $724
JUMPV
LABELV $821
line 2772
;2771:		//movement failed, flip the strafe direction
;2772:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2773
;2773:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2774
;2774:	}
LABELV $785
line 2746
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $784
line 2777
;2775:	//bot couldn't do any useful movement
;2776://	bs->attackchase_time = AAS_Time() + 6;
;2777:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $724
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 0 0
line 2785
;2778:}
;2779:
;2780:/*
;2781:==================
;2782:BotSameTeam
;2783:==================
;2784:*/
;2785:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2789
;2786:
;2787:	extern gclient_t g_clients[ MAX_CLIENTS ];
;2788:
;2789:	if ( (unsigned) bs->client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $824
line 2791
;2790:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2791:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $823
JUMPV
LABELV $824
line 2793
;2792:	}
;2793:	if ( (unsigned) entnum >= MAX_CLIENTS ) {
ADDRFP4 4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $826
line 2795
;2794:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2795:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $823
JUMPV
LABELV $826
line 2797
;2796:	}
;2797:	if ( gametype >= GT_TEAM ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $828
line 2798
;2798:		if ( g_clients[bs->client].sess.sessionTeam == g_clients[entnum].sess.sessionTeam )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 g_clients+624
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 g_clients+624
ADDP4
INDIRI4
NEI4 $830
line 2799
;2799:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $823
JUMPV
LABELV $830
line 2800
;2800:	}
LABELV $828
line 2801
;2801:	return qfalse;
CNSTI4 0
RETI4
LABELV $823
endproc BotSameTeam 0 0
export InFieldOfVision
proc InFieldOfVision 28 4
line 2810
;2802:}
;2803:
;2804:/*
;2805:==================
;2806:InFieldOfVision
;2807:==================
;2808:*/
;2809:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;2810:{
line 2814
;2811:	int i;
;2812:	float diff, angle;
;2813:
;2814:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $835
line 2815
;2815:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2816
;2816:		angles[i] = AngleMod(angles[i]);
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2817
;2817:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2818
;2818:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $839
line 2819
;2819:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $840
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2820
;2820:		}
ADDRGP4 $840
JUMPV
LABELV $839
line 2821
;2821:		else {
line 2822
;2822:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $843
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $843
line 2823
;2823:		}
LABELV $840
line 2824
;2824:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $845
line 2825
;2825:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $846
CNSTI4 0
RETI4
ADDRGP4 $834
JUMPV
line 2826
;2826:		}
LABELV $845
line 2827
;2827:		else {
line 2828
;2828:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
GEF4 $849
CNSTI4 0
RETI4
ADDRGP4 $834
JUMPV
LABELV $849
line 2829
;2829:		}
LABELV $846
line 2830
;2830:	}
LABELV $836
line 2814
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $835
line 2831
;2831:	return qtrue;
CNSTI4 1
RETI4
LABELV $834
endproc InFieldOfVision 28 4
export BotEntityVisible
proc BotEntityVisible 360 28
line 2841
;2832:}
;2833:
;2834:/*
;2835:==================
;2836:BotEntityVisible
;2837:
;2838:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2839:==================
;2840:*/
;2841:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2849
;2842:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2843:	float squaredfogdist, waterfactor, vis, bestvis;
;2844:	bsp_trace_t trace;
;2845:	aas_entityinfo_t entinfo;
;2846:	vec3_t dir, entangles, start, end, middle;
;2847:
;2848:	//calculate middle of bounding box
;2849:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2850
;2850:	if (!entinfo.valid)
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $852
line 2851
;2851:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $851
JUMPV
LABELV $852
line 2852
;2852:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2853
;2853:	VectorScale(middle, 0.5, middle);
ADDRLP4 84
ADDRLP4 84
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 84+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2854
;2854:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2856
;2855:	//check if entity is within field of vision
;2856:	VectorSubtract(middle, eye, dir);
ADDRLP4 332
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2857
;2857:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2858
;2858:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 336
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
NEI4 $883
CNSTF4 0
RETF4
ADDRGP4 $851
JUMPV
LABELV $883
line 2860
;2859:	//
;2860:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 340
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 340
INDIRI4
ASGNI4
line 2861
;2861:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2862
;2862:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2864
;2863:	//
;2864:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2865
;2865:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $885
line 2869
;2866:		//if the point is not in potential visible sight
;2867:		//if (!AAS_inPVS(eye, middle)) continue;
;2868:		//
;2869:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2870
;2870:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2871
;2871:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2872
;2872:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2873
;2873:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2875
;2874:		//if the entity is in water, lava or slime
;2875:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $889
line 2876
;2876:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2877
;2877:		}
LABELV $889
line 2879
;2878:		//if eye is in water, lava or slime
;2879:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $891
line 2880
;2880:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $893
line 2881
;2881:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2882
;2882:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2883
;2883:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2884
;2884:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2885
;2885:			}
LABELV $893
line 2886
;2886:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2887
;2887:		}
LABELV $891
line 2889
;2888:		//trace from start to end
;2889:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2891
;2890:		//if water was hit
;2891:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2892
;2892:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $895
line 2894
;2893:			//if the water surface is translucent
;2894:			if (1) {
line 2896
;2895:				//trace through the water
;2896:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2897
;2897:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2898
;2898:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2899
;2899:			}
LABELV $898
line 2900
;2900:		}
LABELV $895
line 2902
;2901:		//if a full trace or the hitent was hit
;2902:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $905
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $901
LABELV $905
line 2905
;2903:			//check for fog, assuming there's only one fog brush where
;2904:			//either the viewer or the entity is in or both are in
;2905:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 348
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2906
;2906:			if (infog && otherinfog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $906
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $906
line 2907
;2907:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 352
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2908
;2908:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2909
;2909:			}
ADDRGP4 $907
JUMPV
LABELV $906
line 2910
;2910:			else if (infog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $915
line 2911
;2911:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2912
;2912:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2913
;2913:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 352
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2914
;2914:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2915
;2915:			}
ADDRGP4 $916
JUMPV
LABELV $915
line 2916
;2916:			else if (otherinfog) {
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $925
line 2917
;2917:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2918
;2918:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2919
;2919:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2920
;2920:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 352
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 352
INDIRF4
ASGNF4
line 2921
;2921:			}
ADDRGP4 $926
JUMPV
LABELV $925
line 2922
;2922:			else {
line 2924
;2923:				//if the entity and the viewer are not in fog assume there's no fog in between
;2924:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 2925
;2925:			}
LABELV $926
LABELV $916
LABELV $907
line 2927
;2926:			//decrease visibility with the view distance through fog
;2927:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
CNSTF4 1065353216
GEF4 $938
ADDRLP4 352
CNSTF4 1065353216
ASGNF4
ADDRGP4 $939
JUMPV
LABELV $938
ADDRLP4 352
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
ASGNF4
LABELV $939
ADDRLP4 292
CNSTF4 1065353216
ADDRLP4 352
INDIRF4
DIVF4
ASGNF4
line 2929
;2928:			//if entering water visibility is reduced
;2929:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 2931
;2930:			//
;2931:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $940
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $940
line 2933
;2932:			//if pretty much no fog
;2933:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $942
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $851
JUMPV
LABELV $942
line 2934
;2934:		}
LABELV $901
line 2936
;2935:		//check bottom and top of bounding box as well
;2936:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $944
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $945
JUMPV
LABELV $944
line 2937
;2937:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $949
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $949
LABELV $945
line 2938
;2938:	}
LABELV $886
line 2865
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $885
line 2939
;2939:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $851
endproc BotEntityVisible 360 28
export BotFindEnemy
proc BotFindEnemy 424 20
line 2947
;2940:}
;2941:
;2942:/*
;2943:==================
;2944:BotFindEnemy
;2945:==================
;2946:*/
;2947:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 2954
;2948:	int i, healthdecrease;
;2949:	float f, alertness, easyfragger, vis;
;2950:	float squaredist, cursquaredist;
;2951:	aas_entityinfo_t entinfo, curenemyinfo;
;2952:	vec3_t dir, angles;
;2953:
;2954:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 336
INDIRF4
ASGNF4
line 2955
;2955:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 340
INDIRF4
ASGNF4
line 2957
;2956:	//check if the health decreased
;2957:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 5988
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
LEI4 $958
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $959
JUMPV
LABELV $958
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $959
ADDRLP4 160
ADDRLP4 344
INDIRI4
ASGNI4
line 2959
;2958:	//remember the current health value
;2959:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 5988
ADDP4
ADDRLP4 352
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 2961
;2960:	//
;2961:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $960
line 2962
;2962:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 196
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2963
;2963:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 196
ARGP4
ADDRLP4 356
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $962
CNSTI4 0
RETI4
ADDRGP4 $956
JUMPV
LABELV $962
line 2964
;2964:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 196+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 196+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 196+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2965
;2965:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 364
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 364
INDIRF4
ASGNF4
line 2966
;2966:	}
ADDRGP4 $961
JUMPV
LABELV $960
line 2967
;2967:	else {
line 2968
;2968:		cursquaredist = 0;
ADDRLP4 192
CNSTF4 0
ASGNF4
line 2969
;2969:	}
LABELV $961
line 2998
;2970:#ifdef MISSIONPACK
;2971:	if (gametype == GT_OBELISK) {
;2972:		vec3_t target;
;2973:		bot_goal_t *goal;
;2974:		bsp_trace_t trace;
;2975:
;2976:		if (BotTeam(bs) == TEAM_RED)
;2977:			goal = &blueobelisk;
;2978:		else
;2979:			goal = &redobelisk;
;2980:		//if the obelisk is visible
;2981:		VectorCopy(goal->origin, target);
;2982:		target[2] += 1;
;2983:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
;2984:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
;2985:			if (goal->entitynum == bs->enemy) {
;2986:				return qfalse;
;2987:			}
;2988:			bs->enemy = goal->entitynum;
;2989:			bs->enemysight_time = FloatTime();
;2990:			bs->enemysuicide = qfalse;
;2991:			bs->enemydeath_time = 0;
;2992:			bs->enemyvisible_time = FloatTime();
;2993:			return qtrue;
;2994:		}
;2995:	}
;2996:#endif
;2997:	//
;2998:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $974
JUMPV
LABELV $971
line 3000
;2999:
;3000:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $976
ADDRGP4 $972
JUMPV
LABELV $976
line 3002
;3001:		//if it's the current enemy
;3002:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $978
ADDRGP4 $972
JUMPV
LABELV $978
line 3004
;3003:		//if the enemy has targeting disabled
;3004:		if (g_entities[i].flags & FL_NOTARGET) continue;
ADDRLP4 140
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $980
ADDRGP4 $972
JUMPV
LABELV $980
line 3006
;3005:		//
;3006:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3008
;3007:		//
;3008:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $983
ADDRGP4 $972
JUMPV
LABELV $983
line 3010
;3009:		//if the enemy isn't dead and the enemy isn't the bot self
;3010:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 356
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
NEI4 $988
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $985
LABELV $988
ADDRGP4 $972
JUMPV
LABELV $985
line 3012
;3011:		//if the enemy is invisible and not shooting
;3012:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $989
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $989
line 3013
;3013:			continue;
ADDRGP4 $972
JUMPV
LABELV $989
line 3016
;3014:		}
;3015:		//if not an easy fragger don't shoot at chatting players
;3016:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
GEF4 $991
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $991
ADDRGP4 $972
JUMPV
LABELV $991
line 3018
;3017:		//
;3018:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $993
line 3019
;3019:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3020
;3020:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 372
INDIRF4
CNSTF4 1167663104
GEF4 $1004
ADDRGP4 $972
JUMPV
LABELV $1004
line 3021
;3021:		}
LABELV $993
line 3023
;3022:		//calculate the distance towards the enemy
;3023:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3024
;3024:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 376
INDIRF4
ASGNF4
line 3026
;3025:		//if this entity is not carrying a flag
;3026:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1013
line 3027
;3027:		{
line 3029
;3028:			//if this enemy is further away than the current one
;3029:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1015
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
LEF4 $1015
ADDRGP4 $972
JUMPV
LABELV $1015
line 3030
;3030:		} //end if
LABELV $1013
line 3032
;3031:		//if the bot has no
;3032:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 156
INDIRF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
MULF4
LEF4 $1017
ADDRGP4 $972
JUMPV
LABELV $1017
line 3034
;3033:		//if on the same team
;3034:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1019
ADDRGP4 $972
JUMPV
LABELV $1019
line 3036
;3035:		//if the bot's health decreased or the enemy is shooting
;3036:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1021
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1023
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
EQI4 $1021
LABELV $1023
line 3037
;3037:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1022
JUMPV
LABELV $1021
line 3039
;3038:		else
;3039:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1025
ADDRLP4 396
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1026
JUMPV
LABELV $1025
ADDRLP4 396
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1026
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 396
INDIRF4
CNSTF4 957339244
MULF4
SUBF4
SUBF4
ASGNF4
LABELV $1022
line 3041
;3040:		//check if the enemy is visible
;3041:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 400
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 400
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 400
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 400
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 404
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 404
INDIRF4
ASGNF4
line 3042
;3042:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1027
ADDRGP4 $972
JUMPV
LABELV $1027
line 3044
;3043:		//if the enemy is quite far away, not shooting and the bot is not damaged
;3044:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1029
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1029
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1029
ADDRLP4 0
ARGP4
ADDRLP4 408
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 0
NEI4 $1029
line 3045
;3045:		{
line 3047
;3046:			//check if we can avoid this enemy
;3047:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 412
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 412
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 412
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3048
;3048:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3050
;3049:			//if the bot isn't in the fov of the enemy
;3050:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 180
ARGP4
ADDRLP4 416
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
NEI4 $1038
line 3052
;3051:				//update some stuff for this enemy
;3052:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3054
;3053:				//if the bot doesn't really want to fight
;3054:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 420
INDIRI4
CNSTI4 0
EQI4 $1041
ADDRGP4 $972
JUMPV
LABELV $1041
line 3055
;3055:			}
LABELV $1038
line 3056
;3056:		}
LABELV $1029
line 3058
;3057:		//found an enemy
;3058:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3059
;3059:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1044
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1045
JUMPV
LABELV $1044
line 3060
;3060:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1045
line 3061
;3061:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 3062
;3062:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 3063
;3063:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3064
;3064:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $972
line 2998
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $974
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $971
line 3066
;3065:	}
;3066:	return qfalse;
CNSTI4 0
RETI4
LABELV $956
endproc BotFindEnemy 424 20
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 3074
;3067:}
;3068:
;3069:/*
;3070:==================
;3071:BotTeamFlagCarrierVisible
;3072:==================
;3073:*/
;3074:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 3079
;3075:	int i;
;3076:	float vis;
;3077:	aas_entityinfo_t entinfo;
;3078:
;3079:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1050
JUMPV
LABELV $1047
line 3080
;3080:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1052
line 3081
;3081:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1052
line 3083
;3082:		//
;3083:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3085
;3084:		//if this player is active
;3085:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1054
line 3086
;3086:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1054
line 3088
;3087:		//if this player is carrying a flag
;3088:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1056
line 3089
;3089:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1056
line 3091
;3090:		//if the flag carrier is not on the same team
;3091:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1058
line 3092
;3092:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1058
line 3094
;3093:		//if the flag carrier is not visible
;3094:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3095
;3095:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1060
line 3096
;3096:			continue;
ADDRGP4 $1048
JUMPV
LABELV $1060
line 3098
;3097:		//
;3098:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1046
JUMPV
LABELV $1048
line 3079
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1050
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1047
line 3100
;3099:	}
;3100:	return -1;
CNSTI4 -1
RETI4
LABELV $1046
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3108
;3101:}
;3102:
;3103:/*
;3104:==================
;3105:BotTeamFlagCarrier
;3106:==================
;3107:*/
;3108:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3112
;3109:	int i;
;3110:	aas_entityinfo_t entinfo;
;3111:
;3112:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1066
JUMPV
LABELV $1063
line 3113
;3113:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1068
line 3114
;3114:			continue;
ADDRGP4 $1064
JUMPV
LABELV $1068
line 3116
;3115:		//
;3116:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3118
;3117:		//if this player is active
;3118:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1070
line 3119
;3119:			continue;
ADDRGP4 $1064
JUMPV
LABELV $1070
line 3121
;3120:		//if this player is carrying a flag
;3121:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1072
line 3122
;3122:			continue;
ADDRGP4 $1064
JUMPV
LABELV $1072
line 3124
;3123:		//if the flag carrier is not on the same team
;3124:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1074
line 3125
;3125:			continue;
ADDRGP4 $1064
JUMPV
LABELV $1074
line 3127
;3126:		//
;3127:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1062
JUMPV
LABELV $1064
line 3112
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1066
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1063
line 3129
;3128:	}
;3129:	return -1;
CNSTI4 -1
RETI4
LABELV $1062
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3137
;3130:}
;3131:
;3132:/*
;3133:==================
;3134:BotEnemyFlagCarrierVisible
;3135:==================
;3136:*/
;3137:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3142
;3138:	int i;
;3139:	float vis;
;3140:	aas_entityinfo_t entinfo;
;3141:
;3142:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1080
JUMPV
LABELV $1077
line 3143
;3143:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1082
line 3144
;3144:			continue;
ADDRGP4 $1078
JUMPV
LABELV $1082
line 3146
;3145:		//
;3146:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3148
;3147:		//if this player is active
;3148:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1084
line 3149
;3149:			continue;
ADDRGP4 $1078
JUMPV
LABELV $1084
line 3151
;3150:		//if this player is carrying a flag
;3151:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1086
line 3152
;3152:			continue;
ADDRGP4 $1078
JUMPV
LABELV $1086
line 3154
;3153:		//if the flag carrier is on the same team
;3154:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1088
line 3155
;3155:			continue;
ADDRGP4 $1078
JUMPV
LABELV $1088
line 3157
;3156:		//if the flag carrier is not visible
;3157:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3158
;3158:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1090
line 3159
;3159:			continue;
ADDRGP4 $1078
JUMPV
LABELV $1090
line 3161
;3160:		//
;3161:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1076
JUMPV
LABELV $1078
line 3142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1080
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1077
line 3163
;3162:	}
;3163:	return -1;
CNSTI4 -1
RETI4
LABELV $1076
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3171
;3164:}
;3165:
;3166:/*
;3167:==================
;3168:BotVisibleTeamMatesAndEnemies
;3169:==================
;3170:*/
;3171:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3177
;3172:	int i;
;3173:	float vis;
;3174:	aas_entityinfo_t entinfo;
;3175:	vec3_t dir;
;3176:
;3177:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1093
line 3178
;3178:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1093
line 3179
;3179:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1095
line 3180
;3180:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1095
line 3181
;3181:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1100
JUMPV
LABELV $1097
line 3182
;3182:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1102
line 3183
;3183:			continue;
ADDRGP4 $1098
JUMPV
LABELV $1102
line 3185
;3184:		//
;3185:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3187
;3186:		//if this player is active
;3187:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1104
line 3188
;3188:			continue;
ADDRGP4 $1098
JUMPV
LABELV $1104
line 3190
;3189:		//if this player is carrying a flag
;3190:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1106
line 3191
;3191:			continue;
ADDRGP4 $1098
JUMPV
LABELV $1106
line 3193
;3192:		//if not within range
;3193:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3194
;3194:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1115
line 3195
;3195:			continue;
ADDRGP4 $1098
JUMPV
LABELV $1115
line 3197
;3196:		//if the flag carrier is not visible
;3197:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3198
;3198:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1117
line 3199
;3199:			continue;
ADDRGP4 $1098
JUMPV
LABELV $1117
line 3201
;3200:		//if the flag carrier is on the same team
;3201:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1119
line 3202
;3202:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1120
line 3203
;3203:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3204
;3204:		}
ADDRGP4 $1120
JUMPV
LABELV $1119
line 3205
;3205:		else {
line 3206
;3206:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1123
line 3207
;3207:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1123
line 3208
;3208:		}
LABELV $1120
line 3209
;3209:	}
LABELV $1098
line 3181
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1100
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1097
line 3210
;3210:}
LABELV $1092
endproc BotVisibleTeamMatesAndEnemies 192 20
data
align 4
LABELV $1126
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1127
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1128 52
line 3281
;3211:
;3212:#ifdef MISSIONPACK
;3213:/*
;3214:==================
;3215:BotTeamCubeCarrierVisible
;3216:==================
;3217:*/
;3218:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
;3219:	int i;
;3220:	float vis;
;3221:	aas_entityinfo_t entinfo;
;3222:
;3223:	for (i = 0; i < maxclients; i++) {
;3224:		if (i == bs->client) continue;
;3225:		//
;3226:		BotEntityInfo(i, &entinfo);
;3227:		//if this player is active
;3228:		if (!entinfo.valid) continue;
;3229:		//if this player is carrying a flag
;3230:		if (!EntityCarriesCubes(&entinfo)) continue;
;3231:		//if the flag carrier is not on the same team
;3232:		if (!BotSameTeam(bs, i)) continue;
;3233:		//if the flag carrier is not visible
;3234:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3235:		if (vis <= 0) continue;
;3236:		//
;3237:		return i;
;3238:	}
;3239:	return -1;
;3240:}
;3241:
;3242:/*
;3243:==================
;3244:BotEnemyCubeCarrierVisible
;3245:==================
;3246:*/
;3247:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
;3248:	int i;
;3249:	float vis;
;3250:	aas_entityinfo_t entinfo;
;3251:
;3252:	for (i = 0; i < maxclients; i++) {
;3253:		if (i == bs->client)
;3254:			continue;
;3255:		//
;3256:		BotEntityInfo(i, &entinfo);
;3257:		//if this player is active
;3258:		if (!entinfo.valid)
;3259:			continue;
;3260:		//if this player is carrying a flag
;3261:		if (!EntityCarriesCubes(&entinfo)) continue;
;3262:		//if the flag carrier is on the same team
;3263:		if (BotSameTeam(bs, i))
;3264:			continue;
;3265:		//if the flag carrier is not visible
;3266:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
;3267:		if (vis <= 0)
;3268:			continue;
;3269:		//
;3270:		return i;
;3271:	}
;3272:	return -1;
;3273:}
;3274:#endif
;3275:
;3276:/*
;3277:==================
;3278:BotAimAtEnemy
;3279:==================
;3280:*/
;3281:void BotAimAtEnemy(bot_state_t *bs) {
line 3285
;3282:	int i, enemyvisible;
;3283:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3284:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3285:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1126
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1127
INDIRB
ASGNB 12
line 3293
;3286:	weaponinfo_t wi;
;3287:	aas_entityinfo_t entinfo;
;3288:	bot_goal_t goal;
;3289:	bsp_trace_t trace;
;3290:	vec3_t target;
;3291:
;3292:	//if the bot has no enemy
;3293:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1128
line 3294
;3294:		return;
ADDRGP4 $1125
JUMPV
LABELV $1128
line 3297
;3295:	}
;3296:	//get the enemy entity information
;3297:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3299
;3298:	//if this is not a player (should be an obelisk)
;3299:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1130
line 3301
;3300:		//if the obelisk is visible
;3301:		VectorCopy(entinfo.origin, target);
ADDRLP4 828
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3310
;3302:#ifdef MISSIONPACK
;3303:		// if attacking an obelisk
;3304:		if ( bs->enemy == redobelisk.entitynum ||
;3305:			bs->enemy == blueobelisk.entitynum ) {
;3306:			target[2] += 32;
;3307:		}
;3308:#endif
;3309:		//aim at the obelisk
;3310:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 984
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3311
;3311:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3313
;3312:		//set the aim target before trying to attack
;3313:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 828
INDIRB
ASGNB 12
line 3314
;3314:		return;
ADDRGP4 $1125
JUMPV
LABELV $1130
line 3319
;3315:	}
;3316:	//
;3317:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3318:	//
;3319:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3320
;3320:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3322
;3321:	//
;3322:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1137
line 3324
;3323:		//don't aim too early
;3324:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
ADDRLP4 992
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3325
;3325:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1139
ADDRGP4 $1125
JUMPV
LABELV $1139
line 3326
;3326:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1141
ADDRGP4 $1125
JUMPV
LABELV $1141
line 3327
;3327:	}
LABELV $1137
line 3330
;3328:
;3329:	//get the weapon information
;3330:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3332
;3331:	//get the weapon specific aim accuracy and or aim skill
;3332:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1143
line 3333
;3333:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3334
;3334:	}
ADDRGP4 $1144
JUMPV
LABELV $1143
line 3335
;3335:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1146
line 3336
;3336:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3337
;3337:	}
ADDRGP4 $1147
JUMPV
LABELV $1146
line 3338
;3338:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1149
line 3339
;3339:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3340
;3340:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3341
;3341:	}
ADDRGP4 $1150
JUMPV
LABELV $1149
line 3342
;3342:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1152
line 3343
;3343:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3344
;3344:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3345
;3345:	}
ADDRGP4 $1153
JUMPV
LABELV $1152
line 3346
;3346:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1155
line 3347
;3347:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3348
;3348:	}
ADDRGP4 $1156
JUMPV
LABELV $1155
line 3349
;3349:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1158
line 3350
;3350:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3351
;3351:	}
ADDRGP4 $1159
JUMPV
LABELV $1158
line 3352
;3352:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1161
line 3353
;3353:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3354
;3354:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3355
;3355:	}
ADDRGP4 $1162
JUMPV
LABELV $1161
line 3356
;3356:	else if (wi.number == WP_BFG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1164
line 3357
;3357:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3358
;3358:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3359
;3359:	}
LABELV $1164
LABELV $1162
LABELV $1159
LABELV $1156
LABELV $1153
LABELV $1150
LABELV $1147
LABELV $1144
line 3361
;3360:	//
;3361:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1167
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1167
line 3363
;3362:	//get the enemy entity information
;3363:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3365
;3364:	//if the enemy is invisible then shoot crappy most of the time
;3365:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1169
line 3366
;3366:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1036831949
LEF4 $1171
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1053609165
MULF4
ASGNF4
LABELV $1171
line 3367
;3367:	}
LABELV $1169
line 3369
;3368:	//
;3369:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3370
;3370:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 712
ADDRLP4 712
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3372
;3371:	//enemy origin and velocity is remembered every 0.5 seconds
;3372:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1192
line 3374
;3373:		//
;3374:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3375
;3375:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6232
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3376
;3376:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6244
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3377
;3377:	}
LABELV $1192
line 3379
;3378:	//if not extremely skilled
;3379:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1195
line 3380
;3380:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3382
;3381:		//if the enemy moved a bit
;3382:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1004
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1004
INDIRF4
CNSTF4 1158676480
LEF4 $1204
line 3384
;3383:			//if the enemy changed direction
;3384:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6232
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1008
INDIRP4
CNSTI4 6236
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1008
INDIRP4
CNSTI4 6240
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1206
line 3386
;3385:				//aim accuracy should be worse now
;3386:				aim_accuracy *= 0.7f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3387
;3387:			}
LABELV $1206
line 3388
;3388:		}
LABELV $1204
line 3389
;3389:	}
LABELV $1195
line 3391
;3390:	//check visibility of enemy
;3391:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1000
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1000
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 824
ADDRLP4 1004
INDIRF4
CVFI4 4
ASGNI4
line 3393
;3392:	//if the enemy is visible
;3393:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1210
line 3395
;3394:		//
;3395:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3396
;3396:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3399
;3397:		//get the start point shooting from
;3398:		//NOTE: the x and y projectile start offsets are ignored
;3399:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3400
;3400:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3401
;3401:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3403
;3402:		//
;3403:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3405
;3404:		//if the enemy is NOT hit
;3405:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1218
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1218
line 3406
;3406:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3407
;3407:		}
LABELV $1218
line 3409
;3408:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3409:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1224
line 3411
;3410:			//
;3411:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3412
;3412:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3413
;3413:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3415
;3414:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3415:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1240
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1149239296
LTF4 $1238
LABELV $1240
line 3417
;3416:				//if skilled enough do exact prediction
;3417:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1241
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1241
line 3419
;3418:						//if the weapon is ready to fire
;3419:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3423
;3420:					aas_clientmove_t move;
;3421:					vec3_t origin;
;3422:
;3423:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3425
;3424:					//distance towards the enemy
;3425:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1124
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1124
INDIRF4
ASGNF4
line 3427
;3426:					//direction the enemy is moving in
;3427:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3429
;3428:					//
;3429:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 140
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3431
;3430:					//
;3431:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1024
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3432
;3432:					origin[2] += 1;
ADDRLP4 1024+8
ADDRLP4 1024+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3434
;3433:					//
;3434:					VectorClear(cmdmove);
ADDRLP4 968
CNSTF4 0
ASGNF4
ADDRLP4 968+4
CNSTF4 0
ASGNF4
ADDRLP4 968+8
CNSTF4 0
ASGNF4
line 3436
;3435:					//AAS_ClearShownDebugLines();
;3436:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1036
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
INDIRF4
CNSTF4 1092616192
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3440
;3437:														PRESENCE_CROUCH, qfalse,
;3438:														dir, cmdmove, 0,
;3439:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3440:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1036
INDIRB
ASGNB 12
line 3442
;3441:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3442:				}
ADDRGP4 $1242
JUMPV
LABELV $1241
line 3444
;3443:				//if not that skilled do linear prediction
;3444:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1274
line 3445
;3445:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3447
;3446:					//distance towards the enemy
;3447:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1028
INDIRF4
ASGNF4
line 3449
;3448:					//direction the enemy is moving in
;3449:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3450
;3450:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3452
;3451:					//
;3452:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1032
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3455
;3453:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3454:					//best spot to aim at
;3455:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1036
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1040
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3456
;3456:				}
LABELV $1274
LABELV $1242
line 3457
;3457:			}
LABELV $1238
line 3458
;3458:		}
LABELV $1224
line 3460
;3459:		//if the projectile does radial damage
;3460:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1309
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1309
line 3462
;3461:			//if the enemy isn't standing significantly higher than the bot
;3462:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1313
line 3464
;3463:				//try to aim at the ground in front of the enemy
;3464:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3465
;3465:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3466
;3466:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3468
;3467:				//
;3468:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3469
;3469:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $1321
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $1322
JUMPV
LABELV $1321
line 3470
;3470:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $1322
line 3472
;3471:				//trace a line from projectile start to ground target
;3472:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3474
;3473:				//if hitpoint is not vertically too far from the ground target
;3474:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1008
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1112014848
GEF4 $1330
line 3475
;3475:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3477
;3476:					//if the hitpoint is near enough the ground target
;3477:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1012
INDIRF4
CNSTF4 1163984896
GEF4 $1344
line 3478
;3478:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3480
;3479:						//if the hitpoint is far enough from the bot
;3480:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1016
INDIRF4
CNSTF4 1176256512
LEF4 $1355
line 3482
;3481:							//check if the bot is visible from the ground target
;3482:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3483
;3483:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3484
;3484:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $1362
line 3486
;3485:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3486:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3487
;3487:							}
LABELV $1362
line 3488
;3488:						}
LABELV $1355
line 3489
;3489:					}
LABELV $1344
line 3490
;3490:				}
LABELV $1330
line 3491
;3491:			}
LABELV $1313
line 3492
;3492:		}
LABELV $1309
line 3493
;3493:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1008
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3494
;3494:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3495
;3495:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1092616192
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3496
;3496:	}
ADDRGP4 $1211
JUMPV
LABELV $1210
line 3497
;3497:	else {
line 3499
;3498:		//
;3499:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 3500
;3500:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3502
;3501:		//if the bot is skilled enough
;3502:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $1368
line 3504
;3503:			//do prediction shots around corners
;3504:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $1376
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $1376
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1370
LABELV $1376
line 3506
;3505:				wi.number == WP_ROCKET_LAUNCHER ||
;3506:				wi.number == WP_GRENADE_LAUNCHER) {
line 3508
;3507:				//create the chase goal
;3508:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3509
;3509:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3510
;3510:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRB
ASGNB 12
line 3511
;3511:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3512
;3512:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3514
;3513:				//
;3514:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6548
ADDP4
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 828
ARGP4
ADDRLP4 1012
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $1389
line 3515
;3515:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 828
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 828+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 828+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3516
;3516:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1170735104
LEF4 $1395
line 3517
;3517:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 828
INDIRB
ASGNB 12
line 3518
;3518:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3519
;3519:					}
LABELV $1395
line 3520
;3520:				}
LABELV $1389
line 3521
;3521:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3522
;3522:			}
LABELV $1370
line 3523
;3523:		}
LABELV $1368
line 3524
;3524:	}
LABELV $1211
line 3526
;3525:	//
;3526:	if (enemyvisible) {
ADDRLP4 824
INDIRI4
CNSTI4 0
EQI4 $1398
line 3527
;3527:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3528
;3528:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3529
;3529:	}
ADDRGP4 $1399
JUMPV
LABELV $1398
line 3530
;3530:	else {
line 3531
;3531:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3532
;3532:	}
LABELV $1399
line 3534
;3533:	//get aim direction
;3534:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3536
;3535:	//
;3536:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $1413
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $1413
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $1413
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1405
LABELV $1413
line 3539
;3537:		wi.number == WP_SHOTGUN ||
;3538:		wi.number == WP_LIGHTNING ||
;3539:		wi.number == WP_RAILGUN) {
line 3541
;3540:		//distance towards the enemy
;3541:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3542
;3542:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $1414
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $1414
line 3543
;3543:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
ADDRLP4 840
INDIRF4
CNSTF4 992920382
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3544
;3544:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3545
;3545:	}
LABELV $1405
line 3547
;3546:	//add some random stuff to the aim direction depending on the aim accuracy
;3547:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $1416
line 3548
;3548:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3549
;3549:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $1418
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1050253722
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $1419
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $1418
line 3550
;3550:	}
LABELV $1416
line 3552
;3551:	//set the ideal view angles
;3552:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3554
;3553:	//take the weapon spread into account for lower skilled bots
;3554:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 160+268
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3555
;3555:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 1024
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 1024
INDIRF4
ASGNF4
line 3556
;3556:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1028
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1032
INDIRP4
ADDRLP4 1032
INDIRP4
INDIRF4
ADDRLP4 160+264
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1028
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3557
;3557:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 1040
INDIRF4
ASGNF4
line 3559
;3558:	//if the bots should be really challenging
;3559:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $1424
line 3561
;3560:		//if the bot is really accurate and has the enemy in view for some time
;3561:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $1427
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1427
line 3563
;3562:			//set the view angles directly
;3563:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $1429
ADDRLP4 1044
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1429
line 3564
;3564:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 6564
ADDP4
ADDRLP4 1048
INDIRP4
CNSTI4 6576
ADDP4
INDIRB
ASGNB 12
line 3565
;3565:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3566
;3566:		}
LABELV $1427
line 3567
;3567:	}
LABELV $1424
line 3568
;3568:}
LABELV $1125
endproc BotAimAtEnemy 1128 52
data
align 4
LABELV $1432
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1433
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1024 28
line 3575
;3569:
;3570:/*
;3571:==================
;3572:BotCheckAttack
;3573:==================
;3574:*/
;3575:void BotCheckAttack(bot_state_t *bs) {
line 3585
;3576:	float points, reactiontime, fov, firethrottle;
;3577:	int attackentity;
;3578:	bsp_trace_t bsptrace;
;3579:	//float selfpreservation;
;3580:	vec3_t forward, right, start, end, dir, angles;
;3581:	weaponinfo_t wi;
;3582:	bsp_trace_t trace;
;3583:	aas_entityinfo_t entinfo;
;3584:	weapon_t weapon;
;3585:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 812
ADDRGP4 $1432
INDIRB
ASGNB 12
ADDRLP4 824
ADDRGP4 $1433
INDIRB
ASGNB 12
line 3587
;3586:
;3587:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 3589
;3588:	//
;3589:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 836
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3591
;3590:	// if not attacking a player
;3591:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1434
line 3603
;3592:#ifdef MISSIONPACK
;3593:		// if attacking an obelisk
;3594:		if ( entinfo.number == redobelisk.entitynum ||
;3595:			entinfo.number == blueobelisk.entitynum ) {
;3596:			// if obelisk is respawning return
;3597:			if ( g_entities[entinfo.number].activator &&
;3598:				g_entities[entinfo.number].activator->s.frame == 2 ) {
;3599:				return;
;3600:			}
;3601:		}
;3602:#endif
;3603:	}
LABELV $1434
line 3605
;3604:	//
;3605:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 704
ADDRLP4 980
INDIRF4
ASGNF4
line 3606
;3606:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $1436
ADDRGP4 $1431
JUMPV
LABELV $1436
line 3607
;3607:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $1438
ADDRGP4 $1431
JUMPV
LABELV $1438
line 3609
;3608:	//if changing weapons
;3609:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $1440
ADDRGP4 $1431
JUMPV
LABELV $1440
line 3611
;3610:	//check fire throttle characteristic
;3611:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1442
ADDRGP4 $1431
JUMPV
LABELV $1442
line 3612
;3612:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 796
ADDRLP4 984
INDIRF4
ASGNF4
line 3613
;3613:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1444
line 3614
;3614:		if (random() > firethrottle) {
ADDRLP4 988
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 796
INDIRF4
LEF4 $1446
line 3615
;3615:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 796
INDIRF4
ADDF4
ASGNF4
line 3616
;3616:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
CNSTF4 0
ASGNF4
line 3617
;3617:		}
ADDRGP4 $1447
JUMPV
LABELV $1446
line 3618
;3618:		else {
line 3619
;3619:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 796
INDIRF4
SUBF4
ASGNF4
line 3620
;3620:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
CNSTF4 0
ASGNF4
line 3621
;3621:		}
LABELV $1447
line 3622
;3622:	}
LABELV $1444
line 3625
;3623:	//
;3624:	//
;3625:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 988
INDIRP4
CNSTI4 6220
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 988
INDIRP4
CNSTI4 6224
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 992
INDIRP4
CNSTI4 6228
ADDP4
INDIRF4
ADDRLP4 992
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3627
;3626:	//
;3627:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1450
line 3628
;3628:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1163984896
LEF4 $1452
line 3629
;3629:			return;
ADDRGP4 $1431
JUMPV
LABELV $1452
line 3631
;3630:		}
;3631:	}
LABELV $1450
line 3632
;3632:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1176256512
GEF4 $1454
line 3633
;3633:		fov = 120;
ADDRLP4 792
CNSTF4 1123024896
ASGNF4
ADDRGP4 $1455
JUMPV
LABELV $1454
line 3635
;3634:	else
;3635:		fov = 50;
ADDRLP4 792
CNSTF4 1112014848
ASGNF4
LABELV $1455
line 3637
;3636:	//
;3637:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 800
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3638
;3638:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 792
INDIRF4
ARGF4
ADDRLP4 800
ARGP4
ADDRLP4 1000
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
NEI4 $1456
line 3639
;3639:		return;
ADDRGP4 $1431
JUMPV
LABELV $1456
line 3640
;3640:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 708
ARGP4
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6220
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3641
;3641:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 708+8
INDIRF4
CNSTF4 1065353216
GEF4 $1458
ADDRLP4 708+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1458
line 3642
;3642:		return;
ADDRGP4 $1431
JUMPV
LABELV $1458
line 3645
;3643:
;3644:	//get the weapon info
;3645:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3647
;3646:	//get the start point shooting from
;3647:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3648
;3648:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3649
;3649:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3650
;3650:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3651
;3651:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3652
;3652:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3654
;3653:	//end point aiming at
;3654:	VectorMA(start, 1000, forward, end);
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
line 3656
;3655:	//a little back to make sure not inside a very close enemy
;3656:	VectorMA(start, -12, forward, start);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
line 3657
;3657:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 812
ARGP4
ADDRLP4 824
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3659
;3658:	//if the entity is a client
;3659:	if (trace.ent >= 0 && trace.ent < MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LTI4 $1492
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GEI4 $1492
line 3660
;3660:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $1496
line 3662
;3661:			//if a teammate is hit
;3662:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1012
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $1499
line 3663
;3663:				return;
ADDRGP4 $1431
JUMPV
LABELV $1499
line 3664
;3664:		}
LABELV $1496
line 3665
;3665:	}
LABELV $1492
line 3667
;3666:	//if won't hit the enemy or not attacking a player (obelisk)
;3667:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $1505
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $1502
LABELV $1505
line 3669
;3668:		//if the projectile does radial damage
;3669:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1506
line 3670
;3670:			if (trace.fraction * 1000 < wi.proj.radius) {
ADDRLP4 592+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $1510
line 3671
;3671:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 976
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
ADDRLP4 592+8
INDIRF4
CNSTF4 1140457472
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3672
;3672:				if (points > 0) {
ADDRLP4 976
INDIRF4
CNSTF4 0
LEF4 $1518
line 3673
;3673:					return;
ADDRGP4 $1431
JUMPV
LABELV $1518
line 3675
;3674:				}
;3675:			}
LABELV $1510
line 3677
;3676:			//FIXME: check if a teammate gets radial damage
;3677:		}
LABELV $1506
line 3678
;3678:	}
LABELV $1502
line 3680
;3679:
;3680:	weapon = bs->cur_ps.weapon;
ADDRLP4 700
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 3681
;3681:	if ( weapon >= WP_MACHINEGUN && weapon <= WP_BFG && !bs->cur_ps.ammo[ weapon ] ) {
ADDRLP4 700
INDIRI4
CNSTI4 2
LTI4 $1520
ADDRLP4 700
INDIRI4
CNSTI4 9
GTI4 $1520
ADDRLP4 700
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 392
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1520
line 3682
;3682:		return;
ADDRGP4 $1431
JUMPV
LABELV $1520
line 3686
;3683:	}
;3684:
;3685:	//if fire has to be release to activate weapon
;3686:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1522
line 3687
;3687:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1523
line 3688
;3688:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3689
;3689:		}
line 3690
;3690:	}
ADDRGP4 $1523
JUMPV
LABELV $1522
line 3691
;3691:	else {
line 3692
;3692:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3693
;3693:	}
LABELV $1523
line 3694
;3694:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3695
;3695:}
LABELV $1431
endproc BotCheckAttack 1024 28
data
align 4
LABELV $1531
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $1532
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $1533
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 264 16
line 3702
;3696:
;3697:/*
;3698:==================
;3699:BotMapScripts
;3700:==================
;3701:*/
;3702:void BotMapScripts(bot_state_t *bs) {
line 3708
;3703:	int i, shootbutton;
;3704:	float aim_accuracy;
;3705:	aas_entityinfo_t entinfo;
;3706:	vec3_t dir;
;3707:
;3708:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $1530
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $1528
line 3709
;3709:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 168
ADDRGP4 $1531
INDIRB
ASGNB 12
ADDRLP4 180
ADDRGP4 $1532
INDIRB
ASGNB 12
line 3710
;3710:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 192
ADDRGP4 $1533
INDIRB
ASGNB 12
line 3712
;3711:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3712:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3714
;3713:		//if the bot is below the bounding box
;3714:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $1534
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $1534
line 3715
;3715:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $1536
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $1536
line 3716
;3716:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $1540
line 3717
;3717:					return;
ADDRGP4 $1527
JUMPV
LABELV $1540
line 3719
;3718:				}
;3719:			}
LABELV $1536
line 3720
;3720:		}
LABELV $1534
line 3721
;3721:		shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3723
;3722:		//if an enemy is below this bounding box then shoot the button
;3723:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1546
JUMPV
LABELV $1543
line 3725
;3724:
;3725:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1548
ADDRGP4 $1544
JUMPV
LABELV $1548
line 3727
;3726:			//
;3727:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3729
;3728:			//
;3729:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1550
ADDRGP4 $1544
JUMPV
LABELV $1550
line 3731
;3730:			//if the enemy isn't dead and the enemy isn't the bot self
;3731:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $1555
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1552
LABELV $1555
ADDRGP4 $1544
JUMPV
LABELV $1552
line 3733
;3732:			//
;3733:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $1556
ADDRLP4 0+24
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $1556
line 3734
;3734:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $1560
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $1560
line 3735
;3735:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $1568
line 3737
;3736:						//if there's a team mate below the crusher
;3737:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $1573
line 3738
;3738:							shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3739
;3739:							break;
ADDRGP4 $1545
JUMPV
LABELV $1573
line 3741
;3740:						}
;3741:						else {
line 3742
;3742:							shootbutton = qtrue;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 3743
;3743:						}
line 3744
;3744:					}
LABELV $1568
line 3745
;3745:				}
LABELV $1560
line 3746
;3746:			}
LABELV $1556
line 3747
;3747:		}
LABELV $1544
line 3723
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1546
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1543
LABELV $1545
line 3748
;3748:		if (shootbutton) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1529
line 3749
;3749:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3750
;3750:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
ADDRLP4 192
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+4
ADDRLP4 192+4
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+8
ADDRLP4 192+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3751
;3751:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 148
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3752
;3752:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 220
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 160
ADDRLP4 220
INDIRF4
ASGNF4
line 3753
;3753:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 224
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 228
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRF4
ADDRLP4 224
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3754
;3754:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 236
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 236
INDIRF4
ASGNF4
line 3755
;3755:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 240
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRF4
ADDRLP4 240
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3756
;3756:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 252
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 252
INDIRF4
ASGNF4
line 3758
;3757:			//
;3758:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 256
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $1529
line 3759
;3759:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3760
;3760:			}
line 3761
;3761:		}
line 3762
;3762:	}
ADDRGP4 $1529
JUMPV
LABELV $1528
line 3763
;3763:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $1585
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $1583
line 3765
;3764:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;3765:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3766
;3766:	}
LABELV $1583
LABELV $1529
line 3767
;3767:}
LABELV $1527
endproc BotMapScripts 264 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 8 16
line 3780
;3768:
;3769:/*
;3770:==================
;3771:BotSetMovedir
;3772:==================
;3773:*/
;3774:// bk001205 - made these static
;3775:static vec3_t VEC_UP		= {0, -1,  0};
;3776:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;3777:static vec3_t VEC_DOWN		= {0, -2,  0};
;3778:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;3779:
;3780:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3781
;3781:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1587
line 3782
;3782:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3783
;3783:	}
ADDRGP4 $1588
JUMPV
LABELV $1587
line 3784
;3784:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1589
line 3785
;3785:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3786
;3786:	}
ADDRGP4 $1590
JUMPV
LABELV $1589
line 3787
;3787:	else {
line 3788
;3788:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3789
;3789:	}
LABELV $1590
LABELV $1588
line 3790
;3790:}
LABELV $1586
endproc BotSetMovedir 8 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 3799
;3791:
;3792:/*
;3793:==================
;3794:BotModelMinsMaxs
;3795:
;3796:this is ugly
;3797:==================
;3798:*/
;3799:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 3803
;3800:	gentity_t *ent;
;3801:	int i;
;3802:
;3803:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 3804
;3804:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1595
JUMPV
LABELV $1592
line 3805
;3805:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1597
line 3806
;3806:			continue;
ADDRGP4 $1593
JUMPV
LABELV $1597
line 3808
;3807:		}
;3808:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1599
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1599
line 3809
;3809:			continue;
ADDRGP4 $1593
JUMPV
LABELV $1599
line 3811
;3810:		}
;3811:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1601
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1601
line 3812
;3812:			continue;
ADDRGP4 $1593
JUMPV
LABELV $1601
line 3814
;3813:		}
;3814:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1603
line 3815
;3815:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1605
line 3816
;3816:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1605
line 3817
;3817:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1607
line 3818
;3818:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1607
line 3819
;3819:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $1591
JUMPV
LABELV $1603
line 3821
;3820:		}
;3821:	}
LABELV $1593
line 3804
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $1595
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1592
line 3822
;3822:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1609
line 3823
;3823:		VectorClear(mins);
ADDRFP4 12
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $1609
line 3824
;3824:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1611
line 3825
;3825:		VectorClear(maxs);
ADDRFP4 16
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $1611
line 3826
;3826:	return 0;
CNSTI4 0
RETI4
LABELV $1591
endproc BotModelMinsMaxs 40 0
data
align 4
LABELV $1614
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $1615
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 628 28
line 3834
;3827:}
;3828:
;3829:/*
;3830:==================
;3831:BotFuncButtonGoal
;3832:==================
;3833:*/
;3834:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3840
;3835:	int i, areas[10], numareas, modelindex, entitynum;
;3836:	char model[128];
;3837:	float lip, dist, health, angle;
;3838:	vec3_t size, start, end, mins, maxs, angles, points[10];
;3839:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;3840:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $1614
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $1615
INDIRB
ASGNB 12
line 3843
;3841:	bsp_trace_t bsptrace;
;3842:
;3843:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3844
;3844:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 3846
;3845:	//create a bot goal towards the button
;3846:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3847
;3847:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1616
line 3848
;3848:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1616
line 3849
;3849:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 560
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 560
INDIRI4
ASGNI4
line 3850
;3850:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $1619
line 3851
;3851:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1619
line 3852
;3852:	VectorClear(angles);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
CNSTF4 0
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3853
;3853:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 564
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 564
INDIRI4
ASGNI4
line 3855
;3854:	//get the lip of the button
;3855:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1623
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3856
;3856:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $1624
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $1624
line 3858
;3857:	//get the move direction from the angle
;3858:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1626
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3859
;3859:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3860
;3860:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 3862
;3861:	//button size
;3862:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3864
;3863:	//button origin
;3864:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 3865
;3865:	VectorScale(origin, 0.5, origin);
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3867
;3866:	//touch distance of the button
;3867:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 568
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 572
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 576
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 568
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 572
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 576
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3868
;3868:	dist *= 0.5;
ADDRLP4 28
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3870
;3869:	//
;3870:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $1649
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3872
;3871:	//if the button is shootable
;3872:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $1650
line 3874
;3873:		//calculate the shoot target
;3874:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3876
;3875:		//
;3876:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 3877
;3877:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3879
;3878:		//
;3879:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 584
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 584
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 584
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3881
;3880:		// if the button is visible from the current position
;3881:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $1662
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $1658
LABELV $1662
line 3883
;3882:			//
;3883:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3884
;3884:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3885
;3885:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3886
;3886:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3887
;3887:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3888
;3888:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3889
;3889:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3891
;3890:			//
;3891:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1658
line 3893
;3892:		}
;3893:		else {
line 3896
;3894:			//create a goal from where the button is visible and shoot at the button from there
;3895:			//add bounding box size to the dist
;3896:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3897
;3897:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1663
line 3898
;3898:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1667
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1668
JUMPV
LABELV $1667
line 3899
;3899:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1668
line 3900
;3900:			}
LABELV $1664
line 3897
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1663
line 3902
;3901:			//calculate the goal origin
;3902:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 588
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3904
;3903:			//
;3904:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3905
;3905:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3906
;3906:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3907
;3907:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 3908
;3908:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 592
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 592
INDIRI4
ASGNI4
line 3910
;3909:			//
;3910:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1680
JUMPV
LABELV $1677
line 3911
;3911:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 596
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 596
INDIRI4
CNSTI4 0
EQI4 $1681
line 3912
;3912:					break;
ADDRGP4 $1679
JUMPV
LABELV $1681
line 3914
;3913:				}
;3914:			}
LABELV $1678
line 3910
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1680
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1677
LABELV $1679
line 3915
;3915:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1683
line 3917
;3916:				// FIXME: trace forward and maybe in other directions to find a valid area
;3917:			}
LABELV $1683
line 3918
;3918:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1685
line 3920
;3919:				//
;3920:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 3921
;3921:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3922
;3922:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 3923
;3923:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 3925
;3924:				//
;3925:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1687
line 3926
;3926:				{
line 3927
;3927:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1691
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 608
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 608
INDIRP4
ADDRLP4 608
INDIRP4
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1692
JUMPV
LABELV $1691
line 3928
;3928:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 624
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 624
INDIRP4
ADDRLP4 624
INDIRP4
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1692
line 3929
;3929:				} //end for
LABELV $1688
line 3925
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1687
line 3931
;3930:				//
;3931:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3932
;3932:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3933
;3933:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3934
;3934:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1685
line 3936
;3935:			}
;3936:		}
line 3937
;3937:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1650
line 3939
;3938:	}
;3939:	else {
line 3941
;3940:		//add bounding box size to the dist
;3941:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3942
;3942:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1693
line 3943
;3943:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1697
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 580
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1698
JUMPV
LABELV $1697
line 3944
;3944:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1698
line 3945
;3945:		}
LABELV $1694
line 3942
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1693
line 3947
;3946:		//calculate the goal origin
;3947:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3949
;3948:		//
;3949:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3950
;3950:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3951
;3951:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3952
;3952:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3953
;3953:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 584
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 584
INDIRI4
ASGNI4
line 3955
;3954:		//
;3955:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1710
JUMPV
LABELV $1707
line 3956
;3956:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 588
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $1711
line 3957
;3957:				break;
ADDRGP4 $1709
JUMPV
LABELV $1711
line 3959
;3958:			}
;3959:		}
LABELV $1708
line 3955
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1710
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $1707
LABELV $1709
line 3960
;3960:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $1713
line 3962
;3961:			//
;3962:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3963
;3963:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3964
;3964:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3965
;3965:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3967
;3966:			//
;3967:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1723
line 3968
;3968:			{
line 3969
;3969:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1727
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 600
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 600
INDIRP4
ADDRLP4 600
INDIRP4
INDIRF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $1728
JUMPV
LABELV $1727
line 3970
;3970:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 616
INDIRP4
ADDRLP4 616
INDIRP4
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $1728
line 3971
;3971:			} //end for
LABELV $1724
line 3967
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1723
line 3973
;3972:			//
;3973:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3974
;3974:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3975
;3975:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3976
;3976:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1613
JUMPV
LABELV $1713
line 3978
;3977:		}
;3978:	}
line 3979
;3979:	return qfalse;
CNSTI4 0
RETI4
LABELV $1613
endproc BotFuncButtonActivateGoal 628 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1076 20
line 3987
;3980:}
;3981:
;3982:/*
;3983:==================
;3984:BotFuncDoorGoal
;3985:==================
;3986:*/
;3987:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3993
;3988:	int modelindex, entitynum;
;3989:	char model[MAX_INFO_STRING];
;3990:	vec3_t mins, maxs, origin;
;3991:
;3992:	//shoot at the shootable door
;3993:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3994
;3994:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1730
line 3995
;3995:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1730
line 3996
;3996:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1068
INDIRI4
ASGNI4
line 3997
;3997:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1733
line 3998
;3998:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1733
line 4000
;3999:
;4000:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1072
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1072
INDIRI4
ASGNI4
line 4002
;4001:	//door origin
;4002:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 4003
;4003:	VectorScale(origin, 0.5, origin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4004
;4004:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 4005
;4005:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 4007
;4006:	//
;4007:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1064
INDIRI4
ASGNI4
line 4008
;4008:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4009
;4009:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4010
;4010:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4011
;4011:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 4012
;4012:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 4013
;4013:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 4014
;4014:	return qtrue;
CNSTI4 1
RETI4
LABELV $1729
endproc BotFuncDoorActivateGoal 1076 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 272 20
line 4022
;4015:}
;4016:
;4017:/*
;4018:==================
;4019:BotTriggerMultipleGoal
;4020:==================
;4021:*/
;4022:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4028
;4023:	int i, areas[10], numareas, modelindex, entitynum;
;4024:	char model[128];
;4025:	vec3_t start, end, mins, maxs;
;4026:	vec3_t origin, goalorigin;
;4027:
;4028:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4029
;4029:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 4031
;4030:	//create a bot goal towards the trigger
;4031:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4032
;4032:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1746
line 4033
;4033:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1745
JUMPV
LABELV $1746
line 4034
;4034:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 256
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 256
INDIRI4
ASGNI4
line 4035
;4035:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $1749
line 4036
;4036:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1745
JUMPV
LABELV $1749
line 4037
;4037:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 260
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 260
INDIRI4
ASGNI4
line 4039
;4038:	//trigger origin
;4039:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 4040
;4040:	VectorScale(origin, 0.5, origin);
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4041
;4041:	VectorCopy(origin, goalorigin);
ADDRLP4 240
ADDRLP4 4
INDIRB
ASGNB 12
line 4043
;4042:	//
;4043:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 240
INDIRB
ASGNB 12
line 4044
;4044:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4045
;4045:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 4046
;4046:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4047
;4047:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 264
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 264
INDIRI4
ASGNI4
line 4049
;4048:	//
;4049:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1766
JUMPV
LABELV $1763
line 4050
;4050:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $1767
line 4051
;4051:			break;
ADDRGP4 $1765
JUMPV
LABELV $1767
line 4053
;4052:		}
;4053:	}
LABELV $1764
line 4049
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1766
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1763
LABELV $1765
line 4054
;4054:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $1769
line 4055
;4055:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4056
;4056:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 4057
;4057:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4058
;4058:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4060
;4059:		//
;4060:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 252
INDIRI4
ASGNI4
line 4061
;4061:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4062
;4062:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4063
;4063:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1745
JUMPV
LABELV $1769
line 4065
;4064:	}
;4065:	return qfalse;
CNSTI4 0
RETI4
LABELV $1745
endproc BotTriggerMultipleActivateGoal 272 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 4073
;4066:}
;4067:
;4068:/*
;4069:==================
;4070:BotPopFromActivateGoalStack
;4071:==================
;4072:*/
;4073:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 4074
;4074:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1780
line 4075
;4075:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1779
JUMPV
LABELV $1780
line 4076
;4076:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4077
;4077:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 4078
;4078:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4079
;4079:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4080
;4080:	return qtrue;
CNSTI4 1
RETI4
LABELV $1779
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 20 12
line 4088
;4081:}
;4082:
;4083:/*
;4084:==================
;4085:BotPushOntoActivateGoalStack
;4086:==================
;4087:*/
;4088:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4092
;4089:	int i, best;
;4090:	float besttime;
;4091:
;4092:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 4093
;4093:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 4095
;4094:	//
;4095:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1783
line 4096
;4096:		if (!bs->activategoalheap[i].inuse) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1787
line 4097
;4097:			if (bs->activategoalheap[i].justused_time < besttime) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $1789
line 4098
;4098:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 4099
;4099:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4100
;4100:			}
LABELV $1789
line 4101
;4101:		}
LABELV $1787
line 4102
;4102:	}
LABELV $1784
line 4095
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $1783
line 4103
;4103:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1791
line 4104
;4104:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 244
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4105
;4105:		bs->activategoalheap[best].inuse = qtrue;
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4106
;4106:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
line 4107
;4107:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ASGNP4
line 4108
;4108:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1782
JUMPV
LABELV $1791
line 4110
;4109:	}
;4110:	return qfalse;
CNSTI4 0
RETI4
LABELV $1782
endproc BotPushOntoActivateGoalStack 20 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4118
;4111:}
;4112:
;4113:/*
;4114:==================
;4115:BotClearActivateGoalStack
;4116:==================
;4117:*/
;4118:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $1795
JUMPV
LABELV $1794
line 4120
;4119:	while(bs->activatestack)
;4120:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $1795
line 4119
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1794
line 4121
;4121:}
LABELV $1793
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4128
;4122:
;4123:/*
;4124:==================
;4125:BotEnableActivateGoalAreas
;4126:==================
;4127:*/
;4128:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4131
;4129:	int i;
;4130:
;4131:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1801
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $1802
JUMPV
LABELV $1801
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1802
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1798
line 4132
;4132:		return;
ADDRGP4 $1797
JUMPV
LABELV $1798
line 4133
;4133:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1806
JUMPV
LABELV $1803
line 4134
;4134:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $1804
line 4133
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1806
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $1803
line 4135
;4135:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1808
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $1809
JUMPV
LABELV $1808
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1809
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4136
;4136:}
LABELV $1797
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4143
;4137:
;4138:/*
;4139:==================
;4140:BotIsGoingToActivateEntity
;4141:==================
;4142:*/
;4143:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4147
;4144:	bot_activategoal_t *a;
;4145:	int i;
;4146:
;4147:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $1814
JUMPV
LABELV $1811
line 4148
;4148:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1815
line 4149
;4149:			continue;
ADDRGP4 $1812
JUMPV
LABELV $1815
line 4150
;4150:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1817
line 4151
;4151:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1810
JUMPV
LABELV $1817
line 4152
;4152:	}
LABELV $1812
line 4147
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $1814
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1811
line 4153
;4153:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1819
line 4154
;4154:		if (bs->activategoalheap[i].inuse)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1823
line 4155
;4155:			continue;
ADDRGP4 $1820
JUMPV
LABELV $1823
line 4157
;4156:		//
;4157:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1825
line 4159
;4158:			// if the bot went for this goal less than 2 seconds ago
;4159:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $1827
line 4160
;4160:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1810
JUMPV
LABELV $1827
line 4161
;4161:		}
LABELV $1825
line 4162
;4162:	}
LABELV $1820
line 4153
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $1819
line 4163
;4163:	return qfalse;
CNSTI4 0
RETI4
LABELV $1810
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3304 20
line 4176
;4164:}
;4165:
;4166:/*
;4167:==================
;4168:BotGetActivateGoal
;4169:
;4170:  returns the number of the bsp entity to activate
;4171:  goal->entitynum will be set to the game entity to activate
;4172:==================
;4173:*/
;4174://#define OBSTACLEDEBUG
;4175:
;4176:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4186
;4177:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;4178:	char model[MAX_INFO_STRING], tmpmodel[128];
;4179:	char target[128], classname[128];
;4180:	float health;
;4181:	char targetname[10][128];
;4182:	aas_entityinfo_t entinfo;
;4183:	aas_areainfo_t areainfo;
;4184:	vec3_t origin, absmins, absmaxs;
;4185:
;4186:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4187
;4187:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4188
;4188:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $1830
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4189
;4189:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3240
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3240
INDIRI4
ASGNI4
ADDRGP4 $1835
JUMPV
LABELV $1832
line 4190
;4190:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3244
INDIRI4
CNSTI4 0
NEI4 $1836
ADDRGP4 $1833
JUMPV
LABELV $1836
line 4191
;4191:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $1838
ADDRGP4 $1834
JUMPV
LABELV $1838
line 4192
;4192:	}
LABELV $1833
line 4189
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3244
INDIRI4
ASGNI4
LABELV $1835
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1832
LABELV $1834
line 4193
;4193:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1840
line 4194
;4194:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1842
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4195
;4195:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1840
line 4197
;4196:	}
;4197:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1843
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4198
;4198:	if (!*classname) {
ADDRLP4 1456
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1844
line 4199
;4199:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1846
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4200
;4200:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1844
line 4203
;4201:	}
;4202:	//if it is a door
;4203:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1849
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $1847
line 4204
;4204:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1649
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3252
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
EQI4 $1850
line 4206
;4205:			//if the door has health then the door must be shot to open
;4206:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $1852
line 4207
;4207:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4208
;4208:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1852
line 4210
;4209:			}
;4210:		}
LABELV $1850
line 4212
;4211:		//
;4212:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1854
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4214
;4213:		// if the door starts open then just wait for the door to return
;4214:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1855
line 4215
;4215:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1855
line 4217
;4216:		//get the door origin
;4217:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1859
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3256
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $1857
line 4218
;4218:			VectorClear(origin);
ADDRLP4 3192
CNSTF4 0
ASGNF4
ADDRLP4 3192+4
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
CNSTF4 0
ASGNF4
line 4219
;4219:		}
LABELV $1857
line 4221
;4220:		//if the door is open or opening already
;4221:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3260
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $1862
line 4222
;4222:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1862
line 4224
;4223:		// store all the areas the door is in
;4224:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4225
;4225:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1865
line 4226
;4226:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3264
INDIRI4
ASGNI4
line 4227
;4227:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $1868
line 4228
;4228:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4230
;4229:				//
;4230:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3268
INDIRI4
ASGNI4
line 4232
;4231:				// store the areas with reachabilities first
;4232:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1873
JUMPV
LABELV $1870
line 4233
;4233:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1874
line 4234
;4234:						break;
ADDRGP4 $1872
JUMPV
LABELV $1874
line 4235
;4235:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $1876
line 4236
;4236:						continue;
ADDRGP4 $1871
JUMPV
LABELV $1876
line 4238
;4237:					}
;4238:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4239
;4239:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1878
line 4240
;4240:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4241
;4241:					}
LABELV $1878
line 4242
;4242:				}
LABELV $1871
line 4232
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1873
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $1870
LABELV $1872
line 4244
;4243:				// store any remaining areas
;4244:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1883
JUMPV
LABELV $1880
line 4245
;4245:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $1884
line 4246
;4246:						break;
ADDRGP4 $1882
JUMPV
LABELV $1884
line 4247
;4247:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
EQI4 $1886
line 4248
;4248:						continue;
ADDRGP4 $1881
JUMPV
LABELV $1886
line 4250
;4249:					}
;4250:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4251
;4251:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1888
line 4252
;4252:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4253
;4253:					}
LABELV $1888
line 4254
;4254:				}
LABELV $1881
line 4244
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1883
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $1880
LABELV $1882
line 4255
;4255:			}
LABELV $1868
line 4256
;4256:		}
LABELV $1865
line 4257
;4257:	}
LABELV $1847
line 4259
;4258:	// if the bot is blocked by or standing on top of a button
;4259:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1892
ARGP4
ADDRLP4 3252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
NEI4 $1890
line 4260
;4260:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1890
line 4263
;4261:	}
;4262:	// get the targetname so we can find an entity with a matching target
;4263:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1895
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $1893
line 4264
;4264:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1896
line 4265
;4265:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $1899
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4266
;4266:		}
LABELV $1896
line 4267
;4267:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1893
line 4270
;4268:	}
;4269:	// allow tree-like activation
;4270:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3260
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3260
INDIRI4
ASGNI4
line 4271
;4271:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1903
JUMPV
LABELV $1900
line 4272
;4272:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $1907
JUMPV
LABELV $1904
line 4273
;4273:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1910
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $1908
ADDRGP4 $1905
JUMPV
LABELV $1908
line 4274
;4274:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $1911
line 4275
;4275:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3272
INDIRI4
ASGNI4
line 4276
;4276:				break;
ADDRGP4 $1906
JUMPV
LABELV $1911
line 4278
;4277:			}
;4278:		}
LABELV $1905
line 4272
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3264
INDIRI4
ASGNI4
LABELV $1907
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1904
LABELV $1906
line 4279
;4279:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1913
line 4280
;4280:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1915
line 4281
;4281:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $1918
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4282
;4282:			}
LABELV $1915
line 4283
;4283:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4284
;4284:			continue;
ADDRGP4 $1901
JUMPV
LABELV $1913
line 4286
;4285:		}
;4286:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1843
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $1919
line 4287
;4287:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $1901
line 4288
;4288:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $1924
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4289
;4289:			}
line 4290
;4290:			continue;
ADDRGP4 $1901
JUMPV
LABELV $1919
line 4293
;4291:		}
;4292:		// BSP button model
;4293:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1892
ARGP4
ADDRLP4 3272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $1925
line 4295
;4294:			//
;4295:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3276
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $1927
line 4296
;4296:				continue;
ADDRGP4 $1901
JUMPV
LABELV $1927
line 4298
;4297:			// if the bot tries to activate this button already
;4298:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1929
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1929
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $1929
ADDRLP4 3284
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
LEF4 $1929
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $1929
line 4302
;4299:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4300:				 bs->activatestack->time > FloatTime() &&
;4301:				 bs->activatestack->start_time < FloatTime() - 2)
;4302:				continue;
ADDRGP4 $1901
JUMPV
LABELV $1929
line 4304
;4303:			// if the bot is in a reachability area
;4304:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
EQI4 $1931
line 4306
;4305:				// disable all areas the blocking entity is in
;4306:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4308
;4307:				//
;4308:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3296
INDIRI4
ASGNI4
line 4310
;4309:				// if the button is not reachable
;4310:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $1933
line 4311
;4311:					continue;
ADDRGP4 $1901
JUMPV
LABELV $1933
line 4313
;4312:				}
;4313:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4314
;4314:			}
LABELV $1931
line 4315
;4315:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1925
line 4318
;4316:		}
;4317:		// invisible trigger multiple box
;4318:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1937
ARGP4
ADDRLP4 3276
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $1935
line 4320
;4319:			//
;4320:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3280
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $1938
line 4321
;4321:				continue;
ADDRGP4 $1901
JUMPV
LABELV $1938
line 4323
;4322:			// if the bot tries to activate this trigger already
;4323:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1940
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1940
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $1940
ADDRLP4 3288
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
LEF4 $1940
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $1940
line 4327
;4324:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4325:				 bs->activatestack->time > FloatTime() &&
;4326:				 bs->activatestack->start_time < FloatTime() - 2)
;4327:				continue;
ADDRGP4 $1901
JUMPV
LABELV $1940
line 4329
;4328:			// if the bot is in a reachability area
;4329:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $1942
line 4331
;4330:				// disable all areas the blocking entity is in
;4331:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4333
;4332:				//
;4333:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3300
INDIRI4
ASGNI4
line 4335
;4334:				// if the trigger is not reachable
;4335:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $1944
line 4336
;4336:					continue;
ADDRGP4 $1901
JUMPV
LABELV $1944
line 4338
;4337:				}
;4338:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4339
;4339:			}
LABELV $1942
line 4340
;4340:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1935
line 4342
;4341:		}
;4342:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1948
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $1946
line 4344
;4343:			// just skip the func_timer
;4344:			continue;
ADDRGP4 $1901
JUMPV
LABELV $1946
line 4347
;4345:		}
;4346:		// the actual button or trigger might be linked through a target_relay or target_delay
;4347:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $1951
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
EQI4 $1953
ADDRLP4 1456
ARGP4
ADDRGP4 $1952
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $1949
LABELV $1953
line 4348
;4348:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1895
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $1954
line 4349
;4349:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4350
;4350:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3296
INDIRI4
ASGNI4
line 4351
;4351:			}
LABELV $1954
line 4352
;4352:		}
LABELV $1949
line 4353
;4353:	}
LABELV $1901
line 4271
LABELV $1903
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $1957
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $1900
LABELV $1957
line 4357
;4354:#ifdef OBSTACLEDEBUG
;4355:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4356:#endif
;4357:	return 0;
CNSTI4 0
RETI4
LABELV $1829
endproc BotGetActivateGoal 3304 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4365
;4358:}
;4359:
;4360:/*
;4361:==================
;4362:BotGoForActivateGoal
;4363:==================
;4364:*/
;4365:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4368
;4366:	aas_entityinfo_t activateinfo;
;4367:
;4368:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4369
;4369:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1959
line 4370
;4370:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $1959
line 4371
;4371:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4372
;4372:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4373
;4373:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4375
;4374:	//
;4375:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1962
line 4377
;4376:		// enter the activate entity AI node
;4377:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1964
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4378
;4378:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1958
JUMPV
LABELV $1962
line 4380
;4379:	}
;4380:	else {
line 4382
;4381:		// enable any routing areas that were disabled
;4382:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4383
;4383:		return qfalse;
CNSTI4 0
RETI4
LABELV $1958
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4392
;4384:	}
;4385:}
;4386:
;4387:/*
;4388:==================
;4389:BotPrintActivateGoalInfo
;4390:==================
;4391:*/
;4392:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4397
;4393:	char netname[MAX_NETNAME];
;4394:	char classname[128];
;4395:	char buf[128];
;4396:
;4397:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 4398
;4398:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1843
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4399
;4399:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1966
line 4400
;4400:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1968
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4406
;4401:						netname, classname,
;4402:						activategoal->goal.origin[0],
;4403:						activategoal->goal.origin[1],
;4404:						activategoal->goal.origin[2],
;4405:						activategoal->goal.areanum);
;4406:	}
ADDRGP4 $1967
JUMPV
LABELV $1966
line 4407
;4407:	else {
line 4408
;4408:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $1969
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4414
;4409:						netname, classname,
;4410:						activategoal->goal.origin[0],
;4411:						activategoal->goal.origin[1],
;4412:						activategoal->goal.origin[2],
;4413:						activategoal->goal.areanum);
;4414:	}
LABELV $1967
line 4415
;4415:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4416
;4416:}
LABELV $1965
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 28 16
line 4423
;4417:
;4418:/*
;4419:==================
;4420:BotRandomMove
;4421:==================
;4422:*/
;4423:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4426
;4424:	vec3_t dir, angles;
;4425:
;4426:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4427
;4427:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1010041192
MULF4
ASGNF4
line 4428
;4428:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4429
;4429:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4431
;4430:
;4431:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4433
;4432:
;4433:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4434
;4434:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4435
;4435:}
LABELV $1970
endproc BotRandomMove 28 16
data
align 4
LABELV $1974
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 468 16
line 4448
;4436:
;4437:/*
;4438:==================
;4439:BotAIBlocked
;4440:
;4441:Very basic handling of bots being blocked by other entities.
;4442:Check what kind of entity is blocking the bot and try to activate
;4443:it. If that's not an option then try to walk around or over the entity.
;4444:Before the bot ends in this part of the AI it should predict which doors to
;4445:open, which buttons to activate etc.
;4446:==================
;4447:*/
;4448:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4450
;4449:	int movetype, bspent;
;4450:	vec3_t hordir, start, /*end, mins, maxs,*/ sideward, angles, up = {0, 0, 1};
ADDRLP4 192
ADDRGP4 $1974
INDIRB
ASGNB 12
line 4455
;4451:	aas_entityinfo_t entinfo;
;4452:	bot_activategoal_t activategoal;
;4453:
;4454:	// if the bot is not blocked by anything
;4455:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1975
line 4456
;4456:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4457
;4457:		return;
ADDRGP4 $1973
JUMPV
LABELV $1975
line 4460
;4458:	}
;4459:	// if stuck in a solid area
;4460:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1977
line 4462
;4461:		// move in a random direction in the hope to get out
;4462:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4464
;4463:		//
;4464:		return;
ADDRGP4 $1973
JUMPV
LABELV $1977
line 4467
;4465:	}
;4466:	// get info for the entity that is blocking the bot
;4467:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4473
;4468:#ifdef OBSTACLEDEBUG
;4469:	ClientName(bs->client, netname, sizeof(netname));
;4470:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4471:#endif
;4472:	// if blocked by a bsp model and the bot wants to activate it
;4473:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1979
ADDRLP4 24+104
INDIRI4
CNSTI4 0
LEI4 $1979
ADDRLP4 24+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $1979
line 4475
;4474:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4475:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24+20
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
ADDRLP4 452
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 452
INDIRI4
ASGNI4
line 4476
;4476:		if (bspent) {
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $1984
line 4478
;4477:			//
;4478:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 456
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1986
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1986
line 4479
;4479:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $1986
line 4481
;4480:			// if not already trying to activate this entity
;4481:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204+4+40
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $1988
line 4483
;4482:				//
;4483:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4484
;4484:			}
LABELV $1988
line 4488
;4485:			// if ontop of an obstacle or
;4486:			// if the bot is not in a reachability area it'll still
;4487:			// need some dynamic obstacle avoidance, otherwise return
;4488:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1985
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
EQI4 $1985
line 4490
;4489:				trap_AAS_AreaReachability(bs->areanum))
;4490:				return;
ADDRGP4 $1973
JUMPV
line 4491
;4491:		}
LABELV $1984
line 4492
;4492:		else {
line 4494
;4493:			// enable any routing areas that were disabled
;4494:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 204
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4495
;4495:		}
LABELV $1985
line 4496
;4496:	}
LABELV $1979
line 4498
;4497:	// just some basic dynamic obstacle avoidance code
;4498:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4499
;4499:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4500
;4500:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4502
;4501:	// if no direction just take a random direction
;4502:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 452
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 452
INDIRF4
CNSTF4 1036831949
GEF4 $1996
line 4503
;4503:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 180
CNSTF4 0
ASGNF4
ADDRLP4 456
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 180+4
ADDRLP4 456
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 180+8
CNSTF4 0
ASGNF4
line 4504
;4504:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 180
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4505
;4505:	}
LABELV $1996
line 4509
;4506:	//
;4507:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4508:	//else
;4509:	movetype = MOVE_WALK;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 4512
;4510:	// if there's an obstacle at the bot's feet and head then
;4511:	// the bot might be able to crouch through
;4512:	VectorCopy(bs->origin, start);
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4513
;4513:	start[2] += 18;
ADDRLP4 168+8
ADDRLP4 168+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4521
;4514:	//VectorMA(start, 5, hordir, end);
;4515:	//VectorSet(mins, -16, -16, -24);
;4516:	//VectorSet(maxs, 16, 16, 4);
;4517:	//
;4518:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4519:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4520:	// get the sideward vector
;4521:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 192
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4523
;4522:	//
;4523:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2001
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2001
line 4525
;4524:	// try to crouch straight forward?
;4525:	if (!trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 456
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
NEI4 $2007
line 4527
;4526:		// perform the movement
;4527:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $2009
line 4529
;4528:			// flip the avoid direction flag
;4529:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 464
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 464
INDIRP4
ADDRLP4 464
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4532
;4530:			// flip the direction
;4531:			// VectorNegate(sideward, sideward);
;4532:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 4534
;4533:			// move in the other direction
;4534:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4535
;4535:		}
LABELV $2009
line 4536
;4536:	}
LABELV $2007
line 4538
;4537:	//
;4538:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2017
line 4541
;4539:		// just reset goals and hope the bot will go into another direction?
;4540:		// is this still needed??
;4541:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2019
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2020
JUMPV
LABELV $2019
line 4542
;4542:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2021
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
LABELV $2021
LABELV $2020
line 4543
;4543:	}
LABELV $2017
line 4544
;4544:}
LABELV $1973
endproc BotAIBlocked 468 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 316 44
line 4556
;4545:
;4546:/*
;4547:==================
;4548:BotAIPredictObstacles
;4549:
;4550:Predict the route towards the goal and check if the bot
;4551:will be blocked by certain obstacles. When the bot has obstacles
;4552:on its path the bot should figure out if they can be removed
;4553:by activating certain entities.
;4554:==================
;4555:*/
;4556:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4561
;4557:	int modelnum, entitynum, bspent;
;4558:	bot_activategoal_t activategoal;
;4559:	aas_predictroute_t route;
;4560:
;4561:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2024
line 4562
;4562:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2023
JUMPV
LABELV $2024
line 4565
;4563:
;4564:	// always predict when the goal change or at regular intervals
;4565:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6216
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2027
ADDRLP4 292
INDIRP4
CNSTI4 6212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2027
line 4566
;4566:		bs->predictobstacles_time > FloatTime() - 6) {
line 4567
;4567:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2023
JUMPV
LABELV $2027
line 4569
;4568:	}
;4569:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6216
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4570
;4570:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6212
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4573
;4571:
;4572:	// predict at most 100 areas or 10 seconds ahead
;4573:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4578
;4574:							goal->areanum, bs->tfl, 100, 1000,
;4575:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;4576:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4577:	// if bot has to travel through an area with a mover
;4578:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2029
line 4580
;4579:		// if the bot will run into a mover
;4580:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2030
line 4582
;4581:			//NOTE: this only works with bspc 2.1 or higher
;4582:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
CNSTI4 24
LSHI4
BANDI4
CNSTI4 24
RSHI4
ASGNI4
line 4583
;4583:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2030
line 4585
;4584:				//
;4585:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 300
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 300
INDIRI4
ASGNI4
line 4586
;4586:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2030
line 4588
;4587:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4588:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 304
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 304
INDIRI4
ASGNI4
line 4589
;4589:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2030
line 4591
;4590:						//
;4591:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2042
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2042
line 4592
;4592:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $2042
line 4594
;4593:						// if not already trying to activate this entity
;4594:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $2044
line 4598
;4595:							//
;4596:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4597:							//
;4598:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4599
;4599:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2023
JUMPV
LABELV $2044
line 4601
;4600:						}
;4601:						else {
line 4603
;4602:							// enable any routing areas that were disabled
;4603:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4604
;4604:						}
line 4605
;4605:					}
line 4606
;4606:				}
line 4607
;4607:			}
line 4608
;4608:		}
line 4609
;4609:	}
ADDRGP4 $2030
JUMPV
LABELV $2029
line 4610
;4610:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2048
line 4611
;4611:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2051
line 4613
;4612:			//FIXME: check if the bridge is available to travel over
;4613:		}
LABELV $2051
line 4614
;4614:	}
LABELV $2048
LABELV $2030
line 4615
;4615:	return qfalse;
CNSTI4 0
RETI4
LABELV $2023
endproc BotAIPredictObstacles 316 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1008 48
line 4623
;4616:}
;4617:
;4618:/*
;4619:==================
;4620:BotCheckConsoleMessages
;4621:==================
;4622:*/
;4623:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4631
;4624:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4625:	float chat_reply;
;4626:	int context, handle;
;4627:	bot_consolemessage_t m;
;4628:	bot_match_t match;
;4629:
;4630:	//the name of this bot
;4631:	ClientName(bs->client, botname, sizeof(botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2056
JUMPV
LABELV $2055
line 4633
;4632:	//
;4633:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4635
;4634:		//if the chat state is flooded with messages the bot will read them quickly
;4635:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2058
line 4637
;4636:			//if it is a chat message the bot needs some time to read it
;4637:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2060
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2060
ADDRGP4 $2057
JUMPV
LABELV $2060
line 4638
;4638:		}
LABELV $2058
line 4640
;4639:		//
;4640:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4643
;4641:		//if it is a chat message then don't unify white spaces and don't
;4642:		//replace synonyms in the netname
;4643:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2065
line 4645
;4644:			//
;4645:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2068
line 4646
;4646:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4647
;4647:			}
LABELV $2068
line 4648
;4648:		}
LABELV $2065
line 4650
;4649:		//unify the white spaces in the message
;4650:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4652
;4651:		//replace synonyms in the right context
;4652:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4653
;4653:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4655
;4654:		//if there's no match
;4655:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2074
line 4657
;4656:			//if it is a chat message
;4657:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2077
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2077
line 4659
;4658:				//
;4659:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2081
line 4660
;4660:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4661
;4661:					continue;
ADDRGP4 $2056
JUMPV
LABELV $2081
line 4664
;4662:				}
;4663:				//don't use eliza chats with team messages
;4664:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2084
line 4665
;4665:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4666
;4666:					continue;
ADDRGP4 $2056
JUMPV
LABELV $2084
line 4669
;4667:				}
;4668:				//
;4669:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4670
;4670:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4672
;4671:				//if this is a message from the bot self
;4672:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2087
line 4673
;4673:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4674
;4674:					continue;
ADDRGP4 $2056
JUMPV
LABELV $2087
line 4677
;4675:				}
;4676:				//unify the message
;4677:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4679
;4678:				//
;4679:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4680
;4680:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2089
line 4682
;4681:					//
;4682:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2092
ARGP4
ADDRGP4 $2093
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4684
;4683:					//if bot replies with a chat message
;4684:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 968
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 968
INDIRI4
CNSTI4 0
EQI4 $2094
line 4688
;4685:															NULL, NULL,
;4686:															NULL, NULL,
;4687:															NULL, NULL,
;4688:															botname, netname)) {
line 4689
;4689:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2096
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4690
;4690:					}
ADDRGP4 $2090
JUMPV
LABELV $2094
line 4691
;4691:					else {
line 4692
;4692:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2097
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4693
;4693:					}
line 4694
;4694:				}
ADDRGP4 $2090
JUMPV
LABELV $2089
line 4696
;4695:				//if at a valid chat position and not chatting already and not in teamplay
;4696:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2098
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2098
ADDRLP4 976
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2098
line 4697
;4697:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4698
;4698:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2100
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 944
INDIRF4
GEF4 $2100
line 4700
;4699:						//if bot replies with a chat message
;4700:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 996
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $2102
line 4704
;4701:																NULL, NULL,
;4702:																NULL, NULL,
;4703:																NULL, NULL,
;4704:																botname, netname)) {
line 4706
;4705:							//remove the console message
;4706:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4707
;4707:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
ARGP4
ADDRLP4 1004
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1000
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1004
INDIRF4
ADDF4
ASGNF4
line 4708
;4708:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2104
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4710
;4709:							//EA_Say(bs->client, bs->cs.chatmessage);
;4710:							break;
ADDRGP4 $2057
JUMPV
LABELV $2102
line 4712
;4711:						}
;4712:					}
LABELV $2100
line 4713
;4713:				}
LABELV $2098
LABELV $2090
line 4714
;4714:			}
LABELV $2077
line 4715
;4715:		}
LABELV $2074
line 4717
;4716:		//remove the console message
;4717:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4718
;4718:	}
LABELV $2056
line 4633
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2055
LABELV $2057
line 4719
;4719:}
LABELV $2054
endproc BotCheckConsoleMessages 1008 48
export BotCheckForGrenades
proc BotCheckForGrenades 4 16
line 4726
;4720:
;4721:/*
;4722:==================
;4723:BotCheckEvents
;4724:==================
;4725:*/
;4726:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4728
;4727:	// if this is not a grenade
;4728:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2108
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2106
LABELV $2108
line 4729
;4729:		return;
ADDRGP4 $2105
JUMPV
LABELV $2106
line 4731
;4730:	// try to avoid the grenade
;4731:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4732
;4732:}
LABELV $2105
endproc BotCheckForGrenades 4 16
export BotCheckEvents
proc BotCheckEvents 164 12
line 4784
;4733:
;4734:#ifdef MISSIONPACK
;4735:/*
;4736:==================
;4737:BotCheckForProxMines
;4738:==================
;4739:*/
;4740:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
;4741:	// if this is not a prox mine
;4742:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
;4743:		return;
;4744:	// if this prox mine is from someone on our own team
;4745:	if (state->generic1 == BotTeam(bs))
;4746:		return;
;4747:	// if the bot doesn't have a weapon to deactivate the mine
;4748:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
;4749:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4750:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
;4751:		return;
;4752:	}
;4753:	// try to avoid the prox mine
;4754:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
;4755:	//
;4756:	if (bs->numproxmines >= MAX_PROXMINES)
;4757:		return;
;4758:	bs->proxmines[bs->numproxmines] = state->number;
;4759:	bs->numproxmines++;
;4760:}
;4761:
;4762:/*
;4763:==================
;4764:BotCheckForKamikazeBody
;4765:==================
;4766:*/
;4767:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
;4768:	// if this entity is not wearing the kamikaze
;4769:	if (!(state->eFlags & EF_KAMIKAZE))
;4770:		return;
;4771:	// if this entity isn't dead
;4772:	if (!(state->eFlags & EF_DEAD))
;4773:		return;
;4774:	//remember this kamikaze body
;4775:	bs->kamikazebody = state->number;
;4776:}
;4777:#endif
;4778:
;4779:/*
;4780:==================
;4781:BotCheckEvents
;4782:==================
;4783:*/
;4784:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 4793
;4785:	int event;
;4786:	char buf[128];
;4787:#ifdef MISSIONPACK
;4788:	aas_entityinfo_t entinfo;
;4789:#endif
;4790:
;4791:	//NOTE: this sucks, we're accessing the gentity_t directly
;4792:	//but there's no other fast way to do it right now
;4793:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 132
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
ADDRLP4 132
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
NEI4 $2110
line 4794
;4794:		return;
ADDRGP4 $2109
JUMPV
LABELV $2110
line 4796
;4795:	}
;4796:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 136
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
ADDRLP4 136
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
ASGNI4
line 4798
;4797:	//if it's an event only entity
;4798:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $2114
line 4799
;4799:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 4800
;4800:	}
ADDRGP4 $2115
JUMPV
LABELV $2114
line 4801
;4801:	else {
line 4802
;4802:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 4803
;4803:	}
LABELV $2115
line 4805
;4804:	//
;4805:	switch(event) {
ADDRLP4 140
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 1
LTI4 $2116
ADDRLP4 140
INDIRI4
CNSTI4 76
GTI4 $2116
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2165-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2165
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2117
address $2116
address $2116
address $2150
address $2116
address $2116
address $2151
address $2129
address $2137
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2118
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2116
address $2117
code
LABELV $2118
line 4808
;4806:		//client obituary event
;4807:		case EV_OBITUARY:
;4808:		{
line 4811
;4809:			int target, attacker, mod;
;4810:
;4811:			target = state->otherEntityNum;
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4812
;4812:			attacker = state->otherEntityNum2;
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4813
;4813:			mod = state->eventParm;
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 4815
;4814:			//
;4815:			if (target == bs->client) {
ADDRLP4 144
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2119
line 4816
;4816:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 4817
;4817:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 4819
;4818:				//
;4819:				if (target == attacker ||
ADDRLP4 156
ADDRLP4 144
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $2124
ADDRLP4 156
INDIRI4
CNSTI4 1023
EQI4 $2124
ADDRLP4 156
INDIRI4
CNSTI4 1022
NEI4 $2121
LABELV $2124
line 4821
;4820:					target == ENTITYNUM_NONE ||
;4821:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2122
JUMPV
LABELV $2121
line 4822
;4822:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 0
ASGNI4
LABELV $2122
line 4824
;4823:				//
;4824:				bs->num_deaths++;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4825
;4825:			}
ADDRGP4 $2117
JUMPV
LABELV $2119
line 4827
;4826:			//else if this client was killed by the bot
;4827:			else if (attacker == bs->client) {
ADDRLP4 148
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2125
line 4828
;4828:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 4829
;4829:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 4830
;4830:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6168
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4832
;4831:				//
;4832:				bs->num_kills++;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4833
;4833:			}
ADDRGP4 $2117
JUMPV
LABELV $2125
line 4834
;4834:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 156
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $2117
ADDRLP4 144
INDIRI4
ADDRLP4 156
INDIRI4
NEI4 $2117
line 4835
;4835:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 1
ASGNI4
line 4836
;4836:			}
line 4850
;4837:			//
;4838:#ifdef MISSIONPACK			
;4839:			if (gametype == GT_1FCTF) {
;4840:				//
;4841:				BotEntityInfo(target, &entinfo);
;4842:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;4843:					if (!BotSameTeam(bs, target)) {
;4844:						bs->neutralflagstatus = 3;	//enemy dropped the flag
;4845:						bs->flagstatuschanged = qtrue;
;4846:					}
;4847:				}
;4848:			}
;4849:#endif
;4850:			break;
ADDRGP4 $2117
JUMPV
LABELV $2129
line 4853
;4851:		}
;4852:		case EV_GLOBAL_SOUND:
;4853:		{
line 4854
;4854:			if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2132
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2130
LABELV $2132
line 4855
;4855:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2133
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4856
;4856:				break;
ADDRGP4 $2117
JUMPV
LABELV $2130
line 4858
;4857:			}
;4858:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4878
;4859:			/*
;4860:			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
;4861:				//red flag is returned
;4862:				bs->redflagstatus = 0;
;4863:				bs->flagstatuschanged = qtrue;
;4864:			}
;4865:			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
;4866:				//blue flag is returned
;4867:				bs->blueflagstatus = 0;
;4868:				bs->flagstatuschanged = qtrue;
;4869:			}
;4870:			else*/
;4871:#ifdef MISSIONPACK
;4872:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
;4873:				//the kamikaze respawned so don't avoid it
;4874:				BotDontAvoid(bs, "Kamikaze");
;4875:			}
;4876:			else
;4877:#endif
;4878:				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2136
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2117
line 4880
;4879:				//powerup respawned... go get it
;4880:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 4881
;4881:			}
line 4882
;4882:			break;
ADDRGP4 $2117
JUMPV
LABELV $2137
line 4885
;4883:		}
;4884:		case EV_GLOBAL_TEAM_SOUND:
;4885:		{
line 4886
;4886:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2117
line 4887
;4887:				switch(state->eventParm) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
LTI4 $2117
ADDRLP4 144
INDIRI4
CNSTI4 5
GTI4 $2117
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2149
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2149
address $2143
address $2144
address $2145
address $2146
address $2147
address $2148
code
LABELV $2143
line 4889
;4888:					case GTS_RED_CAPTURE:
;4889:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4890
;4890:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4891
;4891:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4892
;4892:						break; //see BotMatch_CTF
ADDRGP4 $2117
JUMPV
LABELV $2144
line 4894
;4893:					case GTS_BLUE_CAPTURE:
;4894:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4895
;4895:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4896
;4896:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4897
;4897:						break; //see BotMatch_CTF
ADDRGP4 $2117
JUMPV
LABELV $2145
line 4900
;4898:					case GTS_RED_RETURN:
;4899:						//blue flag is returned
;4900:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4901
;4901:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4902
;4902:						break;
ADDRGP4 $2117
JUMPV
LABELV $2146
line 4905
;4903:					case GTS_BLUE_RETURN:
;4904:						//red flag is returned
;4905:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4906
;4906:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4907
;4907:						break;
ADDRGP4 $2117
JUMPV
LABELV $2147
line 4910
;4908:					case GTS_RED_TAKEN:
;4909:						//blue flag is taken
;4910:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 1
ASGNI4
line 4911
;4911:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4912
;4912:						break; //see BotMatch_CTF
ADDRGP4 $2117
JUMPV
LABELV $2148
line 4915
;4913:					case GTS_BLUE_TAKEN:
;4914:						//red flag is taken
;4915:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 4916
;4916:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4917
;4917:						break; //see BotMatch_CTF
line 4919
;4918:				}
;4919:			}
line 4952
;4920:#ifdef MISSIONPACK
;4921:			else if (gametype == GT_1FCTF) {
;4922:				switch(state->eventParm) {
;4923:					case GTS_RED_CAPTURE:
;4924:						bs->neutralflagstatus = 0;
;4925:						bs->flagstatuschanged = qtrue;
;4926:						break;
;4927:					case GTS_BLUE_CAPTURE:
;4928:						bs->neutralflagstatus = 0;
;4929:						bs->flagstatuschanged = qtrue;
;4930:						break;
;4931:					case GTS_RED_RETURN:
;4932:						//flag has returned
;4933:						bs->neutralflagstatus = 0;
;4934:						bs->flagstatuschanged = qtrue;
;4935:						break;
;4936:					case GTS_BLUE_RETURN:
;4937:						//flag has returned
;4938:						bs->neutralflagstatus = 0;
;4939:						bs->flagstatuschanged = qtrue;
;4940:						break;
;4941:					case GTS_RED_TAKEN:
;4942:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;4943:						bs->flagstatuschanged = qtrue;
;4944:						break;
;4945:					case GTS_BLUE_TAKEN:
;4946:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
;4947:						bs->flagstatuschanged = qtrue;
;4948:						break;
;4949:				}
;4950:			}
;4951:#endif
;4952:			break;
ADDRGP4 $2117
JUMPV
LABELV $2150
line 4955
;4953:		}
;4954:		case EV_PLAYER_TELEPORT_IN:
;4955:		{
line 4956
;4956:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4957
;4957:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4958
;4958:			break;
ADDRGP4 $2117
JUMPV
LABELV $2151
line 4961
;4959:		}
;4960:		case EV_GENERAL_SOUND:
;4961:		{
line 4963
;4962:			//if this sound is played on the bot
;4963:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2117
line 4964
;4964:				if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 144
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2156
ADDRLP4 144
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2154
LABELV $2156
line 4965
;4965:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2157
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4966
;4966:					break;
ADDRGP4 $2117
JUMPV
LABELV $2154
line 4969
;4967:				}
;4968:				//check out the sound
;4969:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4971
;4970:				//if falling into a death pit
;4971:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2160
ARGP4
ADDRLP4 148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $2117
line 4973
;4972:					//if the bot has a personal teleporter
;4973:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2117
line 4975
;4974:						//use the holdable item
;4975:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 4976
;4976:					}
line 4977
;4977:				}
line 4978
;4978:			}
line 4979
;4979:			break;
line 5006
;4980:		}
;4981:		case EV_FOOTSTEP:
;4982:		case EV_FOOTSTEP_METAL:
;4983:		case EV_FOOTSPLASH:
;4984:		case EV_FOOTWADE:
;4985:		case EV_SWIM:
;4986:		case EV_FALL_SHORT:
;4987:		case EV_FALL_MEDIUM:
;4988:		case EV_FALL_FAR:
;4989:		case EV_STEP_4:
;4990:		case EV_STEP_8:
;4991:		case EV_STEP_12:
;4992:		case EV_STEP_16:
;4993:		case EV_JUMP_PAD:
;4994:		case EV_JUMP:
;4995:		case EV_TAUNT:
;4996:		case EV_WATER_TOUCH:
;4997:		case EV_WATER_LEAVE:
;4998:		case EV_WATER_UNDER:
;4999:		case EV_WATER_CLEAR:
;5000:		case EV_ITEM_PICKUP:
;5001:		case EV_GLOBAL_ITEM_PICKUP:
;5002:		case EV_NOAMMO:
;5003:		case EV_CHANGE_WEAPON:
;5004:		case EV_FIRE_WEAPON:
;5005:			//FIXME: either add to sound queue or mark player as someone making noise
;5006:			break;
line 5023
;5007:		case EV_USE_ITEM0:
;5008:		case EV_USE_ITEM1:
;5009:		case EV_USE_ITEM2:
;5010:		case EV_USE_ITEM3:
;5011:		case EV_USE_ITEM4:
;5012:		case EV_USE_ITEM5:
;5013:		case EV_USE_ITEM6:
;5014:		case EV_USE_ITEM7:
;5015:		case EV_USE_ITEM8:
;5016:		case EV_USE_ITEM9:
;5017:		case EV_USE_ITEM10:
;5018:		case EV_USE_ITEM11:
;5019:		case EV_USE_ITEM12:
;5020:		case EV_USE_ITEM13:
;5021:		case EV_USE_ITEM14:
;5022:		case EV_USE_ITEM15:
;5023:			break;
LABELV $2116
LABELV $2117
line 5025
;5024:	}
;5025:}
LABELV $2109
endproc BotCheckEvents 164 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 5032
;5026:
;5027:/*
;5028:==================
;5029:BotCheckSnapshot
;5030:==================
;5031:*/
;5032:void BotCheckSnapshot(bot_state_t *bs) {
line 5037
;5033:	int ent;
;5034:	entityState_t state;
;5035:
;5036:	//remove all avoid spots
;5037:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 5039
;5038:	//reset kamikaze body
;5039:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
CNSTI4 0
ASGNI4
line 5041
;5040:	//reset number of proxmines
;5041:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTI4 0
ASGNI4
line 5043
;5042:	//
;5043:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $2169
JUMPV
LABELV $2168
line 5044
;5044:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 5046
;5045:		//check the entity state for events
;5046:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5048
;5047:		//check for grenades the bot should avoid
;5048:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 5056
;5049:		//
;5050:#ifdef MISSIONPACK
;5051:		//check for proximity mines which the bot should deactivate
;5052:		BotCheckForProxMines(bs, &state);
;5053:		//check for dead bodies with the kamikaze effect which should be gibbed
;5054:		BotCheckForKamikazeBody(bs, &state);
;5055:#endif
;5056:	}
LABELV $2169
line 5044
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $2168
line 5058
;5057:	//check the player state for events
;5058:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 5060
;5059:	//copy the player state events to the entity state
;5060:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5061
;5061:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 5063
;5062:	//
;5063:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5064
;5064:}
LABELV $2167
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 5071
;5065:
;5066:/*
;5067:==================
;5068:BotCheckAir
;5069:==================
;5070:*/
;5071:void BotCheckAir(bot_state_t *bs) {
line 5072
;5072:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5096
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2174
line 5073
;5073:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2176
line 5074
;5074:			return;
ADDRGP4 $2173
JUMPV
LABELV $2176
line 5076
;5075:		}
;5076:	}
LABELV $2174
line 5077
;5077:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6176
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5078
;5078:}
LABELV $2173
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 5085
;5079:
;5080:/*
;5081:==================
;5082:BotAlternateRoute
;5083:==================
;5084:*/
;5085:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 5089
;5086:	int t;
;5087:
;5088:	// if the bot has an alternative route goal
;5089:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2179
line 5091
;5090:		//
;5091:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2181
line 5092
;5092:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2178
JUMPV
LABELV $2181
line 5094
;5093:		// travel time towards alternative route goal
;5094:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5095
;5095:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2183
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2183
line 5097
;5096:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;5097:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5098
;5098:		}
LABELV $2183
line 5099
;5099:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 5100
;5100:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
RETP4
ADDRGP4 $2178
JUMPV
LABELV $2179
line 5102
;5101:	}
;5102:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2178
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 20 0
line 5110
;5103:}
;5104:
;5105:/*
;5106:==================
;5107:BotGetAlternateRouteGoal
;5108:==================
;5109:*/
;5110:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 5115
;5111:	aas_altroutegoal_t *altroutegoals;
;5112:	bot_goal_t *goal;
;5113:	int numaltroutegoals, rnd;
;5114:
;5115:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2186
line 5116
;5116:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 5117
;5117:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 5118
;5118:	}
ADDRGP4 $2187
JUMPV
LABELV $2186
line 5119
;5119:	else {
line 5120
;5120:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 5121
;5121:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 5122
;5122:	}
LABELV $2187
line 5123
;5123:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2188
line 5124
;5124:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2185
JUMPV
LABELV $2188
line 5125
;5125:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5126
;5126:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2190
line 5127
;5127:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2190
line 5128
;5128:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ASGNP4
line 5129
;5129:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 5130
;5130:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5131
;5131:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5132
;5132:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5133
;5133:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5134
;5134:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5135
;5135:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5136
;5136:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5138
;5137:	//
;5138:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
CNSTF4 0
ASGNF4
line 5139
;5139:	return qtrue;
CNSTI4 1
RETI4
LABELV $2185
endproc BotGetAlternateRouteGoal 20 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 0 0
line 5147
;5140:}
;5141:
;5142:/*
;5143:==================
;5144:BotSetupAlternateRouteGoals
;5145:==================
;5146:*/
;5147:void BotSetupAlternativeRouteGoals(void) {
line 5149
;5148:
;5149:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2193
line 5150
;5150:		return;
ADDRGP4 $2192
JUMPV
LABELV $2193
line 5219
;5151:#ifdef MISSIONPACK
;5152:	if (gametype == GT_CTF) {
;5153:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5154:			BotAI_Print(PRT_WARNING, "No alt routes without Neutral Flag\n");
;5155:		if (ctf_neutralflag.areanum) {
;5156:			//
;5157:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5158:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5159:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5160:										red_altroutegoals, MAX_ALTROUTEGOALS,
;5161:										ALTROUTEGOAL_CLUSTERPORTALS|
;5162:										ALTROUTEGOAL_VIEWPORTALS);
;5163:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5164:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5165:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5166:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;5167:										ALTROUTEGOAL_CLUSTERPORTALS|
;5168:										ALTROUTEGOAL_VIEWPORTALS);
;5169:		}
;5170:	}
;5171:	else if (gametype == GT_1FCTF) {
;5172:		//
;5173:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5174:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5175:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5176:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5177:									ALTROUTEGOAL_CLUSTERPORTALS|
;5178:									ALTROUTEGOAL_VIEWPORTALS);
;5179:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5180:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5181:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5182:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5183:									ALTROUTEGOAL_CLUSTERPORTALS|
;5184:									ALTROUTEGOAL_VIEWPORTALS);
;5185:	}
;5186:	else if (gametype == GT_OBELISK) {
;5187:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5188:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5189:		//
;5190:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5191:									neutralobelisk.origin, neutralobelisk.areanum,
;5192:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5193:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5194:									ALTROUTEGOAL_CLUSTERPORTALS|
;5195:									ALTROUTEGOAL_VIEWPORTALS);
;5196:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5197:									neutralobelisk.origin, neutralobelisk.areanum,
;5198:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5199:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5200:									ALTROUTEGOAL_CLUSTERPORTALS|
;5201:									ALTROUTEGOAL_VIEWPORTALS);
;5202:	}
;5203:	else if (gametype == GT_HARVESTER) {
;5204:		//
;5205:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5206:									neutralobelisk.origin, neutralobelisk.areanum,
;5207:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5208:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5209:									ALTROUTEGOAL_CLUSTERPORTALS|
;5210:									ALTROUTEGOAL_VIEWPORTALS);
;5211:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
;5212:									neutralobelisk.origin, neutralobelisk.areanum,
;5213:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5214:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5215:									ALTROUTEGOAL_CLUSTERPORTALS|
;5216:									ALTROUTEGOAL_VIEWPORTALS);
;5217:	}
;5218:#endif
;5219:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5220
;5220:}
LABELV $2192
endproc BotSetupAlternativeRouteGoals 0 0
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 5227
;5221:
;5222:/*
;5223:==================
;5224:BotDeathmatchAI
;5225:==================
;5226:*/
;5227:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5233
;5228:	char gender[144], name[144], buf[144];
;5229:	char userinfo[MAX_INFO_STRING];
;5230:	int i;
;5231:
;5232:	//if the bot has just been setup
;5233:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2196
line 5234
;5234:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5235
;5235:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2198
ADDRGP4 $2195
JUMPV
LABELV $2198
line 5237
;5236:		//get the gender characteristic
;5237:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5239
;5238:		//set the bot gender
;5239:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5240
;5240:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $2200
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 5241
;5241:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5243
;5242:		//set the team
;5243:		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2201
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $2201
line 5244
;5244:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $2204
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5245
;5245:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 5246
;5246:		}
LABELV $2201
line 5248
;5247:		//set the chat gender
;5248:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2205
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2206
JUMPV
LABELV $2205
line 5249
;5249:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2207
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2208
JUMPV
LABELV $2207
line 5250
;5250:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $2208
LABELV $2206
line 5252
;5251:		//set the chat name
;5252:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5253
;5253:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5255
;5254:		//
;5255:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5256
;5256:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5258
;5257:		//
;5258:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 0
ASGNI4
line 5260
;5259:		//
;5260:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5261
;5261:	}
LABELV $2196
line 5263
;5262:	//no ideal view set
;5263:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5265
;5264:	//
;5265:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2209
line 5267
;5266:		//set the teleport time
;5267:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5269
;5268:		//update some inventory values
;5269:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5271
;5270:		//check out the snapshot
;5271:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5273
;5272:		//check for air
;5273:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5274
;5274:	}
LABELV $2209
line 5276
;5275:	//check the console messages
;5276:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5278
;5277:	//if not in the intermission and not in observer mode
;5278:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2211
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $2211
line 5280
;5279:		//do team AI
;5280:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5281
;5281:	}
LABELV $2211
line 5283
;5282:	//if the bot has no ai node
;5283:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2213
line 5284
;5284:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2215
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5285
;5285:	}
LABELV $2213
line 5287
;5286:	//if the bot entered the game less than 8 seconds ago
;5287:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2216
ADDRLP4 1476
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $2216
line 5288
;5288:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $2218
line 5289
;5289:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 5290
;5290:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2220
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5291
;5291:		}
LABELV $2218
line 5292
;5292:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
CNSTI4 1
ASGNI4
line 5293
;5293:	}
LABELV $2216
line 5295
;5294:	//reset the node switches from the previous frame
;5295:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5297
;5296:	//execute AI nodes
;5297:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2221
line 5298
;5298:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $2225
ADDRGP4 $2223
JUMPV
LABELV $2225
line 5299
;5299:	}
LABELV $2222
line 5297
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2221
LABELV $2223
line 5301
;5300:	//if the bot removed itself :)
;5301:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2227
ADDRGP4 $2195
JUMPV
LABELV $2227
line 5303
;5302:	//if the bot executed too many AI nodes
;5303:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2229
line 5304
;5304:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 5305
;5305:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 5306
;5306:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 5307
;5307:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5308
;5308:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $2231
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5309
;5309:	}
LABELV $2229
line 5311
;5310:	//
;5311:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5312
;5312:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5313
;5313:}
LABELV $2195
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5320
;5314:
;5315:/*
;5316:==================
;5317:BotSetEntityNumForGoalWithModel
;5318:==================
;5319:*/
;5320:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5325
;5321:	gentity_t *ent;
;5322:	int i, modelindex;
;5323:	vec3_t dir;
;5324:
;5325:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5326
;5326:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5327
;5327:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2236
JUMPV
LABELV $2233
line 5328
;5328:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2238
line 5329
;5329:			continue;
ADDRGP4 $2234
JUMPV
LABELV $2238
line 5331
;5330:		}
;5331:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2240
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2240
line 5332
;5332:			continue;
ADDRGP4 $2234
JUMPV
LABELV $2240
line 5334
;5333:		}
;5334:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $2242
line 5335
;5335:			continue;
ADDRGP4 $2234
JUMPV
LABELV $2242
line 5337
;5336:		}
;5337:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5338
;5338:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $2246
line 5339
;5339:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5340
;5340:			return;
ADDRGP4 $2232
JUMPV
LABELV $2246
line 5342
;5341:		}
;5342:	}
LABELV $2234
line 5327
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $2236
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2233
line 5343
;5343:}
LABELV $2232
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5350
;5344:
;5345:/*
;5346:==================
;5347:BotSetEntityNumForGoal
;5348:==================
;5349:*/
;5350:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5355
;5351:	gentity_t *ent;
;5352:	int i;
;5353:	vec3_t dir;
;5354:
;5355:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5356
;5356:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2252
JUMPV
LABELV $2249
line 5357
;5357:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2254
line 5358
;5358:			continue;
ADDRGP4 $2250
JUMPV
LABELV $2254
line 5360
;5359:		}
;5360:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2256
line 5361
;5361:			continue;
ADDRGP4 $2250
JUMPV
LABELV $2256
line 5363
;5362:		}
;5363:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5364
;5364:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $2260
line 5365
;5365:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5366
;5366:			return;
ADDRGP4 $2248
JUMPV
LABELV $2260
line 5368
;5367:		}
;5368:	}
LABELV $2250
line 5356
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $2252
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2249
line 5369
;5369:}
LABELV $2248
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5376
;5370:
;5371:/*
;5372:==================
;5373:BotGoalForBSPEntity
;5374:==================
;5375:*/
;5376:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 5381
;5377:	char value[MAX_INFO_STRING];
;5378:	vec3_t origin, start, end;
;5379:	int ent, numareas, areas[10];
;5380:
;5381:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5382
;5382:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $2266
JUMPV
LABELV $2263
line 5383
;5383:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1843
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2267
line 5384
;5384:			continue;
ADDRGP4 $2264
JUMPV
LABELV $2267
line 5385
;5385:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2269
line 5386
;5386:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $1859
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2271
line 5387
;5387:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2262
JUMPV
LABELV $2271
line 5388
;5388:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5389
;5389:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5390
;5390:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5391
;5391:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5392
;5392:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5393
;5393:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5394
;5394:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2275
line 5395
;5395:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2262
JUMPV
LABELV $2275
line 5396
;5396:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5397
;5397:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2262
JUMPV
LABELV $2269
line 5399
;5398:		}
;5399:	}
LABELV $2264
line 5382
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $2266
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2263
line 5400
;5400:	return qfalse;
CNSTI4 0
RETI4
LABELV $2262
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 152 16
line 5408
;5401:}
;5402:
;5403:/*
;5404:==================
;5405:BotSetupDeathmatchAI
;5406:==================
;5407:*/
;5408:void BotSetupDeathmatchAI(void) {
line 5412
;5409:	int ent, modelnum;
;5410:	char model[128];
;5411:
;5412:	gametype = trap_Cvar_VariableIntegerValue( "g_gametype" );
ADDRGP4 $2278
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 5414
;5413:
;5414:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $2279
ARGP4
ADDRGP4 $2093
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5415
;5415:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $2280
ARGP4
ADDRGP4 $2281
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5416
;5416:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $2282
ARGP4
ADDRGP4 $2281
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5417
;5417:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $2283
ARGP4
ADDRGP4 $2281
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5418
;5418:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2092
ARGP4
ADDRGP4 $2281
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5419
;5419:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $2284
ARGP4
ADDRGP4 $2281
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5420
;5420:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $2285
ARGP4
ADDRGP4 $2093
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5421
;5421:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $2286
ARGP4
ADDRGP4 $2287
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5423
;5422:	//
;5423:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2288
line 5424
;5424:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2292
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $2290
line 5425
;5425:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2293
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2290
line 5426
;5426:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2296
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $2294
line 5427
;5427:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2297
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2294
line 5428
;5428:	}
LABELV $2288
line 5459
;5429:#ifdef MISSIONPACK
;5430:	else if (gametype == GT_1FCTF) {
;5431:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
;5432:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
;5433:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
;5434:			BotAI_Print(PRT_WARNING, "One Flag CTF without Red Flag\n");
;5435:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
;5436:			BotAI_Print(PRT_WARNING, "One Flag CTF without Blue Flag\n");
;5437:	}
;5438:	else if (gametype == GT_OBELISK) {
;5439:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5440:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
;5441:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5442:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5443:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
;5444:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5445:	}
;5446:	else if (gametype == GT_HARVESTER) {
;5447:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
;5448:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
;5449:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
;5450:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
;5451:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
;5452:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
;5453:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
;5454:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
;5455:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
;5456:	}
;5457:#endif
;5458:
;5459:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5460
;5460:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 140
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 140
INDIRI4
ASGNI4
ADDRGP4 $2301
JUMPV
LABELV $2298
line 5461
;5461:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $290
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $2302
ADDRGP4 $2299
JUMPV
LABELV $2302
line 5462
;5462:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $2304
line 5463
;5463:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 148
INDIRI4
ASGNI4
line 5464
;5464:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $2307
line 5465
;5465:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $2307
line 5466
;5466:		}
LABELV $2304
line 5467
;5467:	}
LABELV $2299
line 5460
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
LABELV $2301
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2298
line 5469
;5468:	//initialize the waypoint heap
;5469:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5470
;5470:}
LABELV $2277
endproc BotSetupDeathmatchAI 152 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5477
;5471:
;5472:/*
;5473:==================
;5474:BotShutdownDeathmatchAI
;5475:==================
;5476:*/
;5477:void BotShutdownDeathmatchAI(void) {
line 5478
;5478:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5479
;5479:}
LABELV $2309
endproc BotShutdownDeathmatchAI 0 0
import g_clients
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
import mapname
export gametype
align 4
LABELV gametype
skip 4
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import svf_self_portal2
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_TraceCapsule
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Print
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_predictPVS
import g_unlagged
import g_rotation
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_autoJoin
import g_allowVote
import g_blood
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_maxGameClients
import g_cheats
import g_dedicated
import sv_fps
import g_mapname
import g_gametype
import g_entities
import level
import AddTeamScore
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import G_MapExist
import G_LoadMap
import ParseMapRotation
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_ClearClientSessionData
import G_WriteClientSessionData
import G_ReadClientSessionData
import G_InitSessionData
import G_WriteSessionData
import G_InitWorldSession
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import Team_ResetFlags
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_BroadcastServerCommand
import G_Error
import G_Printf
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import MoveClientToIntermission
import DeathmatchScoreboardMessage
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamConnectedCount
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import SpawnTime
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_RevertVote
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $2297
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2296
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2293
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2292
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2287
byte 1 50
byte 1 0
align 1
LABELV $2286
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
LABELV $2285
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2284
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2283
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2282
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2281
byte 1 48
byte 1 0
align 1
LABELV $2280
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2279
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2278
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2231
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2220
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2215
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2204
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2200
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2160
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2157
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2136
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2133
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2104
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2097
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2096
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $2093
byte 1 49
byte 1 0
align 1
LABELV $2092
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $1969
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1968
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1964
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1952
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1951
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1948
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1937
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1924
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1918
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $1910
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1899
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1895
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1892
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1859
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1854
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $1849
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1846
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1843
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1842
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1830
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1649
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $1626
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1623
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1585
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1530
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $675
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $674
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $673
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $672
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $671
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $504
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $290
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $289
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $285
byte 1 110
byte 1 0
align 1
LABELV $284
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 93
byte 1 0
align 1
LABELV $283
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $133
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $132
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
LABELV $69
byte 1 116
byte 1 0
