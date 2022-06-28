bss
align 1
LABELV $78
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "..\..\..\..\code\cgame\cg_event.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7:// for the voice chats
;8:#ifdef MISSIONPACK // bk001205
;9:#include "../../ui/menudef.h"
;10:#endif
;11://==========================================================================
;12:
;13:/*
;14:===================
;15:CG_PlaceString
;16:
;17:Also called by scoreboard drawing
;18:===================
;19:*/
;20:const char	*CG_PlaceString( int rank ) {
line 24
;21:	static char	str[64];
;22:	char	*s, *t;
;23:
;24:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $79
line 25
;25:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 26
;26:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $81
ASGNP4
line 27
;27:	} else {
ADDRGP4 $80
JUMPV
LABELV $79
line 28
;28:		t = "";
ADDRLP4 4
ADDRGP4 $82
ASGNP4
line 29
;29:	}
LABELV $80
line 31
;30:
;31:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $83
line 32
;32:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $85
ASGNP4
line 33
;33:	} else if ( rank == 2 ) {
ADDRGP4 $84
JUMPV
LABELV $83
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $86
line 34
;34:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $88
ASGNP4
line 35
;35:	} else if ( rank == 3 ) {
ADDRGP4 $87
JUMPV
LABELV $86
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $89
line 36
;36:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $91
ASGNP4
line 37
;37:	} else if ( rank == 11 ) {
ADDRGP4 $90
JUMPV
LABELV $89
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $92
line 38
;38:		s = "11th";
ADDRLP4 0
ADDRGP4 $94
ASGNP4
line 39
;39:	} else if ( rank == 12 ) {
ADDRGP4 $93
JUMPV
LABELV $92
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $95
line 40
;40:		s = "12th";
ADDRLP4 0
ADDRGP4 $97
ASGNP4
line 41
;41:	} else if ( rank == 13 ) {
ADDRGP4 $96
JUMPV
LABELV $95
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $98
line 42
;42:		s = "13th";
ADDRLP4 0
ADDRGP4 $100
ASGNP4
line 43
;43:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $99
JUMPV
LABELV $98
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $101
line 44
;44:		s = va("%ist", rank);
ADDRGP4 $103
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 45
;45:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $102
JUMPV
LABELV $101
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $104
line 46
;46:		s = va("%ind", rank);
ADDRGP4 $106
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 47
;47:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $105
JUMPV
LABELV $104
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $107
line 48
;48:		s = va("%ird", rank);
ADDRGP4 $109
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 49
;49:	} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 50
;50:		s = va("%ith", rank);
ADDRGP4 $110
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 51
;51:	}
LABELV $108
LABELV $105
LABELV $102
LABELV $99
LABELV $96
LABELV $93
LABELV $90
LABELV $87
LABELV $84
line 53
;52:
;53:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $78
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $111
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 54
;54:	return str;
ADDRGP4 $78
RETP4
LABELV $77
endproc CG_PlaceString 12 20
proc CG_Obituary 1340 20
line 63
;55:}
;56:
;57:
;58:/*
;59:=============
;60:CG_Obituary
;61:=============
;62:*/
;63:static void CG_Obituary( entityState_t *ent ) {
line 76
;64:	int			mod;
;65:	int			target, attacker;
;66:	char		*message;
;67:	char		*message2;
;68:	const char	*targetInfo;
;69:	const char	*attackerInfo;
;70:	char		targetName[32];
;71:	char		attackerName[32];
;72:	gender_t	gender;
;73:	clientInfo_t	*ci;
;74:	qboolean	following;
;75:
;76:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 77
;77:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 78
;78:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 80
;79:
;80:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $115
line 81
;81:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $116
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 82
;82:	}
LABELV $113
line 83
;83:	ci = &cgs.clientinfo[target];
ADDRLP4 92
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 85
;84:
;85:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $120
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $118
LABELV $120
line 86
;86:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 87
;87:		attackerInfo = NULL;
ADDRLP4 84
CNSTP4 0
ASGNP4
line 88
;88:	} else {
ADDRGP4 $119
JUMPV
LABELV $118
line 89
;89:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 112
INDIRP4
ASGNP4
line 90
;90:	}
LABELV $119
line 92
;91:
;92:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 112
INDIRP4
ASGNP4
line 93
;93:	if ( !targetInfo[0] )
ADDRLP4 48
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $121
line 94
;94:	{
line 95
;95:		return;
ADDRGP4 $112
JUMPV
LABELV $121
line 97
;96:	}
;97:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $123
ARGP4
ADDRLP4 116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 98
;98:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $124
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 100
;99:
;100:	following = cg.snap->ps.pm_flags & PMF_FOLLOW;
ADDRLP4 96
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ASGNI4
line 102
;101:
;102:	message2 = "";
ADDRLP4 88
ADDRGP4 $82
ASGNP4
line 106
;103:
;104:	// check for single client messages
;105:
;106:	switch( mod ) {
ADDRLP4 44
INDIRI4
CNSTI4 14
LTI4 $126
ADDRLP4 44
INDIRI4
CNSTI4 22
GTI4 $126
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $144-56
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $144
address $134
address $136
address $138
address $132
address $126
address $130
address $128
address $140
address $142
code
LABELV $128
line 108
;107:	case MOD_SUICIDE:
;108:		message = "suicides";
ADDRLP4 40
ADDRGP4 $129
ASGNP4
line 109
;109:		break;
ADDRGP4 $127
JUMPV
LABELV $130
line 111
;110:	case MOD_FALLING:
;111:		message = "cratered";
ADDRLP4 40
ADDRGP4 $131
ASGNP4
line 112
;112:		break;
ADDRGP4 $127
JUMPV
LABELV $132
line 114
;113:	case MOD_CRUSH:
;114:		message = "was squished";
ADDRLP4 40
ADDRGP4 $133
ASGNP4
line 115
;115:		break;
ADDRGP4 $127
JUMPV
LABELV $134
line 117
;116:	case MOD_WATER:
;117:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $135
ASGNP4
line 118
;118:		break;
ADDRGP4 $127
JUMPV
LABELV $136
line 120
;119:	case MOD_SLIME:
;120:		message = "melted";
ADDRLP4 40
ADDRGP4 $137
ASGNP4
line 121
;121:		break;
ADDRGP4 $127
JUMPV
LABELV $138
line 123
;122:	case MOD_LAVA:
;123:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $139
ASGNP4
line 124
;124:		break;
ADDRGP4 $127
JUMPV
LABELV $140
line 126
;125:	case MOD_TARGET_LASER:
;126:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $141
ASGNP4
line 127
;127:		break;
ADDRGP4 $127
JUMPV
LABELV $142
line 129
;128:	case MOD_TRIGGER_HURT:
;129:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $143
ASGNP4
line 130
;130:		break;
ADDRGP4 $127
JUMPV
LABELV $126
line 132
;131:	default:
;132:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 133
;133:		break;
LABELV $127
line 136
;134:	}
;135:
;136:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $146
line 137
;137:		gender = ci->gender;
ADDRLP4 100
ADDRLP4 92
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 138
;138:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 5
EQI4 $150
ADDRLP4 44
INDIRI4
CNSTI4 7
EQI4 $158
ADDRLP4 44
INDIRI4
CNSTI4 9
EQI4 $166
ADDRLP4 44
INDIRI4
CNSTI4 5
LTI4 $148
LABELV $183
ADDRLP4 44
INDIRI4
CNSTI4 13
EQI4 $174
ADDRGP4 $148
JUMPV
LABELV $150
line 145
;139:#ifdef MISSIONPACK
;140:		case MOD_KAMIKAZE:
;141:			message = "goes out with a bang";
;142:			break;
;143:#endif
;144:		case MOD_GRENADE_SPLASH:
;145:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $151
line 146
;146:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $153
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $151
line 147
;147:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $154
line 148
;148:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $156
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $154
line 150
;149:			else
;150:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $157
ASGNP4
line 151
;151:			break;
ADDRGP4 $149
JUMPV
LABELV $158
line 153
;152:		case MOD_ROCKET_SPLASH:
;153:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $159
line 154
;154:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $161
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $159
line 155
;155:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $162
line 156
;156:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $164
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $162
line 158
;157:			else
;158:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $165
ASGNP4
line 159
;159:			break;
ADDRGP4 $149
JUMPV
LABELV $166
line 161
;160:		case MOD_PLASMA_SPLASH:
;161:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $167
line 162
;162:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $169
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $167
line 163
;163:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $170
line 164
;164:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $172
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $170
line 166
;165:			else
;166:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $173
ASGNP4
line 167
;167:			break;
ADDRGP4 $149
JUMPV
LABELV $174
line 169
;168:		case MOD_BFG_SPLASH:
;169:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $175
ASGNP4
line 170
;170:			break;
ADDRGP4 $149
JUMPV
LABELV $148
line 183
;171:#ifdef MISSIONPACK
;172:		case MOD_PROXIMITY_MINE:
;173:			if( gender == GENDER_FEMALE ) {
;174:				message = "found her prox mine";
;175:			} else if ( gender == GENDER_NEUTER ) {
;176:				message = "found its prox mine";
;177:			} else {
;178:				message = "found his prox mine";
;179:			}
;180:			break;
;181:#endif
;182:		default:
;183:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $176
line 184
;184:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $178
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $176
line 185
;185:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $179
line 186
;186:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $181
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $179
line 188
;187:			else
;188:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $182
ASGNP4
line 189
;189:			break;
LABELV $149
line 191
;190:		}
;191:	}
LABELV $146
line 193
;192:
;193:	if ( message ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $184
line 194
;194:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $186
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 196
;195:		// switch to first killer if not following anyone
;196:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $112
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $112
line 197
;197:			if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+149108
INDIRI4
CNSTI4 0
NEI4 $112
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $112
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $112
line 198
;198:				cg.followClient = attacker;
ADDRGP4 cg+149112
ADDRLP4 0
INDIRI4
ASGNI4
line 199
;199:				cg.followTime = cg.time;
ADDRGP4 cg+149108
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 200
;200:			}
line 201
;201:		}
line 202
;202:		return;
ADDRGP4 $112
JUMPV
LABELV $184
line 206
;203:	}
;204:
;205:	// check for kill messages from the current clientNum
;206:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $198
line 209
;207:		char	*s;
;208:
;209:		if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $201
line 210
;210:			s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $204
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 132
INDIRP4
ASGNP4
line 213
;211:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;212:				cg.snap->ps.persistant[PERS_SCORE] );
;213:		} else {
ADDRGP4 $202
JUMPV
LABELV $201
line 214
;214:			s = va("You fragged %s", targetName );
ADDRGP4 $207
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 128
INDIRP4
ASGNP4
line 215
;215:		}
LABELV $202
line 222
;216:#if defined MISSIONPACK
;217:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;218:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;219:		}
;220:#endif
;221:#if defined NEOHUD
;222:		{
line 224
;223:		item_t itm;
;224:		itm = dyn_itemArray[KillMsg_idx];
ADDRLP4 128
ADDRGP4 KillMsg_idx
INDIRI4
CNSTI4 1212
MULI4
ADDRGP4 dyn_itemArray
ADDP4
INDIRB
ASGNB 1212
line 225
;225:		CG_CenterPrint( s, itm.rect.y, itm.fontsize.w, itm.forecolor.color );
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 128+1088+4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 128+1120
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 128+1152
ARGP4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 226
;226:		}
line 233
;227:#endif
;228:#if !defined MISSIONPACK && !defined NEOHUD
;229:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;230:#endif
;231:
;232:		// print the text message as well
;233:	}
LABELV $198
line 236
;234:
;235:	// check for double client messages
;236:	if ( !attackerInfo ) {
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $212
line 237
;237:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 238
;238:		strcpy( attackerName, "noname" );
ADDRLP4 52
ARGP4
ADDRGP4 $214
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 239
;239:	} else {
ADDRGP4 $213
JUMPV
LABELV $212
line 240
;240:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $123
ARGP4
ADDRLP4 124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 52
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 241
;241:		Q_CleanStr( attackerName );
ADDRLP4 52
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 242
;242:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 52
ARGP4
ADDRGP4 $124
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 244
;243:		// check for kill messages about the current clientNum
;244:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $215
line 245
;245:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+115368
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 247
;246:			// follow killer
;247:			if ( following && cg_followKiller.integer ) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $220
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $220
line 248
;248:				if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+149108
INDIRI4
CNSTI4 0
NEI4 $223
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $223
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $223
line 249
;249:					cg.followClient = attacker;
ADDRGP4 cg+149112
ADDRLP4 0
INDIRI4
ASGNI4
line 250
;250:					cg.followTime = cg.time + 1100;
ADDRGP4 cg+149108
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1100
ADDI4
ASGNI4
line 251
;251:				}
LABELV $223
line 252
;252:			}
LABELV $220
line 253
;253:		}
LABELV $215
line 254
;254:	}
LABELV $213
line 256
;255:
;256:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $230
line 257
;257:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $232
ADDRLP4 44
INDIRI4
CNSTI4 23
GTI4 $232
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $267-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $267
address $240
address $236
address $238
address $242
address $245
address $248
address $250
address $252
address $255
address $256
address $258
address $260
address $260
address $232
address $232
address $232
address $232
address $263
address $232
address $232
address $232
address $232
address $234
code
LABELV $234
line 259
;258:		case MOD_GRAPPLE:
;259:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $235
ASGNP4
line 260
;260:			break;
ADDRGP4 $233
JUMPV
LABELV $236
line 262
;261:		case MOD_GAUNTLET:
;262:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $237
ASGNP4
line 263
;263:			break;
ADDRGP4 $233
JUMPV
LABELV $238
line 265
;264:		case MOD_MACHINEGUN:
;265:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $239
ASGNP4
line 266
;266:			break;
ADDRGP4 $233
JUMPV
LABELV $240
line 268
;267:		case MOD_SHOTGUN:
;268:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $241
ASGNP4
line 269
;269:			break;
ADDRGP4 $233
JUMPV
LABELV $242
line 271
;270:		case MOD_GRENADE:
;271:			message = "ate";
ADDRLP4 40
ADDRGP4 $243
ASGNP4
line 272
;272:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $244
ASGNP4
line 273
;273:			break;
ADDRGP4 $233
JUMPV
LABELV $245
line 275
;274:		case MOD_GRENADE_SPLASH:
;275:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $246
ASGNP4
line 276
;276:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $247
ASGNP4
line 277
;277:			break;
ADDRGP4 $233
JUMPV
LABELV $248
line 279
;278:		case MOD_ROCKET:
;279:			message = "ate";
ADDRLP4 40
ADDRGP4 $243
ASGNP4
line 280
;280:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $249
ASGNP4
line 281
;281:			break;
ADDRGP4 $233
JUMPV
LABELV $250
line 283
;282:		case MOD_ROCKET_SPLASH:
;283:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $251
ASGNP4
line 284
;284:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $249
ASGNP4
line 285
;285:			break;
ADDRGP4 $233
JUMPV
LABELV $252
line 287
;286:		case MOD_PLASMA:
;287:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $253
ASGNP4
line 288
;288:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $254
ASGNP4
line 289
;289:			break;
ADDRGP4 $233
JUMPV
LABELV $255
line 291
;290:		case MOD_PLASMA_SPLASH:
;291:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $253
ASGNP4
line 292
;292:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $254
ASGNP4
line 293
;293:			break;
ADDRGP4 $233
JUMPV
LABELV $256
line 295
;294:		case MOD_RAILGUN:
;295:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $257
ASGNP4
line 296
;296:			break;
ADDRGP4 $233
JUMPV
LABELV $258
line 298
;297:		case MOD_LIGHTNING:
;298:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $259
ASGNP4
line 299
;299:			break;
ADDRGP4 $233
JUMPV
LABELV $260
line 302
;300:		case MOD_BFG:
;301:		case MOD_BFG_SPLASH:
;302:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $261
ASGNP4
line 303
;303:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $262
ASGNP4
line 304
;304:			break;
ADDRGP4 $233
JUMPV
LABELV $263
line 326
;305:#ifdef MISSIONPACK
;306:		case MOD_NAIL:
;307:			message = "was nailed by";
;308:			break;
;309:		case MOD_CHAINGUN:
;310:			message = "got lead poisoning from";
;311:			message2 = "'s Chaingun";
;312:			break;
;313:		case MOD_PROXIMITY_MINE:
;314:			message = "was too close to";
;315:			message2 = "'s Prox Mine";
;316:			break;
;317:		case MOD_KAMIKAZE:
;318:			message = "falls to";
;319:			message2 = "'s Kamikaze blast";
;320:			break;
;321:		case MOD_JUICED:
;322:			message = "was juiced by";
;323:			break;
;324:#endif
;325:		case MOD_TELEFRAG:
;326:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $264
ASGNP4
line 327
;327:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $265
ASGNP4
line 328
;328:			break;
ADDRGP4 $233
JUMPV
LABELV $232
line 330
;329:		default:
;330:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $266
ASGNP4
line 331
;331:			break;
LABELV $233
line 334
;332:		}
;333:
;334:		if ( message ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $269
line 335
;335:			CG_Printf( "%s %s %s%s\n", targetName, message, attackerName, message2 );
ADDRGP4 $271
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 337
;336:			// switch to first killer if not following anyone
;337:			if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $112
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $112
line 338
;338:				if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+149108
INDIRI4
CNSTI4 0
NEI4 $112
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $112
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $112
line 339
;339:					cg.followClient = attacker;
ADDRGP4 cg+149112
ADDRLP4 0
INDIRI4
ASGNI4
line 340
;340:					cg.followTime = cg.time;
ADDRGP4 cg+149108
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 341
;341:				}
line 342
;342:			}
line 343
;343:			return;
ADDRGP4 $112
JUMPV
LABELV $269
line 345
;344:		}
;345:	}
LABELV $230
line 348
;346:
;347:	// we don't know what it was
;348:	CG_Printf( "%s "S_COLOR_STRIP"died.\n", targetName );
ADDRGP4 $283
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 349
;349:}
LABELV $112
endproc CG_Obituary 1340 20
proc CG_UseItem 1244 16
line 358
;350://==========================================================================
;351:
;352:
;353:/*
;354:===============
;355:CG_UseItem
;356:===============
;357:*/
;358:static void CG_UseItem( centity_t *cent ) {
line 364
;359:	clientInfo_t	*ci;
;360:	int				itemNum, clientNum;
;361:	gitem_t			*item;
;362:	entityState_t	*es;
;363:
;364:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 366
;365:	
;366:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 367
;367:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $287
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $285
LABELV $287
line 368
;368:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 369
;369:	}
LABELV $285
line 373
;370:
;371:	// print a message if the local player
;372:#ifdef NEOHUD
;373:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $288
line 374
;374:		item_t itm = dyn_itemArray[ItemMsg_idx];
ADDRLP4 24
ADDRGP4 ItemMsg_idx
INDIRI4
CNSTI4 1212
MULI4
ADDRGP4 dyn_itemArray
ADDP4
INDIRB
ASGNB 1212
line 375
;375:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $291
line 376
;376:			CG_CenterPrint( "No item to use", itm.rect.y, itm.fontsize.w, itm.forecolor.color);
ADDRGP4 $293
ARGP4
ADDRLP4 24+1088+4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24+1120
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24+1152
ARGP4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 377
;377:		} else {
ADDRGP4 $292
JUMPV
LABELV $291
line 378
;378:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1236
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1236
INDIRP4
ASGNP4
line 379
;379:			CG_CenterPrint( va("Use %s", item->pickup_name), itm.rect.y, itm.fontsize.w, itm.forecolor.color);
ADDRGP4 $298
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 1240
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
ARGP4
ADDRLP4 24+1088+4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24+1120
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24+1152
ARGP4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 380
;380:		}
LABELV $292
line 381
;381:	}
LABELV $288
line 393
;382:#else
;383:	if ( es->number == cg.snap->ps.clientNum ) {
;384:		if ( !itemNum ) {
;385:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;386:		} else {
;387:			item = BG_FindItemForHoldable( itemNum );
;388:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;389:		}
;390:	}
;391:#endif
;392:
;393:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $305
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $304
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $309
ADDRGP4 $303
JUMPV
LABELV $303
LABELV $305
line 396
;394:	default:
;395:	case HI_NONE:
;396:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148752+548
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 397
;397:		break;
ADDRGP4 $304
JUMPV
line 400
;398:
;399:	case HI_TELEPORTER:
;400:		break;
LABELV $309
line 403
;401:
;402:	case HI_MEDKIT:
;403:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 404
;404:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $310
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $310
line 405
;405:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 406
;406:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 407
;407:		}
LABELV $310
line 408
;408:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148752+848
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 409
;409:		break;
LABELV $304
line 422
;410:
;411:#ifdef MISSIONPACK
;412:	case HI_KAMIKAZE:
;413:		break;
;414:
;415:	case HI_PORTAL:
;416:		break;
;417:	case HI_INVULNERABILITY:
;418:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
;419:		break;
;420:#endif
;421:	}
;422:}
LABELV $284
endproc CG_UseItem 1244 16
data
align 4
LABELV $317
byte 4 -1
code
proc CG_ItemPickup 4 0
line 432
;423:
;424:
;425:/*
;426:================
;427:CG_ItemPickup
;428:
;429:A new item was picked up this frame
;430:================
;431:*/
;432:static void CG_ItemPickup( int itemNum ) {
line 435
;433:	static int oldItem = -1;
;434:	
;435:	cg.itemPickup = itemNum;
ADDRGP4 cg+117860
ADDRFP4 0
INDIRI4
ASGNI4
line 436
;436:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+117868
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 437
;437:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+117872
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 439
;438:
;439:	if ( oldItem != itemNum )
ADDRGP4 $317
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $323
line 440
;440:		cg.itemPickupCount = 1;
ADDRGP4 cg+117864
CNSTI4 1
ASGNI4
ADDRGP4 $324
JUMPV
LABELV $323
line 442
;441:	else
;442:		cg.itemPickupCount++;
ADDRLP4 0
ADDRGP4 cg+117864
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $324
line 444
;443:
;444:	oldItem = itemNum;
ADDRGP4 $317
ADDRFP4 0
INDIRI4
ASGNI4
line 447
;445:	
;446:	// see if it should be the grabbed weapon
;447:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $327
line 449
;448:		// select it immediately
;449:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $330
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $330
line 450
;450:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+117876
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 451
;451:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+108956
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 452
;452:		}
LABELV $330
line 453
;453:	}
LABELV $327
line 455
;454:
;455:}
LABELV $316
endproc CG_ItemPickup 4 0
export CG_WaterLevel
proc CG_WaterLevel 52 8
line 465
;456:
;457:
;458:/*
;459:================
;460:CG_WaterLevel
;461:
;462:Returns waterlevel for entity origin
;463:================
;464:*/
;465:int CG_WaterLevel(centity_t *cent) {
line 470
;466:	vec3_t point;
;467:	int contents, sample1, sample2, anim, waterlevel;
;468:	int viewheight;
;469:
;470:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 472
;471:
;472:	if ( anim == LEGS_WALKCR || anim == LEGS_IDLECR ) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $341
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $339
LABELV $341
line 473
;473:		viewheight = CROUCH_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 12
ASGNI4
line 474
;474:	} else {
ADDRGP4 $340
JUMPV
LABELV $339
line 475
;475:		viewheight = DEFAULT_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 26
ASGNI4
line 476
;476:	}
LABELV $340
line 481
;477:
;478:	//
;479:	// get waterlevel, accounting for ducking
;480:	//
;481:	waterlevel = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 483
;482:
;483:	point[0] = cent->lerpOrigin[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ASGNF4
line 484
;484:	point[1] = cent->lerpOrigin[1];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ASGNF4
line 485
;485:	point[2] = cent->lerpOrigin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 486
;486:	contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 40
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 488
;487:
;488:	if ( contents & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $344
line 489
;489:		sample2 = viewheight - MINS_Z;
ADDRLP4 28
ADDRLP4 24
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 490
;490:		sample1 = sample2 / 2;
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 491
;491:		waterlevel = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 492
;492:		point[2] = cent->lerpOrigin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 493
;493:		contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 495
;494:
;495:		if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $347
line 496
;496:			waterlevel = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 497
;497:			point[2] = cent->lerpOrigin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 498
;498:			contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 48
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 500
;499:
;500:			if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $350
line 501
;501:				waterlevel = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 502
;502:			}
LABELV $350
line 503
;503:		}
LABELV $347
line 504
;504:	}
LABELV $344
line 506
;505:
;506:	return waterlevel;
ADDRLP4 20
INDIRI4
RETI4
LABELV $338
endproc CG_WaterLevel 52 8
export CG_PainEvent
proc CG_PainEvent 16 16
line 516
;507:}
;508:
;509:/*
;510:================
;511:CG_PainEvent
;512:
;513:Also called by playerstate transition
;514:================
;515:*/
;516:void CG_PainEvent( centity_t *cent, int health ) {
line 520
;517:	const char *snd;
;518:
;519:	// don't do more than two pain sounds a second
;520:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $353
line 521
;521:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 522
;522:		return;
ADDRGP4 $352
JUMPV
LABELV $353
line 525
;523:	}
;524:
;525:	if ( cent->pe.painIgnore ) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $356
line 526
;526:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 527
;527:		return;
ADDRGP4 $352
JUMPV
LABELV $356
line 530
;528:	}
;529:
;530:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $358
line 531
;531:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $360
ASGNP4
line 532
;532:	} else if ( health < 50 ) {
ADDRGP4 $359
JUMPV
LABELV $358
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $361
line 533
;533:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $363
ASGNP4
line 534
;534:	} else if ( health < 75 ) {
ADDRGP4 $362
JUMPV
LABELV $361
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $364
line 535
;535:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $366
ASGNP4
line 536
;536:	} else {
ADDRGP4 $365
JUMPV
LABELV $364
line 537
;537:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $367
ASGNP4
line 538
;538:	}
LABELV $365
LABELV $362
LABELV $359
line 541
;539:
;540:	// play a gurp sound instead of a normal pain sound
;541:	if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $368
line 542
;542:		if (rand()&1) {
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $370
line 543
;543:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp1.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $372
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 544
;544:		} else {
ADDRGP4 $369
JUMPV
LABELV $370
line 545
;545:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp2.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $373
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 546
;546:		}
line 547
;547:	} else {
ADDRGP4 $369
JUMPV
LABELV $368
line 548
;548:		trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, snd));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 549
;549:	}
LABELV $369
line 552
;550:
;551:	// save pain time for programitic twitch animation
;552:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 553
;553:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 554
;554:}
LABELV $352
endproc CG_PainEvent 16 16
data
align 4
LABELV $481
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 116 48
line 566
;555:
;556:
;557:
;558:/*
;559:==============
;560:CG_EntityEvent
;561:
;562:An entity has an event value
;563:also called by CG_CheckPlayerstateEvents
;564:==============
;565:*/
;566:void CG_EntityEvent( centity_t *cent, vec3_t position, int entityNum ) {
line 577
;567:	entityState_t	*es;
;568:	entity_event_t	event;
;569:	vec3_t			dir;
;570:	const char		*s;
;571:	int				clientNum;
;572:	clientInfo_t	*ci;
;573:	vec3_t			vec;
;574:	float			fovOffset;
;575:	centity_t		*ce;
;576:
;577:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 578
;578:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 580
;579:
;580:	if ( (unsigned) event >= EV_MAX ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 83
LTU4 $376
line 581
;581:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $378
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 582
;582:		return;
ADDRGP4 $375
JUMPV
LABELV $376
line 585
;583:	}
;584:
;585:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $379
line 586
;586:		CG_Printf( "ent:%3i  event:%3i %s", es->number, event, eventnames[ event ] );
ADDRGP4 $382
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 587
;587:	}
LABELV $379
line 589
;588:
;589:	if ( !event ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $383
line 590
;590:		return;
ADDRGP4 $375
JUMPV
LABELV $383
line 593
;591:	}
;592:
;593:	clientNum = es->clientNum;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 594
;594:	if ( (unsigned) clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $385
line 595
;595:		clientNum = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 596
;596:	}
LABELV $385
line 597
;597:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 599
;598:
;599:	switch ( event ) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
LTI4 $388
ADDRLP4 52
INDIRI4
CNSTI4 82
GTI4 $388
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $795-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $795
address $391
address $397
address $404
address $411
address $418
address $454
address $454
address $454
address $454
address $425
address $435
address $444
address $480
address $488
address $506
address $509
address $512
address $515
address $517
address $538
address $555
address $559
address $562
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $563
address $573
address $570
address $564
address $567
address $577
address $652
address $657
address $664
address $650
address $649
address $585
address $586
address $587
address $588
address $651
address $388
address $752
address $756
address $756
address $756
address $761
address $762
address $771
address $780
address $789
address $584
address $389
address $389
address $388
address $388
address $388
address $388
address $388
address $388
address $793
address $792
address $492
address $494
address $496
address $498
address $500
address $502
address $504
code
LABELV $391
line 604
;600:	//
;601:	// movement generated events
;602:	//
;603:	case EV_FOOTSTEP:
;604:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $389
line 605
;605:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+148752+556
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 607
;606:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;607:		}
line 608
;608:		break;
ADDRGP4 $389
JUMPV
LABELV $397
line 611
;609:
;610:	case EV_FOOTSTEP_METAL:
;611:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $389
line 612
;612:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 614
;613:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;614:		}
line 615
;615:		break;
ADDRGP4 $389
JUMPV
LABELV $404
line 618
;616:
;617:	case EV_FOOTSPLASH:
;618:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $389
line 619
;619:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 621
;620:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;621:		}
line 622
;622:		break;
ADDRGP4 $389
JUMPV
LABELV $411
line 625
;623:
;624:	case EV_FOOTWADE:
;625:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $389
line 626
;626:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 628
;627:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;628:		}
line 629
;629:		break;
ADDRGP4 $389
JUMPV
LABELV $418
line 632
;630:
;631:	case EV_SWIM:
;632:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $389
line 633
;633:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 635
;634:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;635:		}
line 636
;636:		break;
ADDRGP4 $389
JUMPV
LABELV $425
line 639
;637:
;638:	case EV_FALL_SHORT:
;639:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+740
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 640
;640:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $389
line 642
;641:			// smooth landing z changes
;642:			cg.landChange = -8;
ADDRGP4 cg+108948
CNSTF4 3238002688
ASGNF4
line 643
;643:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 644
;644:		}
line 645
;645:		break;
ADDRGP4 $389
JUMPV
LABELV $435
line 649
;646:
;647:	case EV_FALL_MEDIUM:
;648:		// use normal pain sound
;649:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $367
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 650
;650:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 651
;651:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 652
;652:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $389
line 654
;653:			// smooth landing z changes
;654:			cg.landChange = -16;
ADDRGP4 cg+108948
CNSTF4 3246391296
ASGNF4
line 655
;655:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 656
;656:		}
line 657
;657:		break;
ADDRGP4 $389
JUMPV
LABELV $444
line 660
;658:
;659:	case EV_FALL_FAR:
;660:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $445
ARGP4
ADDRLP4 64
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 661
;661:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 662
;662:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 663
;663:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $389
line 665
;664:			// smooth landing z changes
;665:			cg.landChange = -24;
ADDRGP4 cg+108948
CNSTF4 3250585600
ASGNF4
line 666
;666:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 667
;667:		}
line 668
;668:		break;
ADDRGP4 $389
JUMPV
LABELV $454
line 674
;669:
;670:	case EV_STEP_4:
;671:	case EV_STEP_8:
;672:	case EV_STEP_12:
;673:	case EV_STEP_16:		// smooth out step up transitions
;674:	{
line 679
;675:		float	oldStep;
;676:		int		delta;
;677:		int		step;
;678:
;679:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $455
line 680
;680:			break;
ADDRGP4 $389
JUMPV
LABELV $455
line 683
;681:		}
;682:		// if we are interpolating, we don't need to smooth steps
;683:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $467
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $467
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $467
ADDRGP4 cgs+149812
INDIRI4
CNSTI4 0
EQI4 $459
LABELV $467
line 684
;684:			cg_nopredict.integer || cgs.synchronousClients ) {
line 685
;685:			break;
ADDRGP4 $389
JUMPV
LABELV $459
line 688
;686:		}
;687:		// check for stepping up before a previous step is completed
;688:		delta = cg.time - cg.stepTime;
ADDRLP4 68
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108936
INDIRI4
SUBI4
ASGNI4
line 689
;689:		if (delta < STEP_TIME) {
ADDRLP4 68
INDIRI4
CNSTI4 200
GEI4 $470
line 690
;690:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 72
ADDRGP4 cg+108932
INDIRF4
CNSTI4 200
ADDRLP4 68
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
ASGNF4
line 691
;691:		} else {
ADDRGP4 $471
JUMPV
LABELV $470
line 692
;692:			oldStep = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 693
;693:		}
LABELV $471
line 696
;694:
;695:		// add this amount
;696:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 76
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 697
;697:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108932
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 698
;698:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+108932
INDIRF4
CNSTF4 1107296256
LEF4 $474
line 699
;699:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108932
CNSTF4 1107296256
ASGNF4
line 700
;700:		}
LABELV $474
line 701
;701:		cg.stepTime = cg.time;
ADDRGP4 cg+108936
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 702
;702:		break;
ADDRGP4 $389
JUMPV
LABELV $480
line 707
;703:	}
;704:
;705:	case EV_JUMP_PAD:
;706://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;707:		{
line 708
;708:			vec3_t			up = {0, 0, 1};
ADDRLP4 68
ADDRGP4 $481
INDIRB
ASGNB 12
line 711
;709:
;710:
;711:			CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 68
ARGP4
CNSTF4 1107296256
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+148752+276
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 718
;712:						  32, 
;713:						  1, 1, 1, 0.33f,
;714:						  1000, 
;715:						  cg.time, 0,
;716:						  LEF_PUFF_DONT_SCALE, 
;717:						  cgs.media.smokePuffShader );
;718:		}
line 721
;719:
;720:		// boing sound at origin, jump sound on player
;721:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+148752+744
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 722
;722:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $487
ARGP4
ADDRLP4 68
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 723
;723:		break;
ADDRGP4 $389
JUMPV
LABELV $488
line 727
;724:
;725:	case EV_JUMP:
;726:		// pain event with fast sequential jump just creates sound distortion
;727:		if ( cg.time - cent->pe.painTime > 50 )
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 50
LEI4 $389
line 728
;728:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $487
ARGP4
ADDRLP4 72
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 729
;729:		break;
ADDRGP4 $389
JUMPV
LABELV $492
line 732
;730:
;731:	case EV_TAUNT:
;732:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $493
ARGP4
ADDRLP4 76
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 733
;733:		break;
ADDRGP4 $389
JUMPV
LABELV $494
line 737
;734:
;735:#if defined MISSIONPACK || defined NEOHUD
;736:	case EV_TAUNT_YES:
;737:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $495
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 738
;738:		break;
ADDRGP4 $389
JUMPV
LABELV $496
line 741
;739:
;740:	case EV_TAUNT_NO:
;741:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $497
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 742
;742:		break;
ADDRGP4 $389
JUMPV
LABELV $498
line 745
;743:
;744:	case EV_TAUNT_FOLLOWME:
;745:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $499
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 746
;746:		break;
ADDRGP4 $389
JUMPV
LABELV $500
line 749
;747:
;748:	case EV_TAUNT_GETFLAG:
;749:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $501
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 750
;750:		break;
ADDRGP4 $389
JUMPV
LABELV $502
line 753
;751:
;752:	case EV_TAUNT_GUARDBASE:
;753:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $503
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 754
;754:		break;
ADDRGP4 $389
JUMPV
LABELV $504
line 757
;755:
;756:	case EV_TAUNT_PATROL:
;757:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $505
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 758
;758:		break;
ADDRGP4 $389
JUMPV
LABELV $506
line 761
;759:#endif
;760:	case EV_WATER_TOUCH:
;761:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+832
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 762
;762:		break;
ADDRGP4 $389
JUMPV
LABELV $509
line 765
;763:
;764:	case EV_WATER_LEAVE:
;765:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+836
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 766
;766:		break;
ADDRGP4 $389
JUMPV
LABELV $512
line 769
;767:
;768:	case EV_WATER_UNDER:
;769:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+840
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 770
;770:		break;
ADDRGP4 $389
JUMPV
LABELV $515
line 773
;771:
;772:	case EV_WATER_CLEAR:
;773:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $516
ARGP4
ADDRLP4 80
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 774
;774:		break;
ADDRGP4 $389
JUMPV
LABELV $517
line 777
;775:
;776:	case EV_ITEM_PICKUP:
;777:		{
line 781
;778:			gitem_t	*item;
;779:			int		index;
;780:
;781:			index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 783
;782:
;783:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $520
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $518
LABELV $520
line 784
;784:				break;
ADDRGP4 $389
JUMPV
LABELV $518
line 787
;785:			}
;786:
;787:			if ( entityNum >= 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $521
line 789
;788:				// our predicted entity
;789:				ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 790
;790:				if ( ce->delaySpawn > cg.time && ce->delaySpawnPlayed ) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $522
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $522
line 791
;791:					break; // delay item pickup
ADDRGP4 $389
JUMPV
line 793
;792:				}
;793:			} else {
LABELV $521
line 794
;794:				ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 795
;795:			}
LABELV $522
line 797
;796:
;797:			item = &bg_itemlist[ index ];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 801
;798:
;799:			// powerups and team items will have a separate global sound, this one
;800:			// will be played at prediction time
;801:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 96
ADDRLP4 88
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
EQI4 $528
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $526
LABELV $528
line 802
;802:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+1016
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 803
;803:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $527
JUMPV
LABELV $526
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $531
line 820
;804:#ifdef MISSIONPACK
;805:				switch (item->giTag ) {
;806:					case PW_SCOUT:
;807:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
;808:					break;
;809:					case PW_GUARD:
;810:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
;811:					break;
;812:					case PW_DOUBLER:
;813:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
;814:					break;
;815:					case PW_AMMOREGEN:
;816:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
;817:					break;
;818:				}
;819:#endif
;820:			} else {
ADDRGP4 $532
JUMPV
LABELV $531
line 821
;821:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 822
;822:			}
LABELV $532
LABELV $527
line 825
;823:
;824:			// show icon and name on status bar
;825:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $533
line 826
;826:				CG_ItemPickup( index );
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 827
;827:			}
LABELV $533
line 829
;828:
;829:			if ( ce ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $389
line 830
;830:				ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 831
;831:			}
line 832
;832:		}
line 833
;833:		break;
ADDRGP4 $389
JUMPV
LABELV $538
line 836
;834:
;835:	case EV_GLOBAL_ITEM_PICKUP:
;836:		{
line 840
;837:			gitem_t	*item;
;838:			int		index;
;839:
;840:			index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 842
;841:
;842:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $541
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $539
LABELV $541
line 843
;843:				break;
ADDRGP4 $389
JUMPV
LABELV $539
line 846
;844:			}
;845:
;846:			if ( entityNum >= 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $542
line 848
;847:				// our predicted entity
;848:				ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 849
;849:				if ( ce->delaySpawn > cg.time && ce->delaySpawnPlayed ) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $543
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $543
line 850
;850:					break;
ADDRGP4 $389
JUMPV
line 852
;851:				}
;852:			} else {
LABELV $542
line 853
;853:				ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 854
;854:			}
LABELV $543
line 856
;855:
;856:			item = &bg_itemlist[ index ];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 858
;857:			// powerup pickups are global
;858:			if( item->pickup_sound ) {
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $547
line 859
;859:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 860
;860:			}
LABELV $547
line 863
;861:
;862:			// show icon and name on status bar
;863:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $550
line 864
;864:				CG_ItemPickup( index );
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 865
;865:			}
LABELV $550
line 867
;866:
;867:			if ( ce ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $389
line 868
;868:				ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 869
;869:			}
line 870
;870:		}
line 871
;871:		break;
ADDRGP4 $389
JUMPV
LABELV $555
line 878
;872:
;873:	//
;874:	// weapon events
;875:	//
;876:	case EV_NOAMMO:
;877://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;878:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $389
line 879
;879:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 880
;880:		}
line 881
;881:		break;
ADDRGP4 $389
JUMPV
LABELV $559
line 884
;882:
;883:	case EV_CHANGE_WEAPON:
;884:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+544
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 885
;885:		break;
ADDRGP4 $389
JUMPV
LABELV $562
line 888
;886:
;887:	case EV_FIRE_WEAPON:
;888:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 889
;889:		break;
ADDRGP4 $389
JUMPV
LABELV $563
line 907
;890:
;891:	case EV_USE_ITEM0:
;892:	case EV_USE_ITEM1:
;893:	case EV_USE_ITEM2:
;894:	case EV_USE_ITEM3:
;895:	case EV_USE_ITEM4:
;896:	case EV_USE_ITEM5:
;897:	case EV_USE_ITEM6:
;898:	case EV_USE_ITEM7:
;899:	case EV_USE_ITEM8:
;900:	case EV_USE_ITEM9:
;901:	case EV_USE_ITEM10:
;902:	case EV_USE_ITEM11:
;903:	case EV_USE_ITEM12:
;904:	case EV_USE_ITEM13:
;905:	case EV_USE_ITEM14:
;906:	case EV_USE_ITEM15:
;907:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 908
;908:		break;
ADDRGP4 $389
JUMPV
LABELV $564
line 916
;909:
;910:	//=================================================================
;911:
;912:	//
;913:	// other events
;914:	//
;915:	case EV_PLAYER_TELEPORT_IN:
;916:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+720
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 917
;917:		CG_SpawnEffect( position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 918
;918:		break;
ADDRGP4 $389
JUMPV
LABELV $567
line 921
;919:
;920:	case EV_PLAYER_TELEPORT_OUT:
;921:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+724
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 922
;922:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 923
;923:		break;
ADDRGP4 $389
JUMPV
LABELV $570
line 926
;924:
;925:	case EV_ITEM_POP:
;926:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+732
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 927
;927:		break;
ADDRGP4 $389
JUMPV
LABELV $573
line 930
;928:
;929:	case EV_ITEM_RESPAWN:
;930:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 931
;931:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+732
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 932
;932:		break;
ADDRGP4 $389
JUMPV
LABELV $577
line 935
;933:
;934:	case EV_GRENADE_BOUNCE:
;935:		if ( rand() & 1 ) {
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $578
line 936
;936:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+1020
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 937
;937:		} else {
ADDRGP4 $389
JUMPV
LABELV $578
line 938
;938:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+1024
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 939
;939:		}
line 940
;940:		break;
ADDRGP4 $389
JUMPV
LABELV $584
line 983
;941:
;942:#ifdef MISSIONPACK
;943:	case EV_PROXIMITY_MINE_STICK:
;944:		if( es->eventParm & SURF_FLESH ) {
;945:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
;946:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
;947:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
;948:		} else {
;949:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
;950:		}
;951:		break;
;952:
;953:	case EV_PROXIMITY_MINE_TRIGGER:
;954:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
;955:		break;
;956:
;957:	case EV_KAMIKAZE:
;958:		CG_KamikazeEffect( cent->lerpOrigin );
;959:		break;
;960:
;961:	case EV_OBELISKEXPLODE:
;962:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
;963:		break;
;964:
;965:	case EV_OBELISKPAIN:
;966:		CG_ObeliskPain( cent->lerpOrigin );
;967:		break;
;968:
;969:	case EV_INVUL_IMPACT:
;970:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
;971:		break;
;972:
;973:	case EV_JUICED:
;974:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
;975:		break;
;976:
;977:	case EV_LIGHTNINGBOLT:
;978:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
;979:		break;
;980:#endif
;981:
;982:	case EV_SCOREPLUM:
;983:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 984
;984:		break;
ADDRGP4 $389
JUMPV
LABELV $585
line 990
;985:
;986:	//
;987:	// missile impacts
;988:	//
;989:	case EV_MISSILE_HIT:
;990:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 991
;991:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 992
;992:		break;
ADDRGP4 $389
JUMPV
LABELV $586
line 995
;993:
;994:	case EV_MISSILE_MISS:
;995:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 996
;996:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 997
;997:		break;
ADDRGP4 $389
JUMPV
LABELV $587
line 1000
;998:
;999:	case EV_MISSILE_MISS_METAL:
;1000:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1001
;1001:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1002
;1002:		break;
ADDRGP4 $389
JUMPV
LABELV $588
line 1005
;1003:
;1004:	case EV_RAILTRAIL:
;1005:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 1007
;1006:
;1007:		if ( cent->currentState.clientNum == cg.snap->ps.clientNum && !cg_thirdPerson.integer ) 
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $589
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $589
line 1008
;1008:		{
line 1009
;1009:			VectorCopy( cg.refdef.vieworg, vec );
ADDRLP4 16
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 1010
;1010:			fovOffset = -0.2f * ( cgs.fov - 90.0f );
ADDRLP4 48
ADDRGP4 cgs+149796
INDIRF4
CNSTF4 1119092736
SUBF4
CNSTF4 3192704205
MULF4
ASGNF4
line 1013
;1011:
;1012:			// 13.5, -5.5, -6.0
;1013:			VectorMA( vec, cg_gun_x.value + 13.5f, cg.refdef.viewaxis[0], vec );
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
line 1014
;1014:			VectorMA( vec, cg_gun_y.value - 5.5f, cg.refdef.viewaxis[1], vec );
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
line 1015
;1015:			VectorMA( vec, cg_gun_z.value + fovOffset - 6.0f, cg.refdef.viewaxis[2], vec );
ADDRLP4 96
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+24
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+24+4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+24+8
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
line 1016
;1016:		}
ADDRGP4 $590
JUMPV
LABELV $589
line 1018
;1017:		else
;1018:			VectorCopy( es->origin2, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
LABELV $590
line 1021
;1019:
;1020:		// if the end was on a nomark surface, don't make an explosion
;1021:		CG_RailTrail( ci, vec, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 1023
;1022:
;1023:		if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $389
line 1024
;1024:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1025
;1025:			CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1026
;1026:		}
line 1027
;1027:		break;
ADDRGP4 $389
JUMPV
LABELV $649
line 1030
;1028:
;1029:	case EV_BULLET_HIT_WALL:
;1030:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1031
;1031:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1032
;1032:		break;
ADDRGP4 $389
JUMPV
LABELV $650
line 1035
;1033:
;1034:	case EV_BULLET_HIT_FLESH:
;1035:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1036
;1036:		break;
ADDRGP4 $389
JUMPV
LABELV $651
line 1039
;1037:
;1038:	case EV_SHOTGUN:
;1039:		CG_ShotgunFire( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1040
;1040:		break;
ADDRGP4 $389
JUMPV
LABELV $652
line 1043
;1041:
;1042:	case EV_GENERAL_SOUND:
;1043:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
CNSTI4 0
EQI4 $653
line 1044
;1044:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1045
;1045:		} else {
ADDRGP4 $389
JUMPV
LABELV $653
line 1046
;1046:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 104
INDIRP4
ASGNP4
line 1047
;1047:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1048
;1048:		}
line 1049
;1049:		break;
ADDRGP4 $389
JUMPV
LABELV $657
line 1052
;1050:
;1051:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1052:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
CNSTI4 0
EQI4 $658
line 1053
;1053:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1054
;1054:		} else {
ADDRGP4 $389
JUMPV
LABELV $658
line 1055
;1055:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 104
INDIRP4
ASGNP4
line 1056
;1056:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1057
;1057:		}
line 1058
;1058:		break;
ADDRGP4 $389
JUMPV
LABELV $664
line 1061
;1059:
;1060:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1061:		{
line 1062
;1062:			switch( es->eventParm ) {
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
LTI4 $389
ADDRLP4 104
INDIRI4
CNSTI4 12
GTI4 $389
ADDRLP4 104
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $751
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $751
address $668
address $676
address $684
address $694
address $704
address $720
address $389
address $389
address $736
address $739
address $742
address $745
address $748
code
LABELV $668
line 1064
;1063:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1064:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $669
line 1065
;1065:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+148752+876
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $389
JUMPV
LABELV $669
line 1067
;1066:					else
;1067:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+148752+880
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1068
;1068:					break;
ADDRGP4 $389
JUMPV
LABELV $676
line 1070
;1069:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1070:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $677
line 1071
;1071:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+148752+876
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $389
JUMPV
LABELV $677
line 1073
;1072:					else
;1073:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+148752+880
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1074
;1074:					break;
ADDRGP4 $389
JUMPV
LABELV $684
line 1076
;1075:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1076:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $685
line 1077
;1077:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+148752+884
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $686
JUMPV
LABELV $685
line 1079
;1078:					else
;1079:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+148752+888
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $686
line 1081
;1080:					//
;1081:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+148752+904
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1082
;1082:					break;
ADDRGP4 $389
JUMPV
LABELV $694
line 1084
;1083:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1084:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $695
line 1085
;1085:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+148752+884
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $696
JUMPV
LABELV $695
line 1087
;1086:					else
;1087:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+148752+888
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $696
line 1089
;1088:					//
;1089:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+148752+900
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1090
;1090:					break;
ADDRGP4 $389
JUMPV
LABELV $704
line 1094
;1091:
;1092:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1093:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1094:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $709
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $705
LABELV $709
line 1095
;1095:					}
ADDRGP4 $389
JUMPV
LABELV $705
line 1096
;1096:					else {
line 1097
;1097:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $710
line 1103
;1098:#ifdef MISSIONPACK
;1099:							if (cgs.gametype == GT_1FCTF) 
;1100:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1101:							else
;1102:#endif
;1103:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+148752+908
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1104
;1104:						}
ADDRGP4 $389
JUMPV
LABELV $710
line 1105
;1105:						else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $389
line 1111
;1106:#ifdef MISSIONPACK
;1107:							if (cgs.gametype == GT_1FCTF)
;1108:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1109:							else
;1110:#endif
;1111: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+148752+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1112
;1112:						}
line 1113
;1113:					}
line 1114
;1114:					break;
ADDRGP4 $389
JUMPV
LABELV $720
line 1117
;1115:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1116:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1117:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $725
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $721
LABELV $725
line 1118
;1118:					}
ADDRGP4 $389
JUMPV
LABELV $721
line 1119
;1119:					else {
line 1120
;1120:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $726
line 1126
;1121:#ifdef MISSIONPACK
;1122:							if (cgs.gametype == GT_1FCTF)
;1123:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1124:							else
;1125:#endif
;1126:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+148752+908
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1127
;1127:						}
ADDRGP4 $389
JUMPV
LABELV $726
line 1128
;1128:						else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $389
line 1134
;1129:#ifdef MISSIONPACK
;1130:							if (cgs.gametype == GT_1FCTF)
;1131:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1132:							else
;1133:#endif
;1134:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+148752+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1135
;1135:						}
line 1136
;1136:					}
line 1137
;1137:					break;
ADDRGP4 $389
JUMPV
LABELV $736
line 1152
;1138:#ifdef MISSIONPACK
;1139:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1140:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
;1141:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
;1142:					}
;1143:					break;
;1144:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1145:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
;1146:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
;1147:					}
;1148:					break;
;1149:#endif
;1150:
;1151:				case GTS_REDTEAM_SCORED:
;1152:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+148752+856
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1153
;1153:					break;
ADDRGP4 $389
JUMPV
LABELV $739
line 1155
;1154:				case GTS_BLUETEAM_SCORED:
;1155:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+148752+860
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1156
;1156:					break;
ADDRGP4 $389
JUMPV
LABELV $742
line 1158
;1157:				case GTS_REDTEAM_TOOK_LEAD:
;1158:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+148752+864
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1159
;1159:					break;
ADDRGP4 $389
JUMPV
LABELV $745
line 1161
;1160:				case GTS_BLUETEAM_TOOK_LEAD:
;1161:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+148752+868
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1162
;1162:					break;
ADDRGP4 $389
JUMPV
LABELV $748
line 1164
;1163:				case GTS_TEAMS_ARE_TIED:
;1164:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+148752+872
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1165
;1165:					break;
line 1172
;1166:#ifdef MISSIONPACK
;1167:				case GTS_KAMIKAZE:
;1168:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
;1169:					break;
;1170:#endif
;1171:				default:
;1172:					break;
line 1174
;1173:			}
;1174:			break;
ADDRGP4 $389
JUMPV
LABELV $752
line 1180
;1175:		}
;1176:
;1177:	case EV_PAIN:
;1178:		// local player sounds are triggered in CG_CheckLocalSounds,
;1179:		// so ignore events on the player
;1180:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $389
line 1181
;1181:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1182
;1182:		}
line 1183
;1183:		break;
ADDRGP4 $389
JUMPV
LABELV $756
line 1188
;1184:
;1185:	case EV_DEATH1:
;1186:	case EV_DEATH2:
;1187:	case EV_DEATH3:
;1188:		if ( CG_WaterLevel(cent) == 3 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 3
NEI4 $757
line 1189
;1189:			trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*drown.wav") );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $759
ARGP4
ADDRLP4 108
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1190
;1190:		} else {
ADDRGP4 $389
JUMPV
LABELV $757
line 1191
;1191:			trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, va("*death%i.wav", event - EV_DEATH1 + 1)) );
ADDRGP4 $760
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 57
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1192
;1192:		}
line 1194
;1193:
;1194:		break;
ADDRGP4 $389
JUMPV
LABELV $761
line 1197
;1195:
;1196:	case EV_OBITUARY:
;1197:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1198
;1198:		break;
ADDRGP4 $389
JUMPV
LABELV $762
line 1204
;1199:
;1200:	//
;1201:	// powerup events
;1202:	//
;1203:	case EV_POWERUP_QUAD:
;1204:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $763
line 1205
;1205:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+117560
CNSTI4 1
ASGNI4
line 1206
;1206:			cg.powerupTime = cg.time;
ADDRGP4 cg+117564
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1207
;1207:		}
LABELV $763
line 1208
;1208:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148752+536
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1209
;1209:		break;
ADDRGP4 $389
JUMPV
LABELV $771
line 1212
;1210:
;1211:	case EV_POWERUP_BATTLESUIT:
;1212:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $772
line 1213
;1213:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+117560
CNSTI4 2
ASGNI4
line 1214
;1214:			cg.powerupTime = cg.time;
ADDRGP4 cg+117564
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1215
;1215:		}
LABELV $772
line 1216
;1216:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148752+1012
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1217
;1217:		break;
ADDRGP4 $389
JUMPV
LABELV $780
line 1220
;1218:
;1219:	case EV_POWERUP_REGEN:
;1220:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $781
line 1221
;1221:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+117560
CNSTI4 5
ASGNI4
line 1222
;1222:			cg.powerupTime = cg.time;
ADDRGP4 cg+117564
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1223
;1223:		}
LABELV $781
line 1224
;1224:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148752+1008
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1225
;1225:		break;
ADDRGP4 $389
JUMPV
LABELV $789
line 1236
;1226:
;1227:	case EV_GIB_PLAYER:
;1228:		// don't play gib sound when using the kamikaze because it interferes
;1229:		// with the kamikaze sound, downside is that the gib sound will also
;1230:		// not be played when someone is gibbed while just carrying the kamikaze
;1231:#ifdef MISSIONPACK
;1232:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
;1233:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
;1234:		}
;1235:#else
;1236:		trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148752+704
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1238
;1237:#endif
;1238:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1239
;1239:		break;
ADDRGP4 $389
JUMPV
LABELV $792
line 1242
;1240:
;1241:	case EV_STOPLOOPINGSOUND:
;1242:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1243
;1243:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1244
;1244:		break;
ADDRGP4 $389
JUMPV
LABELV $793
line 1247
;1245:
;1246:	case EV_DEBUG_LINE:
;1247:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1248
;1248:		break;
ADDRGP4 $389
JUMPV
line 1252
;1249:
;1250:	case EV_PROXIMITY_MINE_STICK:
;1251:	case EV_PROXIMITY_MINE_TRIGGER:
;1252:		break;
LABELV $388
line 1255
;1253:
;1254:	default:
;1255:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $378
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1256
;1256:		break;
LABELV $389
line 1258
;1257:	}
;1258:}
LABELV $375
endproc CG_EntityEvent 116 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1267
;1259:
;1260:
;1261:/*
;1262:==============
;1263:CG_CheckEvents
;1264:
;1265:==============
;1266:*/
;1267:void CG_CheckEvents( centity_t *cent ) {
line 1269
;1268:	// check for event-only entities
;1269:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $798
line 1270
;1270:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $800
line 1271
;1271:			return;	// already fired
ADDRGP4 $797
JUMPV
LABELV $800
line 1274
;1272:		}
;1273:		// if this is a player event set the entity number of the client entity number
;1274:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $802
line 1275
;1275:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1276
;1276:		}
LABELV $802
line 1278
;1277:
;1278:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1280
;1279:
;1280:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1281
;1281:	} else {
ADDRGP4 $799
JUMPV
LABELV $798
line 1283
;1282:		// check for events riding with another entity
;1283:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $804
line 1284
;1284:			return;
ADDRGP4 $797
JUMPV
LABELV $804
line 1286
;1285:		}
;1286:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1287
;1287:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $806
line 1288
;1288:			return;
ADDRGP4 $797
JUMPV
LABELV $806
line 1290
;1289:		}
;1290:	}
LABELV $799
line 1293
;1291:
;1292:	// calculate the position at exactly the frame time
;1293:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1294
;1294:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1296
;1295:
;1296:	CG_EntityEvent( cent, cent->lerpOrigin, -1 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1297
;1297:}
LABELV $797
endproc CG_CheckEvents 8 12
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
import CG_InitConsoleCommands
import CG_ConsoleCommand
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
LABELV $760
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $759
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $516
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $505
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
LABELV $503
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
LABELV $501
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
LABELV $499
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
LABELV $497
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $495
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $493
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $487
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $445
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $382
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $378
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $373
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $372
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $367
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $366
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $363
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $360
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $298
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $293
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $283
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $271
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $266
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $265
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $264
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $261
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $259
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $257
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $254
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $253
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $251
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $249
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $247
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $246
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $244
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $243
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $241
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $239
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $237
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $235
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $214
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $207
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $204
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $186
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $182
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $181
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $178
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $175
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $173
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $172
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $169
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $165
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $164
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $161
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $157
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $156
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $143
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $141
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $139
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $137
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $133
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $124
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $123
byte 1 110
byte 1 0
align 1
LABELV $116
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
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
byte 1 0
align 1
LABELV $111
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $109
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $100
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $97
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $94
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $91
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $88
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $85
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $82
byte 1 0
align 1
LABELV $81
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
