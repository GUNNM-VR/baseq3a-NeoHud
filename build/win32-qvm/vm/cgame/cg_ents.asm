export CG_PositionEntityOnTag
code
proc CG_PositionEntityOnTag 80 24
file "..\..\..\..\code\cgame\cg_ents.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_ents.c -- present snapshot entities, happens every single frame
;4:
;5:#include "cg_local.h"
;6:
;7:
;8:/*
;9:======================
;10:CG_PositionEntityOnTag
;11:
;12:Modifies the entities position and axis by the given
;13:tag location
;14:======================
;15:*/
;16:void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;17:							qhandle_t parentModel, const char *tagName ) {
line 22
;18:	int				i;
;19:	orientation_t	lerped;
;20:	
;21:	// lerp the tag
;22:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 26
;23:		1.0 - parent->backlerp, tagName );
;24:
;25:	// FIXME: allow origin offsets along tag?
;26:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 27
;27:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $78
line 28
;28:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 29
;29:	}
LABELV $79
line 27
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $78
line 32
;30:
;31:	// had to cast away the const to avoid compiler problems...
;32:	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 33
;33:	entity->backlerp = parent->backlerp;
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ASGNF4
line 34
;34:}
LABELV $77
endproc CG_PositionEntityOnTag 80 24
export CG_PositionRotatedEntityOnTag
proc CG_PositionRotatedEntityOnTag 116 24
line 46
;35:
;36:
;37:/*
;38:======================
;39:CG_PositionRotatedEntityOnTag
;40:
;41:Modifies the entities position and axis by the given
;42:tag location
;43:======================
;44:*/
;45:void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;46:							qhandle_t parentModel, const char *tagName ) {
line 53
;47:	int				i;
;48:	orientation_t	lerped;
;49:	vec3_t			tempAxis[3];
;50:
;51://AxisClear( entity->axis );
;52:	// lerp the tag
;53:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 57
;54:		1.0 - parent->backlerp, tagName );
;55:
;56:	// FIXME: allow origin offsets along tag?
;57:	VectorCopy( parent->origin, entity->origin );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 58
;58:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $84
line 59
;59:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 60
;60:	}
LABELV $85
line 58
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $84
line 63
;61:
;62:	// had to cast away the const to avoid compiler problems...
;63:	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 64
;64:	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 52
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 65
;65:}
LABELV $83
endproc CG_PositionRotatedEntityOnTag 116 24
export CG_SetEntitySoundPosition
proc CG_SetEntitySoundPosition 24 8
line 84
;66:
;67:
;68:
;69:/*
;70:==========================================================================
;71:
;72:FUNCTIONS CALLED EACH FRAME
;73:
;74:==========================================================================
;75:*/
;76:
;77:/*
;78:======================
;79:CG_SetEntitySoundPosition
;80:
;81:Also called by event processing code
;82:======================
;83:*/
;84:void CG_SetEntitySoundPosition( const centity_t *cent ) {
line 85
;85:	if ( cent->currentState.solid == SOLID_BMODEL ) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $90
line 89
;86:		vec3_t	origin;
;87:		float	*v;
;88:
;89:		v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+37924
ADDP4
ASGNP4
line 90
;90:		VectorAdd( cent->lerpOrigin, v, origin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 91
;91:		trap_S_UpdateEntityPosition( cent->currentState.number, origin );
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 92
;92:	} else {
ADDRGP4 $91
JUMPV
LABELV $90
line 93
;93:		trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 94
;94:	}
LABELV $91
line 95
;95:}
LABELV $89
endproc CG_SetEntitySoundPosition 24 8
proc CG_EntityEffects 20 20
line 104
;96:
;97:/*
;98:==================
;99:CG_EntityEffects
;100:
;101:Add continuous entity effects, like local entity emission and lighting
;102:==================
;103:*/
;104:static void CG_EntityEffects( const centity_t *cent ) {
line 107
;105:
;106:	// update sound origins
;107:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 110
;108:
;109:	// add loop sound
;110:	if ( cent->currentState.loopSound ) {
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $96
line 111
;111:		if (cent->currentState.eType != ET_SPEAKER) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $98
line 112
;112:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 114
;113:				cgs.gameSounds[ cent->currentState.loopSound ] );
;114:		} else {
ADDRGP4 $99
JUMPV
LABELV $98
line 115
;115:			trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 117
;116:				cgs.gameSounds[ cent->currentState.loopSound ] );
;117:		}
LABELV $99
line 118
;118:	}
LABELV $96
line 122
;119:
;120:
;121:	// constant light glow
;122:	if(cent->currentState.constantLight)
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
line 123
;123:	{
line 127
;124:		int		cl;
;125:		float		i, r, g, b;
;126:
;127:		cl = cent->currentState.constantLight;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 128
;128:		r = (float)(( cl >> 0 ) & 255) / 255.0;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 129
;129:		g = (float)(( cl >> 8 ) & 255) / 255.0;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 130
;130:		b = (float)(( cl >> 16 ) & 255) / 255.0;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 998277249
MULF4
ASGNF4
line 131
;131:		i = (float)(( cl >> 24 ) & 255) * 4.0;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1082130432
MULF4
ASGNF4
line 132
;132:		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 133
;133:	}
LABELV $102
line 135
;134:
;135:}
LABELV $95
endproc CG_EntityEffects 20 20
proc CG_General 144 12
line 143
;136:
;137:
;138:/*
;139:==================
;140:CG_General
;141:==================
;142:*/
;143:static void CG_General( const centity_t *cent ) {
line 147
;144:	refEntity_t			ent;
;145:	const entityState_t	*s1;
;146:
;147:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 150
;148:
;149:	// if set to invisible, skip
;150:	if (!s1->modelindex) {
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $105
line 151
;151:		return;
ADDRGP4 $104
JUMPV
LABELV $105
line 154
;152:	}
;153:
;154:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 158
;155:
;156:	// set frame
;157:
;158:	ent.frame = s1->frame;
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 159
;159:	ent.oldframe = ent.frame;
ADDRLP4 0+96
ADDRLP4 0+80
INDIRI4
ASGNI4
line 160
;160:	ent.backlerp = 0;
ADDRLP4 0+100
CNSTF4 0
ASGNF4
line 162
;161:
;162:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 163
;163:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 165
;164:
;165:	ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34848
ADDP4
INDIRI4
ASGNI4
line 168
;166:
;167:	// player model
;168:	if (s1->number == cg.snap->ps.clientNum) {
ADDRLP4 140
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $115
line 169
;169:		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 170
;170:	}
LABELV $115
line 173
;171:
;172:	// convert angles to axis
;173:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 176
;174:
;175:	// add to refresh list
;176:	trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 177
;177:}
LABELV $104
endproc CG_General 144 12
proc CG_Speaker 12 16
line 186
;178:
;179:/*
;180:==================
;181:CG_Speaker
;182:
;183:Speaker entities can automatically play sounds
;184:==================
;185:*/
;186:static void CG_Speaker( centity_t *cent ) {
line 187
;187:	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $121
line 188
;188:		return;		// not auto triggering
ADDRGP4 $120
JUMPV
LABELV $121
line 191
;189:	}
;190:
;191:	if ( cg.time < cent->miscTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
GEI4 $123
line 192
;192:		return;
ADDRGP4 $120
JUMPV
LABELV $123
line 195
;193:	}
;194:
;195:	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
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
line 199
;196:
;197:	//	ent->s.frame = ent->wait * 10;
;198:	//	ent->s.clientNum = ent->random * 10;
;199:	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 100
MULI4
CVIF4 4
ADDRLP4 4
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
ADDF4
CVFI4 4
ASGNI4
line 200
;200:}
LABELV $120
endproc CG_Speaker 12 16
proc CG_Item 232 12
line 207
;201:
;202:/*
;203:==================
;204:CG_Item
;205:==================
;206:*/
;207:static void CG_Item( centity_t *cent ) {
line 218
;208:	refEntity_t		ent;
;209:	entityState_t	*es;
;210:	const gitem_t	*item;
;211:	int				msec;
;212:	float			frac;
;213:	float			scale;
;214:	weaponInfo_t	*wi;
;215:	int				modulus;
;216:	itemInfo_t		*itemInfo;
;217:
;218:	es = &cent->currentState;
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
line 219
;219:	if ( es->modelindex >= bg_numItems ) {
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $129
line 220
;220:		CG_Error( "Bad item index %i on entity", es->modelindex );
ADDRGP4 $131
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 221
;221:	}
LABELV $129
line 224
;222:
;223:	// if set to invisible, skip
;224:	if ( !es->modelindex || ( es->eFlags & EF_NODRAW ) || cent->delaySpawn > cg.time ) {
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
EQI4 $136
ADDRLP4 144
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $136
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $132
LABELV $136
line 225
;225:		return;
ADDRGP4 $128
JUMPV
LABELV $132
line 228
;226:	}
;227:
;228:	itemInfo = &cg_items[ es->modelindex ];
ADDRLP4 164
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items
ADDP4
ASGNP4
line 229
;229:	if ( !itemInfo->registered ) {
ADDRLP4 164
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $137
line 230
;230:		CG_RegisterItemVisuals( es->modelindex );
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 231
;231:		if ( !itemInfo->registered ) {
ADDRLP4 164
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $139
line 232
;232:			return;
ADDRGP4 $128
JUMPV
LABELV $139
line 234
;233:		}
;234:	}
LABELV $137
line 236
;235:
;236:	item = &bg_itemlist[ es->modelindex ];
ADDRLP4 140
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 237
;237:	if ( cg_simpleItems.integer && item->giType != IT_TEAM ) {
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
EQI4 $141
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $141
line 238
;238:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 239
;239:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 240
;240:		VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 241
;241:		ent.radius = 14;
ADDRLP4 0+132
CNSTF4 1096810496
ASGNF4
line 242
;242:		ent.customShader = cg_items[es->modelindex].icon_df;
ADDRLP4 0+112
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+24
ADDP4
INDIRI4
ASGNI4
line 243
;243:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 244
;244:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 245
;245:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 246
;246:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 247
;247:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 248
;248:		return;
ADDRGP4 $128
JUMPV
LABELV $141
line 252
;249:	}
;250:
;251:	// items bob up and down continuously
;252:	scale = 0.005 + cent->currentState.number * 0.00001;
ADDRLP4 160
ADDRFP4 0
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 925353388
MULF4
CNSTF4 1000593162
ADDF4
ASGNF4
line 253
;253:	modulus = 2 * M_PI * 20228 / scale;
ADDRLP4 168
CNSTF4 1207450659
ADDRLP4 160
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 254
;254:	cent->lerpOrigin[2] += 4 + cos( ( ( cg.time + 1000 ) % modulus ) *  scale ) * 4;
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ADDRLP4 168
INDIRI4
MODI4
CVIF4 4
ADDRLP4 160
INDIRF4
MULF4
ARGF4
ADDRLP4 176
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 176
INDIRF4
CNSTF4 1082130432
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 256
;255:
;256:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 259
;257:
;258:	// autorotate at one of two speeds
;259:	if ( item->giType == IT_HEALTH ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $156
line 260
;260:		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 cg+109008
INDIRB
ASGNB 12
line 261
;261:		AxisCopy( cg.autoAxisFast, ent.axis );
ADDRGP4 cg+109020
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 262
;262:	} else {
ADDRGP4 $157
JUMPV
LABELV $156
line 263
;263:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 cg+108960
INDIRB
ASGNB 12
line 264
;264:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+108972
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 265
;265:	}
LABELV $157
line 267
;266:
;267:	wi = NULL;
ADDRLP4 152
CNSTP4 0
ASGNP4
line 271
;268:	// the weapons have their origin where they attatch to player
;269:	// models, so we need to offset them or they will rotate
;270:	// eccentricly
;271:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $164
line 272
;272:		wi = &cg_weapons[item->giTag];
ADDRLP4 152
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 273
;273:		cent->lerpOrigin[0] -= 
ADDRLP4 184
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 277
;274:			wi->weaponMidpoint[0] * ent.axis[0][0] +
;275:			wi->weaponMidpoint[1] * ent.axis[1][0] +
;276:			wi->weaponMidpoint[2] * ent.axis[2][0];
;277:		cent->lerpOrigin[1] -= 
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+4
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 281
;278:			wi->weaponMidpoint[0] * ent.axis[0][1] +
;279:			wi->weaponMidpoint[1] * ent.axis[1][1] +
;280:			wi->weaponMidpoint[2] * ent.axis[2][1];
;281:		cent->lerpOrigin[2] -= 
ADDRLP4 200
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ASGNP4
ADDRLP4 200
INDIRP4
ADDRLP4 200
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+8
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 286
;282:			wi->weaponMidpoint[0] * ent.axis[0][2] +
;283:			wi->weaponMidpoint[1] * ent.axis[1][2] +
;284:			wi->weaponMidpoint[2] * ent.axis[2][2];
;285:
;286:		cent->lerpOrigin[2] += 8;	// an extra height boost
ADDRLP4 208
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
ADDRLP4 208
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 287
;287:	}
LABELV $164
line 289
;288:
;289:	ent.hModel = cg_items[es->modelindex].models[0];
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ASGNI4
line 291
;290:
;291:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 292
;292:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 294
;293:
;294:	ent.nonNormalizedAxes = qfalse;
ADDRLP4 0+64
CNSTI4 0
ASGNI4
line 297
;295:
;296:	// if just respawned, slowly scale up
;297:	msec = cg.time - cent->miscTime;
ADDRLP4 156
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
SUBI4
ASGNI4
line 298
;298:	if ( msec >= 0 && msec < ITEM_SCALEUP_TIME ) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $193
ADDRLP4 156
INDIRI4
CNSTI4 1000
GEI4 $193
line 299
;299:		frac = (float)msec / ITEM_SCALEUP_TIME;
ADDRLP4 148
ADDRLP4 156
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 300
;300:		VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 301
;301:		VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 302
;302:		VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 303
;303:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 304
;304:	} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 305
;305:		frac = 1.0;
ADDRLP4 148
CNSTF4 1065353216
ASGNF4
line 306
;306:	}
LABELV $194
line 310
;307:
;308:	// items without glow textures need to keep a minimum light value
;309:	// so they are always visible
;310:	if ( ( item->giType == IT_WEAPON ) ||
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
EQI4 $240
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $238
LABELV $240
line 311
;311:		 ( item->giType == IT_ARMOR ) ) {
line 312
;312:		ent.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 313
;313:	}
LABELV $238
line 316
;314:
;315:	// increase the size of the weapons when they are presented as items
;316:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $242
line 317
;317:		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 318
;318:		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 319
;319:		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 320
;320:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 325
;321:#ifdef MISSIONPACK
;322:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.weaponHoverSound );
;323:#endif
;324:		// pickup color from spectaror/own client
;325:		if ( item->giTag == WP_RAILGUN ) {
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $287
line 326
;326:			const clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
ADDRLP4 192
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
line 327
;327:			ent.shaderRGBA[0] = ci->color1[0] * 255.0f;
ADDRLP4 200
ADDRLP4 192
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 204
CNSTF4 1325400064
ASGNF4
ADDRLP4 200
INDIRF4
ADDRLP4 204
INDIRF4
LTF4 $293
ADDRLP4 196
ADDRLP4 200
INDIRF4
ADDRLP4 204
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $294
JUMPV
LABELV $293
ADDRLP4 196
ADDRLP4 200
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $294
ADDRLP4 0+116
ADDRLP4 196
INDIRU4
CVUU1 4
ASGNU1
line 328
;328:			ent.shaderRGBA[1] = ci->color1[1] * 255.0f;
ADDRLP4 212
ADDRLP4 192
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 216
CNSTF4 1325400064
ASGNF4
ADDRLP4 212
INDIRF4
ADDRLP4 216
INDIRF4
LTF4 $298
ADDRLP4 208
ADDRLP4 212
INDIRF4
ADDRLP4 216
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $299
JUMPV
LABELV $298
ADDRLP4 208
ADDRLP4 212
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $299
ADDRLP4 0+116+1
ADDRLP4 208
INDIRU4
CVUU1 4
ASGNU1
line 329
;329:			ent.shaderRGBA[2] = ci->color1[2] * 255.0f;
ADDRLP4 224
ADDRLP4 192
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 228
CNSTF4 1325400064
ASGNF4
ADDRLP4 224
INDIRF4
ADDRLP4 228
INDIRF4
LTF4 $303
ADDRLP4 220
ADDRLP4 224
INDIRF4
ADDRLP4 228
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $304
JUMPV
LABELV $303
ADDRLP4 220
ADDRLP4 224
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $304
ADDRLP4 0+116+2
ADDRLP4 220
INDIRU4
CVUU1 4
ASGNU1
line 330
;330:			ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 331
;331:		}
LABELV $287
line 332
;332:	}
LABELV $242
line 344
;333:
;334:#ifdef MISSIONPACK
;335:	if ( item->giType == IT_HOLDABLE && item->giTag == HI_KAMIKAZE ) {
;336:		VectorScale( ent.axis[0], 2, ent.axis[0] );
;337:		VectorScale( ent.axis[1], 2, ent.axis[1] );
;338:		VectorScale( ent.axis[2], 2, ent.axis[2] );
;339:		ent.nonNormalizedAxes = qtrue;
;340:	}
;341:#endif
;342:
;343:	// add to refresh list
;344:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 368
;345:
;346:#ifdef MISSIONPACK
;347:	if ( item->giType == IT_WEAPON && wi->barrelModel ) {
;348:		refEntity_t	barrel;
;349:
;350:		memset( &barrel, 0, sizeof( barrel ) );
;351:
;352:		barrel.hModel = wi->barrelModel;
;353:
;354:		VectorCopy( ent.lightingOrigin, barrel.lightingOrigin );
;355:		barrel.shadowPlane = ent.shadowPlane;
;356:		barrel.renderfx = ent.renderfx;
;357:
;358:		CG_PositionRotatedEntityOnTag( &barrel, &ent, wi->weaponModel, "tag_barrel" );
;359:
;360:		AxisCopy( ent.axis, barrel.axis );
;361:		barrel.nonNormalizedAxes = ent.nonNormalizedAxes;
;362:
;363:		trap_R_AddRefEntityToScene( &barrel );
;364:	}
;365:#endif
;366:
;367:	// accompanying rings / spheres for powerups
;368:	if ( !cg_simpleItems.integer ) 
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
NEI4 $307
line 369
;369:	{
line 372
;370:		vec3_t spinAngles;
;371:
;372:		VectorClear( spinAngles );
ADDRLP4 192
CNSTF4 0
ASGNF4
ADDRLP4 192+4
CNSTF4 0
ASGNF4
ADDRLP4 192+8
CNSTF4 0
ASGNF4
line 374
;373:
;374:		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP )
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
EQI4 $314
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $312
LABELV $314
line 375
;375:		{
line 376
;376:			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 )
ADDRLP4 208
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+4+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 208
INDIRI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $315
line 377
;377:			{
line 378
;378:				if ( item->giType == IT_POWERUP )
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $320
line 379
;379:				{
line 380
;380:					ent.origin[2] += 12;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 381
;381:					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
ADDRLP4 192+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 3128950784
MULF4
ASGNF4
line 382
;382:				}
LABELV $320
line 383
;383:				AnglesToAxis( spinAngles, ent.axis );
ADDRLP4 192
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 386
;384:				
;385:				// scale up if respawning
;386:				if ( frac != 1.0 ) {
ADDRLP4 148
INDIRF4
CNSTF4 1065353216
EQF4 $327
line 387
;387:					VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 388
;388:					VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 389
;389:					VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 390
;390:					ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 391
;391:				}
LABELV $327
line 392
;392:				trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 393
;393:			}
LABELV $315
line 394
;394:		}
LABELV $312
line 395
;395:	}
LABELV $307
line 396
;396:}
LABELV $128
endproc CG_Item 232 12
proc CG_Missile 168 20
line 405
;397:
;398://============================================================================
;399:
;400:/*
;401:===============
;402:CG_Missile
;403:===============
;404:*/
;405:static void CG_Missile( centity_t *cent ) {
line 412
;406:	refEntity_t			ent;
;407:	entityState_t		*s1;
;408:	const weaponInfo_t	*weapon;
;409:	const clientInfo_t	*ci;
;410://	int	col;
;411:
;412:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 413
;413:	if ( s1->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
LTI4 $373
line 414
;414:		s1->weapon = WP_NONE;
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 415
;415:	}
LABELV $373
line 416
;416:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 144
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 419
;417:
;418:	// calculate the axis
;419:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 422
;420:
;421:	// add trails
;422:	if ( weapon->missileTrailFunc ) 
ADDRLP4 144
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $375
line 423
;423:	{
line 424
;424:		weapon->missileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 425
;425:	}
LABELV $375
line 444
;426:/*
;427:	if ( cent->currentState.modelindex == TEAM_RED ) {
;428:		col = 1;
;429:	}
;430:	else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;431:		col = 2;
;432:	}
;433:	else {
;434:		col = 0;
;435:	}
;436:
;437:	// add dynamic light
;438:	if ( weapon->missileDlight ) {
;439:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
;440:			weapon->missileDlightColor[col][0], weapon->missileDlightColor[col][1], weapon->missileDlightColor[col][2] );
;441:	}
;442:*/
;443:	// add dynamic light
;444:	if ( weapon->missileDlight ) {
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
CNSTF4 0
EQF4 $377
line 445
;445:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRLP4 144
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 447
;446:			weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
;447:	}
LABELV $377
line 450
;448:
;449:	// add missile sound
;450:	if ( weapon->missileSound ) {
ADDRLP4 144
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $379
line 453
;451:		vec3_t	velocity;
;452:
;453:		BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 455
;454:
;455:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 456
;456:	}
LABELV $379
line 459
;457:
;458:	// create the render entity
;459:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 460
;460:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 461
;461:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 463
;462:
;463:	if ( cent->currentState.weapon == WP_PLASMAGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 8
NEI4 $384
line 464
;464:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 465
;465:		ent.radius = 16;
ADDRLP4 0+132
CNSTF4 1098907648
ASGNF4
line 466
;466:		ent.rotation = 0;
ADDRLP4 0+136
CNSTF4 0
ASGNF4
line 467
;467:		ent.customShader = cgs.media.plasmaBallShader;
ADDRLP4 0+112
ADDRGP4 cgs+148752+288
INDIRI4
ASGNI4
line 468
;468:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 469
;469:		return;
ADDRGP4 $372
JUMPV
LABELV $384
line 473
;470:	}
;471:
;472:	// flicker between two skins
;473:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 474
;474:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 475
;475:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 144
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 486
;476:
;477:#ifdef MISSIONPACK
;478:	if ( cent->currentState.weapon == WP_PROX_LAUNCHER ) {
;479:		if (s1->generic1 == TEAM_BLUE) {
;480:			ent.hModel = cgs.media.blueProxMine;
;481:		}
;482:	}
;483:#endif
;484:
;485:	// convert direction of travel into axis
;486:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 152
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 0
NEF4 $394
line 487
;487:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 488
;488:	}
LABELV $394
line 491
;489:
;490:	// spin as it moves
;491:	if ( s1->pos.trType != TR_STATIONARY ) {
ADDRLP4 140
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $399
line 492
;492:		RotateAroundDirection( ent.axis, ( cg.time % TMOD_004 ) / 4.0 );
ADDRLP4 0+28
ARGP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4272943
MODI4
CVIF4 4
CNSTF4 1048576000
MULF4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 493
;493:	} else {
ADDRGP4 $400
JUMPV
LABELV $399
line 500
;494:#ifdef MISSIONPACK
;495:		if ( s1->weapon == WP_PROX_LAUNCHER ) {
;496:			AnglesToAxis( cent->lerpAngles, ent.axis );
;497:		}
;498:		else
;499:#endif
;500:		{
line 501
;501:			RotateAroundDirection( ent.axis, s1->time );
ADDRLP4 0+28
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 502
;502:		}
line 503
;503:	}
LABELV $400
line 507
;504:
;505:	// add to refresh list, possibly with quad glow
;506:
;507:	s1->powerups &= ~( (1 << PW_INVIS) | (1 << PW_REGEN) );
ADDRLP4 156
ADDRLP4 140
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 -49
BANDI4
ASGNI4
line 508
;508:	ci = &cgs.clientinfo[ s1->clientNum & MAX_CLIENTS ];
ADDRLP4 148
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 509
;509:	if ( ci->infoValid ) {
ADDRLP4 148
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $405
line 510
;510:		CG_AddRefEntityWithPowerups( &ent, s1, ci->team );
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 511
;511:	} else {
ADDRGP4 $406
JUMPV
LABELV $405
line 512
;512:		CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE );
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 513
;513:	}
LABELV $406
line 515
;514:
;515:}
LABELV $372
endproc CG_Missile 168 20
proc CG_Grapple 152 12
line 524
;516:
;517:/*
;518:===============
;519:CG_Grapple
;520:
;521:This is called when the grapple is sitting up against the wall
;522:===============
;523:*/
;524:static void CG_Grapple( centity_t *cent ) {
line 529
;525:	refEntity_t			ent;
;526:	entityState_t		*s1;
;527:	const weaponInfo_t		*weapon;
;528:
;529:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 530
;530:	if ( s1->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
LTI4 $408
line 531
;531:		s1->weapon = WP_NONE;
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 532
;532:	}
LABELV $408
line 533
;533:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 144
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 536
;534:
;535:	// calculate the axis
;536:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 546
;537:
;538:#if 0 // FIXME add grapple pull sound here..?
;539:	// add missile sound
;540:	if ( weapon->missileSound ) {
;541:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->missileSound );
;542:	}
;543:#endif
;544:
;545:	// Will draw cable if needed
;546:	CG_GrappleTrail ( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 CG_GrappleTrail
CALLV
pop
line 549
;547:
;548:	// create the render entity
;549:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 550
;550:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 551
;551:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 554
;552:
;553:	// flicker between two skins
;554:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 555
;555:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 556
;556:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 144
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 559
;557:
;558:	// convert direction of travel into axis
;559:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 148
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 148
INDIRF4
CNSTF4 0
NEF4 $415
line 560
;560:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 561
;561:	}
LABELV $415
line 563
;562:
;563:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 564
;564:}
LABELV $407
endproc CG_Grapple 152 12
proc CG_Mover 144 12
line 571
;565:
;566:/*
;567:===============
;568:CG_Mover
;569:===============
;570:*/
;571:static void CG_Mover( const centity_t *cent ) {
line 575
;572:	refEntity_t			ent;
;573:	const entityState_t	*s1;
;574:
;575:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 578
;576:
;577:	// create the render entity
;578:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 579
;579:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 580
;580:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 581
;581:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 583
;582:
;583:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 586
;584:
;585:	// flicker between two skins (FIXME?)
;586:	ent.skinNum = ( cg.time >> 6 ) & 1;
ADDRLP4 0+104
ADDRGP4 cg+107604
INDIRI4
CNSTI4 6
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 589
;587:
;588:	// get the model, either as a bmodel or a modelindex
;589:	if ( s1->solid == SOLID_BMODEL ) {
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $427
line 590
;590:		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36900
ADDP4
INDIRI4
ASGNI4
line 591
;591:	} else {
ADDRGP4 $428
JUMPV
LABELV $427
line 592
;592:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34848
ADDP4
INDIRI4
ASGNI4
line 593
;593:	}
LABELV $428
line 596
;594:
;595:	// add to refresh list
;596:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 599
;597:
;598:	// add the secondary model
;599:	if ( s1->modelindex2 ) {
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $433
line 600
;600:		ent.skinNum = 0;
ADDRLP4 0+104
CNSTI4 0
ASGNI4
line 601
;601:		ent.hModel = cgs.gameModels[ s1->modelindex2 % MAX_MODELS ];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 256
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34848
ADDP4
INDIRI4
ASGNI4
line 602
;602:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 603
;603:	}
LABELV $433
line 605
;604:
;605:}
LABELV $420
endproc CG_Mover 144 12
export CG_Beam
proc CG_Beam 144 12
line 614
;606:
;607:/*
;608:===============
;609:CG_Beam
;610:
;611:Also called as an event
;612:===============
;613:*/
;614:void CG_Beam( const centity_t *cent ) {
line 618
;615:	refEntity_t			ent;
;616:	const entityState_t	*s1;
;617:
;618:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 621
;619:
;620:	// create the render entity
;621:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 622
;622:	VectorCopy( s1->pos.trBase, ent.origin );
ADDRLP4 0+68
ADDRLP4 140
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 623
;623:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 624
;624:	AxisClear( ent.axis );
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 625
;625:	ent.reType = RT_BEAM;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 627
;626:
;627:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 628
;628:	ent.customShader = cgs.media.whiteShader;
ADDRLP4 0+112
ADDRGP4 cgs+148752+16
INDIRI4
ASGNI4
line 631
;629:
;630:	// add to refresh list
;631:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 632
;632:}
LABELV $438
endproc CG_Beam 144 12
proc CG_Portal 144 12
line 640
;633:
;634:
;635:/*
;636:===============
;637:CG_Portal
;638:===============
;639:*/
;640:static void CG_Portal( const centity_t *cent ) {
line 644
;641:	refEntity_t			ent;
;642:	const entityState_t *s1;
;643:
;644:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 647
;645:
;646:	// create the render entity
;647:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 648
;648:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 649
;649:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 650
;650:	ByteToDir( s1->eventParm, ent.axis[0] );
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 0+28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 651
;651:	PerpendicularVector( ent.axis[1], ent.axis[0] );
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 655
;652:
;653:	// negating this tends to get the directions like they want
;654:	// we really should have a camera roll value
;655:	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );
ADDRLP4 0+28+12
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0+28+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
SUBF4
ASGNF4
line 657
;656:
;657:	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
ADDRLP4 0+28
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 658
;658:	ent.reType = RT_PORTALSURFACE;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 659
;659:	ent.oldframe = s1->powerups;
ADDRLP4 0+96
ADDRLP4 140
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 660
;660:	ent.frame = s1->frame;		// rotation speed
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 661
;661:	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset
ADDRLP4 0+104
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1068761088
MULF4
CVFI4 4
ASGNI4
line 664
;662:
;663:	// add to refresh list
;664:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 665
;665:}
LABELV $446
endproc CG_Portal 144 12
export CG_AdjustPositionForMover
proc CG_AdjustPositionForMover 80 12
line 675
;666:
;667:
;668:/*
;669:=========================
;670:CG_AdjustPositionForMover
;671:
;672:Also called by client movement prediction code
;673:=========================
;674:*/
;675:void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out, const vec3_t angles_in, vec3_t angles_out ) {
line 680
;676:	centity_t	*cent;
;677:	vec3_t	oldOrigin, origin, deltaOrigin;
;678:	vec3_t	oldAngles, angles, deltaAngles;
;679:
;680:	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LEI4 $482
ADDRLP4 76
INDIRI4
CNSTI4 1022
LTI4 $480
LABELV $482
line 681
;681:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 682
;682:		VectorCopy( angles_in, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRB
ASGNB 12
line 683
;683:		return;
ADDRGP4 $479
JUMPV
LABELV $480
line 686
;684:	}
;685:
;686:	cent = &cg_entities[ moverNum ];
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 687
;687:	if ( cent->currentState.eType != ET_MOVER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
EQI4 $483
line 688
;688:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 689
;689:		VectorCopy( angles_in, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRB
ASGNB 12
line 690
;690:		return;
ADDRGP4 $479
JUMPV
LABELV $483
line 693
;691:	}
;692:
;693:	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 694
;694:	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 696
;695:
;696:	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 697
;697:	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 64
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 699
;698:
;699:	VectorSubtract( origin, oldOrigin, deltaOrigin );
ADDRLP4 4
ADDRLP4 40
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 700
;700:	VectorSubtract( angles, oldAngles, deltaAngles );
ADDRLP4 16
ADDRLP4 64
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 64+4
INDIRF4
ADDRLP4 52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 64+8
INDIRF4
ADDRLP4 52+8
INDIRF4
SUBF4
ASGNF4
line 702
;701:
;702:	VectorAdd( in, deltaOrigin, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 703
;703:	VectorAdd( angles_in, deltaAngles, angles_out );
ADDRFP4 24
INDIRP4
ADDRFP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDF4
ASGNF4
line 705
;704:	// FIXME: origin change when on a rotating object
;705:}
LABELV $479
endproc CG_AdjustPositionForMover 80 12
proc CG_InterpolateEntityPosition 44 12
line 713
;706:
;707:
;708:/*
;709:=============================
;710:CG_InterpolateEntityPosition
;711:=============================
;712:*/
;713:static void CG_InterpolateEntityPosition( centity_t *cent ) {
line 719
;714:	vec3_t		current, next;
;715:	float		f;
;716:
;717:	// it would be an internal error to find an entity that interpolates without
;718:	// a snapshot ahead of the current one
;719:	if ( cg.nextSnap == NULL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $502
line 720
;720:		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
ADDRGP4 $505
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 721
;721:	}
LABELV $502
line 723
;722:
;723:	f = cg.frameInterpolation;
ADDRLP4 24
ADDRGP4 cg+107588
INDIRF4
ASGNF4
line 727
;724:
;725:	// this will linearize a sine or parabolic curve, but it is important
;726:	// to not extrapolate player positions if more recent data is available
;727:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
ADDRFP4 0
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
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 728
;728:	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 730
;729:
;730:	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 731
;731:	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 732
;732:	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 734
;733:
;734:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 735
;735:	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 737
;736:
;737:	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 738
;738:	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 739
;739:	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 741
;740:
;741:}
LABELV $501
endproc CG_InterpolateEntityPosition 44 12
proc CG_CalcEntityLerpPositions 20 28
line 749
;742:
;743:/*
;744:===============
;745:CG_CalcEntityLerpPositions
;746:
;747:===============
;748:*/
;749:static void CG_CalcEntityLerpPositions( centity_t *cent ) {
line 752
;750:
;751:	// if this player does not want to see extrapolated players
;752:	if ( !cg_smoothClients.integer ) {
ADDRGP4 cg_smoothClients+12
INDIRI4
CNSTI4 0
NEI4 $522
line 754
;753:		// make sure the clients use TR_INTERPOLATE
;754:		if ( cent->currentState.number < MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $525
line 755
;755:			cent->currentState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 756
;756:			cent->nextState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 1
ASGNI4
line 757
;757:		}
LABELV $525
line 758
;758:	}
LABELV $522
line 760
;759:
;760:	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
NEI4 $527
line 761
;761:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 762
;762:		return;
ADDRGP4 $521
JUMPV
LABELV $527
line 767
;763:	}
;764:
;765:	// first see if we can interpolate between two snaps for
;766:	// linear extrapolated clients
;767:	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $529
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $529
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $529
line 768
;768:											cent->currentState.number < MAX_CLIENTS) {
line 769
;769:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 770
;770:		return;
ADDRGP4 $521
JUMPV
LABELV $529
line 774
;771:	}
;772:
;773:	// just use the current frame and evaluate as best we can
;774:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 775
;775:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 779
;776:
;777:	// adjust for riding a mover if it wasn't rolled into the predicted
;778:	// player state
;779:	if ( cent != &cg.predictedPlayerEntity ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg+108104
CVPU4 4
EQU4 $533
line 780
;780:		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum, 
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 782
;781:		cg.snap->serverTime, cg.time, cent->lerpOrigin, cent->lerpAngles, cent->lerpAngles );
;782:	}
LABELV $533
line 783
;783:}
LABELV $521
endproc CG_CalcEntityLerpPositions 20 28
proc CG_TeamBase 140 12
line 790
;784:
;785:/*
;786:===============
;787:CG_TeamBase
;788:===============
;789:*/
;790:static void CG_TeamBase( const centity_t *cent ) {
line 799
;791:	refEntity_t model;
;792:#ifdef MISSIONPACK
;793:	vec3_t angles;
;794:	int t, h;
;795:	float c;
;796:
;797:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF ) {
;798:#else
;799:	if ( cgs.gametype == GT_CTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $539
line 802
;800:#endif
;801:		// show the flag base
;802:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 803
;803:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 804
;804:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 805
;805:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 806
;806:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 807
;807:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $545
line 808
;808:			model.hModel = cgs.media.redFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+148752+108
INDIRI4
ASGNI4
line 809
;809:		}
ADDRGP4 $546
JUMPV
LABELV $545
line 810
;810:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $550
line 811
;811:			model.hModel = cgs.media.blueFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+148752+112
INDIRI4
ASGNI4
line 812
;812:		}
ADDRGP4 $551
JUMPV
LABELV $550
line 813
;813:		else {
line 814
;814:			model.hModel = cgs.media.neutralFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+148752+116
INDIRI4
ASGNI4
line 815
;815:		}
LABELV $551
LABELV $546
line 816
;816:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 817
;817:	}
LABELV $539
line 936
;818:#ifdef MISSIONPACK
;819:	else if ( cgs.gametype == GT_OBELISK ) {
;820:		// show the obelisk
;821:		memset(&model, 0, sizeof(model));
;822:		model.reType = RT_MODEL;
;823:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;824:		VectorCopy( cent->lerpOrigin, model.origin );
;825:		AnglesToAxis( cent->currentState.angles, model.axis );
;826:
;827:		model.hModel = cgs.media.overloadBaseModel;
;828:		trap_R_AddRefEntityToScene( &model );
;829:		// if hit
;830:		if ( cent->currentState.frame == 1) {
;831:			// show hit model
;832:			// modelindex2 is the health value of the obelisk
;833:			c = cent->currentState.modelindex2;
;834:			model.shaderRGBA[0] = 0xff;
;835:			model.shaderRGBA[1] = c;
;836:			model.shaderRGBA[2] = c;
;837:			model.shaderRGBA[3] = 0xff;
;838:			//
;839:			model.hModel = cgs.media.overloadEnergyModel;
;840:			trap_R_AddRefEntityToScene( &model );
;841:		}
;842:		// if respawning
;843:		if ( cent->currentState.frame == 2) {
;844:			if ( !cent->miscTime ) {
;845:				cent->miscTime = cg.time;
;846:			}
;847:			t = cg.time - cent->miscTime;
;848:			h = (cg_obeliskRespawnDelay.integer - 5) * 1000;
;849:			//
;850:			if (t > h) {
;851:				c = (float) (t - h) / h;
;852:				if (c > 1)
;853:					c = 1;
;854:			}
;855:			else {
;856:				c = 0;
;857:			}
;858:			// show the lights
;859:			AnglesToAxis( cent->currentState.angles, model.axis );
;860:			//
;861:			model.shaderRGBA[0] = c * 0xff;
;862:			model.shaderRGBA[1] = c * 0xff;
;863:			model.shaderRGBA[2] = c * 0xff;
;864:			model.shaderRGBA[3] = c * 0xff;
;865:
;866:			model.hModel = cgs.media.overloadLightsModel;
;867:			trap_R_AddRefEntityToScene( &model );
;868:			// show the target
;869:			if (t > h) {
;870:				if ( !cent->muzzleFlashTime ) {
;871:					trap_S_StartSound (cent->lerpOrigin, ENTITYNUM_NONE, CHAN_BODY,  cgs.media.obeliskRespawnSound);
;872:					cent->muzzleFlashTime = 1;
;873:				}
;874:				VectorCopy(cent->currentState.angles, angles);
;875:				angles[YAW] += (float) 16 * acos(1-c) * 180 / M_PI;
;876:				AnglesToAxis( angles, model.axis );
;877:
;878:				VectorScale( model.axis[0], c, model.axis[0]);
;879:				VectorScale( model.axis[1], c, model.axis[1]);
;880:				VectorScale( model.axis[2], c, model.axis[2]);
;881:
;882:				model.shaderRGBA[0] = 0xff;
;883:				model.shaderRGBA[1] = 0xff;
;884:				model.shaderRGBA[2] = 0xff;
;885:				model.shaderRGBA[3] = 0xff;
;886:				//
;887:				model.origin[2] += 56;
;888:				model.hModel = cgs.media.overloadTargetModel;
;889:				trap_R_AddRefEntityToScene( &model );
;890:			}
;891:			else {
;892:				//FIXME: show animated smoke
;893:			}
;894:		}
;895:		else {
;896:			cent->miscTime = 0;
;897:			cent->muzzleFlashTime = 0;
;898:			// modelindex2 is the health value of the obelisk
;899:			c = cent->currentState.modelindex2;
;900:			model.shaderRGBA[0] = 0xff;
;901:			model.shaderRGBA[1] = c;
;902:			model.shaderRGBA[2] = c;
;903:			model.shaderRGBA[3] = 0xff;
;904:			// show the lights
;905:			model.hModel = cgs.media.overloadLightsModel;
;906:			trap_R_AddRefEntityToScene( &model );
;907:			// show the target
;908:			model.origin[2] += 56;
;909:			model.hModel = cgs.media.overloadTargetModel;
;910:			trap_R_AddRefEntityToScene( &model );
;911:		}
;912:	}
;913:	else if ( cgs.gametype == GT_HARVESTER ) {
;914:		// show harvester model
;915:		memset(&model, 0, sizeof(model));
;916:		model.reType = RT_MODEL;
;917:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;918:		VectorCopy( cent->lerpOrigin, model.origin );
;919:		AnglesToAxis( cent->currentState.angles, model.axis );
;920:
;921:		if ( cent->currentState.modelindex == TEAM_RED ) {
;922:			model.hModel = cgs.media.harvesterModel;
;923:			model.customSkin = cgs.media.harvesterRedSkin;
;924:		}
;925:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;926:			model.hModel = cgs.media.harvesterModel;
;927:			model.customSkin = cgs.media.harvesterBlueSkin;
;928:		}
;929:		else {
;930:			model.hModel = cgs.media.harvesterNeutralModel;
;931:			model.customSkin = 0;
;932:		}
;933:		trap_R_AddRefEntityToScene( &model );
;934:	}
;935:#endif
;936:}
LABELV $538
endproc CG_TeamBase 140 12
proc CG_AddCEntity 8 8
line 944
;937:
;938:/*
;939:===============
;940:CG_AddCEntity
;941:
;942:===============
;943:*/
;944:static void CG_AddCEntity( centity_t *cent ) {
line 946
;945:	// event-only entities will have been dealt with already
;946:	if ( cent->currentState.eType >= ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LTI4 $559
line 947
;947:		return;
ADDRGP4 $558
JUMPV
LABELV $559
line 951
;948:	}
;949:
;950:	// calculate the current origin
;951:	CG_CalcEntityLerpPositions( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 954
;952:
;953:	// add automatic effects
;954:	CG_EntityEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_EntityEffects
CALLV
pop
line 956
;955:
;956:	switch ( cent->currentState.eType ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $561
ADDRLP4 0
INDIRI4
CNSTI4 12
GTI4 $561
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $576
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $576
address $566
address $567
address $568
address $569
address $570
address $571
address $572
address $573
address $562
address $562
address $562
address $574
address $575
code
LABELV $561
line 958
;957:	default:
;958:		CG_Error( "Bad entity type: %i", cent->currentState.eType );
ADDRGP4 $564
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 959
;959:		break;
ADDRGP4 $562
JUMPV
line 963
;960:	case ET_INVISIBLE:
;961:	case ET_PUSH_TRIGGER:
;962:	case ET_TELEPORT_TRIGGER:
;963:		break;
LABELV $566
line 965
;964:	case ET_GENERAL:
;965:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 966
;966:		break;
ADDRGP4 $562
JUMPV
LABELV $567
line 968
;967:	case ET_PLAYER:
;968:		CG_Player( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 969
;969:		break;
ADDRGP4 $562
JUMPV
LABELV $568
line 971
;970:	case ET_ITEM:
;971:		CG_Item( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 972
;972:		break;
ADDRGP4 $562
JUMPV
LABELV $569
line 974
;973:	case ET_MISSILE:
;974:		CG_Missile( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Missile
CALLV
pop
line 975
;975:		break;
ADDRGP4 $562
JUMPV
LABELV $570
line 977
;976:	case ET_MOVER:
;977:		CG_Mover( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 978
;978:		break;
ADDRGP4 $562
JUMPV
LABELV $571
line 980
;979:	case ET_BEAM:
;980:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 981
;981:		break;
ADDRGP4 $562
JUMPV
LABELV $572
line 983
;982:	case ET_PORTAL:
;983:		CG_Portal( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 984
;984:		break;
ADDRGP4 $562
JUMPV
LABELV $573
line 986
;985:	case ET_SPEAKER:
;986:		CG_Speaker( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Speaker
CALLV
pop
line 987
;987:		break;
ADDRGP4 $562
JUMPV
LABELV $574
line 989
;988:	case ET_GRAPPLE:
;989:		CG_Grapple( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Grapple
CALLV
pop
line 990
;990:		break;
ADDRGP4 $562
JUMPV
LABELV $575
line 992
;991:	case ET_TEAM:
;992:		CG_TeamBase( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 993
;993:		break;
LABELV $562
line 995
;994:	}
;995:}
LABELV $558
endproc CG_AddCEntity 8 8
export CG_AddPacketEntities
proc CG_AddPacketEntities 16 12
line 1003
;996:
;997:/*
;998:===============
;999:CG_AddPacketEntities
;1000:
;1001:===============
;1002:*/
;1003:void CG_AddPacketEntities( void ) {
line 1009
;1004:	int					num;
;1005:	centity_t			*cent;
;1006:	playerState_t		*ps;
;1007:
;1008:	// set cg.frameInterpolation
;1009:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $578
line 1012
;1010:		int		delta;
;1011:
;1012:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1013
;1013:		if ( delta == 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $583
line 1014
;1014:			cg.frameInterpolation = 0;
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1015
;1015:		} else {
ADDRGP4 $579
JUMPV
LABELV $583
line 1016
;1016:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+107588
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1017
;1017:		}
line 1018
;1018:	} else {
ADDRGP4 $579
JUMPV
LABELV $578
line 1019
;1019:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1021
;1020:									// no entities should be marked as interpolating
;1021:	}
LABELV $579
line 1024
;1022:
;1023:	// the auto-rotating items will all have the same axis
;1024:	cg.autoAngles[0] = 0;
ADDRGP4 cg+108960
CNSTF4 0
ASGNF4
line 1025
;1025:	cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRGP4 cg+108960+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 973078528
MULF4
ASGNF4
line 1026
;1026:	cg.autoAngles[2] = 0;
ADDRGP4 cg+108960+8
CNSTF4 0
ASGNF4
line 1028
;1027:
;1028:	cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+109008
CNSTF4 0
ASGNF4
line 1029
;1029:	cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
ADDRGP4 cg+109008+4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
CNSTI4 360
MULI4
CVIF4 4
CNSTF4 981467136
MULF4
ASGNF4
line 1030
;1030:	cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+109008+8
CNSTF4 0
ASGNF4
line 1032
;1031:
;1032:	AnglesToAxis( cg.autoAngles, cg.autoAxis );
ADDRGP4 cg+108960
ARGP4
ADDRGP4 cg+108972
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1033
;1033:	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );
ADDRGP4 cg+109008
ARGP4
ADDRGP4 cg+109020
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1036
;1034:
;1035:	// generate and add the entity from the playerstate
;1036:	ps = &cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
ASGNP4
line 1037
;1037:	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+108104
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1038
;1038:	CG_AddCEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1041
;1039:
;1040:	// lerp the non-predicted value for lightning gun origins
;1041:	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1044
;1042:
;1043:	// add each entity sent over by the server
;1044:	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $613
JUMPV
LABELV $610
line 1045
;1045:		cent = &cg_entities[ cg.snap->entities[ num ].number ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 208
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1046
;1046:		CG_AddCEntity( cent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1047
;1047:	}
LABELV $611
line 1044
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $613
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $610
line 1048
;1048:}
LABELV $577
endproc CG_AddPacketEntities 16 12
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
LABELV $564
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $505
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 112
byte 1 111
byte 1 97
byte 1 116
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $131
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
