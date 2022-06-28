export ScorePlum
code
proc ScorePlum 12 8
file "..\..\..\..\code\game\g_combat.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_combat.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:/*
;9:============
;10:ScorePlum
;11:============
;12:*/
;13:void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
line 16
;14:	gentity_t *plum;
;15:
;16:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 65
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 18
;17:	// only send this temp entity to a single client
;18:	plum->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 19
;19:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 21
;20:	//
;21:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 22
;22:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 23
;23:}
LABELV $54
endproc ScorePlum 12 8
export AddScore
proc AddScore 4 12
line 32
;24:
;25:/*
;26:============
;27:AddScore
;28:
;29:Adds score to both the client and his team
;30:============
;31:*/
;32:void AddScore( gentity_t *ent, vec3_t origin, int score ) {
line 33
;33:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $56
line 34
;34:		return;
ADDRGP4 $55
JUMPV
LABELV $56
line 37
;35:	}
;36:	// no scoring during pre-match warmup
;37:	if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $58
line 38
;38:		return;
ADDRGP4 $55
JUMPV
LABELV $58
line 41
;39:	}
;40:	// show score plum
;41:	ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 43
;42:	//
;43:	ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 44
;44:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $61
line 45
;45:		AddTeamScore( origin, ent->client->ps.persistant[PERS_TEAM], score );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 46
;46:	}
LABELV $61
line 47
;47:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 48
;48:}
LABELV $55
endproc AddScore 4 12
export TossClientItems
proc TossClientItems 40 12
line 57
;49:
;50:/*
;51:=================
;52:TossClientItems
;53:
;54:Toss the weapon and powerups for the killed player
;55:=================
;56:*/
;57:void TossClientItems( gentity_t *self ) {
line 65
;58:	gitem_t		*item;
;59:	int			weapon;
;60:	float		angle;
;61:	int			i;
;62:	gentity_t	*drop;
;63:
;64:	// drop the weapon if not a gauntlet or machinegun
;65:	weapon = self->s.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 71
;66:
;67:	// make a special check to see if they are changing to a new
;68:	// weapon that isn't the mg or gauntlet.  Without this, a client
;69:	// can pick up a weapon, be killed, and not drop the weapon because
;70:	// their weapon change hasn't completed yet and they are still holding the MG.
;71:	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $67
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $65
LABELV $67
line 72
;72:		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $68
line 73
;73:			weapon = self->client->pers.cmd.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 74
;74:		}
LABELV $68
line 75
;75:		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $70
line 76
;76:			weapon = WP_NONE;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 77
;77:		}
LABELV $70
line 78
;78:	}
LABELV $65
line 80
;79:
;80:	if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK && 
ADDRLP4 12
INDIRI4
CNSTI4 2
LEI4 $72
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $72
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $72
line 81
;81:		self->client->ps.ammo[ weapon ] ) {
line 83
;82:		// find the item type for this weapon
;83:		item = BG_FindItemForWeapon( weapon );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 86
;84:
;85:		// spawn the item
;86:		drop = Drop_Item( self, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 32
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 89
;87:
;88:		// for pickup prediction
;89:		drop->s.time2 = item->quantity;
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 90
;90:	}
LABELV $72
line 93
;91:
;92:	// drop all the powerups if not in teamplay
;93:	if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $74
line 94
;94:		angle = 45;
ADDRLP4 16
CNSTF4 1110704128
ASGNF4
line 95
;95:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $77
line 96
;96:			if ( self->client->ps.powerups[ i ] > level.time ) {
ADDRLP4 0
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
LEI4 $81
line 97
;97:				item = BG_FindItemForPowerup( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 98
;98:				if ( !item ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $84
line 99
;99:					continue;
ADDRGP4 $78
JUMPV
LABELV $84
line 101
;100:				}
;101:				drop = Drop_Item( self, item, angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 103
;102:				// decide how many seconds it has left
;103:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 0
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
line 104
;104:				if ( drop->count < 1 ) {
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $87
line 105
;105:					drop->count = 1;
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 106
;106:				}
LABELV $87
line 108
;107:				// for pickup prediction
;108:				drop->s.time2 = drop->count;
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 109
;109:				angle += 45;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 110
;110:			}
LABELV $81
line 111
;111:		}
LABELV $78
line 95
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $77
line 112
;112:	}
LABELV $74
line 113
;113:}
LABELV $64
endproc TossClientItems 40 12
export LookAtKiller
proc LookAtKiller 28 4
line 203
;114:
;115:
;116:#ifdef MISSIONPACK
;117:/*
;118:=================
;119:TossClientCubes
;120:=================
;121:*/
;122:extern gentity_t	*neutralObelisk;
;123:
;124:void TossClientCubes( gentity_t *self ) {
;125:	gitem_t		*item;
;126:	gentity_t	*drop;
;127:	vec3_t		velocity;
;128:	vec3_t		angles;
;129:	vec3_t		origin;
;130:
;131:	self->client->ps.generic1 = 0;
;132:
;133:	// this should never happen but we should never
;134:	// get the server to crash due to skull being spawned in
;135:	if (!G_EntitiesFree()) {
;136:		return;
;137:	}
;138:
;139:	if( self->client->sess.sessionTeam == TEAM_RED ) {
;140:		item = BG_FindItem( "Red Cube" );
;141:	}
;142:	else {
;143:		item = BG_FindItem( "Blue Cube" );
;144:	}
;145:
;146:	angles[YAW] = (float)(level.time % 360);
;147:	angles[PITCH] = 0;	// always forward
;148:	angles[ROLL] = 0;
;149:
;150:	AngleVectors( angles, velocity, NULL, NULL );
;151:	VectorScale( velocity, 150, velocity );
;152:	velocity[2] += 200 + crandom() * 50;
;153:
;154:	if( neutralObelisk ) {
;155:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
;156:		origin[2] += 44;
;157:	} else {
;158:		VectorClear( origin ) ;
;159:	}
;160:
;161:	drop = LaunchItem( item, origin, velocity );
;162:
;163:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
;164:	drop->think = G_FreeEntity;
;165:	drop->spawnflags = self->client->sess.sessionTeam;
;166:}
;167:
;168:
;169:/*
;170:=================
;171:TossClientPersistantPowerups
;172:=================
;173:*/
;174:void TossClientPersistantPowerups( gentity_t *ent ) {
;175:	gentity_t	*powerup;
;176:
;177:	if( !ent->client ) {
;178:		return;
;179:	}
;180:
;181:	if( !ent->client->persistantPowerup ) {
;182:		return;
;183:	}
;184:
;185:	powerup = ent->client->persistantPowerup;
;186:
;187:	powerup->r.svFlags &= ~SVF_NOCLIENT;
;188:	powerup->s.eFlags &= ~EF_NODRAW;
;189:	powerup->r.contents = CONTENTS_TRIGGER;
;190:	trap_LinkEntity( powerup );
;191:
;192:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
;193:	ent->client->persistantPowerup = NULL;
;194:}
;195:#endif
;196:
;197:
;198:/*
;199:==================
;200:LookAtKiller
;201:==================
;202:*/
;203:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
line 206
;204:	vec3_t		dir;
;205:
;206:	if ( attacker && attacker != self ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $90
ADDRLP4 12
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $90
line 207
;207:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 208
;208:	} else if ( inflictor && inflictor != self ) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRLP4 16
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $94
ADDRLP4 16
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $94
line 209
;209:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 210
;210:	} else {
ADDRGP4 $95
JUMPV
LABELV $94
line 211
;211:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 212
;212:		return;
ADDRGP4 $89
JUMPV
LABELV $95
LABELV $91
line 215
;213:	}
;214:
;215:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 20
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 216
;216:}
LABELV $89
endproc LookAtKiller 28 4
export GibEntity
proc GibEntity 0 12
line 223
;217:
;218:/*
;219:==================
;220:GibEntity
;221:==================
;222:*/
;223:void GibEntity( gentity_t *self, int killer ) {
line 245
;224:#ifdef MISSIONPACK
;225:	gentity_t *ent;
;226:	int i;
;227:
;228:	//if this entity still has kamikaze
;229:	if (self->s.eFlags & EF_KAMIKAZE) {
;230:		// check if there is a kamikaze timer around for this owner
;231:		for (i = 0; i < level.num_entities; i++) {
;232:			ent = &g_entities[i];
;233:			if (!ent->inuse)
;234:				continue;
;235:			if (ent->activator != self)
;236:				continue;
;237:			if (strcmp(ent->classname, "kamikaze timer"))
;238:				continue;
;239:			G_FreeEntity(ent);
;240:			break;
;241:		}
;242:	}
;243:#endif
;244:
;245:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 246
;246:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 247
;247:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 248
;248:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 249
;249:}
LABELV $98
endproc GibEntity 0 12
export body_die
proc body_die 0 8
line 256
;250:
;251:/*
;252:==================
;253:body_die
;254:==================
;255:*/
;256:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 257
;257:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $100
line 258
;258:		return;
ADDRGP4 $99
JUMPV
LABELV $100
line 260
;259:	}
;260:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $102
line 261
;261:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 262
;262:		return;
ADDRGP4 $99
JUMPV
LABELV $102
line 265
;263:	}
;264:
;265:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 266
;266:}
LABELV $99
endproc body_die 0 8
data
export modNames
align 4
LABELV modNames
address $105
address $106
address $107
address $108
address $109
address $110
address $111
address $112
address $113
address $114
address $115
address $116
address $117
address $118
address $119
address $120
address $121
address $122
address $123
address $124
address $125
address $126
address $127
address $128
export CheckAlmostCapture
code
proc CheckAlmostCapture 52 12
line 340
;267:
;268:
;269:// these are just for logging, the client prints its own messages
;270:char	*modNames[] = {
;271:	"MOD_UNKNOWN",
;272:	"MOD_SHOTGUN",
;273:	"MOD_GAUNTLET",
;274:	"MOD_MACHINEGUN",
;275:	"MOD_GRENADE",
;276:	"MOD_GRENADE_SPLASH",
;277:	"MOD_ROCKET",
;278:	"MOD_ROCKET_SPLASH",
;279:	"MOD_PLASMA",
;280:	"MOD_PLASMA_SPLASH",
;281:	"MOD_RAILGUN",
;282:	"MOD_LIGHTNING",
;283:	"MOD_BFG",
;284:	"MOD_BFG_SPLASH",
;285:	"MOD_WATER",
;286:	"MOD_SLIME",
;287:	"MOD_LAVA",
;288:	"MOD_CRUSH",
;289:	"MOD_TELEFRAG",
;290:	"MOD_FALLING",
;291:	"MOD_SUICIDE",
;292:	"MOD_TARGET_LASER",
;293:	"MOD_TRIGGER_HURT",
;294:#ifdef MISSIONPACK
;295:	"MOD_NAIL",
;296:	"MOD_CHAINGUN",
;297:	"MOD_PROXIMITY_MINE",
;298:	"MOD_KAMIKAZE",
;299:	"MOD_JUICED",
;300:#endif
;301:	"MOD_GRAPPLE"
;302:};
;303:
;304:#ifdef MISSIONPACK
;305:/*
;306:==================
;307:Kamikaze_DeathActivate
;308:==================
;309:*/
;310:void Kamikaze_DeathActivate( gentity_t *ent ) {
;311:	G_StartKamikaze(ent);
;312:	G_FreeEntity(ent);
;313:}
;314:
;315:/*
;316:==================
;317:Kamikaze_DeathTimer
;318:==================
;319:*/
;320:void Kamikaze_DeathTimer( gentity_t *self ) {
;321:	gentity_t *ent;
;322:
;323:	ent = G_Spawn();
;324:	ent->classname = "kamikaze timer";
;325:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
;326:	ent->r.svFlags |= SVF_NOCLIENT;
;327:	ent->think = Kamikaze_DeathActivate;
;328:	ent->nextthink = level.time + 5 * 1000;
;329:
;330:	ent->activator = self;
;331:}
;332:
;333:#endif
;334:
;335:/*
;336:==================
;337:CheckAlmostCapture
;338:==================
;339:*/
;340:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
line 346
;341:	gentity_t	*ent;
;342:	vec3_t		dir;
;343:	char		*classname;
;344:
;345:	// if this player was carrying a flag
;346:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $133
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $133
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $130
LABELV $133
line 348
;347:		self->client->ps.powerups[PW_BLUEFLAG] ||
;348:		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 350
;349:		// get the goal flag this player should have been going for
;350:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $134
line 351
;351:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $137
line 352
;352:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $139
ASGNP4
line 353
;353:			}
ADDRGP4 $135
JUMPV
LABELV $137
line 354
;354:			else {
line 355
;355:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $140
ASGNP4
line 356
;356:			}
line 357
;357:		}
ADDRGP4 $135
JUMPV
LABELV $134
line 358
;358:		else {
line 359
;359:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $141
line 360
;360:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $140
ASGNP4
line 361
;361:			}
ADDRGP4 $142
JUMPV
LABELV $141
line 362
;362:			else {
line 363
;363:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $139
ASGNP4
line 364
;364:			}
LABELV $142
line 365
;365:		}
LABELV $135
line 366
;366:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $143
line 368
;367:		do
;368:		{
line 369
;369:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 370
;370:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $144
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $146
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $143
LABELV $146
line 372
;371:		// if we found the destination flag and it's not picked up
;372:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $147
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $147
line 374
;373:			// if the player was *very* close
;374:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 375
;375:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1128792064
GEF4 $151
line 376
;376:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 377
;377:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $153
line 378
;378:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 379
;379:				}
LABELV $153
line 380
;380:			}
LABELV $151
line 381
;381:		}
LABELV $147
line 382
;382:	}
LABELV $130
line 383
;383:}
LABELV $129
endproc CheckAlmostCapture 52 12
export CheckAlmostScored
proc CheckAlmostScored 44 12
line 390
;384:
;385:/*
;386:==================
;387:CheckAlmostScored
;388:==================
;389:*/
;390:void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
line 396
;391:	gentity_t	*ent;
;392:	vec3_t		dir;
;393:	char		*classname;
;394:
;395:	// if the player was carrying cubes
;396:	if ( self->client->ps.generic1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $156
line 397
;397:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $158
line 398
;398:			classname = "team_redobelisk";
ADDRLP4 16
ADDRGP4 $160
ASGNP4
line 399
;399:		}
ADDRGP4 $159
JUMPV
LABELV $158
line 400
;400:		else {
line 401
;401:			classname = "team_blueobelisk";
ADDRLP4 16
ADDRGP4 $161
ASGNP4
line 402
;402:		}
LABELV $159
line 403
;403:		ent = G_Find(NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 405
;404:		// if we found the destination obelisk
;405:		if ( ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $162
line 407
;406:			// if the player was *very* close
;407:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 408
;408:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $166
line 409
;409:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 410
;410:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $168
line 411
;411:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 412
;412:				}
LABELV $168
line 413
;413:			}
LABELV $166
line 414
;414:		}
LABELV $162
line 415
;415:	}
LABELV $156
line 416
;416:}
LABELV $155
endproc CheckAlmostScored 44 12
bss
align 4
LABELV $236
skip 4
export player_die
code
proc player_die 80 28
line 423
;417:
;418:/*
;419:==================
;420:player_die
;421:==================
;422:*/
;423:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 431
;424:	gentity_t	*ent;
;425:	int			anim;
;426:	int			contents;
;427:	int			killer;
;428:	int			i;
;429:	char		*killerName, *obit;
;430:
;431:	if ( self->client->ps.pm_type == PM_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $171
line 432
;432:		return;
ADDRGP4 $170
JUMPV
LABELV $171
line 435
;433:	}
;434:
;435:	if ( level.intermissiontime ) {
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $173
line 436
;436:		return;
ADDRGP4 $170
JUMPV
LABELV $173
line 440
;437:	}
;438:
;439:	//unlag the client
;440:	G_UnTimeShiftClient( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 443
;441:
;442:	// check for an almost capture
;443:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 445
;444:	// check for a player that almost brought in cubes
;445:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 447
;446:
;447:	if (self->client && self->client->hook) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
line 448
;448:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 449
;449:	}
LABELV $176
line 457
;450:#ifdef MISSIONPACK
;451:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
;452:		self->client->ps.eFlags &= ~EF_TICKING;
;453:		self->activator->think = G_FreeEntity;
;454:		self->activator->nextthink = level.time;
;455:	}
;456:#endif
;457:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 459
;458:
;459:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
line 460
;460:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 461
;461:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $180
line 462
;462:			killerName = attacker->client->pers.netname;
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ASGNP4
line 463
;463:		} else {
ADDRGP4 $179
JUMPV
LABELV $180
line 464
;464:			killerName = "<non-client>";
ADDRLP4 16
ADDRGP4 $182
ASGNP4
line 465
;465:		}
line 466
;466:	} else {
ADDRGP4 $179
JUMPV
LABELV $178
line 467
;467:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 468
;468:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $183
ASGNP4
line 469
;469:	}
LABELV $179
line 471
;470:
;471:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $186
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $184
LABELV $186
line 472
;472:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 473
;473:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $183
ASGNP4
line 474
;474:	}
LABELV $184
line 476
;475:
;476:	if ( (unsigned)meansOfDeath >= ARRAY_LEN( modNames ) ) {
ADDRFP4 16
INDIRI4
CVIU4 4
CNSTU4 24
LTU4 $187
line 477
;477:		obit = "<bad obituary>";
ADDRLP4 20
ADDRGP4 $189
ASGNP4
line 478
;478:	} else {
ADDRGP4 $188
JUMPV
LABELV $187
line 479
;479:		obit = modNames[ meansOfDeath ];
ADDRLP4 20
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 480
;480:	}
LABELV $188
line 482
;481:
;482:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
ADDRGP4 $190
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 487
;483:		killer, self->s.number, meansOfDeath, killerName, 
;484:		self->client->pers.netname, obit );
;485:
;486:	// broadcast the death event to everyone
;487:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 60
ARGI4
ADDRLP4 40
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 488
;488:	ent->s.eventParm = meansOfDeath;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 489
;489:	ent->s.otherEntityNum = self - g_entities;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 816
DIVI4
ASGNI4
line 490
;490:	ent->s.otherEntityNum2 = killer;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 491
;491:	ent->r.svFlags = SVF_BROADCAST;	// send to everyone
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 493
;492:
;493:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 495
;494:
;495:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 497
;496:
;497:	if (attacker && attacker->client) {
ADDRLP4 48
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $191
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $191
line 498
;498:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 728
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 500
;499:
;500:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
ADDRLP4 56
INDIRP4
CVPU4 4
EQU4 $195
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $193
LABELV $195
line 501
;501:			AddScore( attacker, self->r.currentOrigin, -1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 502
;502:		} else {
ADDRGP4 $192
JUMPV
LABELV $193
line 503
;503:			AddScore( attacker, self->r.currentOrigin, 1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 505
;504:
;505:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $196
line 508
;506:				
;507:				// play humiliation on player
;508:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 64
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 511
;509:
;510:				// add the sprite over the player's head
;511:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 512
;512:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 513
;513:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 516
;514:
;515:				// also play humiliation on target
;516:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 517
;517:			}
LABELV $196
line 521
;518:
;519:			// check for two kills in a short amount of time
;520:			// if this is close enough to the last kill, give a reward sound
;521:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $199
line 523
;522:				// play excellent on player
;523:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 64
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 526
;524:
;525:				// add the sprite over the player's head
;526:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 527
;527:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 528
;528:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 529
;529:			}
LABELV $199
line 530
;530:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 532
;531:
;532:		}
line 533
;533:	} else {
ADDRGP4 $192
JUMPV
LABELV $191
line 534
;534:		AddScore( self, self->r.currentOrigin, -1 );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 535
;535:	}
LABELV $192
line 538
;536:
;537:	// Add team bonuses
;538:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 541
;539:
;540:	// if I committed suicide, the flag does not fall, it returns.
;541:	if (meansOfDeath == MOD_SUICIDE) {
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $204
line 548
;542:#ifdef MISSIONPACK
;543:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
;544:			Team_ReturnFlag( TEAM_FREE );
;545:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
;546:		} else 
;547:#endif
;548:		if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $206
line 549
;549:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 550
;550:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 551
;551:		}
ADDRGP4 $207
JUMPV
LABELV $206
line 552
;552:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $208
line 553
;553:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 554
;554:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 555
;555:		}
LABELV $208
LABELV $207
line 556
;556:	}
LABELV $204
line 559
;557:
;558:	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;559:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 52
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 560
;560:	if ( !( contents & CONTENTS_NODROP )) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $210
line 561
;561:		TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 562
;562:	}
ADDRGP4 $211
JUMPV
LABELV $210
line 563
;563:	else {
line 564
;564:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $212
line 565
;565:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 566
;566:		}
ADDRGP4 $213
JUMPV
LABELV $212
line 567
;567:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $214
line 568
;568:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 569
;569:		}
ADDRGP4 $215
JUMPV
LABELV $214
line 570
;570:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $216
line 571
;571:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 572
;572:		}
LABELV $216
LABELV $215
LABELV $213
line 573
;573:	}
LABELV $211
line 581
;574:#ifdef MISSIONPACK
;575:	TossClientPersistantPowerups( self );
;576:	if( g_gametype.integer == GT_HARVESTER ) {
;577:		TossClientCubes( self );
;578:	}
;579:#endif
;580:
;581:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 584
;582:	// send updated scores to any clients that are following this one,
;583:	// or they would get stale scoreboards
;584:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $221
JUMPV
LABELV $218
line 587
;585:		gclient_t	*client;
;586:
;587:		client = &level.clients[i];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 1568
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 588
;588:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 56
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $223
line 589
;589:			continue;
ADDRGP4 $219
JUMPV
LABELV $223
line 591
;590:		}
;591:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 56
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $225
line 592
;592:			continue;
ADDRGP4 $219
JUMPV
LABELV $225
line 594
;593:		}
;594:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 56
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $227
line 595
;595:			Cmd_Score_f( g_entities + i );
ADDRLP4 0
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 596
;596:		}
LABELV $227
line 597
;597:	}
LABELV $219
line 584
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $221
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $218
line 599
;598:
;599:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 601
;600:
;601:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 602
;602:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 603
;603:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 605
;604:
;605:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 606
;606:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 607
;607:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 609
;608:
;609:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 611
;610:
;611:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 613
;612:
;613:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 617
;614:
;615:	// don't allow respawn until the death anim is done
;616:	// g_forcerespawn may force spawning at some later time
;617:	self->client->respawnTime = level.time + 1700;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
line 620
;618:
;619:	// remove powerups
;620:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
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
line 623
;621:
;622:	// never gib in a nodrop
;623:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $235
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $235
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $233
LABELV $235
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $230
LABELV $233
line 625
;624:		// gib death
;625:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 626
;626:	} else {
ADDRGP4 $231
JUMPV
LABELV $230
line 630
;627:		// normal death
;628:		static int i;
;629:
;630:		switch ( i ) {
ADDRLP4 60
ADDRGP4 $236
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $239
ADDRLP4 60
INDIRI4
CNSTI4 1
EQI4 $240
ADDRLP4 60
INDIRI4
CNSTI4 2
EQI4 $241
ADDRGP4 $237
JUMPV
LABELV $239
line 632
;631:		case 0:
;632:			anim = BOTH_DEATH1;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 633
;633:			break;
ADDRGP4 $238
JUMPV
LABELV $240
line 635
;634:		case 1:
;635:			anim = BOTH_DEATH2;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 636
;636:			break;
ADDRGP4 $238
JUMPV
LABELV $241
LABELV $237
line 639
;637:		case 2:
;638:		default:
;639:			anim = BOTH_DEATH3;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 640
;640:			break;
LABELV $238
line 645
;641:		}
;642:
;643:		// for the no-blood option, we need to prevent the health
;644:		// from going to gib level
;645:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $242
line 646
;646:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 647
;647:		}
LABELV $242
line 649
;648:
;649:		self->client->ps.legsAnim = 
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 651
;650:			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;651:		self->client->ps.torsoAnim = 
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 654
;652:			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;653:
;654:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $236
INDIRI4
CNSTI4 57
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 657
;655:
;656:		// the body can still be gibbed
;657:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 660
;658:
;659:		// globally cycle through the different death animations
;660:		i = ( i + 1 ) % 3;
ADDRLP4 72
ADDRGP4 $236
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 667
;661:
;662:#ifdef MISSIONPACK
;663:		if (self->s.eFlags & EF_KAMIKAZE) {
;664:			Kamikaze_DeathTimer( self );
;665:		}
;666:#endif
;667:	}
LABELV $231
line 669
;668:
;669:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 671
;670:
;671:}
LABELV $170
endproc player_die 80 28
export CheckArmor
proc CheckArmor 20 4
line 680
;672:
;673:
;674:/*
;675:================
;676:CheckArmor
;677:================
;678:*/
;679:int CheckArmor (gentity_t *ent, int damage, int dflags)
;680:{
line 685
;681:	gclient_t	*client;
;682:	int			save;
;683:	int			count;
;684:
;685:	if (!damage)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $245
line 686
;686:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $244
JUMPV
LABELV $245
line 688
;687:
;688:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 690
;689:
;690:	if (!client)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $247
line 691
;691:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $244
JUMPV
LABELV $247
line 693
;692:
;693:	if (dflags & DAMAGE_NO_ARMOR)
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $249
line 694
;694:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $244
JUMPV
LABELV $249
line 697
;695:
;696:	// armor
;697:	count = client->ps.stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 698
;698:	save = ceil( damage * ARMOR_PROTECTION );
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1059648963
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 699
;699:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $251
line 700
;700:		save = count;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $251
line 702
;701:
;702:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $253
line 703
;703:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $244
JUMPV
LABELV $253
line 705
;704:
;705:	client->ps.stats[STAT_ARMOR] -= save;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 707
;706:
;707:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $244
endproc CheckArmor 20 4
export RaySphereIntersections
proc RaySphereIntersections 56 4
line 715
;708:}
;709:
;710:/*
;711:================
;712:RaySphereIntersections
;713:================
;714:*/
;715:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
line 724
;716:	float b, c, d, t;
;717:
;718:	//	| origin - (point + t * dir) | = radius
;719:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;720:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;721:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;722:
;723:	// normalize dir so a = 1
;724:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 725
;725:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
CNSTF4 1073741824
MULF4
ASGNF4
line 726
;726:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
SUBF4
ASGNF4
line 731
;727:		(point[1] - origin[1]) * (point[1] - origin[1]) +
;728:		(point[2] - origin[2]) * (point[2] - origin[2]) -
;729:		radius * radius;
;730:
;731:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
MULF4
SUBF4
ASGNF4
line 732
;732:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $256
line 733
;733:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 734
;734:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 735
;735:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 52
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 736
;736:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 737
;737:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $255
JUMPV
LABELV $256
line 739
;738:	}
;739:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $258
line 740
;740:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
ASGNF4
line 741
;741:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 742
;742:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $255
JUMPV
LABELV $258
line 744
;743:	}
;744:	return 0;
CNSTI4 0
RETI4
LABELV $255
endproc RaySphereIntersections 56 4
export G_Damage
proc G_Damage 72 24
line 811
;745:}
;746:
;747:#ifdef MISSIONPACK
;748:/*
;749:================
;750:G_InvulnerabilityEffect
;751:================
;752:*/
;753:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
;754:	gentity_t	*impact;
;755:	vec3_t		intersections[2], vec;
;756:	int			n;
;757:
;758:	if ( !targ->client ) {
;759:		return qfalse;
;760:	}
;761:	VectorCopy(dir, vec);
;762:	VectorInverse(vec);
;763:	// sphere model radius = 42 units
;764:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
;765:	if (n > 0) {
;766:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
;767:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
;768:		vectoangles(vec, impact->s.angles);
;769:		impact->s.angles[0] += 90;
;770:		if (impact->s.angles[0] > 360)
;771:			impact->s.angles[0] -= 360;
;772:		if ( impactpoint ) {
;773:			VectorCopy( intersections[0], impactpoint );
;774:		}
;775:		if ( bouncedir ) {
;776:			VectorCopy( vec, bouncedir );
;777:			VectorNormalize( bouncedir );
;778:		}
;779:		return qtrue;
;780:	}
;781:	else {
;782:		return qfalse;
;783:	}
;784:}
;785:#endif
;786:/*
;787:============
;788:G_Damage
;789:
;790:targ		entity that is being damaged
;791:inflictor	entity that is causing the damage
;792:attacker	entity that caused the inflictor to damage targ
;793:	example: targ=monster, inflictor=rocket, attacker=player
;794:
;795:dir			direction of the attack for knockback
;796:point		point at which the damage is being inflicted, used for headshots
;797:damage		amount of damage being inflicted
;798:knockback	force to be applied against targ as a result of the damage
;799:
;800:inflictor, attacker, dir, and point can be NULL for environmental effects
;801:
;802:dflags		these flags are used to control how T_Damage works
;803:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;804:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;805:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;806:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;807:============
;808:*/
;809:
;810:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;811:			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
line 821
;812:	gclient_t	*client;
;813:	int			take;
;814:	int			asave;
;815:	int			knockback;
;816:	int			max;
;817:#ifdef MISSIONPACK
;818:	vec3_t		bouncedir, impactpoint;
;819:#endif
;820:
;821:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $261
line 822
;822:		return;
ADDRGP4 $260
JUMPV
LABELV $261
line 827
;823:	}
;824:
;825:	// the intermission has already been qualified for, so don't
;826:	// allow any extra scoring
;827:	if ( level.intermissionQueued ) {
ADDRGP4 level+7600
INDIRI4
CNSTI4 0
EQI4 $263
line 828
;828:		return;
ADDRGP4 $260
JUMPV
LABELV $263
line 840
;829:	}
;830:#ifdef MISSIONPACK
;831:	if ( targ->client && mod != MOD_JUICED) {
;832:		if ( targ->client->invulnerabilityTime > level.time) {
;833:			if ( dir && point ) {
;834:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
;835:			}
;836:			return;
;837:		}
;838:	}
;839:#endif
;840:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $266
line 841
;841:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+833952
ASGNP4
line 842
;842:	}
LABELV $266
line 843
;843:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $269
line 844
;844:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+833952
ASGNP4
line 845
;845:	}
LABELV $269
line 848
;846:
;847:	// shootable doors / buttons don't actually have any health
;848:	if ( targ->s.eType == ET_MOVER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $272
line 849
;849:		if ( targ->use && targ->moverState == MOVER_POS1 ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
ADDRLP4 20
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $260
line 850
;850:			targ->use( targ, inflictor, attacker );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 851
;851:		}
line 852
;852:		return;
ADDRGP4 $260
JUMPV
LABELV $272
line 861
;853:	}
;854:#ifdef MISSIONPACK
;855:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
;856:		return;
;857:	}
;858:#endif
;859:	// reduce damage by the attacker's handicap value
;860:	// unless they are rocket jumping
;861:	if ( attacker->client && attacker != targ ) {
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $276
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $276
line 862
;862:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 16
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 868
;863:#ifdef MISSIONPACK
;864:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;865:			max /= 2;
;866:		}
;867:#endif
;868:		damage = damage * max / 100;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 16
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 869
;869:	}
LABELV $276
line 871
;870:
;871:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 873
;872:
;873:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $278
line 874
;874:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRI4
CNSTI4 0
EQI4 $280
line 875
;875:			return;
ADDRGP4 $260
JUMPV
LABELV $280
line 877
;876:		}
;877:	}
LABELV $278
line 879
;878:
;879:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $282
line 880
;880:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 881
;881:	} else {
ADDRGP4 $283
JUMPV
LABELV $282
line 882
;882:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 883
;883:	}
LABELV $283
line 885
;884:
;885:	knockback = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 886
;886:	if ( knockback > 200 ) {
ADDRLP4 4
INDIRI4
CNSTI4 200
LEI4 $284
line 887
;887:		knockback = 200;
ADDRLP4 4
CNSTI4 200
ASGNI4
line 888
;888:	}
LABELV $284
line 889
;889:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $286
line 890
;890:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 891
;891:	}
LABELV $286
line 892
;892:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $288
line 893
;893:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 894
;894:	}
LABELV $288
line 897
;895:
;896:	// figure momentum add, even if the damage won't be taken
;897:	if ( knockback && targ->client ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $290
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $290
line 901
;898:		vec3_t	kvel;
;899:		float	mass;
;900:
;901:		mass = 200;
ADDRLP4 36
CNSTF4 1128792064
ASGNF4
line 903
;902:
;903:		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 48
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 48
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 48
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 36
INDIRF4
DIVF4
MULF4
ASGNF4
line 904
;904:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 908
;905:
;906:		// set the timer so that the other client can't cancel
;907:		// out the movement immediately
;908:		if ( !targ->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $299
line 911
;909:			int		t;
;910:
;911:			t = knockback * 2;
ADDRLP4 64
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 912
;912:			if ( t < 50 ) {
ADDRLP4 64
INDIRI4
CNSTI4 50
GEI4 $301
line 913
;913:				t = 50;
ADDRLP4 64
CNSTI4 50
ASGNI4
line 914
;914:			}
LABELV $301
line 915
;915:			if ( t > 200 ) {
ADDRLP4 64
INDIRI4
CNSTI4 200
LEI4 $303
line 916
;916:				t = 200;
ADDRLP4 64
CNSTI4 200
ASGNI4
line 917
;917:			}
LABELV $303
line 918
;918:			targ->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 919
;919:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 920
;920:		}
LABELV $299
line 921
;921:	}
LABELV $290
line 924
;922:
;923:	// check for completely getting out of the damage
;924:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $305
line 931
;925:
;926:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;927:		// if the attacker was on the same team
;928:#ifdef MISSIONPACK
;929:		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
;930:#else	
;931:		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRP4
CVPU4 4
EQU4 $307
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $307
line 933
;932:#endif
;933:			if ( !g_friendlyFire.integer ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $309
line 934
;934:				return;
ADDRGP4 $260
JUMPV
LABELV $309
line 936
;935:			}
;936:		}
LABELV $307
line 949
;937:#ifdef MISSIONPACK
;938:		if (mod == MOD_PROXIMITY_MINE) {
;939:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
;940:				return;
;941:			}
;942:			if (targ == attacker) {
;943:				return;
;944:			}
;945:		}
;946:#endif
;947:
;948:		// check for godmode
;949:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $312
line 950
;950:			return;
ADDRGP4 $260
JUMPV
LABELV $312
line 952
;951:		}
;952:	}
LABELV $305
line 956
;953:
;954:	// battlesuit protects from all radius damage (but takes knockback)
;955:	// and protects 50% against all damage
;956:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $314
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $314
line 957
;957:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
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
line 958
;958:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $318
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $316
LABELV $318
line 959
;959:			return;
ADDRGP4 $260
JUMPV
LABELV $316
line 961
;960:		}
;961:		damage *= 0.5;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
CVFI4 4
ASGNI4
line 962
;962:	}
LABELV $314
line 966
;963:
;964:	// always give half damage if hurting self
;965:	// calculated after knockback, so rocket jumping works
;966:	if ( targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $319
line 967
;967:		damage *= 0.5;
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
CNSTF4 1056964608
MULF4
CVFI4 4
ASGNI4
line 968
;968:	}
LABELV $319
line 970
;969:
;970:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $321
line 971
;971:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 972
;972:	}
LABELV $321
line 973
;973:	take = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 976
;974:
;975:	// save some from armor
;976:	asave = CheckArmor( targ, take, dflags );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 978
;977:
;978:	take -= asave;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 980
;979:
;980:	if ( g_debugDamage.integer ) {
ADDRGP4 g_debugDamage+12
INDIRI4
CNSTI4 0
EQI4 $323
line 981
;981:		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
ADDRGP4 $326
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 983
;982:			targ->health, take, asave );
;983:	}
LABELV $323
line 986
;984:
;985:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;986:	if ( attacker->client && client && targ != attacker && targ->health > 0
ADDRLP4 32
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRP4
CVPU4 4
EQU4 $328
ADDRLP4 36
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $328
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $328
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $328
line 988
;987:			&& targ->s.eType != ET_MISSILE
;988:			&& targ->s.eType != ET_GENERAL) {
line 999
;989:#ifdef MISSIONPACK
;990:		if ( OnSameTeam( targ, attacker ) ) {
;991:			attacker->client->ps.persistant[PERS_HITS]--;
;992:		} else {
;993:			attacker->client->ps.persistant[PERS_HITS]++;
;994:		}
;995:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
;996:#else
;997:		// we may hit multiple targets from different teams
;998:		// so usual PERS_HITS increments/decrements could result in ZERO delta
;999:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $330
line 1000
;1000:			attacker->client->damage.team++;
ADDRLP4 44
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1556
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1001
;1001:		} else {
ADDRGP4 $331
JUMPV
LABELV $330
line 1002
;1002:			attacker->client->damage.enemy++;
ADDRLP4 44
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1560
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1004
;1003:			// accumulate damage during server frame
;1004:			attacker->client->damage.amount += take + asave;
ADDRLP4 48
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1564
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ADDI4
ASGNI4
line 1005
;1005:		}
LABELV $331
line 1007
;1006:#endif
;1007:	}
LABELV $328
line 1012
;1008:
;1009:	// add to the damage inflicted on a player this frame
;1010:	// the total will be turned into screen blends and view angle kicks
;1011:	// at the end of the frame
;1012:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $332
line 1013
;1013:		if ( attacker ) { // FIXME: always true?
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $334
line 1014
;1014:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1015
;1015:		} else {
ADDRGP4 $335
JUMPV
LABELV $334
line 1016
;1016:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1017
;1017:		}
LABELV $335
line 1018
;1018:		client->damage_armor += asave;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1019
;1019:		client->damage_blood += take;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1020
;1020:		client->damage_knockback += knockback;
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1021
;1021:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $336
line 1022
;1022:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1023
;1023:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 1024
;1024:		} else {
ADDRGP4 $337
JUMPV
LABELV $336
line 1025
;1025:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1026
;1026:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 1
ASGNI4
line 1027
;1027:		}
LABELV $337
line 1028
;1028:	}
LABELV $332
line 1034
;1029:
;1030:	// See if it's the player hurting the emeny flag carrier
;1031:#ifdef MISSIONPACK
;1032:	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
;1033:#else	
;1034:	if( g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $338
line 1036
;1035:#endif
;1036:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1037
;1037:	}
LABELV $338
line 1039
;1038:
;1039:	if (targ->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
line 1041
;1040:		// set the last client who damaged the target
;1041:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 732
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1042
;1042:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 736
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1043
;1043:	}
LABELV $341
line 1046
;1044:
;1045:	// do the damage
;1046:	if (take) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $343
line 1047
;1047:		targ->health = targ->health - take;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1048
;1048:		if ( targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $345
line 1049
;1049:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1050
;1050:		}
LABELV $345
line 1052
;1051:			
;1052:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $347
line 1053
;1053:			if ( client )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $349
line 1054
;1054:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
LABELV $349
line 1056
;1055:
;1056:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $351
line 1057
;1057:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -999
ASGNI4
LABELV $351
line 1059
;1058:
;1059:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1060
;1060:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CALLV
pop
line 1061
;1061:			return;
ADDRGP4 $260
JUMPV
LABELV $347
line 1062
;1062:		} else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $353
line 1063
;1063:			targ->pain (targ, attacker, take);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 1064
;1064:		}
LABELV $353
line 1065
;1065:	}
LABELV $343
line 1067
;1066:
;1067:}
LABELV $260
endproc G_Damage 72 24
export CanDamage
proc CanDamage 144 28
line 1079
;1068:
;1069:
;1070:/*
;1071:============
;1072:CanDamage
;1073:
;1074:Returns qtrue if the inflictor can directly damage the target.  Used for
;1075:explosions and melee attacks.
;1076:============
;1077:*/
;1078:qboolean CanDamage( gentity_t *targ, vec3_t origin )
;1079:{
line 1087
;1080:	//we check if the attacker can damage the target, return qtrue if yes, qfalse if no
;1081:	vec3_t	dest;
;1082:	trace_t	tr;
;1083:	vec3_t	midpoint;
;1084:	vec3_t	size;
;1085:
;1086:	// use the midpoint of the bounds instead of the origin, because bmodels may have their origin 0,0,0
;1087:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 92
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80+4
ADDRLP4 92
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80+8
ADDRLP4 96
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1088
;1088:	VectorScale( midpoint, 0.5, dest );
ADDRLP4 0
ADDRLP4 80
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 80+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1090
;1089:
;1090:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1091
;1091:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
EQF4 $366
ADDRLP4 12+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $362
LABELV $366
line 1092
;1092:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $362
line 1094
;1093:
;1094:	VectorSubtract( targ->r.absmax, targ->r.absmin, size );
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 104
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 104
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68+8
ADDRLP4 108
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1100
;1095:	
;1096:	// top quad
;1097:
;1098:	// - +
;1099:	// - -
;1100:	VectorCopy( targ->r.absmax, dest );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 1101
;1101:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1102
;1102:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $369
line 1103
;1103:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $369
line 1107
;1104:
;1105:	// + -
;1106:	// - -
;1107:	dest[0] -= size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
line 1108
;1108:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1109
;1109:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $372
line 1110
;1110:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $372
line 1114
;1111:
;1112:	// - -
;1113:	// + -
;1114:	dest[1] -= size[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 68+4
INDIRF4
SUBF4
ASGNF4
line 1115
;1115:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1116
;1116:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $377
line 1117
;1117:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $377
line 1121
;1118:
;1119:	// - -
;1120:	// - +
;1121:	dest[0] += size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ASGNF4
line 1122
;1122:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1123
;1123:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $380
line 1124
;1124:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $380
line 1130
;1125:
;1126:	// bottom quad
;1127:
;1128:	// - -
;1129:	// + -
;1130:	VectorCopy( targ->r.absmin, dest );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 1131
;1131:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1132
;1132:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $383
line 1133
;1133:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $383
line 1137
;1134:
;1135:	// - -
;1136:	// - +
;1137:	dest[0] += size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ASGNF4
line 1138
;1138:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1139
;1139:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $386
line 1140
;1140:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $386
line 1144
;1141:
;1142:	// - +
;1143:	// - -
;1144:	dest[1] += size[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 68+4
INDIRF4
ADDF4
ASGNF4
line 1145
;1145:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1146
;1146:	if (tr.fraction == 1.0)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $391
line 1147
;1147:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $391
line 1151
;1148:
;1149:	// + -
;1150:	// - -
;1151:	dest[0] -= size[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
line 1152
;1152:	trap_Trace( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1153
;1153:	if ( tr.fraction == 1.0 )
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $394
line 1154
;1154:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $355
JUMPV
LABELV $394
line 1156
;1155:
;1156:	return qfalse;
CNSTI4 0
RETI4
LABELV $355
endproc CanDamage 144 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1166
;1157:}
;1158:
;1159:
;1160:/*
;1161:============
;1162:G_RadiusDamage
;1163:============
;1164:*/
;1165:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1166:					 gentity_t *ignore, int mod) {
line 1175
;1167:	float		points, dist;
;1168:	gentity_t	*ent;
;1169:	int			entityList[MAX_GENTITIES];
;1170:	int			numListedEntities;
;1171:	vec3_t		mins, maxs;
;1172:	vec3_t		v;
;1173:	vec3_t		dir;
;1174:	int			i, e;
;1175:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1177
;1176:
;1177:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $398
line 1178
;1178:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1179
;1179:	}
LABELV $398
line 1181
;1180:
;1181:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $400
line 1182
;1182:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4144
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1183
;1183:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4156
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1184
;1184:	}
LABELV $401
line 1181
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $400
line 1186
;1185:
;1186:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1188
;1187:
;1188:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $407
JUMPV
LABELV $404
line 1189
;1189:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
CNSTI4 816
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1191
;1190:
;1191:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $408
line 1192
;1192:			continue;
ADDRGP4 $405
JUMPV
LABELV $408
line 1193
;1193:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $410
line 1194
;1194:			continue;
ADDRGP4 $405
JUMPV
LABELV $410
line 1197
;1195:
;1196:		// find the distance from the edge of the bounding box
;1197:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $412
line 1198
;1198:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $416
line 1199
;1199:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1200
;1200:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $417
JUMPV
LABELV $416
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $418
line 1201
;1201:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1202
;1202:			} else {
ADDRGP4 $419
JUMPV
LABELV $418
line 1203
;1203:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1204
;1204:			}
LABELV $419
LABELV $417
line 1205
;1205:		}
LABELV $413
line 1197
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $412
line 1207
;1206:
;1207:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1208
;1208:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $420
line 1209
;1209:			continue;
ADDRGP4 $405
JUMPV
LABELV $420
line 1212
;1210:		}
;1211:
;1212:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1214
;1213:
;1214:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $422
line 1215
;1215:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $424
line 1216
;1216:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1217
;1217:			}
LABELV $424
line 1218
;1218:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1221
;1219:			// push the center of mass higher than the origin so players
;1220:			// get knocked into the air more
;1221:			dir[2] += 24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1222
;1222:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1223
;1223:		}
LABELV $422
line 1224
;1224:	}
LABELV $405
line 1188
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $407
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $404
line 1226
;1225:
;1226:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $397
endproc G_RadiusDamage 4196 32
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
import G_InvulnerabilityEffect
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
LABELV $326
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $190
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $183
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $182
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $161
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $160
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $140
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $139
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
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
LABELV $128
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $127
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $126
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $125
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $124
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $123
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $122
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $121
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $120
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $119
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $118
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $117
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $116
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $115
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $114
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $113
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $112
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $111
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $110
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $109
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $108
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $107
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $106
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $105
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
