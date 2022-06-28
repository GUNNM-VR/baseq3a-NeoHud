data
align 4
LABELV gameCvarTable
address g_cheats
address $55
address $56
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
address $57
address $58
byte 4 68
byte 4 0
byte 4 0
skip 4
byte 4 0
address $59
address $60
byte 4 64
byte 4 0
byte 4 0
skip 4
address g_mapname
address $61
address $56
byte 4 68
byte 4 0
byte 4 0
skip 4
address sv_fps
address $62
address $63
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_gametype
address $64
address $65
byte 4 38
byte 4 0
byte 4 0
skip 4
address g_maxclients
address $66
address $67
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_maxGameClients
address $68
address $65
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_dmflags
address $69
address $65
byte 4 5
byte 4 0
byte 4 1
skip 4
address g_fraglimit
address $70
address $71
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_timelimit
address $72
address $65
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_capturelimit
address $73
address $67
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_synchronousClients
address $74
address $65
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_friendlyFire
address $75
address $65
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_autoJoin
address $76
address $77
byte 4 1
skip 12
address g_teamForceBalance
address $78
address $65
byte 4 1
skip 12
address g_warmup
address $79
address $71
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_log
address $80
address $81
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_logSync
address $82
address $65
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_password
address $83
address $56
byte 4 2
byte 4 0
byte 4 0
skip 4
address g_banIPs
address $84
address $56
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_filterBan
address $85
address $77
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_needpass
address $86
address $65
byte 4 68
byte 4 0
byte 4 0
skip 4
address g_dedicated
address $87
address $65
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_speed
address $88
address $89
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_gravity
address $90
address $91
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_knockback
address $92
address $93
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_quadfactor
address $94
address $95
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponRespawn
address $96
address $97
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponTeamRespawn
address $98
address $63
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_forcerespawn
address $99
address $71
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_inactivity
address $100
address $65
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_debugMove
address $101
address $65
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugDamage
address $102
address $65
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugAlloc
address $103
address $65
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_motd
address $104
address $56
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_blood
address $105
address $77
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDist
address $106
address $107
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDrop
address $108
address $109
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_allowVote
address $110
address $77
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_listEntity
address $111
address $65
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_unlagged
address $112
address $77
byte 4 5
byte 4 0
byte 4 0
skip 4
address g_predictPVS
address $113
address $65
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_smoothClients
address $114
address $77
byte 4 0
byte 4 0
byte 4 0
skip 4
address pmove_fixed
address $115
address $65
byte 4 8
byte 4 0
byte 4 0
skip 4
address pmove_msec
address $116
address $67
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_rotation
address $117
address $56
byte 4 1
byte 4 0
byte 4 0
skip 4
export vmMain
code
proc vmMain 16 12
file "..\..\..\..\code\game\g_main.c"
line 195
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:level_locals_t	level;
;7:
;8:typedef struct {
;9:	vmCvar_t	*vmCvar;
;10:	const char	*cvarName;
;11:	const char	*defaultString;
;12:	int			cvarFlags;
;13:	int			modificationCount;	// for tracking changes
;14:	qboolean	trackChange;		// track this variable, and announce if changed
;15:	qboolean	teamShader;			// track and if changed, update shader state
;16:} cvarTable_t;
;17:
;18:gentity_t		g_entities[MAX_GENTITIES];
;19:gclient_t		g_clients[MAX_CLIENTS];
;20:
;21:vmCvar_t	g_gametype;
;22:vmCvar_t	g_dmflags;
;23:vmCvar_t	g_fraglimit;
;24:vmCvar_t	g_timelimit;
;25:vmCvar_t	g_capturelimit;
;26:vmCvar_t	g_friendlyFire;
;27:vmCvar_t	g_password;
;28:vmCvar_t	g_needpass;
;29:vmCvar_t	g_mapname;
;30:vmCvar_t	sv_fps;
;31:vmCvar_t	g_maxclients;
;32:vmCvar_t	g_maxGameClients;
;33:vmCvar_t	g_dedicated;
;34:vmCvar_t	g_speed;
;35:vmCvar_t	g_gravity;
;36:vmCvar_t	g_cheats;
;37:vmCvar_t	g_knockback;
;38:vmCvar_t	g_quadfactor;
;39:vmCvar_t	g_forcerespawn;
;40:vmCvar_t	g_inactivity;
;41:vmCvar_t	g_debugMove;
;42:vmCvar_t	g_debugDamage;
;43:vmCvar_t	g_debugAlloc;
;44:vmCvar_t	g_weaponRespawn;
;45:vmCvar_t	g_weaponTeamRespawn;
;46:vmCvar_t	g_motd;
;47:vmCvar_t	g_synchronousClients;
;48:vmCvar_t	g_warmup;
;49:vmCvar_t	g_predictPVS;
;50://vmCvar_t	g_restarted;
;51:vmCvar_t	g_log;
;52:vmCvar_t	g_logSync;
;53:vmCvar_t	g_blood;
;54:vmCvar_t	g_podiumDist;
;55:vmCvar_t	g_podiumDrop;
;56:vmCvar_t	g_allowVote;
;57:vmCvar_t	g_autoJoin;
;58:vmCvar_t	g_teamForceBalance;
;59:vmCvar_t	g_banIPs;
;60:vmCvar_t	g_filterBan;
;61:vmCvar_t	g_smoothClients;
;62:vmCvar_t	g_rotation;
;63:vmCvar_t	g_unlagged;
;64:vmCvar_t	pmove_fixed;
;65:vmCvar_t	pmove_msec;
;66:vmCvar_t	g_listEntity;
;67:#ifdef MISSIONPACK
;68:vmCvar_t	g_obeliskHealth;
;69:vmCvar_t	g_obeliskRegenPeriod;
;70:vmCvar_t	g_obeliskRegenAmount;
;71:vmCvar_t	g_obeliskRespawnDelay;
;72:vmCvar_t	g_cubeTimeout;
;73:vmCvar_t	g_redteam;
;74:vmCvar_t	g_blueteam;
;75:vmCvar_t	g_singlePlayer;
;76:vmCvar_t	g_enableDust;
;77:vmCvar_t	g_enableBreath;
;78:vmCvar_t	g_proxMineTimeout;
;79:#endif
;80:
;81:
;82:static cvarTable_t gameCvarTable[] = {
;83:	// don't override the cheat state set by the system
;84:	{ &g_cheats, "sv_cheats", "", 0, 0, qfalse },
;85:
;86:	// noset vars
;87:	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;88:	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },
;89:	//{ &g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse  },
;90:	{ &g_mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;91:	{ &sv_fps, "sv_fps", "30", CVAR_ARCHIVE, 0, qfalse  },
;92:
;93:	// latched vars
;94:	{ &g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse  },
;95:
;96:	{ &g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;97:	{ &g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;98:
;99:	// change anytime vars
;100:	{ &g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue  },
;101:	{ &g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;102:	{ &g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;103:	{ &g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;104:
;105:	{ &g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse  },
;106:
;107:	{ &g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue  },
;108:
;109:	{ &g_autoJoin, "g_autoJoin", "1", CVAR_ARCHIVE  },
;110:	{ &g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE  },
;111:
;112:	{ &g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue  },
;113:	{ &g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse  },
;114:	{ &g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse  },
;115:
;116:	{ &g_password, "g_password", "", CVAR_USERINFO, 0, qfalse  },
;117:
;118:	{ &g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse  },
;119:	{ &g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse  },
;120:
;121:	{ &g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },
;122:
;123:	{ &g_dedicated, "dedicated", "0", 0, 0, qfalse  },
;124:
;125:	{ &g_speed, "g_speed", "320", 0, 0, qtrue  },
;126:	{ &g_gravity, "g_gravity", "800", 0, 0, qtrue  },
;127:	{ &g_knockback, "g_knockback", "1000", 0, 0, qtrue  },
;128:	{ &g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue  },
;129:	{ &g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue  },
;130:	{ &g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue },
;131:	{ &g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue },
;132:	{ &g_inactivity, "g_inactivity", "0", 0, 0, qtrue },
;133:	{ &g_debugMove, "g_debugMove", "0", 0, 0, qfalse },
;134:	{ &g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse },
;135:	{ &g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse },
;136:	{ &g_motd, "g_motd", "", 0, 0, qfalse },
;137:	{ &g_blood, "com_blood", "1", 0, 0, qfalse },
;138:
;139:	{ &g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse },
;140:	{ &g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse },
;141:
;142:	{ &g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse },
;143:	{ &g_listEntity, "g_listEntity", "0", 0, 0, qfalse },
;144:
;145:	{ &g_unlagged, "g_unlagged", "1", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qfalse },
;146:	{ &g_predictPVS, "g_predictPVS", "0", CVAR_ARCHIVE, 0, qfalse },
;147:
;148:#ifdef MISSIONPACK
;149:	{ &g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse },
;150:	{ &g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse },
;151:	{ &g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse },
;152:	{ &g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse },
;153:
;154:	{ &g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse },
;155:	{ &g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue },
;156:	{ &g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue  },
;157:	{ &g_singlePlayer, "ui_singlePlayerActive", "", 0, 0, qfalse, qfalse  },
;158:
;159:	{ &g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;160:	{ &g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;161:	{ &g_proxMineTimeout, "g_proxMineTimeout", "20000", 0, 0, qfalse },
;162:#endif
;163:	{ &g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse},
;164:	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse},
;165:	{ &pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse},
;166:
;167:	{ &g_rotation, "g_rotation", "", CVAR_ARCHIVE, 0, qfalse }
;168:
;169:};
;170:
;171:
;172:static void G_InitGame( int levelTime, int randomSeed, int restart );
;173:static void G_RunFrame( int levelTime );
;174:static void G_ShutdownGame( int restart );
;175:static void CheckExitRules( void );
;176:static void SendScoreboardMessageToAllClients( void );
;177:
;178:// extension interface
;179:#ifdef Q3_VM
;180:qboolean (*trap_GetValue)( char *value, int valueSize, const char *key );
;181:#else
;182:int dll_com_trapGetValue;
;183:#endif
;184:
;185:int	svf_self_portal2;
;186:
;187:/*
;188:================
;189:vmMain
;190:
;191:This is the only way control passes into the module.
;192:This must be the very first function compiled into the .q3vm file
;193:================
;194:*/
;195:DLLEXPORT intptr_t vmMain( int command, int arg0, int arg1, int arg2 ) {
line 196
;196:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $119
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $119
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $132
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $132
address $121
address $122
address $123
address $127
address $125
address $126
address $128
address $124
address $129
address $130
address $131
code
LABELV $121
line 198
;197:	case GAME_INIT:
;198:		G_InitGame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 G_InitGame
CALLV
pop
line 199
;199:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $122
line 201
;200:	case GAME_SHUTDOWN:
;201:		G_ShutdownGame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_ShutdownGame
CALLV
pop
line 202
;202:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $123
line 204
;203:	case GAME_CLIENT_CONNECT:
;204:		return (intptr_t)ClientConnect( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CVUI4 4
RETI4
ADDRGP4 $118
JUMPV
LABELV $124
line 206
;205:	case GAME_CLIENT_THINK:
;206:		ClientThink( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientThink
CALLV
pop
line 207
;207:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $125
line 209
;208:	case GAME_CLIENT_USERINFO_CHANGED:
;209:		ClientUserinfoChanged( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 210
;210:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $126
line 212
;211:	case GAME_CLIENT_DISCONNECT:
;212:		ClientDisconnect( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientDisconnect
CALLV
pop
line 213
;213:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $127
line 215
;214:	case GAME_CLIENT_BEGIN:
;215:		ClientBegin( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 216
;216:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $128
line 218
;217:	case GAME_CLIENT_COMMAND:
;218:		ClientCommand( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientCommand
CALLV
pop
line 219
;219:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $129
line 221
;220:	case GAME_RUN_FRAME:
;221:		G_RunFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_RunFrame
CALLV
pop
line 222
;222:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $130
line 224
;223:	case GAME_CONSOLE_COMMAND:
;224:		return ConsoleCommand();
ADDRLP4 8
ADDRGP4 ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $118
JUMPV
LABELV $131
line 226
;225:	case BOTAI_START_FRAME:
;226:		return BotAIStartFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 BotAIStartFrame
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $118
JUMPV
LABELV $119
line 229
;227:	}
;228:
;229:	return -1;
CNSTI4 -1
RETI4
LABELV $118
endproc vmMain 16 12
export G_Printf
proc G_Printf 8204 12
line 233
;230:}
;231:
;232:
;233:void QDECL G_Printf( const char *fmt, ... ) {
line 238
;234:	va_list		argptr;
;235:	char		text[BIG_INFO_STRING];
;236:	int			len;
;237:
;238:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 239
;239:	len = ED_vsprintf( text, fmt, argptr );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8200
ADDRGP4 ED_vsprintf
CALLI4
ASGNI4
ADDRLP4 8196
ADDRLP4 8200
INDIRI4
ASGNI4
line 240
;240:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 242
;241:
;242:	text[4095] = '\0'; // truncate to 1.32b/c max print buffer size
ADDRLP4 4+4095
CNSTI1 0
ASGNI1
line 244
;243:
;244:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 245
;245:}
LABELV $133
endproc G_Printf 8204 12
export G_BroadcastServerCommand
proc G_BroadcastServerCommand 4 8
line 248
;246:
;247:
;248:void G_BroadcastServerCommand( int ignoreClient, const char *command ) {
line 250
;249:	int i;
;250:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $140
JUMPV
LABELV $137
line 251
;251:		if ( i == ignoreClient )
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $142
line 252
;252:			continue;
ADDRGP4 $138
JUMPV
LABELV $142
line 253
;253:		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $144
line 254
;254:			trap_SendServerCommand( i, command );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 255
;255:		}
LABELV $144
line 256
;256:	}
LABELV $138
line 250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $140
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $137
line 257
;257:}
LABELV $136
endproc G_BroadcastServerCommand 4 8
export G_Error
proc G_Error 1028 12
line 260
;258:
;259:
;260:void QDECL G_Error( const char *fmt, ... ) {
line 264
;261:	va_list		argptr;
;262:	char		text[1024];
;263:
;264:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 265
;265:	ED_vsprintf( text, fmt, argptr );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 266
;266:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 268
;267:
;268:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 269
;269:}
LABELV $146
endproc G_Error 1028 12
export G_FindTeams
proc G_FindTeams 36 12
line 283
;270:
;271:
;272:/*
;273:================
;274:G_FindTeams
;275:
;276:Chain together all entities with a matching team field.
;277:Entity teams are used for item groups and multi-entity mover groups.
;278:
;279:All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
;280:All but the last will have the teamchain field set to the next one
;281:================
;282:*/
;283:void G_FindTeams( void ) {
line 288
;284:	gentity_t	*e, *e2;
;285:	int		i, j;
;286:	int		c, c2;
;287:
;288:	c = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 289
;289:	c2 = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 290
;290:	for ( i=MAX_CLIENTS, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
ADDRLP4 16
CNSTI4 64
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
ADDRGP4 $152
JUMPV
LABELV $149
line 291
;291:		if (!e->inuse)
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $154
line 292
;292:			continue;
ADDRGP4 $150
JUMPV
LABELV $154
line 293
;293:		if (!e->team)
ADDRLP4 4
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $156
line 294
;294:			continue;
ADDRGP4 $150
JUMPV
LABELV $156
line 295
;295:		if (e->flags & FL_TEAMSLAVE)
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $158
line 296
;296:			continue;
ADDRGP4 $150
JUMPV
LABELV $158
line 297
;297:		e->teammaster = e;
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 298
;298:		c++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 299
;299:		c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 300
;300:		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
ADDRGP4 $163
JUMPV
LABELV $160
line 301
;301:		{
line 302
;302:			if (!e2->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $165
line 303
;303:				continue;
ADDRGP4 $161
JUMPV
LABELV $165
line 304
;304:			if (!e2->team)
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $167
line 305
;305:				continue;
ADDRGP4 $161
JUMPV
LABELV $167
line 306
;306:			if (e2->flags & FL_TEAMSLAVE)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $169
line 307
;307:				continue;
ADDRGP4 $161
JUMPV
LABELV $169
line 308
;308:			if (!strcmp(e->team, e2->team))
ADDRLP4 4
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $171
line 309
;309:			{
line 310
;310:				c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 311
;311:				e2->teamchain = e->teamchain;
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
line 312
;312:				e->teamchain = e2;
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 313
;313:				e2->teammaster = e;
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 314
;314:				e2->flags |= FL_TEAMSLAVE;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 317
;315:
;316:				// make sure that targets only point at the master
;317:				if ( e2->targetname ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $173
line 318
;318:					e->targetname = e2->targetname;
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
ASGNP4
line 319
;319:					e2->targetname = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTP4 0
ASGNP4
line 320
;320:				}
LABELV $173
line 321
;321:			}
LABELV $171
line 322
;322:		}
LABELV $161
line 300
ADDRLP4 8
ADDRLP4 8
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
LABELV $163
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $160
line 323
;323:	}
LABELV $150
line 290
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $152
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $149
line 325
;324:
;325:	G_Printf ("%i teams with %i entities\n", c, c2);
ADDRGP4 $175
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 326
;326:}
LABELV $148
endproc G_FindTeams 36 12
export G_RemapTeamShaders
proc G_RemapTeamShaders 0 0
line 329
;327:
;328:
;329:void G_RemapTeamShaders( void ) {
line 341
;330:#ifdef MISSIONPACK
;331:	char string[1024];
;332:	float f = level.time * 0.001;
;333:	Com_sprintf( string, sizeof(string), "team_icon/%s_red", g_redteam.string );
;334:	AddRemap("textures/ctf2/redteam01", string, f); 
;335:	AddRemap("textures/ctf2/redteam02", string, f); 
;336:	Com_sprintf( string, sizeof(string), "team_icon/%s_blue", g_blueteam.string );
;337:	AddRemap("textures/ctf2/blueteam01", string, f); 
;338:	AddRemap("textures/ctf2/blueteam02", string, f); 
;339:	trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
;340:#endif
;341:}
LABELV $176
endproc G_RemapTeamShaders 0 0
export G_RegisterCvars
proc G_RegisterCvars 20 16
line 349
;342:
;343:
;344:/*
;345:=================
;346:G_RegisterCvars
;347:=================
;348:*/
;349:void G_RegisterCvars( void ) {
line 350
;350:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 354
;351:	cvarTable_t *cv;
;352:	int i;
;353:
;354:	for ( i = 0, cv = gameCvarTable ; i < ARRAY_LEN( gameCvarTable ) ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $181
JUMPV
LABELV $178
line 355
;355:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
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
line 357
;356:			cv->defaultString, cv->cvarFlags );
;357:		if ( cv->vmCvar )
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $182
line 358
;358:			cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
LABELV $182
line 360
;359:
;360:		if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $184
line 361
;361:			remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 362
;362:		}
LABELV $184
line 363
;363:	}
LABELV $179
line 354
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $181
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 47
LTU4 $178
line 365
;364:
;365:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $186
line 366
;366:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 367
;367:	}
LABELV $186
line 370
;368:
;369:	// check some things
;370:	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $192
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
LTI4 $188
LABELV $192
line 371
;371:		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
ADDRGP4 $193
ARGP4
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 372
;372:		trap_Cvar_Set( "g_gametype", "0" );
ADDRGP4 $64
ARGP4
ADDRGP4 $65
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 373
;373:		trap_Cvar_Update( &g_gametype );
ADDRGP4 g_gametype
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 374
;374:	}
LABELV $188
line 376
;375:
;376:	level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+356
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 379
;377:
;378:	// force g_doWarmup to 1
;379:	trap_Cvar_Register( NULL, "g_doWarmup", "1", CVAR_ROM );
CNSTP4 0
ARGP4
ADDRGP4 $197
ARGP4
ADDRGP4 $77
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 380
;380:	trap_Cvar_Set( "g_doWarmup", "1" );
ADDRGP4 $197
ARGP4
ADDRGP4 $77
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 381
;381:}
LABELV $177
endproc G_RegisterCvars 20 16
proc G_UpdateCvars 28 12
line 389
;382:
;383:
;384:/*
;385:=================
;386:G_UpdateCvars
;387:=================
;388:*/
;389:static void G_UpdateCvars( void ) {
line 392
;390:	int			i;
;391:	cvarTable_t	*cv;
;392:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 394
;393:
;394:	for ( i = 0, cv = gameCvarTable ; i < ARRAY_LEN( gameCvarTable ) ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $202
JUMPV
LABELV $199
line 395
;395:		if ( cv->vmCvar ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
line 396
;396:			trap_Cvar_Update( cv->vmCvar );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 398
;397:
;398:			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
EQI4 $205
line 399
;399:				cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 401
;400:
;401:				if ( cv->trackChange ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $207
line 402
;402:					G_BroadcastServerCommand( -1, va("print \"Server: %s changed to %s\n\"", 
ADDRGP4 $209
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 404
;403:						cv->cvarName, cv->vmCvar->string ) );
;404:				}
LABELV $207
line 406
;405:
;406:				if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $210
line 407
;407:					remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 408
;408:				}
LABELV $210
line 409
;409:			}
LABELV $205
line 410
;410:		}
LABELV $203
line 411
;411:	}
LABELV $200
line 394
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $202
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 47
LTU4 $199
line 413
;412:
;413:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $212
line 414
;414:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 415
;415:	}
LABELV $212
line 416
;416:}
LABELV $198
endproc G_UpdateCvars 28 12
proc G_LocateSpawnSpots 44 12
line 420
;417:
;418:
;419:static void G_LocateSpawnSpots( void ) 
;420:{
line 424
;421:	gentity_t			*ent;
;422:	int i, n;
;423:
;424:	level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] = NULL;
ADDRGP4 level+7688+4092
CNSTP4 0
ASGNP4
line 427
;425:
;426:	// locate all spawn spots
;427:	n = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 428
;428:	ent = g_entities + MAX_CLIENTS;
ADDRLP4 0
ADDRGP4 g_entities+52224
ASGNP4
line 429
;429:	for ( i = MAX_CLIENTS; i < MAX_GENTITIES; i++, ent++ ) {
ADDRLP4 8
CNSTI4 64
ASGNI4
LABELV $218
line 431
;430:		
;431:		if ( !ent->inuse || !ent->classname )
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $224
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $222
LABELV $224
line 432
;432:			continue;
ADDRGP4 $219
JUMPV
LABELV $222
line 435
;433:
;434:		// intermission/ffa spots
;435:		if ( !Q_stricmpn( ent->classname, "info_player_", 12 ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $227
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 16
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $225
line 436
;436:			if ( !Q_stricmp( ent->classname+12, "intermission" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 $230
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $228
line 437
;437:				if ( level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] == NULL ) {
ADDRGP4 level+7688+4092
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $219
line 438
;438:					level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] = ent; // put in the last slot
ADDRGP4 level+7688+4092
ADDRLP4 0
INDIRP4
ASGNP4
line 439
;439:					ent->fteam = TEAM_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 0
ASGNI4
line 440
;440:				}
line 441
;441:				continue;
ADDRGP4 $219
JUMPV
LABELV $228
line 443
;442:			}
;443:			if ( !Q_stricmp( ent->classname+12, "deathmatch" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 $239
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $219
line 444
;444:				level.spawnSpots[n] = ent; n++;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7688
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 445
;445:				level.numSpawnSpotsFFA++;
ADDRLP4 28
ADDRGP4 level+11792
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 446
;446:				ent->fteam = TEAM_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 0
ASGNI4
line 447
;447:				ent->count = 1;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 448
;448:				continue;
ADDRGP4 $219
JUMPV
line 450
;449:			}
;450:			continue;
LABELV $225
line 454
;451:		}
;452:
;453:		// team spawn spots
;454:		if ( !Q_stricmpn( ent->classname, "team_CTF_", 9 ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $244
ARGP4
CNSTI4 9
ARGI4
ADDRLP4 20
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $242
line 455
;455:			if ( !Q_stricmp( ent->classname+9, "redspawn" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 9
ADDP4
ARGP4
ADDRGP4 $247
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $245
line 456
;456:				level.spawnSpots[n] = ent; n++;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7688
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 457
;457:				level.numSpawnSpotsTeam++;
ADDRLP4 28
ADDRGP4 level+11788
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 458
;458:				ent->fteam = TEAM_RED;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 1
ASGNI4
line 459
;459:				ent->count = 1; // means its not initial spawn point
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 460
;460:				continue;
ADDRGP4 $219
JUMPV
LABELV $245
line 462
;461:			}
;462:			if ( !Q_stricmp( ent->classname+9, "bluespawn" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 9
ADDP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $250
line 463
;463:				level.spawnSpots[n] = ent; n++;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7688
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 464
;464:				level.numSpawnSpotsTeam++;
ADDRLP4 32
ADDRGP4 level+11788
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 465
;465:				ent->fteam = TEAM_BLUE;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 2
ASGNI4
line 466
;466:				ent->count = 1;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 467
;467:				continue;
ADDRGP4 $219
JUMPV
LABELV $250
line 470
;468:			}
;469:			// base spawn spots
;470:			if ( !Q_stricmp( ent->classname+9, "redplayer" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 9
ADDP4
ARGP4
ADDRGP4 $257
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $255
line 471
;471:				level.spawnSpots[n] = ent; n++;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7688
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 472
;472:				level.numSpawnSpotsTeam++;
ADDRLP4 36
ADDRGP4 level+11788
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 473
;473:				ent->fteam = TEAM_RED;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 1
ASGNI4
line 474
;474:				ent->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 475
;475:				continue;
ADDRGP4 $219
JUMPV
LABELV $255
line 477
;476:			}
;477:			if ( !Q_stricmp( ent->classname+9, "blueplayer" ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 9
ADDP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $260
line 478
;478:				level.spawnSpots[n] = ent; n++;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7688
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 479
;479:				level.numSpawnSpotsTeam++;
ADDRLP4 40
ADDRGP4 level+11788
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 480
;480:				ent->fteam = TEAM_BLUE;
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 2
ASGNI4
line 481
;481:				ent->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 482
;482:				continue;
LABELV $260
line 484
;483:			}
;484:		}
LABELV $242
line 485
;485:	}
LABELV $219
line 429
ADDRLP4 8
ADDRLP4 8
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
ADDRLP4 8
INDIRI4
CNSTI4 1024
LTI4 $218
line 486
;486:	level.numSpawnSpots = n;
ADDRGP4 level+11784
ADDRLP4 4
INDIRI4
ASGNI4
line 487
;487:}
LABELV $214
endproc G_LocateSpawnSpots 44 12
proc G_InitGame 1288 20
line 496
;488:
;489:
;490:/*
;491:============
;492:G_InitGame
;493:
;494:============
;495:*/
;496:static void G_InitGame( int levelTime, int randomSeed, int restart ) {
line 500
;497:	char value[ MAX_CVAR_VALUE_STRING ];
;498:	int	i;
;499:
;500:	G_Printf ("------- Game Initialization -------\n");
ADDRGP4 $267
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 501
;501:	G_Printf ("gamename: %s\n", GAMEVERSION);
ADDRGP4 $268
ARGP4
ADDRGP4 $58
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 502
;502:	G_Printf ("gamedate: %s\n", __DATE__);
ADDRGP4 $269
ARGP4
ADDRGP4 $60
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 505
;503:
;504:	// extension interface
;505:	trap_Cvar_VariableStringBuffer( "//trap_GetValue", value, sizeof( value ) );
ADDRGP4 $270
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 506
;506:	if ( value[0] ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $271
line 508
;507:#ifdef Q3_VM
;508:		trap_GetValue = (void*)~atoi( value );
ADDRLP4 4
ARGP4
ADDRLP4 260
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_GetValue
ADDRLP4 260
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 512
;509:#else
;510:		dll_com_trapGetValue = atoi( value );
;511:#endif
;512:		if ( trap_GetValue( value, sizeof( value ), "SVF_SELF_PORTAL2_Q3E" ) ) {
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $275
ARGP4
ADDRLP4 264
ADDRGP4 trap_GetValue
INDIRP4
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $273
line 513
;513:			svf_self_portal2 = atoi( value );
ADDRLP4 4
ARGP4
ADDRLP4 268
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 svf_self_portal2
ADDRLP4 268
INDIRI4
ASGNI4
line 514
;514:		} else {
ADDRGP4 $274
JUMPV
LABELV $273
line 515
;515:			svf_self_portal2 = 0;
ADDRGP4 svf_self_portal2
CNSTI4 0
ASGNI4
line 516
;516:		}
LABELV $274
line 517
;517:	}
LABELV $271
line 519
;518:
;519:	srand( randomSeed );
ADDRFP4 4
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 srand
CALLV
pop
line 521
;520:
;521:	G_RegisterCvars();
ADDRGP4 G_RegisterCvars
CALLV
pop
line 523
;522:
;523:	G_ProcessIPBans();
ADDRGP4 G_ProcessIPBans
CALLV
pop
line 525
;524:
;525:	G_InitMemory();
ADDRGP4 G_InitMemory
CALLV
pop
line 528
;526:
;527:	// set some level globals
;528:	memset( &level, 0, sizeof( level ) );
ADDRGP4 level
ARGP4
CNSTI4 0
ARGI4
CNSTI4 11804
ARGI4
ADDRGP4 memset
CALLP4
pop
line 529
;529:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 531
;530:
;531:	level.startTime = levelTime;
ADDRGP4 level+40
ADDRFP4 0
INDIRI4
ASGNI4
line 533
;532:
;533:	level.previousTime = levelTime;
ADDRGP4 level+36
ADDRFP4 0
INDIRI4
ASGNI4
line 534
;534:	level.msec = FRAMETIME;
ADDRGP4 level+44
CNSTI4 100
ASGNI4
line 536
;535:
;536:	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime
ADDRGP4 $281
ARGP4
ADDRLP4 260
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRGP4 level+352
ADDRLP4 260
INDIRI4
ASGNI4
line 538
;537:
;538:	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $282
ADDRGP4 g_log+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $282
line 539
;539:		if ( g_logSync.integer ) {
ADDRGP4 g_logSync+12
INDIRI4
CNSTI4 0
EQI4 $286
line 540
;540:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 541
;541:		} else {
ADDRGP4 $287
JUMPV
LABELV $286
line 542
;542:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 543
;543:		}
LABELV $287
line 544
;544:		if ( level.logFile == FS_INVALID_HANDLE ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $293
line 545
;545:			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
ADDRGP4 $296
ARGP4
ADDRGP4 g_log+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 546
;546:		} else {
ADDRGP4 $283
JUMPV
LABELV $293
line 549
;547:			char	serverinfo[MAX_INFO_STRING];
;548:
;549:			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );
ADDRLP4 264
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 551
;550:
;551:			G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $298
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 552
;552:			G_LogPrintf("InitGame: %s\n", serverinfo );
ADDRGP4 $299
ARGP4
ADDRLP4 264
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 553
;553:		}
line 554
;554:	} else {
ADDRGP4 $283
JUMPV
LABELV $282
line 555
;555:		G_Printf( "Not logging to disk.\n" );
ADDRGP4 $300
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 556
;556:	}
LABELV $283
line 558
;557:
;558:	G_InitWorldSession();
ADDRGP4 G_InitWorldSession
CALLV
pop
line 561
;559:
;560:	// initialize all entities for this game
;561:	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
ADDRGP4 g_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 835584
ARGI4
ADDRGP4 memset
CALLP4
pop
line 562
;562:	level.gentities = g_entities;
ADDRGP4 level+4
ADDRGP4 g_entities
ASGNP4
line 565
;563:
;564:	// initialize all clients for this game
;565:	level.maxclients = g_maxclients.integer;
ADDRGP4 level+24
ADDRGP4 g_maxclients+12
INDIRI4
ASGNI4
line 566
;566:	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
ADDRGP4 g_clients
ARGP4
CNSTI4 0
ARGI4
CNSTI4 100352
ARGI4
ADDRGP4 memset
CALLP4
pop
line 567
;567:	level.clients = g_clients;
ADDRGP4 level
ADDRGP4 g_clients
ASGNP4
line 570
;568:
;569:	// set client fields on player ents
;570:	for ( i=0 ; i<level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $307
JUMPV
LABELV $304
line 571
;571:		g_entities[i].client = level.clients + i;
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+516
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 572
;572:	}
LABELV $305
line 570
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $307
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $304
line 577
;573:
;574:	// always leave room for the max number of clients,
;575:	// even if they aren't all used, so numbers inside that
;576:	// range are NEVER anything but clients
;577:	level.num_entities = MAX_CLIENTS;
ADDRGP4 level+12
CNSTI4 64
ASGNI4
line 579
;578:
;579:	for ( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $311
line 580
;580:		g_entities[ i ].classname = "clientslot";
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+524
ADDP4
ADDRGP4 $316
ASGNP4
line 581
;581:	}
LABELV $312
line 579
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $311
line 584
;582:
;583:	// let the server system know where the entites are
;584:	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ), 
ADDRGP4 level+4
INDIRP4
ARGP4
ADDRGP4 level+12
INDIRI4
ARGI4
CNSTI4 816
ARGI4
ADDRGP4 level
INDIRP4
ARGP4
CNSTI4 1568
ARGI4
ADDRGP4 trap_LocateGameData
CALLV
pop
line 588
;585:		&level.clients[0].ps, sizeof( level.clients[0] ) );
;586:
;587:	// reserve some spots for dead player bodies
;588:	InitBodyQue();
ADDRGP4 InitBodyQue
CALLV
pop
line 590
;589:
;590:	ClearRegisteredItems();
ADDRGP4 ClearRegisteredItems
CALLV
pop
line 593
;591:
;592:	// parse the key/value pairs and spawn gentities
;593:	G_SpawnEntitiesFromString();
ADDRGP4 G_SpawnEntitiesFromString
CALLV
pop
line 596
;594:
;595:	// general initialization
;596:	G_FindTeams();
ADDRGP4 G_FindTeams
CALLV
pop
line 599
;597:
;598:	// make sure we have flags for CTF, etc
;599:	if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $319
line 600
;600:		G_CheckTeamItems();
ADDRGP4 G_CheckTeamItems
CALLV
pop
line 601
;601:	}
LABELV $319
line 603
;602:
;603:	SaveRegisteredItems();
ADDRGP4 SaveRegisteredItems
CALLV
pop
line 605
;604:
;605:	G_LocateSpawnSpots();
ADDRGP4 G_LocateSpawnSpots
CALLV
pop
line 607
;606:
;607:	G_Printf ("-----------------------------------\n");
ADDRGP4 $322
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 609
;608:
;609:	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $327
ADDRGP4 $326
ARGP4
ADDRLP4 264
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $323
LABELV $327
line 610
;610:		G_ModelIndex( SP_PODIUM_MODEL );
ADDRGP4 $328
ARGP4
ADDRGP4 G_ModelIndex
CALLI4
pop
line 611
;611:	}
LABELV $323
line 613
;612:
;613:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $331
ARGP4
ADDRLP4 268
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $329
line 614
;614:		BotAISetup( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAISetup
CALLI4
pop
line 615
;615:		BotAILoadMap( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAILoadMap
CALLI4
pop
line 616
;616:		G_InitBots( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_InitBots
CALLV
pop
line 617
;617:	}
LABELV $329
line 619
;618:
;619:	G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 622
;620:
;621:	// don't forget to reset times
;622:	trap_SetConfigstring( CS_INTERMISSION, "" );
CNSTI4 22
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 624
;623:
;624:	if ( g_gametype.integer != GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $332
line 626
;625:		// launch rotation system on first map load
;626:		if ( trap_Cvar_VariableIntegerValue( SV_ROTATION ) == 0 ) {
ADDRGP4 $337
ARGP4
ADDRLP4 272
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $335
line 627
;627:			trap_Cvar_Set( SV_ROTATION, "1" );
ADDRGP4 $337
ARGP4
ADDRGP4 $77
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 628
;628:			level.denyMapRestart = qtrue;
ADDRGP4 level+11796
CNSTI4 1
ASGNI4
line 629
;629:			ParseMapRotation();
ADDRGP4 ParseMapRotation
CALLI4
pop
line 630
;630:		}
LABELV $335
line 631
;631:	}
LABELV $332
line 632
;632:}
LABELV $266
endproc G_InitGame 1288 20
proc G_ShutdownGame 4 4
line 641
;633:
;634:
;635:/*
;636:=================
;637:G_ShutdownGame
;638:=================
;639:*/
;640:static void G_ShutdownGame( int restart )
;641:{
line 642
;642:	G_Printf ("==== ShutdownGame ====\n");
ADDRGP4 $340
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 644
;643:
;644:	if ( level.logFile != FS_INVALID_HANDLE ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
EQI4 $341
line 645
;645:		G_LogPrintf("ShutdownGame:\n" );
ADDRGP4 $344
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 646
;646:		G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $298
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 647
;647:		trap_FS_FCloseFile( level.logFile );
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 648
;648:		level.logFile = FS_INVALID_HANDLE;
ADDRGP4 level+20
CNSTI4 0
ASGNI4
line 649
;649:	}
LABELV $341
line 652
;650:
;651:	// write all the client session data so we can get it back
;652:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 654
;653:
;654:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $331
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $347
line 655
;655:		BotAIShutdown( restart );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdown
CALLI4
pop
line 656
;656:	}
LABELV $347
line 657
;657:}
LABELV $339
endproc G_ShutdownGame 4 4
export Com_Error
proc Com_Error 4100 12
line 666
;658:
;659:
;660:
;661://===================================================================
;662:
;663:#ifndef GAME_HARD_LINKED
;664:// this is only here so the functions in q_shared.c and bg_*.c can link
;665:
;666:void QDECL Com_Error( int level, const char *fmt, ... ) {
line 670
;667:	va_list		argptr;
;668:	char		text[4096];
;669:
;670:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 671
;671:	ED_vsprintf( text, fmt, argptr );
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 672
;672:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 674
;673:
;674:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 675
;675:}
LABELV $349
endproc Com_Error 4100 12
export Com_Printf
proc Com_Printf 4100 12
line 678
;676:
;677:
;678:void QDECL Com_Printf( const char *fmt, ... ) {
line 682
;679:	va_list		argptr;
;680:	char		text[4096];
;681:
;682:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 683
;683:	ED_vsprintf( text, fmt, argptr );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 684
;684:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 686
;685:
;686:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 687
;687:}
LABELV $351
endproc Com_Printf 4100 12
export AddTournamentPlayer
proc AddTournamentPlayer 20 8
line 707
;688:
;689:#endif
;690:
;691:/*
;692:========================================================================
;693:
;694:PLAYER COUNTING / SCORE SORTING
;695:
;696:========================================================================
;697:*/
;698:
;699:/*
;700:=============
;701:AddTournamentPlayer
;702:
;703:If there are less than two tournament players, put a
;704:spectator in the game and restart
;705:=============
;706:*/
;707:void AddTournamentPlayer( void ) {
line 712
;708:	int			i;
;709:	gclient_t	*client;
;710:	gclient_t	*nextInLine;
;711:
;712:	if ( level.numPlayingClients >= 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
LTI4 $354
line 713
;713:		return;
ADDRGP4 $353
JUMPV
LABELV $354
line 717
;714:	}
;715:
;716:	// never change during intermission
;717:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $357
line 718
;718:		return;
ADDRGP4 $353
JUMPV
LABELV $357
line 721
;719:	}
;720:
;721:	nextInLine = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 723
;722:
;723:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $363
JUMPV
LABELV $360
line 724
;724:		client = &level.clients[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 725
;725:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $365
line 726
;726:			continue;
ADDRGP4 $361
JUMPV
LABELV $365
line 728
;727:		}
;728:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $367
line 729
;729:			continue;
ADDRGP4 $361
JUMPV
LABELV $367
line 732
;730:		}
;731:		// never select the dedicated follow or scoreboard clients
;732:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD || 
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
EQI4 $371
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
CNSTI4 0
GEI4 $369
LABELV $371
line 733
;733:			client->sess.spectatorClient < 0  ) {
line 734
;734:			continue;
ADDRGP4 $361
JUMPV
LABELV $369
line 737
;735:		}
;736:
;737:		if ( !nextInLine || client->sess.spectatorTime > nextInLine->sess.spectatorTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $374
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LEI4 $372
LABELV $374
line 738
;738:			nextInLine = client;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 739
;739:		}
LABELV $372
line 740
;740:	}
LABELV $361
line 723
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $363
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $360
line 742
;741:
;742:	if ( !nextInLine ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $375
line 743
;743:		return;
ADDRGP4 $353
JUMPV
LABELV $375
line 746
;744:	}
;745:
;746:	level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 749
;747:
;748:	// set them to free-for-all team
;749:	SetTeam( &g_entities[ nextInLine - level.clients ], "f" );
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1568
DIVI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 SetTeam
CALLI4
pop
line 750
;750:}
LABELV $353
endproc AddTournamentPlayer 20 8
export RemoveTournamentLoser
proc RemoveTournamentLoser 4 8
line 760
;751:
;752:
;753:/*
;754:=======================
;755:RemoveTournamentLoser
;756:
;757:Make the loser a spectator at the back of the line
;758:=======================
;759:*/
;760:void RemoveTournamentLoser( void ) {
line 763
;761:	int			clientNum;
;762:
;763:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
EQI4 $380
line 764
;764:		return;
ADDRGP4 $379
JUMPV
LABELV $380
line 767
;765:	}
;766:
;767:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+88+4
INDIRI4
ASGNI4
line 769
;768:
;769:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $385
line 770
;770:		return;
ADDRGP4 $379
JUMPV
LABELV $385
line 774
;771:	}
;772:
;773:	// make them a spectator
;774:	SetTeam( &g_entities[ clientNum ], "s" );
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $387
ARGP4
ADDRGP4 SetTeam
CALLI4
pop
line 775
;775:}
LABELV $379
endproc RemoveTournamentLoser 4 8
export RemoveTournamentWinner
proc RemoveTournamentWinner 4 8
line 783
;776:
;777:
;778:/*
;779:=======================
;780:RemoveTournamentWinner
;781:=======================
;782:*/
;783:void RemoveTournamentWinner( void ) {
line 786
;784:	int			clientNum;
;785:
;786:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
EQI4 $389
line 787
;787:		return;
ADDRGP4 $388
JUMPV
LABELV $389
line 790
;788:	}
;789:
;790:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+88
INDIRI4
ASGNI4
line 792
;791:
;792:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $393
line 793
;793:		return;
ADDRGP4 $388
JUMPV
LABELV $393
line 797
;794:	}
;795:
;796:	// make them a spectator
;797:	SetTeam( &g_entities[ clientNum ], "s" );
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $387
ARGP4
ADDRGP4 SetTeam
CALLI4
pop
line 798
;798:}
LABELV $388
endproc RemoveTournamentWinner 4 8
export AdjustTournamentScores
proc AdjustTournamentScores 8 4
line 806
;799:
;800:
;801:/*
;802:=======================
;803:AdjustTournamentScores
;804:=======================
;805:*/
;806:void AdjustTournamentScores( void ) {
line 809
;807:	int			clientNum;
;808:
;809:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+88
INDIRI4
ASGNI4
line 810
;810:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $397
line 811
;811:		level.clients[ clientNum ].sess.wins++;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 812
;812:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 813
;813:	}
LABELV $397
line 815
;814:
;815:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+88+4
INDIRI4
ASGNI4
line 816
;816:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $401
line 817
;817:		level.clients[ clientNum ].sess.losses++;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 644
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 818
;818:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 819
;819:	}
LABELV $401
line 821
;820:
;821:}
LABELV $395
endproc AdjustTournamentScores 8 4
proc SortRanks 16 0
line 829
;822:
;823:
;824:/*
;825:=============
;826:SortRanks
;827:=============
;828:*/
;829:static int QDECL SortRanks( const void *a, const void *b ) {
line 832
;830:	gclient_t	*ca, *cb;
;831:
;832:	ca = &level.clients[*(int *)a];
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 833
;833:	cb = &level.clients[*(int *)b];
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 836
;834:
;835:	// sort special clients last
;836:	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
EQI4 $406
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
CNSTI4 0
GEI4 $404
LABELV $406
line 837
;837:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $403
JUMPV
LABELV $404
line 839
;838:	}
;839:	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
ADDRLP4 4
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
EQI4 $409
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
CNSTI4 0
GEI4 $407
LABELV $409
line 840
;840:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $403
JUMPV
LABELV $407
line 844
;841:	}
;842:
;843:	// then connecting clients
;844:	if ( ca->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $410
line 845
;845:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $403
JUMPV
LABELV $410
line 847
;846:	}
;847:	if ( cb->pers.connected == CON_CONNECTING ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $412
line 848
;848:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $403
JUMPV
LABELV $412
line 852
;849:	}
;850:
;851:	// then spectators
;852:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $414
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $414
line 853
;853:		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
LEI4 $416
line 854
;854:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $403
JUMPV
LABELV $416
line 856
;855:		}
;856:		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
GEI4 $418
line 857
;857:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $403
JUMPV
LABELV $418
line 859
;858:		}
;859:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $403
JUMPV
LABELV $414
line 861
;860:	}
;861:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $420
line 862
;862:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $403
JUMPV
LABELV $420
line 864
;863:	}
;864:	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $422
line 865
;865:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $403
JUMPV
LABELV $422
line 869
;866:	}
;867:
;868:	// then sort by score
;869:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
LEI4 $424
line 870
;870:		> cb->ps.persistant[PERS_SCORE] ) {
line 871
;871:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $403
JUMPV
LABELV $424
line 873
;872:	}
;873:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
GEI4 $426
line 874
;874:		< cb->ps.persistant[PERS_SCORE] ) {
line 875
;875:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $403
JUMPV
LABELV $426
line 877
;876:	}
;877:	return 0;
CNSTI4 0
RETI4
LABELV $403
endproc SortRanks 16 0
export CalculateRanks
proc CalculateRanks 44 16
line 890
;878:}
;879:
;880:
;881:/*
;882:============
;883:CalculateRanks
;884:
;885:Recalculates the score ranks of all players
;886:This will be called on every client connect, begin, disconnect, death,
;887:and team change.
;888:============
;889:*/
;890:void CalculateRanks( void ) {
line 897
;891:	int		i;
;892:	int		rank;
;893:	int		score;
;894:	int		newScore;
;895:	gclient_t	*cl;
;896:
;897:	if ( level.restarted )
ADDRGP4 level+72
INDIRI4
CNSTI4 0
EQI4 $429
line 898
;898:		return;
ADDRGP4 $428
JUMPV
LABELV $429
line 900
;899:
;900:	level.follow1 = -1;
ADDRGP4 level+344
CNSTI4 -1
ASGNI4
line 901
;901:	level.follow2 = -1;
ADDRGP4 level+348
CNSTI4 -1
ASGNI4
line 902
;902:	level.numConnectedClients = 0;
ADDRGP4 level+76
CNSTI4 0
ASGNI4
line 903
;903:	level.numNonSpectatorClients = 0;
ADDRGP4 level+80
CNSTI4 0
ASGNI4
line 904
;904:	level.numPlayingClients = 0;
ADDRGP4 level+84
CNSTI4 0
ASGNI4
line 905
;905:	level.numVotingClients = 0;		// don't count bots
ADDRGP4 level+888
CNSTI4 0
ASGNI4
line 906
;906:	for (i = 0; i < ARRAY_LEN(level.numteamVotingClients); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $441
JUMPV
LABELV $438
line 907
;907:		level.numteamVotingClients[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2964
ADDP4
CNSTI4 0
ASGNI4
line 908
;908:	}
LABELV $439
line 906
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $441
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 4
LTU4 $438
line 909
;909:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $448
JUMPV
LABELV $445
line 910
;910:		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $450
line 911
;911:			level.sortedClients[level.numConnectedClients] = i;
ADDRGP4 level+76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 912
;912:			level.numConnectedClients++;
ADDRLP4 20
ADDRGP4 level+76
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 914
;913:
;914:			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
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
EQI4 $455
line 915
;915:				level.numNonSpectatorClients++;
ADDRLP4 24
ADDRGP4 level+80
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 918
;916:			
;917:				// decide if this should be auto-followed
;918:				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $458
line 919
;919:					level.numPlayingClients++;
ADDRLP4 28
ADDRGP4 level+84
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 920
;920:					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
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
NEI4 $461
line 921
;921:						level.numVotingClients++;
ADDRLP4 32
ADDRGP4 level+888
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 922
;922:						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $466
line 923
;923:							level.numteamVotingClients[0]++;
ADDRLP4 36
ADDRGP4 level+2964
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $467
JUMPV
LABELV $466
line 924
;924:						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $469
line 925
;925:							level.numteamVotingClients[1]++;
ADDRLP4 40
ADDRGP4 level+2964+4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $469
LABELV $467
line 926
;926:					}
LABELV $461
line 927
;927:					if ( level.follow1 == -1 ) {
ADDRGP4 level+344
INDIRI4
CNSTI4 -1
NEI4 $473
line 928
;928:						level.follow1 = i;
ADDRGP4 level+344
ADDRLP4 0
INDIRI4
ASGNI4
line 929
;929:					} else if ( level.follow2 == -1 ) {
ADDRGP4 $474
JUMPV
LABELV $473
ADDRGP4 level+348
INDIRI4
CNSTI4 -1
NEI4 $477
line 930
;930:						level.follow2 = i;
ADDRGP4 level+348
ADDRLP4 0
INDIRI4
ASGNI4
line 931
;931:					}
LABELV $477
LABELV $474
line 932
;932:				}
LABELV $458
line 933
;933:			}
LABELV $455
line 934
;934:		}
LABELV $450
line 935
;935:	}
LABELV $446
line 909
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $448
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $445
line 937
;936:
;937:	qsort( level.sortedClients, level.numConnectedClients, 
ADDRGP4 level+88
ARGP4
ADDRGP4 level+76
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 SortRanks
ARGP4
ADDRGP4 qsort
CALLV
pop
line 941
;938:		sizeof(level.sortedClients[0]), SortRanks );
;939:
;940:	// set the rank value for all clients that are connected and not spectators
;941:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $484
line 943
;942:		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
;943:		for ( i = 0;  i < level.numConnectedClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $490
JUMPV
LABELV $487
line 944
;944:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 945
;945:			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 level+48+8
INDIRI4
NEI4 $493
line 946
;946:				cl->ps.persistant[PERS_RANK] = 2;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 2
ASGNI4
line 947
;947:			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
ADDRGP4 $494
JUMPV
LABELV $493
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 level+48+8
INDIRI4
LEI4 $499
line 948
;948:				cl->ps.persistant[PERS_RANK] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 0
ASGNI4
line 949
;949:			} else {
ADDRGP4 $500
JUMPV
LABELV $499
line 950
;950:				cl->ps.persistant[PERS_RANK] = 1;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 1
ASGNI4
line 951
;951:			}
LABELV $500
LABELV $494
line 952
;952:		}
LABELV $488
line 943
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $490
ADDRLP4 0
INDIRI4
ADDRGP4 level+76
INDIRI4
LTI4 $487
line 953
;953:	} else {	
ADDRGP4 $485
JUMPV
LABELV $484
line 954
;954:		rank = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 955
;955:		score = MAX_QINT;
ADDRLP4 16
CNSTI4 2147483647
ASGNI4
line 956
;956:		for ( i = 0;  i < level.numPlayingClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $508
JUMPV
LABELV $505
line 957
;957:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 958
;958:			newScore = cl->ps.persistant[PERS_SCORE];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 959
;959:			if ( i == 0 || newScore != score ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $513
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $511
LABELV $513
line 960
;960:				rank = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 962
;961:				// assume we aren't tied until the next client is checked
;962:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 963
;963:			} else {
ADDRGP4 $512
JUMPV
LABELV $511
line 965
;964:				// we are tied with the previous client
;965:				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88-4
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 966
;966:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 967
;967:			}
LABELV $512
line 968
;968:			score = newScore;
ADDRLP4 16
ADDRLP4 8
INDIRI4
ASGNI4
line 969
;969:			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $518
ADDRGP4 level+84
INDIRI4
CNSTI4 1
NEI4 $518
line 970
;970:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 971
;971:			}
LABELV $518
line 972
;972:		}
LABELV $506
line 956
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $508
ADDRLP4 0
INDIRI4
ADDRGP4 level+84
INDIRI4
LTI4 $505
line 973
;973:	}
LABELV $485
line 976
;974:
;975:	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
;976:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $523
line 977
;977:		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+48+4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 978
;978:		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+48+8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 979
;979:	} else {
ADDRGP4 $524
JUMPV
LABELV $523
line 980
;980:		if ( level.numConnectedClients == 0 ) {
ADDRGP4 level+76
INDIRI4
CNSTI4 0
NEI4 $531
line 981
;981:			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $526
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 982
;982:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $526
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 983
;983:		} else if ( level.numConnectedClients == 1 ) {
ADDRGP4 $532
JUMPV
LABELV $531
ADDRGP4 level+76
INDIRI4
CNSTI4 1
NEI4 $534
line 984
;984:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+88
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 985
;985:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $526
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 986
;986:		} else {
ADDRGP4 $535
JUMPV
LABELV $534
line 987
;987:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+88
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 988
;988:			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+88+4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 989
;989:		}
LABELV $535
LABELV $532
line 990
;990:	}
LABELV $524
line 993
;991:
;992:	// see if it is time to end the level
;993:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 996
;994:
;995:	// if we are at the intermission, send the new info to everyone
;996:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $541
line 997
;997:		SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 998
;998:	}
LABELV $541
line 999
;999:}
LABELV $428
endproc CalculateRanks 44 16
proc SendScoreboardMessageToAllClients 4 4
line 1018
;1000:
;1001:
;1002:/*
;1003:========================================================================
;1004:
;1005:MAP CHANGING
;1006:
;1007:========================================================================
;1008:*/
;1009:
;1010:/*
;1011:========================
;1012:SendScoreboardMessageToAllClients
;1013:
;1014:Do this at BeginIntermission time and whenever ranks are recalculated
;1015:due to enters/exits/forced team changes
;1016:========================
;1017:*/
;1018:static void SendScoreboardMessageToAllClients( void ) {
line 1021
;1019:	int		i;
;1020:
;1021:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $548
JUMPV
LABELV $545
line 1022
;1022:		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $550
line 1023
;1023:			DeathmatchScoreboardMessage( g_entities + i );
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 1024
;1024:		}
LABELV $550
line 1025
;1025:	}
LABELV $546
line 1021
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $548
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $545
line 1026
;1026:}
LABELV $544
endproc SendScoreboardMessageToAllClients 4 4
export MoveClientToIntermission
proc MoveClientToIntermission 8 12
line 1037
;1027:
;1028:
;1029:/*
;1030:========================
;1031:MoveClientToIntermission
;1032:
;1033:When the intermission starts, this will be called for all players.
;1034:If a new client connects, this will be called after the spawn function.
;1035:========================
;1036:*/
;1037:void MoveClientToIntermission( gentity_t *ent ) {
line 1041
;1038:
;1039:	gclient_t * client;
;1040:
;1041:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1044
;1042:	
;1043:	// take out of follow mode if needed
;1044:	if ( client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
NEI4 $553
line 1045
;1045:		StopFollowing( ent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 StopFollowing
CALLV
pop
line 1046
;1046:	}
LABELV $553
line 1049
;1047:
;1048:	// move to the spot
;1049:	VectorCopy( level.intermission_origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 level+7616
INDIRB
ASGNB 12
line 1050
;1050:	VectorCopy( level.intermission_origin, client->ps.origin );
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+7616
INDIRB
ASGNB 12
line 1051
;1051:	SetClientViewAngle( ent, level.intermission_angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 level+7628
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 1052
;1052:	client->ps.pm_type = PM_INTERMISSION;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 1055
;1053:
;1054:	// clean up powerup info
;1055:	memset( client->ps.powerups, 0, sizeof( client->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1057
;1056:
;1057:	client->ps.eFlags = ( client->ps.eFlags & ~EF_PERSISTANT ) | ( client->ps.eFlags & EF_PERSISTANT );
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -548865
BANDI4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 548864
BANDI4
BORI4
ASGNI4
line 1059
;1058:
;1059:	ent->s.eFlags = client->ps.eFlags;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 1060
;1060:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1061
;1061:	ent->s.modelindex = 0;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 1062
;1062:	ent->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1063
;1063:	ent->s.event = 0;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 1064
;1064:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 1066
;1065:
;1066:	ent->s.legsAnim = LEGS_IDLE;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 22
ASGNI4
line 1067
;1067:	ent->s.torsoAnim = TORSO_STAND;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 11
ASGNI4
line 1068
;1068:}
LABELV $552
endproc MoveClientToIntermission 8 12
export FindIntermissionPoint
proc FindIntermissionPoint 28 16
line 1078
;1069:
;1070:
;1071:/*
;1072:==================
;1073:FindIntermissionPoint
;1074:
;1075:This is also used for spectator spawns
;1076:==================
;1077:*/
;1078:void FindIntermissionPoint( void ) {
line 1082
;1079:	gentity_t	*ent, *target;
;1080:	vec3_t		dir;
;1081:
;1082:	if ( level.intermission_spot ) // search only once
ADDRGP4 level+7640
INDIRI4
CNSTI4 0
EQI4 $559
line 1083
;1083:		return;
ADDRGP4 $558
JUMPV
LABELV $559
line 1086
;1084:
;1085:	// find the intermission spot
;1086:	ent = level.spawnSpots[ SPAWN_SPOT_INTERMISSION ];
ADDRLP4 0
ADDRGP4 level+7688+4092
INDIRP4
ASGNP4
line 1088
;1087:
;1088:	if ( !ent ) { // the map creator forgot to put in an intermission point...
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $564
line 1089
;1089:		SelectSpawnPoint( NULL, vec3_origin, level.intermission_origin, level.intermission_angle );
CNSTP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 level+7616
ARGP4
ADDRGP4 level+7628
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 1090
;1090:	} else {
ADDRGP4 $565
JUMPV
LABELV $564
line 1091
;1091:		VectorCopy (ent->s.origin, level.intermission_origin);
ADDRGP4 level+7616
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1092
;1092:		VectorCopy (ent->s.angles, level.intermission_angle);
ADDRGP4 level+7628
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1094
;1093:		// if it has a target, look towards it
;1094:		if ( ent->target ) {
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $570
line 1095
;1095:			target = G_PickTarget( ent->target );
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1096
;1096:			if ( target ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $572
line 1097
;1097:				VectorSubtract( target->s.origin, level.intermission_origin, dir );
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 level+7616
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 24
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 level+7616+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 level+7616+8
INDIRF4
SUBF4
ASGNF4
line 1098
;1098:				vectoangles( dir, level.intermission_angle );
ADDRLP4 8
ARGP4
ADDRGP4 level+7628
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1099
;1099:			}
LABELV $572
line 1100
;1100:		}
LABELV $570
line 1101
;1101:	}
LABELV $565
line 1103
;1102:
;1103:	level.intermission_spot = qtrue;
ADDRGP4 level+7640
CNSTI4 1
ASGNI4
line 1104
;1104:}
LABELV $558
endproc FindIntermissionPoint 28 16
export BeginIntermission
proc BeginIntermission 8 4
line 1112
;1105:
;1106:
;1107:/*
;1108:==================
;1109:BeginIntermission
;1110:==================
;1111:*/
;1112:void BeginIntermission( void ) {
line 1116
;1113:	int			i;
;1114:	gentity_t	*client;
;1115:
;1116:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $584
line 1117
;1117:		return; // already active
ADDRGP4 $583
JUMPV
LABELV $584
line 1121
;1118:	}
;1119:
;1120:	// if in tournement mode, change the wins / losses
;1121:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $587
line 1122
;1122:		AdjustTournamentScores();
ADDRGP4 AdjustTournamentScores
CALLV
pop
line 1123
;1123:	}
LABELV $587
line 1125
;1124:
;1125:	level.intermissiontime = level.time;
ADDRGP4 level+7604
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1126
;1126:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 1129
;1127:
;1128:	// move all clients to the intermission point
;1129:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $595
JUMPV
LABELV $592
line 1130
;1130:		client = g_entities + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1131
;1131:		if ( !client->inuse )
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $597
line 1132
;1132:			continue;
ADDRGP4 $593
JUMPV
LABELV $597
line 1135
;1133:
;1134:		// respawn if dead
;1135:		if ( client->health <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $599
line 1136
;1136:			respawn( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 1137
;1137:		}
LABELV $599
line 1139
;1138:
;1139:		MoveClientToIntermission( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 1140
;1140:	}
LABELV $593
line 1129
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $595
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $592
line 1149
;1141:
;1142:#ifdef MISSIONPACK
;1143:	if (g_singlePlayer.integer) {
;1144:		trap_Cvar_Set("ui_singlePlayerActive", "0");
;1145:		UpdateTournamentInfo();
;1146:	}
;1147:#else
;1148:	// if single player game
;1149:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $601
line 1150
;1150:		UpdateTournamentInfo();
ADDRGP4 UpdateTournamentInfo
CALLV
pop
line 1151
;1151:		SpawnModelsOnVictoryPads();
ADDRGP4 SpawnModelsOnVictoryPads
CALLV
pop
line 1152
;1152:	}
LABELV $601
line 1156
;1153:#endif
;1154:
;1155:	// send the current scoring to all clients
;1156:	SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 1157
;1157:}
LABELV $583
endproc BeginIntermission 8 4
export ExitLevel
proc ExitLevel 272 12
line 1168
;1158:
;1159:
;1160:/*
;1161:=============
;1162:ExitLevel
;1163:
;1164:When the intermission has been exited, the server is either killed
;1165:or moved to a new level based on the "nextmap" cvar 
;1166:=============
;1167:*/
;1168:void ExitLevel( void ) {
line 1173
;1169:	int		i;
;1170:	gclient_t *cl;
;1171:
;1172:	//bot interbreeding
;1173:	BotInterbreedEndMatch();
ADDRGP4 BotInterbreedEndMatch
CALLV
pop
line 1177
;1174:
;1175:	// if we are running a tournement map, kick the loser to spectator status,
;1176:	// which will automatically grab the next spectator and restart
;1177:	if ( g_gametype.integer == GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $605
line 1178
;1178:		if ( !level.restarted ) {
ADDRGP4 level+72
INDIRI4
CNSTI4 0
NEI4 $604
line 1179
;1179:			RemoveTournamentLoser();
ADDRGP4 RemoveTournamentLoser
CALLV
pop
line 1180
;1180:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $611
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1181
;1181:			level.restarted = qtrue;
ADDRGP4 level+72
CNSTI4 1
ASGNI4
line 1182
;1182:			level.intermissiontime = 0;
ADDRGP4 level+7604
CNSTI4 0
ASGNI4
line 1183
;1183:		}
line 1184
;1184:		return;	
ADDRGP4 $604
JUMPV
LABELV $605
line 1187
;1185:	}
;1186:
;1187:	level.intermissiontime = 0;
ADDRGP4 level+7604
CNSTI4 0
ASGNI4
line 1190
;1188:
;1189:	// reset all the scores so we don't enter the intermission again
;1190:	level.teamScores[TEAM_RED] = 0;
ADDRGP4 level+48+4
CNSTI4 0
ASGNI4
line 1191
;1191:	level.teamScores[TEAM_BLUE] = 0;
ADDRGP4 level+48+8
CNSTI4 0
ASGNI4
line 1192
;1192:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $622
JUMPV
LABELV $619
line 1193
;1193:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1194
;1194:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $624
line 1195
;1195:			continue;
ADDRGP4 $620
JUMPV
LABELV $624
line 1197
;1196:		}
;1197:		cl->ps.persistant[PERS_SCORE] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 0
ASGNI4
line 1198
;1198:	}
LABELV $620
line 1192
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $622
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $619
line 1201
;1199:
;1200:	// we need to do this here before changing to CON_CONNECTING
;1201:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 1205
;1202:
;1203:	// change all client states to connecting, so the early players into the
;1204:	// next level will know the others aren't done reconnecting
;1205:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $629
JUMPV
LABELV $626
line 1206
;1206:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $631
line 1207
;1207:			level.clients[i].pers.connected = CON_CONNECTING;
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1208
;1208:		}
LABELV $631
line 1209
;1209:	}
LABELV $627
line 1205
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $629
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $626
line 1211
;1210:
;1211:	if ( !ParseMapRotation() ) {
ADDRLP4 8
ADDRGP4 ParseMapRotation
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $633
line 1214
;1212:		char val[ MAX_CVAR_VALUE_STRING ];
;1213:
;1214:		trap_Cvar_VariableStringBuffer( "nextmap", val, sizeof( val ) );
ADDRGP4 $635
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1216
;1215:
;1216:		if ( !val[0] || !Q_stricmpn( val, "map_restart ", 12 ) )
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $639
ADDRLP4 12
ARGP4
ADDRGP4 $638
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 268
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $636
LABELV $639
line 1217
;1217:			G_LoadMap( NULL );
CNSTP4 0
ARGP4
ADDRGP4 G_LoadMap
CALLV
pop
ADDRGP4 $637
JUMPV
LABELV $636
line 1219
;1218:		else
;1219:			trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
CNSTI4 2
ARGI4
ADDRGP4 $640
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
LABELV $637
line 1220
;1220:	} 
LABELV $633
line 1221
;1221:}
LABELV $604
endproc ExitLevel 272 12
export G_LogPrintf
proc G_LogPrintf 8224 24
line 1231
;1222:
;1223:
;1224:/*
;1225:=================
;1226:G_LogPrintf
;1227:
;1228:Print to the logfile with a time stamp if it is open
;1229:=================
;1230:*/
;1231:void QDECL G_LogPrintf( const char *fmt, ... ) {
line 1236
;1232:	va_list		argptr;
;1233:	char		string[BIG_INFO_STRING];
;1234:	int			min, tsec, sec, len, n;
;1235:
;1236:	tsec = level.time / 100;
ADDRLP4 8192
ADDRGP4 level+32
INDIRI4
CNSTI4 100
DIVI4
ASGNI4
line 1237
;1237:	sec = tsec / 10;
ADDRLP4 8196
ADDRLP4 8192
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1238
;1238:	tsec %= 10;
ADDRLP4 8192
ADDRLP4 8192
INDIRI4
CNSTI4 10
MODI4
ASGNI4
line 1239
;1239:	min = sec / 60;
ADDRLP4 8204
ADDRLP4 8196
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1240
;1240:	sec -= min * 60;
ADDRLP4 8196
ADDRLP4 8196
INDIRI4
ADDRLP4 8204
INDIRI4
CNSTI4 60
MULI4
SUBI4
ASGNI4
line 1242
;1241:
;1242:	len = Com_sprintf( string, sizeof( string ), "%3i:%02i.%i ", min, sec, tsec );
ADDRLP4 0
ARGP4
CNSTI4 8192
ARGI4
ADDRGP4 $643
ARGP4
ADDRLP4 8204
INDIRI4
ARGI4
ADDRLP4 8196
INDIRI4
ARGI4
ADDRLP4 8192
INDIRI4
ARGI4
ADDRLP4 8216
ADDRGP4 Com_sprintf
CALLI4
ASGNI4
ADDRLP4 8208
ADDRLP4 8216
INDIRI4
ASGNI4
line 1244
;1243:
;1244:	va_start( argptr, fmt );
ADDRLP4 8200
ADDRFP4 0+4
ASGNP4
line 1245
;1245:	ED_vsprintf( string + len, fmt,argptr );
ADDRLP4 8208
INDIRI4
ADDRLP4 0
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8200
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 1246
;1246:	va_end( argptr );
ADDRLP4 8200
CNSTP4 0
ASGNP4
line 1248
;1247:
;1248:	n = (int)strlen( string );
ADDRLP4 0
ARGP4
ADDRLP4 8220
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8212
ADDRLP4 8220
INDIRI4
ASGNI4
line 1250
;1249:
;1250:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $645
line 1251
;1251:		G_Printf( "%s", string + len );
ADDRGP4 $648
ARGP4
ADDRLP4 8208
INDIRI4
ADDRLP4 0
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1252
;1252:	}
LABELV $645
line 1254
;1253:
;1254:	if ( level.logFile == FS_INVALID_HANDLE ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $649
line 1255
;1255:		return;
ADDRGP4 $641
JUMPV
LABELV $649
line 1258
;1256:	}
;1257:
;1258:	trap_FS_Write( string, n, level.logFile );
ADDRLP4 0
ARGP4
ADDRLP4 8212
INDIRI4
ARGI4
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 1259
;1259:}
LABELV $641
endproc G_LogPrintf 8224 24
export LogExit
proc LogExit 24 20
line 1269
;1260:
;1261:
;1262:/*
;1263:================
;1264:LogExit
;1265:
;1266:Append information about this game to the log file
;1267:================
;1268:*/
;1269:void LogExit( const char *string ) {
line 1275
;1270:	int				i, numSorted;
;1271:	gclient_t		*cl;
;1272:#ifdef MISSIONPACK
;1273:	qboolean won = qtrue;
;1274:#endif
;1275:	G_LogPrintf( "Exit: %s\n", string );
ADDRGP4 $654
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1277
;1276:
;1277:	level.intermissionQueued = level.time;
ADDRGP4 level+7600
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1281
;1278:
;1279:	// this will keep the clients from playing any voice sounds
;1280:	// that will get cut off when the queued intermission starts
;1281:	trap_SetConfigstring( CS_INTERMISSION, "1" );
CNSTI4 22
ARGI4
ADDRGP4 $77
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1284
;1282:
;1283:	// don't send more than 32 scores (FIXME?)
;1284:	numSorted = level.numConnectedClients;
ADDRLP4 8
ADDRGP4 level+76
INDIRI4
ASGNI4
line 1285
;1285:	if ( numSorted > 32 ) {
ADDRLP4 8
INDIRI4
CNSTI4 32
LEI4 $658
line 1286
;1286:		numSorted = 32;
ADDRLP4 8
CNSTI4 32
ASGNI4
line 1287
;1287:	}
LABELV $658
line 1289
;1288:
;1289:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $660
line 1290
;1290:		G_LogPrintf( "red:%i  blue:%i\n",
ADDRGP4 $663
ARGP4
ADDRGP4 level+48+4
INDIRI4
ARGI4
ADDRGP4 level+48+8
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1292
;1291:			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
;1292:	}
LABELV $660
line 1294
;1293:
;1294:	for (i=0 ; i < numSorted ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $671
JUMPV
LABELV $668
line 1297
;1295:		int		ping;
;1296:
;1297:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1299
;1298:
;1299:		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $673
line 1300
;1300:			continue;
ADDRGP4 $669
JUMPV
LABELV $673
line 1302
;1301:		}
;1302:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $675
line 1303
;1303:			continue;
ADDRGP4 $669
JUMPV
LABELV $675
line 1306
;1304:		}
;1305:
;1306:		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
GEI4 $678
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $679
JUMPV
LABELV $678
ADDRLP4 16
CNSTI4 999
ASGNI4
LABELV $679
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 1308
;1307:
;1308:		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
ADDRGP4 $680
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1317
;1309:#ifdef MISSIONPACK
;1310:		if (g_singlePlayer.integer && g_gametype.integer == GT_TOURNAMENT) {
;1311:			if (g_entities[cl - level.clients].r.svFlags & SVF_BOT && cl->ps.persistant[PERS_RANK] == 0) {
;1312:				won = qfalse;
;1313:			}
;1314:		}
;1315:#endif
;1316:
;1317:	}
LABELV $669
line 1294
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $671
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $668
line 1329
;1318:
;1319:#ifdef MISSIONPACK
;1320:	if (g_singlePlayer.integer) {
;1321:		if (g_gametype.integer >= GT_CTF) {
;1322:			won = level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE];
;1323:		}
;1324:		trap_SendConsoleCommand( EXEC_APPEND, (won) ? "spWin\n" : "spLose\n" );
;1325:	}
;1326:#endif
;1327:
;1328:
;1329:}
LABELV $653
endproc LogExit 24 20
export CheckIntermissionExit
proc CheckIntermissionExit 20 0
line 1342
;1330:
;1331:
;1332:/*
;1333:=================
;1334:CheckIntermissionExit
;1335:
;1336:The level will stay at the intermission for a minimum of 5 seconds
;1337:If all players wish to continue, the level will then exit.
;1338:If one or more players have not acknowledged the continue, the game will
;1339:wait 10 seconds before going on.
;1340:=================
;1341:*/
;1342:void CheckIntermissionExit( void ) {
line 1348
;1343:	int			ready, notReady;
;1344:	int			i;
;1345:	gclient_t	*cl;
;1346:	int			readyMask;
;1347:
;1348:	if ( g_gametype.integer == GT_SINGLE_PLAYER )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $683
line 1349
;1349:		return;
ADDRGP4 $682
JUMPV
LABELV $683
line 1352
;1350:
;1351:	// see which players are ready
;1352:	ready = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1353
;1353:	notReady = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1354
;1354:	readyMask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1355
;1355:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $689
JUMPV
LABELV $686
line 1356
;1356:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1357
;1357:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $691
line 1358
;1358:			continue;
ADDRGP4 $687
JUMPV
LABELV $691
line 1361
;1359:		}
;1360:
;1361:		if ( g_entities[i].r.svFlags & SVF_BOT ) {
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
EQI4 $693
line 1362
;1362:			cl->readyToExit = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
CNSTI4 1
ASGNI4
line 1363
;1363:		}
LABELV $693
line 1365
;1364:
;1365:		if ( cl->readyToExit ) {
ADDRLP4 4
INDIRP4
CNSTI4 652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $697
line 1366
;1366:			ready++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1367
;1367:			if ( i < 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $698
line 1368
;1368:				readyMask |= 1 << i;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BORI4
ASGNI4
line 1369
;1369:			}
line 1370
;1370:		} else {
ADDRGP4 $698
JUMPV
LABELV $697
line 1371
;1371:			notReady++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1372
;1372:		}
LABELV $698
line 1373
;1373:	}
LABELV $687
line 1355
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $689
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $686
line 1376
;1374:
;1375:	// vote in progress
;1376:	if ( level.voteTime || level.voteExecuteTime ) {
ADDRGP4 level+872
INDIRI4
CNSTI4 0
NEI4 $705
ADDRGP4 level+876
INDIRI4
CNSTI4 0
EQI4 $701
LABELV $705
line 1377
;1377:		ready  = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1378
;1378:		notReady = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1379
;1379:	}
LABELV $701
line 1383
;1380:
;1381:	// copy the readyMask to each player's stats so
;1382:	// it can be displayed on the scoreboard
;1383:	for ( i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $709
JUMPV
LABELV $706
line 1384
;1384:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1385
;1385:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $711
line 1386
;1386:			continue;
ADDRGP4 $707
JUMPV
LABELV $711
line 1388
;1387:		}
;1388:		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1389
;1389:	}
LABELV $707
line 1383
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $709
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $706
line 1392
;1390:
;1391:	// never exit in less than five seconds
;1392:	if ( level.time < level.intermissiontime + 5000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7604
INDIRI4
CNSTI4 5000
ADDI4
GEI4 $713
line 1393
;1393:		return;
ADDRGP4 $682
JUMPV
LABELV $713
line 1397
;1394:	}
;1395:
;1396:	// if nobody wants to go, clear timer
;1397:	if ( !ready && notReady ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $717
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $717
line 1398
;1398:		level.readyToExit = qfalse;
ADDRGP4 level+7608
CNSTI4 0
ASGNI4
line 1399
;1399:		return;
ADDRGP4 $682
JUMPV
LABELV $717
line 1403
;1400:	}
;1401:
;1402:	// if everyone wants to go, go now
;1403:	if ( !notReady ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $720
line 1404
;1404:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1405
;1405:		return;
ADDRGP4 $682
JUMPV
LABELV $720
line 1409
;1406:	}
;1407:
;1408:	// the first person to ready starts the ten second timeout
;1409:	if ( !level.readyToExit ) {
ADDRGP4 level+7608
INDIRI4
CNSTI4 0
NEI4 $722
line 1410
;1410:		level.readyToExit = qtrue;
ADDRGP4 level+7608
CNSTI4 1
ASGNI4
line 1411
;1411:		level.exitTime = level.time + 10000;
ADDRGP4 level+7612
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1412
;1412:	}
LABELV $722
line 1416
;1413:
;1414:	// if we have waited ten seconds since at least one player
;1415:	// wanted to exit, go ahead
;1416:	if ( level.time < level.exitTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7612
INDIRI4
GEI4 $728
line 1417
;1417:		return;
ADDRGP4 $682
JUMPV
LABELV $728
line 1420
;1418:	}
;1419:
;1420:	ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1421
;1421:}
LABELV $682
endproc CheckIntermissionExit 20 0
proc ScoreIsTied 12 0
line 1429
;1422:
;1423:
;1424:/*
;1425:=============
;1426:ScoreIsTied
;1427:=============
;1428:*/
;1429:static qboolean ScoreIsTied( void ) {
line 1432
;1430:	int		a, b;
;1431:
;1432:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
GEI4 $733
line 1433
;1433:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $732
JUMPV
LABELV $733
line 1436
;1434:	}
;1435:	
;1436:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $736
line 1437
;1437:		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 level+48+8
INDIRI4
NEI4 $744
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $745
JUMPV
LABELV $744
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $745
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $732
JUMPV
LABELV $736
line 1440
;1438:	}
;1439:
;1440:	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
ADDRLP4 0
ADDRGP4 level+88
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1441
;1441:	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];
ADDRLP4 4
ADDRGP4 level+88+4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1443
;1442:
;1443:	return a == b;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $750
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $751
JUMPV
LABELV $750
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $751
ADDRLP4 8
INDIRI4
RETI4
LABELV $732
endproc ScoreIsTied 12 0
proc CheckExitRules 16 8
line 1456
;1444:}
;1445:
;1446:
;1447:/*
;1448:=================
;1449:CheckExitRules
;1450:
;1451:There will be a delay between the time the exit is qualified for
;1452:and the time everyone is moved to the intermission spot, so you
;1453:can see the last frag.
;1454:=================
;1455:*/
;1456:static void CheckExitRules( void ) {
line 1462
;1457:	int			i;
;1458:	gclient_t	*cl;
;1459:
;1460:	// if at the intermission, wait for all non-bots to
;1461:	// signal ready, then go to next level
;1462:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $753
line 1463
;1463:		CheckIntermissionExit();
ADDRGP4 CheckIntermissionExit
CALLV
pop
line 1464
;1464:		return;
ADDRGP4 $752
JUMPV
LABELV $753
line 1467
;1465:	}
;1466:
;1467:	if ( level.intermissionQueued ) {
ADDRGP4 level+7600
INDIRI4
CNSTI4 0
EQI4 $756
line 1475
;1468:#ifdef MISSIONPACK
;1469:		int time = (g_singlePlayer.integer) ? SP_INTERMISSION_DELAY_TIME : INTERMISSION_DELAY_TIME;
;1470:		if ( level.time - level.intermissionQueued >= time ) {
;1471:			level.intermissionQueued = 0;
;1472:			BeginIntermission();
;1473:		}
;1474:#else
;1475:		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+7600
INDIRI4
SUBI4
CNSTI4 1000
LTI4 $752
line 1476
;1476:			level.intermissionQueued = 0;
ADDRGP4 level+7600
CNSTI4 0
ASGNI4
line 1477
;1477:			BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 1478
;1478:		}
line 1480
;1479:#endif
;1480:		return;
ADDRGP4 $752
JUMPV
LABELV $756
line 1484
;1481:	}
;1482:
;1483:	// check for sudden death
;1484:	if ( ScoreIsTied() ) {
ADDRLP4 8
ADDRGP4 ScoreIsTied
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $764
line 1486
;1485:		// always wait for sudden death
;1486:		return;
ADDRGP4 $752
JUMPV
LABELV $764
line 1489
;1487:	}
;1488:
;1489:	if ( g_timelimit.integer && !level.warmupTime ) {
ADDRGP4 g_timelimit+12
INDIRI4
CNSTI4 0
EQI4 $766
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $766
line 1490
;1490:		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
ADDRGP4 g_timelimit+12
INDIRI4
CNSTI4 60000
MULI4
LTI4 $770
line 1491
;1491:			G_BroadcastServerCommand( -1, "print \"Timelimit hit.\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $775
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1492
;1492:			LogExit( "Timelimit hit." );
ADDRGP4 $776
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1493
;1493:			return;
ADDRGP4 $752
JUMPV
LABELV $770
line 1495
;1494:		}
;1495:	}
LABELV $766
line 1497
;1496:
;1497:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
GEI4 $777
line 1498
;1498:		return;
ADDRGP4 $752
JUMPV
LABELV $777
line 1501
;1499:	}
;1500:
;1501:	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GEI4 $780
ADDRGP4 g_fraglimit+12
INDIRI4
CNSTI4 0
EQI4 $780
line 1502
;1502:		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $784
line 1503
;1503:			G_BroadcastServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $789
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1504
;1504:			LogExit( "Fraglimit hit." );
ADDRGP4 $790
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1505
;1505:			return;
ADDRGP4 $752
JUMPV
LABELV $784
line 1508
;1506:		}
;1507:
;1508:		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
ADDRGP4 level+48+8
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $791
line 1509
;1509:			G_BroadcastServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $796
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1510
;1510:			LogExit( "Fraglimit hit." );
ADDRGP4 $790
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1511
;1511:			return;
ADDRGP4 $752
JUMPV
LABELV $791
line 1514
;1512:		}
;1513:
;1514:		for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $800
JUMPV
LABELV $797
line 1515
;1515:			cl = level.clients + i;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1516
;1516:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $802
line 1517
;1517:				continue;
ADDRGP4 $798
JUMPV
LABELV $802
line 1519
;1518:			}
;1519:			if ( cl->sess.sessionTeam != TEAM_FREE ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 0
EQI4 $804
line 1520
;1520:				continue;
ADDRGP4 $798
JUMPV
LABELV $804
line 1523
;1521:			}
;1522:
;1523:			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $806
line 1524
;1524:				LogExit( "Fraglimit hit." );
ADDRGP4 $790
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1525
;1525:				G_BroadcastServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
ADDRGP4 $809
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1527
;1526:					cl->pers.netname ) );
;1527:				return;
ADDRGP4 $752
JUMPV
LABELV $806
line 1529
;1528:			}
;1529:		}
LABELV $798
line 1514
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $800
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $797
line 1530
;1530:	}
LABELV $780
line 1532
;1531:
;1532:	if ( g_gametype.integer >= GT_CTF && g_capturelimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
LTI4 $810
ADDRGP4 g_capturelimit+12
INDIRI4
CNSTI4 0
EQI4 $810
line 1534
;1533:
;1534:		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $814
line 1535
;1535:			G_BroadcastServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $819
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1536
;1536:			LogExit( "Capturelimit hit." );
ADDRGP4 $820
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1537
;1537:			return;
ADDRGP4 $752
JUMPV
LABELV $814
line 1540
;1538:		}
;1539:
;1540:		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
ADDRGP4 level+48+8
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $821
line 1541
;1541:			G_BroadcastServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $826
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1542
;1542:			LogExit( "Capturelimit hit." );
ADDRGP4 $820
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1543
;1543:			return;
LABELV $821
line 1545
;1544:		}
;1545:	}
LABELV $810
line 1546
;1546:}
LABELV $752
endproc CheckExitRules 16 8
proc ClearBodyQue 12 4
line 1549
;1547:
;1548:
;1549:static void ClearBodyQue( void ) {
line 1553
;1550:	int	i;
;1551:	gentity_t	*ent;
;1552:
;1553:	for ( i = 0 ; i < BODY_QUEUE_SIZE ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $828
line 1554
;1554:		ent = level.bodyQue[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+7656
ADDP4
INDIRP4
ASGNP4
line 1555
;1555:		if ( ent->r.linked || ent->physicsObject ) {
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $835
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $833
LABELV $835
line 1556
;1556:			trap_UnlinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1557
;1557:			ent->physicsObject = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 1558
;1558:		}
LABELV $833
line 1559
;1559:	}
LABELV $829
line 1553
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $828
line 1560
;1560:}
LABELV $827
endproc ClearBodyQue 12 4
proc G_WarmupEnd 44 12
line 1564
;1561:
;1562:
;1563:static void G_WarmupEnd( void ) 
;1564:{
line 1570
;1565:	gclient_t *client;
;1566:	gentity_t *ent;
;1567:	int i, t;
;1568:
;1569:	// remove corpses
;1570:	ClearBodyQue();
ADDRGP4 ClearBodyQue
CALLV
pop
line 1573
;1571:
;1572:	// return flags
;1573:	Team_ResetFlags();
ADDRGP4 Team_ResetFlags
CALLV
pop
line 1575
;1574:
;1575:	memset( level.teamScores, 0, sizeof( level.teamScores ) );
ADDRGP4 level+48
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1577
;1576:
;1577:	level.warmupTime = 0;
ADDRGP4 level+16
CNSTI4 0
ASGNI4
line 1578
;1578:	level.startTime = level.time;
ADDRGP4 level+40
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1580
;1579:
;1580:	trap_SetConfigstring( CS_SCORES1, "0" );
CNSTI4 6
ARGI4
ADDRGP4 $65
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1581
;1581:	trap_SetConfigstring( CS_SCORES2, "0" );
CNSTI4 7
ARGI4
ADDRGP4 $65
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1582
;1582:	trap_SetConfigstring( CS_WARMUP, "" );
CNSTI4 5
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1583
;1583:	trap_SetConfigstring( CS_LEVEL_START_TIME, va( "%i", level.startTime ) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 21
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1585
;1584:	
;1585:	client = level.clients;
ADDRLP4 0
ADDRGP4 level
INDIRP4
ASGNP4
line 1586
;1586:	for ( i = 0; i < level.maxclients; i++, client++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $846
JUMPV
LABELV $843
line 1588
;1587:		
;1588:		if ( client->pers.connected != CON_CONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $848
line 1589
;1589:			continue;
ADDRGP4 $844
JUMPV
LABELV $848
line 1592
;1590:
;1591:		// reset player awards
;1592:		client->ps.persistant[PERS_IMPRESSIVE_COUNT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
CNSTI4 0
ASGNI4
line 1593
;1593:		client->ps.persistant[PERS_EXCELLENT_COUNT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
CNSTI4 0
ASGNI4
line 1594
;1594:		client->ps.persistant[PERS_DEFEND_COUNT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
CNSTI4 0
ASGNI4
line 1595
;1595:		client->ps.persistant[PERS_ASSIST_COUNT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTI4 0
ASGNI4
line 1596
;1596:		client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
CNSTI4 0
ASGNI4
line 1598
;1597:
;1598:		client->ps.persistant[PERS_SCORE] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 0
ASGNI4
line 1599
;1599:		client->ps.persistant[PERS_CAPTURES] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTI4 0
ASGNI4
line 1601
;1600:
;1601:		client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1023
ASGNI4
line 1602
;1602:		client->ps.persistant[PERS_ATTACKEE_ARMOR] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 0
ASGNI4
line 1603
;1603:		client->damage.enemy = client->damage.team = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1556
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1560
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1605
;1604:
;1605:		client->ps.stats[STAT_CLIENTS_READY] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1606
;1606:		client->ps.stats[STAT_HOLDABLE_ITEM] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1608
;1607:
;1608:		memset( &client->ps.powerups, 0, sizeof( client->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1610
;1609:
;1610:		ClientUserinfoChanged( i ); // set max.health etc.
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 1612
;1611:
;1612:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $850
line 1613
;1613:			ClientSpawn( level.gentities + i );
ADDRLP4 8
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 level+4
INDIRP4
ADDP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 1614
;1614:		}
LABELV $850
line 1616
;1615:
;1616:		trap_SendServerCommand( i, "map_restart" );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 $853
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1617
;1617:	}
LABELV $844
line 1586
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1568
ADDP4
ASGNP4
LABELV $846
ADDRLP4 8
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $843
line 1620
;1618:
;1619:	// respawn items, remove projectiles, etc.
;1620:	ent = level.gentities + MAX_CLIENTS;
ADDRLP4 4
ADDRGP4 level+4
INDIRP4
CNSTI4 52224
ADDP4
ASGNP4
line 1621
;1621:	for ( i = MAX_CLIENTS; i < level.num_entities ; i++, ent++ ) {
ADDRLP4 8
CNSTI4 64
ASGNI4
ADDRGP4 $858
JUMPV
LABELV $855
line 1623
;1622:
;1623:		if ( !ent->inuse || ent->freeAfterEvent )
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $862
ADDRLP4 4
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $860
LABELV $862
line 1624
;1624:			continue;
ADDRGP4 $856
JUMPV
LABELV $860
line 1626
;1625:
;1626:		if ( ent->tag == TAG_DONTSPAWN ) {
ADDRLP4 4
INDIRP4
CNSTI4 812
ADDP4
INDIRI4
CNSTI4 1
NEI4 $863
line 1627
;1627:			ent->nextthink = 0;
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 1628
;1628:			continue;
ADDRGP4 $856
JUMPV
LABELV $863
line 1631
;1629:		}
;1630:
;1631:		if ( ent->s.eType == ET_ITEM && ent->item ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $865
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $865
line 1634
;1632:
;1633:			// already processed in Team_ResetFlags()
;1634:			if ( ent->item->giTag == PW_NEUTRALFLAG || ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG )
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
EQI4 $870
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
EQI4 $870
ADDRLP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $867
LABELV $870
line 1635
;1635:				continue;
ADDRGP4 $856
JUMPV
LABELV $867
line 1638
;1636:
;1637:			// remove dropped items
;1638:			if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $871
line 1639
;1639:				ent->nextthink = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1640
;1640:				continue;
ADDRGP4 $856
JUMPV
LABELV $871
line 1644
;1641:			}
;1642:
;1643:			// respawn picked up items
;1644:			t = SpawnTime( ent, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 SpawnTime
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 1645
;1645:			if ( t != 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $874
line 1647
;1646:				// hide items with defined spawn time
;1647:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 36
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1648
;1648:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 40
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1649
;1649:				ent->r.contents = 0;
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 1650
;1650:				ent->activator = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
CNSTP4 0
ASGNP4
line 1651
;1651:				ent->think = RespawnItem;
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 1652
;1652:			} else {
ADDRGP4 $875
JUMPV
LABELV $874
line 1653
;1653:				t = FRAMETIME;
ADDRLP4 12
CNSTI4 100
ASGNI4
line 1654
;1654:				if ( ent->activator ) {
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $876
line 1655
;1655:					ent->activator = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
CNSTP4 0
ASGNP4
line 1656
;1656:					ent->think = RespawnItem;
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 1657
;1657:				}
LABELV $876
line 1658
;1658:			}
LABELV $875
line 1659
;1659:			if ( ent->random ) {
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
EQF4 $878
line 1660
;1660:				t += (crandom() * ent->random) * 1000;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 36
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
ADDRLP4 4
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
MULF4
CNSTF4 1148846080
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1661
;1661:				if ( t < FRAMETIME ) {
ADDRLP4 12
INDIRI4
CNSTI4 100
GEI4 $880
line 1662
;1662:					t = FRAMETIME;
ADDRLP4 12
CNSTI4 100
ASGNI4
line 1663
;1663:				}
LABELV $880
line 1664
;1664:			}
LABELV $878
line 1665
;1665:			ent->nextthink = level.time + t;
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1667
;1666:
;1667:		} else if ( ent->s.eType == ET_MISSILE ) {
ADDRGP4 $866
JUMPV
LABELV $865
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $883
line 1669
;1668:			// remove all launched missiles
;1669:			G_FreeEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1670
;1670:		}
LABELV $883
LABELV $866
line 1671
;1671:	}
LABELV $856
line 1621
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 816
ADDP4
ASGNP4
LABELV $858
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $855
line 1672
;1672:}
LABELV $836
endproc G_WarmupEnd 44 12
proc CheckTournament 28 8
line 1691
;1673:
;1674:
;1675:/*
;1676:========================================================================
;1677:
;1678:FUNCTIONS CALLED EVERY FRAME
;1679:
;1680:========================================================================
;1681:*/
;1682:
;1683:
;1684:/*
;1685:=============
;1686:CheckTournament
;1687:
;1688:Once a frame, check for changes in tournement player state
;1689:=============
;1690:*/
;1691:static void CheckTournament( void ) {
line 1695
;1692:
;1693:	// check because we run 3 game frames before calling Connect and/or ClientBegin
;1694:	// for clients on a map_restart
;1695:	if ( level.numPlayingClients == 0 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 0
NEI4 $886
line 1696
;1696:		return;
ADDRGP4 $885
JUMPV
LABELV $886
line 1699
;1697:	}
;1698:
;1699:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $889
line 1702
;1700:
;1701:		// pull in a spectator if needed
;1702:		if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
GEI4 $892
line 1703
;1703:			AddTournamentPlayer();
ADDRGP4 AddTournamentPlayer
CALLV
pop
line 1704
;1704:		}
LABELV $892
line 1707
;1705:
;1706:		// if we don't have two players, go back to "waiting for players"
;1707:		if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
EQI4 $895
line 1708
;1708:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $885
line 1709
;1709:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1710
;1710:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1711
;1711:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $903
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1712
;1712:			}
line 1713
;1713:			return;
ADDRGP4 $885
JUMPV
LABELV $895
line 1716
;1714:		}
;1715:
;1716:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $904
line 1717
;1717:			return;
ADDRGP4 $885
JUMPV
LABELV $904
line 1721
;1718:		}
;1719:
;1720:		// if the warmup is changed at the console, restart it
;1721:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+356
INDIRI4
EQI4 $907
line 1722
;1722:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+356
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1723
;1723:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1724
;1724:		}
LABELV $907
line 1727
;1725:
;1726:		// if all players have arrived, start the countdown
;1727:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $914
line 1728
;1728:			if ( level.numPlayingClients == 2 ) {
ADDRGP4 level+84
INDIRI4
CNSTI4 2
NEI4 $885
line 1729
;1729:				if ( g_warmup.integer > 0 ) {
ADDRGP4 g_warmup+12
INDIRI4
CNSTI4 0
LEI4 $920
line 1730
;1730:					level.warmupTime = level.time + g_warmup.integer * 1000;
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1731
;1731:				} else {
ADDRGP4 $921
JUMPV
LABELV $920
line 1732
;1732:					level.warmupTime = 0;
ADDRGP4 level+16
CNSTI4 0
ASGNI4
line 1733
;1733:				}
LABELV $921
line 1735
;1734:
;1735:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1736
;1736:			}
line 1737
;1737:			return;
ADDRGP4 $885
JUMPV
LABELV $914
line 1741
;1738:		}
;1739:
;1740:		// if the warmup time has counted down, restart
;1741:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $890
line 1742
;1742:			G_WarmupEnd();
ADDRGP4 G_WarmupEnd
CALLV
pop
line 1743
;1743:			return;
ADDRGP4 $885
JUMPV
line 1745
;1744:		}
;1745:	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
LABELV $889
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $932
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $932
line 1747
;1746:		int		counts[TEAM_NUM_TEAMS];
;1747:		qboolean	notEnough = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1749
;1748:
;1749:		if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $936
line 1750
;1750:			counts[TEAM_BLUE] = TeamConnectedCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 20
ADDRGP4 TeamConnectedCount
CALLI4
ASGNI4
ADDRLP4 4+8
ADDRLP4 20
INDIRI4
ASGNI4
line 1751
;1751:			counts[TEAM_RED] = TeamConnectedCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 TeamConnectedCount
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 24
INDIRI4
ASGNI4
line 1753
;1752:
;1753:			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
ADDRLP4 4+4
INDIRI4
CNSTI4 1
LTI4 $945
ADDRLP4 4+8
INDIRI4
CNSTI4 1
GEI4 $937
LABELV $945
line 1754
;1754:				notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1755
;1755:			}
line 1756
;1756:		} else if ( level.numPlayingClients < 2 ) {
ADDRGP4 $937
JUMPV
LABELV $936
ADDRGP4 level+84
INDIRI4
CNSTI4 2
GEI4 $946
line 1757
;1757:			notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1758
;1758:		}
LABELV $946
LABELV $937
line 1760
;1759:
;1760:		if ( notEnough ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $949
line 1761
;1761:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $885
line 1762
;1762:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1763
;1763:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1764
;1764:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $903
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1765
;1765:			}
line 1766
;1766:			return; // still waiting for team members
ADDRGP4 $885
JUMPV
LABELV $949
line 1769
;1767:		}
;1768:
;1769:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $956
line 1770
;1770:			return;
ADDRGP4 $885
JUMPV
LABELV $956
line 1774
;1771:		}
;1772:
;1773:		// if the warmup is changed at the console, restart it
;1774:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+356
INDIRI4
EQI4 $959
line 1775
;1775:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+356
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1776
;1776:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1777
;1777:		}
LABELV $959
line 1780
;1778:
;1779:		// if all players have arrived, start the countdown
;1780:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $966
line 1781
;1781:			if ( g_warmup.integer > 0 ) {
ADDRGP4 g_warmup+12
INDIRI4
CNSTI4 0
LEI4 $969
line 1782
;1782:				level.warmupTime = level.time + g_warmup.integer * 1000;
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1783
;1783:			} else {
ADDRGP4 $970
JUMPV
LABELV $969
line 1784
;1784:				level.warmupTime = 0;
ADDRGP4 level+16
CNSTI4 0
ASGNI4
line 1785
;1785:			}
LABELV $970
line 1787
;1786:
;1787:			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $526
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1788
;1788:			return;
ADDRGP4 $885
JUMPV
LABELV $966
line 1792
;1789:		}
;1790:
;1791:		// if the warmup time has counted down, restart
;1792:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $977
line 1793
;1793:			G_WarmupEnd();
ADDRGP4 G_WarmupEnd
CALLV
pop
line 1794
;1794:			return;
LABELV $977
line 1796
;1795:		}
;1796:	}
LABELV $932
LABELV $890
line 1797
;1797:}
LABELV $885
endproc CheckTournament 28 8
proc CheckVote 4 8
line 1805
;1798:
;1799:
;1800:/*
;1801:==================
;1802:CheckVote
;1803:==================
;1804:*/
;1805:static void CheckVote( void ) {
line 1807
;1806:	
;1807:	if ( level.voteExecuteTime ) {
ADDRGP4 level+876
INDIRI4
CNSTI4 0
EQI4 $982
line 1808
;1808:		 if ( level.voteExecuteTime < level.time ) {
ADDRGP4 level+876
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $981
line 1809
;1809:			level.voteExecuteTime = 0;
ADDRGP4 level+876
CNSTI4 0
ASGNI4
line 1810
;1810:			trap_SendConsoleCommand( EXEC_APPEND, va( "%s\n", level.voteString ) );
ADDRGP4 $990
ARGP4
ADDRGP4 level+360
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1811
;1811:		 }
line 1812
;1812:		 return;
ADDRGP4 $981
JUMPV
LABELV $982
line 1815
;1813:	}
;1814:
;1815:	if ( !level.voteTime ) {
ADDRGP4 level+872
INDIRI4
CNSTI4 0
NEI4 $992
line 1816
;1816:		return;
ADDRGP4 $981
JUMPV
LABELV $992
line 1819
;1817:	}
;1818:
;1819:	if ( level.time - level.voteTime >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+872
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $995
line 1820
;1820:		G_BroadcastServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $999
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1821
;1821:	} else {
ADDRGP4 $996
JUMPV
LABELV $995
line 1823
;1822:		// ATVI Q3 1.32 Patch #9, WNF
;1823:		if ( level.voteYes > level.numVotingClients/2 ) {
ADDRGP4 level+880
INDIRI4
ADDRGP4 level+888
INDIRI4
CNSTI4 2
DIVI4
LEI4 $1000
line 1825
;1824:			// execute the command, then remove the vote
;1825:			G_BroadcastServerCommand( -1, "print \"Vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $1004
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1826
;1826:			level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+876
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1827
;1827:		} else if ( level.voteNo >= level.numVotingClients/2 ) {
ADDRGP4 $1001
JUMPV
LABELV $1000
ADDRGP4 level+884
INDIRI4
ADDRGP4 level+888
INDIRI4
CNSTI4 2
DIVI4
LTI4 $981
line 1829
;1828:			// same behavior as a timeout
;1829:			G_BroadcastServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $999
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1830
;1830:		} else {
line 1832
;1831:			// still waiting for a majority
;1832:			return;
LABELV $1008
LABELV $1001
line 1834
;1833:		}
;1834:	}
LABELV $996
line 1836
;1835:
;1836:	level.voteTime = 0;
ADDRGP4 level+872
CNSTI4 0
ASGNI4
line 1837
;1837:	trap_SetConfigstring( CS_VOTE_TIME, "" );
CNSTI4 8
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1838
;1838:}
LABELV $981
endproc CheckVote 4 8
proc PrintTeam 4 8
line 1846
;1839:
;1840:
;1841:/*
;1842:==================
;1843:PrintTeam
;1844:==================
;1845:*/
;1846:static void PrintTeam( team_t team, const char *message ) {
line 1849
;1847:	int i;
;1848:
;1849:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1016
JUMPV
LABELV $1013
line 1850
;1850:		if ( level.clients[i].sess.sessionTeam != team )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $1018
line 1851
;1851:			continue;
ADDRGP4 $1014
JUMPV
LABELV $1018
line 1852
;1852:		if ( level.clients[i].pers.connected != CON_CONNECTED )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1020
line 1853
;1853:			continue;
ADDRGP4 $1014
JUMPV
LABELV $1020
line 1854
;1854:		trap_SendServerCommand( i, message );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1855
;1855:	}
LABELV $1014
line 1849
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1016
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1013
line 1856
;1856:}
LABELV $1012
endproc PrintTeam 4 8
export SetLeader
proc SetLeader 8 8
line 1864
;1857:
;1858:
;1859:/*
;1860:==================
;1861:SetLeader
;1862:==================
;1863:*/
;1864:void SetLeader( team_t team, int client ) {
line 1867
;1865:	int i;
;1866:
;1867:	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1023
line 1868
;1868:		PrintTeam( team, va("print \"%s "S_COLOR_STRIP"is not connected\n\"", level.clients[client].pers.netname) );
ADDRGP4 $1025
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1869
;1869:		return;
ADDRGP4 $1022
JUMPV
LABELV $1023
line 1871
;1870:	}
;1871:	if (level.clients[client].sess.sessionTeam != team) {
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $1026
line 1872
;1872:		PrintTeam( team, va("print \"%s "S_COLOR_STRIP"is not on the team anymore\n\"", level.clients[client].pers.netname) );
ADDRGP4 $1028
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1873
;1873:		return;
ADDRGP4 $1022
JUMPV
LABELV $1026
line 1875
;1874:	}
;1875:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1032
JUMPV
LABELV $1029
line 1876
;1876:		if (level.clients[i].sess.sessionTeam != team)
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $1034
line 1877
;1877:			continue;
ADDRGP4 $1030
JUMPV
LABELV $1034
line 1878
;1878:		if (level.clients[i].sess.teamLeader) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1036
line 1879
;1879:			level.clients[i].sess.teamLeader = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 648
ADDP4
CNSTI4 0
ASGNI4
line 1880
;1880:			ClientUserinfoChanged( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 1881
;1881:		}
LABELV $1036
line 1882
;1882:	}
LABELV $1030
line 1875
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1032
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1029
line 1883
;1883:	level.clients[client].sess.teamLeader = qtrue;
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 648
ADDP4
CNSTI4 1
ASGNI4
line 1884
;1884:	ClientUserinfoChanged( client );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 1885
;1885:	PrintTeam( team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
ADDRGP4 $1038
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1886
;1886:}
LABELV $1022
endproc SetLeader 8 8
export CheckTeamLeader
proc CheckTeamLeader 28 8
line 1894
;1887:
;1888:
;1889:/*
;1890:==================
;1891:CheckTeamLeader
;1892:==================
;1893:*/
;1894:void CheckTeamLeader( team_t team ) {
line 1899
;1895:	int i;
;1896:	int	max_score, max_id;
;1897:	int	max_bot_score, max_bot_id;
;1898:
;1899:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1043
JUMPV
LABELV $1040
line 1901
;1900:
;1901:		if ( level.clients[i].sess.sessionTeam != team || level.clients[i].pers.connected == CON_DISCONNECTED )
ADDRLP4 24
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRLP4 24
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1047
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRLP4 24
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1045
LABELV $1047
line 1902
;1902:			continue;
ADDRGP4 $1041
JUMPV
LABELV $1045
line 1904
;1903:
;1904:		if ( level.clients[i].sess.teamLeader )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1048
line 1905
;1905:			return;
ADDRGP4 $1039
JUMPV
LABELV $1048
line 1906
;1906:	}
LABELV $1041
line 1899
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1043
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1040
line 1909
;1907:
;1908:	// no leaders? find player with highest score
;1909:	max_score = SHRT_MIN;
ADDRLP4 4
CNSTI4 -32768
ASGNI4
line 1910
;1910:	max_id = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 1911
;1911:	max_bot_score = SHRT_MIN;
ADDRLP4 8
CNSTI4 -32768
ASGNI4
line 1912
;1912:	max_bot_id = -1;
ADDRLP4 16
CNSTI4 -1
ASGNI4
line 1914
;1913:
;1914:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1053
JUMPV
LABELV $1050
line 1916
;1915:
;1916:		if ( level.clients[i].sess.sessionTeam != team )
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $1055
line 1917
;1917:			continue;
ADDRGP4 $1051
JUMPV
LABELV $1055
line 1919
;1918:
;1919:		if ( g_entities[i].r.svFlags & SVF_BOT ) {
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
EQI4 $1057
line 1920
;1920:			if ( level.clients[i].ps.persistant[PERS_SCORE] > max_bot_score ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $1058
line 1921
;1921:				max_bot_score = level.clients[i].ps.persistant[PERS_SCORE];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1922
;1922:				max_bot_id = i;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 1923
;1923:			}
line 1924
;1924:		} else {
ADDRGP4 $1058
JUMPV
LABELV $1057
line 1925
;1925:			if ( level.clients[i].ps.persistant[PERS_SCORE] > max_score ) {
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $1063
line 1926
;1926:				max_score = level.clients[i].ps.persistant[PERS_SCORE];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1927
;1927:				max_id = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 1928
;1928:			}
LABELV $1063
line 1929
;1929:		}
LABELV $1058
line 1930
;1930:	}
LABELV $1051
line 1914
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1053
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1050
line 1932
;1931:
;1932:	if ( max_id != -1 ) {
ADDRLP4 12
INDIRI4
CNSTI4 -1
EQI4 $1065
line 1933
;1933:		SetLeader( team, max_id ); 
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1934
;1934:		return;
ADDRGP4 $1039
JUMPV
LABELV $1065
line 1937
;1935:	}
;1936:
;1937:	if ( max_bot_id != -1 ) {
ADDRLP4 16
INDIRI4
CNSTI4 -1
EQI4 $1067
line 1938
;1938:		SetLeader( team, max_bot_id );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1939
;1939:		return;
LABELV $1067
line 1941
;1940:	}
;1941:}
LABELV $1039
endproc CheckTeamLeader 28 8
proc CheckTeamVote 16 12
line 1949
;1942:
;1943:
;1944:/*
;1945:==================
;1946:CheckTeamVote
;1947:==================
;1948:*/
;1949:static void CheckTeamVote( team_t team ) {
line 1952
;1950:	int cs_offset;
;1951:
;1952:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1070
line 1953
;1953:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1071
JUMPV
LABELV $1070
line 1954
;1954:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1069
line 1955
;1955:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1957
;1956:	else
;1957:		return;
LABELV $1073
LABELV $1071
line 1959
;1958:
;1959:	if ( !level.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1074
line 1960
;1960:		return;
ADDRGP4 $1069
JUMPV
LABELV $1074
line 1962
;1961:	}
;1962:	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2940
ADDP4
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $1077
line 1963
;1963:		G_BroadcastServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $1081
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1964
;1964:	} else {
ADDRGP4 $1078
JUMPV
LABELV $1077
line 1965
;1965:		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2948
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2964
ADDP4
INDIRI4
CNSTI4 2
DIVI4
LEI4 $1082
line 1967
;1966:			// execute the command, then remove the vote
;1967:			G_BroadcastServerCommand( -1, "print \"Team vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $1086
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1969
;1968:			//
;1969:			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
ADDRGP4 $1089
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+892
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1087
line 1971
;1970:				//set the team leader
;1971:				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+892+7
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1972
;1972:			}
ADDRGP4 $1083
JUMPV
LABELV $1087
line 1973
;1973:			else {
line 1974
;1974:				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
ADDRGP4 $990
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+892
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1975
;1975:			}
line 1976
;1976:		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
ADDRGP4 $1083
JUMPV
LABELV $1082
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2956
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2964
ADDP4
INDIRI4
CNSTI4 2
DIVI4
LTI4 $1069
line 1978
;1977:			// same behavior as a timeout
;1978:			G_BroadcastServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $1081
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 1979
;1979:		} else {
line 1981
;1980:			// still waiting for a majority
;1981:			return;
LABELV $1095
LABELV $1083
line 1983
;1982:		}
;1983:	}
LABELV $1078
line 1984
;1984:	level.teamVoteTime[cs_offset] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+2940
ADDP4
CNSTI4 0
ASGNI4
line 1985
;1985:	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );
ADDRLP4 0
INDIRI4
CNSTI4 12
ADDI4
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1987
;1986:
;1987:}
LABELV $1069
endproc CheckTeamVote 16 12
data
align 4
LABELV $1100
byte 4 -1
export CheckCvars
code
proc CheckCvars 4 8
line 1995
;1988:
;1989:
;1990:/*
;1991:==================
;1992:CheckCvars
;1993:==================
;1994:*/
;1995:void CheckCvars( void ) {
line 1998
;1996:	static int lastMod = -1;
;1997:
;1998:	if ( lastMod != g_password.modificationCount ) {
ADDRGP4 $1100
INDIRI4
ADDRGP4 g_password+4
INDIRI4
EQI4 $1101
line 1999
;1999:		lastMod = g_password.modificationCount;
ADDRGP4 $1100
ADDRGP4 g_password+4
INDIRI4
ASGNI4
line 2000
;2000:		if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) != 0 ) {
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1105
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $1109
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1105
line 2001
;2001:			trap_Cvar_Set( "g_needpass", "1" );
ADDRGP4 $86
ARGP4
ADDRGP4 $77
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2002
;2002:		} else {
ADDRGP4 $1106
JUMPV
LABELV $1105
line 2003
;2003:			trap_Cvar_Set( "g_needpass", "0" );
ADDRGP4 $86
ARGP4
ADDRGP4 $65
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2004
;2004:		}
LABELV $1106
line 2005
;2005:	}
LABELV $1101
line 2006
;2006:}
LABELV $1099
endproc CheckCvars 4 8
export G_RunThink
proc G_RunThink 8 4
line 2016
;2007:
;2008:
;2009:/*
;2010:=============
;2011:G_RunThink
;2012:
;2013:Runs thinking code for this frame if necessary
;2014:=============
;2015:*/
;2016:void G_RunThink( gentity_t *ent ) {
line 2019
;2017:	int	thinktime;
;2018:
;2019:	thinktime = ent->nextthink;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ASGNI4
line 2020
;2020:	if (thinktime <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1111
line 2021
;2021:		return;
ADDRGP4 $1110
JUMPV
LABELV $1111
line 2023
;2022:	}
;2023:	if (thinktime > level.time) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1113
line 2024
;2024:		return;
ADDRGP4 $1110
JUMPV
LABELV $1113
line 2027
;2025:	}
;2026:	
;2027:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 2028
;2028:	if ( !ent->think ) {
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1116
line 2029
;2029:		G_Error ( "NULL ent->think");
ADDRGP4 $1118
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2030
;2030:	} else {
ADDRGP4 $1117
JUMPV
LABELV $1116
line 2031
;2031:		ent->think (ent);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CALLV
pop
line 2032
;2032:	}
LABELV $1117
line 2033
;2033:}
LABELV $1110
endproc G_RunThink 8 4
bss
align 4
LABELV $1120
skip 3840
code
proc G_RunFrame 32 12
line 2043
;2034:
;2035:
;2036:/*
;2037:================
;2038:G_RunFrame
;2039:
;2040:Advances the non-player objects in the world
;2041:================
;2042:*/
;2043:static void G_RunFrame( int levelTime ) {
line 2051
;2044:	int			i;
;2045:	gentity_t	*ent;
;2046:	gclient_t	*client;
;2047:	static	gentity_t *missiles[ MAX_GENTITIES - MAX_CLIENTS ];
;2048:	int		numMissiles;
;2049:	
;2050:	// if we are waiting for the level to restart, do nothing
;2051:	if ( level.restarted ) {
ADDRGP4 level+72
INDIRI4
CNSTI4 0
EQI4 $1121
line 2052
;2052:		return;
ADDRGP4 $1119
JUMPV
LABELV $1121
line 2055
;2053:	}
;2054:
;2055:	level.framenum++;
ADDRLP4 16
ADDRGP4 level+28
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2056
;2056:	level.previousTime = level.time;
ADDRGP4 level+36
ADDRGP4 level+32
INDIRI4
ASGNI4
line 2057
;2057:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 2058
;2058:	level.msec = level.time - level.previousTime;
ADDRGP4 level+44
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
ASGNI4
line 2061
;2059:
;2060:	// get any cvar changes
;2061:	G_UpdateCvars();
ADDRGP4 G_UpdateCvars
CALLV
pop
line 2063
;2062:
;2063:	numMissiles = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2068
;2064:
;2065:	//
;2066:	// go through all allocated objects
;2067:	//
;2068:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 2069
;2069:	for (i=0 ; i<level.num_entities ; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1134
JUMPV
LABELV $1131
line 2070
;2070:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1136
line 2071
;2071:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1136
line 2075
;2072:		}
;2073:
;2074:		// clear events that are too old
;2075:		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 300
LEI4 $1138
line 2076
;2076:			if ( ent->s.event ) {
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1141
line 2077
;2077:				ent->s.event = 0;	// &= EV_EVENT_BITS;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 2078
;2078:				if ( ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1143
line 2079
;2079:					ent->client->ps.externalEvent = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 2083
;2080:					// predicted events should never be set to zero
;2081:					//ent->client->ps.events[0] = 0;
;2082:					//ent->client->ps.events[1] = 0;
;2083:				}
LABELV $1143
line 2084
;2084:			}
LABELV $1141
line 2085
;2085:			if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1145
line 2087
;2086:				// tempEntities or dropped items completely go away after their event
;2087:				G_FreeEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 2088
;2088:				continue;
ADDRGP4 $1132
JUMPV
LABELV $1145
line 2089
;2089:			} else if ( ent->unlinkAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1147
line 2091
;2090:				// items that will respawn will hide themselves after their pickup event
;2091:				ent->unlinkAfterEvent = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 2092
;2092:				trap_UnlinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 2093
;2093:			}
LABELV $1147
line 2094
;2094:		}
LABELV $1138
line 2097
;2095:
;2096:		// temporary entities don't think
;2097:		if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1149
line 2098
;2098:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1149
line 2101
;2099:		}
;2100:
;2101:		if ( !ent->r.linked && ent->neverFree ) {
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1151
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1151
line 2102
;2102:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1151
line 2105
;2103:		}
;2104:
;2105:		if ( ent->s.eType == ET_MISSILE ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1153
line 2107
;2106:			// queue for unlagged pass
;2107:			missiles[ numMissiles ] = ent;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1120
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2108
;2108:			numMissiles++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2109
;2109:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1153
line 2112
;2110:		}
;2111:
;2112:		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1157
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1155
LABELV $1157
line 2113
;2113:			G_RunItem( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunItem
CALLV
pop
line 2114
;2114:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1155
line 2117
;2115:		}
;2116:
;2117:		if ( ent->s.eType == ET_MOVER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1158
line 2118
;2118:			G_RunMover( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunMover
CALLV
pop
line 2119
;2119:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1158
line 2122
;2120:		}
;2121:
;2122:		if ( i < MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $1160
line 2123
;2123:			client = ent->client;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 2124
;2124:			client->sess.spectatorTime += level.msec; 
ADDRLP4 28
ADDRLP4 12
INDIRP4
CNSTI4 628
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRGP4 level+44
INDIRI4
ADDI4
ASGNI4
line 2125
;2125:			if ( client->pers.connected == CON_CONNECTED )
ADDRLP4 12
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1132
line 2126
;2126:				G_RunClient( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunClient
CALLV
pop
line 2127
;2127:			continue;
ADDRGP4 $1132
JUMPV
LABELV $1160
line 2130
;2128:		}
;2129:
;2130:		G_RunThink( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 2131
;2131:	}
LABELV $1132
line 2069
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
LABELV $1134
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $1131
line 2133
;2132:
;2133:	if ( numMissiles ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1165
line 2135
;2134:		// unlagged
;2135:		G_TimeShiftAllClients( level.previousTime, NULL );
ADDRGP4 level+36
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 G_TimeShiftAllClients
CALLV
pop
line 2137
;2136:		// run missiles
;2137:		for ( i = 0; i < numMissiles; i++ )
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1171
JUMPV
LABELV $1168
line 2138
;2138:			G_RunMissile( missiles[ i ] );
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1120
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_RunMissile
CALLV
pop
LABELV $1169
line 2137
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1171
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1168
line 2140
;2139:		// unlagged
;2140:		G_UnTimeShiftAllClients( NULL );
CNSTP4 0
ARGP4
ADDRGP4 G_UnTimeShiftAllClients
CALLV
pop
line 2141
;2141:	}
LABELV $1165
line 2144
;2142:
;2143:	// perform final fixups on the players
;2144:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 2145
;2145:	for ( i = 0; i < level.maxclients; i++, ent++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1175
JUMPV
LABELV $1172
line 2146
;2146:		if ( ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1177
line 2147
;2147:			ClientEndFrame( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 2148
;2148:		}
LABELV $1177
line 2149
;2149:	}
LABELV $1173
line 2145
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
LABELV $1175
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1172
line 2152
;2150:
;2151:	// see if it is time to do a tournement restart
;2152:	CheckTournament();
ADDRGP4 CheckTournament
CALLV
pop
line 2155
;2153:
;2154:	// see if it is time to end the level
;2155:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 2158
;2156:
;2157:	// update to team status?
;2158:	CheckTeamStatus();
ADDRGP4 CheckTeamStatus
CALLV
pop
line 2161
;2159:
;2160:	// cancel vote if timed out
;2161:	CheckVote();
ADDRGP4 CheckVote
CALLV
pop
line 2164
;2162:
;2163:	// check team votes
;2164:	CheckTeamVote( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2165
;2165:	CheckTeamVote( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 2168
;2166:
;2167:	// for tracking changes
;2168:	CheckCvars();
ADDRGP4 CheckCvars
CALLV
pop
line 2170
;2169:
;2170:	if (g_listEntity.integer) {
ADDRGP4 g_listEntity+12
INDIRI4
CNSTI4 0
EQI4 $1179
line 2171
;2171:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1182
line 2172
;2172:			G_Printf("%4i: %s\n", i, g_entities[i].classname);
ADDRGP4 $1186
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 2173
;2173:		}
LABELV $1183
line 2171
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $1182
line 2174
;2174:		trap_Cvar_Set("g_listEntity", "0");
ADDRGP4 $111
ARGP4
ADDRGP4 $65
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2175
;2175:	}
LABELV $1179
line 2178
;2176:
;2177:	// unlagged
;2178:	level.frameStartTime = trap_Milliseconds();
ADDRLP4 20
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 level+11800
ADDRLP4 20
INDIRI4
ASGNI4
line 2179
;2179:}
LABELV $1119
endproc G_RunFrame 32 12
bss
export trap_GetValue
align 4
LABELV trap_GetValue
skip 4
export g_listEntity
align 4
LABELV g_listEntity
skip 272
export g_podiumDrop
align 4
LABELV g_podiumDrop
skip 272
export g_podiumDist
align 4
LABELV g_podiumDist
skip 272
export g_logSync
align 4
LABELV g_logSync
skip 272
export g_log
align 4
LABELV g_log
skip 272
export g_maxclients
align 4
LABELV g_maxclients
skip 272
export g_clients
align 4
LABELV g_clients
skip 100352
export svf_self_portal2
align 4
LABELV svf_self_portal2
skip 4
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
export g_predictPVS
align 4
LABELV g_predictPVS
skip 272
export g_unlagged
align 4
LABELV g_unlagged
skip 272
export g_rotation
align 4
LABELV g_rotation
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export g_smoothClients
align 4
LABELV g_smoothClients
skip 272
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
export g_filterBan
align 4
LABELV g_filterBan
skip 272
export g_banIPs
align 4
LABELV g_banIPs
skip 272
export g_teamForceBalance
align 4
LABELV g_teamForceBalance
skip 272
export g_autoJoin
align 4
LABELV g_autoJoin
skip 272
export g_allowVote
align 4
LABELV g_allowVote
skip 272
export g_blood
align 4
LABELV g_blood
skip 272
export g_warmup
align 4
LABELV g_warmup
skip 272
export g_motd
align 4
LABELV g_motd
skip 272
export g_synchronousClients
align 4
LABELV g_synchronousClients
skip 272
export g_weaponTeamRespawn
align 4
LABELV g_weaponTeamRespawn
skip 272
export g_weaponRespawn
align 4
LABELV g_weaponRespawn
skip 272
export g_debugDamage
align 4
LABELV g_debugDamage
skip 272
export g_debugAlloc
align 4
LABELV g_debugAlloc
skip 272
export g_debugMove
align 4
LABELV g_debugMove
skip 272
export g_inactivity
align 4
LABELV g_inactivity
skip 272
export g_forcerespawn
align 4
LABELV g_forcerespawn
skip 272
export g_quadfactor
align 4
LABELV g_quadfactor
skip 272
export g_knockback
align 4
LABELV g_knockback
skip 272
export g_speed
align 4
LABELV g_speed
skip 272
export g_gravity
align 4
LABELV g_gravity
skip 272
export g_needpass
align 4
LABELV g_needpass
skip 272
export g_password
align 4
LABELV g_password
skip 272
export g_friendlyFire
align 4
LABELV g_friendlyFire
skip 272
export g_capturelimit
align 4
LABELV g_capturelimit
skip 272
export g_timelimit
align 4
LABELV g_timelimit
skip 272
export g_fraglimit
align 4
LABELV g_fraglimit
skip 272
export g_dmflags
align 4
LABELV g_dmflags
skip 272
export g_maxGameClients
align 4
LABELV g_maxGameClients
skip 272
export g_cheats
align 4
LABELV g_cheats
skip 272
export g_dedicated
align 4
LABELV g_dedicated
skip 272
export sv_fps
align 4
LABELV sv_fps
skip 272
export g_mapname
align 4
LABELV g_mapname
skip 272
export g_gametype
align 4
LABELV g_gametype
skip 272
export g_entities
align 4
LABELV g_entities
skip 835584
export level
align 4
LABELV level
skip 11804
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
import DeathmatchScoreboardMessage
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
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
LABELV $1186
byte 1 37
byte 1 52
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1118
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 45
byte 1 62
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $1109
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $1089
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1086
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1081
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1038
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1028
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1025
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $1004
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $999
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $990
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $903
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $853
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $826
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
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
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $820
byte 1 67
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
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $819
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
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
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $809
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $796
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $790
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $789
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $776
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $775
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $680
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $663
byte 1 114
byte 1 101
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $654
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $648
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $643
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $640
byte 1 118
byte 1 115
byte 1 116
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $638
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 0
align 1
LABELV $635
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $611
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $526
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $387
byte 1 115
byte 1 0
align 1
LABELV $378
byte 1 102
byte 1 0
align 1
LABELV $344
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $340
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $337
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 77
byte 1 97
byte 1 112
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $331
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $328
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
LABELV $326
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $322
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
LABELV $316
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $300
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $299
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $298
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
LABELV $296
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $281
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
byte 1 102
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $275
byte 1 83
byte 1 86
byte 1 70
byte 1 95
byte 1 83
byte 1 69
byte 1 76
byte 1 70
byte 1 95
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 65
byte 1 76
byte 1 50
byte 1 95
byte 1 81
byte 1 51
byte 1 69
byte 1 0
align 1
LABELV $270
byte 1 47
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $269
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $268
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $267
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
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
LABELV $262
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $257
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $252
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $247
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $244
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 0
align 1
LABELV $239
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $230
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $227
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 0
align 1
LABELV $209
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $197
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $193
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
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
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
byte 1 44
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
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
LABELV $117
byte 1 103
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $116
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $115
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $114
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $113
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 80
byte 1 86
byte 1 83
byte 1 0
align 1
LABELV $112
byte 1 103
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $111
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $110
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $109
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $108
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
LABELV $107
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $106
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
LABELV $105
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $104
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 0
align 1
LABELV $102
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $101
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 77
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $98
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $97
byte 1 53
byte 1 0
align 1
LABELV $96
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 51
byte 1 0
align 1
LABELV $94
byte 1 103
byte 1 95
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $93
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $92
byte 1 103
byte 1 95
byte 1 107
byte 1 110
byte 1 111
byte 1 99
byte 1 107
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $91
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $90
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $89
byte 1 51
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $88
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $87
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $86
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $85
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $84
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 0
align 1
LABELV $83
byte 1 103
byte 1 95
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $82
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 83
byte 1 121
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $81
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $80
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $79
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $78
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 66
byte 1 97
byte 1 108
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $77
byte 1 49
byte 1 0
align 1
LABELV $76
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $75
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $74
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $73
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
LABELV $72
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
LABELV $71
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $70
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
LABELV $69
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $68
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $67
byte 1 56
byte 1 0
align 1
LABELV $66
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $65
byte 1 48
byte 1 0
align 1
LABELV $64
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
LABELV $63
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $62
byte 1 115
byte 1 118
byte 1 95
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $61
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $60
byte 1 77
byte 1 97
byte 1 114
byte 1 32
byte 1 50
byte 1 54
byte 1 32
byte 1 50
byte 1 48
byte 1 50
byte 1 50
byte 1 0
align 1
LABELV $59
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $58
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 0
align 1
LABELV $57
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $56
byte 1 0
align 1
LABELV $55
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
