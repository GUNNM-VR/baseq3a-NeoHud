export BotValidTeamLeader
code
proc BotValidTeamLeader 8 4
file "..\..\..\..\code\game\ai_team.c"
line 57
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_team.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_team.c $
;10: *
;11: *****************************************************************************/
;12:
;13:#include "g_local.h"
;14:#include "botlib.h"
;15:#include "be_aas.h"
;16:#include "be_ea.h"
;17:#include "be_ai_char.h"
;18:#include "be_ai_chat.h"
;19:#include "be_ai_gen.h"
;20:#include "be_ai_goal.h"
;21:#include "be_ai_move.h"
;22:#include "be_ai_weap.h"
;23://
;24:#include "ai_main.h"
;25:#include "ai_dmq3.h"
;26:#include "ai_chat.h"
;27:#include "ai_cmd.h"
;28:#include "ai_dmnet.h"
;29:#include "ai_team.h"
;30:#include "ai_vcmd.h"
;31:
;32:#include "match.h"
;33:
;34:// for the voice chats
;35:#ifdef MISSIONPACK
;36:#include "../../ui/menudef.h"
;37:#endif
;38:#ifdef NEOHUD
;39:#include "../ui/menudef.h"
;40:#endif
;41:
;42://ctf task preferences for a client
;43:typedef struct bot_ctftaskpreference_s
;44:{
;45:	char		name[36];
;46:	int			preference;
;47:} bot_ctftaskpreference_t;
;48:
;49:bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];
;50:
;51:
;52:/*
;53:==================
;54:BotValidTeamLeader
;55:==================
;56:*/
;57:int BotValidTeamLeader(bot_state_t *bs) {
line 58
;58:	if (!strlen(bs->teamleader)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $56
CNSTI4 0
RETI4
ADDRGP4 $55
JUMPV
LABELV $56
line 59
;59:	if (ClientFromName(bs->teamleader) == -1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $58
CNSTI4 0
RETI4
ADDRGP4 $55
JUMPV
LABELV $58
line 60
;60:	return qtrue;
CNSTI4 1
RETI4
LABELV $55
endproc BotValidTeamLeader 8 4
export BotNumTeamMates
proc BotNumTeamMates 1048 12
line 68
;61:}
;62:
;63:/*
;64:==================
;65:BotNumTeamMates
;66:==================
;67:*/
;68:int BotNumTeamMates(bot_state_t *bs) {
line 72
;69:	int i, numplayers;
;70:	char buf[MAX_INFO_STRING];
;71:
;72:	numplayers = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 73
;73:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $61
line 74
;74:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 76
;75:		//if no config string or no name
;76:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $69
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $66
LABELV $69
ADDRGP4 $62
JUMPV
LABELV $66
line 78
;77:		//skip spectators
;78:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $72
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
CNSTI4 3
NEI4 $70
ADDRGP4 $62
JUMPV
LABELV $70
line 80
;79:		//
;80:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $73
line 81
;81:			numplayers++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 82
;82:		}
LABELV $73
line 83
;83:	}
LABELV $62
line 73
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $64
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $61
line 84
;84:	return numplayers;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $60
endproc BotNumTeamMates 1048 12
export BotClientTravelTimeToGoal
proc BotClientTravelTimeToGoal 480 16
line 92
;85:}
;86:
;87:/*
;88:==================
;89:BotClientTravelTimeToGoal
;90:==================
;91:*/
;92:int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
line 96
;93:	playerState_t ps;
;94:	int areanum;
;95:
;96:	BotAI_GetClientState(client, &ps);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 97
;97:	areanum = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 472
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 472
INDIRI4
ASGNI4
line 98
;98:	if (!areanum) return 1;
ADDRLP4 468
INDIRI4
CNSTI4 0
NEI4 $77
CNSTI4 1
RETI4
ADDRGP4 $75
JUMPV
LABELV $77
line 99
;99:	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
RETI4
LABELV $75
endproc BotClientTravelTimeToGoal 480 16
export BotSortTeamMatesByBaseTravelTime
proc BotSortTeamMatesByBaseTravelTime 1336 12
line 107
;100:}
;101:
;102:/*
;103:==================
;104:BotSortTeamMatesByBaseTravelTime
;105:==================
;106:*/
;107:int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {
line 112
;108:
;109:	int i, j, k, numteammates, traveltime;
;110:	char buf[MAX_INFO_STRING];
;111:	int traveltimes[MAX_CLIENTS];
;112:	bot_goal_t *goal = NULL;
ADDRLP4 1300
CNSTP4 0
ASGNP4
line 117
;113:
;114:#ifdef MISSIONPACK
;115:	if (gametype == GT_CTF || gametype == GT_1FCTF)
;116:#else
;117:	if (gametype == GT_CTF)
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $81
line 119
;118:#endif
;119:	{
line 120
;120:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1304
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 1
NEI4 $83
line 121
;121:			goal = &ctf_redflag;
ADDRLP4 1300
ADDRGP4 ctf_redflag
ASGNP4
ADDRGP4 $84
JUMPV
LABELV $83
line 123
;122:		else
;123:			goal = &ctf_blueflag;
ADDRLP4 1300
ADDRGP4 ctf_blueflag
ASGNP4
LABELV $84
line 124
;124:	}
LABELV $81
line 134
;125:#ifdef MISSIONPACK
;126:	else {
;127:		if (BotTeam(bs) == TEAM_RED)
;128:			goal = &redobelisk;
;129:		else
;130:			goal = &blueobelisk;
;131:	}
;132:#endif
;133:
;134:	numteammates = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 135
;135:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 272
CNSTI4 0
ASGNI4
ADDRGP4 $88
JUMPV
LABELV $85
line 136
;136:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 272
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 138
;137:		//if no config string or no name
;138:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 276
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $92
ADDRLP4 276
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1304
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1304
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $90
LABELV $92
ADDRGP4 $86
JUMPV
LABELV $90
line 140
;139:		//skip spectators
;140:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 276
ARGP4
ADDRGP4 $72
ARGP4
ADDRLP4 1308
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 3
NEI4 $93
ADDRGP4 $86
JUMPV
LABELV $93
line 142
;141:		//
;142:		if (BotSameTeam(bs, i) && goal) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1316
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
EQI4 $95
ADDRLP4 1300
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $95
line 144
;143:			//
;144:			traveltime = BotClientTravelTimeToGoal(i, goal);
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1320
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 268
ADDRLP4 1320
INDIRI4
ASGNI4
line 146
;145:			//
;146:			for (j = 0; j < numteammates; j++) {
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 $100
JUMPV
LABELV $97
line 147
;147:				if (traveltime < traveltimes[j]) {
ADDRLP4 268
INDIRI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
GEI4 $101
line 148
;148:					for (k = numteammates; k > j; k--) {
ADDRLP4 0
ADDRLP4 264
INDIRI4
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $103
line 149
;149:						traveltimes[k] = traveltimes[k-1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ASGNI4
line 150
;150:						teammates[k] = teammates[k-1];
ADDRLP4 1332
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1332
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 4
SUBI4
ADDRLP4 1332
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 151
;151:					}
LABELV $104
line 148
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $106
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
GTI4 $103
line 152
;152:					break;
ADDRGP4 $99
JUMPV
LABELV $101
line 154
;153:				}
;154:			}
LABELV $98
line 146
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $100
ADDRLP4 260
INDIRI4
ADDRLP4 264
INDIRI4
LTI4 $97
LABELV $99
line 155
;155:			traveltimes[j] = traveltime;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 156
;156:			teammates[j] = i;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 157
;157:			numteammates++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 158
;158:			if (numteammates >= maxteammates) break;
ADDRLP4 264
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $108
ADDRGP4 $87
JUMPV
LABELV $108
line 159
;159:		}
LABELV $95
line 160
;160:	}
LABELV $86
line 135
ADDRLP4 272
ADDRLP4 272
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $88
ADDRLP4 272
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $85
LABELV $87
line 161
;161:	return numteammates;
ADDRLP4 264
INDIRI4
RETI4
LABELV $80
endproc BotSortTeamMatesByBaseTravelTime 1336 12
export BotSetTeamMateTaskPreference
proc BotSetTeamMateTaskPreference 36 12
line 169
;162:}
;163:
;164:/*
;165:==================
;166:BotSetTeamMateTaskPreference
;167:==================
;168:*/
;169:void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
line 172
;170:	char teammatename[MAX_NETNAME];
;171:
;172:	ctftaskpreferences[teammate].preference = preference;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 173
;173:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 174
;174:	strcpy(ctftaskpreferences[teammate].name, teammatename);
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 175
;175:}
LABELV $110
endproc BotSetTeamMateTaskPreference 36 12
export BotGetTeamMateTaskPreference
proc BotGetTeamMateTaskPreference 40 12
line 182
;176:
;177:/*
;178:==================
;179:BotGetTeamMateTaskPreference
;180:==================
;181:*/
;182:int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
line 185
;183:	char teammatename[MAX_NETNAME];
;184:
;185:	if (!ctftaskpreferences[teammate].preference) return 0;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $113
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $113
line 186
;186:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 187
;187:	if (Q_stricmp(teammatename, ctftaskpreferences[teammate].name)) return 0;
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $116
CNSTI4 0
RETI4
ADDRGP4 $112
JUMPV
LABELV $116
line 188
;188:	return ctftaskpreferences[teammate].preference;
ADDRFP4 4
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
RETI4
LABELV $112
endproc BotGetTeamMateTaskPreference 40 12
export BotSortTeamMatesByTaskPreference
proc BotSortTeamMatesByTaskPreference 800 12
line 196
;189:}
;190:
;191:/*
;192:==================
;193:BotSortTeamMatesByTaskPreference
;194:==================
;195:*/
;196:int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
line 202
;197:	int defenders[MAX_CLIENTS], numdefenders;
;198:	int attackers[MAX_CLIENTS], numattackers;
;199:	int roamers[MAX_CLIENTS], numroamers;
;200:	int i, preference;
;201:
;202:	numdefenders = numattackers = numroamers = 0;
ADDRLP4 788
CNSTI4 0
ASGNI4
ADDRLP4 272
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 788
INDIRI4
ASGNI4
line 203
;203:	for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $123
JUMPV
LABELV $120
line 204
;204:		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 792
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 792
INDIRI4
ASGNI4
line 205
;205:		if (preference & TEAMTP_DEFENDER) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $124
line 206
;206:			defenders[numdefenders++] = teammates[i];
ADDRLP4 796
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 796
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 207
;207:		}
ADDRGP4 $125
JUMPV
LABELV $124
line 208
;208:		else if (preference & TEAMTP_ATTACKER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $126
line 209
;209:			attackers[numattackers++] = teammates[i];
ADDRLP4 796
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 796
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 210
;210:		}
ADDRGP4 $127
JUMPV
LABELV $126
line 211
;211:		else {
line 212
;212:			roamers[numroamers++] = teammates[i];
ADDRLP4 796
ADDRLP4 272
INDIRI4
ASGNI4
ADDRLP4 272
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 796
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 532
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 213
;213:		}
LABELV $127
LABELV $125
line 214
;214:	}
LABELV $121
line 203
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $123
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $120
line 215
;215:	numteammates = 0;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 217
;216:	//defenders at the front of the list
;217:	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
CVIU4 4
CNSTI4 2
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 218
;218:	numteammates += numdefenders;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 220
;219:	//roamers in the middle
;220:	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 532
ARGP4
ADDRLP4 272
INDIRI4
CVIU4 4
CNSTI4 2
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 221
;221:	numteammates += numroamers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 272
INDIRI4
ADDI4
ASGNI4
line 223
;222:	//attacker in the back of the list
;223:	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 268
INDIRI4
CVIU4 4
CNSTI4 2
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 224
;224:	numteammates += numattackers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 268
INDIRI4
ADDI4
ASGNI4
line 226
;225:
;226:	return numteammates;
ADDRFP4 8
INDIRI4
RETI4
LABELV $119
endproc BotSortTeamMatesByTaskPreference 800 12
export BotSayTeamOrderAlways
proc BotSayTeamOrderAlways 548 20
line 234
;227:}
;228:
;229:/*
;230:==================
;231:BotSayTeamOrders
;232:==================
;233:*/
;234:void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
line 240
;235:	char teamchat[MAX_MESSAGE_SIZE];
;236:	char buf[MAX_MESSAGE_SIZE];
;237:	char name[MAX_NETNAME];
;238:
;239:	//if the bot is talking to itself
;240:	if (bs->client == toclient) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $129
line 242
;241:		//don't show the message just put it in the console message queue
;242:		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGetChatMessage
CALLV
pop
line 243
;243:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 244
;244:		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $131
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 245
;245:		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 246
;246:	}
ADDRGP4 $130
JUMPV
LABELV $129
line 247
;247:	else {
line 248
;248:		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 249
;249:	}
LABELV $130
line 250
;250:}
LABELV $128
endproc BotSayTeamOrderAlways 548 20
export BotSayTeamOrder
proc BotSayTeamOrder 0 8
line 257
;251:
;252:/*
;253:==================
;254:BotSayTeamOrders
;255:==================
;256:*/
;257:void BotSayTeamOrder(bot_state_t *bs, int toclient) {
line 264
;258:#ifdef MISSIONPACK //GUNNM I assume this test keep the gameplay identical to q3a
;259:	// voice chats only
;260:	char buf[MAX_MESSAGE_SIZE];
;261:
;262:	trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
;263:#else
;264:	BotSayTeamOrderAlways(bs, toclient);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 266
;265:#endif
;266:}
LABELV $132
endproc BotSayTeamOrder 0 8
export BotVoiceChat
proc BotVoiceChat 8 12
line 273
;267:
;268:/*
;269:==================
;270:BotVoiceChat
;271:==================
;272:*/
;273:void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) {
line 275
;274:#if defined MISSIONPACK || defined NEOHUD
;275:	if (toclient == -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $134
line 277
;276:		// voice only say team
;277:		trap_EA_Command(bs->client, va("vsay_team %s", voicechat));
ADDRGP4 $136
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
ADDRGP4 $135
JUMPV
LABELV $134
line 280
;278:	else
;279:		// voice only tell single player
;280:		trap_EA_Command(bs->client, va("vtell %d %s", toclient, voicechat));
ADDRGP4 $137
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
LABELV $135
line 282
;281:#endif
;282:}
LABELV $133
endproc BotVoiceChat 8 12
export BotVoiceChatOnly
proc BotVoiceChatOnly 8 12
line 289
;283:
;284:/*
;285:==================
;286:BotVoiceChatOnly
;287:==================
;288:*/
;289:void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) {
line 291
;290:#if defined MISSIONPACK || defined NEOHUD
;291:	if (toclient == -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $139
line 293
;292:		// voice only say team
;293:		trap_EA_Command(bs->client, va("vosay_team %s", voicechat));
ADDRGP4 $141
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
ADDRGP4 $140
JUMPV
LABELV $139
line 296
;294:	else
;295:		// voice only tell single player
;296:		trap_EA_Command(bs->client, va("votell %d %s", toclient, voicechat));
ADDRGP4 $142
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
LABELV $140
line 298
;297:#endif
;298:}
LABELV $138
endproc BotVoiceChatOnly 8 12
export BotSayVoiceTeamOrder
proc BotSayVoiceTeamOrder 0 12
line 305
;299:
;300:/*
;301:==================
;302:BotSayVoiceTeamOrder
;303:==================
;304:*/
;305:void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) {
line 307
;306:#if defined MISSIONPACK || defined NEOHUD
;307:	BotVoiceChat(bs, toclient, voicechat);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 309
;308:#endif
;309:}
LABELV $143
endproc BotSayVoiceTeamOrder 0 12
export BotCTFOrders_BothFlagsNotAtBase
proc BotCTFOrders_BothFlagsNotAtBase 364 20
line 316
;310:
;311:/*
;312:==================
;313:BotCTFOrders
;314:==================
;315:*/
;316:void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
line 321
;317:	int numteammates, defenders, attackers, i, other;
;318:	int teammates[MAX_CLIENTS];
;319:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;320:
;321:	memset( teammates, 0, sizeof( teammates ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 322
;322:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 348
INDIRI4
ASGNI4
line 323
;323:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 325
;324:	//different orders based on the number of team mates
;325:	switch(bs->numteammates) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 1
EQI4 $146
ADDRLP4 352
INDIRI4
CNSTI4 2
EQI4 $149
ADDRLP4 352
INDIRI4
CNSTI4 3
EQI4 $155
ADDRGP4 $145
JUMPV
line 326
;326:		case 1: break;
LABELV $149
line 328
;327:		case 2:
;328:		{
line 330
;329:			//tell the one not carrying the flag to attack the enemy base
;330:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
EQI4 $150
ADDRLP4 308
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $151
JUMPV
LABELV $150
line 331
;331:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 0+4
INDIRI4
ASGNI4
LABELV $151
line 332
;332:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 333
;333:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 334
;334:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 336
;335:#if defined MISSIONPACK || defined NEOHUD
;336:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 338
;337:#endif
;338:			break;
ADDRGP4 $146
JUMPV
LABELV $155
line 341
;339:		}
;340:		case 3:
;341:		{
line 343
;342:			//tell the one closest to the base not carrying the flag to accompany the flag carrier
;343:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
EQI4 $156
ADDRLP4 308
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $157
JUMPV
LABELV $156
line 344
;344:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 0+4
INDIRI4
ASGNI4
LABELV $157
line 345
;345:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 346
;346:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $159
line 347
;347:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 348
;348:				if (bs->flagcarrier == bs->client) {
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $161
line 349
;349:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 351
;350:#if defined MISSIONPACK || defined NEOHUD
;351:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 353
;352:#endif
;353:				}
ADDRGP4 $160
JUMPV
LABELV $161
line 354
;354:				else {
line 355
;355:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 357
;356:#if defined MISSIONPACK || defined NEOHUD
;357:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $166
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 359
;358:#endif
;359:				}
line 360
;360:			}
ADDRGP4 $160
JUMPV
LABELV $159
line 361
;361:			else {
line 363
;362:				//
;363:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 365
;364:#if defined MISSIONPACK || defined NEOHUD
;365:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 367
;366:#endif
;367:			}
LABELV $160
line 368
;368:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 370
;369:			//tell the one furthest from the the base not carrying the flag to get the enemy flag
;370:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 0+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
EQI4 $167
ADDRLP4 308
ADDRLP4 0+8
INDIRI4
ASGNI4
ADDRGP4 $168
JUMPV
LABELV $167
line 371
;371:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 0+4
INDIRI4
ASGNI4
LABELV $168
line 372
;372:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 373
;373:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 374
;374:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 376
;375:#if defined MISSIONPACK || defined NEOHUD
;376:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $172
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 378
;377:#endif
;378:			break;
ADDRGP4 $146
JUMPV
LABELV $145
line 381
;379:		}
;380:		default:
;381:		{
line 382
;382:			defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1053609165
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 383
;383:			if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $173
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $173
line 384
;384:			attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 304
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 385
;385:			if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $175
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $175
line 386
;386:			if (bs->flagcarrier != -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $177
line 387
;387:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 388
;388:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $182
JUMPV
LABELV $179
line 390
;389:					//
;390:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $183
line 391
;391:						continue;
ADDRGP4 $180
JUMPV
LABELV $183
line 394
;392:					}
;393:					//
;394:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 395
;395:					if (bs->flagcarrier == bs->client) {
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $185
line 396
;396:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 398
;397:#if defined MISSIONPACK || defined NEOHUD
;398:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 400
;399:#endif
;400:					}
ADDRGP4 $186
JUMPV
LABELV $185
line 401
;401:					else {
line 402
;402:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 404
;403:#if defined MISSIONPACK || defined NEOHUD
;404:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $166
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 406
;405:#endif
;406:					}
LABELV $186
line 407
;407:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 408
;408:				}
LABELV $180
line 388
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $182
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $179
line 409
;409:			}
ADDRGP4 $178
JUMPV
LABELV $177
line 410
;410:			else {
line 411
;411:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $190
JUMPV
LABELV $187
line 413
;412:					//
;413:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $191
line 414
;414:						continue;
ADDRGP4 $188
JUMPV
LABELV $191
line 417
;415:					}
;416:					//
;417:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 418
;418:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 420
;419:#if defined MISSIONPACK || defined NEOHUD
;420:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 422
;421:#endif
;422:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 423
;423:				}
LABELV $188
line 411
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $190
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $187
line 424
;424:			}
LABELV $178
line 425
;425:			for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $196
JUMPV
LABELV $193
line 427
;426:				//
;427:				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $197
line 428
;428:					continue;
ADDRGP4 $194
JUMPV
LABELV $197
line 431
;429:				}
;430:				//
;431:				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 432
;432:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 433
;433:				BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 435
;434:#if defined MISSIONPACK || defined NEOHUD
;435:				BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $172
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 437
;436:#endif
;437:			}
LABELV $194
line 425
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $196
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $193
line 439
;438:			//
;439:			break;
LABELV $146
line 442
;440:		}
;441:	}
;442:}
LABELV $144
endproc BotCTFOrders_BothFlagsNotAtBase 364 20
export BotCTFOrders_FlagNotAtBase
proc BotCTFOrders_FlagNotAtBase 320 16
line 449
;443:
;444:/*
;445:==================
;446:BotCTFOrders
;447:==================
;448:*/
;449:void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
line 454
;450:	int numteammates, defenders, attackers, i;
;451:	int teammates[MAX_CLIENTS];
;452:	char name[MAX_NETNAME];
;453:
;454:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 455
;455:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 457
;456:	//passive strategy
;457:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $204
line 459
;458:		//different orders based on the number of team mates
;459:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $205
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $210
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $215
ADDRGP4 $206
JUMPV
line 460
;460:			case 1: break;
LABELV $210
line 462
;461:			case 2:
;462:			{
line 464
;463:				//both will go for the enemy flag
;464:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 465
;465:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 466
;466:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 468
;467:#if defined MISSIONPACK || defined NEOHUD
;468:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 471
;469:#endif
;470:				//
;471:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 472
;472:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 473
;473:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 475
;474:#if defined MISSIONPACK || defined NEOHUD
;475:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 477
;476:#endif
;477:				break;
ADDRGP4 $205
JUMPV
LABELV $215
line 480
;478:			}
;479:			case 3:
;480:			{
line 482
;481:				//keep one near the base for when the flag is returned
;482:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 483
;483:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 484
;484:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 486
;485:#if defined MISSIONPACK || defined NEOHUD
;486:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 489
;487:#endif
;488:				//the other two get the flag
;489:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 490
;490:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 491
;491:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 493
;492:#if defined MISSIONPACK || defined NEOHUD
;493:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 496
;494:#endif
;495:      			//
;496:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 497
;497:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 498
;498:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 500
;499:#if defined MISSIONPACK || defined NEOHUD
;500:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 502
;501:#endif
;502:				break;
ADDRGP4 $205
JUMPV
LABELV $206
line 505
;503:			}
;504:			default:
;505:			{
line 507
;506:				//keep some people near the base for when the flag is returned
;507:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1050253722
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 508
;508:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $223
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $223
line 509
;509:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1060320051
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 510
;510:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $225
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $225
line 511
;511:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $230
JUMPV
LABELV $227
line 513
;512:					//
;513:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 514
;514:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 515
;515:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 517
;516:#if defined MISSIONPACK || defined NEOHUD
;517:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 519
;518:#endif
;519:				}
LABELV $228
line 511
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $230
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $227
line 520
;520:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $234
JUMPV
LABELV $231
line 522
;521:					//
;522:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 523
;523:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 524
;524:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 526
;525:#if defined MISSIONPACK || defined NEOHUD
;526:					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 528
;527:#endif
;528:				}
LABELV $232
line 520
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $234
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $231
line 530
;529:				//
;530:				break;
line 533
;531:			}
;532:		}
;533:	}
ADDRGP4 $205
JUMPV
LABELV $204
line 534
;534:	else {
line 536
;535:		//different orders based on the number of team mates
;536:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $238
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $241
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $245
ADDRGP4 $237
JUMPV
line 537
;537:			case 1: break;
LABELV $241
line 539
;538:			case 2:
;539:			{
line 541
;540:				//both will go for the enemy flag
;541:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 542
;542:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 543
;543:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 545
;544:#if defined MISSIONPACK || defined NEOHUD
;545:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 548
;546:#endif
;547:				//
;548:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 549
;549:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 550
;550:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 552
;551:#if defined MISSIONPACK || defined NEOHUD
;552:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 554
;553:#endif
;554:				break;
ADDRGP4 $238
JUMPV
LABELV $245
line 557
;555:			}
;556:			case 3:
;557:			{
line 559
;558:				//everyone go for the flag
;559:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 560
;560:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 561
;561:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 563
;562:#if defined MISSIONPACK || defined NEOHUD
;563:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 566
;564:#endif
;565:				//
;566:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 567
;567:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 568
;568:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 570
;569:#if defined MISSIONPACK || defined NEOHUD
;570:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 573
;571:#endif
;572:				//
;573:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 574
;574:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 575
;575:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 577
;576:#if defined MISSIONPACK || defined NEOHUD
;577:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 579
;578:#endif
;579:				break;
ADDRGP4 $238
JUMPV
LABELV $237
line 582
;580:			}
;581:			default:
;582:			{
line 584
;583:				//keep some people near the base for when the flag is returned
;584:				defenders = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 300
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1045220557
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 585
;585:				if (defenders > 2) defenders = 2;
ADDRLP4 300
INDIRI4
CNSTI4 2
LEI4 $252
ADDRLP4 300
CNSTI4 2
ASGNI4
LABELV $252
line 586
;586:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1060320051
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 587
;587:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $254
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $254
line 588
;588:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $259
JUMPV
LABELV $256
line 590
;589:					//
;590:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 591
;591:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 592
;592:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 594
;593:#if defined MISSIONPACK || defined NEOHUD
;594:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 596
;595:#endif
;596:				}
LABELV $257
line 588
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $259
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $256
line 597
;597:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $263
JUMPV
LABELV $260
line 599
;598:					//
;599:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 600
;600:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 601
;601:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 603
;602:#if defined MISSIONPACK || defined NEOHUD
;603:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 605
;604:#endif
;605:				}
LABELV $261
line 597
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $263
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $260
line 607
;606:				//
;607:				break;
LABELV $238
line 610
;608:			}
;609:		}
;610:	}
LABELV $205
line 611
;611:}
LABELV $203
endproc BotCTFOrders_FlagNotAtBase 320 16
export BotCTFOrders_EnemyFlagNotAtBase
proc BotCTFOrders_EnemyFlagNotAtBase 360 20
line 618
;612:
;613:/*
;614:==================
;615:BotCTFOrders
;616:==================
;617:*/
;618:void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
line 623
;619:	int numteammates, defenders, attackers, i, other;
;620:	int teammates[MAX_CLIENTS];
;621:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;622:
;623:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 348
INDIRI4
ASGNI4
line 624
;624:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 626
;625:	//different orders based on the number of team mates
;626:	switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $269
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $271
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $275
ADDRGP4 $268
JUMPV
line 627
;627:		case 1: break;
LABELV $271
line 629
;628:		case 2:
;629:		{
line 631
;630:			//tell the one not carrying the flag to defend the base
;631:			if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $272
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $273
JUMPV
LABELV $272
line 632
;632:			else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $273
line 633
;633:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 634
;634:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 635
;635:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 637
;636:#if defined MISSIONPACK || defined NEOHUD
;637:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 639
;638:#endif
;639:			break;
ADDRGP4 $269
JUMPV
LABELV $275
line 642
;640:		}
;641:		case 3:
;642:		{
line 644
;643:			//tell the one closest to the base not carrying the flag to defend the base
;644:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
EQI4 $276
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $277
JUMPV
LABELV $276
line 645
;645:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $277
line 646
;646:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 647
;647:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 648
;648:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 650
;649:#if defined MISSIONPACK || defined NEOHUD
;650:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 653
;651:#endif
;652:			//tell the other also to defend the base
;653:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
EQI4 $279
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $280
JUMPV
LABELV $279
line 654
;654:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $280
line 655
;655:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 656
;656:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 657
;657:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 659
;658:#if defined MISSIONPACK || defined NEOHUD
;659:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 661
;660:#endif
;661:			break;
ADDRGP4 $269
JUMPV
LABELV $268
line 664
;662:		}
;663:		default:
;664:		{
line 666
;665:			//60% will defend the base
;666:			defenders = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 300
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1058642330
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 667
;667:			if (defenders > 6) defenders = 6;
ADDRLP4 300
INDIRI4
CNSTI4 6
LEI4 $284
ADDRLP4 300
CNSTI4 6
ASGNI4
LABELV $284
line 669
;668:			//30% accompanies the flag carrier
;669:			attackers = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 304
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1050253722
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 670
;670:			if (attackers > 3) attackers = 3;
ADDRLP4 304
INDIRI4
CNSTI4 3
LEI4 $286
ADDRLP4 304
CNSTI4 3
ASGNI4
LABELV $286
line 671
;671:			for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $291
JUMPV
LABELV $288
line 673
;672:				//
;673:				if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $292
line 674
;674:					continue;
ADDRGP4 $289
JUMPV
LABELV $292
line 676
;675:				}
;676:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 677
;677:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 678
;678:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 680
;679:#if defined MISSIONPACK || defined NEOHUD
;680:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 682
;681:#endif
;682:			}
LABELV $289
line 671
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $291
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $288
line 684
;683:			// if we have a flag carrier
;684:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $294
line 685
;685:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 686
;686:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $299
JUMPV
LABELV $296
line 688
;687:					//
;688:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $300
line 689
;689:						continue;
ADDRGP4 $297
JUMPV
LABELV $300
line 692
;690:					}
;691:					//
;692:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 693
;693:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $304
line 694
;694:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 696
;695:#if defined MISSIONPACK || defined NEOHUD
;696:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 698
;697:#endif
;698:					}
ADDRGP4 $305
JUMPV
LABELV $304
line 699
;699:					else {
line 700
;700:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 702
;701:#if defined MISSIONPACK || defined NEOHUD
;702:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $166
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 704
;703:#endif
;704:					}
LABELV $305
line 705
;705:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 706
;706:				}
LABELV $297
line 686
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $299
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $296
line 707
;707:			}
ADDRGP4 $269
JUMPV
LABELV $294
line 708
;708:			else {
line 709
;709:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $312
JUMPV
LABELV $309
line 711
;710:					//
;711:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
NEI4 $313
line 712
;712:						continue;
ADDRGP4 $310
JUMPV
LABELV $313
line 715
;713:					}
;714:					//
;715:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 716
;716:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 718
;717:#if defined MISSIONPACK || defined NEOHUD
;718:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 720
;719:#endif
;720:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 721
;721:				}
LABELV $310
line 709
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $312
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $309
line 722
;722:			}
line 724
;723:			//
;724:			break;
LABELV $269
line 727
;725:		}
;726:	}
;727:}
LABELV $267
endproc BotCTFOrders_EnemyFlagNotAtBase 360 20
export BotCTFOrders_BothFlagsAtBase
proc BotCTFOrders_BothFlagsAtBase 316 16
line 735
;728:
;729:
;730:/*
;731:==================
;732:BotCTFOrders
;733:==================
;734:*/
;735:void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
line 740
;736:	int numteammates, defenders, attackers, i;
;737:	int teammates[MAX_CLIENTS];
;738:	char name[MAX_NETNAME];
;739:
;740:	memset( teammates, 0, sizeof( teammates ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 742
;741:	//sort team mates by travel time to base
;742:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 744
;743:	//sort team mates by CTF preference
;744:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 746
;745:	//passive strategy
;746:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $320
line 748
;747:		//different orders based on the number of team mates
;748:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $321
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $325
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $329
ADDRGP4 $322
JUMPV
line 749
;749:			case 1: break;
LABELV $325
line 751
;750:			case 2:
;751:			{
line 753
;752:				//the one closest to the base will defend the base
;753:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 754
;754:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 755
;755:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 757
;756:#if defined MISSIONPACK || defined NEOHUD
;757:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 760
;758:#endif
;759:				//the other will get the flag
;760:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 761
;761:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 762
;762:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 764
;763:#if defined MISSIONPACK || defined NEOHUD
;764:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 766
;765:#endif
;766:				break;
ADDRGP4 $321
JUMPV
LABELV $329
line 769
;767:			}
;768:			case 3:
;769:			{
line 771
;770:				//the one closest to the base will defend the base
;771:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 772
;772:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 773
;773:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 775
;774:#if defined MISSIONPACK || defined NEOHUD
;775:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 778
;776:#endif
;777:				//the second one closest to the base will defend the base
;778:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 779
;779:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 780
;780:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 782
;781:#if defined MISSIONPACK || defined NEOHUD
;782:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 785
;783:#endif
;784:				//the other will get the flag
;785:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 786
;786:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 787
;787:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 789
;788:#if defined MISSIONPACK || defined NEOHUD
;789:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 791
;790:#endif
;791:				break;
ADDRGP4 $321
JUMPV
LABELV $322
line 794
;792:			}
;793:			default:
;794:			{
line 795
;795:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 300
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 796
;796:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $336
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $336
line 797
;797:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1053609165
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 798
;798:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $338
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $338
line 799
;799:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $343
JUMPV
LABELV $340
line 801
;800:					//
;801:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 802
;802:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 803
;803:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 805
;804:#if defined MISSIONPACK || defined NEOHUD
;805:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 807
;806:#endif
;807:				}
LABELV $341
line 799
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $343
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $340
line 808
;808:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $347
JUMPV
LABELV $344
line 810
;809:					//
;810:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 811
;811:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 812
;812:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 814
;813:#if defined MISSIONPACK || defined NEOHUD
;814:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 816
;815:#endif
;816:				}
LABELV $345
line 808
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $347
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $344
line 818
;817:				//
;818:				break;
line 821
;819:			}
;820:		}
;821:	}
ADDRGP4 $321
JUMPV
LABELV $320
line 822
;822:	else {
line 824
;823:		//different orders based on the number of team mates
;824:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $352
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $354
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $358
ADDRGP4 $351
JUMPV
line 825
;825:			case 1: break;
LABELV $354
line 827
;826:			case 2:
;827:			{
line 829
;828:				//the one closest to the base will defend the base
;829:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 830
;830:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 831
;831:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 833
;832:#if defined MISSIONPACK || defined NEOHUD
;833:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 836
;834:#endif
;835:				//the other will get the flag
;836:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 837
;837:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 838
;838:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 840
;839:#if defined MISSIONPACK || defined NEOHUD
;840:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 842
;841:#endif
;842:				break;
ADDRGP4 $352
JUMPV
LABELV $358
line 845
;843:			}
;844:			case 3:
;845:			{
line 847
;846:				//the one closest to the base will defend the base
;847:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 848
;848:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 849
;849:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 851
;850:#if defined MISSIONPACK || defined NEOHUD
;851:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 854
;852:#endif
;853:				//the others should go for the enemy flag
;854:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 855
;855:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 856
;856:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 858
;857:#if defined MISSIONPACK || defined NEOHUD
;858:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 861
;859:#endif
;860:				//
;861:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 862
;862:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 863
;863:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 865
;864:#if defined MISSIONPACK || defined NEOHUD
;865:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 867
;866:#endif
;867:				break;
ADDRGP4 $352
JUMPV
LABELV $351
line 870
;868:			}
;869:			default:
;870:			{
line 871
;871:				defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1053609165
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 872
;872:				if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $365
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $365
line 873
;873:				attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 304
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 874
;874:				if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $367
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $367
line 875
;875:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $369
line 877
;876:					//
;877:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 878
;878:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $211
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 879
;879:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 881
;880:#if defined MISSIONPACK || defined NEOHUD
;881:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 883
;882:#endif
;883:				}
LABELV $370
line 875
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $372
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $369
line 884
;884:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $373
line 886
;885:					//
;886:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 887
;887:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 888
;888:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 890
;889:#if defined MISSIONPACK || defined NEOHUD
;890:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 892
;891:#endif
;892:				}
LABELV $374
line 884
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $376
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $373
line 894
;893:				//
;894:				break;
LABELV $352
line 897
;895:			}
;896:		}
;897:	}
LABELV $321
line 898
;898:}
LABELV $319
endproc BotCTFOrders_BothFlagsAtBase 316 16
export BotCTFOrders
proc BotCTFOrders 20 4
line 905
;899:
;900:/*
;901:==================
;902:BotCTFOrders
;903:==================
;904:*/
;905:void BotCTFOrders(bot_state_t *bs) {
line 909
;906:	int flagstatus;
;907:
;908:	//
;909:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
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
NEI4 $381
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $382
JUMPV
LABELV $381
line 910
;910:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $382
line 912
;911:	//
;912:	switch(flagstatus) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $383
ADDRLP4 16
INDIRI4
CNSTI4 3
GTI4 $383
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $389
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $389
address $385
address $386
address $387
address $388
code
LABELV $385
line 913
;913:		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsAtBase
CALLV
pop
ADDRGP4 $384
JUMPV
LABELV $386
line 914
;914:		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_EnemyFlagNotAtBase
CALLV
pop
ADDRGP4 $384
JUMPV
LABELV $387
line 915
;915:		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_FlagNotAtBase
CALLV
pop
ADDRGP4 $384
JUMPV
LABELV $388
line 916
;916:		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsNotAtBase
CALLV
pop
LABELV $383
LABELV $384
line 918
;917:	}
;918:}
LABELV $380
endproc BotCTFOrders 20 4
export BotCreateGroup
proc BotCreateGroup 76 20
line 926
;919:
;920:
;921:/*
;922:==================
;923:BotCreateGroup
;924:==================
;925:*/
;926:void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
line 931
;927:	char name[MAX_NETNAME], leadername[MAX_NETNAME];
;928:	int i;
;929:
;930:	// the others in the group will follow the teammates[0]
;931:	ClientName(teammates[0], leadername, sizeof(leadername));
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 932
;932:	for (i = 1; i < groupsize; i++)
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $394
JUMPV
LABELV $391
line 933
;933:	{
line 934
;934:		ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 935
;935:		if (teammates[0] == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $395
line 936
;936:			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 937
;937:		}
ADDRGP4 $396
JUMPV
LABELV $395
line 938
;938:		else {
line 939
;939:			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 40
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 940
;940:		}
LABELV $396
line 941
;941:		BotSayTeamOrderAlways(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 942
;942:	}
LABELV $392
line 932
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $394
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $391
line 943
;943:}
LABELV $390
endproc BotCreateGroup 76 20
export BotTeamOrders
proc BotTeamOrders 1304 12
line 952
;944:
;945:/*
;946:==================
;947:BotTeamOrders
;948:
;949:  FIXME: defend key areas?
;950:==================
;951:*/
;952:void BotTeamOrders(bot_state_t *bs) {
line 957
;953:	int teammates[MAX_CLIENTS];
;954:	int numteammates, i;
;955:	char buf[MAX_INFO_STRING];
;956:
;957:	numteammates = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 958
;958:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $398
line 959
;959:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 961
;960:		//if no config string or no name
;961:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $405
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1288
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1288
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $403
LABELV $405
ADDRGP4 $399
JUMPV
LABELV $403
line 963
;962:		//skip spectators
;963:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $72
ARGP4
ADDRLP4 1292
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1292
INDIRP4
ARGP4
ADDRLP4 1296
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 3
NEI4 $406
ADDRGP4 $399
JUMPV
LABELV $406
line 965
;964:		//
;965:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 1300
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 0
EQI4 $408
line 966
;966:			teammates[numteammates] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
ADDRLP4 1024
INDIRI4
ASGNI4
line 967
;967:			numteammates++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 968
;968:		}
LABELV $408
line 969
;969:	}
LABELV $399
line 958
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $401
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $398
line 971
;970:	//
;971:	switch(numteammates) {
ADDRLP4 1028
INDIRI4
CNSTI4 1
LTI4 $410
ADDRLP4 1028
INDIRI4
CNSTI4 5
GTI4 $410
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $425-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $425
address $411
address $411
address $414
address $415
address $417
code
line 972
;972:		case 1: break;
line 974
;973:		case 2:
;974:		{
line 976
;975:			//nothing special
;976:			break;
LABELV $414
line 979
;977:		}
;978:		case 3:
;979:		{
line 981
;980:			//have one follow another and one free roaming
;981:			BotCreateGroup(bs, teammates, 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 982
;982:			break;
ADDRGP4 $411
JUMPV
LABELV $415
line 985
;983:		}
;984:		case 4:
;985:		{
line 986
;986:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 987
;987:			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 988
;988:			break;
ADDRGP4 $411
JUMPV
LABELV $417
line 991
;989:		}
;990:		case 5:
;991:		{
line 992
;992:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 993
;993:			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 994
;994:			break;
ADDRGP4 $411
JUMPV
LABELV $410
line 997
;995:		}
;996:		default:
;997:		{
line 998
;998:			if (numteammates <= 10) {
ADDRLP4 1028
INDIRI4
CNSTI4 10
GTI4 $411
line 999
;999:				for (i = 0; i < numteammates / 2; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $424
JUMPV
LABELV $421
line 1000
;1000:					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 1001
;1001:				}
LABELV $422
line 999
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $424
ADDRLP4 1024
INDIRI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
DIVI4
LTI4 $421
line 1002
;1002:			}
line 1003
;1003:			break;
LABELV $411
line 1006
;1004:		}
;1005:	}
;1006:}
LABELV $397
endproc BotTeamOrders 1304 12
export FindHumanTeamLeader
proc FindHumanTeamLeader 12 12
line 1969
;1007:
;1008:#ifdef MISSIONPACK
;1009:
;1010:/*
;1011:==================
;1012:Bot1FCTFOrders_FlagAtCenter
;1013:
;1014:  X% defend the base, Y% get the flag
;1015:==================
;1016:*/
;1017:void Bot1FCTFOrders_FlagAtCenter(bot_state_t *bs) {
;1018:	int numteammates, defenders, attackers, i;
;1019:	int teammates[MAX_CLIENTS];
;1020:	char name[MAX_NETNAME];
;1021:
;1022:	//sort team mates by travel time to base
;1023:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1024:	//sort team mates by CTF preference
;1025:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1026:	//passive strategy
;1027:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1028:		//different orders based on the number of team mates
;1029:		switch(numteammates) {
;1030:			case 1: break;
;1031:			case 2:
;1032:			{
;1033:				//the one closest to the base will defend the base
;1034:				ClientName(teammates[0], name, sizeof(name));
;1035:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1036:				BotSayTeamOrder(bs, teammates[0]);
;1037:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1038:				//the other will get the flag
;1039:				ClientName(teammates[1], name, sizeof(name));
;1040:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1041:				BotSayTeamOrder(bs, teammates[1]);
;1042:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1043:				break;
;1044:			}
;1045:			case 3:
;1046:			{
;1047:				//the one closest to the base will defend the base
;1048:				ClientName(teammates[0], name, sizeof(name));
;1049:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1050:				BotSayTeamOrder(bs, teammates[0]);
;1051:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1052:				//the second one closest to the base will defend the base
;1053:				ClientName(teammates[1], name, sizeof(name));
;1054:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1055:				BotSayTeamOrder(bs, teammates[1]);
;1056:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1057:				//the other will get the flag
;1058:				ClientName(teammates[2], name, sizeof(name));
;1059:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1060:				BotSayTeamOrder(bs, teammates[2]);
;1061:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1062:				break;
;1063:			}
;1064:			default:
;1065:			{
;1066:				//50% defend the base
;1067:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1068:				if (defenders > 5) defenders = 5;
;1069:				//40% get the flag
;1070:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1071:				if (attackers > 4) attackers = 4;
;1072:				for (i = 0; i < defenders; i++) {
;1073:					//
;1074:					ClientName(teammates[i], name, sizeof(name));
;1075:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1076:					BotSayTeamOrder(bs, teammates[i]);
;1077:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1078:				}
;1079:				for (i = 0; i < attackers; i++) {
;1080:					//
;1081:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1082:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1083:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1084:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1085:				}
;1086:				//
;1087:				break;
;1088:			}
;1089:		}
;1090:	}
;1091:	else { //aggressive
;1092:		//different orders based on the number of team mates
;1093:		switch(numteammates) {
;1094:			case 1: break;
;1095:			case 2:
;1096:			{
;1097:				//the one closest to the base will defend the base
;1098:				ClientName(teammates[0], name, sizeof(name));
;1099:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1100:				BotSayTeamOrder(bs, teammates[0]);
;1101:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1102:				//the other will get the flag
;1103:				ClientName(teammates[1], name, sizeof(name));
;1104:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1105:				BotSayTeamOrder(bs, teammates[1]);
;1106:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1107:				break;
;1108:			}
;1109:			case 3:
;1110:			{
;1111:				//the one closest to the base will defend the base
;1112:				ClientName(teammates[0], name, sizeof(name));
;1113:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1114:				BotSayTeamOrder(bs, teammates[0]);
;1115:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1116:				//the others should go for the enemy flag
;1117:				ClientName(teammates[1], name, sizeof(name));
;1118:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1119:				BotSayTeamOrder(bs, teammates[1]);
;1120:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1121:				//
;1122:				ClientName(teammates[2], name, sizeof(name));
;1123:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1124:				BotSayTeamOrder(bs, teammates[2]);
;1125:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1126:				break;
;1127:			}
;1128:			default:
;1129:			{
;1130:				//30% defend the base
;1131:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1132:				if (defenders > 3) defenders = 3;
;1133:				//60% get the flag
;1134:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1135:				if (attackers > 6) attackers = 6;
;1136:				for (i = 0; i < defenders; i++) {
;1137:					//
;1138:					ClientName(teammates[i], name, sizeof(name));
;1139:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1140:					BotSayTeamOrder(bs, teammates[i]);
;1141:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1142:				}
;1143:				for (i = 0; i < attackers; i++) {
;1144:					//
;1145:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1146:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1147:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1148:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1149:				}
;1150:				//
;1151:				break;
;1152:			}
;1153:		}
;1154:	}
;1155:}
;1156:
;1157:/*
;1158:==================
;1159:Bot1FCTFOrders_TeamHasFlag
;1160:
;1161:  X% towards neutral flag, Y% go towards enemy base and accompany flag carrier if visible
;1162:==================
;1163:*/
;1164:void Bot1FCTFOrders_TeamHasFlag(bot_state_t *bs) {
;1165:	int numteammates, defenders, attackers, i, other;
;1166:	int teammates[MAX_CLIENTS];
;1167:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1168:
;1169:	//sort team mates by travel time to base
;1170:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1171:	//sort team mates by CTF preference
;1172:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1173:	//passive strategy
;1174:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1175:		//different orders based on the number of team mates
;1176:		switch(numteammates) {
;1177:			case 1: break;
;1178:			case 2:
;1179:			{
;1180:				//tell the one not carrying the flag to attack the enemy base
;1181:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1182:				else other = teammates[0];
;1183:				ClientName(other, name, sizeof(name));
;1184:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1185:				BotSayTeamOrder(bs, other);
;1186:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_OFFENSE);
;1187:				break;
;1188:			}
;1189:			case 3:
;1190:			{
;1191:				//tell the one closest to the base not carrying the flag to defend the base
;1192:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1193:				else other = teammates[1];
;1194:				ClientName(other, name, sizeof(name));
;1195:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1196:				BotSayTeamOrder(bs, other);
;1197:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1198:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1199:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1200:				else other = teammates[1];
;1201:				ClientName(other, name, sizeof(name));
;1202:				if ( bs->flagcarrier != -1 ) {
;1203:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1204:					if (bs->flagcarrier == bs->client) {
;1205:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1206:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1207:					}
;1208:					else {
;1209:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1210:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1211:					}
;1212:				}
;1213:				else {
;1214:					//
;1215:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1216:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;1217:				}
;1218:				BotSayTeamOrder(bs, other);
;1219:				break;
;1220:			}
;1221:			default:
;1222:			{
;1223:				//30% will defend the base
;1224:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1225:				if (defenders > 3) defenders = 3;
;1226:				//70% accompanies the flag carrier
;1227:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1228:				if (attackers > 7) attackers = 7;
;1229:				for (i = 0; i < defenders; i++) {
;1230:					//
;1231:					if (teammates[i] == bs->flagcarrier) {
;1232:						continue;
;1233:					}
;1234:					ClientName(teammates[i], name, sizeof(name));
;1235:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1236:					BotSayTeamOrder(bs, teammates[i]);
;1237:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1238:				}
;1239:				if (bs->flagcarrier != -1) {
;1240:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1241:					for (i = 0; i < attackers; i++) {
;1242:						//
;1243:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1244:							continue;
;1245:						}
;1246:						//
;1247:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1248:						if (bs->flagcarrier == bs->client) {
;1249:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1250:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1251:						}
;1252:						else {
;1253:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1254:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1255:						}
;1256:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1257:					}
;1258:				}
;1259:				else {
;1260:					for (i = 0; i < attackers; i++) {
;1261:						//
;1262:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1263:							continue;
;1264:						}
;1265:						//
;1266:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1267:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1268:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1269:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1270:					}
;1271:				}
;1272:				//
;1273:				break;
;1274:			}
;1275:		}
;1276:	}
;1277:	else { //aggressive
;1278:		//different orders based on the number of team mates
;1279:		switch(numteammates) {
;1280:			case 1: break;
;1281:			case 2:
;1282:			{
;1283:				//tell the one not carrying the flag to defend the base
;1284:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1285:				else other = teammates[0];
;1286:				ClientName(other, name, sizeof(name));
;1287:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1288:				BotSayTeamOrder(bs, other);
;1289:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1290:				break;
;1291:			}
;1292:			case 3:
;1293:			{
;1294:				//tell the one closest to the base not carrying the flag to defend the base
;1295:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1296:				else other = teammates[1];
;1297:				ClientName(other, name, sizeof(name));
;1298:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1299:				BotSayTeamOrder(bs, other);
;1300:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1301:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1302:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1303:				else other = teammates[1];
;1304:				ClientName(other, name, sizeof(name));
;1305:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1306:				if (bs->flagcarrier == bs->client) {
;1307:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1308:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1309:				}
;1310:				else {
;1311:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1312:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1313:				}
;1314:				BotSayTeamOrder(bs, other);
;1315:				break;
;1316:			}
;1317:			default:
;1318:			{
;1319:				//20% will defend the base
;1320:				defenders = (int) (float) numteammates * 0.2 + 0.5;
;1321:				if (defenders > 2) defenders = 2;
;1322:				//80% accompanies the flag carrier
;1323:				attackers = (int) (float) numteammates * 0.8 + 0.5;
;1324:				if (attackers > 8) attackers = 8;
;1325:				for (i = 0; i < defenders; i++) {
;1326:					//
;1327:					if (teammates[i] == bs->flagcarrier) {
;1328:						continue;
;1329:					}
;1330:					ClientName(teammates[i], name, sizeof(name));
;1331:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1332:					BotSayTeamOrder(bs, teammates[i]);
;1333:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1334:				}
;1335:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1336:				for (i = 0; i < attackers; i++) {
;1337:					//
;1338:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1339:						continue;
;1340:					}
;1341:					//
;1342:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1343:					if (bs->flagcarrier == bs->client) {
;1344:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1345:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1346:					}
;1347:					else {
;1348:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1349:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1350:					}
;1351:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1352:				}
;1353:				//
;1354:				break;
;1355:			}
;1356:		}
;1357:	}
;1358:}
;1359:
;1360:/*
;1361:==================
;1362:Bot1FCTFOrders_EnemyHasFlag
;1363:
;1364:  X% defend the base, Y% towards neutral flag
;1365:==================
;1366:*/
;1367:void Bot1FCTFOrders_EnemyHasFlag(bot_state_t *bs) {
;1368:	int numteammates, defenders, attackers, i;
;1369:	int teammates[MAX_CLIENTS];
;1370:	char name[MAX_NETNAME];
;1371:
;1372:	//sort team mates by travel time to base
;1373:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1374:	//sort team mates by CTF preference
;1375:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1376:	//passive strategy
;1377:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1378:		//different orders based on the number of team mates
;1379:		switch(numteammates) {
;1380:			case 1: break;
;1381:			case 2:
;1382:			{
;1383:				//both defend the base
;1384:				ClientName(teammates[0], name, sizeof(name));
;1385:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1386:				BotSayTeamOrder(bs, teammates[0]);
;1387:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1388:				//
;1389:				ClientName(teammates[1], name, sizeof(name));
;1390:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1391:				BotSayTeamOrder(bs, teammates[1]);
;1392:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1393:				break;
;1394:			}
;1395:			case 3:
;1396:			{
;1397:				//the one closest to the base will defend the base
;1398:				ClientName(teammates[0], name, sizeof(name));
;1399:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1400:				BotSayTeamOrder(bs, teammates[0]);
;1401:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1402:				//the second one closest to the base will defend the base
;1403:				ClientName(teammates[1], name, sizeof(name));
;1404:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1405:				BotSayTeamOrder(bs, teammates[1]);
;1406:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1407:				//the other will also defend the base
;1408:				ClientName(teammates[2], name, sizeof(name));
;1409:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1410:				BotSayTeamOrder(bs, teammates[2]);
;1411:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_DEFEND);
;1412:				break;
;1413:			}
;1414:			default:
;1415:			{
;1416:				//80% will defend the base
;1417:				defenders = (int) (float) numteammates * 0.8 + 0.5;
;1418:				if (defenders > 8) defenders = 8;
;1419:				//10% will try to return the flag
;1420:				attackers = (int) (float) numteammates * 0.1 + 0.5;
;1421:				if (attackers > 1) attackers = 1;
;1422:				for (i = 0; i < defenders; i++) {
;1423:					//
;1424:					ClientName(teammates[i], name, sizeof(name));
;1425:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1426:					BotSayTeamOrder(bs, teammates[i]);
;1427:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1428:				}
;1429:				for (i = 0; i < attackers; i++) {
;1430:					//
;1431:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1432:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1433:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1434:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1435:				}
;1436:				//
;1437:				break;
;1438:			}
;1439:		}
;1440:	}
;1441:	else { //aggressive
;1442:		//different orders based on the number of team mates
;1443:		switch(numteammates) {
;1444:			case 1: break;
;1445:			case 2:
;1446:			{
;1447:				//the one closest to the base will defend the base
;1448:				ClientName(teammates[0], name, sizeof(name));
;1449:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1450:				BotSayTeamOrder(bs, teammates[0]);
;1451:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1452:				//the other will get the flag
;1453:				ClientName(teammates[1], name, sizeof(name));
;1454:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1455:				BotSayTeamOrder(bs, teammates[1]);
;1456:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1457:				break;
;1458:			}
;1459:			case 3:
;1460:			{
;1461:				//the one closest to the base will defend the base
;1462:				ClientName(teammates[0], name, sizeof(name));
;1463:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1464:				BotSayTeamOrder(bs, teammates[0]);
;1465:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1466:				//the others should go for the enemy flag
;1467:				ClientName(teammates[1], name, sizeof(name));
;1468:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1469:				BotSayTeamOrder(bs, teammates[1]);
;1470:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1471:				//
;1472:				ClientName(teammates[2], name, sizeof(name));
;1473:				BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1474:				BotSayTeamOrder(bs, teammates[2]);
;1475:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1476:				break;
;1477:			}
;1478:			default:
;1479:			{
;1480:				//70% defend the base
;1481:				defenders = (int) (float) numteammates * 0.7 + 0.5;
;1482:				if (defenders > 7) defenders = 7;
;1483:				//20% try to return the flag
;1484:				attackers = (int) (float) numteammates * 0.2 + 0.5;
;1485:				if (attackers > 2) attackers = 2;
;1486:				for (i = 0; i < defenders; i++) {
;1487:					//
;1488:					ClientName(teammates[i], name, sizeof(name));
;1489:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1490:					BotSayTeamOrder(bs, teammates[i]);
;1491:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1492:				}
;1493:				for (i = 0; i < attackers; i++) {
;1494:					//
;1495:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1496:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1497:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1498:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1499:				}
;1500:				//
;1501:				break;
;1502:			}
;1503:		}
;1504:	}
;1505:}
;1506:
;1507:/*
;1508:==================
;1509:Bot1FCTFOrders_EnemyDroppedFlag
;1510:
;1511:  X% defend the base, Y% get the flag
;1512:==================
;1513:*/
;1514:void Bot1FCTFOrders_EnemyDroppedFlag(bot_state_t *bs) {
;1515:	int numteammates, defenders, attackers, i;
;1516:	int teammates[MAX_CLIENTS];
;1517:	char name[MAX_NETNAME];
;1518:
;1519:	//sort team mates by travel time to base
;1520:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1521:	//sort team mates by CTF preference
;1522:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1523:	//passive strategy
;1524:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1525:		//different orders based on the number of team mates
;1526:		switch(numteammates) {
;1527:			case 1: break;
;1528:			case 2:
;1529:			{
;1530:				//the one closest to the base will defend the base
;1531:				ClientName(teammates[0], name, sizeof(name));
;1532:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1533:				BotSayTeamOrder(bs, teammates[0]);
;1534:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1535:				//the other will get the flag
;1536:				ClientName(teammates[1], name, sizeof(name));
;1537:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1538:				BotSayTeamOrder(bs, teammates[1]);
;1539:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1540:				break;
;1541:			}
;1542:			case 3:
;1543:			{
;1544:				//the one closest to the base will defend the base
;1545:				ClientName(teammates[0], name, sizeof(name));
;1546:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1547:				BotSayTeamOrder(bs, teammates[0]);
;1548:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1549:				//the second one closest to the base will defend the base
;1550:				ClientName(teammates[1], name, sizeof(name));
;1551:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1552:				BotSayTeamOrder(bs, teammates[1]);
;1553:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1554:				//the other will get the flag
;1555:				ClientName(teammates[2], name, sizeof(name));
;1556:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1557:				BotSayTeamOrder(bs, teammates[2]);
;1558:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1559:				break;
;1560:			}
;1561:			default:
;1562:			{
;1563:				//50% defend the base
;1564:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1565:				if (defenders > 5) defenders = 5;
;1566:				//40% get the flag
;1567:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1568:				if (attackers > 4) attackers = 4;
;1569:				for (i = 0; i < defenders; i++) {
;1570:					//
;1571:					ClientName(teammates[i], name, sizeof(name));
;1572:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1573:					BotSayTeamOrder(bs, teammates[i]);
;1574:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1575:				}
;1576:				for (i = 0; i < attackers; i++) {
;1577:					//
;1578:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1579:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1580:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1581:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1582:				}
;1583:				//
;1584:				break;
;1585:			}
;1586:		}
;1587:	}
;1588:	else { //aggressive
;1589:		//different orders based on the number of team mates
;1590:		switch(numteammates) {
;1591:			case 1: break;
;1592:			case 2:
;1593:			{
;1594:				//the one closest to the base will defend the base
;1595:				ClientName(teammates[0], name, sizeof(name));
;1596:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1597:				BotSayTeamOrder(bs, teammates[0]);
;1598:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1599:				//the other will get the flag
;1600:				ClientName(teammates[1], name, sizeof(name));
;1601:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1602:				BotSayTeamOrder(bs, teammates[1]);
;1603:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1604:				break;
;1605:			}
;1606:			case 3:
;1607:			{
;1608:				//the one closest to the base will defend the base
;1609:				ClientName(teammates[0], name, sizeof(name));
;1610:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1611:				BotSayTeamOrder(bs, teammates[0]);
;1612:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1613:				//the others should go for the enemy flag
;1614:				ClientName(teammates[1], name, sizeof(name));
;1615:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1616:				BotSayTeamOrder(bs, teammates[1]);
;1617:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1618:				//
;1619:				ClientName(teammates[2], name, sizeof(name));
;1620:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1621:				BotSayTeamOrder(bs, teammates[2]);
;1622:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1623:				break;
;1624:			}
;1625:			default:
;1626:			{
;1627:				//30% defend the base
;1628:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1629:				if (defenders > 3) defenders = 3;
;1630:				//60% get the flag
;1631:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1632:				if (attackers > 6) attackers = 6;
;1633:				for (i = 0; i < defenders; i++) {
;1634:					//
;1635:					ClientName(teammates[i], name, sizeof(name));
;1636:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1637:					BotSayTeamOrder(bs, teammates[i]);
;1638:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1639:				}
;1640:				for (i = 0; i < attackers; i++) {
;1641:					//
;1642:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1643:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1644:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1645:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1646:				}
;1647:				//
;1648:				break;
;1649:			}
;1650:		}
;1651:	}
;1652:}
;1653:
;1654:/*
;1655:==================
;1656:Bot1FCTFOrders
;1657:==================
;1658:*/
;1659:void Bot1FCTFOrders(bot_state_t *bs) {
;1660:	switch(bs->neutralflagstatus) {
;1661:		case 0: Bot1FCTFOrders_FlagAtCenter(bs); break;
;1662:		case 1: Bot1FCTFOrders_TeamHasFlag(bs); break;
;1663:		case 2: Bot1FCTFOrders_EnemyHasFlag(bs); break;
;1664:		case 3: Bot1FCTFOrders_EnemyDroppedFlag(bs); break;
;1665:	}
;1666:}
;1667:
;1668:/*
;1669:==================
;1670:BotObeliskOrders
;1671:
;1672:  X% in defence Y% in offence
;1673:==================
;1674:*/
;1675:void BotObeliskOrders(bot_state_t *bs) {
;1676:	int numteammates, defenders, attackers, i;
;1677:	int teammates[MAX_CLIENTS];
;1678:	char name[MAX_NETNAME];
;1679:
;1680:	//sort team mates by travel time to base
;1681:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1682:	//sort team mates by CTF preference
;1683:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1684:	//passive strategy
;1685:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1686:		//different orders based on the number of team mates
;1687:		switch(numteammates) {
;1688:			case 1: break;
;1689:			case 2:
;1690:			{
;1691:				//the one closest to the base will defend the base
;1692:				ClientName(teammates[0], name, sizeof(name));
;1693:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1694:				BotSayTeamOrder(bs, teammates[0]);
;1695:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1696:				//the other will attack the enemy base
;1697:				ClientName(teammates[1], name, sizeof(name));
;1698:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1699:				BotSayTeamOrder(bs, teammates[1]);
;1700:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1701:				break;
;1702:			}
;1703:			case 3:
;1704:			{
;1705:				//the one closest to the base will defend the base
;1706:				ClientName(teammates[0], name, sizeof(name));
;1707:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1708:				BotSayTeamOrder(bs, teammates[0]);
;1709:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1710:				//the one second closest to the base also defends the base
;1711:				ClientName(teammates[1], name, sizeof(name));
;1712:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1713:				BotSayTeamOrder(bs, teammates[1]);
;1714:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1715:				//the other one attacks the enemy base
;1716:				ClientName(teammates[2], name, sizeof(name));
;1717:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1718:				BotSayTeamOrder(bs, teammates[2]);
;1719:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1720:				break;
;1721:			}
;1722:			default:
;1723:			{
;1724:				//50% defend the base
;1725:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1726:				if (defenders > 5) defenders = 5;
;1727:				//40% attack the enemy base
;1728:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1729:				if (attackers > 4) attackers = 4;
;1730:				for (i = 0; i < defenders; i++) {
;1731:					//
;1732:					ClientName(teammates[i], name, sizeof(name));
;1733:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1734:					BotSayTeamOrder(bs, teammates[i]);
;1735:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1736:				}
;1737:				for (i = 0; i < attackers; i++) {
;1738:					//
;1739:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1740:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1741:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1742:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1743:				}
;1744:				//
;1745:				break;
;1746:			}
;1747:		}
;1748:	}
;1749:	else {
;1750:		//different orders based on the number of team mates
;1751:		switch(numteammates) {
;1752:			case 1: break;
;1753:			case 2:
;1754:			{
;1755:				//the one closest to the base will defend the base
;1756:				ClientName(teammates[0], name, sizeof(name));
;1757:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1758:				BotSayTeamOrder(bs, teammates[0]);
;1759:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1760:				//the other will attack the enemy base
;1761:				ClientName(teammates[1], name, sizeof(name));
;1762:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1763:				BotSayTeamOrder(bs, teammates[1]);
;1764:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1765:				break;
;1766:			}
;1767:			case 3:
;1768:			{
;1769:				//the one closest to the base will defend the base
;1770:				ClientName(teammates[0], name, sizeof(name));
;1771:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1772:				BotSayTeamOrder(bs, teammates[0]);
;1773:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1774:				//the others attack the enemy base
;1775:				ClientName(teammates[1], name, sizeof(name));
;1776:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1777:				BotSayTeamOrder(bs, teammates[1]);
;1778:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1779:				//
;1780:				ClientName(teammates[2], name, sizeof(name));
;1781:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1782:				BotSayTeamOrder(bs, teammates[2]);
;1783:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1784:				break;
;1785:			}
;1786:			default:
;1787:			{
;1788:				//30% defend the base
;1789:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1790:				if (defenders > 3) defenders = 3;
;1791:				//70% attack the enemy base
;1792:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1793:				if (attackers > 7) attackers = 7;
;1794:				for (i = 0; i < defenders; i++) {
;1795:					//
;1796:					ClientName(teammates[i], name, sizeof(name));
;1797:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1798:					BotSayTeamOrder(bs, teammates[i]);
;1799:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1800:				}
;1801:				for (i = 0; i < attackers; i++) {
;1802:					//
;1803:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1804:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1805:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1806:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1807:				}
;1808:				//
;1809:				break;
;1810:			}
;1811:		}
;1812:	}
;1813:}
;1814:
;1815:/*
;1816:==================
;1817:BotHarvesterOrders
;1818:
;1819:  X% defend the base, Y% harvest
;1820:==================
;1821:*/
;1822:void BotHarvesterOrders(bot_state_t *bs) {
;1823:	int numteammates, defenders, attackers, i;
;1824:	int teammates[MAX_CLIENTS];
;1825:	char name[MAX_NETNAME];
;1826:
;1827:	memset( teammates, 0, sizeof( teammates ) );
;1828:	//sort team mates by travel time to base
;1829:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1830:	//sort team mates by CTF preference
;1831:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1832:	//passive strategy
;1833:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1834:		//different orders based on the number of team mates
;1835:		switch(numteammates) {
;1836:			case 1: break;
;1837:			case 2:
;1838:			{
;1839:				//the one closest to the base will defend the base
;1840:				ClientName(teammates[0], name, sizeof(name));
;1841:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1842:				BotSayTeamOrder(bs, teammates[0]);
;1843:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1844:				//the other will harvest
;1845:				ClientName(teammates[1], name, sizeof(name));
;1846:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1847:				BotSayTeamOrder(bs, teammates[1]);
;1848:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1849:				break;
;1850:			}
;1851:			case 3:
;1852:			{
;1853:				//the one closest to the base will defend the base
;1854:				ClientName(teammates[0], name, sizeof(name));
;1855:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1856:				BotSayTeamOrder(bs, teammates[0]);
;1857:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1858:				//the one second closest to the base also defends the base
;1859:				ClientName(teammates[1], name, sizeof(name));
;1860:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1861:				BotSayTeamOrder(bs, teammates[1]);
;1862:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1863:				//the other one goes harvesting
;1864:				ClientName(teammates[2], name, sizeof(name));
;1865:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1866:				BotSayTeamOrder(bs, teammates[2]);
;1867:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1868:				break;
;1869:			}
;1870:			default:
;1871:			{
;1872:				//50% defend the base
;1873:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1874:				if (defenders > 5) defenders = 5;
;1875:				//40% goes harvesting
;1876:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1877:				if (attackers > 4) attackers = 4;
;1878:				for (i = 0; i < defenders; i++) {
;1879:					//
;1880:					ClientName(teammates[i], name, sizeof(name));
;1881:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1882:					BotSayTeamOrder(bs, teammates[i]);
;1883:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1884:				}
;1885:				for (i = 0; i < attackers; i++) {
;1886:					//
;1887:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1888:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1889:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1890:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1891:				}
;1892:				//
;1893:				break;
;1894:			}
;1895:		}
;1896:	}
;1897:	else {
;1898:		//different orders based on the number of team mates
;1899:		switch(numteammates) {
;1900:			case 1: break;
;1901:			case 2:
;1902:			{
;1903:				//the one closest to the base will defend the base
;1904:				ClientName(teammates[0], name, sizeof(name));
;1905:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1906:				BotSayTeamOrder(bs, teammates[0]);
;1907:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1908:				//the other will harvest
;1909:				ClientName(teammates[1], name, sizeof(name));
;1910:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1911:				BotSayTeamOrder(bs, teammates[1]);
;1912:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1913:				break;
;1914:			}
;1915:			case 3:
;1916:			{
;1917:				//the one closest to the base will defend the base
;1918:				ClientName(teammates[0], name, sizeof(name));
;1919:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1920:				BotSayTeamOrder(bs, teammates[0]);
;1921:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1922:				//the others go harvesting
;1923:				ClientName(teammates[1], name, sizeof(name));
;1924:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1925:				BotSayTeamOrder(bs, teammates[1]);
;1926:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1927:				//
;1928:				ClientName(teammates[2], name, sizeof(name));
;1929:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1930:				BotSayTeamOrder(bs, teammates[2]);
;1931:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1932:				break;
;1933:			}
;1934:			default:
;1935:			{
;1936:				//30% defend the base
;1937:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1938:				if (defenders > 3) defenders = 3;
;1939:				//70% go harvesting
;1940:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1941:				if (attackers > 7) attackers = 7;
;1942:				for (i = 0; i < defenders; i++) {
;1943:					//
;1944:					ClientName(teammates[i], name, sizeof(name));
;1945:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1946:					BotSayTeamOrder(bs, teammates[i]);
;1947:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1948:				}
;1949:				for (i = 0; i < attackers; i++) {
;1950:					//
;1951:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1952:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1953:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1954:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1955:				}
;1956:				//
;1957:				break;
;1958:			}
;1959:		}
;1960:	}
;1961:}
;1962:#endif
;1963:
;1964:/*
;1965:==================
;1966:FindHumanTeamLeader
;1967:==================
;1968:*/
;1969:int FindHumanTeamLeader(bot_state_t *bs) {
line 1972
;1970:	int i;
;1971:
;1972:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $428
line 1973
;1973:		if ( g_entities[i].inuse ) {
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $432
line 1975
;1974:			// if this player is not a bot
;1975:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $435
line 1977
;1976:				// if this player is ok with being the leader
;1977:				if (!notleader[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
INDIRI4
CNSTI4 0
NEI4 $439
line 1979
;1978:					// if this player is on the same team
;1979:					if ( BotSameTeam(bs, i) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $441
line 1980
;1980:						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1982
;1981:						// if not yet ordered to do anything
;1982:						if ( !BotSetLastOrderedTask(bs) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $443
line 1984
;1983:							// go on defense by default
;1984:							BotVoiceChat_Defend(bs, i, SAY_TELL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 1985
;1985:						}
LABELV $443
line 1986
;1986:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $427
JUMPV
LABELV $441
line 1988
;1987:					}
;1988:				}
LABELV $439
line 1989
;1989:			}
LABELV $435
line 1990
;1990:		}
LABELV $432
line 1991
;1991:	}
LABELV $429
line 1972
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $428
line 1992
;1992:	return qfalse;
CNSTI4 0
RETI4
LABELV $427
endproc FindHumanTeamLeader 12 12
export BotTeamAI
proc BotTeamAI 68 12
line 2000
;1993:}
;1994:
;1995:/*
;1996:==================
;1997:BotTeamAI
;1998:==================
;1999:*/
;2000:void BotTeamAI(bot_state_t *bs) {
line 2005
;2001:	int numteammates;
;2002:	char netname[MAX_NETNAME];
;2003:
;2004:	//
;2005:	if ( gametype < GT_TEAM  )
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $446
line 2006
;2006:		return;
ADDRGP4 $445
JUMPV
LABELV $446
line 2008
;2007:	// make sure we've got a valid team leader
;2008:	if (!BotValidTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotValidTeamLeader
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $448
line 2010
;2009:		//
;2010:		if (!FindHumanTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 FindHumanTeamLeader
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $450
line 2012
;2011:			//
;2012:			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
CNSTF4 0
NEF4 $452
ADDRLP4 48
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
CNSTF4 0
NEF4 $452
line 2013
;2013:				if (bs->entergame_time + 10 > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
CNSTF4 1092616192
ADDF4
ADDRGP4 floattime
INDIRF4
LEF4 $454
line 2014
;2014:					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 966787392
MULF4
ADDF4
ASGNF4
line 2015
;2015:				}
ADDRGP4 $455
JUMPV
LABELV $454
line 2016
;2016:				else {
line 2017
;2017:					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 966787392
MULF4
ADDF4
ASGNF4
line 2018
;2018:				}
LABELV $455
line 2019
;2019:			}
LABELV $452
line 2020
;2020:			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
CNSTF4 0
EQF4 $456
ADDRLP4 52
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $456
line 2022
;2021:				// if asked for a team leader and no response
;2022:				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $458
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2023
;2023:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2024
;2024:				bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 2025
;2025:				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 966787392
MULF4
ADDF4
ASGNF4
line 2026
;2026:			}
LABELV $456
line 2027
;2027:			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
CNSTF4 0
EQF4 $445
ADDRLP4 56
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $445
line 2028
;2028:				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $461
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 2029
;2029:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 2031
;2030:#if defined MISSIONPACK || defined NEOHUD
;2031:				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $462
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 2033
;2032:#endif
;2033:				ClientName(bs->client, netname, sizeof(netname));
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
line 2034
;2034:				Q_strncpyz( bs->teamleader, netname, sizeof( bs->teamleader ) );
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2035
;2035:				bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
CNSTF4 0
ASGNF4
line 2036
;2036:			}
line 2037
;2037:			return;
ADDRGP4 $445
JUMPV
LABELV $450
line 2039
;2038:		}
;2039:	}
LABELV $448
line 2040
;2040:	bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 2041
;2041:	bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
CNSTF4 0
ASGNF4
line 2044
;2042:
;2043:	//return if this bot is NOT the team leader
;2044:	ClientName(bs->client, netname, sizeof(netname));
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
line 2045
;2045:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $463
ADDRGP4 $445
JUMPV
LABELV $463
line 2047
;2046:	//
;2047:	numteammates = BotNumTeamMates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotNumTeamMates
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 48
INDIRI4
ASGNI4
line 2049
;2048:	//give orders
;2049:	switch(gametype) {
ADDRLP4 52
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 3
EQI4 $467
ADDRLP4 52
INDIRI4
CNSTI4 4
EQI4 $473
ADDRGP4 $465
JUMPV
LABELV $467
line 2051
;2050:		case GT_TEAM:
;2051:		{
line 2052
;2052:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $470
ADDRLP4 56
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 0
EQI4 $468
LABELV $470
line 2053
;2053:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2054
;2054:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2055
;2055:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
CNSTI4 0
ASGNI4
line 2056
;2056:			}
LABELV $468
line 2058
;2057:			//if it's time to give orders
;2058:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
CNSTF4 0
EQF4 $466
ADDRLP4 60
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $466
line 2059
;2059:				BotTeamOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamOrders
CALLV
pop
line 2061
;2060:				//give orders again after 120 seconds
;2061:				bs->teamgiveorders_time = FloatTime() + 120;
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 2062
;2062:			}
line 2063
;2063:			break;
ADDRGP4 $466
JUMPV
LABELV $473
line 2066
;2064:		}
;2065:		case GT_CTF:
;2066:		{
line 2069
;2067:			//if the number of team mates changed or the flag status changed
;2068:			//or someone wants to know what to do
;2069:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $477
ADDRLP4 56
INDIRP4
CNSTI4 6968
ADDP4
INDIRI4
CNSTI4 0
NEI4 $477
ADDRLP4 56
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 0
EQI4 $474
LABELV $477
line 2070
;2070:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2071
;2071:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6952
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2072
;2072:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 0
ASGNI4
line 2073
;2073:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
CNSTI4 0
ASGNI4
line 2074
;2074:			}
LABELV $474
line 2076
;2075:			//if there were no flag captures the last 3 minutes
;2076:			if (bs->lastflagcapture_time < FloatTime() - 240) {
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1131413504
SUBF4
GEF4 $478
line 2077
;2077:				bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2079
;2078:				//randomly change the CTF strategy
;2079:				if (random() < 0.4) {
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1053609165
GEF4 $480
line 2080
;2080:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6980
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2081
;2081:					bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2082
;2082:				}
LABELV $480
line 2083
;2083:			}
LABELV $478
line 2085
;2084:			//if it's time to give orders
;2085:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
CNSTF4 0
EQF4 $466
ADDRLP4 60
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $466
line 2086
;2086:				BotCTFOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders
CALLV
pop
line 2088
;2087:				//
;2088:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
CNSTF4 0
ASGNF4
line 2089
;2089:			}
line 2090
;2090:			break;
LABELV $465
LABELV $466
line 2150
;2091:		}
;2092:#ifdef MISSIONPACK
;2093:		case GT_1FCTF:
;2094:		{
;2095:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
;2096:				bs->teamgiveorders_time = FloatTime();
;2097:				bs->numteammates = numteammates;
;2098:				bs->flagstatuschanged = qfalse;
;2099:				bs->forceorders = qfalse;
;2100:			}
;2101:			//if there were no flag captures the last 4 minutes
;2102:			if (bs->lastflagcapture_time < FloatTime() - 240) {
;2103:				bs->lastflagcapture_time = FloatTime();
;2104:				//randomly change the CTF strategy
;2105:				if (random() < 0.4) {
;2106:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
;2107:					bs->teamgiveorders_time = FloatTime();
;2108:				}
;2109:			}
;2110:			//if it's time to give orders
;2111:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 2) {
;2112:				Bot1FCTFOrders(bs);
;2113:				//
;2114:				bs->teamgiveorders_time = 0;
;2115:			}
;2116:			break;
;2117:		}
;2118:		case GT_OBELISK:
;2119:		{
;2120:			if (bs->numteammates != numteammates || bs->forceorders) {
;2121:				bs->teamgiveorders_time = FloatTime();
;2122:				bs->numteammates = numteammates;
;2123:				bs->forceorders = qfalse;
;2124:			}
;2125:			//if it's time to give orders
;2126:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2127:				BotObeliskOrders(bs);
;2128:				//give orders again after 30 seconds
;2129:				bs->teamgiveorders_time = FloatTime() + 30;
;2130:			}
;2131:			break;
;2132:		}
;2133:		case GT_HARVESTER:
;2134:		{
;2135:			if (bs->numteammates != numteammates || bs->forceorders) {
;2136:				bs->teamgiveorders_time = FloatTime();
;2137:				bs->numteammates = numteammates;
;2138:				bs->forceorders = qfalse;
;2139:			}
;2140:			//if it's time to give orders
;2141:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2142:				BotHarvesterOrders(bs);
;2143:				//give orders again after 30 seconds
;2144:				bs->teamgiveorders_time = FloatTime() + 30;
;2145:			}
;2146:			break;
;2147:		}
;2148:#endif
;2149:	}
;2150:}
LABELV $445
endproc BotTeamAI 68 12
bss
export ctftaskpreferences
align 4
LABELV ctftaskpreferences
skip 2560
import BotVoiceChat_Defend
import BotVoiceChatCommand
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
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import mapname
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
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
LABELV $462
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $461
byte 1 105
byte 1 97
byte 1 109
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $458
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $216
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $211
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $172
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
LABELV $166
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $164
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $163
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $142
byte 1 118
byte 1 111
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
byte 1 0
align 1
LABELV $141
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
byte 1 32
byte 1 37
byte 1 115
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
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $136
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
byte 1 0
align 1
LABELV $131
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $72
byte 1 116
byte 1 0
align 1
LABELV $68
byte 1 110
byte 1 0
