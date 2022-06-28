data
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export enemyModelModificationCount
align 4
LABELV enemyModelModificationCount
byte 4 -1
export enemyColorsModificationCount
align 4
LABELV enemyColorsModificationCount
byte 4 -1
export teamModelModificationCount
align 4
LABELV teamModelModificationCount
byte 4 -1
export teamColorsModificationCount
align 4
LABELV teamColorsModificationCount
byte 4 -1
export intShaderTime
align 4
LABELV intShaderTime
byte 4 0
export linearLight
align 4
LABELV linearLight
byte 4 0
export vmMain
code
proc vmMain 16 12
file "..\..\..\..\code\cgame\cg_main.c"
line 43
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_main.c -- initialization and primary entry point for cgame
;4:#include "cg_local.h"
;5:
;6:#ifdef MISSIONPACK
;7:#include "../ui/ui_shared.h"
;8:// display context for new ui stuff
;9:displayContextDef_t cgDC;
;10:#endif
;11:
;12:int forceModelModificationCount = -1;
;13:int enemyModelModificationCount  = -1;
;14:int	enemyColorsModificationCount = -1;
;15:int teamModelModificationCount  = -1;
;16:int	teamColorsModificationCount = -1;
;17:
;18:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum );
;19:void CG_Shutdown( void );
;20:
;21:// extension interface
;22:qboolean intShaderTime = qfalse;
;23:qboolean linearLight = qfalse;
;24:
;25:#ifdef Q3_VM
;26:qboolean (*trap_GetValue)( char *value, int valueSize, const char *key );
;27:void (*trap_R_AddRefEntityToScene2)( const refEntity_t *re );
;28:void (*trap_R_AddLinearLightToScene)( const vec3_t start, const vec3_t end, float intensity, float r, float g, float b );
;29:#else
;30:int dll_com_trapGetValue;
;31:int dll_trap_R_AddRefEntityToScene2;
;32:int dll_trap_R_AddLinearLightToScene;
;33:#endif
;34:
;35:/*
;36:================
;37:vmMain
;38:
;39:This is the only way control passes into the module.
;40:This must be the very first function compiled into the .q3vm file
;41:================
;42:*/
;43:DLLEXPORT intptr_t vmMain( int command, int arg0, int arg1, int arg2 ) {
line 45
;44:
;45:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $78
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $78
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $90
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $90
address $80
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
code
LABELV $80
line 47
;46:	case CG_INIT:
;47:		CG_Init( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 48
;48:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $81
line 50
;49:	case CG_SHUTDOWN:
;50:		CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 51
;51:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $82
line 53
;52:	case CG_CONSOLE_COMMAND:
;53:		return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $83
line 55
;54:	case CG_DRAW_ACTIVE_FRAME:
;55:		CG_DrawActiveFrame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 56
;56:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $84
line 58
;57:	case CG_CROSSHAIR_PLAYER:
;58:		return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $85
line 60
;59:	case CG_LAST_ATTACKER:
;60:		return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $86
line 62
;61:	case CG_KEY_EVENT:
;62:		CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 63
;63:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $87
line 69
;64:	case CG_MOUSE_EVENT:
;65:#ifdef MISSIONPACK
;66:		cgDC.cursorx = cgs.cursorX;
;67:		cgDC.cursory = cgs.cursorY;
;68:#endif
;69:		CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 70
;70:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $88
line 72
;71:	case CG_EVENT_HANDLING:
;72:		CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 73
;73:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $78
line 75
;74:	default:
;75:		CG_Error( "vmMain: unknown command %i", command );
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 76
;76:		break;
LABELV $79
line 78
;77:	}
;78:	return -1;
CNSTI4 -1
RETI4
LABELV $77
endproc vmMain 16 12
data
align 4
LABELV cvarTable
address cg_ignore
address $92
address $93
byte 4 0
address cg_autoswitch
address $94
address $95
byte 4 1
address cg_drawGun
address $96
address $95
byte 4 1
address cg_zoomFov
address $97
address $98
byte 4 1
address cg_fov
address $99
address $100
byte 4 1
address cg_viewsize
address $101
address $102
byte 4 1
address cg_shadows
address $103
address $95
byte 4 1
address cg_gibs
address $104
address $95
byte 4 1
address cg_draw2D
address $105
address $95
byte 4 1
address cg_drawStatus
address $106
address $95
byte 4 1
address cg_drawTimer
address $107
address $93
byte 4 1
address cg_drawFPS
address $108
address $93
byte 4 1
address cg_drawSnapshot
address $109
address $93
byte 4 1
address cg_draw3dIcons
address $110
address $95
byte 4 1
address cg_drawIcons
address $111
address $95
byte 4 1
address cg_drawAmmoWarning
address $112
address $95
byte 4 1
address cg_drawAttacker
address $113
address $95
byte 4 1
address cg_drawSpeed
address $114
address $93
byte 4 1
address cg_drawCrosshair
address $115
address $116
byte 4 1
address cg_drawCrosshairNames
address $117
address $95
byte 4 1
address cg_drawRewards
address $118
address $95
byte 4 1
address cg_drawWeaponSelect
address $119
address $95
byte 4 1
address cg_crosshairSize
address $120
address $121
byte 4 1
address cg_crosshairHealth
address $122
address $95
byte 4 1
address cg_crosshairX
address $123
address $93
byte 4 1
address cg_crosshairY
address $124
address $93
byte 4 1
address cg_brassTime
address $125
address $126
byte 4 1
address cg_simpleItems
address $127
address $93
byte 4 1
address cg_addMarks
address $128
address $95
byte 4 1
address cg_lagometer
address $129
address $95
byte 4 1
address cg_drawPing
address $130
address $95
byte 4 1
address cg_railTrailTime
address $131
address $132
byte 4 1
address cg_railTrailRadius
address $133
address $93
byte 4 1
address cg_gun_x
address $134
address $93
byte 4 1
address cg_gun_y
address $135
address $93
byte 4 1
address cg_gun_z
address $136
address $93
byte 4 1
address cg_centertime
address $137
address $138
byte 4 512
address cg_runpitch
address $139
address $140
byte 4 1
address cg_runroll
address $141
address $142
byte 4 1
address cg_bobup
address $143
address $142
byte 4 1
address cg_bobpitch
address $144
address $140
byte 4 1
address cg_bobroll
address $145
address $140
byte 4 1
address cg_swingSpeed
address $146
address $147
byte 4 512
address cg_animSpeed
address $148
address $95
byte 4 512
address cg_debugAnim
address $149
address $93
byte 4 512
address cg_debugPosition
address $150
address $93
byte 4 512
address cg_debugEvents
address $151
address $93
byte 4 512
address cg_errorDecay
address $152
address $102
byte 4 0
address cg_nopredict
address $153
address $93
byte 4 0
address cg_noPlayerAnims
address $154
address $93
byte 4 512
address cg_showmiss
address $155
address $93
byte 4 0
address cg_footsteps
address $156
address $95
byte 4 512
address cg_tracerChance
address $157
address $158
byte 4 512
address cg_tracerWidth
address $159
address $95
byte 4 512
address cg_tracerLength
address $160
address $102
byte 4 512
address cg_thirdPersonRange
address $161
address $162
byte 4 512
address cg_thirdPersonAngle
address $163
address $93
byte 4 512
address cg_thirdPerson
address $164
address $93
byte 4 0
address cg_teamChatTime
address $165
address $166
byte 4 1
address cg_teamChatHeight
address $167
address $93
byte 4 1
address cg_forceModel
address $168
address $93
byte 4 1
address cg_predictItems
address $169
address $95
byte 4 1
address cg_deferPlayers
address $170
address $95
byte 4 1
address cg_drawTeamOverlay
address $171
address $93
byte 4 1
address cg_teamOverlayUserinfo
address $172
address $93
byte 4 66
address cg_stats
address $173
address $93
byte 4 0
address cg_drawFriend
address $174
address $95
byte 4 1
address cg_teamChatsOnly
address $175
address $93
byte 4 1
address cg_noVoiceChats
address $176
address $93
byte 4 1
address cg_noVoiceText
address $177
address $93
byte 4 1
address cg_buildScript
address $178
address $93
byte 4 0
address cg_paused
address $179
address $93
byte 4 64
address cg_blood
address $180
address $95
byte 4 1
address cg_currentSelectedPlayer
address $181
address $93
byte 4 1
address cg_hudFiles
address $182
address $183
byte 4 1
address cg_cameraOrbit
address $184
address $93
byte 4 512
address cg_cameraOrbitDelay
address $185
address $186
byte 4 1
address cg_timescaleFadeEnd
address $187
address $95
byte 4 0
address cg_timescaleFadeSpeed
address $188
address $93
byte 4 0
address cg_timescale
address $189
address $95
byte 4 0
address cg_scorePlum
address $190
address $95
byte 4 3
address cg_smoothClients
address $191
address $93
byte 4 3
address cg_cameraMode
address $192
address $93
byte 4 512
address cg_noTaunt
address $193
address $93
byte 4 1
address cg_noProjectileTrail
address $194
address $93
byte 4 1
address cg_smallFont
address $195
address $196
byte 4 1
address cg_bigFont
address $197
address $158
byte 4 1
address cg_oldRail
address $198
address $95
byte 4 1
address cg_oldRocket
address $199
address $95
byte 4 1
address cg_oldPlasma
address $200
address $95
byte 4 1
address cg_trueLightning
address $201
address $202
byte 4 1
address cg_hitSounds
address $203
address $93
byte 4 1
address cg_enemyModel
address $204
address $205
byte 4 1
address cg_enemyColors
address $206
address $205
byte 4 1
address cg_teamModel
address $207
address $205
byte 4 1
address cg_teamColors
address $208
address $205
byte 4 1
address cg_deadBodyDarken
address $209
address $95
byte 4 1
address cg_fovAdjust
address $210
address $93
byte 4 1
address cg_followKiller
address $211
address $93
byte 4 1
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 351
;79:}
;80:
;81:
;82:cg_t				cg;
;83:cgs_t				cgs;
;84:centity_t			cg_entities[MAX_GENTITIES];
;85:weaponInfo_t		cg_weapons[MAX_WEAPONS];
;86:itemInfo_t			cg_items[MAX_ITEMS];
;87:
;88:
;89:vmCvar_t	cg_railTrailTime;
;90:vmCvar_t	cg_railTrailRadius;
;91:vmCvar_t	cg_centertime;
;92:vmCvar_t	cg_runpitch;
;93:vmCvar_t	cg_runroll;
;94:vmCvar_t	cg_bobup;
;95:vmCvar_t	cg_bobpitch;
;96:vmCvar_t	cg_bobroll;
;97:vmCvar_t	cg_swingSpeed;
;98:vmCvar_t	cg_shadows;
;99:vmCvar_t	cg_gibs;
;100:vmCvar_t	cg_drawTimer;
;101:vmCvar_t	cg_drawFPS;
;102:vmCvar_t	cg_drawSnapshot;
;103:vmCvar_t	cg_draw3dIcons;
;104:vmCvar_t	cg_drawIcons;
;105:vmCvar_t	cg_drawAmmoWarning;
;106:vmCvar_t	cg_drawCrosshair;
;107:vmCvar_t	cg_drawCrosshairNames;
;108:vmCvar_t	cg_drawRewards;
;109:vmCvar_t	cg_drawWeaponSelect;
;110:vmCvar_t	cg_crosshairSize;
;111:vmCvar_t	cg_crosshairX;
;112:vmCvar_t	cg_crosshairY;
;113:vmCvar_t	cg_crosshairHealth;
;114:vmCvar_t	cg_draw2D;
;115:vmCvar_t	cg_drawStatus;
;116:vmCvar_t	cg_animSpeed;
;117:vmCvar_t	cg_debugAnim;
;118:vmCvar_t	cg_debugPosition;
;119:vmCvar_t	cg_debugEvents;
;120:vmCvar_t	cg_errorDecay;
;121:vmCvar_t	cg_nopredict;
;122:vmCvar_t	cg_noPlayerAnims;
;123:vmCvar_t	cg_showmiss;
;124:vmCvar_t	cg_footsteps;
;125:vmCvar_t	cg_addMarks;
;126:vmCvar_t	cg_brassTime;
;127:vmCvar_t	cg_viewsize;
;128:vmCvar_t	cg_drawGun;
;129:vmCvar_t	cg_gun_frame;
;130:vmCvar_t	cg_gun_x;
;131:vmCvar_t	cg_gun_y;
;132:vmCvar_t	cg_gun_z;
;133:vmCvar_t	cg_tracerChance;
;134:vmCvar_t	cg_tracerWidth;
;135:vmCvar_t	cg_tracerLength;
;136:vmCvar_t	cg_autoswitch;
;137:vmCvar_t	cg_ignore;
;138:vmCvar_t	cg_simpleItems;
;139:vmCvar_t	cg_fov;
;140:vmCvar_t	cg_zoomFov;
;141:vmCvar_t	cg_thirdPerson;
;142:vmCvar_t	cg_thirdPersonRange;
;143:vmCvar_t	cg_thirdPersonAngle;
;144:vmCvar_t	cg_lagometer;
;145:vmCvar_t	cg_drawPing;
;146:vmCvar_t	cg_drawAttacker;
;147:vmCvar_t	cg_drawSpeed;
;148:vmCvar_t 	cg_teamChatTime;
;149:vmCvar_t 	cg_teamChatHeight;
;150:vmCvar_t 	cg_stats;
;151:vmCvar_t 	cg_buildScript;
;152:vmCvar_t 	cg_forceModel;
;153:vmCvar_t	cg_paused;
;154:vmCvar_t	cg_blood;
;155:vmCvar_t	cg_predictItems;
;156:vmCvar_t	cg_deferPlayers;
;157:vmCvar_t	cg_drawTeamOverlay;
;158:vmCvar_t	cg_teamOverlayUserinfo;
;159:vmCvar_t	cg_drawFriend;
;160:vmCvar_t	cg_teamChatsOnly;
;161:#if defined MISSIONPACK || defined NEOHUD
;162:vmCvar_t	cg_noVoiceChats;
;163:vmCvar_t	cg_noVoiceText;
;164:#endif
;165:vmCvar_t	cg_hudFiles;
;166:vmCvar_t 	cg_scorePlum;
;167:vmCvar_t 	cg_smoothClients;
;168:vmCvar_t	cg_cameraMode;
;169:vmCvar_t	cg_cameraOrbit;
;170:vmCvar_t	cg_cameraOrbitDelay;
;171:vmCvar_t	cg_timescaleFadeEnd;
;172:vmCvar_t	cg_timescaleFadeSpeed;
;173:vmCvar_t	cg_timescale;
;174:vmCvar_t	cg_smallFont;
;175:vmCvar_t	cg_bigFont;
;176:vmCvar_t	cg_noTaunt;
;177:vmCvar_t	cg_noProjectileTrail;
;178:vmCvar_t	cg_oldRail;
;179:vmCvar_t	cg_oldRocket;
;180:vmCvar_t	cg_oldPlasma;
;181:vmCvar_t	cg_trueLightning;
;182:
;183:#if defined MISSIONPACK || defined NEOHUD
;184:vmCvar_t	cg_currentSelectedPlayer;
;185:#endif
;186:#ifdef MISSIONPACK
;187:vmCvar_t 	cg_redTeamName;
;188:vmCvar_t 	cg_blueTeamName;
;189:
;190:vmCvar_t	cg_currentSelectedPlayerName;
;191:vmCvar_t	cg_singlePlayer;
;192:vmCvar_t	cg_enableDust;
;193:vmCvar_t	cg_enableBreath;
;194:vmCvar_t	cg_singlePlayerActive;
;195:vmCvar_t	cg_recordSPDemo;
;196:vmCvar_t	cg_recordSPDemoName;
;197:vmCvar_t	cg_obeliskRespawnDelay;
;198:#endif
;199:
;200:vmCvar_t	cg_hitSounds;
;201:
;202:vmCvar_t	cg_enemyModel;
;203:vmCvar_t	cg_enemyColors;
;204:vmCvar_t	cg_teamModel;
;205:vmCvar_t	cg_teamColors;
;206:
;207:vmCvar_t	cg_deadBodyDarken;
;208:vmCvar_t	cg_fovAdjust;
;209:vmCvar_t	cg_followKiller;
;210:
;211:typedef struct {
;212:	vmCvar_t	*vmCvar;
;213:	const char	*cvarName;
;214:	const char	*defaultString;
;215:	const int	cvarFlags;
;216:} cvarTable_t;
;217:
;218:static const cvarTable_t cvarTable[] = {
;219:	{ &cg_ignore, "cg_ignore", "0", 0 }, // used for debugging
;220:	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE },
;221:	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE },
;222:	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE },
;223:	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE },
;224:	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE },
;225:	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE },
;226:	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE },
;227:	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE },
;228:	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE },
;229:	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE },
;230:	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE },
;231:	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE },
;232:	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE },
;233:	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE },
;234:	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE },
;235:	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE },
;236:	{ &cg_drawSpeed, "cg_drawSpeed", "0", CVAR_ARCHIVE },
;237:	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;238:	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;239:	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE },
;240:	{ &cg_drawWeaponSelect, "cg_drawWeaponSelect", "1", CVAR_ARCHIVE },
;241:	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE },
;242:	{ &cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE },
;243:	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE },
;244:	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE },
;245:	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;246:	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE },
;247:	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE },
;248:	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE },
;249:#ifdef NEOHUD
;250:	{ &cg_drawPing, "cg_drawPing", "1", CVAR_ARCHIVE },
;251:#endif
;252:	{ &cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE },
;253:	{ &cg_railTrailRadius, "cg_railTrailRadius", "0", CVAR_ARCHIVE },
;254:	{ &cg_gun_x, "cg_gunX", "0", CVAR_ARCHIVE },
;255:	{ &cg_gun_y, "cg_gunY", "0", CVAR_ARCHIVE },
;256:	{ &cg_gun_z, "cg_gunZ", "0", CVAR_ARCHIVE },
;257:	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT },
;258:	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
;259:	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE },
;260:	{ &cg_bobup , "cg_bobup", "0.005", CVAR_ARCHIVE },
;261:	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE },
;262:	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE },
;263:	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT },
;264:	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT },
;265:	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT },
;266:	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT },
;267:	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT },
;268:	{ &cg_errorDecay, "cg_errordecay", "100", 0 },
;269:	{ &cg_nopredict, "cg_nopredict", "0", 0 },
;270:	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT },
;271:	{ &cg_showmiss, "cg_showmiss", "0", 0 },
;272:	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT },
;273:	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT },
;274:	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT },
;275:	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT },
;276:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT },
;277:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT },
;278:	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0 },
;279:	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE },
;280:	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE },
;281:	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE },
;282:	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE },
;283:#ifdef MISSIONPACK
;284:	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE },
;285:#else
;286:	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE },
;287:#endif
;288:	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE },
;289:	{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO },
;290:	{ &cg_stats, "cg_stats", "0", 0 },
;291:	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE },
;292:	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE },
;293:#if defined MISSIONPACK || defined NEOHUD
;294:	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE },
;295:	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE },
;296:#endif
;297:	// the following variables are created in other parts of the system,
;298:	// but we also reference them here
;299:	{ &cg_buildScript, "com_buildScript", "0", 0 },	// force loading of all possible data amd error on failures
;300:	{ &cg_paused, "cl_paused", "0", CVAR_ROM },
;301:	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE },
;302:#if defined MISSIONPACK || defined NEOHUD
;303:	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
;304:	{ &cg_hudFiles, "cg_hudFiles", DEFAULT_HUD, CVAR_ARCHIVE },
;305:#endif
;306:#ifdef MISSIONPACK
;307:	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;308:	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;309:	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
;310:	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;311:	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
;312:	{ &cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO},
;313:	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;314:	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;315:	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
;316:	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
;317:	{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
;318:#endif
;319:	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
;320:	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
;321:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
;322:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
;323:	{ &cg_timescale, "timescale", "1", 0},
;324:	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
;325:	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
;326:	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},
;327:	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
;328:	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
;329:	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;330:	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;331:	{ &cg_oldRail, "cg_oldRail", "1", CVAR_ARCHIVE},
;332:	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
;333:	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
;334:	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE},
;335:	{ &cg_hitSounds, "cg_hitSounds", "0", CVAR_ARCHIVE},
;336:	{ &cg_enemyModel, "cg_enemyModel", "", CVAR_ARCHIVE},
;337:	{ &cg_enemyColors, "cg_enemyColors", "", CVAR_ARCHIVE},
;338:	{ &cg_teamModel, "cg_teamModel", "", CVAR_ARCHIVE},
;339:	{ &cg_teamColors, "cg_teamColors", "", CVAR_ARCHIVE},
;340:	{ &cg_deadBodyDarken, "cg_deadBodyDarken", "1", CVAR_ARCHIVE},
;341:	{ &cg_fovAdjust, "cg_fovAdjust", "0", CVAR_ARCHIVE},
;342:	{ &cg_followKiller, "cg_followKiller", "0", CVAR_ARCHIVE}
;343:};
;344:
;345:
;346:/*
;347:=================
;348:CG_RegisterCvars
;349:=================
;350:*/
;351:void CG_RegisterCvars( void ) {
line 356
;352:	int			i;
;353:	const cvarTable_t	*cv;
;354:	char		var[MAX_TOKEN_CHARS];
;355:
;356:	for ( i = 0, cv = cvarTable ; i < ARRAY_LEN( cvarTable ) ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $216
JUMPV
LABELV $213
line 357
;357:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
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
line 359
;358:			cv->defaultString, cv->cvarFlags );
;359:	}
LABELV $214
line 356
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
LABELV $216
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 99
LTU4 $213
line 362
;360:
;361:	// see if we are also running the server on this machine
;362:	trap_Cvar_VariableStringBuffer( "sv_running", var, sizeof( var ) );
ADDRGP4 $217
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 363
;363:	cgs.localServer = atoi( var );
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31476
ADDRLP4 1032
INDIRI4
ASGNI4
line 365
;364:
;365:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 366
;366:	enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 367
;367:	enemyColorsModificationCount = cg_enemyColors.modificationCount;
ADDRGP4 enemyColorsModificationCount
ADDRGP4 cg_enemyColors+4
INDIRI4
ASGNI4
line 368
;368:	teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 369
;369:	teamColorsModificationCount = cg_teamColors.modificationCount;
ADDRGP4 teamColorsModificationCount
ADDRGP4 cg_teamColors+4
INDIRI4
ASGNI4
line 372
;370:
;371:
;372:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $224
ARGP4
ADDRGP4 $225
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 373
;373:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $226
ARGP4
ADDRGP4 $225
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 376
;374:	//trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
;375:	//trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
;376:}
LABELV $212
endproc CG_RegisterCvars 1036 16
export CG_ForceModelChange
proc CG_ForceModelChange 12 4
line 384
;377:
;378:
;379:/*																																			
;380:===================
;381:CG_ForceModelChange
;382:===================
;383:*/
;384:void CG_ForceModelChange( void ) {
line 388
;385:	const char *clientInfo;
;386:	int i;
;387:
;388:	for ( i = 0 ; i < MAX_CLIENTS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $228
line 389
;389:		clientInfo = CG_ConfigString( CS_PLAYERS + i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 390
;390:		if ( !clientInfo[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $232
line 391
;391:			continue;
ADDRGP4 $229
JUMPV
LABELV $232
line 393
;392:		}
;393:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 394
;394:	}
LABELV $229
line 388
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $228
line 395
;395:}
LABELV $227
endproc CG_ForceModelChange 12 4
export CG_UpdateCvars
proc CG_UpdateCvars 8 8
line 403
;396:
;397:
;398:/*
;399:=================
;400:CG_UpdateCvars
;401:=================
;402:*/
;403:void CG_UpdateCvars( void ) {
line 407
;404:	int			i;
;405:	const cvarTable_t	*cv;
;406:
;407:	for ( i = 0, cv = cvarTable ; i < ARRAY_LEN( cvarTable ) ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $238
JUMPV
LABELV $235
line 408
;408:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 409
;409:	}
LABELV $236
line 407
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
LABELV $238
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 99
LTU4 $235
line 415
;410:
;411:	// check for modications here
;412:
;413:	// If team overlay is on, ask for updates from the server.  If its off,
;414:	// let the server know so we don't receive it
;415:	if ( drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount ) {
ADDRGP4 drawTeamOverlayModificationCount
INDIRI4
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
EQI4 $239
line 416
;416:		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
ADDRGP4 drawTeamOverlayModificationCount
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
ASGNI4
line 425
;417:#if 0
;418:		if ( cg_drawTeamOverlay.integer > 0 ) {
;419:			trap_Cvar_Set( "teamoverlay", "1" );
;420:		} else {
;421:			trap_Cvar_Set( "teamoverlay", "0" );
;422:		}
;423:#endif
;424:		// FIXME E3 HACK
;425:		trap_Cvar_Set( "teamoverlay", "1" );
ADDRGP4 $172
ARGP4
ADDRGP4 $95
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 426
;426:	}
LABELV $239
line 429
;427:
;428:	// if model changed
;429:	if ( forceModelModificationCount != cg_forceModel.modificationCount 
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
NEI4 $253
ADDRGP4 enemyModelModificationCount
INDIRI4
ADDRGP4 cg_enemyModel+4
INDIRI4
NEI4 $253
ADDRGP4 enemyColorsModificationCount
INDIRI4
ADDRGP4 cg_enemyColors+4
INDIRI4
NEI4 $253
ADDRGP4 teamModelModificationCount
INDIRI4
ADDRGP4 cg_teamModel+4
INDIRI4
NEI4 $253
ADDRGP4 teamColorsModificationCount
INDIRI4
ADDRGP4 cg_teamColors+4
INDIRI4
EQI4 $243
LABELV $253
line 433
;430:		|| enemyModelModificationCount != cg_enemyModel.modificationCount
;431:		|| enemyColorsModificationCount != cg_enemyColors.modificationCount
;432:		|| teamModelModificationCount != cg_teamModel.modificationCount
;433:		|| teamColorsModificationCount != cg_teamColors.modificationCount ) {
line 435
;434:
;435:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 436
;436:		enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 437
;437:		enemyColorsModificationCount = cg_enemyColors.modificationCount;
ADDRGP4 enemyColorsModificationCount
ADDRGP4 cg_enemyColors+4
INDIRI4
ASGNI4
line 438
;438:		teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 439
;439:		teamColorsModificationCount = cg_teamColors.modificationCount;
ADDRGP4 teamColorsModificationCount
ADDRGP4 cg_teamColors+4
INDIRI4
ASGNI4
line 441
;440:
;441:		CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 442
;442:	}
LABELV $243
line 443
;443:}
LABELV $234
endproc CG_UpdateCvars 8 8
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 446
;444:
;445:
;446:int CG_CrosshairPlayer( void ) {
line 447
;447:	if ( cg.time > ( cg.crosshairClientTime + 1000 ) ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+117556
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $260
line 448
;448:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $259
JUMPV
LABELV $260
line 450
;449:	}
;450:	return cg.crosshairClientNum;
ADDRGP4 cg+117552
INDIRI4
RETI4
LABELV $259
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 453
;451:}
;452:
;453:int CG_LastAttacker( void ) {
line 454
;454:	if ( !cg.attackerTime ) {
ADDRGP4 cg+117604
INDIRI4
CNSTI4 0
NEI4 $266
line 455
;455:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $265
JUMPV
LABELV $266
line 457
;456:	}
;457:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $265
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 12
line 460
;458:}
;459:
;460:void QDECL CG_Printf( const char *msg, ... ) {
line 464
;461:	va_list		argptr;
;462:	char		text[1024];
;463:
;464:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 465
;465:	ED_vsprintf (text, msg, argptr);
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
line 466
;466:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 468
;467:
;468:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 469
;469:}
LABELV $270
endproc CG_Printf 1028 12
export CG_Error
proc CG_Error 1028 12
line 471
;470:
;471:void QDECL CG_Error( const char *msg, ... ) {
line 475
;472:	va_list		argptr;
;473:	char		text[1024];
;474:
;475:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 476
;476:	ED_vsprintf (text, msg, argptr);
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
line 477
;477:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 479
;478:
;479:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 480
;480:}
LABELV $272
endproc CG_Error 1028 12
export Com_Error
proc Com_Error 1028 12
line 485
;481:
;482:#ifndef CGAME_HARD_LINKED
;483:// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)
;484:
;485:void QDECL Com_Error( int level, const char *error, ... ) {
line 489
;486:	va_list		argptr;
;487:	char		text[1024];
;488:
;489:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 490
;490:	ED_vsprintf (text, error, argptr);
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
line 491
;491:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 493
;492:
;493:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 494
;494:}
LABELV $274
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 496
;495:
;496:void QDECL Com_Printf( const char *msg, ... ) {
line 500
;497:	va_list		argptr;
;498:	char		text[1024];
;499:
;500:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 501
;501:	ED_vsprintf (text, msg, argptr);
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
line 502
;502:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 504
;503:
;504:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 505
;505:}
LABELV $276
endproc Com_Printf 1028 12
bss
align 1
LABELV $279
skip 2048
data
align 4
LABELV $280
byte 4 0
export CG_Argv
code
proc CG_Argv 4 12
line 515
;506:
;507:#endif
;508:
;509:/*
;510:================
;511:CG_Argv
;512:================
;513:*/
;514:const char *CG_Argv( int arg ) 
;515:{
line 519
;516:	static char	buffer[ 2 ][ MAX_STRING_CHARS ];
;517:	static int index = 0;
;518:
;519:	index ^= 1;
ADDRLP4 0
ADDRGP4 $280
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 520
;520:	trap_Argv( arg, buffer[ index ], sizeof( buffer[ 0 ] ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $280
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $279
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 522
;521:
;522:	return buffer[ index ];
ADDRGP4 $280
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $279
ADDP4
RETP4
LABELV $278
endproc CG_Argv 4 12
proc CG_RegisterItemSounds 96 12
line 535
;523:}
;524:
;525:
;526://========================================================================
;527:
;528:/*
;529:=================
;530:CG_RegisterItemSounds
;531:
;532:The server says this item is used on this level
;533:=================
;534:*/
;535:static void CG_RegisterItemSounds( int itemNum ) {
line 541
;536:	gitem_t			*item;
;537:	char			data[MAX_QPATH];
;538:	const char		*s, *start;
;539:	int				len;
;540:
;541:	item = &bg_itemlist[ itemNum ];
ADDRLP4 76
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 543
;542:
;543:	if( item->pickup_sound ) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
line 544
;544:		trap_S_RegisterSound( item->pickup_sound, qfalse );
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 545
;545:	}
LABELV $282
line 548
;546:
;547:	// parse the space separated precache string for other media
;548:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 549
;549:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $286
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $288
LABELV $286
line 550
;550:		return;
ADDRGP4 $281
JUMPV
LABELV $287
line 552
;551:
;552:	while (*s) {
line 553
;553:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $291
JUMPV
LABELV $290
line 554
;554:		while (*s && *s != ' ') {
line 555
;555:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 556
;556:		}
LABELV $291
line 554
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $293
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $290
LABELV $293
line 558
;557:
;558:		len = s-start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 559
;559:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $296
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $294
LABELV $296
line 560
;560:			CG_Error( "PrecacheItem: %s has bad precache string", 
ADDRGP4 $297
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 562
;561:				item->classname);
;562:			return;
ADDRGP4 $281
JUMPV
LABELV $294
line 564
;563:		}
;564:		memcpy (data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 565
;565:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 566
;566:		if ( *s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $298
line 567
;567:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 568
;568:		}
LABELV $298
line 570
;569:
;570:		if ( !strcmp(data+len-3, "wav" )) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $300
line 571
;571:			trap_S_RegisterSound( data, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 572
;572:		}
LABELV $300
line 573
;573:	}
LABELV $288
line 552
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $287
line 574
;574:}
LABELV $281
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 560 16
line 584
;575:
;576:
;577:/*
;578:=================
;579:CG_RegisterSounds
;580:
;581:called during a precache command
;582:=================
;583:*/
;584:static void CG_RegisterSounds( void ) {
line 595
;585:	int		i;
;586:	char	items[MAX_ITEMS+1];
;587:	char	name[MAX_QPATH];
;588:	const char	*soundName;
;589:
;590:	// voice commands
;591:#ifdef MISSIONPACK
;592:	CG_LoadVoiceChats();
;593:#endif
;594:
;595:	cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
ADDRGP4 $307
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+748
ADDRLP4 332
INDIRI4
ASGNI4
line 596
;596:	cgs.media.fiveMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
ADDRGP4 $310
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+752
ADDRLP4 336
INDIRI4
ASGNI4
line 597
;597:	cgs.media.suddenDeathSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
ADDRGP4 $313
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+756
ADDRLP4 340
INDIRI4
ASGNI4
line 598
;598:	cgs.media.oneFragSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
ADDRGP4 $316
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+768
ADDRLP4 344
INDIRI4
ASGNI4
line 599
;599:	cgs.media.twoFragSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
ADDRGP4 $319
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+764
ADDRLP4 348
INDIRI4
ASGNI4
line 600
;600:	cgs.media.threeFragSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
ADDRGP4 $322
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+760
ADDRLP4 352
INDIRI4
ASGNI4
line 601
;601:	cgs.media.count3Sound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
ADDRGP4 $325
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+936
ADDRLP4 356
INDIRI4
ASGNI4
line 602
;602:	cgs.media.count2Sound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
ADDRGP4 $328
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+940
ADDRLP4 360
INDIRI4
ASGNI4
line 603
;603:	cgs.media.count1Sound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
ADDRGP4 $331
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+944
ADDRLP4 364
INDIRI4
ASGNI4
line 604
;604:	cgs.media.countFightSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
ADDRGP4 $334
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+948
ADDRLP4 368
INDIRI4
ASGNI4
line 605
;605:	cgs.media.countPrepareSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );
ADDRGP4 $337
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+952
ADDRLP4 372
INDIRI4
ASGNI4
line 610
;606:#ifdef MISSIONPACK
;607:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound( "sound/feedback/prepare_team.wav", qtrue );
;608:#endif
;609:
;610:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $342
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $338
LABELV $342
line 612
;611:
;612:		cgs.media.captureAwardSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $345
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+852
ADDRLP4 376
INDIRI4
ASGNI4
line 613
;613:		cgs.media.redLeadsSound = trap_S_RegisterSound( "sound/feedback/redleads.wav", qtrue );
ADDRGP4 $348
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+864
ADDRLP4 380
INDIRI4
ASGNI4
line 614
;614:		cgs.media.blueLeadsSound = trap_S_RegisterSound( "sound/feedback/blueleads.wav", qtrue );
ADDRGP4 $351
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+868
ADDRLP4 384
INDIRI4
ASGNI4
line 615
;615:		cgs.media.teamsTiedSound = trap_S_RegisterSound( "sound/feedback/teamstied.wav", qtrue );
ADDRGP4 $354
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+872
ADDRLP4 388
INDIRI4
ASGNI4
line 616
;616:		cgs.media.hitTeamSound = trap_S_RegisterSound( "sound/feedback/hit_teammate.wav", qtrue );
ADDRGP4 $357
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+792
ADDRLP4 392
INDIRI4
ASGNI4
line 618
;617:
;618:		cgs.media.redScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_red_scores.wav", qtrue );
ADDRGP4 $360
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+856
ADDRLP4 396
INDIRI4
ASGNI4
line 619
;619:		cgs.media.blueScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_scores.wav", qtrue );
ADDRGP4 $363
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+860
ADDRLP4 400
INDIRI4
ASGNI4
line 621
;620:
;621:		cgs.media.captureYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $345
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+876
ADDRLP4 404
INDIRI4
ASGNI4
line 622
;622:		cgs.media.captureOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_opponent.wav", qtrue );
ADDRGP4 $368
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+880
ADDRLP4 408
INDIRI4
ASGNI4
line 624
;623:
;624:		cgs.media.returnYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_yourteam.wav", qtrue );
ADDRGP4 $371
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+884
ADDRLP4 412
INDIRI4
ASGNI4
line 625
;625:		cgs.media.returnOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $374
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+888
ADDRLP4 416
INDIRI4
ASGNI4
line 627
;626:
;627:		cgs.media.takenYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_yourteam.wav", qtrue );
ADDRGP4 $377
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+892
ADDRLP4 420
INDIRI4
ASGNI4
line 628
;628:		cgs.media.takenOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_opponent.wav", qtrue );
ADDRGP4 $380
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+896
ADDRLP4 424
INDIRI4
ASGNI4
line 630
;629:
;630:		if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $385
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $381
LABELV $385
line 631
;631:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_red_returned.wav", qtrue );
ADDRGP4 $388
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+900
ADDRLP4 428
INDIRI4
ASGNI4
line 632
;632:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_returned.wav", qtrue );
ADDRGP4 $391
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+904
ADDRLP4 432
INDIRI4
ASGNI4
line 633
;633:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_flag.wav", qtrue );
ADDRGP4 $394
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+908
ADDRLP4 436
INDIRI4
ASGNI4
line 634
;634:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_flag.wav", qtrue );
ADDRGP4 $397
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+916
ADDRLP4 440
INDIRI4
ASGNI4
line 635
;635:		}
LABELV $381
line 655
;636:
;637:#ifdef MISSIONPACK
;638:		if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;639:			// FIXME: get a replacement for this sound ?
;640:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
;641:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
;642:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
;643:		}
;644:
;645:		if ( cgs.gametype == GT_1FCTF || cgs.gametype == GT_CTF || cg_buildScript.integer ) {
;646:			cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
;647:			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
;648:		}
;649:
;650:		if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;651:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound( "sound/teamplay/voc_base_attack.wav", qtrue );
;652:		}
;653:		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
;654:#else
;655:		cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
ADDRGP4 $400
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+924
ADDRLP4 428
INDIRI4
ASGNI4
line 656
;656:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $403
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+932
ADDRLP4 432
INDIRI4
ASGNI4
line 657
;657:		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
ADDRGP4 $406
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+920
ADDRLP4 436
INDIRI4
ASGNI4
line 658
;658:		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
ADDRGP4 $409
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+912
ADDRLP4 440
INDIRI4
ASGNI4
line 660
;659:#endif
;660:	}
LABELV $338
line 662
;661:
;662:	cgs.media.tracerSound = trap_S_RegisterSound( "sound/weapons/machinegun/buletby1.wav", qfalse );
ADDRGP4 $412
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+540
ADDRLP4 376
INDIRI4
ASGNI4
line 663
;663:	cgs.media.selectSound = trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
ADDRGP4 $415
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+544
ADDRLP4 380
INDIRI4
ASGNI4
line 664
;664:	cgs.media.wearOffSound = trap_S_RegisterSound( "sound/items/wearoff.wav", qfalse );
ADDRGP4 $418
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+552
ADDRLP4 384
INDIRI4
ASGNI4
line 665
;665:	cgs.media.useNothingSound = trap_S_RegisterSound( "sound/items/use_nothing.wav", qfalse );
ADDRGP4 $421
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+548
ADDRLP4 388
INDIRI4
ASGNI4
line 666
;666:	cgs.media.gibSound = trap_S_RegisterSound( "sound/player/gibsplt1.wav", qfalse );
ADDRGP4 $424
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+704
ADDRLP4 392
INDIRI4
ASGNI4
line 667
;667:	cgs.media.gibBounce1Sound = trap_S_RegisterSound( "sound/player/gibimp1.wav", qfalse );
ADDRGP4 $427
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+708
ADDRLP4 396
INDIRI4
ASGNI4
line 668
;668:	cgs.media.gibBounce2Sound = trap_S_RegisterSound( "sound/player/gibimp2.wav", qfalse );
ADDRGP4 $430
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+712
ADDRLP4 400
INDIRI4
ASGNI4
line 669
;669:	cgs.media.gibBounce3Sound = trap_S_RegisterSound( "sound/player/gibimp3.wav", qfalse );
ADDRGP4 $433
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+716
ADDRLP4 404
INDIRI4
ASGNI4
line 688
;670:
;671:#ifdef MISSIONPACK
;672:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound( "sound/items/invul_activate.wav", qfalse );
;673:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound( "sound/items/invul_impact_01.wav", qfalse );
;674:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound( "sound/items/invul_impact_02.wav", qfalse );
;675:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound( "sound/items/invul_impact_03.wav", qfalse );
;676:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound( "sound/items/invul_juiced.wav", qfalse );
;677:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound( "sound/items/obelisk_hit_01.wav", qfalse );
;678:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound( "sound/items/obelisk_hit_02.wav", qfalse );
;679:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound( "sound/items/obelisk_hit_03.wav", qfalse );
;680:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound( "sound/items/obelisk_respawn.wav", qfalse );
;681:
;682:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
;683:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
;684:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
;685:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
;686:#endif
;687:
;688:	cgs.media.teleInSound = trap_S_RegisterSound( "sound/world/telein.wav", qfalse );
ADDRGP4 $436
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+720
ADDRLP4 408
INDIRI4
ASGNI4
line 689
;689:	cgs.media.teleOutSound = trap_S_RegisterSound( "sound/world/teleout.wav", qfalse );
ADDRGP4 $439
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+724
ADDRLP4 412
INDIRI4
ASGNI4
line 690
;690:	cgs.media.respawnSound = trap_S_RegisterSound( "sound/items/respawn1.wav", qfalse );
ADDRGP4 $442
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+732
ADDRLP4 416
INDIRI4
ASGNI4
line 692
;691:
;692:	cgs.media.noAmmoSound = trap_S_RegisterSound( "sound/weapons/noammo.wav", qfalse );
ADDRGP4 $445
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+728
ADDRLP4 420
INDIRI4
ASGNI4
line 694
;693:
;694:	cgs.media.talkSound = trap_S_RegisterSound( "sound/player/talk.wav", qfalse );
ADDRGP4 $448
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+736
ADDRLP4 424
INDIRI4
ASGNI4
line 695
;695:	cgs.media.landSound = trap_S_RegisterSound( "sound/player/land1.wav", qfalse);
ADDRGP4 $451
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+740
ADDRLP4 428
INDIRI4
ASGNI4
line 697
;696:
;697:	cgs.media.hitSounds[0] = trap_S_RegisterSound( "sound/feedback/hit25.wav", qfalse );
ADDRGP4 $454
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+776
ADDRLP4 432
INDIRI4
ASGNI4
line 698
;698:	cgs.media.hitSounds[1] = trap_S_RegisterSound( "sound/feedback/hit50.wav", qfalse );
ADDRGP4 $458
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+776+4
ADDRLP4 436
INDIRI4
ASGNI4
line 699
;699:	cgs.media.hitSounds[2] = trap_S_RegisterSound( "sound/feedback/hit75.wav", qfalse );
ADDRGP4 $462
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+776+8
ADDRLP4 440
INDIRI4
ASGNI4
line 700
;700:	cgs.media.hitSounds[3] = trap_S_RegisterSound( "sound/feedback/hit100.wav", qfalse );
ADDRGP4 $466
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+776+12
ADDRLP4 444
INDIRI4
ASGNI4
line 702
;701:
;702:	cgs.media.hitSound = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
ADDRGP4 $469
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+772
ADDRLP4 448
INDIRI4
ASGNI4
line 709
;703:
;704:#ifdef MISSIONPACK
;705:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound( "sound/feedback/hithi.wav", qfalse );
;706:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound( "sound/feedback/hitlo.wav", qfalse );
;707:#endif
;708:
;709:	cgs.media.impressiveSound = trap_S_RegisterSound( "sound/feedback/impressive.wav", qtrue );
ADDRGP4 $472
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+796
ADDRLP4 452
INDIRI4
ASGNI4
line 710
;710:	cgs.media.excellentSound = trap_S_RegisterSound( "sound/feedback/excellent.wav", qtrue );
ADDRGP4 $475
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+800
ADDRLP4 456
INDIRI4
ASGNI4
line 711
;711:	cgs.media.deniedSound = trap_S_RegisterSound( "sound/feedback/denied.wav", qtrue );
ADDRGP4 $478
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+804
ADDRLP4 460
INDIRI4
ASGNI4
line 712
;712:	cgs.media.humiliationSound = trap_S_RegisterSound( "sound/feedback/humiliation.wav", qtrue );
ADDRGP4 $481
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+808
ADDRLP4 464
INDIRI4
ASGNI4
line 713
;713:	cgs.media.assistSound = trap_S_RegisterSound( "sound/feedback/assist.wav", qtrue );
ADDRGP4 $484
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+812
ADDRLP4 468
INDIRI4
ASGNI4
line 714
;714:	cgs.media.defendSound = trap_S_RegisterSound( "sound/feedback/defense.wav", qtrue );
ADDRGP4 $487
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+816
ADDRLP4 472
INDIRI4
ASGNI4
line 721
;715:#ifdef MISSIONPACK
;716:	cgs.media.firstImpressiveSound = trap_S_RegisterSound( "sound/feedback/first_impressive.wav", qtrue );
;717:	cgs.media.firstExcellentSound = trap_S_RegisterSound( "sound/feedback/first_excellent.wav", qtrue );
;718:	cgs.media.firstHumiliationSound = trap_S_RegisterSound( "sound/feedback/first_gauntlet.wav", qtrue );
;719:#endif
;720:
;721:	cgs.media.takenLeadSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue);
ADDRGP4 $490
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+820
ADDRLP4 476
INDIRI4
ASGNI4
line 722
;722:	cgs.media.tiedLeadSound = trap_S_RegisterSound( "sound/feedback/tiedlead.wav", qtrue);
ADDRGP4 $493
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+824
ADDRLP4 480
INDIRI4
ASGNI4
line 723
;723:	cgs.media.lostLeadSound = trap_S_RegisterSound( "sound/feedback/lostlead.wav", qtrue);
ADDRGP4 $496
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+828
ADDRLP4 484
INDIRI4
ASGNI4
line 731
;724:
;725:#ifdef MISSIONPACK
;726:	cgs.media.voteNow = trap_S_RegisterSound( "sound/feedback/vote_now.wav", qtrue);
;727:	cgs.media.votePassed = trap_S_RegisterSound( "sound/feedback/vote_passed.wav", qtrue);
;728:	cgs.media.voteFailed = trap_S_RegisterSound( "sound/feedback/vote_failed.wav", qtrue);
;729:#endif
;730:
;731:	cgs.media.watrInSound = trap_S_RegisterSound( "sound/player/watr_in.wav", qfalse);
ADDRGP4 $499
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+832
ADDRLP4 488
INDIRI4
ASGNI4
line 732
;732:	cgs.media.watrOutSound = trap_S_RegisterSound( "sound/player/watr_out.wav", qfalse);
ADDRGP4 $502
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+836
ADDRLP4 492
INDIRI4
ASGNI4
line 733
;733:	cgs.media.watrUnSound = trap_S_RegisterSound( "sound/player/watr_un.wav", qfalse);
ADDRGP4 $505
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+840
ADDRLP4 496
INDIRI4
ASGNI4
line 735
;734:
;735:	cgs.media.jumpPadSound = trap_S_RegisterSound ("sound/world/jumppad.wav", qfalse );
ADDRGP4 $508
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+744
ADDRLP4 500
INDIRI4
ASGNI4
line 737
;736:
;737:	for (i=0 ; i<4 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $509
line 738
;738:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/step%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $513
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 739
;739:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556
ADDP4
ADDRLP4 504
INDIRI4
ASGNI4
line 741
;740:
;741:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/boot%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $516
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 742
;742:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+16
ADDP4
ADDRLP4 508
INDIRI4
ASGNI4
line 744
;743:
;744:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $520
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 745
;745:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+32
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 747
;746:
;747:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/mech%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $524
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 748
;748:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+48
ADDP4
ADDRLP4 516
INDIRI4
ASGNI4
line 750
;749:
;750:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/energy%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $528
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 751
;751:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+64
ADDP4
ADDRLP4 520
INDIRI4
ASGNI4
line 753
;752:
;753:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/splash%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $532
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 754
;754:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+96
ADDP4
ADDRLP4 524
INDIRI4
ASGNI4
line 756
;755:
;756:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/clank%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $536
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 757
;757:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+556+80
ADDP4
ADDRLP4 528
INDIRI4
ASGNI4
line 758
;758:	}
LABELV $510
line 737
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $509
line 761
;759:
;760:	// only register the items that the server says we need
;761:	Q_strncpyz(items, CG_ConfigString(CS_ITEMS), sizeof(items));
CNSTI4 27
ARGI4
ADDRLP4 504
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 504
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 763
;762:
;763:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $543
JUMPV
LABELV $540
line 765
;764://		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;765:			CG_RegisterItemSounds( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 767
;766://		}
;767:	}
LABELV $541
line 763
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $543
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $540
line 769
;768:
;769:	for ( i = 1 ; i < MAX_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $544
line 770
;770:		soundName = CG_ConfigString( CS_SOUNDS+i );
ADDRLP4 0
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 508
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 508
INDIRP4
ASGNP4
line 771
;771:		if ( !soundName[0] ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $548
line 772
;772:			break;
ADDRGP4 $546
JUMPV
LABELV $548
line 774
;773:		}
;774:		if ( soundName[0] == '*' ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $550
line 775
;775:			continue;	// custom sound
ADDRGP4 $545
JUMPV
LABELV $550
line 777
;776:		}
;777:		cgs.gameSounds[i] = trap_S_RegisterSound( soundName, qfalse );
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 778
;778:	}
LABELV $545
line 769
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $544
LABELV $546
line 781
;779:
;780:	// FIXME: only needed with item
;781:	cgs.media.flightSound = trap_S_RegisterSound( "sound/items/flight.wav", qfalse );
ADDRGP4 $555
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+844
ADDRLP4 508
INDIRI4
ASGNI4
line 782
;782:	cgs.media.medkitSound = trap_S_RegisterSound ("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $558
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+848
ADDRLP4 512
INDIRI4
ASGNI4
line 783
;783:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $561
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+536
ADDRLP4 516
INDIRI4
ASGNI4
line 784
;784:	cgs.media.sfx_ric1 = trap_S_RegisterSound ("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $564
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+680
ADDRLP4 520
INDIRI4
ASGNI4
line 785
;785:	cgs.media.sfx_ric2 = trap_S_RegisterSound ("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $567
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+684
ADDRLP4 524
INDIRI4
ASGNI4
line 786
;786:	cgs.media.sfx_ric3 = trap_S_RegisterSound ("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $570
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+688
ADDRLP4 528
INDIRI4
ASGNI4
line 788
;787:	//cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
;788:	cgs.media.sfx_rockexp = trap_S_RegisterSound ("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $573
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+696
ADDRLP4 532
INDIRI4
ASGNI4
line 789
;789:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound ("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $576
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+700
ADDRLP4 536
INDIRI4
ASGNI4
line 811
;790:#ifdef MISSIONPACK
;791:	cgs.media.sfx_proxexp = trap_S_RegisterSound( "sound/weapons/proxmine/wstbexpl.wav" , qfalse);
;792:	cgs.media.sfx_nghit = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpd.wav" , qfalse);
;793:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpl.wav" , qfalse);
;794:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpm.wav", qfalse );
;795:	cgs.media.sfx_chghit = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpd.wav", qfalse );
;796:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpl.wav", qfalse );
;797:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpm.wav", qfalse );
;798:	cgs.media.weaponHoverSound = trap_S_RegisterSound( "sound/weapons/weapon_hover.wav", qfalse );
;799:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound( "sound/items/kam_explode.wav", qfalse );
;800:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound( "sound/items/kam_implode.wav", qfalse );
;801:	cgs.media.kamikazeFarSound = trap_S_RegisterSound( "sound/items/kam_explode_far.wav", qfalse );
;802:	cgs.media.winnerSound = trap_S_RegisterSound( "sound/feedback/voc_youwin.wav", qfalse );
;803:	cgs.media.loserSound = trap_S_RegisterSound( "sound/feedback/voc_youlose.wav", qfalse );
;804:
;805:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
;806:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
;807:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
;808:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
;809:#endif
;810:
;811:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $579
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1008
ADDRLP4 540
INDIRI4
ASGNI4
line 812
;812:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $582
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 544
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1012
ADDRLP4 544
INDIRI4
ASGNI4
line 813
;813:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse );
ADDRGP4 $585
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 548
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1016
ADDRLP4 548
INDIRI4
ASGNI4
line 814
;814:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $588
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 552
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1020
ADDRLP4 552
INDIRI4
ASGNI4
line 815
;815:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $591
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1024
ADDRLP4 556
INDIRI4
ASGNI4
line 845
;816:
;817:#ifdef MISSIONPACK
;818:	trap_S_RegisterSound("sound/player/james/death1.wav", qfalse );
;819:	trap_S_RegisterSound("sound/player/james/death2.wav", qfalse );
;820:	trap_S_RegisterSound("sound/player/james/death3.wav", qfalse );
;821:	trap_S_RegisterSound("sound/player/james/jump1.wav", qfalse );
;822:	trap_S_RegisterSound("sound/player/james/pain25_1.wav", qfalse );
;823:	trap_S_RegisterSound("sound/player/james/pain75_1.wav", qfalse );
;824:	trap_S_RegisterSound("sound/player/james/pain100_1.wav", qfalse );
;825:	trap_S_RegisterSound("sound/player/james/falling1.wav", qfalse );
;826:	trap_S_RegisterSound("sound/player/james/gasp.wav", qfalse );
;827:	trap_S_RegisterSound("sound/player/james/drown.wav", qfalse );
;828:	trap_S_RegisterSound("sound/player/james/fall1.wav", qfalse );
;829:	trap_S_RegisterSound("sound/player/james/taunt.wav", qfalse );
;830:
;831:	trap_S_RegisterSound("sound/player/janet/death1.wav", qfalse );
;832:	trap_S_RegisterSound("sound/player/janet/death2.wav", qfalse );
;833:	trap_S_RegisterSound("sound/player/janet/death3.wav", qfalse );
;834:	trap_S_RegisterSound("sound/player/janet/jump1.wav", qfalse );
;835:	trap_S_RegisterSound("sound/player/janet/pain25_1.wav", qfalse );
;836:	trap_S_RegisterSound("sound/player/janet/pain75_1.wav", qfalse );
;837:	trap_S_RegisterSound("sound/player/janet/pain100_1.wav", qfalse );
;838:	trap_S_RegisterSound("sound/player/janet/falling1.wav", qfalse );
;839:	trap_S_RegisterSound("sound/player/janet/gasp.wav", qfalse );
;840:	trap_S_RegisterSound("sound/player/janet/drown.wav", qfalse );
;841:	trap_S_RegisterSound("sound/player/janet/fall1.wav", qfalse );
;842:	trap_S_RegisterSound("sound/player/janet/taunt.wav", qfalse );
;843:#endif
;844:
;845:}
LABELV $304
endproc CG_RegisterSounds 560 16
data
align 4
LABELV $593
address $594
address $595
address $596
address $597
address $598
address $599
address $600
address $601
address $602
address $603
address $604
code
proc CG_RegisterGraphics 604 16
line 858
;846:
;847:
;848://===================================================================================
;849:
;850:
;851:/*
;852:=================
;853:CG_RegisterGraphics
;854:
;855:This function may execute for a couple of minutes with a slow disk.
;856:=================
;857:*/
;858:static void CG_RegisterGraphics( void ) {
line 876
;859:	int			i;
;860:	char		items[MAX_ITEMS+1];
;861:	static char		*sb_nums[11] = {
;862:		"gfx/2d/numbers/zero_32b",
;863:		"gfx/2d/numbers/one_32b",
;864:		"gfx/2d/numbers/two_32b",
;865:		"gfx/2d/numbers/three_32b",
;866:		"gfx/2d/numbers/four_32b",
;867:		"gfx/2d/numbers/five_32b",
;868:		"gfx/2d/numbers/six_32b",
;869:		"gfx/2d/numbers/seven_32b",
;870:		"gfx/2d/numbers/eight_32b",
;871:		"gfx/2d/numbers/nine_32b",
;872:		"gfx/2d/numbers/minus_32b",
;873:	};
;874:
;875:	// clear any references to old media
;876:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109056
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 877
;877:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 879
;878:
;879:	CG_LoadingString( cgs.mapname );
ADDRGP4 cgs+31508
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 881
;880:
;881:	trap_R_LoadWorldMap( cgs.mapname );
ADDRGP4 cgs+31508
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 884
;882:
;883:	// precache status bar pics
;884:	CG_LoadingString( "game media" );
ADDRGP4 $609
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 886
;885:
;886:	for ( i = 0 ; i < ARRAY_LEN( sb_nums ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $613
JUMPV
LABELV $610
line 887
;887:		cgs.media.numberShaders[i] = trap_R_RegisterShader( sb_nums[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $593
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+320
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 888
;888:	}
LABELV $611
line 886
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $613
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 11
LTU4 $610
line 890
;889:
;890:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader( "menu/art/skill1.tga" );
ADDRGP4 $618
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+368
ADDRLP4 264
INDIRI4
ASGNI4
line 891
;891:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader( "menu/art/skill2.tga" );
ADDRGP4 $622
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+368+4
ADDRLP4 268
INDIRI4
ASGNI4
line 892
;892:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader( "menu/art/skill3.tga" );
ADDRGP4 $626
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+368+8
ADDRLP4 272
INDIRI4
ASGNI4
line 893
;893:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader( "menu/art/skill4.tga" );
ADDRGP4 $630
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+368+12
ADDRLP4 276
INDIRI4
ASGNI4
line 894
;894:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader( "menu/art/skill5.tga" );
ADDRGP4 $634
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+368+16
ADDRLP4 280
INDIRI4
ASGNI4
line 896
;895:
;896:	cgs.media.viewBloodShader = trap_R_RegisterShader( "viewBloodBlend" );
ADDRGP4 $637
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+216
ADDRLP4 284
INDIRI4
ASGNI4
line 898
;897:
;898:	cgs.media.deferShader = trap_R_RegisterShaderNoMip( "gfx/2d/defer.tga" );
ADDRGP4 $640
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+132
ADDRLP4 288
INDIRI4
ASGNI4
line 900
;899:
;900:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip( "menu/tab/name.tga" );
ADDRGP4 $643
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+496
ADDRLP4 292
INDIRI4
ASGNI4
line 901
;901:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip( "menu/tab/ping.tga" );
ADDRGP4 $646
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+500
ADDRLP4 296
INDIRI4
ASGNI4
line 902
;902:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip( "menu/tab/score.tga" );
ADDRGP4 $649
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+504
ADDRLP4 300
INDIRI4
ASGNI4
line 903
;903:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip( "menu/tab/time.tga" );
ADDRGP4 $652
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+508
ADDRLP4 304
INDIRI4
ASGNI4
line 905
;904:
;905:	cgs.media.smokePuffShader = trap_R_RegisterShader( "smokePuff" );
ADDRGP4 $655
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+276
ADDRLP4 308
INDIRI4
ASGNI4
line 906
;906:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader( "smokePuffRagePro" );
ADDRGP4 $658
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+280
ADDRLP4 312
INDIRI4
ASGNI4
line 907
;907:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader( "shotgunSmokePuff" );
ADDRGP4 $661
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+284
ADDRLP4 316
INDIRI4
ASGNI4
line 912
;908:#ifdef MISSIONPACK
;909:	cgs.media.nailPuffShader = trap_R_RegisterShader( "nailtrail" );
;910:	cgs.media.blueProxMine = trap_R_RegisterModel( "models/weaphits/proxmineb.md3" );
;911:#endif
;912:	cgs.media.plasmaBallShader = trap_R_RegisterShader( "sprites/plasma1" );
ADDRGP4 $664
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+288
ADDRLP4 320
INDIRI4
ASGNI4
line 913
;913:	cgs.media.bloodTrailShader = trap_R_RegisterShader( "bloodTrail" );
ADDRGP4 $667
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+296
ADDRLP4 324
INDIRI4
ASGNI4
line 914
;914:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer" );
ADDRGP4 $670
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+264
ADDRLP4 328
INDIRI4
ASGNI4
line 915
;915:	cgs.media.connectionShader = trap_R_RegisterShader( "disconnected" );
ADDRGP4 $673
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+208
ADDRLP4 332
INDIRI4
ASGNI4
line 917
;916:
;917:	cgs.media.waterBubbleShader = trap_R_RegisterShader( "waterBubble" );
ADDRGP4 $676
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+292
ADDRLP4 336
INDIRI4
ASGNI4
line 919
;918:
;919:	cgs.media.tracerShader = trap_R_RegisterShader( "gfx/misc/tracer" );
ADDRGP4 $679
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+220
ADDRLP4 340
INDIRI4
ASGNI4
line 920
;920:	cgs.media.selectShader = trap_R_RegisterShader( "gfx/2d/select" );
ADDRGP4 $682
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+212
ADDRLP4 344
INDIRI4
ASGNI4
line 922
;921:
;922:	for ( i = 0 ; i < NUM_CROSSHAIRS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $683
line 923
;923:		cgs.media.crosshairShader[i] = trap_R_RegisterShader( va("gfx/2d/crosshair%c", 'a'+i) );
ADDRGP4 $689
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148752+224
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 924
;924:	}
LABELV $684
line 922
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $683
line 926
;925:
;926:	cgs.media.backTileShader = trap_R_RegisterShader( "gfx/2d/backtile" );
ADDRGP4 $692
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+268
ADDRLP4 348
INDIRI4
ASGNI4
line 927
;927:	cgs.media.noammoShader = trap_R_RegisterShader( "icons/noammo" );
ADDRGP4 $695
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+272
ADDRLP4 352
INDIRI4
ASGNI4
line 930
;928:
;929:	// powerup shaders
;930:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad" );
ADDRGP4 $698
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+412
ADDRLP4 356
INDIRI4
ASGNI4
line 931
;931:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon" );
ADDRGP4 $701
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+420
ADDRLP4 360
INDIRI4
ASGNI4
line 932
;932:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit" );
ADDRGP4 $704
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+432
ADDRLP4 364
INDIRI4
ASGNI4
line 933
;933:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon" );
ADDRGP4 $707
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+436
ADDRLP4 368
INDIRI4
ASGNI4
line 934
;934:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility" );
ADDRGP4 $710
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+424
ADDRLP4 372
INDIRI4
ASGNI4
line 935
;935:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen" );
ADDRGP4 $713
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+428
ADDRLP4 376
INDIRI4
ASGNI4
line 936
;936:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff" );
ADDRGP4 $716
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+440
ADDRLP4 380
INDIRI4
ASGNI4
line 941
;937:
;938:#ifdef MISSIONPACK
;939:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;940:#else
;941:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $721
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $717
LABELV $721
line 943
;942:#endif
;943:		cgs.media.redCubeModel = trap_R_RegisterModel( "models/powerups/orb/r_orb.md3" );
ADDRGP4 $724
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+20
ADDRLP4 384
INDIRI4
ASGNI4
line 944
;944:		cgs.media.blueCubeModel = trap_R_RegisterModel( "models/powerups/orb/b_orb.md3" );
ADDRGP4 $727
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+24
ADDRLP4 388
INDIRI4
ASGNI4
line 945
;945:		cgs.media.redCubeIcon = trap_R_RegisterShader( "icons/skull_red" );
ADDRGP4 $730
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+28
ADDRLP4 392
INDIRI4
ASGNI4
line 946
;946:		cgs.media.blueCubeIcon = trap_R_RegisterShader( "icons/skull_blue" );
ADDRGP4 $733
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+32
ADDRLP4 396
INDIRI4
ASGNI4
line 947
;947:	}
LABELV $717
line 952
;948:
;949:#ifdef MISSIONPACK
;950:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;951:#else
;952:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $738
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $734
LABELV $738
line 954
;953:#endif
;954:		cgs.media.redFlagModel = trap_R_RegisterModel( "models/flags/r_flag.md3" );
ADDRGP4 $741
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+36
ADDRLP4 384
INDIRI4
ASGNI4
line 955
;955:		cgs.media.blueFlagModel = trap_R_RegisterModel( "models/flags/b_flag.md3" );
ADDRGP4 $744
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+40
ADDRLP4 388
INDIRI4
ASGNI4
line 956
;956:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_red1" );
ADDRGP4 $747
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+48
ADDRLP4 392
INDIRI4
ASGNI4
line 957
;957:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
ADDRGP4 $751
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+48+4
ADDRLP4 396
INDIRI4
ASGNI4
line 958
;958:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_red3" );
ADDRGP4 $755
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+48+8
ADDRLP4 400
INDIRI4
ASGNI4
line 959
;959:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_blu1" );
ADDRGP4 $758
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+60
ADDRLP4 404
INDIRI4
ASGNI4
line 960
;960:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
ADDRGP4 $762
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+60+4
ADDRLP4 408
INDIRI4
ASGNI4
line 961
;961:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu3" );
ADDRGP4 $766
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+60+8
ADDRLP4 412
INDIRI4
ASGNI4
line 963
;962:
;963:		cgs.media.flagPoleModel = trap_R_RegisterModel( "models/flag2/flagpole.md3" );
ADDRGP4 $769
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+88
ADDRLP4 416
INDIRI4
ASGNI4
line 964
;964:		cgs.media.flagFlapModel = trap_R_RegisterModel( "models/flag2/flagflap3.md3" );
ADDRGP4 $772
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+92
ADDRLP4 420
INDIRI4
ASGNI4
line 966
;965:
;966:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/red.skin" );
ADDRGP4 $775
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+148752+96
ADDRLP4 424
INDIRI4
ASGNI4
line 967
;967:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/blue.skin" );
ADDRGP4 $778
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+148752+100
ADDRLP4 428
INDIRI4
ASGNI4
line 968
;968:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/white.skin" );
ADDRGP4 $781
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+148752+104
ADDRLP4 432
INDIRI4
ASGNI4
line 974
;969:#ifdef MISSIONPACK
;970:		cgs.media.redFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/red_base.md3" );
;971:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/blue_base.md3" );
;972:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/ntrl_base.md3" );
;973:#endif
;974:	}
LABELV $734
line 1003
;975:
;976:#ifdef MISSIONPACK
;977:	if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;978:		cgs.media.neutralFlagModel = trap_R_RegisterModel( "models/flags/n_flag.md3" );
;979:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral1" );
;980:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
;981:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
;982:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral3" );
;983:	}
;984:
;985:	if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;986:		cgs.media.overloadBaseModel = trap_R_RegisterModel( "models/powerups/overload_base.md3" );
;987:		cgs.media.overloadTargetModel = trap_R_RegisterModel( "models/powerups/overload_target.md3" );
;988:		cgs.media.overloadLightsModel = trap_R_RegisterModel( "models/powerups/overload_lights.md3" );
;989:		cgs.media.overloadEnergyModel = trap_R_RegisterModel( "models/powerups/overload_energy.md3" );
;990:	}
;991:
;992:	if ( cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;993:		cgs.media.harvesterModel = trap_R_RegisterModel( "models/powerups/harvester/harvester.md3" );
;994:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin( "models/powerups/harvester/red.skin" );
;995:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin( "models/powerups/harvester/blue.skin" );
;996:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel( "models/powerups/obelisk/obelisk.md3" );
;997:	}
;998:
;999:	cgs.media.redKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikred" );
;1000:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff" );
;1001:#endif
;1002:
;1003:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $786
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $782
LABELV $786
line 1004
;1004:		cgs.media.friendShader = trap_R_RegisterShader( "sprites/foe" );
ADDRGP4 $789
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+200
ADDRLP4 384
INDIRI4
ASGNI4
line 1005
;1005:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag" );
ADDRGP4 $792
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+416
ADDRLP4 388
INDIRI4
ASGNI4
line 1006
;1006:		cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" );
ADDRGP4 $795
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+128
ADDRLP4 392
INDIRI4
ASGNI4
line 1010
;1007:#ifdef MISSIONPACK
;1008:		cgs.media.blueKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikblu" );
;1009:#endif
;1010:	}
LABELV $782
line 1012
;1011:
;1012:	cgs.media.armorModel = trap_R_RegisterModel( "models/powerups/armor/armor_yel.md3" );
ADDRGP4 $798
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+120
ADDRLP4 384
INDIRI4
ASGNI4
line 1013
;1013:	cgs.media.armorIcon  = trap_R_RegisterShaderNoMip( "icons/iconr_yellow" );
ADDRGP4 $801
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+124
ADDRLP4 388
INDIRI4
ASGNI4
line 1015
;1014:
;1015:	cgs.media.machinegunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/m_shell.md3" );
ADDRGP4 $804
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+180
ADDRLP4 392
INDIRI4
ASGNI4
line 1016
;1016:	cgs.media.shotgunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $807
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+184
ADDRLP4 396
INDIRI4
ASGNI4
line 1018
;1017:
;1018:	cgs.media.gibAbdomen = trap_R_RegisterModel( "models/gibs/abdomen.md3" );
ADDRGP4 $810
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+136
ADDRLP4 400
INDIRI4
ASGNI4
line 1019
;1019:	cgs.media.gibArm = trap_R_RegisterModel( "models/gibs/arm.md3" );
ADDRGP4 $813
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+140
ADDRLP4 404
INDIRI4
ASGNI4
line 1020
;1020:	cgs.media.gibChest = trap_R_RegisterModel( "models/gibs/chest.md3" );
ADDRGP4 $816
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+144
ADDRLP4 408
INDIRI4
ASGNI4
line 1021
;1021:	cgs.media.gibFist = trap_R_RegisterModel( "models/gibs/fist.md3" );
ADDRGP4 $819
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+148
ADDRLP4 412
INDIRI4
ASGNI4
line 1022
;1022:	cgs.media.gibFoot = trap_R_RegisterModel( "models/gibs/foot.md3" );
ADDRGP4 $822
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+152
ADDRLP4 416
INDIRI4
ASGNI4
line 1023
;1023:	cgs.media.gibForearm = trap_R_RegisterModel( "models/gibs/forearm.md3" );
ADDRGP4 $825
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+156
ADDRLP4 420
INDIRI4
ASGNI4
line 1024
;1024:	cgs.media.gibIntestine = trap_R_RegisterModel( "models/gibs/intestine.md3" );
ADDRGP4 $828
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+160
ADDRLP4 424
INDIRI4
ASGNI4
line 1025
;1025:	cgs.media.gibLeg = trap_R_RegisterModel( "models/gibs/leg.md3" );
ADDRGP4 $831
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+164
ADDRLP4 428
INDIRI4
ASGNI4
line 1026
;1026:	cgs.media.gibSkull = trap_R_RegisterModel( "models/gibs/skull.md3" );
ADDRGP4 $834
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+168
ADDRLP4 432
INDIRI4
ASGNI4
line 1027
;1027:	cgs.media.gibBrain = trap_R_RegisterModel( "models/gibs/brain.md3" );
ADDRGP4 $837
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+172
ADDRLP4 436
INDIRI4
ASGNI4
line 1029
;1028:
;1029:	cgs.media.smoke2 = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $807
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+176
ADDRLP4 440
INDIRI4
ASGNI4
line 1031
;1030:
;1031:	cgs.media.balloonShader = trap_R_RegisterShader( "sprites/balloon3" );
ADDRGP4 $842
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+204
ADDRLP4 444
INDIRI4
ASGNI4
line 1033
;1032:
;1033:	cgs.media.bloodExplosionShader = trap_R_RegisterShader( "bloodExplosion" );
ADDRGP4 $845
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+484
ADDRLP4 448
INDIRI4
ASGNI4
line 1035
;1034:
;1035:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $848
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+444
ADDRLP4 452
INDIRI4
ASGNI4
line 1036
;1036:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $851
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+448
ADDRLP4 456
INDIRI4
ASGNI4
line 1037
;1037:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $854
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+452
ADDRLP4 460
INDIRI4
ASGNI4
line 1041
;1038:#ifdef MISSIONPACK
;1039:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/powerups/pop.md3" );
;1040:#else
;1041:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/misc/telep.md3" );
ADDRGP4 $857
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+148752+488
ADDRLP4 464
INDIRI4
ASGNI4
line 1042
;1042:	cgs.media.teleportEffectShader = trap_R_RegisterShader( "teleportEffect" );
ADDRGP4 $860
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+492
ADDRLP4 468
INDIRI4
ASGNI4
line 1060
;1043:#endif
;1044:#ifdef MISSIONPACK
;1045:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel( "models/weaphits/kamboom2.md3" );
;1046:	cgs.media.kamikazeShockWave = trap_R_RegisterModel( "models/weaphits/kamwave.md3" );
;1047:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel( "models/powerups/kamikazi.md3" );
;1048:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel( "models/powerups/trailtest.md3" );
;1049:	cgs.media.guardPowerupModel = trap_R_RegisterModel( "models/powerups/guard_player.md3" );
;1050:	cgs.media.scoutPowerupModel = trap_R_RegisterModel( "models/powerups/scout_player.md3" );
;1051:	cgs.media.doublerPowerupModel = trap_R_RegisterModel( "models/powerups/doubler_player.md3" );
;1052:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel( "models/powerups/ammo_player.md3" );
;1053:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel( "models/powerups/shield/impact.md3" );
;1054:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel( "models/powerups/shield/juicer.md3" );
;1055:	cgs.media.medkitUsageModel = trap_R_RegisterModel( "models/powerups/regen.md3" );
;1056:	cgs.media.heartShader = trap_R_RegisterShaderNoMip( "ui/assets/statusbar/selectedhealth.tga" );
;1057:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel( "models/powerups/shield/shield.md3" );
;1058:#endif
;1059:
;1060:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip( "medal_impressive" );
ADDRGP4 $863
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+512
ADDRLP4 472
INDIRI4
ASGNI4
line 1061
;1061:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip( "medal_excellent" );
ADDRGP4 $866
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+516
ADDRLP4 476
INDIRI4
ASGNI4
line 1062
;1062:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip( "medal_gauntlet" );
ADDRGP4 $869
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+520
ADDRLP4 480
INDIRI4
ASGNI4
line 1063
;1063:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip( "medal_defend" );
ADDRGP4 $872
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+524
ADDRLP4 484
INDIRI4
ASGNI4
line 1064
;1064:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip( "medal_assist" );
ADDRGP4 $875
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+528
ADDRLP4 488
INDIRI4
ASGNI4
line 1065
;1065:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip( "medal_capture" );
ADDRGP4 $878
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+532
ADDRLP4 492
INDIRI4
ASGNI4
line 1069
;1066:
;1067:#ifdef NEOHUD
;1068:	// Quake Live HUD default icons
;1069:	cgs.media.gameTypeShader[GT_FFA] = trap_R_RegisterShaderNoMip("hud/hudQL/ffa");//free for all
ADDRGP4 $881
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+300
ADDRLP4 496
INDIRI4
ASGNI4
line 1070
;1070:	cgs.media.gameTypeShader[GT_TOURNAMENT] = trap_R_RegisterShaderNoMip("hud/hudQL/duel");//one on one tournament
ADDRGP4 $885
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+300+4
ADDRLP4 500
INDIRI4
ASGNI4
line 1071
;1071:	cgs.media.gameTypeShader[GT_SINGLE_PLAYER] = trap_R_RegisterShaderNoMip("hud/hudQL/ffa");//single player ffa
ADDRGP4 $881
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+300+8
ADDRLP4 504
INDIRI4
ASGNI4
line 1072
;1072:	cgs.media.gameTypeShader[GT_TEAM] = trap_R_RegisterShaderNoMip("hud/hudQL/tdm");//team deathmatch
ADDRGP4 $892
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+300+12
ADDRLP4 508
INDIRI4
ASGNI4
line 1073
;1073:	cgs.media.gameTypeShader[GT_CTF] = trap_R_RegisterShaderNoMip("hud/hudQL/ctf");//capture the flag
ADDRGP4 $896
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+300+16
ADDRLP4 512
INDIRI4
ASGNI4
line 1081
;1074:#endif
;1075:#ifdef MISSIONPACK
;1076:	cgs.media.gameTypeShader[GT_1FCTF] = trap_R_RegisterShaderNoMip("hud/hudQL/1f");
;1077:	cgs.media.gameTypeShader[GT_OBELISK] = trap_R_RegisterShaderNoMip("hud/hudQL/har");
;1078:	cgs.media.gameTypeShader[GT_HARVESTER] = trap_R_RegisterShaderNoMip("hud/hudQL/har");
;1079:#endif
;1080:
;1081:	memset( cg_items, 0, sizeof( cg_items ) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7168
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1082
;1082:	memset( cg_weapons, 0, sizeof( cg_weapons ) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1085
;1083:
;1084:	// only register the items that the server says we need
;1085:	Q_strncpyz( items, CG_ConfigString(CS_ITEMS), sizeof( items ) );
CNSTI4 27
ARGI4
ADDRLP4 516
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 516
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1087
;1086:
;1087:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $900
JUMPV
LABELV $897
line 1088
;1088:		if ( items[ i ] == '1' || cg_buildScript.integer ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $904
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $901
LABELV $904
line 1089
;1089:			CG_LoadingItem( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 1090
;1090:			CG_RegisterItemVisuals( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1091
;1091:		}
LABELV $901
line 1092
;1092:	}
LABELV $898
line 1087
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $900
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $897
line 1094
;1093:
;1094:	cg.skipDFshaders = qfalse;
ADDRGP4 cg+149116
CNSTI4 0
ASGNI4
line 1097
;1095:
;1096:	// wall marks
;1097:	cgs.media.bulletMarkShader = trap_R_RegisterShader( "gfx/damage/bullet_mrk" );
ADDRGP4 $908
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+396
ADDRLP4 520
INDIRI4
ASGNI4
line 1098
;1098:	cgs.media.burnMarkShader = trap_R_RegisterShader( "gfx/damage/burn_med_mrk" );
ADDRGP4 $911
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+400
ADDRLP4 524
INDIRI4
ASGNI4
line 1099
;1099:	cgs.media.holeMarkShader = trap_R_RegisterShader( "gfx/damage/hole_lg_mrk" );
ADDRGP4 $914
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+404
ADDRLP4 528
INDIRI4
ASGNI4
line 1100
;1100:	cgs.media.energyMarkShader = trap_R_RegisterShader( "gfx/damage/plasma_mrk" );
ADDRGP4 $917
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+408
ADDRLP4 532
INDIRI4
ASGNI4
line 1101
;1101:	cgs.media.shadowMarkShader = trap_R_RegisterShader( "markShadow" );
ADDRGP4 $920
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+364
ADDRLP4 536
INDIRI4
ASGNI4
line 1102
;1102:	cgs.media.wakeMarkShader = trap_R_RegisterShader( "wake" );
ADDRGP4 $923
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+388
ADDRLP4 540
INDIRI4
ASGNI4
line 1103
;1103:	cgs.media.bloodMarkShader = trap_R_RegisterShader( "bloodMark" );
ADDRGP4 $926
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+392
ADDRLP4 544
INDIRI4
ASGNI4
line 1106
;1104:
;1105:	// register the inline models
;1106:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 548
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+36896
ADDRLP4 548
INDIRI4
ASGNI4
line 1107
;1107:	for ( i = 1 ; i < cgs.numInlineModels ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $931
JUMPV
LABELV $928
line 1112
;1108:		char	name[10];
;1109:		vec3_t			mins, maxs;
;1110:		int				j;
;1111:
;1112:		Com_sprintf( name, sizeof(name), "*%i", i );
ADDRLP4 580
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $933
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1113
;1113:		cgs.inlineDrawModel[i] = trap_R_RegisterModel( name );
ADDRLP4 580
ARGP4
ADDRLP4 592
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36900
ADDP4
ADDRLP4 592
INDIRI4
ASGNI4
line 1114
;1114:		trap_R_ModelBounds( cgs.inlineDrawModel[i], mins, maxs );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36900
ADDP4
INDIRI4
ARGI4
ADDRLP4 556
ARGP4
ADDRLP4 568
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1115
;1115:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 552
CNSTI4 0
ASGNI4
LABELV $936
line 1116
;1116:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * ( maxs[j] - mins[j] );
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+37924
ADDP4
ADDP4
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 556
ADDP4
INDIRF4
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 568
ADDP4
INDIRF4
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 556
ADDP4
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 1117
;1117:		}
LABELV $937
line 1115
ADDRLP4 552
ADDRLP4 552
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 3
LTI4 $936
line 1118
;1118:	}
LABELV $929
line 1107
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $931
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+36896
INDIRI4
LTI4 $928
line 1121
;1119:
;1120:	// register all the server specified models
;1121:	for (i=1 ; i<MAX_MODELS ; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $941
line 1124
;1122:		const char		*modelName;
;1123:
;1124:		modelName = CG_ConfigString( CS_MODELS+i );
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 556
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 552
ADDRLP4 556
INDIRP4
ASGNP4
line 1125
;1125:		if ( !modelName[0] ) {
ADDRLP4 552
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $945
line 1126
;1126:			break;
ADDRGP4 $943
JUMPV
LABELV $945
line 1128
;1127:		}
;1128:		cgs.gameModels[i] = trap_R_RegisterModel( modelName );
ADDRLP4 552
INDIRP4
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34848
ADDP4
ADDRLP4 560
INDIRI4
ASGNI4
line 1129
;1129:	}
LABELV $942
line 1121
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $941
LABELV $943
line 1131
;1130:
;1131:	cgs.media.cursor = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
ADDRGP4 $950
ARGP4
ADDRLP4 552
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+1004
ADDRLP4 552
INDIRI4
ASGNI4
line 1133
;1132:#if defined MISSIONPACK || defined NEOHUD
;1133:	cgs.media.menuscreen2 = trap_R_RegisterShader("menuscreen2");
ADDRGP4 $953
ARGP4
ADDRLP4 556
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+956
ADDRLP4 556
INDIRI4
ASGNI4
line 1135
;1134:	// new stuff
;1135:	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
ADDRGP4 $956
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+960
ADDRLP4 560
INDIRI4
ASGNI4
line 1136
;1136:	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
ADDRGP4 $959
ARGP4
ADDRLP4 564
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+964
ADDRLP4 564
INDIRI4
ASGNI4
line 1137
;1137:	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
ADDRGP4 $962
ARGP4
ADDRLP4 568
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+968
ADDRLP4 568
INDIRI4
ASGNI4
line 1138
;1138:	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
ADDRGP4 $965
ARGP4
ADDRLP4 572
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+972
ADDRLP4 572
INDIRI4
ASGNI4
line 1139
;1139:	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
ADDRGP4 $968
ARGP4
ADDRLP4 576
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+976
ADDRLP4 576
INDIRI4
ASGNI4
line 1140
;1140:	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
ADDRGP4 $971
ARGP4
ADDRLP4 580
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+980
ADDRLP4 580
INDIRI4
ASGNI4
line 1141
;1141:	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
ADDRGP4 $974
ARGP4
ADDRLP4 584
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+984
ADDRLP4 584
INDIRI4
ASGNI4
line 1142
;1142:	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
ADDRGP4 $977
ARGP4
ADDRLP4 588
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+988
ADDRLP4 588
INDIRI4
ASGNI4
line 1144
;1143:
;1144:	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
ADDRGP4 $980
ARGP4
ADDRLP4 592
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+992
ADDRLP4 592
INDIRI4
ASGNI4
line 1145
;1145:	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
ADDRGP4 $984
ARGP4
ADDRLP4 596
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+992+4
ADDRLP4 596
INDIRI4
ASGNI4
line 1146
;1146:	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");
ADDRGP4 $988
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+992+8
ADDRLP4 600
INDIRI4
ASGNI4
line 1161
;1147:#endif
;1148:
;1149:#ifdef MISSIONPACK
;1150:	cgs.media.sizeCursor 	= trap_R_RegisterShaderNoMip( "ui/assets/sizecursor.tga" );
;1151:	cgs.media.selectCursor 	= trap_R_RegisterShaderNoMip( "ui/assets/selectcursor.tga" );
;1152:	trap_R_RegisterModel( "models/players/james/lower.md3" );
;1153:	trap_R_RegisterModel( "models/players/james/upper.md3" );
;1154:	trap_R_RegisterModel( "models/players/heads/james/james.md3" );
;1155:
;1156:	trap_R_RegisterModel( "models/players/janet/lower.md3" );
;1157:	trap_R_RegisterModel( "models/players/janet/upper.md3" );
;1158:	trap_R_RegisterModel( "models/players/heads/janet/janet.md3" );
;1159:
;1160:#endif
;1161:	CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 1174
;1162:/*
;1163:	for (i=1; i<MAX_PARTICLES_AREAS; i++)
;1164:	{
;1165:		{
;1166:			int rval;
;1167:
;1168:			rval = CG_NewParticleArea ( CS_PARTICLES + i);
;1169:			if (!rval)
;1170:				break;
;1171:		}
;1172:	}
;1173:*/
;1174:}
LABELV $592
endproc CG_RegisterGraphics 604 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 1184
;1175:
;1176:
;1177:
;1178:/*																																			
;1179:=======================
;1180:CG_BuildSpectatorString
;1181:
;1182:=======================
;1183:*/
;1184:void CG_BuildSpectatorString( void ) {
line 1186
;1185:	int i;
;1186:	cg.spectatorList[0] = 0;
ADDRGP4 cg+115436
CNSTI1 0
ASGNI1
line 1187
;1187:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $991
line 1188
;1188:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $995
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $995
line 1189
;1189:			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $1002
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+115436
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1190
;1190:		}
LABELV $995
line 1191
;1191:	}
LABELV $992
line 1187
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $991
line 1192
;1192:	i = strlen(cg.spectatorList);
ADDRGP4 cg+115436
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1193
;1193:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+116460
INDIRI4
EQI4 $1006
line 1194
;1194:		cg.spectatorLen = i;
ADDRGP4 cg+116460
ADDRLP4 0
INDIRI4
ASGNI4
line 1195
;1195:		cg.spectatorWidth = -1;
ADDRGP4 cg+116464
CNSTF4 3212836864
ASGNF4
line 1196
;1196:	}
LABELV $1006
line 1197
;1197:}
LABELV $989
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 1205
;1198:
;1199:
;1200:/*																																			
;1201:===================
;1202:CG_RegisterClients
;1203:===================
;1204:*/
;1205:static void CG_RegisterClients( void ) {
line 1208
;1206:	int		i;
;1207:
;1208:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1209
;1209:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1211
;1210:
;1211:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1014
line 1214
;1212:		const char		*clientInfo;
;1213:
;1214:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1018
line 1215
;1215:			continue;
ADDRGP4 $1015
JUMPV
LABELV $1018
line 1218
;1216:		}
;1217:
;1218:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1219
;1219:		if ( !clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1021
line 1220
;1220:			continue;
ADDRGP4 $1015
JUMPV
LABELV $1021
line 1222
;1221:		}
;1222:		CG_LoadingClient( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1223
;1223:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1224
;1224:	}
LABELV $1015
line 1211
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1014
line 1225
;1225:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 1226
;1226:}
LABELV $1011
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 1235
;1227:
;1228://===========================================================================
;1229:
;1230:/*
;1231:=================
;1232:CG_ConfigString
;1233:=================
;1234:*/
;1235:const char *CG_ConfigString( int index ) {
line 1236
;1236:	if ( index < 0 || index >= MAX_CONFIGSTRINGS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1026
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1024
LABELV $1026
line 1237
;1237:		CG_Error( "CG_ConfigString: bad index: %i", index );
ADDRGP4 $1027
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1238
;1238:		return "";
ADDRGP4 $205
RETP4
ADDRGP4 $1023
JUMPV
LABELV $1024
line 1240
;1239:	}
;1240:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $1023
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 144 12
line 1251
;1241:}
;1242:
;1243://==================================================================
;1244:
;1245:/*
;1246:======================
;1247:CG_StartMusic
;1248:
;1249:======================
;1250:*/
;1251:void CG_StartMusic( void ) {
line 1256
;1252:	char	*s;
;1253:	char	parm1[MAX_QPATH], parm2[MAX_QPATH];
;1254:
;1255:	// start the background music
;1256:	s = (char *)CG_ConfigString( CS_MUSIC );
CNSTI4 2
ARGI4
ADDRLP4 132
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 1257
;1257:	Q_strncpyz( parm1, COM_Parse( &s ), sizeof( parm1 ) );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1258
;1258:	Q_strncpyz( parm2, COM_Parse( &s ), sizeof( parm2 ) );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1260
;1259:
;1260:	trap_S_StartBackgroundTrack( parm1, parm2 );
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 1261
;1261:}
LABELV $1029
endproc CG_StartMusic 144 12
export CG_Init
proc CG_Init 312 12
line 1927
;1262:#ifdef MISSIONPACK
;1263:char *CG_GetMenuBuffer(const char *filename) {
;1264:	int	len;
;1265:	fileHandle_t	f;
;1266:	static char buf[MAX_MENUFILE];
;1267:
;1268:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
;1269:	if ( !f ) {
;1270:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
;1271:		return NULL;
;1272:	}
;1273:	if ( len >= MAX_MENUFILE ) {
;1274:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i\n", filename, len, MAX_MENUFILE ) );
;1275:		trap_FS_FCloseFile( f );
;1276:		return NULL;
;1277:	}
;1278:
;1279:	trap_FS_Read( buf, len, f );
;1280:	buf[len] = 0;
;1281:	trap_FS_FCloseFile( f );
;1282:
;1283:	return buf;
;1284:}
;1285:
;1286://
;1287:// ==============================
;1288:// new hud stuff ( mission pack )
;1289:// ==============================
;1290://
;1291:qboolean CG_Asset_Parse(int handle) {
;1292:	pc_token_t token;
;1293:	const char *tempStr;
;1294:
;1295:	if (!trap_PC_ReadToken(handle, &token))
;1296:		return qfalse;
;1297:	if (Q_stricmp(token.string, "{") != 0) {
;1298:		return qfalse;
;1299:	}
;1300:
;1301:	while ( 1 ) {
;1302:		if (!trap_PC_ReadToken(handle, &token))
;1303:			return qfalse;
;1304:
;1305:		if (Q_stricmp(token.string, "}") == 0) {
;1306:			return qtrue;
;1307:		}
;1308:
;1309:		// font
;1310:		if (Q_stricmp(token.string, "font") == 0) {
;1311:			int pointSize;
;1312:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1313:				return qfalse;
;1314:			}
;1315:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
;1316:			continue;
;1317:		}
;1318:
;1319:		// smallFont
;1320:		if (Q_stricmp(token.string, "smallFont") == 0) {
;1321:			int pointSize;
;1322:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1323:				return qfalse;
;1324:			}
;1325:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
;1326:			continue;
;1327:		}
;1328:
;1329:		// bigfont
;1330:		if (Q_stricmp(token.string, "bigfont") == 0) {
;1331:			int pointSize;
;1332:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1333:				return qfalse;
;1334:			}
;1335:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
;1336:			continue;
;1337:		}
;1338:
;1339:		// gradientbar
;1340:		if (Q_stricmp(token.string, "gradientbar") == 0) {
;1341:			if (!PC_String_Parse(handle, &tempStr)) {
;1342:				return qfalse;
;1343:			}
;1344:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
;1345:			continue;
;1346:		}
;1347:
;1348:		// enterMenuSound
;1349:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
;1350:			if (!PC_String_Parse(handle, &tempStr)) {
;1351:				return qfalse;
;1352:			}
;1353:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
;1354:			continue;
;1355:		}
;1356:
;1357:		// exitMenuSound
;1358:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
;1359:			if (!PC_String_Parse(handle, &tempStr)) {
;1360:				return qfalse;
;1361:			}
;1362:			cgDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
;1363:			continue;
;1364:		}
;1365:
;1366:		// itemFocusSound
;1367:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
;1368:			if (!PC_String_Parse(handle, &tempStr)) {
;1369:				return qfalse;
;1370:			}
;1371:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
;1372:			continue;
;1373:		}
;1374:
;1375:		// menuBuzzSound
;1376:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
;1377:			if (!PC_String_Parse(handle, &tempStr)) {
;1378:				return qfalse;
;1379:			}
;1380:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
;1381:			continue;
;1382:		}
;1383:
;1384:		if (Q_stricmp(token.string, "cursor") == 0) {
;1385:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
;1386:				return qfalse;
;1387:			}
;1388:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip( cgDC.Assets.cursorStr);
;1389:			continue;
;1390:		}
;1391:
;1392:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
;1393:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
;1394:				return qfalse;
;1395:			}
;1396:			continue;
;1397:		}
;1398:
;1399:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
;1400:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
;1401:				return qfalse;
;1402:			}
;1403:			continue;
;1404:		}
;1405:
;1406:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
;1407:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
;1408:				return qfalse;
;1409:			}
;1410:			continue;
;1411:		}
;1412:
;1413:		if (Q_stricmp(token.string, "shadowX") == 0) {
;1414:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
;1415:				return qfalse;
;1416:			}
;1417:			continue;
;1418:		}
;1419:
;1420:		if (Q_stricmp(token.string, "shadowY") == 0) {
;1421:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
;1422:				return qfalse;
;1423:			}
;1424:			continue;
;1425:		}
;1426:
;1427:		if (Q_stricmp(token.string, "shadowColor") == 0) {
;1428:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
;1429:				return qfalse;
;1430:			}
;1431:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
;1432:			continue;
;1433:		}
;1434:	}
;1435:	return qfalse;
;1436:}
;1437:
;1438:void CG_ParseMenu(const char *menuFile) {
;1439:	pc_token_t token;
;1440:	int handle;
;1441:
;1442:	handle = trap_PC_LoadSource(menuFile);
;1443:	if (!handle)
;1444:		handle = trap_PC_LoadSource("ui/testhud.menu");
;1445:	if (!handle)
;1446:		return;
;1447:
;1448:	while ( 1 ) {
;1449:		if (!trap_PC_ReadToken( handle, &token )) {
;1450:			break;
;1451:		}
;1452:
;1453:		//if ( Q_stricmp( token, "{" ) ) {
;1454:		//	Com_Printf( "Missing { in menu file\n" );
;1455:		//	break;
;1456:		//}
;1457:
;1458:		//if ( menuCount == MAX_MENUS ) {
;1459:		//	Com_Printf( "Too many menus!\n" );
;1460:		//	break;
;1461:		//}
;1462:
;1463:		if ( token.string[0] == '}' ) {
;1464:			break;
;1465:		}
;1466:
;1467:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
;1468:			if (CG_Asset_Parse(handle)) {
;1469:				continue;
;1470:			} else {
;1471:				break;
;1472:			}
;1473:		}
;1474:
;1475:
;1476:		if (Q_stricmp(token.string, "menudef") == 0) {
;1477:			// start a new menu
;1478:			Menu_New(handle);
;1479:		}
;1480:	}
;1481:	trap_PC_FreeSource(handle);
;1482:}
;1483:
;1484:qboolean CG_Load_Menu(char **p) {
;1485:	char *token;
;1486:
;1487:	token = COM_ParseExt(p, qtrue);
;1488:
;1489:	if (token[0] != '{') {
;1490:		return qfalse;
;1491:	}
;1492:
;1493:	while ( 1 ) {
;1494:
;1495:		token = COM_ParseExt(p, qtrue);
;1496:
;1497:		if (Q_stricmp(token, "}") == 0) {
;1498:			return qtrue;
;1499:		}
;1500:
;1501:		if ( !token || token[0] == 0 ) {
;1502:			return qfalse;
;1503:		}
;1504:
;1505:		CG_ParseMenu(token); 
;1506:	}
;1507:	return qfalse;
;1508:}
;1509:
;1510:
;1511:
;1512:void CG_LoadMenus(const char *menuFile) {
;1513:	char	*token;
;1514:	char *p;
;1515:	int	len, start;
;1516:	fileHandle_t	f;
;1517:	static char buf[MAX_MENUDEFFILE];
;1518:
;1519:	start = trap_Milliseconds();
;1520:
;1521:	len = trap_FS_FOpenFile( menuFile, &f, FS_READ );
;1522:	if ( !f ) {
;1523:		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;1524:		len = trap_FS_FOpenFile( "ui/hud.txt", &f, FS_READ );
;1525:		if (!f) {
;1526:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile ) );
;1527:		}
;1528:	}
;1529:
;1530:	if ( len >= MAX_MENUDEFFILE ) {
;1531:		trap_FS_FCloseFile( f );
;1532:		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE ) );
;1533:		return;
;1534:	}
;1535:
;1536:	trap_FS_Read( buf, len, f );
;1537:	buf[len] = 0;
;1538:	trap_FS_FCloseFile( f );
;1539:	
;1540:	COM_Compress(buf);
;1541:
;1542:	Menu_Reset();
;1543:
;1544:	p = buf;
;1545:
;1546:	while ( 1 ) {
;1547:		token = COM_ParseExt( &p, qtrue );
;1548:		if( !token || token[0] == 0 || token[0] == '}') {
;1549:			break;
;1550:		}
;1551:
;1552:		//if ( Q_stricmp( token, "{" ) ) {
;1553:		//	Com_Printf( "Missing { in menu file\n" );
;1554:		//	break;
;1555:		//}
;1556:
;1557:		//if ( menuCount == MAX_MENUS ) {
;1558:		//	Com_Printf( "Too many menus!\n" );
;1559:		//	break;
;1560:		//}
;1561:
;1562:		if ( Q_stricmp( token, "}" ) == 0 ) {
;1563:			break;
;1564:		}
;1565:
;1566:		if (Q_stricmp(token, "loadmenu") == 0) {
;1567:			if (CG_Load_Menu(&p)) {
;1568:				continue;
;1569:			} else {
;1570:				break;
;1571:			}
;1572:		}
;1573:	}
;1574:
;1575:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
;1576:
;1577:}
;1578:
;1579:
;1580:
;1581:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
;1582:	return qfalse;
;1583:}
;1584:
;1585:
;1586:static int CG_FeederCount(float feederID) {
;1587:	int i, count;
;1588:	count = 0;
;1589:	if (feederID == FEEDER_REDTEAM_LIST) {
;1590:		for (i = 0; i < cg.numScores; i++) {
;1591:			if (cg.scores[i].team == TEAM_RED) {
;1592:				count++;
;1593:			}
;1594:		}
;1595:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;1596:		for (i = 0; i < cg.numScores; i++) {
;1597:			if (cg.scores[i].team == TEAM_BLUE) {
;1598:				count++;
;1599:			}
;1600:		}
;1601:	} else if (feederID == FEEDER_SCOREBOARD) {
;1602:		return cg.numScores;
;1603:	}
;1604:	return count;
;1605:}
;1606:
;1607:
;1608:void CG_SetScoreSelection(void *p) {
;1609:	menuDef_t *menu = (menuDef_t*)p;
;1610:	playerState_t *ps = &cg.snap->ps;
;1611:	int i, red, blue;
;1612:	red = blue = 0;
;1613:	for (i = 0; i < cg.numScores; i++) {
;1614:		if (cg.scores[i].team == TEAM_RED) {
;1615:			red++;
;1616:		} else if (cg.scores[i].team == TEAM_BLUE) {
;1617:			blue++;
;1618:		}
;1619:		if (ps->clientNum == cg.scores[i].client) {
;1620:			cg.selectedScore = i;
;1621:		}
;1622:	}
;1623:
;1624:	if (menu == NULL) {
;1625:		// just interested in setting the selected score
;1626:		return;
;1627:	}
;1628:
;1629:	if ( cgs.gametype >= GT_TEAM ) {
;1630:		int feeder = FEEDER_REDTEAM_LIST;
;1631:		i = red;
;1632:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
;1633:			feeder = FEEDER_BLUETEAM_LIST;
;1634:			i = blue;
;1635:		}
;1636:		Menu_SetFeederSelection(menu, feeder, i, NULL);
;1637:	} else {
;1638:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
;1639:	}
;1640:}
;1641:
;1642:// FIXME: might need to cache this info
;1643:static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
;1644:	int i, count;
;1645:	if ( cgs.gametype >= GT_TEAM ) {
;1646:		count = 0;
;1647:		for (i = 0; i < cg.numScores; i++) {
;1648:			if (cg.scores[i].team == team) {
;1649:				if (count == index) {
;1650:					*scoreIndex = i;
;1651:					return &cgs.clientinfo[cg.scores[i].client];
;1652:				}
;1653:				count++;
;1654:			}
;1655:		}
;1656:	}
;1657:	*scoreIndex = index;
;1658:	return &cgs.clientinfo[ cg.scores[index].client ];
;1659:}
;1660:
;1661:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
;1662:	gitem_t *item;
;1663:	int scoreIndex = 0;
;1664:	clientInfo_t *info = NULL;
;1665:	int team = -1;
;1666:	score_t *sp = NULL;
;1667:
;1668:	*handle = -1;
;1669:
;1670:	if (feederID == FEEDER_REDTEAM_LIST) {
;1671:		team = TEAM_RED;
;1672:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;1673:		team = TEAM_BLUE;
;1674:	}
;1675:
;1676:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
;1677:	sp = &cg.scores[scoreIndex];
;1678:
;1679:	if (info && info->infoValid) {
;1680:		switch (column) {
;1681:			case 0:
;1682:				if ( info->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;1683:					item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1684:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1685:				} else if ( info->powerups & ( 1 << PW_REDFLAG ) ) {
;1686:					item = BG_FindItemForPowerup( PW_REDFLAG );
;1687:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1688:				} else if ( info->powerups & ( 1 << PW_BLUEFLAG ) ) {
;1689:					item = BG_FindItemForPowerup( PW_BLUEFLAG );
;1690:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1691:				} else {
;1692:					if ( info->botSkill > 0 && info->botSkill <= 5 ) {
;1693:						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
;1694:					} else if ( info->handicap < 100 ) {
;1695:					return va("%i", info->handicap );
;1696:					}
;1697:				}
;1698:			break;
;1699:			case 1:
;1700:				if (team == -1) {
;1701:					return "";
;1702:				} else {
;1703:					*handle = CG_StatusHandle(info->teamTask);
;1704:				}
;1705:		  break;
;1706:			case 2:
;1707:				if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << sp->client ) ) {
;1708:					return "Ready";
;1709:				}
;1710:				if (team == -1) {
;1711:					if (cgs.gametype == GT_TOURNAMENT) {
;1712:						return va("%i/%i", info->wins, info->losses);
;1713:					} else if (info->infoValid && info->team == TEAM_SPECTATOR ) {
;1714:						return "Spectator";
;1715:					} else {
;1716:						return "";
;1717:					}
;1718:				} else {
;1719:					if (info->teamLeader) {
;1720:						return "Leader";
;1721:					}
;1722:				}
;1723:			break;
;1724:			case 3:
;1725:				return info->name;
;1726:			break;
;1727:			case 4:
;1728:				return va("%i", info->score);
;1729:			break;
;1730:			case 5:
;1731:				return va("%4i", sp->time);
;1732:			break;
;1733:			case 6:
;1734:				if ( sp->ping == -1 ) {
;1735:					return "connecting";
;1736:				} 
;1737:				return va("%4i", sp->ping);
;1738:			break;
;1739:		}
;1740:	}
;1741:
;1742:	return "";
;1743:}
;1744:
;1745:static qhandle_t CG_FeederItemImage(float feederID, int index) {
;1746:	return 0;
;1747:}
;1748:
;1749:static void CG_FeederSelection(float feederID, int index) {
;1750:	if ( cgs.gametype >= GT_TEAM ) {
;1751:		int i, count;
;1752:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
;1753:		count = 0;
;1754:		for (i = 0; i < cg.numScores; i++) {
;1755:			if (cg.scores[i].team == team) {
;1756:				if (index == count) {
;1757:					cg.selectedScore = i;
;1758:				}
;1759:				count++;
;1760:			}
;1761:		}
;1762:	} else {
;1763:		cg.selectedScore = index;
;1764:	}
;1765:}
;1766:#endif
;1767:
;1768:#ifdef MISSIONPACK
;1769:static float CG_Cvar_Get(const char *cvar) {
;1770:	char buff[128];
;1771:	memset(buff, 0, sizeof(buff));
;1772:	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
;1773:	return atof(buff);
;1774:}
;1775:#endif
;1776:
;1777:#ifdef MISSIONPACK
;1778:void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
;1779:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
;1780:}
;1781:
;1782:static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
;1783:	switch (ownerDraw) {
;1784:	  case CG_GAME_TYPE:
;1785:			return CG_Text_Width(CG_GameTypeString(), scale, 0);
;1786:	  case CG_GAME_STATUS:
;1787:			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
;1788:			break;
;1789:	  case CG_KILLER:
;1790:			return CG_Text_Width(CG_GetKillerText(), scale, 0);
;1791:			break;
;1792:	  case CG_RED_NAME:
;1793:			return CG_Text_Width(cg_redTeamName.string, scale, 0);
;1794:			break;
;1795:	  case CG_BLUE_NAME:
;1796:			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
;1797:			break;
;1798:
;1799:
;1800:	}
;1801:	return 0;
;1802:}
;1803:
;1804:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
;1805:  return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
;1806:}
;1807:
;1808:static void CG_StopCinematic(int handle) {
;1809:  trap_CIN_StopCinematic(handle);
;1810:}
;1811:
;1812:static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
;1813:  trap_CIN_SetExtents(handle, x, y, w, h);
;1814:  trap_CIN_DrawCinematic(handle);
;1815:}
;1816:
;1817:static void CG_RunCinematicFrame(int handle) {
;1818:  trap_CIN_RunCinematic(handle);
;1819:}
;1820:
;1821:/*
;1822:=================
;1823:CG_LoadHudMenu();
;1824:
;1825:=================
;1826:*/
;1827:void CG_LoadHudMenu( void ) {
;1828:	char buff[1024];
;1829:	const char *hudSet;
;1830:
;1831:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
;1832:	cgDC.setColor = &trap_R_SetColor;
;1833:	cgDC.drawHandlePic = &CG_DrawPic;
;1834:	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
;1835:	cgDC.drawText = &CG_Text_Paint;
;1836:	cgDC.textWidth = &CG_Text_Width;
;1837:	cgDC.textHeight = &CG_Text_Height;
;1838:	cgDC.registerModel = &trap_R_RegisterModel;
;1839:	cgDC.modelBounds = &trap_R_ModelBounds;
;1840:	cgDC.fillRect = &CG_FillRect;
;1841:	cgDC.drawRect = &CG_DrawRect;   
;1842:	cgDC.drawSides = &CG_DrawSides;
;1843:	cgDC.drawTopBottom = &CG_DrawTopBottom;
;1844:	cgDC.clearScene = &trap_R_ClearScene;
;1845:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
;1846:	cgDC.renderScene = &trap_R_RenderScene;
;1847:	cgDC.registerFont = &trap_R_RegisterFont;
;1848:	cgDC.ownerDrawItem = &CG_OwnerDraw;
;1849:	cgDC.getValue = &CG_GetValue;
;1850:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
;1851:	cgDC.runScript = &CG_RunMenuScript;
;1852:	cgDC.getTeamColor = &CG_GetTeamColor;
;1853:	cgDC.setCVar = trap_Cvar_Set;
;1854:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
;1855:	cgDC.getCVarValue = CG_Cvar_Get;
;1856:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
;1857:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;1858:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;1859:	cgDC.startLocalSound = &trap_S_StartLocalSound;
;1860:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
;1861:	cgDC.feederCount = &CG_FeederCount;
;1862:	cgDC.feederItemImage = &CG_FeederItemImage;
;1863:	cgDC.feederItemText = &CG_FeederItemText;
;1864:	cgDC.feederSelection = &CG_FeederSelection;
;1865:	//cgDC.setBinding = &trap_Key_SetBinding;
;1866:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;1867:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;1868:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;1869:	cgDC.Error = &Com_Error; 
;1870:	cgDC.Print = &Com_Printf; 
;1871:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
;1872:	//cgDC.Pause = &CG_Pause;
;1873:	cgDC.registerSound = &trap_S_RegisterSound;
;1874:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
;1875:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
;1876:	cgDC.playCinematic = &CG_PlayCinematic;
;1877:	cgDC.stopCinematic = &CG_StopCinematic;
;1878:	cgDC.drawCinematic = &CG_DrawCinematic;
;1879:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
;1880:	
;1881:	Init_Display(&cgDC);
;1882:
;1883:	Menu_Reset();
;1884:	
;1885:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;1886:	hudSet = buff;
;1887:	if (hudSet[0] == '\0') {
;1888:		hudSet = "ui/hud.txt";
;1889:	}
;1890:
;1891:	CG_LoadMenus(hudSet);
;1892:}
;1893:
;1894:void CG_AssetCache( void ) {
;1895:	//if (Assets.textFont == NULL) {
;1896:	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
;1897:	//}
;1898:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;1899:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;1900:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
;1901:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
;1902:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
;1903:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
;1904:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
;1905:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
;1906:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
;1907:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
;1908:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
;1909:	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
;1910:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
;1911:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
;1912:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
;1913:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
;1914:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
;1915:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
;1916:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
;1917:}
;1918:#endif
;1919:/*
;1920:=================
;1921:CG_Init
;1922:
;1923:Called after every level change or subsystem restart
;1924:Will perform callbacks to make the loading info screen update.
;1925:=================
;1926:*/
;1927:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum ) {
line 1932
;1928:	char  value[MAX_CVAR_VALUE_STRING];
;1929:	const char	*s;
;1930:
;1931:	// clear everything
;1932:	memset( &cgs, 0, sizeof( cgs ) );
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 149844
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1933
;1933:	memset( &cg, 0, sizeof( cg ) );
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 149120
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1934
;1934:	memset( cg_entities, 0, sizeof(cg_entities) );
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 757760
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1935
;1935:	memset( cg_weapons, 0, sizeof(cg_weapons) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1936
;1936:	memset( cg_items, 0, sizeof(cg_items) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7168
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1938
;1937:
;1938:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 1940
;1939:
;1940:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31472
ADDRFP4 0
INDIRI4
ASGNI4
line 1941
;1941:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31468
ADDRFP4 4
INDIRI4
ASGNI4
line 1943
;1942:
;1943:	trap_Cvar_VariableStringBuffer( "//trap_GetValue", value, sizeof( value ) );
ADDRGP4 $1034
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1944
;1944:	if ( value[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1035
line 1946
;1945:#ifdef Q3_VM
;1946:		trap_GetValue = (void*)~atoi( value );
ADDRLP4 0
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
line 1947
;1947:		if ( trap_GetValue( value, sizeof( value ), "trap_R_AddRefEntityToScene2" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1039
ARGP4
ADDRLP4 264
ADDRGP4 trap_GetValue
INDIRP4
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $1037
line 1948
;1948:			trap_R_AddRefEntityToScene2 = (void*)~atoi( value );
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_R_AddRefEntityToScene2
ADDRLP4 268
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 1949
;1949:			intShaderTime = qtrue;
ADDRGP4 intShaderTime
CNSTI4 1
ASGNI4
line 1950
;1950:		}
LABELV $1037
line 1951
;1951:		if ( trap_GetValue( value, sizeof( value ), "trap_R_AddLinearLightToScene_Q3E" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1042
ARGP4
ADDRLP4 268
ADDRGP4 trap_GetValue
INDIRP4
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $1040
line 1952
;1952:			trap_R_AddLinearLightToScene = (void*)~atoi( value );
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_R_AddLinearLightToScene
ADDRLP4 272
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 1953
;1953:			linearLight = qtrue;
ADDRGP4 linearLight
CNSTI4 1
ASGNI4
line 1954
;1954:		}
LABELV $1040
line 1966
;1955:#else
;1956:		dll_com_trapGetValue = atoi( value );
;1957:		if ( trap_GetValue( value, sizeof( value ), "trap_R_AddRefEntityToScene2" ) ) {
;1958:			dll_trap_R_AddRefEntityToScene2 = atoi( value );
;1959:			intShaderTime = qtrue;
;1960:		}
;1961:		if ( trap_GetValue( value, sizeof( value ), "trap_R_AddLinearLightToScene_Q3E" ) ) {
;1962:			dll_trap_R_AddLinearLightToScene = atoi( value );
;1963:			linearLight = qtrue;
;1964:		}
;1965:#endif
;1966:	}
LABELV $1035
line 1969
;1967:
;1968:	// load a few needed things before we do any screen updates
;1969:	cgs.media.charsetShader		= trap_R_RegisterShader( "gfx/2d/bigchars" );
ADDRGP4 $1044
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752
ADDRLP4 260
INDIRI4
ASGNI4
line 1970
;1970:	cgs.media.whiteShader		= trap_R_RegisterShader( "white" );
ADDRGP4 $1047
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+148752+16
ADDRLP4 264
INDIRI4
ASGNI4
line 1971
;1971:	cgs.media.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
ADDRGP4 $1050
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+4
ADDRLP4 268
INDIRI4
ASGNI4
line 1972
;1972:	cgs.media.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
ADDRGP4 $1053
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+8
ADDRLP4 272
INDIRI4
ASGNI4
line 1973
;1973:	cgs.media.charsetPropB		= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );
ADDRGP4 $1056
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+148752+12
ADDRLP4 276
INDIRI4
ASGNI4
line 1975
;1974:
;1975:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 1977
;1976:
;1977:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 1979
;1978:
;1979:	cg.weaponSelect = WP_MACHINEGUN;
ADDRGP4 cg+108956
CNSTI4 2
ASGNI4
line 1981
;1980:
;1981:	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
ADDRLP4 280
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+34836
ADDRLP4 280
INDIRI4
ASGNI4
ADDRGP4 cgs+34832
ADDRLP4 280
INDIRI4
ASGNI4
line 1982
;1982:	cgs.flagStatus = -1;
ADDRGP4 cgs+34840
CNSTI4 -1
ASGNI4
line 1986
;1983:	// old servers
;1984:
;1985:	// get the rendering configuration from the client system
;1986:	trap_GetGlconfig( &cgs.glconfig );
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 1988
;1987:
;1988:	cgs.screenXBias = 0.0;
ADDRGP4 cgs+31444
CNSTF4 0
ASGNF4
line 1989
;1989:	cgs.screenYBias = 0.0;
ADDRGP4 cgs+31448
CNSTF4 0
ASGNF4
line 1991
;1990:	
;1991:	if ( cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640 ) {
ADDRGP4 cgs+20100+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 cgs+20100+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $1064
line 1993
;1992:		// wide screen, scale by height
;1993:		cgs.screenXScale = cgs.screenYScale = cgs.glconfig.vidHeight * (1.0/480.0);
ADDRLP4 284
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
ADDRGP4 cgs+31436
ADDRLP4 284
INDIRF4
ASGNF4
ADDRGP4 cgs+31432
ADDRLP4 284
INDIRF4
ASGNF4
line 1994
;1994:		cgs.screenXBias = 0.5 * ( cgs.glconfig.vidWidth - ( cgs.glconfig.vidHeight * (640.0/480.0) ) );
ADDRGP4 cgs+31444
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1995
;1995:	}
ADDRGP4 $1065
JUMPV
LABELV $1064
line 1996
;1996:	else {
line 1998
;1997:		// no wide screen, scale by width
;1998:		cgs.screenXScale = cgs.screenYScale = cgs.glconfig.vidWidth * (1.0/640.0);
ADDRLP4 284
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
ADDRGP4 cgs+31436
ADDRLP4 284
INDIRF4
ASGNF4
ADDRGP4 cgs+31432
ADDRLP4 284
INDIRF4
ASGNF4
line 1999
;1999:		cgs.screenYBias = 0.5 * ( cgs.glconfig.vidHeight - ( cgs.glconfig.vidWidth * (480.0/640.0) ) );
ADDRGP4 cgs+31448
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1061158912
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2000
;2000:	}
LABELV $1065
line 2002
;2001:
;2002:	cgs.screenXmin = 0.0 - (cgs.screenXBias / cgs.screenXScale);
ADDRGP4 cgs+31452
CNSTF4 0
ADDRGP4 cgs+31444
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
DIVF4
SUBF4
ASGNF4
line 2003
;2003:	cgs.screenXmax = 640.0 + (cgs.screenXBias / cgs.screenXScale);
ADDRGP4 cgs+31456
ADDRGP4 cgs+31444
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
DIVF4
CNSTF4 1142947840
ADDF4
ASGNF4
line 2005
;2004:
;2005:	cgs.screenYmin = 0.0 - (cgs.screenYBias / cgs.screenYScale);
ADDRGP4 cgs+31460
CNSTF4 0
ADDRGP4 cgs+31448
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
DIVF4
SUBF4
ASGNF4
line 2006
;2006:	cgs.screenYmax = 480.0 + (cgs.screenYBias / cgs.screenYScale);
ADDRGP4 cgs+31464
ADDRGP4 cgs+31448
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
DIVF4
CNSTF4 1139802112
ADDF4
ASGNF4
line 2008
;2007:
;2008:	cgs.cursorScaleR = 1.0 / cgs.screenXScale;
ADDRGP4 cgs+31440
CNSTF4 1065353216
ADDRGP4 cgs+31432
INDIRF4
DIVF4
ASGNF4
line 2009
;2009:	if ( cgs.cursorScaleR < 0.5 ) {
ADDRGP4 cgs+31440
INDIRF4
CNSTF4 1056964608
GEF4 $1102
line 2010
;2010:		cgs.cursorScaleR = 0.5;
ADDRGP4 cgs+31440
CNSTF4 1056964608
ASGNF4
line 2011
;2011:	}
LABELV $1102
line 2014
;2012:
;2013:#ifdef USE_NEW_FONT_RENDERER
;2014:	CG_LoadFonts();
ADDRGP4 CG_LoadFonts
CALLV
pop
line 2018
;2015:#endif
;2016:
;2017:	// get the gamestate from the client system
;2018:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 2021
;2019:
;2020:	// check version
;2021:	s = CG_ConfigString( CS_GAME_VERSION );
CNSTI4 20
ARGI4
ADDRLP4 284
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 256
ADDRLP4 284
INDIRP4
ASGNP4
line 2022
;2022:	if ( strstr( s, "defrag-" ) ) {
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 $1108
ARGP4
ADDRLP4 288
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 288
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1106
line 2023
;2023:		cgs.defrag = qtrue;
ADDRGP4 cgs+149820
CNSTI4 1
ASGNI4
line 2024
;2024:	} else if ( strcmp( s, GAME_VERSION ) ) {
ADDRGP4 $1107
JUMPV
LABELV $1106
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 $1112
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1110
line 2025
;2025:		CG_Error( "Client/Server game mismatch: %s/%s", GAME_VERSION, s );
ADDRGP4 $1113
ARGP4
ADDRGP4 $1112
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2026
;2026:	}
LABELV $1110
LABELV $1107
line 2028
;2027:
;2028:	cgs.ospEnc = atoi( CG_ConfigString( 872 ) ) & 1;
CNSTI4 872
ARGI4
ADDRLP4 296
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+149816
ADDRLP4 300
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 2030
;2029:
;2030:	s = CG_ConfigString( CS_LEVEL_START_TIME );
CNSTI4 21
ARGI4
ADDRLP4 304
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 256
ADDRLP4 304
INDIRP4
ASGNP4
line 2031
;2031:	cgs.levelStartTime = atoi( s );
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34820
ADDRLP4 308
INDIRI4
ASGNI4
line 2033
;2032:
;2033:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 2034
;2034:	CG_ParseSysteminfo();
ADDRGP4 CG_ParseSysteminfo
CALLV
pop
line 2037
;2035:
;2036:	// load the new map
;2037:	CG_LoadingString( "collision map" );
ADDRGP4 $1116
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2039
;2038:
;2039:	trap_CM_LoadMap( cgs.mapname );
ADDRGP4 cgs+31508
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 2042
;2040:
;2041:#if defined MISSIONPACK || defined NEOHUD
;2042:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 2045
;2043:#endif
;2044:
;2045:	cg.loading = qtrue;		// force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 2047
;2046:
;2047:	CG_LoadingString( "sounds" );
ADDRGP4 $1119
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2049
;2048:
;2049:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 2051
;2050:
;2051:	CG_LoadingString( "graphics" );
ADDRGP4 $1120
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2053
;2052:
;2053:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 2055
;2054:
;2055:	CG_LoadingString( "clients" );
ADDRGP4 $1121
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2057
;2056:
;2057:	CG_RegisterClients();	// if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 2065
;2058:
;2059:#ifdef MISSIONPACK
;2060:	CG_AssetCache();
;2061:	CG_LoadHudMenu();      	// load new hud stuff
;2062:#endif
;2063:
;2064:#ifdef NEOHUD
;2065:	CG_CheckHUD();			// full parse of selected HUD
ADDRGP4 CG_CheckHUD
CALLI4
pop
line 2068
;2066:#endif
;2067:
;2068:	cg.loading = qfalse;	// future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 2070
;2069:
;2070:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 2072
;2071:
;2072:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 2075
;2073:
;2074:	// remove the last loading update
;2075:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+109448
CNSTI1 0
ASGNI1
line 2080
;2076:
;2077:	// Make sure we have update values (scores)
;2078:	// CG_SetConfigValues();
;2079:
;2080:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 2082
;2081:
;2082:	CG_LoadingString( "" );
ADDRGP4 $205
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2088
;2083:
;2084:#ifdef MISSIONPACK
;2085:	CG_InitTeamChat();
;2086:#endif
;2087:
;2088:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 2090
;2089:
;2090:	trap_S_ClearLoopingSounds( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 2091
;2091:}
LABELV $1030
endproc CG_Init 312 12
export CG_Shutdown
proc CG_Shutdown 0 0
line 2101
;2092:
;2093:
;2094:/*
;2095:=================
;2096:CG_Shutdown
;2097:
;2098:Called before every level change or subsystem restart
;2099:=================
;2100:*/
;2101:void CG_Shutdown( void ) {
line 2104
;2102:	// some mods may need to do cleanup work here,
;2103:	// like closing files or archiving session data
;2104:}
LABELV $1124
endproc CG_Shutdown 0 0
export CG_EventHandling
proc CG_EventHandling 0 0
line 2118
;2105:
;2106:
;2107:/*
;2108:==================
;2109:CG_EventHandling
;2110:==================
;2111: type 0 - no event handling
;2112:      1 - team menu
;2113:      2 - scoreboard
;2114:      3 - hud editor
;2115:*/
;2116:#ifndef MISSIONPACK
;2117:void CG_EventHandling( cgame_event_t type ) 
;2118:{
line 2120
;2119:
;2120:}
LABELV $1125
endproc CG_EventHandling 0 0
export CG_SetScoreCatcher
proc CG_SetScoreCatcher 36 4
line 2124
;2121:
;2122:
;2123:void CG_SetScoreCatcher( qboolean enable )
;2124:{
line 2128
;2125:	int	currentCatcher, newCatcher, old_state, new_state;
;2126:	qboolean spectator;
;2127:
;2128:	currentCatcher = trap_Key_GetCatcher();
ADDRLP4 20
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 2130
;2129:
;2130:	if ( currentCatcher & KEYCATCH_CONSOLE || !cg.snap )
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1130
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1127
LABELV $1130
line 2131
;2131:		return;
ADDRGP4 $1126
JUMPV
LABELV $1127
line 2133
;2132:	
;2133:	spectator = cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR || cg.demoPlayback || ( cg.snap->ps.pm_flags & PMF_FOLLOW );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1138
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $1138
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1135
LABELV $1138
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $1136
JUMPV
LABELV $1135
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $1136
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 2135
;2134:
;2135:	if ( enable && spectator ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $1139
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1139
line 2136
;2136:		cgs.score_key = trap_Key_GetKey( "+scores" );
ADDRGP4 $1142
ARGP4
ADDRLP4 28
ADDRGP4 trap_Key_GetKey
CALLI4
ASGNI4
ADDRGP4 cgs+149832
ADDRLP4 28
INDIRI4
ASGNI4
line 2137
;2137:		cgs.score_catched = qtrue;
ADDRGP4 cgs+149828
CNSTI4 1
ASGNI4
line 2138
;2138:		newCatcher = currentCatcher | KEYCATCH_CGAME;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 2139
;2139:	} else {
ADDRGP4 $1140
JUMPV
LABELV $1139
line 2140
;2140:		cgs.score_catched = qfalse;
ADDRGP4 cgs+149828
CNSTI4 0
ASGNI4
line 2141
;2141:		newCatcher = currentCatcher & ~KEYCATCH_CGAME;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 2142
;2142:	}
LABELV $1140
line 2144
;2143:
;2144:	if ( newCatcher != currentCatcher ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $1145
line 2145
;2145:		if ( cgs.score_key ) {
ADDRGP4 cgs+149832
INDIRI4
CNSTI4 0
EQI4 $1147
line 2148
;2146:			// keycatcher change may cause reset of all pressed buttons on new engines
;2147:			// so track state of scoreboard key and ignore first upcoming keyup event for it
;2148:			old_state = trap_Key_IsDown( cgs.score_key );
ADDRGP4 cgs+149832
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 trap_Key_IsDown
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 2149
;2149:			trap_Key_SetCatcher( newCatcher );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 2150
;2150:			new_state = trap_Key_IsDown( cgs.score_key );
ADDRGP4 cgs+149832
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 trap_Key_IsDown
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 2151
;2151:			if ( new_state != old_state ) {
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1148
line 2152
;2152:				cgs.filterKeyUpEvent = qtrue;
ADDRGP4 cgs+149824
CNSTI4 1
ASGNI4
line 2153
;2153:			}
line 2154
;2154:		} else {
ADDRGP4 $1148
JUMPV
LABELV $1147
line 2155
;2155:			trap_Key_SetCatcher( newCatcher );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 2156
;2156:		}
LABELV $1148
line 2157
;2157:	}
LABELV $1145
line 2158
;2158:}
LABELV $1126
endproc CG_SetScoreCatcher 36 4
export CG_KeyEvent
proc CG_KeyEvent 0 4
line 2162
;2159:
;2160:
;2161:void CG_KeyEvent( int key, qboolean down ) 
;2162:{
line 2164
;2163:	// process scoreboard clicks etc.
;2164:	if ( cgs.score_catched && down ) 
ADDRGP4 cgs+149828
INDIRI4
CNSTI4 0
EQI4 $1156
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1156
line 2165
;2165:	{
line 2166
;2166:		if ( key == /*K_TAB*/ cgs.score_key )
ADDRFP4 0
INDIRI4
ADDRGP4 cgs+149832
INDIRI4
NEI4 $1159
line 2167
;2167:			return;
ADDRGP4 $1155
JUMPV
LABELV $1159
line 2168
;2168:		if ( key == /*K_MOUSE1*/178 )
ADDRFP4 0
INDIRI4
CNSTI4 178
NEI4 $1162
line 2169
;2169:			CG_ScoreboardClick();
ADDRGP4 CG_ScoreboardClick
CALLV
pop
ADDRGP4 $1163
JUMPV
LABELV $1162
line 2171
;2170:		else
;2171:			CG_SetScoreCatcher( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
LABELV $1163
line 2172
;2172:	}
LABELV $1156
line 2173
;2173:}
LABELV $1155
endproc CG_KeyEvent 0 4
export CG_MouseEvent
proc CG_MouseEvent 8 0
line 2177
;2174:
;2175:
;2176:void CG_MouseEvent( int x, int y )
;2177:{
line 2178
;2178:	cgs.cursorX += x * cgs.cursorScaleR;
ADDRLP4 0
ADDRGP4 cgs+149836
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31440
INDIRF4
MULF4
ADDF4
ASGNF4
line 2179
;2179:	cgs.cursorY += y * cgs.cursorScaleR;
ADDRLP4 4
ADDRGP4 cgs+149840
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31440
INDIRF4
MULF4
ADDF4
ASGNF4
line 2181
;2180:
;2181:	if ( cgs.cursorX < cgs.screenXmin ) {
ADDRGP4 cgs+149836
INDIRF4
ADDRGP4 cgs+31452
INDIRF4
GEF4 $1169
line 2182
;2182:		cgs.cursorX = cgs.screenXmin;
ADDRGP4 cgs+149836
ADDRGP4 cgs+31452
INDIRF4
ASGNF4
line 2183
;2183:	}
ADDRGP4 $1170
JUMPV
LABELV $1169
line 2184
;2184:	else if ( cgs.cursorX > cgs.screenXmax ) {
ADDRGP4 cgs+149836
INDIRF4
ADDRGP4 cgs+31456
INDIRF4
LEF4 $1175
line 2185
;2185:		cgs.cursorX = cgs.screenXmax;
ADDRGP4 cgs+149836
ADDRGP4 cgs+31456
INDIRF4
ASGNF4
line 2186
;2186:	}
LABELV $1175
LABELV $1170
line 2188
;2187:
;2188:	if ( cgs.cursorY < cgs.screenYmin ) {
ADDRGP4 cgs+149840
INDIRF4
ADDRGP4 cgs+31460
INDIRF4
GEF4 $1181
line 2189
;2189:		cgs.cursorY = cgs.screenYmin;
ADDRGP4 cgs+149840
ADDRGP4 cgs+31460
INDIRF4
ASGNF4
line 2190
;2190:	}
ADDRGP4 $1182
JUMPV
LABELV $1181
line 2191
;2191:	else if ( cgs.cursorY > cgs.screenYmax ) {
ADDRGP4 cgs+149840
INDIRF4
ADDRGP4 cgs+31464
INDIRF4
LEF4 $1187
line 2192
;2192:		cgs.cursorY = cgs.screenYmax;
ADDRGP4 cgs+149840
ADDRGP4 cgs+31464
INDIRF4
ASGNF4
line 2193
;2193:	}
LABELV $1187
LABELV $1182
line 2194
;2194:}
LABELV $1164
endproc CG_MouseEvent 8 0
bss
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
export trap_GetValue
align 4
LABELV trap_GetValue
skip 4
export trap_R_AddLinearLightToScene
align 4
LABELV trap_R_AddLinearLightToScene
skip 4
export trap_R_AddRefEntityToScene2
align 4
LABELV trap_R_AddRefEntityToScene2
skip 4
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
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
import eventnames
export cg_followKiller
align 4
LABELV cg_followKiller
skip 272
export cg_fovAdjust
align 4
LABELV cg_fovAdjust
skip 272
export cg_deadBodyDarken
align 4
LABELV cg_deadBodyDarken
skip 272
export cg_teamColors
align 4
LABELV cg_teamColors
skip 272
export cg_teamModel
align 4
LABELV cg_teamModel
skip 272
export cg_enemyColors
align 4
LABELV cg_enemyColors
skip 272
export cg_enemyModel
align 4
LABELV cg_enemyModel
skip 272
export cg_hitSounds
align 4
LABELV cg_hitSounds
skip 272
export cg_currentSelectedPlayer
align 4
LABELV cg_currentSelectedPlayer
skip 272
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_oldRail
align 4
LABELV cg_oldRail
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_cameraMode
align 4
LABELV cg_cameraMode
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_cameraOrbitDelay
align 4
LABELV cg_cameraOrbitDelay
skip 272
export cg_cameraOrbit
align 4
LABELV cg_cameraOrbit
skip 272
export cg_smoothClients
align 4
LABELV cg_smoothClients
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_noVoiceText
align 4
LABELV cg_noVoiceText
skip 272
export cg_noVoiceChats
align 4
LABELV cg_noVoiceChats
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_drawSpeed
align 4
LABELV cg_drawSpeed
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_drawPing
align 4
LABELV cg_drawPing
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_railTrailRadius
align 4
LABELV cg_railTrailRadius
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_drawWeaponSelect
align 4
LABELV cg_drawWeaponSelect
skip 272
export cg_teamOverlayUserinfo
align 4
LABELV cg_teamOverlayUserinfo
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 7168
export cg_weapons
align 4
LABELV cg_weapons
skip 2176
export cg_entities
align 4
LABELV cg_entities
skip 757760
export cg
align 4
LABELV cg
skip 149120
export cgs
align 4
LABELV cgs
skip 149844
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
LABELV $1142
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1121
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1120
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $1119
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1116
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1113
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1112
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1108
byte 1 100
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 45
byte 1 0
align 1
LABELV $1056
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1053
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1050
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1047
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1044
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1042
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 82
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 84
byte 1 111
byte 1 83
byte 1 99
byte 1 101
byte 1 110
byte 1 101
byte 1 95
byte 1 81
byte 1 51
byte 1 69
byte 1 0
align 1
LABELV $1039
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 82
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 82
byte 1 101
byte 1 102
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 84
byte 1 111
byte 1 83
byte 1 99
byte 1 101
byte 1 110
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1034
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
LABELV $1027
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1002
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $988
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $984
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $980
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $977
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 101
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $974
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $971
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $968
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $965
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $962
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $959
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $956
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $953
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $950
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 51
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $933
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $926
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $923
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $920
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $917
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $914
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $911
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $908
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $896
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 81
byte 1 76
byte 1 47
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $892
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 81
byte 1 76
byte 1 47
byte 1 116
byte 1 100
byte 1 109
byte 1 0
align 1
LABELV $885
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 81
byte 1 76
byte 1 47
byte 1 100
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $881
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 81
byte 1 76
byte 1 47
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $878
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $875
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $872
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $869
byte 1 109
byte 1 101
byte 1 100
byte 1 97
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
byte 1 0
align 1
LABELV $866
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $863
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $860
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $857
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $854
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $851
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $848
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $845
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $842
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $837
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $834
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $831
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $828
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $825
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $822
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $819
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $816
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $813
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $810
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $807
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $804
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $801
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $798
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $795
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $792
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $789
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $781
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $778
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $775
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $772
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 112
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $769
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 112
byte 1 111
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $766
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $762
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $758
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $755
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $751
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $747
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $744
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $741
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $733
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $730
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $727
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $724
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $716
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $713
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $710
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 105
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
LABELV $707
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $704
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $701
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $698
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $695
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $692
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $689
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $682
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $679
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $676
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $673
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $670
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $667
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $664
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $661
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $658
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $655
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $652
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $649
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $646
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $643
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $640
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $637
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $634
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $630
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $626
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $622
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $618
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $609
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $604
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $603
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $602
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $601
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $600
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $599
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $598
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $597
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $596
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $595
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $594
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $591
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $588
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $585
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
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $582
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
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $579
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
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $576
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $573
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $570
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $567
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $564
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $561
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
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $558
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
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $555
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
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $536
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $532
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $528
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $524
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $520
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $516
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $513
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
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $508
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $505
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $502
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $499
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $496
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $493
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $490
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $487
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $484
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $481
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $478
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $475
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $472
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $469
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $466
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 49
byte 1 48
byte 1 48
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $462
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 55
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $458
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 53
byte 1 48
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $454
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 50
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $451
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
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $448
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
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $445
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $442
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
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $439
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $436
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $433
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $430
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $427
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
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $424
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
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $421
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
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $418
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
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $415
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $412
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
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
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $409
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $406
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $403
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $400
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $397
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $394
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $391
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $388
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $380
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $377
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $374
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $371
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $368
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $363
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $360
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $357
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $354
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $351
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $348
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $345
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $337
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $334
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $331
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $328
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $325
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $322
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $319
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $316
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $313
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $310
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $307
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $303
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $297
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $226
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $225
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $224
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $217
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $211
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $210
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 65
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 66
byte 1 111
byte 1 100
byte 1 121
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $208
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $207
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $206
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $205
byte 1 0
align 1
LABELV $204
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $203
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $202
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $201
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $199
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $198
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $197
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $196
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $195
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $193
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $192
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $191
byte 1 99
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
LABELV $190
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $189
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $188
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $187
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $186
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $185
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
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $184
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
LABELV $183
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 95
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 99
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 100
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $181
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $180
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
LABELV $179
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $178
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
LABELV $177
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $172
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $171
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $169
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $168
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $167
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $166
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $164
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
LABELV $163
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
LABELV $162
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $161
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
LABELV $160
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $159
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $158
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $157
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $156
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $155
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $154
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $148
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $147
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $146
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $145
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $144
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $142
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $141
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $140
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $138
byte 1 51
byte 1 0
align 1
LABELV $137
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $135
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $133
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 82
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $132
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $129
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $128
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
LABELV $127
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $126
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $125
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
LABELV $124
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $123
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $121
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $120
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $119
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $118
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $117
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
LABELV $116
byte 1 52
byte 1 0
align 1
LABELV $115
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
LABELV $114
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $113
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $112
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $111
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $108
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $107
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $104
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $103
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $102
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $101
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
LABELV $100
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $99
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $98
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $97
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $96
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $93
byte 1 48
byte 1 0
align 1
LABELV $92
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $89
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
