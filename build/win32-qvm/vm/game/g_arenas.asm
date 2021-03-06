export UpdateTournamentInfo
code
proc UpdateTournamentInfo 1100 44
file "..\..\..\..\code\game\g_arenas.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3://
;4:// g_arenas.c
;5://
;6:
;7:#include "g_local.h"
;8:
;9:
;10:gentity_t	*podium1;
;11:gentity_t	*podium2;
;12:gentity_t	*podium3;
;13:
;14:
;15:/*
;16:==================
;17:UpdateTournamentInfo
;18:==================
;19:*/
;20:void UpdateTournamentInfo( void ) {
line 33
;21:	int			i;
;22:	gentity_t	*player;
;23:	int			playerClientNum;
;24:	int			n, accuracy, perfect,	msglen;
;25:#ifdef MISSIONPACK
;26:  int score1, score2;
;27:	qboolean won;
;28:#endif
;29:	char		buf[32];
;30:	char		msg[MAX_STRING_CHARS];
;31:
;32:	// find the real player
;33:	player = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 34
;34:	for (i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $58
JUMPV
LABELV $55
line 35
;35:		player = &g_entities[i];
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 36
;36:		if ( !player->inuse ) {
ADDRLP4 40
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $60
line 37
;37:			continue;
ADDRGP4 $56
JUMPV
LABELV $60
line 39
;38:		}
;39:		if ( !( player->r.svFlags & SVF_BOT ) ) {
ADDRLP4 40
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $62
line 40
;40:			break;
ADDRGP4 $57
JUMPV
LABELV $62
line 42
;41:		}
;42:	}
LABELV $56
line 34
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $58
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $55
LABELV $57
line 44
;43:	// this should never happen!
;44:	if ( !player || i == level.maxclients ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $67
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
NEI4 $64
LABELV $67
line 45
;45:		return;
ADDRGP4 $54
JUMPV
LABELV $64
line 47
;46:	}
;47:	playerClientNum = i;
ADDRLP4 1072
ADDRLP4 0
INDIRI4
ASGNI4
line 49
;48:
;49:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 51
;50:
;51:	if ( level.clients[playerClientNum].sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 1072
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $68
line 55
;52:#ifdef MISSIONPACK
;53:		Com_sprintf( msg, sizeof(msg), "postgame %i %i 0 0 0 0 0 0 0 0 0 0 0", level.numNonSpectatorClients, playerClientNum );
;54:#else
;55:		Com_sprintf( msg, sizeof(msg), "postgame %i %i 0 0 0 0 0 0", level.numNonSpectatorClients, playerClientNum );
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $70
ARGP4
ADDRGP4 level+80
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 57
;56:#endif
;57:	}
ADDRGP4 $69
JUMPV
LABELV $68
line 58
;58:	else {
line 59
;59:		if( player->client->accuracy_shots ) {
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $72
line 60
;60:			accuracy = player->client->accuracy_hits * 100 / player->client->accuracy_shots;
ADDRLP4 1076
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 724
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
DIVI4
ASGNI4
line 61
;61:		}
ADDRGP4 $73
JUMPV
LABELV $72
line 62
;62:		else {
line 63
;63:			accuracy = 0;
ADDRLP4 1076
CNSTI4 0
ASGNI4
line 64
;64:		}
LABELV $73
line 96
;65:#ifdef MISSIONPACK
;66:		won = qfalse;
;67:		if (g_gametype.integer >= GT_CTF) {
;68:			score1 = level.teamScores[TEAM_RED];
;69:			score2 = level.teamScores[TEAM_BLUE];
;70:			if (level.clients[playerClientNum].sess.sessionTeam	== TEAM_RED) {
;71:				won = (level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE]);
;72:			} else {
;73:				won = (level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED]);
;74:			}
;75:		} else {
;76:			if (&level.clients[playerClientNum] == &level.clients[ level.sortedClients[0] ]) {
;77:				won = qtrue;
;78:				score1 = level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE];
;79:				score2 = level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE];
;80:			} else {
;81:				score2 = level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE];
;82:				score1 = level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE];
;83:			}
;84:		}
;85:		if (won && player->client->ps.persistant[PERS_KILLED] == 0) {
;86:			perfect = 1;
;87:		} else {
;88:			perfect = 0;
;89:		}
;90:		Com_sprintf( msg, sizeof(msg), "postgame %i %i %i %i %i %i %i %i %i %i %i %i %i %i", level.numNonSpectatorClients, playerClientNum, accuracy,
;91:			player->client->ps.persistant[PERS_IMPRESSIVE_COUNT], player->client->ps.persistant[PERS_EXCELLENT_COUNT],player->client->ps.persistant[PERS_DEFEND_COUNT],
;92:			player->client->ps.persistant[PERS_ASSIST_COUNT], player->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], player->client->ps.persistant[PERS_SCORE],
;93:			perfect, score1, score2, level.time, player->client->ps.persistant[PERS_CAPTURES] );
;94:
;95:#else
;96:		perfect = ( level.clients[playerClientNum].ps.persistant[PERS_RANK] == 0 && player->client->ps.persistant[PERS_KILLED] == 0 ) ? 1 : 0;
ADDRLP4 1072
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $75
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
NEI4 $75
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $76
JUMPV
LABELV $75
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $76
ADDRLP4 1080
ADDRLP4 1084
INDIRI4
ASGNI4
line 97
;97:		Com_sprintf( msg, sizeof(msg), "postgame %i %i %i %i %i %i %i %i", level.numNonSpectatorClients, playerClientNum, accuracy,
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $77
ARGP4
ADDRGP4 level+80
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1076
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 1080
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 102
;98:			player->client->ps.persistant[PERS_IMPRESSIVE_COUNT], player->client->ps.persistant[PERS_EXCELLENT_COUNT],
;99:			player->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], player->client->ps.persistant[PERS_SCORE],
;100:			perfect );
;101:#endif
;102:	}
LABELV $69
line 104
;103:
;104:	msglen = (int)strlen( msg );
ADDRLP4 44
ARGP4
ADDRLP4 1084
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
ADDRLP4 1084
INDIRI4
ASGNI4
line 105
;105:	for( i = 0; i < level.numNonSpectatorClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $82
JUMPV
LABELV $79
line 106
;106:		n = level.sortedClients[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
ASGNI4
line 107
;107:		Com_sprintf( buf, sizeof(buf), " %i %i %i", n, level.clients[n].ps.persistant[PERS_RANK], level.clients[n].ps.persistant[PERS_SCORE] );
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $85
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRLP4 1092
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRLP4 1092
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 108
;108:		msglen += (int)strlen( buf );
ADDRLP4 8
ARGP4
ADDRLP4 1096
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
ADDRLP4 1068
INDIRI4
ADDRLP4 1096
INDIRI4
ADDI4
ASGNI4
line 109
;109:		if( msglen >= sizeof(msg)-1 ) {
ADDRLP4 1068
INDIRI4
CVIU4 4
CNSTU4 1023
LTU4 $86
line 110
;110:			break;
ADDRGP4 $81
JUMPV
LABELV $86
line 112
;111:		}
;112:		strcat( msg, buf );
ADDRLP4 44
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 113
;113:	}
LABELV $80
line 105
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $82
ADDRLP4 0
INDIRI4
ADDRGP4 level+80
INDIRI4
LTI4 $79
LABELV $81
line 114
;114:	trap_SendConsoleCommand( EXEC_APPEND, msg );
CNSTI4 2
ARGI4
ADDRLP4 44
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 115
;115:}
LABELV $54
endproc UpdateTournamentInfo 1100 44
proc SpawnModelOnVictoryPad 80 16
line 118
;116:
;117:
;118:static gentity_t *SpawnModelOnVictoryPad( gentity_t *pad, vec3_t offset, gentity_t *ent, int place ) {
line 123
;119:	gentity_t	*body;
;120:	vec3_t		vec;
;121:	vec3_t		f, r, u;
;122:
;123:	body = G_Spawn();
ADDRLP4 52
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 124
;124:	if ( !body ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $89
line 125
;125:		G_Printf( S_COLOR_RED "ERROR: out of gentities\n" );
ADDRGP4 $91
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 126
;126:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $88
JUMPV
LABELV $89
line 129
;127:	}
;128:
;129:	body->classname = ent->client->pers.netname;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ASGNP4
line 130
;130:	body->client = ent->client;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 131
;131:	body->s = ent->s;
ADDRLP4 0
INDIRP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 208
line 132
;132:	body->s.eType = ET_PLAYER;		// could be ET_INVISIBLE
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 133
;133:	body->s.eFlags = 0;				// clear EF_TALK, etc
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 134
;134:	body->s.powerups = 0;			// clear powerups
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:	body->s.loopSound = 0;			// clear lava burning
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 136
;136:	body->s.number = body - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 137
;137:	body->timestamp = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 138
;138:	body->physicsObject = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 139
;139:	body->physicsBounce = 0;		// don't bounce
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 0
ASGNF4
line 140
;140:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 141
;141:	body->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 142
;142:	body->s.groundEntityNum = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1022
ASGNI4
line 143
;143:	body->s.legsAnim = LEGS_IDLE;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 22
ASGNI4
line 144
;144:	body->s.torsoAnim = TORSO_STAND;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 11
ASGNI4
line 145
;145:	if( body->s.weapon == WP_NONE ) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
NEI4 $93
line 146
;146:		body->s.weapon = WP_MACHINEGUN;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 2
ASGNI4
line 147
;147:	}
LABELV $93
line 148
;148:	if( body->s.weapon == WP_GAUNTLET) {
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
NEI4 $95
line 149
;149:		body->s.torsoAnim = TORSO_STAND2;
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 12
ASGNI4
line 150
;150:	}
LABELV $95
line 151
;151:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 152
;152:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 153
;153:	VectorCopy (ent->r.mins, body->r.mins);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 154
;154:	VectorCopy (ent->r.maxs, body->r.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 155
;155:	VectorCopy (ent->r.absmin, body->r.absmin);
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 156
;156:	VectorCopy (ent->r.absmax, body->r.absmax);
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 157
;157:	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 65537
ASGNI4
line 158
;158:	body->r.contents = CONTENTS_BODY;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 159
;159:	body->r.ownerNum = ent->r.ownerNum;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 160
;160:	body->takedamage = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 162
;161:
;162:	VectorSubtract( level.intermission_origin, pad->r.currentOrigin, vec );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 level+7616
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 level+7616+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 163
;163:	vectoangles( vec, body->s.apos.trBase );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 164
;164:	body->s.apos.trBase[PITCH] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 165
;165:	body->s.apos.trBase[ROLL] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 0
ASGNF4
line 167
;166:
;167:	AngleVectors( body->s.apos.trBase, f, r, u );
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 168
;168:	VectorMA( pad->r.currentOrigin, offset[0], f, vec );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 64
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 68
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 64
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 68
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 169
;169:	VectorMA( vec, offset[1], r, vec );
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 170
;170:	VectorMA( vec, offset[2], u, vec );
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 172
;171:
;172:	G_SetOrigin( body, vec );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 174
;173:
;174:	trap_LinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 176
;175:
;176:	body->count = place;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 178
;177:
;178:	return body;
ADDRLP4 0
INDIRP4
RETP4
LABELV $88
endproc SpawnModelOnVictoryPad 80 16
proc CelebrateStop 8 0
line 182
;179:}
;180:
;181:
;182:static void CelebrateStop( gentity_t *player ) {
line 185
;183:	int		anim;
;184:
;185:	if( player->s.weapon == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
NEI4 $121
line 186
;186:		anim = TORSO_STAND2;
ADDRLP4 0
CNSTI4 12
ASGNI4
line 187
;187:	}
ADDRGP4 $122
JUMPV
LABELV $121
line 188
;188:	else {
line 189
;189:		anim = TORSO_STAND;
ADDRLP4 0
CNSTI4 11
ASGNI4
line 190
;190:	}
LABELV $122
line 191
;191:	player->s.torsoAnim = ( ( player->s.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 192
;192:}
LABELV $120
endproc CelebrateStop 8 0
proc CelebrateStart 4 12
line 196
;193:
;194:
;195:#define	TIMER_GESTURE	(34*66+50)
;196:static void CelebrateStart( gentity_t *player ) {
line 197
;197:	player->s.torsoAnim = ( ( player->s.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | TORSO_GESTURE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
CNSTI4 6
BORI4
ASGNI4
line 198
;198:	player->nextthink = level.time + TIMER_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2294
ADDI4
ASGNI4
line 199
;199:	player->think = CelebrateStop;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 CelebrateStop
ASGNP4
line 206
;200:
;201:	/*
;202:	player->client->ps.events[player->client->ps.eventSequence & (MAX_PS_EVENTS-1)] = EV_TAUNT;
;203:	player->client->ps.eventParms[player->client->ps.eventSequence & (MAX_PS_EVENTS-1)] = 0;
;204:	player->client->ps.eventSequence++;
;205:	*/
;206:	G_AddEvent(player, EV_TAUNT, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 76
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 207
;207:}
LABELV $123
endproc CelebrateStart 4 12
data
align 4
LABELV offsetFirst
byte 4 0
byte 4 0
byte 4 1116995584
align 4
LABELV offsetSecond
byte 4 3240099840
byte 4 1114636288
byte 4 1113063424
align 4
LABELV offsetThird
byte 4 3247964160
byte 4 3262119936
byte 4 1110704128
code
proc PodiumPlacementThink 88 16
line 214
;208:
;209:
;210:static vec3_t	offsetFirst  = {0, 0, 74};
;211:static vec3_t	offsetSecond = {-10, 60, 54};
;212:static vec3_t	offsetThird  = {-19, -60, 45};
;213:
;214:static void PodiumPlacementThink( gentity_t *podium ) {
line 219
;215:	vec3_t		vec;
;216:	vec3_t		origin;
;217:	vec3_t		f, r, u;
;218:
;219:	podium->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 221
;220:
;221:	AngleVectors( level.intermission_angle, vec, NULL, NULL );
ADDRGP4 level+7628
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
line 222
;222:	VectorMA( level.intermission_origin, trap_Cvar_VariableIntegerValue( "g_podiumDist" ), vec, origin );
ADDRGP4 $129
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 48
ADDRGP4 level+7616
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 $129
ARGP4
ADDRLP4 64
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 48+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 64
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 $129
ARGP4
ADDRLP4 68
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 48+8
ADDRGP4 level+7616+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 68
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 223
;223:	origin[2] -= trap_Cvar_VariableIntegerValue( "g_podiumDrop" );
ADDRGP4 $139
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 48+8
ADDRLP4 48+8
INDIRF4
ADDRLP4 72
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 224
;224:	G_SetOrigin( podium, origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 226
;225:
;226:	if( podium1 ) {
ADDRGP4 podium1
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $140
line 227
;227:		VectorSubtract( level.intermission_origin, podium->r.currentOrigin, vec );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRGP4 level+7616
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 level+7616+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 228
;228:		vectoangles( vec, podium1->s.apos.trBase );
ADDRLP4 0
ARGP4
ADDRGP4 podium1
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 229
;229:		podium1->s.apos.trBase[PITCH] = 0;
ADDRGP4 podium1
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 230
;230:		podium1->s.apos.trBase[ROLL] = 0;
ADDRGP4 podium1
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 0
ASGNF4
line 232
;231:
;232:		AngleVectors( podium1->s.apos.trBase, f, r, u );
ADDRGP4 podium1
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 233
;233:		VectorMA( podium->r.currentOrigin, offsetFirst[0], f, vec );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRGP4 offsetFirst
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 offsetFirst
INDIRF4
MULF4
ADDF4
ASGNF4
line 234
;234:		VectorMA( vec, offsetFirst[1], r, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 offsetFirst+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 offsetFirst+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 offsetFirst+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 235
;235:		VectorMA( vec, offsetFirst[2], u, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 offsetFirst+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 offsetFirst+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 offsetFirst+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 237
;236:
;237:		G_SetOrigin( podium1, vec );
ADDRGP4 podium1
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 238
;238:	}
LABELV $140
line 240
;239:
;240:	if( podium2 ) {
ADDRGP4 podium2
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $171
line 241
;241:		VectorSubtract( level.intermission_origin, podium->r.currentOrigin, vec );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRGP4 level+7616
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 level+7616+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 242
;242:		vectoangles( vec, podium2->s.apos.trBase );
ADDRLP4 0
ARGP4
ADDRGP4 podium2
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 243
;243:		podium2->s.apos.trBase[PITCH] = 0;
ADDRGP4 podium2
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 244
;244:		podium2->s.apos.trBase[ROLL] = 0;
ADDRGP4 podium2
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 0
ASGNF4
line 246
;245:
;246:		AngleVectors( podium2->s.apos.trBase, f, r, u );
ADDRGP4 podium2
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 247
;247:		VectorMA( podium->r.currentOrigin, offsetSecond[0], f, vec );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRGP4 offsetSecond
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 offsetSecond
INDIRF4
MULF4
ADDF4
ASGNF4
line 248
;248:		VectorMA( vec, offsetSecond[1], r, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 offsetSecond+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 offsetSecond+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 offsetSecond+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 249
;249:		VectorMA( vec, offsetSecond[2], u, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 offsetSecond+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 offsetSecond+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 offsetSecond+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 251
;250:
;251:		G_SetOrigin( podium2, vec );
ADDRGP4 podium2
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 252
;252:	}
LABELV $171
line 254
;253:
;254:	if( podium3 ) {
ADDRGP4 podium3
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $202
line 255
;255:		VectorSubtract( level.intermission_origin, podium->r.currentOrigin, vec );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRGP4 level+7616
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 level+7616+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 256
;256:		vectoangles( vec, podium3->s.apos.trBase );
ADDRLP4 0
ARGP4
ADDRGP4 podium3
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 257
;257:		podium3->s.apos.trBase[PITCH] = 0;
ADDRGP4 podium3
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 258
;258:		podium3->s.apos.trBase[ROLL] = 0;
ADDRGP4 podium3
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 0
ASGNF4
line 260
;259:
;260:		AngleVectors( podium3->s.apos.trBase, f, r, u );
ADDRGP4 podium3
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 261
;261:		VectorMA( podium->r.currentOrigin, offsetThird[0], f, vec );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRGP4 offsetThird
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 offsetThird
INDIRF4
MULF4
ADDF4
ASGNF4
line 262
;262:		VectorMA( vec, offsetThird[1], r, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 offsetThird+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 offsetThird+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 offsetThird+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 263
;263:		VectorMA( vec, offsetThird[2], u, vec );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 offsetThird+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 offsetThird+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 offsetThird+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 265
;264:
;265:		G_SetOrigin( podium3, vec );
ADDRGP4 podium3
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 266
;266:	}
LABELV $202
line 267
;267:}
LABELV $125
endproc PodiumPlacementThink 88 16
proc SpawnPodium 64 16
line 270
;268:
;269:
;270:static gentity_t *SpawnPodium( void ) {
line 275
;271:	gentity_t	*podium;
;272:	vec3_t		vec;
;273:	vec3_t		origin;
;274:
;275:	podium = G_Spawn();
ADDRLP4 28
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 276
;276:	if ( !podium ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $234
line 277
;277:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $233
JUMPV
LABELV $234
line 280
;278:	}
;279:
;280:	podium->classname = "podium";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $236
ASGNP4
line 281
;281:	podium->s.eType = ET_GENERAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 282
;282:	podium->s.number = podium - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 283
;283:	podium->clipmask = CONTENTS_SOLID;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 1
ASGNI4
line 284
;284:	podium->r.contents = CONTENTS_SOLID;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1
ASGNI4
line 285
;285:	podium->s.modelindex = G_ModelIndex( SP_PODIUM_MODEL );
ADDRGP4 $237
ARGP4
ADDRLP4 36
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 287
;286:
;287:	AngleVectors( level.intermission_angle, vec, NULL, NULL );
ADDRGP4 level+7628
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 288
;288:	VectorMA( level.intermission_origin, trap_Cvar_VariableIntegerValue( "g_podiumDist" ), vec, origin );
ADDRGP4 $129
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 level+7616
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 $129
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 16+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 $129
ARGP4
ADDRLP4 48
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 16+8
ADDRGP4 level+7616+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 48
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 289
;289:	origin[2] -= trap_Cvar_VariableIntegerValue( "g_podiumDrop" );
ADDRGP4 $139
ARGP4
ADDRLP4 52
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 52
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 290
;290:	G_SetOrigin( podium, origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 292
;291:
;292:	VectorSubtract( level.intermission_origin, podium->r.currentOrigin, vec );
ADDRLP4 4
ADDRGP4 level+7616
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 level+7616+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 level+7616+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 293
;293:	podium->s.apos.trBase[YAW] = vectoyaw( vec );
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 294
;294:	trap_LinkEntity (podium);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 296
;295:
;296:	podium->think = PodiumPlacementThink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 PodiumPlacementThink
ASGNP4
line 297
;297:	podium->nextthink = level.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 298
;298:	return podium;
ADDRLP4 0
INDIRP4
RETP4
LABELV $233
endproc SpawnPodium 64 16
export SpawnModelsOnVictoryPads
proc SpawnModelsOnVictoryPads 24 16
line 307
;299:}
;300:
;301:
;302:/*
;303:==================
;304:SpawnModelsOnVictoryPads
;305:==================
;306:*/
;307:void SpawnModelsOnVictoryPads( void ) {
line 311
;308:	gentity_t	*player;
;309:	gentity_t	*podium;
;310:
;311:	podium1 = NULL;
ADDRGP4 podium1
CNSTP4 0
ASGNP4
line 312
;312:	podium2 = NULL;
ADDRGP4 podium2
CNSTP4 0
ASGNP4
line 313
;313:	podium3 = NULL;
ADDRGP4 podium3
CNSTP4 0
ASGNP4
line 315
;314:
;315:	podium = SpawnPodium();
ADDRLP4 8
ADDRGP4 SpawnPodium
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 317
;316:
;317:	player = SpawnModelOnVictoryPad( podium, offsetFirst, &g_entities[level.sortedClients[0]],
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 offsetFirst
ARGP4
ADDRGP4 level+88
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 level+88
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
ARGI4
ADDRLP4 12
ADDRGP4 SpawnModelOnVictoryPad
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 319
;318:				level.clients[ level.sortedClients[0] ].ps.persistant[PERS_RANK] &~ RANK_TIED_FLAG );
;319:	if ( player ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
line 320
;320:		player->nextthink = level.time + 2000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 321
;321:		player->think = CelebrateStart;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 CelebrateStart
ASGNP4
line 322
;322:		podium1 = player;
ADDRGP4 podium1
ADDRLP4 0
INDIRP4
ASGNP4
line 323
;323:	}
LABELV $260
line 325
;324:
;325:	player = SpawnModelOnVictoryPad( podium, offsetSecond, &g_entities[level.sortedClients[1]],
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 offsetSecond
ARGP4
ADDRGP4 level+88+4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 level+88+4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
ARGI4
ADDRLP4 16
ADDRGP4 SpawnModelOnVictoryPad
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 327
;326:				level.clients[ level.sortedClients[1] ].ps.persistant[PERS_RANK] &~ RANK_TIED_FLAG );
;327:	if ( player ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $267
line 328
;328:		podium2 = player;
ADDRGP4 podium2
ADDRLP4 0
INDIRP4
ASGNP4
line 329
;329:	}
LABELV $267
line 331
;330:
;331:	if ( level.numNonSpectatorClients > 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
LEI4 $269
line 332
;332:		player = SpawnModelOnVictoryPad( podium, offsetThird, &g_entities[level.sortedClients[2]],
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 offsetThird
ARGP4
ADDRGP4 level+88+8
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 level+88+8
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
ARGI4
ADDRLP4 20
ADDRGP4 SpawnModelOnVictoryPad
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 334
;333:				level.clients[ level.sortedClients[2] ].ps.persistant[PERS_RANK] &~ RANK_TIED_FLAG );
;334:		if ( player ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $276
line 335
;335:			podium3 = player;
ADDRGP4 podium3
ADDRLP4 0
INDIRP4
ASGNP4
line 336
;336:		}
LABELV $276
line 337
;337:	}
LABELV $269
line 338
;338:}
LABELV $257
endproc SpawnModelsOnVictoryPads 24 16
export Svcmd_AbortPodium_f
proc Svcmd_AbortPodium_f 0 0
line 346
;339:
;340:
;341:/*
;342:===============
;343:Svcmd_AbortPodium_f
;344:===============
;345:*/
;346:void Svcmd_AbortPodium_f( void ) {
line 347
;347:	if( g_gametype.integer != GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $279
line 348
;348:		return;
ADDRGP4 $278
JUMPV
LABELV $279
line 351
;349:	}
;350:
;351:	if( podium1 ) {
ADDRGP4 podium1
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
line 352
;352:		podium1->nextthink = level.time;
ADDRGP4 podium1
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 353
;353:		podium1->think = CelebrateStop;
ADDRGP4 podium1
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 CelebrateStop
ASGNP4
line 354
;354:	}
LABELV $282
line 355
;355:}
LABELV $278
endproc Svcmd_AbortPodium_f 0 0
bss
export podium3
align 4
LABELV podium3
skip 4
export podium2
align 4
LABELV podium2
skip 4
export podium1
align 4
LABELV podium1
skip 4
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
LABELV $237
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
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 47
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 52
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $236
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $139
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $129
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $91
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 103
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $77
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $70
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 0
