export P_DamageFeedback
code
proc P_DamageFeedback 36 12
file "..\..\..\..\code\game\g_active.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:
;7:/*
;8:===============
;9:G_DamageFeedback
;10:
;11:Called just before a snapshot is sent to the given player.
;12:Totals up all damage and generates both the player_state_t
;13:damage values to that client for pain blends and kicks, and
;14:global pain sound events for all clients.
;15:===============
;16:*/
;17:void P_DamageFeedback( gentity_t *player ) {
line 22
;18:	gclient_t	*client;
;19:	float	count;
;20:	vec3_t	angles;
;21:
;22:	client = player->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 23
;23:	if ( client->ps.pm_type == PM_DEAD ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $55
line 24
;24:		return;
ADDRGP4 $54
JUMPV
LABELV $55
line 28
;25:	}
;26:
;27:	// total points of damage shot at the player this frame
;28:	count = client->damage_blood + client->damage_armor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 29
;29:	if ( count == 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $57
line 30
;30:		return;		// didn't take any damage
ADDRGP4 $54
JUMPV
LABELV $57
line 33
;31:	}
;32:
;33:	if ( count > 255 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
LEF4 $59
line 34
;34:		count = 255;
ADDRLP4 4
CNSTF4 1132396544
ASGNF4
line 35
;35:	}
LABELV $59
line 41
;36:
;37:	// send the information to the client
;38:
;39:	// world damage (falling, slime, etc) uses a special code
;40:	// to make the blend blob centered instead of positional
;41:	if ( client->damage_fromWorld ) {
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $61
line 42
;42:		client->ps.damagePitch = 255;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 255
ASGNI4
line 43
;43:		client->ps.damageYaw = 255;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 255
ASGNI4
line 45
;44:
;45:		client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 46
;46:	} else {
ADDRGP4 $62
JUMPV
LABELV $61
line 47
;47:		vectoangles( client->damage_from, angles );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 48
;48:		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 49
;49:		client->ps.damageYaw = angles[YAW]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 8+4
INDIRF4
CNSTF4 1060506465
MULF4
CVFI4 4
ASGNI4
line 50
;50:	}
LABELV $62
line 53
;51:
;52:	// play an appropriate pain sound
;53:	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
LEI4 $64
ADDRLP4 24
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $64
line 54
;54:		player->pain_debounce_time = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 55
;55:		G_AddEvent( player, EV_PAIN, player->health );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 56
;56:		client->ps.damageEvent++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 57
;57:	}
LABELV $64
line 60
;58:
;59:
;60:	client->ps.damageCount = count;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 65
;61:
;62:	//
;63:	// clear totals
;64:	//
;65:	client->damage_blood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTI4 0
ASGNI4
line 66
;66:	client->damage_armor = 0;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 67
;67:	client->damage_knockback = 0;
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
CNSTI4 0
ASGNI4
line 68
;68:}
LABELV $54
endproc P_DamageFeedback 36 12
export P_WorldEffects
proc P_WorldEffects 24 32
line 79
;69:
;70:
;71:
;72:/*
;73:=============
;74:P_WorldEffects
;75:
;76:Check for lava / slime contents and drowning
;77:=============
;78:*/
;79:void P_WorldEffects( gentity_t *ent ) {
line 83
;80:	qboolean	envirosuit;
;81:	int			waterlevel;
;82:
;83:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $69
line 84
;84:		ent->client->airOutTime = level.time + 12000;	// don't need air
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 85
;85:		return;
ADDRGP4 $68
JUMPV
LABELV $69
line 88
;86:	}
;87:
;88:	waterlevel = ent->waterlevel;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ASGNI4
line 90
;89:
;90:	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $74
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $75
JUMPV
LABELV $74
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $75
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 95
;91:
;92:	//
;93:	// check for drowning
;94:	//
;95:	if ( waterlevel == 3 ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $76
line 97
;96:		// envirosuit give air
;97:		if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $78
line 98
;98:			ent->client->airOutTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 99
;99:		}
LABELV $78
line 102
;100:
;101:		// if out of air, start drowning
;102:		if ( ent->client->airOutTime < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $77
line 104
;103:			// drown!
;104:			ent->client->airOutTime += 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 105
;105:			if ( ent->health > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $77
line 107
;106:				// take more damage the longer underwater
;107:				ent->damage += 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 108
;108:				if (ent->damage > 15)
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 15
LEI4 $86
line 109
;109:					ent->damage = 15;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 15
ASGNI4
LABELV $86
line 112
;110:
;111:				// don't play a normal pain sound
;112:				ent->pain_debounce_time = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 114
;113:
;114:				G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 14
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 116
;115:					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
;116:			}
line 117
;117:		}
line 118
;118:	} else {
ADDRGP4 $77
JUMPV
LABELV $76
line 119
;119:		ent->client->airOutTime = level.time + 12000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 120
;120:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 121
;121:	}
LABELV $77
line 126
;122:
;123:	//
;124:	// check for sizzle damage (move to pmove?)
;125:	//
;126:	if (waterlevel && 
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $90
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $90
line 127
;127:		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
line 128
;128:		if (ent->health > 0
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $92
ADDRLP4 12
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $92
line 129
;129:			&& ent->pain_debounce_time <= level.time	) {
line 131
;130:
;131:			if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $95
line 132
;132:				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 133
;133:			} else {
ADDRGP4 $96
JUMPV
LABELV $95
line 134
;134:				if (ent->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $97
line 135
;135:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 30
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 137
;136:						30*waterlevel, 0, MOD_LAVA);
;137:				}
LABELV $97
line 139
;138:
;139:				if (ent->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $99
line 140
;140:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 15
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 142
;141:						10*waterlevel, 0, MOD_SLIME);
;142:				}
LABELV $99
line 143
;143:			}
LABELV $96
line 144
;144:		}
LABELV $92
line 145
;145:	}
LABELV $90
line 146
;146:}
LABELV $68
endproc P_WorldEffects 24 32
export G_SetClientSound
proc G_SetClientSound 4 0
line 155
;147:
;148:
;149:
;150:/*
;151:===============
;152:G_SetClientSound
;153:===============
;154:*/
;155:void G_SetClientSound( gentity_t *ent ) {
line 162
;156:#ifdef MISSIONPACK
;157:	if( ent->s.eFlags & EF_TICKING ) {
;158:		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
;159:	}
;160:	else
;161:#endif
;162:	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $102
line 163
;163:		ent->client->ps.loopSound = level.snd_fry;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 level+352
INDIRI4
ASGNI4
line 164
;164:	} else {
ADDRGP4 $103
JUMPV
LABELV $102
line 165
;165:		ent->client->ps.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 166
;166:	}
LABELV $103
line 167
;167:}
LABELV $101
endproc G_SetClientSound 4 0
export ClientImpacts
proc ClientImpacts 76 12
line 178
;168:
;169:
;170:
;171://==============================================================
;172:
;173:/*
;174:==============
;175:ClientImpacts
;176:==============
;177:*/
;178:void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
line 183
;179:	int		i, j;
;180:	trace_t	trace;
;181:	gentity_t	*other;
;182:
;183:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 184
;184:	for (i=0 ; i<pm->numtouch ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $106
line 185
;185:		for (j=0 ; j<i ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $113
JUMPV
LABELV $110
line 186
;186:			if (pm->touchents[j] == pm->touchents[i] ) {
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
NEI4 $114
line 187
;187:				break;
ADDRGP4 $112
JUMPV
LABELV $114
line 189
;188:			}
;189:		}
LABELV $111
line 185
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $113
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $110
LABELV $112
line 190
;190:		if (j != i) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $116
line 191
;191:			continue;	// duplicated
ADDRGP4 $107
JUMPV
LABELV $116
line 193
;192:		}
;193:		other = &g_entities[ pm->touchents[i] ];
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 195
;194:
;195:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $118
ADDRLP4 68
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $118
line 196
;196:			ent->touch( ent, other, &trace );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 197
;197:		}
LABELV $118
line 199
;198:
;199:		if ( !other->touch ) {
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $120
line 200
;200:			continue;
ADDRGP4 $107
JUMPV
LABELV $120
line 203
;201:		}
;202:
;203:		other->touch( other, ent, &trace );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 204
;204:	}
LABELV $107
line 184
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $109
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LTI4 $106
line 206
;205:
;206:}
LABELV $105
endproc ClientImpacts 76 12
data
align 4
LABELV $123
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
export G_TouchTriggers
code
proc G_TouchTriggers 4224 16
line 216
;207:
;208:/*
;209:============
;210:G_TouchTriggers
;211:
;212:Find all trigger entities that ent's current position touches.
;213:Spectators will only interact with teleporters.
;214:============
;215:*/
;216:void	G_TouchTriggers( gentity_t *ent ) {
line 224
;217:	int			i, num;
;218:	int			touch[MAX_GENTITIES];
;219:	gentity_t	*hit;
;220:	trace_t		trace;
;221:	vec3_t		mins, maxs;
;222:	static vec3_t	range = { 40, 40, 52 };
;223:
;224:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $124
line 225
;225:		return;
ADDRGP4 $122
JUMPV
LABELV $124
line 229
;226:	}
;227:
;228:	// dead clients don't activate triggers!
;229:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $126
line 230
;230:		return;
ADDRGP4 $122
JUMPV
LABELV $126
line 233
;231:	}
;232:
;233:	VectorSubtract( ent->client->ps.origin, range, mins );
ADDRLP4 4188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $123
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4188
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $123+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $123+8
INDIRF4
SUBF4
ASGNF4
line 234
;234:	VectorAdd( ent->client->ps.origin, range, maxs );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $123
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4192
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $123+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $123+8
INDIRF4
ADDF4
ASGNF4
line 236
;235:
;236:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4196
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4196
INDIRI4
ASGNI4
line 239
;237:
;238:	// can't use ent->absmin, because that has a one unit pad
;239:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 4200
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4200
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4204
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4204
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 240
;240:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 242
;241:
;242:	for ( i=0 ; i<num ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $143
JUMPV
LABELV $140
line 243
;243:		hit = &g_entities[touch[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 92
ADDP4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 245
;244:
;245:		if ( !hit->touch && !ent->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $144
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $144
line 246
;246:			continue;
ADDRGP4 $141
JUMPV
LABELV $144
line 248
;247:		}
;248:		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $146
line 249
;249:			continue;
ADDRGP4 $141
JUMPV
LABELV $146
line 253
;250:		}
;251:
;252:		// ignore most entities if a spectator
;253:		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $148
line 254
;254:			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $150
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 Touch_DoorTrigger
CVPU4 4
EQU4 $150
line 257
;255:				// this is ugly but adding a new ET_? type will
;256:				// most likely cause network incompatibilities
;257:				hit->touch != Touch_DoorTrigger) {
line 258
;258:				continue;
ADDRGP4 $141
JUMPV
LABELV $150
line 260
;259:			}
;260:		}
LABELV $148
line 264
;261:
;262:		// use separate code for determining if an item is picked up
;263:		// so you don't have to actually contact its bounding box
;264:		if ( hit->s.eType == ET_ITEM ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $152
line 265
;265:			if ( !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 4216
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $153
line 266
;266:				continue;
ADDRGP4 $141
JUMPV
line 268
;267:			}
;268:		} else {
LABELV $152
line 269
;269:			if ( !trap_EntityContact( mins, maxs, hit ) ) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4216
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $157
line 270
;270:				continue;
ADDRGP4 $141
JUMPV
LABELV $157
line 272
;271:			}
;272:		}
LABELV $153
line 274
;273:
;274:		memset( &trace, 0, sizeof(trace) );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 276
;275:
;276:		if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $159
line 277
;277:			hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 278
;278:		}
LABELV $159
line 280
;279:
;280:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $161
ADDRLP4 4216
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $161
line 281
;281:			ent->touch( ent, hit, &trace );
ADDRLP4 4220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4220
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 282
;282:		}
LABELV $161
line 283
;283:	}
LABELV $141
line 242
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $143
ADDRLP4 4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $140
line 286
;284:
;285:	// if we didn't touch a jump pad this pmove frame
;286:	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 4216
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
EQI4 $163
line 287
;287:		ent->client->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 288
;288:		ent->client->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 289
;289:	}
LABELV $163
line 290
;290:}
LABELV $122
endproc G_TouchTriggers 4224 16
export SpectatorThink
proc SpectatorThink 236 12
line 297
;291:
;292:/*
;293:=================
;294:SpectatorThink
;295:=================
;296:*/
;297:void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
line 301
;298:	pmove_t	pm;
;299:	gclient_t	*client;
;300:
;301:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 303
;302:
;303:	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
EQI4 $166
line 304
;304:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 305
;305:		client->ps.speed = g_speed.value * 1.25f; // faster than normal
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CNSTF4 1067450368
MULF4
CVFI4 4
ASGNI4
line 308
;306:
;307:		// set up for pmove
;308:		memset( &pm, 0, sizeof( pm ) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 224
ARGI4
ADDRGP4 memset
CALLP4
pop
line 309
;309:		pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 310
;310:		pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 24
line 311
;311:		if ( client->noclip )
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $170
line 312
;312:			pm.tracemask = 0;
ADDRLP4 4+28
CNSTI4 0
ASGNI4
ADDRGP4 $171
JUMPV
LABELV $170
line 314
;313:		else
;314:			pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
LABELV $171
line 315
;315:		pm.trace = trap_Trace;
ADDRLP4 4+216
ADDRGP4 trap_Trace
ASGNP4
line 316
;316:		pm.pointcontents = trap_PointContents;
ADDRLP4 4+220
ADDRGP4 trap_PointContents
ASGNP4
line 319
;317:
;318:		// perform a pmove
;319:		Pmove( &pm );
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 321
;320:		// save results of pmove
;321:		VectorCopy( client->ps.origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 323
;322:
;323:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 324
;324:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 325
;325:	}
LABELV $166
line 327
;326:
;327:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 328
;328:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 331
;329:
;330:	// attack button cycles through spectators
;331:	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $176
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $176
line 332
;332:		Cmd_FollowCycle_f( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 333
;333:	}
LABELV $176
line 334
;334:}
LABELV $165
endproc SpectatorThink 236 12
export ClientInactivityTimer
proc ClientInactivityTimer 8 8
line 345
;335:
;336:
;337:
;338:/*
;339:=================
;340:ClientInactivityTimer
;341:
;342:Returns qfalse if the client is dropped
;343:=================
;344:*/
;345:qboolean ClientInactivityTimer( gclient_t *client ) {
line 346
;346:	if ( ! g_inactivity.integer ) {
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 0
NEI4 $179
line 349
;347:		// give everyone some time, so if the operator sets g_inactivity during
;348:		// gameplay, everyone isn't kicked
;349:		client->inactivityTime = level.time + 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 60000
ADDI4
ASGNI4
line 350
;350:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 0
ASGNI4
line 351
;351:	} else if ( client->pers.cmd.forwardmove || 
ADDRGP4 $180
JUMPV
LABELV $179
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 493
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $187
ADDRLP4 0
INDIRP4
CNSTI4 494
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $187
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $187
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $183
LABELV $187
line 354
;352:		client->pers.cmd.rightmove || 
;353:		client->pers.cmd.upmove ||
;354:		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
line 355
;355:		client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 356
;356:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 0
ASGNI4
line 357
;357:	} else if ( !client->pers.localClient ) {
ADDRGP4 $184
JUMPV
LABELV $183
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $190
line 358
;358:		if ( level.time > client->inactivityTime ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
LEI4 $192
line 359
;359:			trap_DropClient( client - level.clients, "Dropped due to inactivity" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1568
DIVI4
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 360
;360:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $178
JUMPV
LABELV $192
line 362
;361:		}
;362:		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $196
ADDRLP4 4
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CNSTI4 0
NEI4 $196
line 363
;363:			client->inactivityWarning = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
CNSTI4 1
ASGNI4
line 364
;364:			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1568
DIVI4
ARGI4
ADDRGP4 $199
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 365
;365:		}
LABELV $196
line 366
;366:	}
LABELV $190
LABELV $184
LABELV $180
line 367
;367:	return qtrue;
CNSTI4 1
RETI4
LABELV $178
endproc ClientInactivityTimer 8 8
export ClientTimerActions
proc ClientTimerActions 20 12
line 377
;368:}
;369:
;370:/*
;371:==================
;372:ClientTimerActions
;373:
;374:Actions that happen once a second
;375:==================
;376:*/
;377:void ClientTimerActions( gentity_t *ent, int msec ) {
line 383
;378:	gclient_t	*client;
;379:#ifdef MISSIONPACK
;380:	int			maxHealth;
;381:#endif
;382:
;383:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 384
;384:	client->timeResidual += msec;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $202
JUMPV
LABELV $201
line 386
;385:
;386:	while ( client->timeResidual >= 1000 ) {
line 387
;387:		client->timeResidual -= 1000;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 415
;388:
;389:		// regenerate
;390:#ifdef MISSIONPACK
;391:		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;392:			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
;393:		}
;394:		else if ( client->ps.powerups[PW_REGEN] ) {
;395:			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
;396:		}
;397:		else {
;398:			maxHealth = 0;
;399:		}
;400:		if( maxHealth ) {
;401:			if ( ent->health < maxHealth ) {
;402:				ent->health += 15;
;403:				if ( ent->health > maxHealth * 1.1 ) {
;404:					ent->health = maxHealth * 1.1;
;405:				}
;406:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;407:			} else if ( ent->health < maxHealth * 2) {
;408:				ent->health += 5;
;409:				if ( ent->health > maxHealth * 2 ) {
;410:					ent->health = maxHealth * 2;
;411:				}
;412:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;413:			}
;414:#else
;415:		if ( client->ps.powerups[PW_REGEN] ) {
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $204
line 416
;416:			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
GEI4 $206
line 417
;417:				ent->health += 15;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 418
;418:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
LEF4 $208
line 419
;419:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ASGNI4
line 420
;420:				}
LABELV $208
line 421
;421:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 422
;422:			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
ADDRGP4 $205
JUMPV
LABELV $206
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $205
line 423
;423:				ent->health += 5;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 424
;424:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $212
line 425
;425:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 426
;426:				}
LABELV $212
line 427
;427:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 428
;428:			}
line 430
;429:#endif
;430:		} else {
ADDRGP4 $205
JUMPV
LABELV $204
line 432
;431:			// count down health when over max
;432:			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $214
line 433
;433:				ent->health--;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 434
;434:			}
LABELV $214
line 435
;435:		}
LABELV $205
line 438
;436:
;437:		// count down armor when over max
;438:		if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $216
line 439
;439:			client->ps.stats[STAT_ARMOR]--;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 440
;440:		}
LABELV $216
line 441
;441:	}
LABELV $202
line 386
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $201
line 480
;442:#ifdef MISSIONPACK
;443:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;444:		int w, max, inc, t, i;
;445:    int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
;446:    int weapCount = ARRAY_LEN( weapList );
;447:		//
;448:    for (i = 0; i < weapCount; i++) {
;449:		  w = weapList[i];
;450:
;451:		  switch(w) {
;452:			  case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
;453:			  case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
;454:			  case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
;455:			  case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
;456:			  case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
;457:			  case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
;458:			  case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
;459:			  case WP_BFG: max = 10; inc = 1; t = 4000; break;
;460:			  case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
;461:			  case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
;462:			  case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
;463:			  default: max = 0; inc = 0; t = 1000; break;
;464:		  }
;465:		  client->ammoTimes[w] += msec;
;466:		  if ( client->ps.ammo[w] >= max ) {
;467:			  client->ammoTimes[w] = 0;
;468:		  }
;469:		  if ( client->ammoTimes[w] >= t ) {
;470:			  while ( client->ammoTimes[w] >= t )
;471:				  client->ammoTimes[w] -= t;
;472:			  client->ps.ammo[w] += inc;
;473:			  if ( client->ps.ammo[w] > max ) {
;474:				  client->ps.ammo[w] = max;
;475:			  }
;476:		  }
;477:    }
;478:	}
;479:#endif
;480:}
LABELV $200
endproc ClientTimerActions 20 12
export ClientIntermissionThink
proc ClientIntermissionThink 20 0
line 487
;481:
;482:/*
;483:====================
;484:ClientIntermissionThink
;485:====================
;486:*/
;487:void ClientIntermissionThink( gclient_t *client ) {
line 488
;488:	client->ps.eFlags &= ~EF_TALK;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 489
;489:	client->ps.eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 494
;490:
;491:	// the level will exit when everyone wants to or after timeouts
;492:
;493:	// swap and latch button actions
;494:	client->oldbuttons = client->buttons;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 495
;495:	client->buttons = client->pers.cmd.buttons;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 664
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ASGNI4
line 496
;496:	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 16
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
BXORI4
BANDI4
CNSTI4 0
EQI4 $219
line 498
;497:		// this used to be an ^1 but once a player says ready, it should stick
;498:		client->readyToExit = 1;
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTI4 1
ASGNI4
line 499
;499:	}
LABELV $219
line 500
;500:}
LABELV $218
endproc ClientIntermissionThink 20 0
export ClientEvents
proc ClientEvents 68 32
line 511
;501:
;502:
;503:/*
;504:================
;505:ClientEvents
;506:
;507:Events will be passed on to the clients for presentation,
;508:but any server game effects are handled here
;509:================
;510:*/
;511:void ClientEvents( gentity_t *ent, int oldEventSequence ) {
line 521
;512:	int		i, j;
;513:	int		event;
;514:	gclient_t *client;
;515:	int		damage;
;516:	vec3_t	origin, angles;
;517://	qboolean	fired;
;518:	gitem_t *item;
;519:	gentity_t *drop;
;520:
;521:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 523
;522:
;523:	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $222
line 524
;524:		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 525
;525:	}
LABELV $222
line 526
;526:	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $227
JUMPV
LABELV $224
line 527
;527:		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 529
;528:
;529:		switch ( event ) {
ADDRLP4 4
INDIRI4
CNSTI4 11
EQI4 $230
ADDRLP4 4
INDIRI4
CNSTI4 12
EQI4 $230
ADDRLP4 4
INDIRI4
CNSTI4 11
LTI4 $229
LABELV $253
ADDRLP4 4
INDIRI4
CNSTI4 23
EQI4 $239
ADDRLP4 4
INDIRI4
CNSTI4 25
EQI4 $240
ADDRLP4 4
INDIRI4
CNSTI4 26
EQI4 $252
ADDRGP4 $229
JUMPV
LABELV $230
line 532
;530:		case EV_FALL_MEDIUM:
;531:		case EV_FALL_FAR:
;532:			if ( ent->s.eType != ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $231
line 533
;533:				break;		// not in the player model
ADDRGP4 $229
JUMPV
LABELV $231
line 535
;534:			}
;535:			if ( g_dmflags.integer & DF_NO_FALLING ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $233
line 536
;536:				break;
ADDRGP4 $229
JUMPV
LABELV $233
line 538
;537:			}
;538:			if ( event == EV_FALL_FAR ) {
ADDRLP4 4
INDIRI4
CNSTI4 12
NEI4 $236
line 539
;539:				damage = 10;
ADDRLP4 24
CNSTI4 10
ASGNI4
line 540
;540:			} else {
ADDRGP4 $237
JUMPV
LABELV $236
line 541
;541:				damage = 5;
ADDRLP4 24
CNSTI4 5
ASGNI4
line 542
;542:			}
LABELV $237
line 543
;543:			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 544
;544:			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 545
;545:			break;
ADDRGP4 $229
JUMPV
LABELV $239
line 548
;546:
;547:		case EV_FIRE_WEAPON:
;548:			FireWeapon( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FireWeapon
CALLV
pop
line 549
;549:			break;
ADDRGP4 $229
JUMPV
LABELV $240
line 553
;550:
;551:		case EV_USE_ITEM1:		// teleporter
;552:			// drop flags in CTF
;553:			item = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 554
;554:			j = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 556
;555:
;556:			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $241
line 557
;557:				item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 60
INDIRP4
ASGNP4
line 558
;558:				j = PW_REDFLAG;
ADDRLP4 16
CNSTI4 7
ASGNI4
line 559
;559:			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $242
JUMPV
LABELV $241
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $243
line 560
;560:				item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 60
INDIRP4
ASGNP4
line 561
;561:				j = PW_BLUEFLAG;
ADDRLP4 16
CNSTI4 8
ASGNI4
line 562
;562:			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $244
JUMPV
LABELV $243
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $245
line 563
;563:				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 60
INDIRP4
ASGNP4
line 564
;564:				j = PW_NEUTRALFLAG;
ADDRLP4 16
CNSTI4 9
ASGNI4
line 565
;565:			}
LABELV $245
LABELV $244
LABELV $242
line 567
;566:
;567:			if ( item ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $247
line 568
;568:				drop = Drop_Item( ent, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 60
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 60
INDIRP4
ASGNP4
line 570
;569:				// decide how many seconds it has left
;570:				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 571
;571:				if ( drop->count < 1 ) {
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $250
line 572
;572:					drop->count = 1;
ADDRLP4 20
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 573
;573:				}
LABELV $250
line 575
;574:				// for pickup prediction
;575:				drop->s.time2 = drop->count;
ADDRLP4 64
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 577
;576:
;577:				ent->client->ps.powerups[ j ] = 0;
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 578
;578:			}
LABELV $247
line 602
;579:
;580:#ifdef MISSIONPACK
;581:			if ( g_gametype.integer == GT_HARVESTER ) {
;582:				if ( ent->client->ps.generic1 > 0 ) {
;583:					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;584:						item = BG_FindItem( "Blue Cube" );
;585:					} else {
;586:						item = BG_FindItem( "Red Cube" );
;587:					}
;588:					if ( item ) {
;589:						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
;590:							drop = Drop_Item( ent, item, 0 );
;591:							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;592:								drop->spawnflags = TEAM_BLUE;
;593:							} else {
;594:								drop->spawnflags = TEAM_RED;
;595:							}
;596:						}
;597:					}
;598:					ent->client->ps.generic1 = 0;
;599:				}
;600:			}
;601:#endif
;602:			SelectSpawnPoint( ent, ent->client->ps.origin, origin, angles );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 603
;603:			TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 604
;604:			break;
ADDRGP4 $229
JUMPV
LABELV $252
line 607
;605:
;606:		case EV_USE_ITEM2:		// medkit
;607:			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 609
;608:
;609:			break;
line 633
;610:
;611:#ifdef MISSIONPACK
;612:		case EV_USE_ITEM3:		// kamikaze
;613:			// make sure the invulnerability is off
;614:			ent->client->invulnerabilityTime = 0;
;615:			// start the kamikze
;616:			G_StartKamikaze( ent );
;617:			break;
;618:
;619:		case EV_USE_ITEM4:		// portal
;620:			if( ent->client->portalID ) {
;621:				DropPortalSource( ent );
;622:			}
;623:			else {
;624:				DropPortalDestination( ent );
;625:			}
;626:			break;
;627:		case EV_USE_ITEM5:		// invulnerability
;628:			ent->client->invulnerabilityTime = level.time + 10000;
;629:			break;
;630:#endif
;631:
;632:		default:
;633:			break;
LABELV $229
line 635
;634:		}
;635:	}
LABELV $225
line 526
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $227
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $224
line 637
;636:
;637:}
LABELV $221
endproc ClientEvents 68 32
export SendPendingPredictableEvents
proc SendPendingPredictableEvents 40 12
line 689
;638:
;639:#ifdef MISSIONPACK
;640:/*
;641:==============
;642:StuckInOtherClient
;643:==============
;644:*/
;645:static int StuckInOtherClient(gentity_t *ent) {
;646:	int i;
;647:	gentity_t	*ent2;
;648:
;649:	ent2 = &g_entities[0];
;650:	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
;651:		if ( ent2 == ent ) {
;652:			continue;
;653:		}
;654:		if ( !ent2->inuse ) {
;655:			continue;
;656:		}
;657:		if ( !ent2->client ) {
;658:			continue;
;659:		}
;660:		if ( ent2->health <= 0 ) {
;661:			continue;
;662:		}
;663:		//
;664:		if (ent2->r.absmin[0] > ent->r.absmax[0])
;665:			continue;
;666:		if (ent2->r.absmin[1] > ent->r.absmax[1])
;667:			continue;
;668:		if (ent2->r.absmin[2] > ent->r.absmax[2])
;669:			continue;
;670:		if (ent2->r.absmax[0] < ent->r.absmin[0])
;671:			continue;
;672:		if (ent2->r.absmax[1] < ent->r.absmin[1])
;673:			continue;
;674:		if (ent2->r.absmax[2] < ent->r.absmin[2])
;675:			continue;
;676:		return qtrue;
;677:	}
;678:	return qfalse;
;679:}
;680:#endif
;681:
;682:void BotTestSolid(vec3_t origin);
;683:
;684:/*
;685:==============
;686:SendPendingPredictableEvents
;687:==============
;688:*/
;689:void SendPendingPredictableEvents( playerState_t *ps ) {
line 695
;690:	gentity_t *t;
;691:	int event, seq;
;692:	int extEvent, number;
;693:
;694:	// if there are still events pending
;695:	if ( ps->entityEventSequence < ps->eventSequence ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $255
line 698
;696:		// create a temporary entity for this event which is sent to everyone
;697:		// except the client who generated the event
;698:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 699
;699:		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 8
LSHI4
BORI4
ASGNI4
line 701
;700:		// set external event to zero before calling BG_PlayerStateToEntityState
;701:		extEvent = ps->externalEvent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 702
;702:		ps->externalEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 704
;703:		// create temporary entity for event
;704:		t = G_TempEntity( ps->origin, event );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 705
;705:		number = t->s.number;
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 706
;706:		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 707
;707:		t->s.number = number;
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 708
;708:		t->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 709
;709:		t->s.eFlags |= EF_PLAYER_EVENT;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 710
;710:		t->s.otherEntityNum = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 712
;711:		// send to everyone except the client who generated the event
;712:		t->r.svFlags |= SVF_NOTSINGLECLIENT;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 713
;713:		t->r.singleClient = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 715
;714:		// set back external event
;715:		ps->externalEvent = extEvent;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 716
;716:	}
LABELV $255
line 717
;717:}
LABELV $254
endproc SendPendingPredictableEvents 40 12
export ClientThink_real
proc ClientThink_real 288 12
line 730
;718:
;719:/*
;720:==============
;721:ClientThink
;722:
;723:This will be called once for each client frame, which will
;724:usually be a couple times for each server frame on fast clients.
;725:
;726:If "g_synchronousClients 1" is set, this will be called exactly
;727:once for each server frame, which makes for smooth demo recording.
;728:==============
;729:*/
;730:void ClientThink_real( gentity_t *ent ) {
line 737
;731:	gclient_t	*client;
;732:	pmove_t		pm;
;733:	int			oldEventSequence;
;734:	int			msec;
;735:	usercmd_t	*ucmd;
;736:
;737:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 740
;738:
;739:	// don't think if the client is not yet connected (and thus not yet spawned in)
;740:	if (client->pers.connected != CON_CONNECTED) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $258
line 741
;741:		return;
ADDRGP4 $257
JUMPV
LABELV $258
line 744
;742:	}
;743:	// mark the time, so the connection sprite can be removed
;744:	ucmd = &ent->client->pers.cmd;
ADDRLP4 228
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
line 747
;745:
;746:	// sanity check the command time to prevent speedup cheating
;747:	if ( ucmd->serverTime > level.time + 200 ) {
ADDRLP4 228
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
LEI4 $260
line 748
;748:		ucmd->serverTime = level.time + 200;
ADDRLP4 228
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 750
;749://		G_Printf("serverTime <<<<<\n" );
;750:	} else
ADDRGP4 $261
JUMPV
LABELV $260
line 751
;751:	if ( ucmd->serverTime < level.time - 1000 ) {
ADDRLP4 228
INDIRP4
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $264
line 752
;752:		ucmd->serverTime = level.time - 1000;
ADDRLP4 228
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 754
;753://		G_Printf("serverTime >>>>>\n" );
;754:	}
LABELV $264
LABELV $261
line 757
;755:
;756:	// unlagged
;757:	client->frameOffset = trap_Milliseconds() - level.frameStartTime;
ADDRLP4 240
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1548
ADDP4
ADDRLP4 240
INDIRI4
ADDRGP4 level+11800
INDIRI4
SUBI4
ASGNI4
line 758
;758:	client->lastCmdTime = ucmd->serverTime;
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
ADDRLP4 228
INDIRP4
INDIRI4
ASGNI4
line 759
;759:	client->lastUpdateFrame = level.framenum;
ADDRLP4 0
INDIRP4
CNSTI4 1552
ADDP4
ADDRGP4 level+28
INDIRI4
ASGNI4
line 761
;760:
;761:	msec = ucmd->serverTime - client->ps.commandTime;
ADDRLP4 232
ADDRLP4 228
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 764
;762:	// following others may result in bad times, but we still want
;763:	// to check for follow toggles
;764:	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 232
INDIRI4
CNSTI4 1
GEI4 $270
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
EQI4 $270
line 765
;765:		return;
ADDRGP4 $257
JUMPV
LABELV $270
line 767
;766:	}
;767:	if ( msec > 200 ) {
ADDRLP4 232
INDIRI4
CNSTI4 200
LEI4 $272
line 768
;768:		msec = 200;
ADDRLP4 232
CNSTI4 200
ASGNI4
line 769
;769:	}
LABELV $272
line 771
;770:
;771:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $274
line 772
;772:		trap_Cvar_Set( "pmove_msec", "8" );
ADDRGP4 $277
ARGP4
ADDRGP4 $278
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 773
;773:		trap_Cvar_Update( &pmove_msec );
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 774
;774:	} else if ( pmove_msec.integer > 33 ) {
ADDRGP4 $275
JUMPV
LABELV $274
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $279
line 775
;775:		trap_Cvar_Set( "pmove_msec", "33" );
ADDRGP4 $277
ARGP4
ADDRGP4 $282
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 776
;776:		trap_Cvar_Update( &pmove_msec );
ADDRGP4 pmove_msec
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 777
;777:	}
LABELV $279
LABELV $275
line 779
;778:
;779:	if ( pmove_fixed.integer ) {
ADDRGP4 pmove_fixed+12
INDIRI4
CNSTI4 0
EQI4 $283
line 780
;780:		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 783
;781:		//if (ucmd->serverTime - client->ps.commandTime <= 0)
;782:		//	return;
;783:	}
LABELV $283
line 788
;784:
;785:	//
;786:	// check for exiting intermission
;787:	//
;788:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $289
line 789
;789:		ClientIntermissionThink( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 790
;790:		return;
ADDRGP4 $257
JUMPV
LABELV $289
line 794
;791:	}
;792:
;793:	// spectators don't do much
;794:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $292
line 795
;795:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
NEI4 $294
line 796
;796:			return;
ADDRGP4 $257
JUMPV
LABELV $294
line 798
;797:		}
;798:		SpectatorThink( ent, ucmd );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 228
INDIRP4
ARGP4
ADDRGP4 SpectatorThink
CALLV
pop
line 799
;799:		return;
ADDRGP4 $257
JUMPV
LABELV $292
line 803
;800:	}
;801:
;802:	// check for inactivity timer, but never drop the local client of a non-dedicated server
;803:	if ( !ClientInactivityTimer( client ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 244
ADDRGP4 ClientInactivityTimer
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
NEI4 $296
line 804
;804:		return;
ADDRGP4 $257
JUMPV
LABELV $296
line 808
;805:	}
;806:
;807:	// clear the rewards if time
;808:	if ( level.time > client->rewardTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
LEI4 $298
line 809
;809:		client->ps.eFlags &= ~EF_AWARDS;
ADDRLP4 248
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 248
INDIRP4
ADDRLP4 248
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 810
;810:	}
LABELV $298
line 812
;811:
;812:	if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $301
line 813
;813:		client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 814
;814:	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 $302
JUMPV
LABELV $301
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $303
line 815
;815:		client->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 816
;816:	} else {
ADDRGP4 $304
JUMPV
LABELV $303
line 817
;817:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 818
;818:	}
LABELV $304
LABELV $302
line 820
;819:
;820:	client->ps.gravity = g_gravity.value;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRGP4 g_gravity+8
INDIRF4
CVFI4 4
ASGNI4
line 823
;821:
;822:	// set speed
;823:	client->ps.speed = g_speed.value;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CVFI4 4
ASGNI4
line 831
;824:
;825:#ifdef MISSIONPACK
;826:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;827:		client->ps.speed *= 1.5;
;828:	}
;829:	else
;830:#endif
;831:	if ( client->ps.powerups[PW_HASTE] ) {
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $307
line 832
;832:		client->ps.speed *= 1.3;
ADDRLP4 248
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 248
INDIRP4
ADDRLP4 248
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1067869798
MULF4
CVFI4 4
ASGNI4
line 833
;833:	}
LABELV $307
line 836
;834:
;835:	// Let go of the hook if we aren't firing
;836:	if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $309
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $309
ADDRLP4 228
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $309
line 837
;837:		client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
line 838
;838:		Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 839
;839:	}
LABELV $309
line 842
;840:
;841:	// set up for pmove
;842:	oldEventSequence = client->ps.eventSequence;
ADDRLP4 236
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 844
;843:
;844:	memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 224
ARGI4
ADDRGP4 memset
CALLP4
pop
line 848
;845:
;846:	// check for the hit-scan gauntlet, don't let the action
;847:	// go through as an attack unless it actually hits something
;848:	if ( client->ps.weapon == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $311
ADDRLP4 228
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $311
ADDRLP4 228
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $311
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
GTI4 $311
line 849
;849:		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
line 850
;850:		pm.gauntletHit = CheckGauntletAttack( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+36
ADDRLP4 260
INDIRI4
ASGNI4
line 851
;851:	}
LABELV $311
line 853
;852:
;853:	if ( ent->flags & FL_FORCE_GESTURE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $314
line 854
;854:		ent->flags &= ~FL_FORCE_GESTURE;
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 855
;855:		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 264
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 264
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 856
;856:	}
LABELV $314
line 885
;857:
;858:#ifdef MISSIONPACK
;859:	// check for invulnerability expansion before doing the Pmove
;860:	if (client->ps.powerups[PW_INVULNERABILITY] ) {
;861:		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
;862:			vec3_t mins = { -42, -42, -42 };
;863:			vec3_t maxs = { 42, 42, 42 };
;864:			vec3_t oldmins, oldmaxs;
;865:
;866:			VectorCopy (ent->r.mins, oldmins);
;867:			VectorCopy (ent->r.maxs, oldmaxs);
;868:			// expand
;869:			VectorCopy (mins, ent->r.mins);
;870:			VectorCopy (maxs, ent->r.maxs);
;871:			trap_LinkEntity(ent);
;872:			// check if this would get anyone stuck in this player
;873:			if ( !StuckInOtherClient(ent) ) {
;874:				// set flag so the expanded size will be set in PM_CheckDuck
;875:				client->ps.pm_flags |= PMF_INVULEXPAND;
;876:			}
;877:			// set back
;878:			VectorCopy (oldmins, ent->r.mins);
;879:			VectorCopy (oldmaxs, ent->r.maxs);
;880:			trap_LinkEntity(ent);
;881:		}
;882:	}
;883:#endif
;884:
;885:	pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 886
;886:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 228
INDIRP4
INDIRB
ASGNB 24
line 887
;887:	if ( pm.ps->pm_type == PM_DEAD ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $317
line 888
;888:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 889
;889:	}
ADDRGP4 $318
JUMPV
LABELV $317
line 890
;890:	else if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $320
line 891
;891:		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
ADDRLP4 4+28
CNSTI4 37814273
ASGNI4
line 892
;892:	}
ADDRGP4 $321
JUMPV
LABELV $320
line 893
;893:	else {
line 894
;894:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 895
;895:	}
LABELV $321
LABELV $318
line 896
;896:	pm.trace = trap_Trace;
ADDRLP4 4+216
ADDRGP4 trap_Trace
ASGNP4
line 897
;897:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+220
ADDRGP4 trap_PointContents
ASGNP4
line 898
;898:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 900
;899:
;900:	pm.pmove_fixed = pmove_fixed.integer;
ADDRLP4 4+208
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 901
;901:	pm.pmove_msec = pmove_msec.integer;
ADDRLP4 4+212
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 903
;902:
;903:	VectorCopy( client->ps.origin, client->oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 920
;904:
;905:#ifdef MISSIONPACK
;906:		if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
;907:			if ( level.time - level.intermissionQueued >= 1000  ) {
;908:				pm.cmd.buttons = 0;
;909:				pm.cmd.forwardmove = 0;
;910:				pm.cmd.rightmove = 0;
;911:				pm.cmd.upmove = 0;
;912:				if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
;913:					trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
;914:				}
;915:				ent->client->ps.pm_type = PM_SPINTERMISSION;
;916:			}
;917:		}
;918:		Pmove (&pm);
;919:#else
;920:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 924
;921:#endif
;922:
;923:	// save results of pmove
;924:	if ( ent->client->ps.eventSequence != oldEventSequence ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 236
INDIRI4
EQI4 $332
line 925
;925:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 926
;926:	}
LABELV $332
line 928
;927:
;928:	BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 264
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 930
;929:
;930:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 932
;931:
;932:	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $335
line 933
;933:		client->fireHeld = qfalse;		// for grapple
ADDRLP4 0
INDIRP4
CNSTI4 764
ADDP4
CNSTI4 0
ASGNI4
line 934
;934:	}
LABELV $335
line 937
;935:
;936:	// use the snapped origin for linking so it matches client predicted versions
;937:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 268
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 939
;938:
;939:	VectorCopy (pm.mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+176
INDIRB
ASGNB 12
line 940
;940:	VectorCopy (pm.maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+188
INDIRB
ASGNB 12
line 942
;941:
;942:	ent->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 4+204
INDIRI4
ASGNI4
line 943
;943:	ent->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 4+200
INDIRI4
ASGNI4
line 946
;944:
;945:	// execute client events
;946:	ClientEvents( ent, oldEventSequence );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 236
INDIRI4
ARGI4
ADDRGP4 ClientEvents
CALLV
pop
line 949
;947:
;948:	// link entity now, after any personal teleporters have been used
;949:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 950
;950:	if ( !ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
NEI4 $341
line 951
;951:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 952
;952:	}
LABELV $341
line 955
;953:
;954:	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
;955:	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 272
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 958
;956:
;957:	//test for solid areas in the AAS file
;958:	BotTestAAS(ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BotTestAAS
CALLV
pop
line 961
;959:
;960:	// touch other objects
;961:	ClientImpacts( ent, &pm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 964
;962:
;963:	// save results of triggers and client events
;964:	if (ent->client->ps.eventSequence != oldEventSequence) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 236
INDIRI4
EQI4 $343
line 965
;965:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 966
;966:	}
LABELV $343
line 969
;967:
;968:	// swap and latch button actions
;969:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ASGNI4
line 970
;970:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
ADDRLP4 228
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 971
;971:	client->latched_buttons |= client->buttons & ~client->oldbuttons;
ADDRLP4 284
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 664
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRI4
BCOMI4
BANDI4
BORI4
ASGNI4
line 974
;972:
;973:	// check for respawning
;974:	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $346
line 976
;975:		// wait for the attack button to be pressed
;976:		if ( level.time > client->respawnTime ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
LEI4 $257
line 978
;977:			// forcerespawn is to prevent users from waiting out powerups
;978:			if ( g_forcerespawn.integer > 0 && 
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 0
LEI4 $351
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
SUBI4
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 1000
MULI4
LEI4 $351
line 979
;979:				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
line 980
;980:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 981
;981:				return;
ADDRGP4 $257
JUMPV
LABELV $351
line 985
;982:			}
;983:		
;984:			// pressing attack or use is the normal respawn method
;985:			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
ADDRLP4 228
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
EQI4 $257
line 986
;986:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 987
;987:			}
line 988
;988:		}
line 989
;989:		return;
ADDRGP4 $257
JUMPV
LABELV $346
line 993
;990:	}
;991:
;992:	// perform once-a-second actions
;993:	ClientTimerActions( ent, msec );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
INDIRI4
ARGI4
ADDRGP4 ClientTimerActions
CALLV
pop
line 994
;994:}
LABELV $257
endproc ClientThink_real 288 12
export ClientThink
proc ClientThink 4 8
line 1004
;995:
;996:
;997:/*
;998:==================
;999:ClientThink
;1000:
;1001:A new command has arrived from the client
;1002:==================
;1003:*/
;1004:void ClientThink( int clientNum ) {
line 1007
;1005:	gentity_t *ent;
;1006:
;1007:	ent = g_entities + clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1008
;1008:	trap_GetUsercmd( clientNum, &ent->client->pers.cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1016
;1009:
;1010:	// mark the time we got info, so we can display the
;1011:	// phone jack if they don't get any for a while
;1012:#if 0 // unlagged
;1013:	ent->client->lastCmdTime = level.time;
;1014:#endif
;1015:
;1016:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $359
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $359
line 1017
;1017:		ClientThink_real( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1018
;1018:	}
LABELV $359
line 1019
;1019:}
LABELV $358
endproc ClientThink 4 8
export G_RunClient
proc G_RunClient 0 4
line 1022
;1020:
;1021:
;1022:void G_RunClient( gentity_t *ent ) {
line 1023
;1023:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $363
ADDRGP4 g_synchronousClients+12
INDIRI4
CNSTI4 0
NEI4 $363
line 1024
;1024:		return;
ADDRGP4 $362
JUMPV
LABELV $363
line 1026
;1025:	}
;1026:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1027
;1027:	ClientThink_real( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientThink_real
CALLV
pop
line 1028
;1028:}
LABELV $362
endproc G_RunClient 0 4
export SpectatorClientEndFrame
proc SpectatorClientEndFrame 20 4
line 1037
;1029:
;1030:
;1031:/*
;1032:==================
;1033:SpectatorClientEndFrame
;1034:
;1035:==================
;1036:*/
;1037:void SpectatorClientEndFrame( gentity_t *ent ) {
line 1041
;1038:	gclient_t	*cl;
;1039:
;1040:	// if we are doing a chase cam or a remote view, grab the latest info
;1041:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 2
NEI4 $368
line 1044
;1042:		int		clientNum, flags;
;1043:
;1044:		clientNum = ent->client->sess.spectatorClient;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ASGNI4
line 1047
;1045:
;1046:		// team follow1 and team follow2 go to whatever clients are playing
;1047:		if ( clientNum == -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $370
line 1048
;1048:			clientNum = level.follow1;
ADDRLP4 4
ADDRGP4 level+344
INDIRI4
ASGNI4
line 1049
;1049:		} else if ( clientNum == -2 ) {
ADDRGP4 $371
JUMPV
LABELV $370
ADDRLP4 4
INDIRI4
CNSTI4 -2
NEI4 $373
line 1050
;1050:			clientNum = level.follow2;
ADDRLP4 4
ADDRGP4 level+348
INDIRI4
ASGNI4
line 1051
;1051:		}
LABELV $373
LABELV $371
line 1052
;1052:		if ( (unsigned)clientNum < MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 64
GEU4 $376
line 1053
;1053:			cl = &level.clients[ clientNum ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1054
;1054:			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $378
ADDRLP4 12
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $378
line 1055
;1055:				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -540673
BANDI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 540672
BANDI4
BORI4
ASGNI4
line 1056
;1056:				ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 468
line 1057
;1057:				ent->client->ps.pm_flags |= PMF_FOLLOW;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1058
;1058:				ent->client->ps.eFlags = flags;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1059
;1059:				return;
ADDRGP4 $367
JUMPV
LABELV $378
line 1060
;1060:			} else {
line 1062
;1061:				// drop them to free spectators unless they are dedicated camera followers
;1062:				if ( ent->client->sess.spectatorClient >= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
CNSTI4 0
LTI4 $380
line 1063
;1063:					ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
CNSTI4 1
ASGNI4
line 1064
;1064:					ClientBegin( ent->client - level.clients );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1568
DIVI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 1065
;1065:				}
LABELV $380
line 1066
;1066:			}
line 1067
;1067:		}
LABELV $376
line 1068
;1068:	}
LABELV $368
line 1070
;1069:
;1070:	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 3
NEI4 $382
line 1071
;1071:		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1072
;1072:	} else {
ADDRGP4 $383
JUMPV
LABELV $382
line 1073
;1073:		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1074
;1074:	}
LABELV $383
line 1075
;1075:}
LABELV $367
endproc SpectatorClientEndFrame 20 4
bss
align 4
LABELV $385
skip 816
export ClientEndFrame
code
proc ClientEndFrame 40 12
line 1087
;1076:
;1077:
;1078:/*
;1079:==============
;1080:ClientEndFrame
;1081:
;1082:Called at the end of each server frame for each connected client
;1083:A fast client will have multiple ClientThink for each ClientEdFrame,
;1084:while a slow client may have multiple ClientEndFrame between ClientThink.
;1085:==============
;1086:*/
;1087:void ClientEndFrame( gentity_t *ent ) {
line 1094
;1088:	static gentity_t sent;
;1089:	int			i;
;1090:	gclient_t	*client;
;1091:	// unlagged
;1092:	int			frames;
;1093:
;1094:	if ( !ent->client )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $386
line 1095
;1095:		return;
ADDRGP4 $384
JUMPV
LABELV $386
line 1097
;1096:
;1097:	ent->r.svFlags &= ~svf_self_portal2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRGP4 svf_self_portal2
INDIRI4
BCOMI4
BANDI4
ASGNI4
line 1099
;1098:
;1099:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $388
line 1100
;1100:		SpectatorClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpectatorClientEndFrame
CALLV
pop
line 1101
;1101:		return;
ADDRGP4 $384
JUMPV
LABELV $388
line 1104
;1102:	}
;1103:
;1104:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1107
;1105:
;1106:	// turn off any expired powerups
;1107:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $390
line 1108
;1108:		if ( client->ps.powerups[ i ] < client->pers.cmd.serverTime ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
GEI4 $394
line 1109
;1109:			client->ps.powerups[ i ] = 0;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1110
;1110:		}
LABELV $394
line 1111
;1111:	}
LABELV $391
line 1107
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $390
line 1144
;1112:
;1113:#ifdef MISSIONPACK
;1114:	// set powerup for player animation
;1115:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;1116:		ent->client->ps.powerups[PW_GUARD] = level.time;
;1117:	}
;1118:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;1119:		ent->client->ps.powerups[PW_SCOUT] = level.time;
;1120:	}
;1121:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
;1122:		ent->client->ps.powerups[PW_DOUBLER] = level.time;
;1123:	}
;1124:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;1125:		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
;1126:	}
;1127:	if ( ent->client->invulnerabilityTime > level.time ) {
;1128:		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
;1129:	}
;1130:#endif
;1131:
;1132:	// save network bandwidth
;1133:#if 0
;1134:	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
;1135:		// FIXME: this must change eventually for non-sync demo recording
;1136:		VectorClear( ent->client->ps.viewangles );
;1137:	}
;1138:#endif
;1139:
;1140:	//
;1141:	// If the end of unit layout is displayed, don't give
;1142:	// the player any normal movement attributes
;1143:	//
;1144:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $396
line 1145
;1145:		client->ps.commandTime = client->pers.cmd.serverTime;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
ASGNI4
line 1146
;1146:		return;
ADDRGP4 $384
JUMPV
LABELV $396
line 1150
;1147:	}
;1148:
;1149:	// burn from lava, etc
;1150:	P_WorldEffects (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_WorldEffects
CALLV
pop
line 1153
;1151:
;1152:	// apply all the damage taken this frame
;1153:	P_DamageFeedback (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_DamageFeedback
CALLV
pop
line 1155
;1154:
;1155:	client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1157
;1156:
;1157:	G_SetClientSound( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetClientSound
CALLV
pop
line 1160
;1158:
;1159:	// set the latest info
;1160:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1162
;1161:
;1162:	SendPendingPredictableEvents( &client->ps );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1164
;1163:
;1164:	client->ps.eFlags &= ~EF_CONNECTION;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1165
;1165:	ent->s.eFlags &= ~EF_CONNECTION;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1167
;1166:
;1167:	frames = level.framenum - client->lastUpdateFrame - 1;
ADDRLP4 8
ADDRGP4 level+28
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1552
ADDP4
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1170
;1168:
;1169:	// PVS prediction
;1170:	if ( g_predictPVS.integer && svf_self_portal2 ) {
ADDRGP4 g_predictPVS+12
INDIRI4
CNSTI4 0
EQI4 $400
ADDRGP4 svf_self_portal2
INDIRI4
CNSTI4 0
EQI4 $400
line 1172
;1171:		int lag;
;1172:		sent.s = ent->s;
ADDRGP4 $385
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 1173
;1173:		sent.r = ent->r;
ADDRGP4 $385+208
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRB
ASGNB 308
line 1174
;1174:		sent.clipmask = ent->clipmask;
ADDRGP4 $385+572
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 1177
;1175:		//VectorCopy( client->ps.origin, sent.s.pos.trBase );
;1176:		//VectorCopy( client->ps.velocity, sent.s.pos.trDelta );
;1177:		lag = level.time - client->ps.commandTime + 50;
ADDRLP4 24
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
CNSTI4 50
ADDI4
ASGNI4
line 1178
;1178:		if ( lag > 500 )
ADDRLP4 24
INDIRI4
CNSTI4 500
LEI4 $406
line 1179
;1179:			lag = 500;
ADDRLP4 24
CNSTI4 500
ASGNI4
LABELV $406
line 1180
;1180:		G_PredictPlayerMove( &sent, (float)lag * 0.001f );
ADDRGP4 $385
ARGP4
ADDRLP4 24
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1181
;1181:		VectorCopy( sent.s.pos.trBase, ent->r.unused.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDRGP4 $385+12+12
INDIRB
ASGNB 12
line 1182
;1182:		ent->r.unused.origin2[2] += client->ps.viewheight;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1183
;1183:		ent->r.svFlags |= svf_self_portal2;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRGP4 svf_self_portal2
INDIRI4
BORI4
ASGNI4
line 1184
;1184:	}
LABELV $400
line 1186
;1185:
;1186:	if ( frames > 2 ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LEI4 $410
line 1188
;1187:		// limit lagged player prediction to 2 server frames
;1188:		frames = 2;
ADDRLP4 8
CNSTI4 2
ASGNI4
line 1190
;1189:		// and add the EF_CONNECTION flag if we haven't gotten commands recently
;1190:		if ( !( ent->r.svFlags & SVF_BOT ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $412
line 1191
;1191:			client->ps.eFlags |= EF_CONNECTION;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1192
;1192:			ent->s.eFlags |= EF_CONNECTION;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1193
;1193:		}
LABELV $412
line 1194
;1194:	}
LABELV $410
line 1196
;1195:
;1196:	if ( frames > 0 && g_smoothClients.integer ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $414
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 0
EQI4 $414
line 1197
;1197:		G_PredictPlayerMove( ent, (float)frames / sv_fps.value );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 sv_fps+8
INDIRF4
DIVF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1198
;1198:		SnapVector( ent->s.pos.trBase );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1199
;1199:	}
LABELV $414
line 1202
;1200:
;1201:	// unlagged
;1202:	G_StoreHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StoreHistory
CALLV
pop
line 1205
;1203:
;1204:	// hitsounds
;1205:	if ( client->damage.enemy && client->damage.amount ) {
ADDRLP4 0
INDIRP4
CNSTI4 1560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $418
ADDRLP4 0
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $418
line 1206
;1206:		client->ps.persistant[PERS_HITS] += client->damage.enemy;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1560
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1207
;1207:		client->damage.enemy = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1560
ADDP4
CNSTI4 0
ASGNI4
line 1209
;1208:		// scale damage by max.health
;1209:		i = client->damage.amount * 100 / client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1211
;1210:		// avoid high-byte setup
;1211:		if ( i > 255 )
ADDRLP4 4
INDIRI4
CNSTI4 255
LEI4 $420
line 1212
;1212:			i = 255;
ADDRLP4 4
CNSTI4 255
ASGNI4
LABELV $420
line 1213
;1213:		client->ps.persistant[PERS_ATTACKEE_ARMOR] = i;
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1214
;1214:		client->damage.amount = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1564
ADDP4
CNSTI4 0
ASGNI4
line 1215
;1215:	} else if ( client->damage.team ) {
ADDRGP4 $419
JUMPV
LABELV $418
ADDRLP4 0
INDIRP4
CNSTI4 1556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $422
line 1216
;1216:		client->ps.persistant[PERS_HITS] -= client->damage.team;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1556
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1217
;1217:		client->damage.team = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1556
ADDP4
CNSTI4 0
ASGNI4
line 1218
;1218:	}
LABELV $422
LABELV $419
line 1223
;1219:
;1220:	// set the bit for the reachability area the client is currently in
;1221://	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
;1222://	ent->client->areabits[i >> 3] |= 1 << (i & 7);
;1223:}
LABELV $384
endproc ClientEndFrame 40 12
import BotTestSolid
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
LABELV $282
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $278
byte 1 56
byte 1 0
align 1
LABELV $277
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
LABELV $199
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 32
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
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $195
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
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
