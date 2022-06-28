data
align 4
LABELV cg_customSoundNames
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
address $89
skip 76
export CG_CustomSound
code
proc CG_CustomSound 16 8
file "..\..\..\..\code\cgame\cg_players.c"
line 31
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_players.c -- handle the media and animation for player entities
;4:#include "cg_local.h"
;5:
;6:#define	PM_SKIN "pm"
;7:
;8:static const char *cg_customSoundNames[ MAX_CUSTOM_SOUNDS ] = {
;9:	"*death1.wav",
;10:	"*death2.wav",
;11:	"*death3.wav",
;12:	"*jump1.wav",
;13:	"*pain25_1.wav",
;14:	"*pain50_1.wav",
;15:	"*pain75_1.wav",
;16:	"*pain100_1.wav",
;17:	"*falling1.wav",
;18:	"*gasp.wav",
;19:	"*drown.wav",
;20:	"*fall1.wav",
;21:	"*taunt.wav"
;22:};
;23:
;24:
;25:/*
;26:================
;27:CG_CustomSound
;28:
;29:================
;30:*/
;31:sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
line 35
;32:	clientInfo_t *ci;
;33:	int			i;
;34:
;35:	if ( soundName[0] != '*' ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $91
line 36
;36:		return trap_S_RegisterSound( soundName, qfalse );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $90
JUMPV
LABELV $91
line 39
;37:	}
;38:
;39:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $95
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $93
LABELV $95
line 40
;40:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 41
;41:	}
LABELV $93
line 42
;42:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 44
;43:
;44:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $100
JUMPV
LABELV $97
line 45
;45:		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $101
line 46
;46:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $90
JUMPV
LABELV $101
line 48
;47:		}
;48:	}
LABELV $98
line 44
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $100
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $103
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $97
LABELV $103
line 50
;49:
;50:	CG_Error( "Unknown custom sound: %s", soundName );
ADDRGP4 $104
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 51
;51:	return 0;
CNSTI4 0
RETI4
LABELV $90
endproc CG_CustomSound 16 8
proc CG_ParseAnimationFile 20076 12
line 72
;52:}
;53:
;54:
;55:
;56:/*
;57:=============================================================================
;58:
;59:CLIENT INFO
;60:
;61:=============================================================================
;62:*/
;63:
;64:/*
;65:======================
;66:CG_ParseAnimationFile
;67:
;68:Read a configuration file containing animation counts and rates
;69:models/players/visor/animation.cfg, etc
;70:======================
;71:*/
;72:static qboolean	CG_ParseAnimationFile( const char *filename, clientInfo_t *ci ) {
line 83
;73:	char		*text_p, *prev;
;74:	int			len;
;75:	int			i;
;76:	char		*token;
;77:	float		fps;
;78:	int			skip;
;79:	char		text[20000];
;80:	fileHandle_t	f;
;81:	animation_t *animations;
;82:
;83:	animations = ci->animations;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 448
ADDP4
ASGNP4
line 86
;84:
;85:	// load the file
;86:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 20036
INDIRI4
ASGNI4
line 87
;87:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $106
line 88
;88:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $106
line 90
;89:	}
;90:	if ( len <= 0 ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GTI4 $108
line 91
;91:		trap_FS_FCloseFile( f );
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 92
;92:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $108
line 94
;93:	}
;94:	if ( len >= sizeof( text ) - 1 ) {
ADDRLP4 28
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $110
line 95
;95:		CG_Printf( "File %s too long\n", filename );
ADDRGP4 $112
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 96
;96:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $110
line 98
;97:	}
;98:	trap_FS_Read( text, len, f );
ADDRLP4 36
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 99
;99:	text[len] = '\0';
ADDRLP4 28
INDIRI4
ADDRLP4 36
ADDP4
CNSTI1 0
ASGNI1
line 100
;100:	trap_FS_FCloseFile( f );
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 103
;101:
;102:	// parse the text
;103:	text_p = text;
ADDRLP4 12
ADDRLP4 36
ASGNP4
line 104
;104:	skip = 0;	// quite the compiler warning
ADDRLP4 24
CNSTI4 0
ASGNI4
line 106
;105:
;106:	ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 0
ASGNI4
line 107
;107:	VectorClear( ci->headOffset );
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
CNSTF4 0
ASGNF4
line 108
;108:	ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 109
;109:	ci->fixedlegs = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 0
ASGNI4
line 110
;110:	ci->fixedtorso = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $113
line 113
;111:
;112:	// read optional parameters
;113:	while ( 1 ) {
line 114
;114:		prev = text_p;	// so we can unget
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
line 115
;115:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20040
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20040
INDIRP4
ASGNP4
line 116
;116:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 117
;117:			break;
ADDRGP4 $115
JUMPV
LABELV $116
line 119
;118:		}
;119:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRLP4 20044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20044
INDIRI4
CNSTI4 0
NEI4 $118
line 120
;120:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 121
;121:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $121
line 122
;122:				break;
ADDRGP4 $115
JUMPV
LABELV $121
line 124
;123:			}
;124:			if ( !Q_stricmp( token, "default" ) || !Q_stricmp( token, "normal" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
EQI4 $127
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $123
LABELV $127
line 125
;125:				ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 0
ASGNI4
line 126
;126:			} else if ( !Q_stricmp( token, "boot" ) ) {
ADDRGP4 $114
JUMPV
LABELV $123
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $130
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $128
line 127
;127:				ci->footsteps = FOOTSTEP_BOOT;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 1
ASGNI4
line 128
;128:			} else if ( !Q_stricmp( token, "flesh" ) ) {
ADDRGP4 $114
JUMPV
LABELV $128
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $133
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $131
line 129
;129:				ci->footsteps = FOOTSTEP_FLESH;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 2
ASGNI4
line 130
;130:			} else if ( !Q_stricmp( token, "mech" ) ) {
ADDRGP4 $114
JUMPV
LABELV $131
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $136
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $134
line 131
;131:				ci->footsteps = FOOTSTEP_MECH;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 3
ASGNI4
line 132
;132:			} else if ( !Q_stricmp( token, "energy" ) ) {
ADDRGP4 $114
JUMPV
LABELV $134
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $139
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $137
line 133
;133:				ci->footsteps = FOOTSTEP_ENERGY;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 4
ASGNI4
line 134
;134:			} else {
ADDRGP4 $114
JUMPV
LABELV $137
line 135
;135:				CG_Printf( "Bad footsteps parm in %s: %s\n", filename, token );
ADDRGP4 $140
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 136
;136:			}
line 137
;137:			continue;
ADDRGP4 $114
JUMPV
LABELV $118
line 138
;138:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $143
ARGP4
ADDRLP4 20048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20048
INDIRI4
CNSTI4 0
NEI4 $141
line 139
;139:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $144
line 140
;140:				token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 141
;141:				if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $148
line 142
;142:					break;
ADDRGP4 $114
JUMPV
LABELV $148
line 144
;143:				}
;144:				ci->headOffset[i] = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
ADDP4
ADDRLP4 20056
INDIRF4
ASGNF4
line 145
;145:			}
LABELV $145
line 139
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $144
line 146
;146:			continue;
ADDRGP4 $114
JUMPV
LABELV $141
line 147
;147:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
NEI4 $150
line 148
;148:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20056
INDIRP4
ASGNP4
line 149
;149:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $153
line 150
;150:				break;
ADDRGP4 $115
JUMPV
LABELV $153
line 152
;151:			}
;152:			if ( token[0] == 'f' || token[0] == 'F' ) {
ADDRLP4 20060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 102
EQI4 $157
ADDRLP4 20060
INDIRI4
CNSTI4 70
NEI4 $155
LABELV $157
line 153
;153:				ci->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 154
;154:			} else if ( token[0] == 'n' || token[0] == 'N' ) {
ADDRGP4 $114
JUMPV
LABELV $155
ADDRLP4 20064
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 110
EQI4 $160
ADDRLP4 20064
INDIRI4
CNSTI4 78
NEI4 $158
LABELV $160
line 155
;155:				ci->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 2
ASGNI4
line 156
;156:			} else {
ADDRGP4 $114
JUMPV
LABELV $158
line 157
;157:				ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 158
;158:			}
line 159
;159:			continue;
ADDRGP4 $114
JUMPV
LABELV $150
line 160
;160:		} else if ( !Q_stricmp( token, "fixedlegs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $161
line 161
;161:			ci->fixedlegs = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 1
ASGNI4
line 162
;162:			continue;
ADDRGP4 $114
JUMPV
LABELV $161
line 163
;163:		} else if ( !Q_stricmp( token, "fixedtorso" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $166
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $164
line 164
;164:			ci->fixedtorso = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 1
ASGNI4
line 165
;165:			continue;
ADDRGP4 $114
JUMPV
LABELV $164
line 169
;166:		}
;167:
;168:		// if it is a number, start parsing animations
;169:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20064
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 48
LTI4 $167
ADDRLP4 20064
INDIRI4
CNSTI4 57
GTI4 $167
line 170
;170:			text_p = prev;	// unget the token
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 171
;171:			break;
ADDRGP4 $115
JUMPV
LABELV $167
line 173
;172:		}
;173:		Com_Printf( "unknown token '%s' in %s\n", token, filename );
ADDRGP4 $169
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 174
;174:	}
LABELV $114
line 113
ADDRGP4 $113
JUMPV
LABELV $115
line 177
;175:
;176:	// read information for each frame
;177:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $170
line 179
;178:
;179:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20040
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20040
INDIRP4
ASGNP4
line 180
;180:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $174
line 181
;181:			if( i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE ) {
ADDRLP4 4
INDIRI4
CNSTI4 25
LTI4 $172
ADDRLP4 4
INDIRI4
CNSTI4 30
GTI4 $172
line 182
;182:				animations[i].firstFrame = animations[TORSO_GESTURE].firstFrame;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 183
;183:				animations[i].frameLerp = animations[TORSO_GESTURE].frameLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 184
;184:				animations[i].initialLerp = animations[TORSO_GESTURE].initialLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 185
;185:				animations[i].loopFrames = animations[TORSO_GESTURE].loopFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
line 186
;186:				animations[i].numFrames = animations[TORSO_GESTURE].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 187
;187:				animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 188
;188:				animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 189
;189:				continue;
ADDRGP4 $171
JUMPV
line 191
;190:			}
;191:			break;
LABELV $174
line 193
;192:		}
;193:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 20044
INDIRI4
ASGNI4
line 195
;194:		// leg only frames are adjusted to not count the upper body only frames
;195:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $178
line 196
;196:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 24
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 197
;197:		}
LABELV $178
line 198
;198:		if ( i >= LEGS_WALKCR && i<TORSO_GETFLAG) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $180
ADDRLP4 4
INDIRI4
CNSTI4 25
GEI4 $180
line 199
;199:			animations[i].firstFrame -= skip;
ADDRLP4 20052
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20052
INDIRP4
ADDRLP4 20052
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 200
;200:		}
LABELV $180
line 202
;201:
;202:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 203
;203:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $182
line 204
;204:			break;
ADDRGP4 $172
JUMPV
LABELV $182
line 206
;205:		}
;206:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20056
INDIRI4
ASGNI4
line 208
;207:
;208:		animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 209
;209:		animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 211
;210:		// if numFrames is negative the animation is reversed
;211:		if (animations[i].numFrames < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $184
line 212
;212:			animations[i].numFrames = -animations[i].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
NEGI4
ASGNI4
line 213
;213:			animations[i].reversed = qtrue;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 214
;214:		}
LABELV $184
line 216
;215:
;216:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 217
;217:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $186
line 218
;218:			break;
ADDRGP4 $172
JUMPV
LABELV $186
line 220
;219:		}
;220:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20064
INDIRI4
ASGNI4
line 222
;221:
;222:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20068
INDIRP4
ASGNP4
line 223
;223:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $188
line 224
;224:			break;
ADDRGP4 $172
JUMPV
LABELV $188
line 226
;225:		}
;226:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20072
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20072
INDIRF4
ASGNF4
line 227
;227:		if ( fps == 0 ) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $190
line 228
;228:			fps = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 229
;229:		}
LABELV $190
line 230
;230:		animations[i].frameLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 231
;231:		animations[i].initialLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 232
;232:	}
LABELV $171
line 177
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $170
LABELV $172
line 234
;233:
;234:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $192
line 235
;235:		CG_Printf( "Error parsing animation file: %s\n", filename );
ADDRGP4 $194
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 236
;236:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $105
JUMPV
LABELV $192
line 240
;237:	}
;238:
;239:	// crouch backward animation
;240:	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 896
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 241
;241:	animations[LEGS_BACKCR].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 916
ADDP4
CNSTI4 1
ASGNI4
line 243
;242:	// walk backward animation
;243:	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 924
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 392
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 244
;244:	animations[LEGS_BACKWALK].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 1
ASGNI4
line 246
;245:	// flag moving fast
;246:	animations[FLAG_RUN].firstFrame = 0;
ADDRLP4 8
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 0
ASGNI4
line 247
;247:	animations[FLAG_RUN].numFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 16
ASGNI4
line 248
;248:	animations[FLAG_RUN].loopFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 16
ASGNI4
line 249
;249:	animations[FLAG_RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 964
ADDP4
CNSTI4 66
ASGNI4
line 250
;250:	animations[FLAG_RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 968
ADDP4
CNSTI4 66
ASGNI4
line 251
;251:	animations[FLAG_RUN].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 972
ADDP4
CNSTI4 0
ASGNI4
line 253
;252:	// flag not moving or moving slowly
;253:	animations[FLAG_STAND].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 16
ASGNI4
line 254
;254:	animations[FLAG_STAND].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 5
ASGNI4
line 255
;255:	animations[FLAG_STAND].loopFrames = 0;
ADDRLP4 8
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 256
;256:	animations[FLAG_STAND].frameLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 50
ASGNI4
line 257
;257:	animations[FLAG_STAND].initialLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 50
ASGNI4
line 258
;258:	animations[FLAG_STAND].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 260
;259:	// flag speeding up
;260:	animations[FLAG_STAND2RUN].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1008
ADDP4
CNSTI4 16
ASGNI4
line 261
;261:	animations[FLAG_STAND2RUN].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 5
ASGNI4
line 262
;262:	animations[FLAG_STAND2RUN].loopFrames = 1;
ADDRLP4 8
INDIRP4
CNSTI4 1016
ADDP4
CNSTI4 1
ASGNI4
line 263
;263:	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 66
ASGNI4
line 264
;264:	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 66
ASGNI4
line 265
;265:	animations[FLAG_STAND2RUN].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 1
ASGNI4
line 275
;266:	//
;267:	// new anims changes
;268:	//
;269://	animations[TORSO_GETFLAG].flipflop = qtrue;
;270://	animations[TORSO_GUARDBASE].flipflop = qtrue;
;271://	animations[TORSO_PATROL].flipflop = qtrue;
;272://	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
;273://	animations[TORSO_NEGATIVE].flipflop = qtrue;
;274:	//
;275:	return qtrue;
CNSTI4 1
RETI4
LABELV $105
endproc CG_ParseAnimationFile 20076 12
proc CG_FileExists 12 12
line 284
;276:}
;277:
;278:
;279:/*
;280:==========================
;281:CG_FileExists
;282:==========================
;283:*/
;284:static qboolean	CG_FileExists( const char *filename ) {
line 288
;285:	int len;
;286:	fileHandle_t	f;
;287:
;288:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 290
;289:
;290:	if ( f != FS_INVALID_HANDLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $196
line 291
;291:		trap_FS_FCloseFile( f );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 292
;292:	}
LABELV $196
line 294
;293:
;294:	if ( len > 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $198
line 295
;295:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $195
JUMPV
LABELV $198
line 298
;296:	}
;297:
;298:	return qfalse;
CNSTI4 0
RETI4
LABELV $195
endproc CG_FileExists 12 12
proc CG_FindClientModelFile 36 40
line 307
;299:}
;300:
;301:
;302:/*
;303:==========================
;304:CG_FindClientModelFile
;305:==========================
;306:*/
;307:static qboolean	CG_FindClientModelFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext ) {
line 311
;308:	char *team, *charactersFolder;
;309:	int i;
;310:
;311:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $201
line 312
;312:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $207
ADDRGP4 $204
JUMPV
LABELV $207
line 313
;313:			case TEAM_BLUE: {
line 314
;314:				team = "blue";
ADDRLP4 8
ADDRGP4 $208
ASGNP4
line 315
;315:				break;
ADDRGP4 $202
JUMPV
LABELV $204
line 317
;316:			}
;317:			default: {
line 318
;318:				team = "red";
ADDRLP4 8
ADDRGP4 $209
ASGNP4
line 319
;319:				break;
line 322
;320:			}
;321:		}
;322:	}
ADDRGP4 $202
JUMPV
LABELV $201
line 323
;323:	else {
line 324
;324:		team = "default";
ADDRLP4 8
ADDRGP4 $125
ASGNP4
line 325
;325:	}
LABELV $202
line 328
;326:
;327:	// colored skins
;328:	if ( ci->coloredSkin && !Q_stricmp( ci->skinName, PM_SKIN ) ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $210
ADDRLP4 12
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $210
line 329
;329:		team = PM_SKIN;
ADDRLP4 8
ADDRGP4 $212
ASGNP4
line 330
;330:	}
LABELV $210
line 332
;331:
;332:	charactersFolder = "";
ADDRLP4 4
ADDRGP4 $213
ASGNP4
ADDRGP4 $215
JUMPV
LABELV $214
line 333
;333:	while(1) {
line 334
;334:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $217
line 335
;335:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $221
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $221
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $221
line 337
;336:				//								"models/players/characters/james/stroggs/lower_lily_red.skin"
;337:				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $223
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 338
;338:			}
ADDRGP4 $222
JUMPV
LABELV $221
line 339
;339:			else {
line 341
;340:				//								"models/players/characters/james/lower_lily_red.skin"
;341:				Com_sprintf( filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 342
;342:			}
LABELV $222
line 343
;343:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $225
line 344
;344:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $200
JUMPV
LABELV $225
line 346
;345:			}
;346:			if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $227
line 347
;347:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $230
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $230
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $230
line 349
;348:					//								"models/players/characters/james/stroggs/lower_red.skin"
;349:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 350
;350:				}
ADDRGP4 $228
JUMPV
LABELV $230
line 351
;351:				else {
line 353
;352:					//								"models/players/characters/james/lower_red.skin"
;353:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 354
;354:				}
line 355
;355:			}
ADDRGP4 $228
JUMPV
LABELV $227
line 356
;356:			else {
line 357
;357:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $234
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $234
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $234
line 359
;358:					//								"models/players/characters/james/stroggs/lower_lily.skin"
;359:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 360
;360:				}
ADDRGP4 $235
JUMPV
LABELV $234
line 361
;361:				else {
line 363
;362:					//								"models/players/characters/james/lower_lily.skin"
;363:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 364
;364:				}
LABELV $235
line 365
;365:			}
LABELV $228
line 366
;366:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $236
line 367
;367:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $200
JUMPV
LABELV $236
line 369
;368:			}
;369:			if ( !teamName || !*teamName ) {
ADDRLP4 32
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $240
ADDRLP4 32
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $238
LABELV $240
line 370
;370:				break;
ADDRGP4 $219
JUMPV
LABELV $238
line 372
;371:			}
;372:		}
LABELV $218
line 334
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $217
LABELV $219
line 374
;373:		// if tried the heads folder first
;374:		if ( charactersFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $241
line 375
;375:			break;
ADDRGP4 $216
JUMPV
LABELV $241
line 377
;376:		}
;377:		charactersFolder = "characters/";
ADDRLP4 4
ADDRGP4 $243
ASGNP4
line 378
;378:	}
LABELV $215
line 333
ADDRGP4 $214
JUMPV
LABELV $216
line 380
;379:
;380:	return qfalse;
CNSTI4 0
RETI4
LABELV $200
endproc CG_FindClientModelFile 36 40
proc CG_FindClientHeadFile 36 40
line 389
;381:}
;382:
;383:
;384:/*
;385:==========================
;386:CG_FindClientHeadFile
;387:==========================
;388:*/
;389:static qboolean	CG_FindClientHeadFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
line 393
;390:	char *team, *headsFolder;
;391:	int i;
;392:
;393:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $245
line 394
;394:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $251
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $252
ADDRGP4 $248
JUMPV
LABELV $251
line 395
;395:			case TEAM_RED: {
line 396
;396:				team = "red";
ADDRLP4 8
ADDRGP4 $209
ASGNP4
line 397
;397:				break;
ADDRGP4 $246
JUMPV
LABELV $252
line 399
;398:			}
;399:			case TEAM_BLUE: {
line 400
;400:				team = "blue";
ADDRLP4 8
ADDRGP4 $208
ASGNP4
line 401
;401:				break;
ADDRGP4 $246
JUMPV
LABELV $248
line 403
;402:			}
;403:			default: {
line 404
;404:				team = "default";
ADDRLP4 8
ADDRGP4 $125
ASGNP4
line 405
;405:				break;
line 408
;406:			}
;407:		}
;408:	}
ADDRGP4 $246
JUMPV
LABELV $245
line 409
;409:	else {
line 410
;410:		team = "default";
ADDRLP4 8
ADDRGP4 $125
ASGNP4
line 411
;411:	}
LABELV $246
line 414
;412:
;413:	// colored skins
;414:	if ( ci->coloredSkin && !Q_stricmp( ci->headSkinName, PM_SKIN ) ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $253
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $253
line 415
;415:		team = PM_SKIN;
ADDRLP4 8
ADDRGP4 $212
ASGNP4
line 416
;416:	}
LABELV $253
line 418
;417:
;418:	if ( headModelName[0] == '*' ) {
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $255
line 419
;419:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $257
ASGNP4
line 420
;420:		headModelName++;
ADDRFP4 16
ADDRFP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 421
;421:	}
ADDRGP4 $259
JUMPV
LABELV $255
line 422
;422:	else {
line 423
;423:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $213
ASGNP4
line 424
;424:	}
ADDRGP4 $259
JUMPV
LABELV $258
line 425
;425:	while(1) {
line 426
;426:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $261
line 427
;427:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $265
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $265
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $265
line 428
;428:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $267
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 429
;429:			}
ADDRGP4 $266
JUMPV
LABELV $265
line 430
;430:			else {
line 431
;431:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $268
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 432
;432:			}
LABELV $266
line 433
;433:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $269
line 434
;434:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $244
JUMPV
LABELV $269
line 436
;435:			}
;436:			if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $271
line 437
;437:				if ( i == 0 &&  teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $274
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $274
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $274
line 438
;438:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 439
;439:				}
ADDRGP4 $272
JUMPV
LABELV $274
line 440
;440:				else {
line 441
;441:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 442
;442:				}
line 443
;443:			}
ADDRGP4 $272
JUMPV
LABELV $271
line 444
;444:			else {
line 445
;445:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $276
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $276
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $276
line 446
;446:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 447
;447:				}
ADDRGP4 $277
JUMPV
LABELV $276
line 448
;448:				else {
line 449
;449:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $233
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 450
;450:				}
LABELV $277
line 451
;451:			}
LABELV $272
line 452
;452:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $278
line 453
;453:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $244
JUMPV
LABELV $278
line 455
;454:			}
;455:			if ( !teamName || !*teamName ) {
ADDRLP4 32
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
ADDRLP4 32
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $280
LABELV $282
line 456
;456:				break;
ADDRGP4 $263
JUMPV
LABELV $280
line 458
;457:			}
;458:		}
LABELV $262
line 426
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $261
LABELV $263
line 460
;459:		// if tried the heads folder first
;460:		if ( headsFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $283
line 461
;461:			break;
ADDRGP4 $260
JUMPV
LABELV $283
line 463
;462:		}
;463:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $257
ASGNP4
line 464
;464:	}
LABELV $259
line 425
ADDRGP4 $258
JUMPV
LABELV $260
line 466
;465:
;466:	return qfalse;
CNSTI4 0
RETI4
LABELV $244
endproc CG_FindClientHeadFile 36 40
proc CG_RegisterClientSkin 80 32
line 475
;467:}
;468:
;469:
;470:/*
;471:==========================
;472:CG_RegisterClientSkin
;473:==========================
;474:*/
;475:static qboolean	CG_RegisterClientSkin( clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName ) {
line 500
;476:	char filename[MAX_QPATH];
;477:
;478:	/*
;479:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%slower_%s.skin", modelName, teamName, skinName );
;480:	ci->legsSkin = trap_R_RegisterSkin( filename );
;481:	if (!ci->legsSkin) {
;482:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%slower_%s.skin", modelName, teamName, skinName );
;483:		ci->legsSkin = trap_R_RegisterSkin( filename );
;484:		if (!ci->legsSkin) {
;485:			Com_Printf( "Leg skin load failure: %s\n", filename );
;486:		}
;487:	}
;488:
;489:
;490:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%supper_%s.skin", modelName, teamName, skinName );
;491:	ci->torsoSkin = trap_R_RegisterSkin( filename );
;492:	if (!ci->torsoSkin) {
;493:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%supper_%s.skin", modelName, teamName, skinName );
;494:		ci->torsoSkin = trap_R_RegisterSkin( filename );
;495:		if (!ci->torsoSkin) {
;496:			Com_Printf( "Torso skin load failure: %s\n", filename );
;497:		}
;498:	}
;499:	*/
;500:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "lower", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $288
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $286
line 501
;501:		ci->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 502
;502:	}
LABELV $286
line 503
;503:	if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
NEI4 $290
line 504
;504:		Com_Printf( "Leg skin load failure: %s\n", filename );
ADDRGP4 $292
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 505
;505:	}
LABELV $290
line 507
;506:
;507:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "upper", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 68
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $293
line 508
;508:		ci->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 509
;509:	}
LABELV $293
line 510
;510:	if (!ci->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
NEI4 $296
line 511
;511:		Com_Printf( "Torso skin load failure: %s\n", filename );
ADDRGP4 $298
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 512
;512:	}
LABELV $296
line 514
;513:
;514:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headModelName, headSkinName, "head", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 72
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $299
line 515
;515:		ci->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 516
;516:	}
LABELV $299
line 517
;517:	if (!ci->headSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
NEI4 $302
line 518
;518:		Com_Printf( "Head skin load failure: %s\n", filename );
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 519
;519:	}
LABELV $302
line 522
;520:
;521:	// if any skins failed to load
;522:	if ( !ci->legsSkin || !ci->torsoSkin || !ci->headSkin ) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 76
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 76
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
NEI4 $305
LABELV $308
line 523
;523:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $285
JUMPV
LABELV $305
line 525
;524:	}
;525:	return qtrue;
CNSTI4 1
RETI4
LABELV $285
endproc CG_RegisterClientSkin 80 32
proc CG_RegisterClientModelname 164 32
line 534
;526:}
;527:
;528:
;529:/*
;530:==========================
;531:CG_RegisterClientModelname
;532:==========================
;533:*/
;534:static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName ) {
line 539
;535:	char	filename[MAX_QPATH];
;536:	const char		*headName;
;537:	char newTeamName[MAX_QPATH];
;538:
;539:	if ( headModelName[0] == '\0' ) {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $310
line 540
;540:		headName = modelName;
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
line 541
;541:	}
ADDRGP4 $311
JUMPV
LABELV $310
line 542
;542:	else {
line 543
;543:		headName = headModelName;
ADDRLP4 64
ADDRFP4 12
INDIRP4
ASGNP4
line 544
;544:	}
LABELV $311
line 545
;545:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $312
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 546
;546:	ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 547
;547:	if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $313
line 548
;548:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $315
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 549
;549:		ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 550
;550:		if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $316
line 551
;551:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 552
;552:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $316
line 554
;553:		}
;554:	}
LABELV $313
line 556
;555:
;556:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $319
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 557
;557:	ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 558
;558:	if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
NEI4 $320
line 559
;559:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $322
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 560
;560:		ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 561
;561:		if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
NEI4 $323
line 562
;562:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 563
;563:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $323
line 565
;564:		}
;565:	}
LABELV $320
line 567
;566:
;567:	if( headName[0] == '*' ) {
ADDRLP4 64
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $325
line 568
;568:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 140
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 569
;569:	}
ADDRGP4 $326
JUMPV
LABELV $325
line 570
;570:	else {
line 571
;571:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $328
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 572
;572:	}
LABELV $326
line 573
;573:	ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 575
;574:	// if the head model could not be found and we didn't load from the heads folder try to load from there
;575:	if ( !ci->headModel && headName[0] != '*' ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $329
ADDRLP4 64
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $329
line 576
;576:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 144
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 577
;577:		ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 578
;578:	}
LABELV $329
line 579
;579:	if ( !ci->headModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $331
line 580
;580:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 581
;581:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $331
line 585
;582:	}
;583:
;584:	// if any skins failed to load, return failure
;585:	if ( !CG_RegisterClientSkin( ci, teamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $333
line 586
;586:		if ( teamName && *teamName) {
ADDRLP4 148
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $335
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $335
line 587
;587:			Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $337
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 588
;588:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $338
line 589
;589:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
ADDRLP4 68
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $340
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 590
;590:			}
ADDRGP4 $339
JUMPV
LABELV $338
line 591
;591:			else {
line 592
;592:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
ADDRLP4 68
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $340
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 593
;593:			}
LABELV $339
line 594
;594:			if ( !CG_RegisterClientSkin( ci, newTeamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $336
line 595
;595:				Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $337
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 596
;596:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
line 598
;597:			}
;598:		} else {
LABELV $335
line 599
;599:			Com_Printf( "Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName );
ADDRGP4 $345
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 600
;600:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $336
line 602
;601:		}
;602:	}
LABELV $333
line 605
;603:
;604:	// load the animations
;605:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $346
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 606
;606:	if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $347
line 607
;607:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $349
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 608
;608:		if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $350
line 609
;609:			Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $352
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 610
;610:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $350
line 612
;611:		}
;612:	}
LABELV $347
line 614
;613:
;614:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 152
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $353
line 615
;615:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 616
;616:	}
ADDRGP4 $354
JUMPV
LABELV $353
line 617
;617:	else if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "tga" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 156
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $356
line 618
;618:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 160
INDIRI4
ASGNI4
line 619
;619:	}
LABELV $356
LABELV $354
line 621
;620:
;621:	if ( !ci->modelIcon ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
CNSTI4 0
NEI4 $359
line 622
;622:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $359
line 625
;623:	}
;624:
;625:	return qtrue;
CNSTI4 1
RETI4
LABELV $309
endproc CG_RegisterClientModelname 164 32
proc CG_IsKnownModel 92 8
line 630
;626:}
;627:
;628:
;629:/* advance this function on any new pm skin added */
;630:static qboolean CG_IsKnownModel( const char *modelName ) {
line 632
;631:
;632:	if ( Q_stricmp(modelName, "anarki") &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $365
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $368
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $369
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $371
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $373
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $374
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $376
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $377
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $381
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $383
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $386
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $362
line 655
;633:		 Q_stricmp(modelName, "biker") &&
;634:		 Q_stricmp(modelName, "bitterman") &&
;635:		 Q_stricmp(modelName, "bones") &&
;636:		 Q_stricmp(modelName, "crash") &&
;637:		 Q_stricmp(modelName, "doom") &&
;638:		 Q_stricmp(modelName, "grunt") &&
;639:		 Q_stricmp(modelName, "hunter") &&
;640:		 Q_stricmp(modelName, "keel") &&
;641:		 Q_stricmp(modelName, "klesk") &&
;642:		 Q_stricmp(modelName, "lucy") &&
;643:		 Q_stricmp(modelName, "major") &&
;644:		 Q_stricmp(modelName, "mynx") &&
;645:		 Q_stricmp(modelName, "orbb") &&
;646:		 Q_stricmp(modelName, "ranger") &&
;647:		 Q_stricmp(modelName, "razor") &&
;648:		 Q_stricmp(modelName, "sarge") &&
;649:		 Q_stricmp(modelName, "slash") &&
;650:		 Q_stricmp(modelName, "sorlag") &&
;651:		 Q_stricmp(modelName, "tankjr") &&
;652:		 Q_stricmp(modelName, "uriel") &&
;653:		 Q_stricmp(modelName, "visor") &&
;654:		 Q_stricmp(modelName, "xaero") )
;655:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $362
line 657
;656:	else
;657:		return qtrue;
CNSTI4 1
RETI4
LABELV $361
endproc CG_IsKnownModel 92 8
proc CG_ColorFromChar 8 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII1 4
ASGNI1
line 666
;658:}
;659:
;660:
;661:/*
;662:====================
;663:CG_ColorFromChar
;664:====================
;665:*/
;666:static void CG_ColorFromChar( char v, vec3_t color ) {
line 669
;667:	int val;
;668:
;669:	val = v - '0';
ADDRLP4 0
ADDRFP4 0
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 671
;670:
;671:	if ( val < 1 || val > 7 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $390
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $388
LABELV $390
line 672
;672:		VectorSet( color, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 673
;673:	} else {
ADDRGP4 $389
JUMPV
LABELV $388
line 674
;674:		VectorClear( color );
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 675
;675:		if ( val & 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $391
line 676
;676:			color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 677
;677:		}
LABELV $391
line 678
;678:		if ( val & 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $393
line 679
;679:			color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 680
;680:		}
LABELV $393
line 681
;681:		if ( val & 4 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $395
line 682
;682:			color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 683
;683:		}
LABELV $395
line 684
;684:	}
LABELV $389
line 685
;685:}
LABELV $387
endproc CG_ColorFromChar 8 0
proc CG_SetColorInfo 0 8
line 689
;686:
;687:
;688:static void CG_SetColorInfo( const char *color, clientInfo_t *info ) 
;689:{
line 690
;690:	VectorSet ( info->headColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1616
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1620
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1624
ADDP4
CNSTF4 1065353216
ASGNF4
line 691
;691:	VectorSet ( info->bodyColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1628
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1632
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1636
ADDP4
CNSTF4 1065353216
ASGNF4
line 692
;692:	VectorSet ( info->legsColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1640
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1644
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1648
ADDP4
CNSTF4 1065353216
ASGNF4
line 694
;693:	
;694:	if ( !color[0] )
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $398
line 695
;695:		return;
ADDRGP4 $397
JUMPV
LABELV $398
line 696
;696:	CG_ColorFromChar( color[0], info->headColor );
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1616
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 698
;697:	
;698:	if ( !color[1] )
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $400
line 699
;699:		return;
ADDRGP4 $397
JUMPV
LABELV $400
line 700
;700:	CG_ColorFromChar( color[1], info->bodyColor );
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1628
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 702
;701:
;702:	if ( !color[2] )
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $402
line 703
;703:		return;
ADDRGP4 $397
JUMPV
LABELV $402
line 704
;704:	CG_ColorFromChar( color[2], info->legsColor );
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1640
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 707
;705:
;706:	// override color1/color2 if specified
;707:	if ( !color[3] )
ADDRFP4 0
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $404
line 708
;708:		return;
ADDRGP4 $397
JUMPV
LABELV $404
line 709
;709:	CG_ColorFromChar( color[3], info->color1 );
ADDRFP4 0
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 711
;710:
;711:	if ( !color[4] )
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $406
line 712
;712:		return;
ADDRGP4 $397
JUMPV
LABELV $406
line 713
;713:	CG_ColorFromChar( color[4], info->color2 );
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 714
;714:}
LABELV $397
endproc CG_SetColorInfo 0 8
bss
align 1
LABELV $409
skip 6
code
proc CG_GetTeamColors 8 12
line 717
;715:
;716:
;717:static const char *CG_GetTeamColors( const char *color, team_t team ) {
line 720
;718:	static char str[6];
;719:
;720:	Q_strncpyz( str, color, sizeof( str ) );
ADDRGP4 $409
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 722
;721:
;722:	switch ( team ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $415
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $413
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $414
ADDRGP4 $411
JUMPV
LABELV $413
line 723
;723:		case TEAM_RED:  replace1( '?', '1', str ); break;
CNSTI4 63
ARGI4
CNSTI4 49
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
ADDRGP4 $411
JUMPV
LABELV $414
line 724
;724:		case TEAM_BLUE: replace1( '?', '4', str ); break;
CNSTI4 63
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
ADDRGP4 $411
JUMPV
LABELV $415
line 725
;725:		case TEAM_FREE: replace1( '?', '7', str ); break;
CNSTI4 63
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
line 726
;726:		default: break;
LABELV $411
line 729
;727:    }
;728:
;729:	return str;
ADDRGP4 $409
RETP4
LABELV $408
endproc CG_GetTeamColors 8 12
proc CG_LoadClientInfo 404 24
line 741
;730:}
;731:
;732:
;733:/*
;734:===================
;735:CG_LoadClientInfo
;736:
;737:Load it now, taking the disk hits.
;738:This will usually be deferred to a safe time
;739:===================
;740:*/
;741:static void CG_LoadClientInfo( clientInfo_t *ci ) {
line 749
;742:	const char	*dir;
;743:	int			i, modelloaded;
;744:	const char	*s;
;745:	int			clientNum;
;746:	char		teamname[MAX_QPATH];
;747:	char		vertexlit[MAX_CVAR_VALUE_STRING];
;748:
;749:	teamname[0] = '\0';
ADDRLP4 276
CNSTI1 0
ASGNI1
line 752
;750:
;751:	// disable vertexlight for colored skins
;752:	trap_Cvar_VariableStringBuffer( "r_vertexlight", vertexlit, sizeof( vertexlit ) );
ADDRGP4 $417
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 753
;753:	if ( vertexlit[0] && vertexlit[0] != '0' ) {
ADDRLP4 340
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $418
ADDRLP4 340
INDIRI4
CNSTI4 48
EQI4 $418
line 754
;754:		trap_Cvar_Set( "r_vertexlight", "0" );
ADDRGP4 $417
ARGP4
ADDRGP4 $420
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 755
;755:	}
LABELV $418
line 769
;756:
;757:#ifdef MISSIONPACK
;758:	if( cgs.gametype >= GT_TEAM) {
;759:		if( ci->team == TEAM_BLUE ) {
;760:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
;761:		} else {
;762:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
;763:		}
;764:	}
;765:	if( teamname[0] ) {
;766:		strcat( teamname, "/" );
;767:	}
;768:#endif
;769:	modelloaded = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 770
;770:	if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname ) ) {
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 348
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $421
line 771
;771:		if ( cg_buildScript.integer ) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $423
line 772
;772:			CG_Error( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
ADDRGP4 $426
ARGP4
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 773
;773:		}
LABELV $423
line 776
;774:
;775:		// fall back to default team name
;776:		if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $427
line 778
;777:			// keep skin name
;778:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $430
line 779
;779:				Q_strncpyz(teamname, DEFAULT_BLUETEAM_NAME, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 $341
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 780
;780:			} else {
ADDRGP4 $431
JUMPV
LABELV $430
line 781
;781:				Q_strncpyz(teamname, DEFAULT_REDTEAM_NAME, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 $342
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 782
;782:			}
LABELV $431
line 783
;783:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, ci->skinName, DEFAULT_MODEL, ci->skinName, teamname ) ) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 $380
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 360
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $428
line 784
;784:				CG_Error( "DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_MODEL, ci->skinName );
ADDRGP4 $434
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 785
;785:			}
line 786
;786:		} else {
ADDRGP4 $428
JUMPV
LABELV $427
line 787
;787:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, "default", DEFAULT_MODEL, "default", teamname ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 $380
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 $125
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 360
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $435
line 788
;788:				CG_Error( "DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL );
ADDRGP4 $437
ARGP4
ADDRGP4 $380
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 789
;789:			}
LABELV $435
line 790
;790:		}
LABELV $428
line 791
;791:		modelloaded = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 792
;792:	}
LABELV $421
line 794
;793:
;794:	ci->newAnims = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 795
;795:	if ( ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $438
line 798
;796:		orientation_t tag;
;797:		// if the torso model has the "tag_flag"
;798:		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
ADDRLP4 352
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $442
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
CNSTI4 0
EQI4 $440
line 799
;799:			ci->newAnims = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 800
;800:		}
LABELV $440
line 801
;801:	}
LABELV $438
line 804
;802:
;803:	// sounds
;804:	dir = ci->modelName;
ADDRLP4 272
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 806
;805:
;806:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $443
line 807
;807:		s = cg_customSoundNames[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 808
;808:		if ( !s ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $447
line 809
;809:			break;
ADDRGP4 $445
JUMPV
LABELV $447
line 811
;810:		}
;811:		ci->sounds[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 813
;812:		// if the model didn't load use the sounds of the default model
;813:		if (modelloaded) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $449
line 814
;814:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", dir, s + 1), qfalse );
ADDRGP4 $451
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 815
;815:		}
LABELV $449
line 816
;816:		if ( !ci->sounds[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $452
line 817
;817:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", DEFAULT_MODEL, s + 1), qfalse );
ADDRGP4 $451
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 818
;818:		}
LABELV $452
line 819
;819:	}
LABELV $444
line 806
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $443
LABELV $445
line 821
;820:
;821:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 825
;822:
;823:	// reset any existing players and bodies, because they might be in bad
;824:	// frames for this new model
;825:	clientNum = ci - cgs.clientinfo;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+40996
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1652
DIVI4
ASGNI4
line 826
;826:	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $455
line 827
;827:		if ( cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $459
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $459
line 828
;828:			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
line 829
;829:			CG_ResetPlayerEntity( &cg_entities[i] );
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 830
;830:		}
LABELV $459
line 831
;831:	}
LABELV $456
line 826
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $455
line 834
;832:
;833:	// restore vertexlight mode
;834:	if ( vertexlit[0] && vertexlit[0] != '0' ) {
ADDRLP4 352
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $463
ADDRLP4 352
INDIRI4
CNSTI4 48
EQI4 $463
line 835
;835:		trap_Cvar_Set( "r_vertexlight", vertexlit );
ADDRGP4 $417
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 836
;836:	}
LABELV $463
line 837
;837:}
LABELV $416
endproc CG_LoadClientInfo 404 24
proc CG_CopyClientInfoModel 0 12
line 845
;838:
;839:
;840:/*
;841:======================
;842:CG_CopyClientInfoModel
;843:======================
;844:*/
;845:static void CG_CopyClientInfoModel( const clientInfo_t *from, clientInfo_t *to ) {
line 846
;846:	VectorCopy( from->headOffset, to->headOffset );
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRB
ASGNB 12
line 847
;847:	to->footsteps = from->footsteps;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 848
;848:	to->gender = from->gender;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 850
;849:
;850:	to->legsModel = from->legsModel;
ADDRFP4 4
INDIRP4
CNSTI4 420
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 851
;851:	to->legsSkin = from->legsSkin;
ADDRFP4 4
INDIRP4
CNSTI4 424
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 852
;852:	to->torsoModel = from->torsoModel;
ADDRFP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 853
;853:	to->torsoSkin = from->torsoSkin;
ADDRFP4 4
INDIRP4
CNSTI4 432
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
ASGNI4
line 854
;854:	to->headModel = from->headModel;
ADDRFP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 855
;855:	to->headSkin = from->headSkin;
ADDRFP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 856
;856:	to->modelIcon = from->modelIcon;
ADDRFP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ASGNI4
line 858
;857:
;858:	to->newAnims = from->newAnims;
ADDRFP4 4
INDIRP4
CNSTI4 388
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ASGNI4
line 859
;859:	to->coloredSkin = from->coloredSkin;
ADDRFP4 4
INDIRP4
CNSTI4 1612
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
ASGNI4
line 861
;860:
;861:	memcpy( to->animations, from->animations, sizeof( to->animations ) );
ADDRFP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTI4 1036
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 862
;862:	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
ADDRFP4 4
INDIRP4
CNSTI4 1484
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 863
;863:}
LABELV $465
endproc CG_CopyClientInfoModel 0 12
proc CG_ScanForExistingClientInfo 24 8
line 871
;864:
;865:
;866:/*
;867:======================
;868:CG_ScanForExistingClientInfo
;869:======================
;870:*/
;871:static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
line 875
;872:	int		i;
;873:	clientInfo_t	*match;
;874:
;875:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $470
JUMPV
LABELV $467
line 876
;876:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 877
;877:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $473
line 878
;878:			continue;
ADDRGP4 $468
JUMPV
LABELV $473
line 880
;879:		}
;880:		if ( match->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $475
line 881
;881:			continue;
ADDRGP4 $468
JUMPV
LABELV $475
line 883
;882:		}
;883:		if ( !Q_stricmp( ci->modelName, match->modelName )
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $477
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $477
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $477
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $477
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $480
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $477
LABELV $480
line 889
;884:			&& !Q_stricmp( ci->skinName, match->skinName )
;885:			&& !Q_stricmp( ci->headModelName, match->headModelName )
;886:			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
;887:			//&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
;888:			//&& !Q_stricmp( ci->redTeam, match->redTeam )
;889:			&& (cgs.gametype < GT_TEAM || ci->team == match->team) ) {
line 892
;890:			// this clientinfo is identical, so use it's handles
;891:
;892:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 894
;893:
;894:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 896
;895:
;896:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $466
JUMPV
LABELV $477
line 898
;897:		}
;898:	}
LABELV $468
line 875
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $470
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $467
line 901
;899:
;900:	// nothing matches, so defer the load
;901:	return qfalse;
CNSTI4 0
RETI4
LABELV $466
endproc CG_ScanForExistingClientInfo 24 8
proc CG_SetDeferredClientInfo 20 8
line 913
;902:}
;903:
;904:
;905:/*
;906:======================
;907:CG_SetDeferredClientInfo
;908:
;909:We aren't going to load it now, so grab some other
;910:client's info to use until we have some spare time.
;911:======================
;912:*/
;913:static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
line 919
;914:	int		i;
;915:	clientInfo_t	*match;
;916:
;917:	// if someone else is already the same models and skins we
;918:	// can just load the client info
;919:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $485
JUMPV
LABELV $482
line 920
;920:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 921
;921:		if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $490
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $488
LABELV $490
line 922
;922:			continue;
ADDRGP4 $483
JUMPV
LABELV $488
line 924
;923:		}
;924:		if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $495
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $495
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $491
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
EQI4 $491
LABELV $495
line 928
;925:			 Q_stricmp( ci->modelName, match->modelName ) ||
;926://			 Q_stricmp( ci->headModelName, match->headModelName ) ||
;927://			 Q_stricmp( ci->headSkinName, match->headSkinName ) ||
;928:			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 929
;929:			continue;
ADDRGP4 $483
JUMPV
LABELV $491
line 932
;930:		}
;931:		// just load the real info cause it uses the same models and skins
;932:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 933
;933:		return;
ADDRGP4 $481
JUMPV
LABELV $483
line 919
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $485
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $482
line 937
;934:	}
;935:
;936:	// if we are in teamplay, only grab a model if the skin is correct
;937:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $496
line 938
;938:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $502
JUMPV
LABELV $499
line 939
;939:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 940
;940:			if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $507
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $505
LABELV $507
line 941
;941:				continue;
ADDRGP4 $500
JUMPV
LABELV $505
line 943
;942:			}
;943:			if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $511
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $508
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
EQI4 $508
LABELV $511
line 944
;944:				(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 945
;945:				continue;
ADDRGP4 $500
JUMPV
LABELV $508
line 947
;946:			}
;947:			ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1
ASGNI4
line 948
;948:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 949
;949:			return;
ADDRGP4 $481
JUMPV
LABELV $500
line 938
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $502
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $499
line 955
;950:		}
;951:		// load the full model, because we don't ever want to show
;952:		// an improper team skin.  This will cause a hitch for the first
;953:		// player, when the second enters.  Combat shouldn't be going on
;954:		// yet, so it shouldn't matter
;955:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 956
;956:		return;
ADDRGP4 $481
JUMPV
LABELV $496
line 960
;957:	}
;958:
;959:	// find the first valid clientinfo and grab its stuff
;960:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $512
line 961
;961:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 962
;962:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $518
line 963
;963:			continue;
ADDRGP4 $513
JUMPV
LABELV $518
line 966
;964:		}
;965:
;966:		ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1
ASGNI4
line 967
;967:		CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 968
;968:		return;
ADDRGP4 $481
JUMPV
LABELV $513
line 960
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $515
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $512
line 972
;969:	}
;970:
;971:	// we should never get here...
;972:	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );
ADDRGP4 $520
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 974
;973:
;974:	CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 975
;975:}
LABELV $481
endproc CG_SetDeferredClientInfo 20 8
proc CG_SetSkinAndModel 188 12
line 986
;976:
;977:
;978:static void CG_SetSkinAndModel( clientInfo_t *newInfo,
;979:		clientInfo_t *curInfo,
;980:		const char *infomodel,
;981:		qboolean allowNativeModel,
;982:		int clientNum, int myClientNum,
;983:		team_t myTeam, qboolean setColor,
;984:		char *modelName, int modelNameSize,
;985:		char *skinName, int skinNameSize ) 
;986:{
line 994
;987:	char modelStr[ MAX_QPATH ];
;988:	char newSkin[ MAX_QPATH ];
;989:	char *skin, *slash;
;990:	qboolean	pm_model;
;991:	team_t		team;
;992:	const char	*colors;
;993:	
;994:	team = newInfo->team;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
line 995
;995:	pm_model = ( Q_stricmp( cg_enemyModel.string, PM_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $524
ADDRLP4 148
CNSTI4 1
ASGNI4
ADDRGP4 $525
JUMPV
LABELV $524
ADDRLP4 148
CNSTI4 0
ASGNI4
LABELV $525
ADDRLP4 8
ADDRLP4 148
INDIRI4
ASGNI4
line 997
;996:
;997:	if ( cg_forceModel.integer || cg_enemyModel.string[0] || cg_teamModel.string[0] )
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
NEI4 $532
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $532
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $526
LABELV $532
line 998
;998:	{
line 999
;999:		if ( cgs.gametype >= GT_TEAM )
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $533
line 1000
;1000:		{
line 1002
;1001:			// enemy model
;1002:			if ( cg_enemyModel.string[0] && team != myTeam && team != TEAM_SPECTATOR ) {
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $536
ADDRLP4 156
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 156
INDIRI4
ADDRFP4 24
INDIRI4
EQI4 $536
ADDRLP4 156
INDIRI4
CNSTI4 3
EQI4 $536
line 1003
;1003:				if ( pm_model )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $539
line 1004
;1004:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $540
JUMPV
LABELV $539
line 1006
;1005:				else
;1006:					Q_strncpyz( modelName, cg_enemyModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $540
line 1008
;1007:
;1008:				skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 160
INDIRP4
ASGNP4
line 1010
;1009:				// force skin
;1010:				strcpy( newSkin, PM_SKIN );
ADDRLP4 16
ARGP4
ADDRGP4 $212
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1011
;1011:				if ( skin )
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $542
line 1012
;1012:					*skin = '\0';
ADDRLP4 12
INDIRP4
CNSTI1 0
ASGNI1
LABELV $542
line 1014
;1013:
;1014:				if ( pm_model && !CG_IsKnownModel( modelName ) ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $544
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $544
line 1016
;1015:					// revert to default model if specified skin is not known
;1016:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1017
;1017:				}
LABELV $544
line 1018
;1018:				Q_strncpyz( skinName, newSkin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1020
;1019:
;1020:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $527
line 1021
;1021:					if ( cg_enemyColors.string[0] && myTeam != TEAM_SPECTATOR ) // free-fly?
ADDRGP4 cg_enemyColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $548
ADDRFP4 24
INDIRI4
CNSTI4 3
EQI4 $548
line 1022
;1022:						colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 168
INDIRP4
ASGNP4
ADDRGP4 $549
JUMPV
LABELV $548
line 1024
;1023:					else
;1024:						colors = CG_GetTeamColors( "???", newInfo->team );
ADDRGP4 $552
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 172
INDIRP4
ASGNP4
LABELV $549
line 1026
;1025:
;1026:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 80
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1027
;1027:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1028
;1028:				}
line 1030
;1029:
;1030:			} else if ( cg_teamModel.string[0] && team == myTeam && team != TEAM_SPECTATOR && clientNum != myClientNum ) {
ADDRGP4 $527
JUMPV
LABELV $536
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $553
ADDRLP4 160
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 160
INDIRI4
ADDRFP4 24
INDIRI4
NEI4 $553
ADDRLP4 160
INDIRI4
CNSTI4 3
EQI4 $553
ADDRFP4 16
INDIRI4
ADDRFP4 20
INDIRI4
EQI4 $553
line 1032
;1031:				// teammodel
;1032:				pm_model = ( Q_stricmp( cg_teamModel.string, PM_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_teamModel+16
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $558
ADDRLP4 164
CNSTI4 1
ASGNI4
ADDRGP4 $559
JUMPV
LABELV $558
ADDRLP4 164
CNSTI4 0
ASGNI4
LABELV $559
ADDRLP4 8
ADDRLP4 164
INDIRI4
ASGNI4
line 1034
;1033:
;1034:				if ( pm_model )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $560
line 1035
;1035:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
ADDRGP4 $561
JUMPV
LABELV $560
line 1037
;1036:				else
;1037:					Q_strncpyz( modelName, cg_teamModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_teamModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $561
line 1039
;1038:
;1039:				skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 172
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 172
INDIRP4
ASGNP4
line 1041
;1040:				// force skin
;1041:				strcpy( newSkin, PM_SKIN );
ADDRLP4 16
ARGP4
ADDRGP4 $212
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1042
;1042:				if ( skin )
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $563
line 1043
;1043:					*skin = '\0';
ADDRLP4 12
INDIRP4
CNSTI1 0
ASGNI1
LABELV $563
line 1045
;1044:
;1045:				if ( pm_model && !CG_IsKnownModel( modelName ) ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $565
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $565
line 1047
;1046:					// revert to default model if specified skin is not known
;1047:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1048
;1048:				}
LABELV $565
line 1049
;1049:				Q_strncpyz( skinName, newSkin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1051
;1050:
;1051:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $527
line 1052
;1052:					if ( cg_teamColors.string[0] && myTeam != TEAM_SPECTATOR ) // free-fly?
ADDRGP4 cg_teamColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $569
ADDRFP4 24
INDIRI4
CNSTI4 3
EQI4 $569
line 1053
;1053:						colors = CG_GetTeamColors( cg_teamColors.string, newInfo->team );
ADDRGP4 cg_teamColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 180
INDIRP4
ASGNP4
ADDRGP4 $570
JUMPV
LABELV $569
line 1055
;1054:					else
;1055:						colors = CG_GetTeamColors( "???", newInfo->team );
ADDRGP4 $552
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 184
INDIRP4
ASGNP4
LABELV $570
line 1057
;1056:
;1057:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 80
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1058
;1058:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1059
;1059:				}
line 1061
;1060:
;1061:			} else {
ADDRGP4 $527
JUMPV
LABELV $553
line 1063
;1062:				// forcemodel etc.
;1063:				if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $573
line 1065
;1064:
;1065:					trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $576
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1066
;1066:					if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 84
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 164
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 164
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $577
line 1067
;1067:						skin = "default";
ADDRLP4 12
ADDRGP4 $125
ASGNP4
line 1068
;1068:					} else {
ADDRGP4 $578
JUMPV
LABELV $577
line 1069
;1069:						*skin++ = '\0';
ADDRLP4 168
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 168
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI1 0
ASGNI1
line 1070
;1070:					}
LABELV $578
line 1072
;1071:
;1072:					Q_strncpyz( skinName, skin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1073
;1073:					Q_strncpyz( modelName, modelStr, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1075
;1074:
;1075:				} else {
ADDRGP4 $527
JUMPV
LABELV $573
line 1076
;1076:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1077
;1077:					slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 164
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 164
INDIRP4
ASGNP4
line 1078
;1078:					if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $579
line 1079
;1079:						Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1080
;1080:					} else {
ADDRGP4 $527
JUMPV
LABELV $579
line 1081
;1081:						Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1082
;1082:						*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1083
;1083:					}
line 1084
;1084:				}
line 1085
;1085:			}
line 1086
;1086:		} else { // not team game
ADDRGP4 $527
JUMPV
LABELV $533
line 1088
;1087:
;1088:			if ( pm_model && myClientNum != clientNum && cgs.gametype != GT_SINGLE_PLAYER ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $581
ADDRFP4 20
INDIRI4
ADDRFP4 16
INDIRI4
EQI4 $581
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
EQI4 $581
line 1089
;1089:				Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1092
;1090:
;1091:				// strip skin name from model name
;1092:				slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
line 1093
;1093:				if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $584
line 1094
;1094:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1095
;1095:				} else {
ADDRGP4 $585
JUMPV
LABELV $584
line 1096
;1096:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1097
;1097:					*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1098
;1098:				}
LABELV $585
line 1100
;1099:
;1100:				if ( !CG_IsKnownModel( modelName ) )
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $586
line 1101
;1101:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $586
line 1103
;1102:
;1103:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $527
line 1104
;1104:					colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 164
INDIRP4
ASGNP4
line 1105
;1105:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 80
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1106
;1106:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1107
;1107:				}
line 1109
;1108:
;1109:			} else if ( cg_enemyModel.string[0] && myClientNum != clientNum && !allowNativeModel && cgs.gametype != GT_SINGLE_PLAYER ) {
ADDRGP4 $527
JUMPV
LABELV $581
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $591
ADDRFP4 20
INDIRI4
ADDRFP4 16
INDIRI4
EQI4 $591
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $591
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
EQI4 $591
line 1111
;1110:
;1111:				Q_strncpyz( modelName, cg_enemyModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1113
;1112:
;1113:				slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
line 1114
;1114:				if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $596
line 1115
;1115:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1116
;1116:				} else {
ADDRGP4 $597
JUMPV
LABELV $596
line 1117
;1117:					Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1118
;1118:					*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1119
;1119:				}
LABELV $597
line 1121
;1120:
;1121:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $527
line 1122
;1122:					colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 160
INDIRP4
ASGNP4
line 1123
;1123:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 80
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1124
;1124:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1125
;1125:				}
line 1126
;1126:			} else { // forcemodel, etc.
ADDRGP4 $527
JUMPV
LABELV $591
line 1127
;1127:				if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $601
line 1129
;1128:
;1129:					trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $576
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1130
;1130:					if ( ( skin = strchr( modelStr, '/' ) ) == NULL ) {
ADDRLP4 84
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 156
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $604
line 1131
;1131:						skin = "default";
ADDRLP4 12
ADDRGP4 $125
ASGNP4
line 1132
;1132:					} else {
ADDRGP4 $605
JUMPV
LABELV $604
line 1133
;1133:						*skin++ = '\0';
ADDRLP4 160
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 160
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI1 0
ASGNI1
line 1134
;1134:					}
LABELV $605
line 1136
;1135:
;1136:					Q_strncpyz( skinName, skin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1137
;1137:					Q_strncpyz( modelName, modelStr, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 84
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1138
;1138:				} else {
ADDRGP4 $527
JUMPV
LABELV $601
line 1139
;1139:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1140
;1140:						slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
line 1141
;1141:					if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $606
line 1143
;1142:						// modelName didn not include a skin name
;1143:						Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1144
;1144:					} else {
ADDRGP4 $527
JUMPV
LABELV $606
line 1145
;1145:						Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1147
;1146:						// truncate modelName
;1147:						*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1148
;1148:					}
line 1149
;1149:				}
line 1150
;1150:			}
line 1151
;1151:		}
line 1152
;1152:	}
ADDRGP4 $527
JUMPV
LABELV $526
line 1154
;1153:	else // !cg_forcemodel && !cg_enemyModel && !cg_teamModel
;1154:	{
line 1155
;1155:		Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1156
;1156:		slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
line 1157
;1157:		if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $608
line 1159
;1158:			// modelName didn not include a skin name
;1159:			Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1160
;1160:		} else {
ADDRGP4 $609
JUMPV
LABELV $608
line 1161
;1161:			Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1163
;1162:			// truncate modelName
;1163:			*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1164
;1164:		}
LABELV $609
line 1165
;1165:	}
LABELV $527
line 1166
;1166:}
LABELV $521
endproc CG_SetSkinAndModel 188 12
export CG_NewClientInfo
proc CG_NewClientInfo 1788 48
line 1174
;1167:
;1168:
;1169:/*
;1170:======================
;1171:CG_NewClientInfo
;1172:======================
;1173:*/
;1174:void CG_NewClientInfo( int clientNum ) {
line 1188
;1175:	clientInfo_t *ci;
;1176:	clientInfo_t newInfo;
;1177:	const char	*configstring;
;1178:	const char	*v;
;1179:
;1180:	// for colored skins
;1181:	qboolean	allowNativeModel;
;1182:	int			can_defer;
;1183:	int			myClientNum;
;1184:	team_t		myTeam;
;1185:	team_t		team;
;1186:	int			len;
;1187:
;1188:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 1668
ADDRFP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1190
;1189:
;1190:	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1688
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1656
ADDRLP4 1688
INDIRP4
ASGNP4
line 1191
;1191:	if ( !configstring[0] ) {
ADDRLP4 1656
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $612
line 1192
;1192:		memset( ci, 0, sizeof( *ci ) );
ADDRLP4 1668
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1652
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1193
;1193:		return;	// player just left
ADDRGP4 $610
JUMPV
LABELV $612
line 1196
;1194:	}
;1195:
;1196:	if ( cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $614
line 1197
;1197:		myClientNum = cg.snap->ps.clientNum;
ADDRLP4 1672
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1198
;1198:		myTeam = cgs.clientinfo[ myClientNum ].team;
ADDRLP4 1664
ADDRLP4 1672
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 1199
;1199:	} else {
ADDRGP4 $615
JUMPV
LABELV $614
line 1200
;1200:		myClientNum = cg.clientNum;
ADDRLP4 1672
ADDRGP4 cg+4
INDIRI4
ASGNI4
line 1201
;1201:		myTeam = TEAM_SPECTATOR;
ADDRLP4 1664
CNSTI4 3
ASGNI4
line 1202
;1202:	}
LABELV $615
line 1205
;1203:
;1204:	// "join" team if spectating
;1205:	if ( myTeam == TEAM_SPECTATOR && cg.snap ) {
ADDRLP4 1664
INDIRI4
CNSTI4 3
NEI4 $621
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $621
line 1206
;1206:		myTeam = cg.snap->ps.persistant[ PERS_TEAM ];
ADDRLP4 1664
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 1207
;1207:	}
LABELV $621
line 1209
;1208:
;1209:	allowNativeModel = qfalse;
ADDRLP4 1676
CNSTI4 0
ASGNI4
line 1210
;1210:	if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $625
line 1211
;1211:		if ( !cg.snap || ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_FREE && cg.snap->ps.clientNum == clientNum ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $633
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 0
NEI4 $628
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $628
LABELV $633
line 1212
;1212:			if ( cg.demoPlayback || ( cg.snap && cg.snap->ps.pm_flags & PMF_FOLLOW ) ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $639
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $634
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $634
LABELV $639
line 1213
;1213:				allowNativeModel = qtrue;
ADDRLP4 1676
CNSTI4 1
ASGNI4
line 1214
;1214:			}
LABELV $634
line 1215
;1215:		}
LABELV $628
line 1216
;1216:	}
LABELV $625
line 1220
;1217:
;1218:	// build into a temp buffer so the defer checks can use
;1219:	// the old value
;1220:	memset( &newInfo, 0, sizeof( newInfo ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1652
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1223
;1221:
;1222:	// isolate the player's name
;1223:	v = Info_ValueForKey( configstring, "n" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $640
ARGP4
ADDRLP4 1692
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1692
INDIRP4
ASGNP4
line 1224
;1224:	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );
ADDRLP4 0+4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1227
;1225:
;1226:	// team
;1227:	v = Info_ValueForKey( configstring, "t" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $643
ARGP4
ADDRLP4 1696
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1696
INDIRP4
ASGNP4
line 1228
;1228:	team = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1700
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1660
ADDRLP4 1700
INDIRI4
ASGNI4
line 1229
;1229:	if ( (unsigned) team > TEAM_NUM_TEAMS ) {
ADDRLP4 1660
INDIRI4
CVIU4 4
CNSTU4 4
LEU4 $644
line 1230
;1230:		team = TEAM_SPECTATOR;
ADDRLP4 1660
CNSTI4 3
ASGNI4
line 1231
;1231:	}
LABELV $644
line 1232
;1232:	newInfo.team = team;
ADDRLP4 0+36
ADDRLP4 1660
INDIRI4
ASGNI4
line 1235
;1233:
;1234:	// colors
;1235:	v = Info_ValueForKey( configstring, "c1" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $647
ARGP4
ADDRLP4 1704
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1704
INDIRP4
ASGNP4
line 1236
;1236:	CG_ColorFromChar( v[0], newInfo.color1 );
ADDRLP4 1652
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+44
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 1238
;1237:
;1238:	v = Info_ValueForKey( configstring, "c2" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $649
ARGP4
ADDRLP4 1708
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1708
INDIRP4
ASGNP4
line 1239
;1239:	CG_ColorFromChar( v[0], newInfo.color2 );
ADDRLP4 1652
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+56
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 1241
;1240:
;1241:	VectorSet( newInfo.headColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1616
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1616+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1616+8
CNSTF4 1065353216
ASGNF4
line 1242
;1242:	VectorSet( newInfo.bodyColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1628
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1628+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1628+8
CNSTF4 1065353216
ASGNF4
line 1243
;1243:	VectorSet( newInfo.legsColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1640
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1640+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1640+8
CNSTF4 1065353216
ASGNF4
line 1246
;1244:
;1245:	// bot skill
;1246:	v = Info_ValueForKey( configstring, "skill" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $666
ARGP4
ADDRLP4 1712
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1712
INDIRP4
ASGNP4
line 1247
;1247:	newInfo.botSkill = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1716
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+40
ADDRLP4 1716
INDIRI4
ASGNI4
line 1250
;1248:
;1249:	// handicap
;1250:	v = Info_ValueForKey( configstring, "hc" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $668
ARGP4
ADDRLP4 1720
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1720
INDIRP4
ASGNP4
line 1251
;1251:	newInfo.handicap = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1724
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+88
ADDRLP4 1724
INDIRI4
ASGNI4
line 1254
;1252:
;1253:	// wins
;1254:	v = Info_ValueForKey( configstring, "w" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $670
ARGP4
ADDRLP4 1728
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1728
INDIRP4
ASGNP4
line 1255
;1255:	newInfo.wins = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1732
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+92
ADDRLP4 1732
INDIRI4
ASGNI4
line 1258
;1256:
;1257:	// losses
;1258:	v = Info_ValueForKey( configstring, "l" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $672
ARGP4
ADDRLP4 1736
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1736
INDIRP4
ASGNP4
line 1259
;1259:	newInfo.losses = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1740
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+96
ADDRLP4 1740
INDIRI4
ASGNI4
line 1262
;1260:
;1261:	// always apply team colors [4] and [5] if specified, this will work in non-team games too
;1262:	if ( cg_teamColors.string[0] && team != TEAM_SPECTATOR ) {
ADDRGP4 cg_teamColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $674
ADDRLP4 1660
INDIRI4
CNSTI4 3
EQI4 $674
line 1263
;1263:		if ( allowNativeModel || ( ( team == TEAM_RED || team == TEAM_BLUE ) && team == myTeam && ( clientNum != myClientNum || cg.demoPlayback ) ) ) {
ADDRLP4 1676
INDIRI4
CNSTI4 0
NEI4 $682
ADDRLP4 1660
INDIRI4
CNSTI4 1
EQI4 $681
ADDRLP4 1660
INDIRI4
CNSTI4 2
NEI4 $677
LABELV $681
ADDRLP4 1660
INDIRI4
ADDRLP4 1664
INDIRI4
NEI4 $677
ADDRFP4 0
INDIRI4
ADDRLP4 1672
INDIRI4
NEI4 $682
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
EQI4 $677
LABELV $682
line 1264
;1264:			v = CG_GetTeamColors( cg_teamColors.string, team );
ADDRGP4 cg_teamColors+16
ARGP4
ADDRLP4 1660
INDIRI4
ARGI4
ADDRLP4 1748
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1748
INDIRP4
ASGNP4
line 1265
;1265:			len = strlen( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1752
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1684
ADDRLP4 1752
INDIRI4
ASGNI4
line 1266
;1266:			if ( len >= 4 )
ADDRLP4 1684
INDIRI4
CNSTI4 4
LTI4 $684
line 1267
;1267:				CG_ColorFromChar( v[3], newInfo.color1 );
ADDRLP4 1652
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+44
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
LABELV $684
line 1268
;1268:			if ( len >= 5 )
ADDRLP4 1684
INDIRI4
CNSTI4 5
LTI4 $687
line 1269
;1269:				CG_ColorFromChar( v[4], newInfo.color2 );
ADDRLP4 1652
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+56
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
LABELV $687
line 1270
;1270:		}
LABELV $677
line 1271
;1271:	}
LABELV $674
line 1274
;1272:
;1273:	// team task
;1274:	v = Info_ValueForKey( configstring, "tt" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $690
ARGP4
ADDRLP4 1744
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1744
INDIRP4
ASGNP4
line 1275
;1275:	newInfo.teamTask = atoi(v);
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1748
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+100
ADDRLP4 1748
INDIRI4
ASGNI4
line 1278
;1276:
;1277:	// team leader
;1278:	v = Info_ValueForKey( configstring, "tl" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $692
ARGP4
ADDRLP4 1752
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1752
INDIRP4
ASGNP4
line 1279
;1279:	newInfo.teamLeader = atoi(v);
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1756
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+104
ADDRLP4 1756
INDIRI4
ASGNI4
line 1282
;1280:
;1281:	// model
;1282:	v = Info_ValueForKey( configstring, "model" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $576
ARGP4
ADDRLP4 1760
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1760
INDIRP4
ASGNP4
line 1283
;1283:	CG_SetSkinAndModel( &newInfo, ci, v, allowNativeModel, clientNum, myClientNum, myTeam, qtrue, 
ADDRLP4 0
ARGP4
ADDRLP4 1668
INDIRP4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1676
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1672
INDIRI4
ARGI4
ADDRLP4 1664
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0+128
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0+192
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_SetSkinAndModel
CALLV
pop
line 1287
;1284:		newInfo.modelName, sizeof( newInfo.modelName ),	newInfo.skinName, sizeof( newInfo.skinName ) );
;1285:
;1286:	// head model
;1287:	v = Info_ValueForKey( configstring, "hmodel" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $698
ARGP4
ADDRLP4 1764
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1764
INDIRP4
ASGNP4
line 1288
;1288:	CG_SetSkinAndModel( &newInfo, ci, v, allowNativeModel, clientNum, myClientNum, myTeam, qfalse, 
ADDRLP4 0
ARGP4
ADDRLP4 1668
INDIRP4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1676
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1672
INDIRI4
ARGI4
ADDRLP4 1664
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0+256
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0+320
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_SetSkinAndModel
CALLV
pop
line 1292
;1289:		newInfo.headModelName, sizeof( newInfo.headModelName ),	newInfo.headSkinName, sizeof( newInfo.headSkinName ) );
;1290:
;1291:	// allow deferred load at some conditions
;1292:	can_defer = cg_deferPlayers.integer == 2 || ( cg_deferPlayers.integer == 1 && myTeam != TEAM_SPECTATOR && team == TEAM_SPECTATOR );
ADDRGP4 cg_deferPlayers+12
INDIRI4
CNSTI4 2
EQI4 $708
ADDRGP4 cg_deferPlayers+12
INDIRI4
CNSTI4 1
NEI4 $706
ADDRLP4 1664
INDIRI4
CNSTI4 3
EQI4 $706
ADDRLP4 1660
INDIRI4
CNSTI4 3
NEI4 $706
LABELV $708
ADDRLP4 1768
CNSTI4 1
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $706
ADDRLP4 1768
CNSTI4 0
ASGNI4
LABELV $707
ADDRLP4 1680
ADDRLP4 1768
INDIRI4
ASGNI4
line 1296
;1293:
;1294:	// scan for an existing clientinfo that matches this modelname
;1295:	// so we can avoid loading checks if possible
;1296:	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1772
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 1772
INDIRI4
CNSTI4 0
NEI4 $709
line 1299
;1297:		qboolean	forceDefer;
;1298:
;1299:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 1784
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 1784
INDIRI4
CNSTI4 4000000
GEI4 $712
ADDRLP4 1780
CNSTI4 1
ASGNI4
ADDRGP4 $713
JUMPV
LABELV $712
ADDRLP4 1780
CNSTI4 0
ASGNI4
LABELV $713
ADDRLP4 1776
ADDRLP4 1780
INDIRI4
ASGNI4
line 1302
;1300:
;1301:		// if we are defering loads, just have it pick the first valid
;1302:		if ( forceDefer || (can_defer && !cg_buildScript.integer && !cg.loading) )  {
ADDRLP4 1776
INDIRI4
CNSTI4 0
NEI4 $718
ADDRLP4 1680
INDIRI4
CNSTI4 0
EQI4 $714
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
NEI4 $714
ADDRGP4 cg+20
INDIRI4
CNSTI4 0
NEI4 $714
LABELV $718
line 1304
;1303:			// keep whatever they had if it won't violate team skins
;1304:			CG_SetDeferredClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 1306
;1305:			// if we are low on memory, leave them with this model
;1306:			if ( forceDefer ) {
ADDRLP4 1776
INDIRI4
CNSTI4 0
EQI4 $715
line 1307
;1307:				CG_Printf( "Memory is low. Using deferred model.\n" );
ADDRGP4 $721
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1308
;1308:				newInfo.deferred = qfalse;
ADDRLP4 0+384
CNSTI4 0
ASGNI4
line 1309
;1309:			}
line 1310
;1310:		} else {
ADDRGP4 $715
JUMPV
LABELV $714
line 1311
;1311:			CG_LoadClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1312
;1312:		}
LABELV $715
line 1313
;1313:	}
LABELV $709
line 1316
;1314:
;1315:	// replace whatever was there with the new one
;1316:	newInfo.infoValid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1317
;1317:	*ci = newInfo;
ADDRLP4 1668
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1652
line 1318
;1318:}
LABELV $610
endproc CG_NewClientInfo 1788 48
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 16 4
line 1330
;1319:
;1320:
;1321:/*
;1322:======================
;1323:CG_LoadDeferredPlayers
;1324:
;1325:Called each frame when a player is dead
;1326:and the scoreboard is up
;1327:so deferred players can be loaded
;1328:======================
;1329:*/
;1330:void CG_LoadDeferredPlayers( void ) {
line 1335
;1331:	int		i;
;1332:	clientInfo_t	*ci;
;1333:
;1334:	// scan for a deferred player to load
;1335:	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+40996
ASGNP4
ADDRGP4 $727
JUMPV
LABELV $724
line 1336
;1336:		if ( ci->infoValid && ci->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $730
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $730
line 1338
;1337:			// if we are low on memory, leave it deferred
;1338:			if ( trap_MemoryRemaining() < 4000000 ) {
ADDRLP4 12
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4000000
GEI4 $732
line 1339
;1339:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $734
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1340
;1340:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 1341
;1341:				continue;
ADDRGP4 $725
JUMPV
LABELV $732
line 1343
;1342:			}
;1343:			CG_LoadClientInfo( ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1345
;1344://			break;
;1345:		}
LABELV $730
line 1346
;1346:	}
LABELV $725
line 1335
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1652
ADDP4
ASGNP4
LABELV $727
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $724
line 1347
;1347:}
LABELV $723
endproc CG_LoadDeferredPlayers 16 4
proc CG_SetLerpFrameAnimation 12 8
line 1365
;1348:
;1349:/*
;1350:=============================================================================
;1351:
;1352:PLAYER ANIMATION
;1353:
;1354:=============================================================================
;1355:*/
;1356:
;1357:
;1358:/*
;1359:===============
;1360:CG_SetLerpFrameAnimation
;1361:
;1362:may include ANIM_TOGGLEBIT
;1363:===============
;1364:*/
;1365:static void CG_SetLerpFrameAnimation( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 1368
;1366:	animation_t	*anim;
;1367:
;1368:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1369
;1369:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1371
;1370:
;1371:	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $738
ADDRLP4 4
INDIRI4
CNSTI4 37
LTI4 $736
LABELV $738
line 1372
;1372:		CG_Error( "Bad animation number: %i", newAnimation );
ADDRGP4 $739
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1373
;1373:	}
LABELV $736
line 1375
;1374:
;1375:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDP4
ASGNP4
line 1377
;1376:
;1377:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1378
;1378:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1380
;1379:
;1380:	if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $740
line 1381
;1381:		CG_Printf( "Anim: %i\n", newAnimation );
ADDRGP4 $743
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1382
;1382:	}
LABELV $740
line 1383
;1383:}
LABELV $735
endproc CG_SetLerpFrameAnimation 12 8
proc CG_RunLerpFrame 36 12
line 1394
;1384:
;1385:
;1386:/*
;1387:===============
;1388:CG_RunLerpFrame
;1389:
;1390:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1391:cg.time should be between oldFrameTime and frameTime after exit
;1392:===============
;1393:*/
;1394:static void CG_RunLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale ) {
line 1399
;1395:	int			f, numFrames;
;1396:	animation_t	*anim;
;1397:
;1398:	// debugging tool to get no animations
;1399:	if ( cg_animSpeed.integer == 0 ) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $745
line 1400
;1400:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1401
;1401:		return;
ADDRGP4 $744
JUMPV
LABELV $745
line 1405
;1402:	}
;1403:
;1404:	// see if the animation sequence is switching
;1405:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $750
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $748
LABELV $750
line 1406
;1406:		CG_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1407
;1407:	}
LABELV $748
line 1411
;1408:
;1409:	// if we have passed the current frame, move it to
;1410:	// oldFrame and calculate a new frame
;1411:	if ( cg.time >= lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $751
line 1412
;1412:		lf->oldFrame = lf->frame;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1413
;1413:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1416
;1414:
;1415:		// get the next frame based on the animation
;1416:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 1417
;1417:		if ( !anim->frameLerp ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $754
line 1418
;1418:			return;		// shouldn't happen
ADDRGP4 $744
JUMPV
LABELV $754
line 1420
;1419:		}
;1420:		if ( cg.time < lf->animationTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $756
line 1421
;1421:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1422
;1422:		} else {
ADDRGP4 $757
JUMPV
LABELV $756
line 1423
;1423:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1424
;1424:		}
LABELV $757
line 1425
;1425:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1426
;1426:		f *= speedScale;		// adjust for haste, etc
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1428
;1427:
;1428:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1429
;1429:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $759
line 1430
;1430:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1431
;1431:		}
LABELV $759
line 1432
;1432:		if ( f >= numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $761
line 1433
;1433:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1434
;1434:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $763
line 1435
;1435:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 1436
;1436:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1437
;1437:			} else {
ADDRGP4 $764
JUMPV
LABELV $763
line 1438
;1438:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1441
;1439:				// the animation is stuck at the end, so it
;1440:				// can immediately transition to another sequence
;1441:				lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1442
;1442:			}
LABELV $764
line 1443
;1443:		}
LABELV $761
line 1444
;1444:		if ( anim->reversed ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $766
line 1445
;1445:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1446
;1446:		}
ADDRGP4 $767
JUMPV
LABELV $766
line 1447
;1447:		else if (anim->flipflop && f>=anim->numFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $768
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $768
line 1448
;1448:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
MODI4
SUBI4
ASGNI4
line 1449
;1449:		}
ADDRGP4 $769
JUMPV
LABELV $768
line 1450
;1450:		else {
line 1451
;1451:			lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1452
;1452:		}
LABELV $769
LABELV $767
line 1453
;1453:		if ( cg.time > lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $770
line 1454
;1454:			lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1455
;1455:			if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $774
line 1456
;1456:				CG_Printf( "Clamp lf->frameTime\n");
ADDRGP4 $777
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1457
;1457:			}
LABELV $774
line 1458
;1458:		}
LABELV $770
line 1459
;1459:	}
LABELV $751
line 1461
;1460:
;1461:	if ( lf->frameTime > cg.time + 200 ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
LEI4 $778
line 1462
;1462:		lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1463
;1463:	}
LABELV $778
line 1465
;1464:
;1465:	if ( lf->oldFrameTime > cg.time ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $782
line 1466
;1466:		lf->oldFrameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1467
;1467:	}
LABELV $782
line 1469
;1468:	// calculate current lerp value
;1469:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $786
line 1470
;1470:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1471
;1471:	} else {
ADDRGP4 $787
JUMPV
LABELV $786
line 1472
;1472:		lf->backlerp = 1.0 - (float)( cg.time - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1473
;1473:	}
LABELV $787
line 1474
;1474:}
LABELV $744
endproc CG_RunLerpFrame 36 12
proc CG_ClearLerpFrame 16 12
line 1482
;1475:
;1476:
;1477:/*
;1478:===============
;1479:CG_ClearLerpFrame
;1480:===============
;1481:*/
;1482:static void CG_ClearLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int animationNumber ) {
line 1483
;1483:	lf->frameTime = lf->oldFrameTime = cg.time;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1484
;1484:	CG_SetLerpFrameAnimation( ci, lf, animationNumber );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1485
;1485:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1486
;1486:}
LABELV $789
endproc CG_ClearLerpFrame 16 12
proc CG_PlayerAnimation 20 16
line 1495
;1487:
;1488:
;1489:/*
;1490:===============
;1491:CG_PlayerAnimation
;1492:===============
;1493:*/
;1494:static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1495:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 1500
;1496:	clientInfo_t	*ci;
;1497:	int				clientNum;
;1498:	float			speedScale;
;1499:
;1500:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1502
;1501:
;1502:	if ( cg_noPlayerAnims.integer ) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $792
line 1503
;1503:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1504
;1504:		return;
ADDRGP4 $791
JUMPV
LABELV $792
line 1507
;1505:	}
;1506:
;1507:	if ( cent->currentState.powerups & ( 1 << PW_HASTE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $795
line 1508
;1508:		speedScale = 1.5;
ADDRLP4 4
CNSTF4 1069547520
ASGNF4
line 1509
;1509:	} else {
ADDRGP4 $796
JUMPV
LABELV $795
line 1510
;1510:		speedScale = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1511
;1511:	}
LABELV $796
line 1513
;1512:
;1513:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1516
;1514:
;1515:	// do the shuffle turn frames locally
;1516:	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
EQI4 $798
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $798
line 1517
;1517:		CG_RunLerpFrame( ci, &cent->pe.legs, LEGS_TURN, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1518
;1518:	} else {
ADDRGP4 $799
JUMPV
LABELV $798
line 1519
;1519:		CG_RunLerpFrame( ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 460
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1520
;1520:	}
LABELV $799
line 1522
;1521:
;1522:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1523
;1523:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
ASGNI4
line 1524
;1524:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ASGNF4
line 1526
;1525:
;1526:	CG_RunLerpFrame( ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1528
;1527:
;1528:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ASGNI4
line 1529
;1529:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ASGNI4
line 1530
;1530:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRF4
ASGNF4
line 1531
;1531:}
LABELV $791
endproc CG_PlayerAnimation 20 16
proc CG_SwingAngles 28 8
line 1547
;1532:
;1533:/*
;1534:=============================================================================
;1535:
;1536:PLAYER ANGLES
;1537:
;1538:=============================================================================
;1539:*/
;1540:
;1541:/*
;1542:==================
;1543:CG_SwingAngles
;1544:==================
;1545:*/
;1546:static void CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;1547:					float speed, float *angle, qboolean *swinging ) {
line 1552
;1548:	float	swing;
;1549:	float	move;
;1550:	float	scale;
;1551:
;1552:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $801
line 1554
;1553:		// see if a swing should be started
;1554:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1555
;1555:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $805
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $803
LABELV $805
line 1556
;1556:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1557
;1557:		}
LABELV $803
line 1558
;1558:	}
LABELV $801
line 1560
;1559:
;1560:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $806
line 1561
;1561:		return;
ADDRGP4 $800
JUMPV
LABELV $806
line 1566
;1562:	}
;1563:	
;1564:	// modify the speed depending on the delta
;1565:	// so it doesn't seem so linear
;1566:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1567
;1567:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1568
;1568:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
GEF4 $808
line 1569
;1569:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1570
;1570:	} else if ( scale < swingTolerance ) {
ADDRGP4 $809
JUMPV
LABELV $808
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $810
line 1571
;1571:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1572
;1572:	} else {
ADDRGP4 $811
JUMPV
LABELV $810
line 1573
;1573:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1574
;1574:	}
LABELV $811
LABELV $809
line 1577
;1575:
;1576:	// swing towards the destination angle
;1577:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $812
line 1578
;1578:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1579
;1579:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $815
line 1580
;1580:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1581
;1581:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1582
;1582:		}
LABELV $815
line 1583
;1583:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1584
;1584:	} else {
ADDRGP4 $813
JUMPV
LABELV $812
line 1585
;1585:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1586
;1586:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $818
line 1587
;1587:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1588
;1588:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1589
;1589:		}
LABELV $818
line 1590
;1590:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1591
;1591:	}
LABELV $813
line 1594
;1592:
;1593:	// clamp to no more than tolerance
;1594:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1595
;1595:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $820
line 1596
;1596:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1597
;1597:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $821
JUMPV
LABELV $820
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $822
line 1598
;1598:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1599
;1599:	}
LABELV $822
LABELV $821
line 1600
;1600:}
LABELV $800
endproc CG_SwingAngles 28 8
proc CG_AddPainTwitch 12 0
line 1608
;1601:
;1602:
;1603:/*
;1604:=================
;1605:CG_AddPainTwitch
;1606:=================
;1607:*/
;1608:static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
line 1612
;1609:	int		t;
;1610:	float	f;
;1611:
;1612:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1613
;1613:	if ( t >= PAIN_TWITCH_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $826
line 1614
;1614:		return;
ADDRGP4 $824
JUMPV
LABELV $826
line 1617
;1615:	}
;1616:
;1617:	f = 1.0 - (float)t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 1619
;1618:
;1619:	if ( cent->pe.painDirection ) {
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 0
EQI4 $828
line 1620
;1620:		torsoAngles[ROLL] += 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 1621
;1621:	} else {
ADDRGP4 $829
JUMPV
LABELV $828
line 1622
;1622:		torsoAngles[ROLL] -= 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
SUBF4
ASGNF4
line 1623
;1623:	}
LABELV $829
line 1624
;1624:}
LABELV $824
endproc CG_AddPainTwitch 12 0
data
align 4
LABELV $831
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
code
proc CG_PlayerAngles 136 24
line 1641
;1625:
;1626:
;1627:/*
;1628:===============
;1629:CG_PlayerAngles
;1630:
;1631:Handles separate torso motion
;1632:
;1633:  legs pivot based on direction of movement
;1634:
;1635:  head always looks exactly at cent->lerpAngles
;1636:
;1637:  if motion < 20 degrees, show in head only
;1638:  if < 45 degrees, also show in torso
;1639:===============
;1640:*/
;1641:static void CG_PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 1650
;1642:	vec3_t		legsAngles, torsoAngles, headAngles;
;1643:	float		dest;
;1644:	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
;1645:	vec3_t		velocity;
;1646:	float		speed;
;1647:	int			dir, clientNum;
;1648:	clientInfo_t	*ci;
;1649:
;1650:	VectorCopy( cent->lerpAngles, headAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1651
;1651:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 68
INDIRF4
ASGNF4
line 1652
;1652:	VectorClear( legsAngles );
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12+4
CNSTF4 0
ASGNF4
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1653
;1653:	VectorClear( torsoAngles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1658
;1654:
;1655:	// --------- yaw -------------
;1656:
;1657:	// allow yaw to drift a bit
;1658:	if ( ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $840
ADDRLP4 72
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 11
EQI4 $838
ADDRLP4 72
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 12
EQI4 $838
LABELV $840
line 1660
;1659:		|| ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND 
;1660:		&& (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND2)) {
line 1662
;1661:		// if not standing still, always point all in the same direction
;1662:		cent->pe.torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 1663
;1663:		cent->pe.torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 1
ASGNI4
line 1664
;1664:		cent->pe.legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 1
ASGNI4
line 1665
;1665:	}
LABELV $838
line 1668
;1666:
;1667:	// adjust legs for movement dir
;1668:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $841
line 1670
;1669:		// don't let dead bodies twitch
;1670:		dir = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1671
;1671:	} else {
ADDRGP4 $842
JUMPV
LABELV $841
line 1672
;1672:		dir = cent->currentState.angles2[YAW];
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1673
;1673:		if ( dir < 0 || dir > 7 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $845
ADDRLP4 52
INDIRI4
CNSTI4 7
LEI4 $843
LABELV $845
line 1674
;1674:			CG_Error( "Bad player movement angle" );
ADDRGP4 $846
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1675
;1675:		}
LABELV $843
line 1676
;1676:	}
LABELV $842
line 1677
;1677:	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $831
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1678
;1678:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $831
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 1681
;1679:
;1680:	// torso
;1681:	CG_SwingAngles( torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1682
;1682:	CG_SwingAngles( legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRLP4 12+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 484
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1684
;1683:
;1684:	torsoAngles[YAW] = cent->pe.torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1685
;1685:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ASGNF4
line 1691
;1686:
;1687:
;1688:	// --------- pitch -------------
;1689:
;1690:	// only show a fraction of the pitch angle in the torso
;1691:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 24
INDIRF4
CNSTF4 1127481344
LEF4 $857
line 1692
;1692:		dest = (-360 + headAngles[PITCH]) * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 3283353600
ADDF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1693
;1693:	} else {
ADDRGP4 $858
JUMPV
LABELV $857
line 1694
;1694:		dest = headAngles[PITCH] * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1695
;1695:	}
LABELV $858
line 1696
;1696:	CG_SwingAngles( dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 536
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 540
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1697
;1697:	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
ASGNF4
line 1700
;1698:
;1699:	//
;1700:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1701
;1701:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $859
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $859
line 1702
;1702:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1703
;1703:		if ( ci->fixedtorso ) {
ADDRLP4 64
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
CNSTI4 0
EQI4 $862
line 1704
;1704:			torsoAngles[PITCH] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1705
;1705:		}
LABELV $862
line 1706
;1706:	}
LABELV $859
line 1712
;1707:
;1708:	// --------- roll -------------
;1709:
;1710:
;1711:	// lean towards the direction of travel
;1712:	VectorCopy( cent->currentState.pos.trDelta, velocity );
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1713
;1713:	speed = VectorNormalize( velocity );
ADDRLP4 40
ARGP4
ADDRLP4 92
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 92
INDIRF4
ASGNF4
line 1714
;1714:	if ( speed ) {
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $864
line 1718
;1715:		vec3_t	axis[3];
;1716:		float	side;
;1717:
;1718:		speed *= 0.05f;
ADDRLP4 56
ADDRLP4 56
INDIRF4
CNSTF4 1028443341
MULF4
ASGNF4
line 1720
;1719:
;1720:		AnglesToAxis( legsAngles, axis );
ADDRLP4 12
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1721
;1721:		side = speed * DotProduct( velocity, axis[1] );
ADDRLP4 132
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 96+12
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 96+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 96+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1722
;1722:		legsAngles[ROLL] -= side;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 132
INDIRF4
SUBF4
ASGNF4
line 1724
;1723:
;1724:		side = speed * DotProduct( velocity, axis[0] );
ADDRLP4 132
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 96+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 96+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1725
;1725:		legsAngles[PITCH] += side;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 132
INDIRF4
ADDF4
ASGNF4
line 1726
;1726:	}
LABELV $864
line 1729
;1727:
;1728:	//
;1729:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1730
;1730:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $878
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $878
line 1731
;1731:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1732
;1732:		if ( ci->fixedlegs ) {
ADDRLP4 64
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $881
line 1733
;1733:			legsAngles[YAW] = torsoAngles[YAW];
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 1734
;1734:			legsAngles[PITCH] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1735
;1735:			legsAngles[ROLL] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1736
;1736:		}
LABELV $881
line 1737
;1737:	}
LABELV $878
line 1740
;1738:
;1739:	// pain twitch
;1740:	CG_AddPainTwitch( cent, torsoAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 1743
;1741:
;1742:	// pull the angles back out of the hierarchial chain
;1743:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1744
;1744:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1745
;1745:	AnglesToAxis( legsAngles, legs );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1746
;1746:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1747
;1747:	AnglesToAxis( headAngles, head );
ADDRLP4 24
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1748
;1748:}
LABELV $830
endproc CG_PlayerAngles 136 24
proc CG_HasteTrail 32 48
line 1758
;1749:
;1750:
;1751://==========================================================================
;1752:
;1753:/*
;1754:===============
;1755:CG_HasteTrail
;1756:===============
;1757:*/
;1758:static void CG_HasteTrail( centity_t *cent ) {
line 1763
;1759:	localEntity_t	*smoke;
;1760:	vec3_t			origin;
;1761:	int				anim;
;1762:
;1763:	if ( cent->trailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $887
line 1764
;1764:		return;
ADDRGP4 $886
JUMPV
LABELV $887
line 1766
;1765:	}
;1766:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1767
;1767:	if ( anim != LEGS_RUN && anim != LEGS_BACK ) {
ADDRLP4 12
INDIRI4
CNSTI4 15
EQI4 $890
ADDRLP4 12
INDIRI4
CNSTI4 16
EQI4 $890
line 1768
;1768:		return;
ADDRGP4 $886
JUMPV
LABELV $890
line 1771
;1769:	}
;1770:
;1771:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1772
;1772:	if ( cent->trailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $892
line 1773
;1773:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1774
;1774:	}
LABELV $892
line 1776
;1775:
;1776:	VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 1777
;1777:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1779
;1778:
;1779:	smoke = CG_SmokePuff( origin, vec3_origin, 
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148752+440
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 1789
;1780:				  8, 
;1781:				  1, 1, 1, 1,
;1782:				  500, 
;1783:				  cg.time,
;1784:				  0,
;1785:				  0,
;1786:				  cgs.media.hastePuffShader );
;1787:
;1788:	// use the optimized local entity add
;1789:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 1790
;1790:}
LABELV $886
endproc CG_HasteTrail 32 48
proc CG_TrailItem 188 12
line 1885
;1791:
;1792:
;1793:#ifdef MISSIONPACK
;1794:/*
;1795:===============
;1796:CG_BreathPuffs
;1797:===============
;1798:*/
;1799:static void CG_BreathPuffs( centity_t *cent, refEntity_t *head) {
;1800:	clientInfo_t *ci;
;1801:	vec3_t up, origin;
;1802:	int contents;
;1803:
;1804:	ci = &cgs.clientinfo[ cent->currentState.number ];
;1805:
;1806:	if (!cg_enableBreath.integer) {
;1807:		return;
;1808:	}
;1809:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
;1810:		return;
;1811:	}
;1812:	if ( cent->currentState.eFlags & EF_DEAD ) {
;1813:		return;
;1814:	}
;1815:	contents = CG_PointContents( head->origin, 0 );
;1816:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
;1817:		return;
;1818:	}
;1819:	if ( ci->breathPuffTime > cg.time ) {
;1820:		return;
;1821:	}
;1822:
;1823:	VectorSet( up, 0, 0, 8 );
;1824:	VectorMA(head->origin, 8, head->axis[0], origin);
;1825:	VectorMA(origin, -4, head->axis[2], origin);
;1826:	CG_SmokePuff( origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
;1827:	ci->breathPuffTime = cg.time + 2000;
;1828:}
;1829:
;1830:/*
;1831:===============
;1832:CG_DustTrail
;1833:===============
;1834:*/
;1835:static void CG_DustTrail( centity_t *cent ) {
;1836:	int				anim;
;1837:	vec3_t end, vel;
;1838:	trace_t tr;
;1839:
;1840:	if (!cg_enableDust.integer)
;1841:		return;
;1842:
;1843:	if ( cent->dustTrailTime > cg.time ) {
;1844:		return;
;1845:	}
;1846:
;1847:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
;1848:	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
;1849:		return;
;1850:	}
;1851:
;1852:	cent->dustTrailTime += 40;
;1853:	if ( cent->dustTrailTime < cg.time ) {
;1854:		cent->dustTrailTime = cg.time;
;1855:	}
;1856:
;1857:	VectorCopy(cent->currentState.pos.trBase, end);
;1858:	end[2] -= 64;
;1859:	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );
;1860:
;1861:	if ( !(tr.surfaceFlags & SURF_DUST) )
;1862:		return;
;1863:
;1864:	VectorCopy( cent->currentState.pos.trBase, end );
;1865:	end[2] -= 16;
;1866:
;1867:	VectorSet(vel, 0, 0, -30);
;1868:	CG_SmokePuff( end, vel,
;1869:				  24,
;1870:				  .8f, .8f, 0.7f, 0.33f,
;1871:				  500,
;1872:				  cg.time,
;1873:				  0,
;1874:				  0,
;1875:				  cgs.media.dustPuffShader );
;1876:}
;1877:#endif
;1878:
;1879:
;1880:/*
;1881:===============
;1882:CG_TrailItem
;1883:===============
;1884:*/
;1885:static void CG_TrailItem( const centity_t *cent, qhandle_t hModel ) {
line 1890
;1886:	refEntity_t		ent;
;1887:	vec3_t			angles;
;1888:	vec3_t			axis[3];
;1889:
;1890:	VectorCopy( cent->lerpAngles, angles );
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1891
;1891:	angles[PITCH] = 0;
ADDRLP4 140
CNSTF4 0
ASGNF4
line 1892
;1892:	angles[ROLL] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1893
;1893:	AnglesToAxis( angles, axis );
ADDRLP4 140
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1895
;1894:
;1895:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1896
;1896:	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ADDRLP4 152+4
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ADDRLP4 152+8
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
line 1897
;1897:	ent.origin[2] += 16;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1898
;1898:	angles[YAW] += 90;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1899
;1899:	AnglesToAxis( angles, ent.axis );
ADDRLP4 140
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1901
;1900:
;1901:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 1902
;1902:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1903
;1903:}
LABELV $900
endproc CG_TrailItem 188 12
proc CG_PlayerFlag 352 24
line 1911
;1904:
;1905:
;1906:/*
;1907:===============
;1908:CG_PlayerFlag
;1909:===============
;1910:*/
;1911:static void CG_PlayerFlag( centity_t *cent, qhandle_t hSkin, refEntity_t *torso ) {
line 1920
;1912:	clientInfo_t	*ci;
;1913:	refEntity_t	pole;
;1914:	refEntity_t	flag;
;1915:	vec3_t		angles, dir;
;1916:	int			legsAnim, flagAnim, updateangles;
;1917:	float		angle, d;
;1918:
;1919:	// show the flag pole model
;1920:	memset( &pole, 0, sizeof(pole) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1921
;1921:	pole.hModel = cgs.media.flagPoleModel;
ADDRLP4 0+8
ADDRGP4 cgs+148752+88
INDIRI4
ASGNI4
line 1922
;1922:	VectorCopy( torso->lightingOrigin, pole.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1923
;1923:	pole.shadowPlane = torso->shadowPlane;
ADDRLP4 0+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1924
;1924:	pole.renderfx = torso->renderfx;
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1925
;1925:	CG_PositionEntityOnTag( &pole, torso, torso->hModel, "tag_flag" );
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $442
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 1926
;1926:	trap_R_AddRefEntityToScene( &pole );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1929
;1927:
;1928:	// show the flag model
;1929:	memset( &flag, 0, sizeof(flag) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1930
;1930:	flag.hModel = cgs.media.flagFlapModel;
ADDRLP4 140+8
ADDRGP4 cgs+148752+92
INDIRI4
ASGNI4
line 1931
;1931:	flag.customSkin = hSkin;
ADDRLP4 140+108
ADDRFP4 4
INDIRI4
ASGNI4
line 1932
;1932:	VectorCopy( torso->lightingOrigin, flag.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1933
;1933:	flag.shadowPlane = torso->shadowPlane;
ADDRLP4 140+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1934
;1934:	flag.renderfx = torso->renderfx;
ADDRLP4 140+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1936
;1935:
;1936:	VectorClear(angles);
ADDRLP4 280
CNSTF4 0
ASGNF4
ADDRLP4 280+4
CNSTF4 0
ASGNF4
ADDRLP4 280+8
CNSTF4 0
ASGNF4
line 1938
;1937:
;1938:	updateangles = qfalse;
ADDRLP4 312
CNSTI4 0
ASGNI4
line 1939
;1939:	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1940
;1940:	if( legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR ) {
ADDRLP4 304
INDIRI4
CNSTI4 22
EQI4 $932
ADDRLP4 304
INDIRI4
CNSTI4 23
NEI4 $930
LABELV $932
line 1941
;1941:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 1942
;1942:	} else if ( legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR ) {
ADDRGP4 $931
JUMPV
LABELV $930
ADDRLP4 304
INDIRI4
CNSTI4 14
EQI4 $935
ADDRLP4 304
INDIRI4
CNSTI4 13
NEI4 $933
LABELV $935
line 1943
;1943:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 1944
;1944:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 1945
;1945:	} else {
ADDRGP4 $934
JUMPV
LABELV $933
line 1946
;1946:		flagAnim = FLAG_RUN;
ADDRLP4 320
CNSTI4 34
ASGNI4
line 1947
;1947:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 1948
;1948:	}
LABELV $934
LABELV $931
line 1950
;1949:
;1950:	if ( updateangles ) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $936
line 1952
;1951:
;1952:		VectorCopy( cent->currentState.pos.trDelta, dir );
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1954
;1953:		// add gravity
;1954:		dir[2] += 100;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 1955
;1955:		VectorNormalize( dir );
ADDRLP4 292
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1956
;1956:		d = DotProduct(pole.axis[2], dir);
ADDRLP4 308
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1958
;1957:		// if there is enough movement orthogonal to the flag pole
;1958:		if (fabs(d) < 0.9) {
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 340
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 340
INDIRF4
CNSTF4 1063675494
GEF4 $949
line 1960
;1959:			//
;1960:			d = DotProduct(pole.axis[0], dir);
ADDRLP4 308
ADDRLP4 0+28
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1961
;1961:			if (d > 1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 1065353216
LEF4 $958
line 1962
;1962:				d = 1.0f;
ADDRLP4 308
CNSTF4 1065353216
ASGNF4
line 1963
;1963:			}
ADDRGP4 $959
JUMPV
LABELV $958
line 1964
;1964:			else if (d < -1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 3212836864
GEF4 $960
line 1965
;1965:				d = -1.0f;
ADDRLP4 308
CNSTF4 3212836864
ASGNF4
line 1966
;1966:			}
LABELV $960
LABELV $959
line 1967
;1967:			angle = acos(d);
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 344
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 344
INDIRF4
ASGNF4
line 1969
;1968:
;1969:			d = DotProduct(pole.axis[1], dir);
ADDRLP4 308
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1970
;1970:			if (d < 0) {
ADDRLP4 308
INDIRF4
CNSTF4 0
GEF4 $972
line 1971
;1971:				angles[YAW] = 360 - angle * 180 / M_PI;
ADDRLP4 280+4
CNSTF4 1135869952
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
SUBF4
ASGNF4
line 1972
;1972:			}
ADDRGP4 $973
JUMPV
LABELV $972
line 1973
;1973:			else {
line 1974
;1974:				angles[YAW] = angle * 180 / M_PI;
ADDRLP4 280+4
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 1975
;1975:			}
LABELV $973
line 1976
;1976:			if (angles[YAW] < 0)
ADDRLP4 280+4
INDIRF4
CNSTF4 0
GEF4 $976
line 1977
;1977:				angles[YAW] += 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $976
line 1978
;1978:			if (angles[YAW] > 360)
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
LEF4 $980
line 1979
;1979:				angles[YAW] -= 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $980
line 1984
;1980:
;1981:			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
;1982:			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
;1983:			// change the yaw angle
;1984:			CG_SwingAngles( angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing );
ADDRLP4 280+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1041865114
ARGF4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 576
ADDP4
ARGP4
ADDRLP4 348
INDIRP4
CNSTI4 580
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1985
;1985:		}
LABELV $949
line 2005
;1986:
;1987:		/*
;1988:		d = DotProduct(pole.axis[2], dir);
;1989:		angle = Q_acos(d);
;1990:
;1991:		d = DotProduct(pole.axis[1], dir);
;1992:		if (d < 0) {
;1993:			angle = 360 - angle * 180 / M_PI;
;1994:		}
;1995:		else {
;1996:			angle = angle * 180 / M_PI;
;1997:		}
;1998:		if (angle > 340 && angle < 20) {
;1999:			flagAnim = FLAG_RUNUP;
;2000:		}
;2001:		if (angle > 160 && angle < 200) {
;2002:			flagAnim = FLAG_RUNDOWN;
;2003:		}
;2004:		*/
;2005:	}
LABELV $936
line 2008
;2006:
;2007:	// set the yaw angle
;2008:	angles[YAW] = cent->pe.flag.yawAngle;
ADDRLP4 280+4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRF4
ASGNF4
line 2010
;2009:	// lerp the flag animation frames
;2010:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2011
;2011:	CG_RunLerpFrame( ci, &cent->pe.flag, flagAnim, 1 );
ADDRLP4 316
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ARGP4
ADDRLP4 320
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 2012
;2012:	flag.oldframe = cent->pe.flag.oldFrame;
ADDRLP4 140+96
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 2013
;2013:	flag.frame = cent->pe.flag.frame;
ADDRLP4 140+80
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ASGNI4
line 2014
;2014:	flag.backlerp = cent->pe.flag.backlerp;
ADDRLP4 140+100
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
ASGNF4
line 2016
;2015:
;2016:	AnglesToAxis( angles, flag.axis );
ADDRLP4 280
ARGP4
ADDRLP4 140+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2017
;2017:	CG_PositionRotatedEntityOnTag( &flag, &pole, pole.hModel, "tag_flag" );
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $442
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2019
;2018:
;2019:	trap_R_AddRefEntityToScene( &flag );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2020
;2020:}
LABELV $914
endproc CG_PlayerFlag 352 24
proc CG_PlayerPowerups 12 20
line 2096
;2021:
;2022:
;2023:#ifdef MISSIONPACK // bk001204
;2024:/*
;2025:===============
;2026:CG_PlayerTokens
;2027:===============
;2028:*/
;2029:static void CG_PlayerTokens( centity_t *cent, int renderfx ) {
;2030:	int			tokens, i, j;
;2031:	float		angle;
;2032:	refEntity_t	ent;
;2033:	vec3_t		dir, origin;
;2034:	skulltrail_t *trail;
;2035:	trail = &cg.skulltrails[cent->currentState.number];
;2036:	tokens = cent->currentState.generic1;
;2037:	if ( !tokens ) {
;2038:		trail->numpositions = 0;
;2039:		return;
;2040:	}
;2041:
;2042:	if ( tokens > MAX_SKULLTRAIL ) {
;2043:		tokens = MAX_SKULLTRAIL;
;2044:	}
;2045:
;2046:	// add skulls if there are more than last time
;2047:	for (i = 0; i < tokens - trail->numpositions; i++) {
;2048:		for (j = trail->numpositions; j > 0; j--) {
;2049:			VectorCopy(trail->positions[j-1], trail->positions[j]);
;2050:		}
;2051:		VectorCopy(cent->lerpOrigin, trail->positions[0]);
;2052:	}
;2053:	trail->numpositions = tokens;
;2054:
;2055:	// move all the skulls along the trail
;2056:	VectorCopy(cent->lerpOrigin, origin);
;2057:	for (i = 0; i < trail->numpositions; i++) {
;2058:		VectorSubtract(trail->positions[i], origin, dir);
;2059:		if (VectorNormalize(dir) > 30) {
;2060:			VectorMA(origin, 30, dir, trail->positions[i]);
;2061:		}
;2062:		VectorCopy(trail->positions[i], origin);
;2063:	}
;2064:
;2065:	memset( &ent, 0, sizeof( ent ) );
;2066:	if( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE ) {
;2067:		ent.hModel = cgs.media.redCubeModel;
;2068:	} else {
;2069:		ent.hModel = cgs.media.blueCubeModel;
;2070:	}
;2071:	ent.renderfx = renderfx;
;2072:
;2073:	VectorCopy(cent->lerpOrigin, origin);
;2074:	for (i = 0; i < trail->numpositions; i++) {
;2075:		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
;2076:		ent.axis[0][2] = 0;
;2077:		VectorNormalize(ent.axis[0]);
;2078:		VectorSet(ent.axis[2], 0, 0, 1);
;2079:		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
;2080:
;2081:		VectorCopy(trail->positions[i], ent.origin);
;2082:		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
;2083:		ent.origin[2] += sin(angle) * 10;
;2084:		trap_R_AddRefEntityToScene( &ent );
;2085:		VectorCopy(trail->positions[i], origin);
;2086:	}
;2087:}
;2088:#endif
;2089:
;2090:
;2091:/*
;2092:===============
;2093:CG_PlayerPowerups
;2094:===============
;2095:*/
;2096:static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
line 2100
;2097:	int		powerups;
;2098:	clientInfo_t	*ci;
;2099:
;2100:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2101
;2101:	if ( !powerups ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $993
line 2102
;2102:		return;
ADDRGP4 $992
JUMPV
LABELV $993
line 2106
;2103:	}
;2104:
;2105:	// quad gives a dlight
;2106:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $995
line 2107
;2107:		if ( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $997
line 2108
;2108:			trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2109
;2109:		} else {
ADDRGP4 $998
JUMPV
LABELV $997
line 2110
;2110:			trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 0.2f, 0.2f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2111
;2111:		}
LABELV $998
line 2112
;2112:	}
LABELV $995
line 2115
;2113:
;2114:	// flight plays a looped sound
;2115:	if ( powerups & ( 1 << PW_FLIGHT ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1001
line 2116
;2116:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+148752+844
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 2117
;2117:	}
LABELV $1001
line 2119
;2118:
;2119:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2121
;2120:	// redflag
;2121:	if ( powerups & ( 1 << PW_REDFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1006
line 2122
;2122:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1008
line 2123
;2123:			CG_PlayerFlag( cent, cgs.media.redFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+96
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2124
;2124:		}
ADDRGP4 $1009
JUMPV
LABELV $1008
line 2125
;2125:		else {
line 2126
;2126:			CG_TrailItem( cent, cgs.media.redFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+36
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2127
;2127:		}
LABELV $1009
line 2128
;2128:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2129
;2129:	}
LABELV $1006
line 2132
;2130:
;2131:	// blueflag
;2132:	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1014
line 2133
;2133:		if (ci->newAnims){
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1016
line 2134
;2134:			CG_PlayerFlag( cent, cgs.media.blueFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+100
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2135
;2135:		}
ADDRGP4 $1017
JUMPV
LABELV $1016
line 2136
;2136:		else {
line 2137
;2137:			CG_TrailItem( cent, cgs.media.blueFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+40
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2138
;2138:		}
LABELV $1017
line 2139
;2139:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 0.2f, 0.2f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2140
;2140:	}
LABELV $1014
line 2143
;2141:
;2142:	// neutralflag
;2143:	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1022
line 2144
;2144:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1024
line 2145
;2145:			CG_PlayerFlag( cent, cgs.media.neutralFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+104
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2146
;2146:		}
ADDRGP4 $1025
JUMPV
LABELV $1024
line 2147
;2147:		else {
line 2148
;2148:			CG_TrailItem( cent, cgs.media.neutralFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+44
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2149
;2149:		}
LABELV $1025
line 2150
;2150:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 1.0f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2151
;2151:	}
LABELV $1022
line 2154
;2152:
;2153:	// haste leaves smoke trails
;2154:	if ( powerups & ( 1 << PW_HASTE ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1030
line 2155
;2155:		CG_HasteTrail( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2156
;2156:	}
LABELV $1030
line 2157
;2157:}
LABELV $992
endproc CG_PlayerPowerups 12 20
proc CG_PlayerFloatSprite 144 12
line 2167
;2158:
;2159:
;2160:/*
;2161:===============
;2162:CG_PlayerFloatSprite
;2163:
;2164:Float a sprite over the player's head
;2165:===============
;2166:*/
;2167:static void CG_PlayerFloatSprite( const centity_t *cent, qhandle_t shader ) {
line 2171
;2168:	int				rf;
;2169:	refEntity_t		ent;
;2170:
;2171:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1033
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1033
line 2172
;2172:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 140
CNSTI4 2
ASGNI4
line 2173
;2173:	} else {
ADDRGP4 $1034
JUMPV
LABELV $1033
line 2174
;2174:		rf = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 2175
;2175:	}
LABELV $1034
line 2177
;2176:
;2177:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2178
;2178:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2179
;2179:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2180
;2180:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2181
;2181:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2182
;2182:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2183
;2183:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 140
INDIRI4
ASGNI4
line 2184
;2184:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 2185
;2185:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 2186
;2186:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 2187
;2187:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2188
;2188:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2189
;2189:}
LABELV $1032
endproc CG_PlayerFloatSprite 144 12
proc CG_PlayerSprites 4 8
line 2199
;2190:
;2191:
;2192:/*
;2193:===============
;2194:CG_PlayerSprites
;2195:
;2196:Float sprites over the player's head
;2197:===============
;2198:*/
;2199:static void CG_PlayerSprites( centity_t *cent ) {
line 2202
;2200:	int		team;
;2201:
;2202:	if ( cent->currentState.eFlags & EF_CONNECTION ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1051
line 2203
;2203:		CG_PlayerFloatSprite( cent, cgs.media.connectionShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+208
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2204
;2204:		return;
ADDRGP4 $1050
JUMPV
LABELV $1051
line 2207
;2205:	}
;2206:
;2207:	if ( cent->currentState.eFlags & EF_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1055
line 2208
;2208:		CG_PlayerFloatSprite( cent, cgs.media.balloonShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+204
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2209
;2209:		return;
ADDRGP4 $1050
JUMPV
LABELV $1055
line 2212
;2210:	}
;2211:
;2212:	if ( cent->currentState.eFlags & EF_AWARD_IMPRESSIVE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1059
line 2213
;2213:		CG_PlayerFloatSprite( cent, cgs.media.medalImpressive );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+512
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2214
;2214:		return;
ADDRGP4 $1050
JUMPV
LABELV $1059
line 2217
;2215:	}
;2216:
;2217:	if ( cent->currentState.eFlags & EF_AWARD_EXCELLENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1063
line 2218
;2218:		CG_PlayerFloatSprite( cent, cgs.media.medalExcellent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+516
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2219
;2219:		return;
ADDRGP4 $1050
JUMPV
LABELV $1063
line 2222
;2220:	}
;2221:
;2222:	if ( cent->currentState.eFlags & EF_AWARD_GAUNTLET ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1067
line 2223
;2223:		CG_PlayerFloatSprite( cent, cgs.media.medalGauntlet );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+520
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2224
;2224:		return;
ADDRGP4 $1050
JUMPV
LABELV $1067
line 2227
;2225:	}
;2226:
;2227:	if ( cent->currentState.eFlags & EF_AWARD_DEFEND ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1071
line 2228
;2228:		CG_PlayerFloatSprite( cent, cgs.media.medalDefend );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+524
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2229
;2229:		return;
ADDRGP4 $1050
JUMPV
LABELV $1071
line 2232
;2230:	}
;2231:
;2232:	if ( cent->currentState.eFlags & EF_AWARD_ASSIST ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1075
line 2233
;2233:		CG_PlayerFloatSprite( cent, cgs.media.medalAssist );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+528
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2234
;2234:		return;
ADDRGP4 $1050
JUMPV
LABELV $1075
line 2237
;2235:	}
;2236:
;2237:	if ( cent->currentState.eFlags & EF_AWARD_CAP ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1079
line 2238
;2238:		CG_PlayerFloatSprite( cent, cgs.media.medalCapture );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+532
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2239
;2239:		return;
ADDRGP4 $1050
JUMPV
LABELV $1079
line 2242
;2240:	}
;2241:
;2242:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 2243
;2243:	if ( !(cent->currentState.eFlags & EF_DEAD) && 
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1085
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1085
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1085
line 2245
;2244:		cg.snap->ps.persistant[PERS_TEAM] == team &&
;2245:		cgs.gametype >= GT_TEAM) {
line 2246
;2246:		if (cg_drawFriend.integer) {
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $1050
line 2247
;2247:			CG_PlayerFloatSprite( cent, cgs.media.friendShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148752+200
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2248
;2248:		}
line 2249
;2249:		return;
LABELV $1085
line 2251
;2250:	}
;2251:}
LABELV $1050
endproc CG_PlayerSprites 4 8
data
align 4
LABELV $1095
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1096
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 100 44
line 2264
;2252:
;2253:
;2254:/*
;2255:===============
;2256:CG_PlayerShadow
;2257:
;2258:Returns the Z component of the surface being shadowed
;2259:
;2260:  should it return a full plane instead of a Z?
;2261:===============
;2262:*/
;2263:#define	SHADOW_DISTANCE		128
;2264:static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
line 2265
;2265:	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 72
ADDRGP4 $1095
INDIRB
ASGNB 12
ADDRLP4 84
ADDRGP4 $1096
INDIRB
ASGNB 12
line 2269
;2266:	trace_t		trace;
;2267:	float		alpha;
;2268:
;2269:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2271
;2270:
;2271:	if ( cg_shadows.integer == 0 ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1097
line 2272
;2272:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1094
JUMPV
LABELV $1097
line 2276
;2273:	}
;2274:
;2275:	// no shadows when invisible
;2276:	if ( cent->currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1100
line 2277
;2277:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1094
JUMPV
LABELV $1100
line 2281
;2278:	}
;2279:
;2280:	// send a trace down from the player to the ground
;2281:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2282
;2282:	end[2] -= SHADOW_DISTANCE;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
CNSTF4 1124073472
SUBF4
ASGNF4
line 2284
;2283:
;2284:	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2287
;2285:
;2286:	// no shadow if too high
;2287:	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1108
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1108
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1103
LABELV $1108
line 2288
;2288:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1094
JUMPV
LABELV $1103
line 2291
;2289:	}
;2290:
;2291:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2293
;2292:
;2293:	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1111
line 2294
;2294:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1094
JUMPV
LABELV $1111
line 2298
;2295:	}
;2296:
;2297:	// fade the shadow out with height
;2298:	alpha = 1.0 - trace.fraction;
ADDRLP4 56
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2305
;2299:
;2300:	// bk0101022 - hack / FPE - bogus planes?
;2301:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2302:
;2303:	// add the mark as a temporary, so it goes directly to the renderer
;2304:	// without taking a spot in the cg_marks array
;2305:	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
ADDRGP4 cgs+148752+364
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
CNSTF4 1103101952
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2308
;2306:		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
;2307:
;2308:	return qtrue;
CNSTI4 1
RETI4
LABELV $1094
endproc CG_PlayerShadow 100 44
proc CG_PlayerSplash 188 28
line 2319
;2309:}
;2310:
;2311:
;2312:/*
;2313:===============
;2314:CG_PlayerSplash
;2315:
;2316:Draw a mark at the water surface
;2317:===============
;2318:*/
;2319:static void CG_PlayerSplash( const centity_t *cent ) {
line 2325
;2320:	vec3_t		start, end;
;2321:	trace_t		trace;
;2322:	int			contents;
;2323:	polyVert_t	verts[4];
;2324:
;2325:	if ( !cg_shadows.integer ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1120
line 2326
;2326:		return;
ADDRGP4 $1119
JUMPV
LABELV $1120
line 2329
;2327:	}
;2328:
;2329:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2330
;2330:	end[2] -= 24;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 2334
;2331:
;2332:	// if the feet aren't in liquid, don't make a mark
;2333:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2334:	contents = CG_PointContents( end, 0 );
ADDRLP4 164
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 180
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 180
INDIRI4
ASGNI4
line 2335
;2335:	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1124
line 2336
;2336:		return;
ADDRGP4 $1119
JUMPV
LABELV $1124
line 2339
;2337:	}
;2338:
;2339:	VectorCopy( cent->lerpOrigin, start );
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2340
;2340:	start[2] += 32;
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2343
;2341:
;2342:	// if the head isn't out of liquid, don't make a mark
;2343:	contents = CG_PointContents( start, 0 );
ADDRLP4 152
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 184
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ASGNI4
line 2344
;2344:	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 57
BANDI4
CNSTI4 0
EQI4 $1127
line 2345
;2345:		return;
ADDRGP4 $1119
JUMPV
LABELV $1127
line 2349
;2346:	}
;2347:
;2348:	// trace down to find the surface
;2349:	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );
ADDRLP4 96
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 164
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2351
;2350:
;2351:	if ( trace.fraction == 1.0 ) {
ADDRLP4 96+8
INDIRF4
CNSTF4 1065353216
NEF4 $1129
line 2352
;2352:		return;
ADDRGP4 $1119
JUMPV
LABELV $1129
line 2356
;2353:	}
;2354:
;2355:	// create a mark polygon
;2356:	VectorCopy( trace.endpos, verts[0].xyz );
ADDRLP4 0
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2357
;2357:	verts[0].xyz[0] -= 32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2358
;2358:	verts[0].xyz[1] -= 32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2359
;2359:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2360
;2360:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2361
;2361:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2362
;2362:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2363
;2363:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2364
;2364:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2366
;2365:
;2366:	VectorCopy( trace.endpos, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2367
;2367:	verts[1].xyz[0] -= 32;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2368
;2368:	verts[1].xyz[1] += 32;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2369
;2369:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2370
;2370:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2371
;2371:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2372
;2372:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2373
;2373:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2374
;2374:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2376
;2375:
;2376:	VectorCopy( trace.endpos, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2377
;2377:	verts[2].xyz[0] += 32;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2378
;2378:	verts[2].xyz[1] += 32;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2379
;2379:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2380
;2380:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2381
;2381:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2382
;2382:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2383
;2383:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2384
;2384:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2386
;2385:
;2386:	VectorCopy( trace.endpos, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2387
;2387:	verts[3].xyz[0] += 32;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2388
;2388:	verts[3].xyz[1] -= 32;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2389
;2389:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2390
;2390:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2391
;2391:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2392
;2392:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2393
;2393:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2394
;2394:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2396
;2395:
;2396:	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
ADDRGP4 cgs+148752+388
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2397
;2397:}
LABELV $1119
endproc CG_PlayerSplash 188 28
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 0 4
line 2408
;2398:
;2399:
;2400:/*
;2401:===============
;2402:CG_AddRefEntityWithPowerups
;2403:
;2404:Adds a piece with modifications or duplications for powerups
;2405:Also called by CG_Missile for quad rockets, but nobody can tell...
;2406:===============
;2407:*/
;2408:void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
line 2410
;2409:
;2410:	if ( state->powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1210
line 2411
;2411:		ent->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148752+424
INDIRI4
ASGNI4
line 2412
;2412:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2413
;2413:	} else {
ADDRGP4 $1211
JUMPV
LABELV $1210
line 2423
;2414:		/*
;2415:		if ( state->eFlags & EF_KAMIKAZE ) {
;2416:			if (team == TEAM_BLUE)
;2417:				ent->customShader = cgs.media.blueKamikazeShader;
;2418:			else
;2419:				ent->customShader = cgs.media.redKamikazeShader;
;2420:			trap_R_AddRefEntityToScene( ent );
;2421:		}
;2422:		else {*/
;2423:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2426
;2424:		//}
;2425:
;2426:		if ( state->powerups & ( 1 << PW_QUAD ) )
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1214
line 2427
;2427:		{
line 2428
;2428:			if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1216
line 2429
;2429:				ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148752+416
INDIRI4
ASGNI4
ADDRGP4 $1217
JUMPV
LABELV $1216
line 2431
;2430:			else
;2431:				ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148752+412
INDIRI4
ASGNI4
LABELV $1217
line 2432
;2432:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2433
;2433:		}
LABELV $1214
line 2434
;2434:		if ( state->powerups & ( 1 << PW_REGEN ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1222
line 2435
;2435:			if ( ( ( cg.time / 100 ) % 10 ) == 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1224
line 2436
;2436:				ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148752+428
INDIRI4
ASGNI4
line 2437
;2437:				trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2438
;2438:			}
LABELV $1224
line 2439
;2439:		}
LABELV $1222
line 2440
;2440:		if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1229
line 2441
;2441:			ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148752+432
INDIRI4
ASGNI4
line 2442
;2442:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2443
;2443:		}
LABELV $1229
line 2444
;2444:	}
LABELV $1211
line 2445
;2445:}
LABELV $1209
endproc CG_AddRefEntityWithPowerups 0 4
export CG_LightVerts
proc CG_LightVerts 88 16
line 2454
;2446:
;2447:
;2448:/*
;2449:=================
;2450:CG_LightVerts
;2451:=================
;2452:*/
;2453:int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
;2454:{
line 2461
;2455:	int				i, j;
;2456:	float			incoming;
;2457:	vec3_t			ambientLight;
;2458:	vec3_t			lightDir;
;2459:	vec3_t			directedLight;
;2460:
;2461:	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 2463
;2462:
;2463:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1237
JUMPV
LABELV $1234
line 2464
;2464:		incoming = DotProduct (normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2465
;2465:		if ( incoming <= 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1240
line 2466
;2466:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1243
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1244
JUMPV
LABELV $1243
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1244
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 2467
;2467:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1247
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1248
JUMPV
LABELV $1247
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1248
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 2468
;2468:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1251
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1252
JUMPV
LABELV $1251
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1252
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 2469
;2469:			verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2470
;2470:			continue;
ADDRGP4 $1235
JUMPV
LABELV $1240
line 2472
;2471:		} 
;2472:		j = ( ambientLight[0] + incoming * directedLight[0] );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2473
;2473:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1253
line 2474
;2474:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2475
;2475:		}
LABELV $1253
line 2476
;2476:		verts[i].modulate[0] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2478
;2477:
;2478:		j = ( ambientLight[1] + incoming * directedLight[1] );
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2479
;2479:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1257
line 2480
;2480:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2481
;2481:		}
LABELV $1257
line 2482
;2482:		verts[i].modulate[1] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2484
;2483:
;2484:		j = ( ambientLight[2] + incoming * directedLight[2] );
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2485
;2485:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1261
line 2486
;2486:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2487
;2487:		}
LABELV $1261
line 2488
;2488:		verts[i].modulate[2] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2490
;2489:
;2490:		verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2491
;2491:	}
LABELV $1235
line 2463
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1237
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1234
line 2492
;2492:	return qtrue;
CNSTI4 1
RETI4
LABELV $1233
endproc CG_LightVerts 88 16
export CG_Player
proc CG_Player 484 28
line 2501
;2493:}
;2494:
;2495:
;2496:/*
;2497:===============
;2498:CG_Player
;2499:===============
;2500:*/
;2501:void CG_Player( centity_t *cent ) {
line 2523
;2502:	clientInfo_t	*ci;
;2503:	refEntity_t		legs;
;2504:	refEntity_t		torso;
;2505:	refEntity_t		head;
;2506:	int				clientNum;
;2507:	int				renderfx;
;2508:	qboolean		shadow;
;2509:	float			shadowPlane;
;2510:#ifdef MISSIONPACK
;2511:	refEntity_t		skull;
;2512:	refEntity_t		powerup;
;2513:	int				t;
;2514:	float			c;
;2515:	float			angle;
;2516:	vec3_t			dir, angles;
;2517:#endif
;2518:	qboolean		darken;
;2519:
;2520:	// the client number is stored in clientNum.  It can't be derived
;2521:	// from the entity number, because a single client may have
;2522:	// multiple corpses on the level using the same clientinfo
;2523:	clientNum = cent->currentState.clientNum;
ADDRLP4 436
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 2524
;2524:	if ( (unsigned) clientNum >= MAX_CLIENTS ) {
ADDRLP4 436
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1264
line 2525
;2525:		CG_Error( "Bad clientNum on player entity" );
ADDRGP4 $1266
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2526
;2526:	}
LABELV $1264
line 2527
;2527:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 280
ADDRLP4 436
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2531
;2528:
;2529:	// it is possible to see corpses from disconnected players that may
;2530:	// not have valid clientinfo
;2531:	if ( !ci->infoValid ) {
ADDRLP4 280
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1268
line 2532
;2532:		return;
ADDRGP4 $1263
JUMPV
LABELV $1268
line 2536
;2533:	}
;2534:
;2535:	// get the player model information
;2536:	renderfx = 0;
ADDRLP4 424
CNSTI4 0
ASGNI4
line 2537
;2537:	if ( cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1270
line 2538
;2538:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1273
line 2539
;2539:			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
ADDRLP4 424
CNSTI4 2
ASGNI4
line 2540
;2540:		} else {
ADDRGP4 $1274
JUMPV
LABELV $1273
line 2541
;2541:			if (cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
EQI4 $1276
line 2542
;2542:				return;
ADDRGP4 $1263
JUMPV
LABELV $1276
line 2544
;2543:			}
;2544:		}
LABELV $1274
line 2545
;2545:	}
LABELV $1270
line 2547
;2546:
;2547:	if ( cg_deadBodyDarken.integer && cent->currentState.eFlags & EF_DEAD )
ADDRGP4 cg_deadBodyDarken+12
INDIRI4
CNSTI4 0
EQI4 $1279
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1279
line 2548
;2548:		darken = qtrue;
ADDRLP4 432
CNSTI4 1
ASGNI4
ADDRGP4 $1280
JUMPV
LABELV $1279
line 2550
;2549:	else
;2550:		darken = qfalse;
ADDRLP4 432
CNSTI4 0
ASGNI4
LABELV $1280
line 2552
;2551:
;2552:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2553
;2553:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2554
;2554:	memset( &head, 0, sizeof(head) );
ADDRLP4 284
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2557
;2555:
;2556:	// get the rotation information
;2557:	CG_PlayerAngles( cent, legs.axis, torso.axis, head.axis );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 140+28
ARGP4
ADDRLP4 284+28
ARGP4
ADDRGP4 CG_PlayerAngles
CALLV
pop
line 2560
;2558:
;2559:	// get the animation state (after rotation, to allow feet shuffle)
;2560:	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+96
ARGP4
ADDRLP4 0+80
ARGP4
ADDRLP4 0+100
ARGP4
ADDRLP4 140+96
ARGP4
ADDRLP4 140+80
ARGP4
ADDRLP4 140+100
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 2564
;2561:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;2562:
;2563:	// add the talk baloon or disconnect icon
;2564:	CG_PlayerSprites( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSprites
CALLV
pop
line 2567
;2565:
;2566:	// add the shadow
;2567:	shadow = CG_PlayerShadow( cent, &shadowPlane );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 428
ARGP4
ADDRLP4 444
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 440
ADDRLP4 444
INDIRI4
ASGNI4
line 2570
;2568:
;2569:	// add a water splash if partially in and out of water
;2570:	CG_PlayerSplash( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 2572
;2571:
;2572:	if ( cg_shadows.integer == 3 && shadow ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $1291
ADDRLP4 440
INDIRI4
CNSTI4 0
EQI4 $1291
line 2573
;2573:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 424
ADDRLP4 424
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2574
;2574:	}
LABELV $1291
line 2575
;2575:	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
ADDRLP4 424
ADDRLP4 424
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2584
;2576:#ifdef MISSIONPACK
;2577:	if( cgs.gametype == GT_HARVESTER ) {
;2578:		CG_PlayerTokens( cent, renderfx );
;2579:	}
;2580:#endif
;2581:	//
;2582:	// add the legs
;2583:	//
;2584:	legs.hModel = ci->legsModel;
ADDRLP4 0+8
ADDRLP4 280
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 2585
;2585:	legs.customSkin = ci->legsSkin;
ADDRLP4 0+108
ADDRLP4 280
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 2587
;2586:
;2587:	VectorCopy( cent->lerpOrigin, legs.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2589
;2588:
;2589:	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2590
;2590:	legs.shadowPlane = shadowPlane;
ADDRLP4 0+24
ADDRLP4 428
INDIRF4
ASGNF4
line 2591
;2591:	legs.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2592
;2592:	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all
ADDRLP4 0+84
ADDRLP4 0+68
INDIRB
ASGNB 12
line 2595
;2593:
;2594:	// colored skin
;2595:	if ( darken ) {
ADDRLP4 432
INDIRI4
CNSTI4 0
EQI4 $1302
line 2596
;2596:		legs.shaderRGBA[0] = 85;
ADDRLP4 0+116
CNSTU1 85
ASGNU1
line 2597
;2597:		legs.shaderRGBA[1] = 85;
ADDRLP4 0+116+1
CNSTU1 85
ASGNU1
line 2598
;2598:		legs.shaderRGBA[2] = 85;
ADDRLP4 0+116+2
CNSTU1 85
ASGNU1
line 2599
;2599:	} else {
ADDRGP4 $1303
JUMPV
LABELV $1302
line 2600
;2600:		legs.shaderRGBA[0] = ci->legsColor[0] * 255;
ADDRLP4 452
ADDRLP4 280
INDIRP4
CNSTI4 1640
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 456
CNSTF4 1325400064
ASGNF4
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
LTF4 $1311
ADDRLP4 448
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1312
JUMPV
LABELV $1311
ADDRLP4 448
ADDRLP4 452
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1312
ADDRLP4 0+116
ADDRLP4 448
INDIRU4
CVUU1 4
ASGNU1
line 2601
;2601:		legs.shaderRGBA[1] = ci->legsColor[1] * 255;
ADDRLP4 464
ADDRLP4 280
INDIRP4
CNSTI4 1644
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 468
CNSTF4 1325400064
ASGNF4
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
LTF4 $1316
ADDRLP4 460
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1317
JUMPV
LABELV $1316
ADDRLP4 460
ADDRLP4 464
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1317
ADDRLP4 0+116+1
ADDRLP4 460
INDIRU4
CVUU1 4
ASGNU1
line 2602
;2602:		legs.shaderRGBA[2] = ci->legsColor[2] * 255;
ADDRLP4 476
ADDRLP4 280
INDIRP4
CNSTI4 1648
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 480
CNSTF4 1325400064
ASGNF4
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
LTF4 $1321
ADDRLP4 472
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1322
JUMPV
LABELV $1321
ADDRLP4 472
ADDRLP4 476
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1322
ADDRLP4 0+116+2
ADDRLP4 472
INDIRU4
CVUU1 4
ASGNU1
line 2603
;2603:	}
LABELV $1303
line 2604
;2604:	legs.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2606
;2605:
;2606:	CG_AddRefEntityWithPowerups( &legs, &cent->currentState, ci->team );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2609
;2607:
;2608:	// if the model failed, allow the default nullmodel to be displayed
;2609:	if (!legs.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1325
line 2610
;2610:		return;
ADDRGP4 $1263
JUMPV
LABELV $1325
line 2616
;2611:	}
;2612:
;2613:	//
;2614:	// add the torso
;2615:	//
;2616:	torso.hModel = ci->torsoModel;
ADDRLP4 140+8
ADDRLP4 280
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 2617
;2617:	if (!torso.hModel) {
ADDRLP4 140+8
INDIRI4
CNSTI4 0
NEI4 $1329
line 2618
;2618:		return;
ADDRGP4 $1263
JUMPV
LABELV $1329
line 2621
;2619:	}
;2620:
;2621:	torso.customSkin = ci->torsoSkin;
ADDRLP4 140+108
ADDRLP4 280
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
ASGNI4
line 2623
;2622:
;2623:	VectorCopy( cent->lerpOrigin, torso.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2625
;2624:
;2625:	CG_PositionRotatedEntityOnTag( &torso, &legs, ci->legsModel, "tag_torso");
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1334
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2627
;2626:
;2627:	torso.shadowPlane = shadowPlane;
ADDRLP4 140+24
ADDRLP4 428
INDIRF4
ASGNF4
line 2628
;2628:	torso.renderfx = renderfx;
ADDRLP4 140+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2631
;2629:
;2630:	// colored skin
;2631:	if ( darken ) {
ADDRLP4 432
INDIRI4
CNSTI4 0
EQI4 $1337
line 2632
;2632:		torso.shaderRGBA[0] = 85;
ADDRLP4 140+116
CNSTU1 85
ASGNU1
line 2633
;2633:		torso.shaderRGBA[1] = 85;
ADDRLP4 140+116+1
CNSTU1 85
ASGNU1
line 2634
;2634:		torso.shaderRGBA[2] = 85;
ADDRLP4 140+116+2
CNSTU1 85
ASGNU1
line 2635
;2635:	} else {
ADDRGP4 $1338
JUMPV
LABELV $1337
line 2636
;2636:		torso.shaderRGBA[0] = ci->bodyColor[0] * 255;
ADDRLP4 452
ADDRLP4 280
INDIRP4
CNSTI4 1628
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 456
CNSTF4 1325400064
ASGNF4
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
LTF4 $1346
ADDRLP4 448
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1347
JUMPV
LABELV $1346
ADDRLP4 448
ADDRLP4 452
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1347
ADDRLP4 140+116
ADDRLP4 448
INDIRU4
CVUU1 4
ASGNU1
line 2637
;2637:		torso.shaderRGBA[1] = ci->bodyColor[1] * 255;
ADDRLP4 464
ADDRLP4 280
INDIRP4
CNSTI4 1632
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 468
CNSTF4 1325400064
ASGNF4
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
LTF4 $1351
ADDRLP4 460
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1352
JUMPV
LABELV $1351
ADDRLP4 460
ADDRLP4 464
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1352
ADDRLP4 140+116+1
ADDRLP4 460
INDIRU4
CVUU1 4
ASGNU1
line 2638
;2638:		torso.shaderRGBA[2] = ci->bodyColor[2] * 255;
ADDRLP4 476
ADDRLP4 280
INDIRP4
CNSTI4 1636
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 480
CNSTF4 1325400064
ASGNF4
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
LTF4 $1356
ADDRLP4 472
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1357
JUMPV
LABELV $1356
ADDRLP4 472
ADDRLP4 476
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1357
ADDRLP4 140+116+2
ADDRLP4 472
INDIRU4
CVUU1 4
ASGNU1
line 2639
;2639:	}
LABELV $1338
line 2640
;2640:	torso.shaderRGBA[3] = 255;
ADDRLP4 140+116+3
CNSTU1 255
ASGNU1
line 2642
;2641:
;2642:	CG_AddRefEntityWithPowerups( &torso, &cent->currentState, ci->team );
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2851
;2643:
;2644:#ifdef MISSIONPACK
;2645:	if ( cent->currentState.eFlags & EF_KAMIKAZE ) {
;2646:
;2647:		memset( &skull, 0, sizeof(skull) );
;2648:
;2649:		VectorCopy( cent->lerpOrigin, skull.lightingOrigin );
;2650:		skull.shadowPlane = shadowPlane;
;2651:		skull.renderfx = renderfx;
;2652:
;2653:		if ( cent->currentState.eFlags & EF_DEAD ) {
;2654:			// one skull bobbing above the dead body
;2655:			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
;2656:			if (angle > M_PI * 2)
;2657:				angle -= (float)M_PI * 2;
;2658:			dir[0] = sin(angle) * 20;
;2659:			dir[1] = cos(angle) * 20;
;2660:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;2661:			dir[2] = 15 + sin(angle) * 8;
;2662:			VectorAdd(torso.origin, dir, skull.origin);
;2663:
;2664:			dir[2] = 0;
;2665:			VectorCopy(dir, skull.axis[1]);
;2666:			VectorNormalize(skull.axis[1]);
;2667:			VectorSet(skull.axis[2], 0, 0, 1);
;2668:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2669:
;2670:			skull.hModel = cgs.media.kamikazeHeadModel;
;2671:			trap_R_AddRefEntityToScene( &skull );
;2672:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2673:			trap_R_AddRefEntityToScene( &skull );
;2674:		}
;2675:		else {
;2676:			// three skulls spinning around the player
;2677:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;2678:			dir[0] = cos(angle) * 20;
;2679:			dir[1] = sin(angle) * 20;
;2680:			dir[2] = cos(angle) * 20;
;2681:			VectorAdd(torso.origin, dir, skull.origin);
;2682:
;2683:			angles[0] = sin(angle) * 30;
;2684:			angles[1] = (angle * 180 / M_PI) + 90;
;2685:			if (angles[1] > 360)
;2686:				angles[1] -= 360;
;2687:			angles[2] = 0;
;2688:			AnglesToAxis( angles, skull.axis );
;2689:
;2690:			/*
;2691:			dir[2] = 0;
;2692:			VectorInverse(dir);
;2693:			VectorCopy(dir, skull.axis[1]);
;2694:			VectorNormalize(skull.axis[1]);
;2695:			VectorSet(skull.axis[2], 0, 0, 1);
;2696:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2697:			*/
;2698:
;2699:			skull.hModel = cgs.media.kamikazeHeadModel;
;2700:			trap_R_AddRefEntityToScene( &skull );
;2701:			// flip the trail because this skull is spinning in the other direction
;2702:			VectorInverse(skull.axis[1]);
;2703:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2704:			trap_R_AddRefEntityToScene( &skull );
;2705:
;2706:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
;2707:			if (angle > M_PI * 2)
;2708:				angle -= (float)M_PI * 2;
;2709:			dir[0] = sin(angle) * 20;
;2710:			dir[1] = cos(angle) * 20;
;2711:			dir[2] = cos(angle) * 20;
;2712:			VectorAdd(torso.origin, dir, skull.origin);
;2713:
;2714:			angles[0] = cos(angle - 0.5 * M_PI) * 30;
;2715:			angles[1] = 360 - (angle * 180 / M_PI);
;2716:			if (angles[1] > 360)
;2717:				angles[1] -= 360;
;2718:			angles[2] = 0;
;2719:			AnglesToAxis( angles, skull.axis );
;2720:
;2721:			/*
;2722:			dir[2] = 0;
;2723:			VectorCopy(dir, skull.axis[1]);
;2724:			VectorNormalize(skull.axis[1]);
;2725:			VectorSet(skull.axis[2], 0, 0, 1);
;2726:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2727:			*/
;2728:
;2729:			skull.hModel = cgs.media.kamikazeHeadModel;
;2730:			trap_R_AddRefEntityToScene( &skull );
;2731:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2732:			trap_R_AddRefEntityToScene( &skull );
;2733:
;2734:			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
;2735:			if (angle > M_PI * 2)
;2736:				angle -= (float)M_PI * 2;
;2737:			dir[0] = sin(angle) * 20;
;2738:			dir[1] = cos(angle) * 20;
;2739:			dir[2] = 0;
;2740:			VectorAdd(torso.origin, dir, skull.origin);
;2741:
;2742:			VectorCopy(dir, skull.axis[1]);
;2743:			VectorNormalize(skull.axis[1]);
;2744:			VectorSet(skull.axis[2], 0, 0, 1);
;2745:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2746:
;2747:			skull.hModel = cgs.media.kamikazeHeadModel;
;2748:			trap_R_AddRefEntityToScene( &skull );
;2749:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2750:			trap_R_AddRefEntityToScene( &skull );
;2751:		}
;2752:	}
;2753:
;2754:	if ( cent->currentState.powerups & ( 1 << PW_GUARD ) ) {
;2755:		memcpy(&powerup, &torso, sizeof(torso));
;2756:		powerup.hModel = cgs.media.guardPowerupModel;
;2757:		powerup.frame = 0;
;2758:		powerup.oldframe = 0;
;2759:		powerup.customSkin = 0;
;2760:		trap_R_AddRefEntityToScene( &powerup );
;2761:	}
;2762:	if ( cent->currentState.powerups & ( 1 << PW_SCOUT ) ) {
;2763:		memcpy(&powerup, &torso, sizeof(torso));
;2764:		powerup.hModel = cgs.media.scoutPowerupModel;
;2765:		powerup.frame = 0;
;2766:		powerup.oldframe = 0;
;2767:		powerup.customSkin = 0;
;2768:		trap_R_AddRefEntityToScene( &powerup );
;2769:	}
;2770:	if ( cent->currentState.powerups & ( 1 << PW_DOUBLER ) ) {
;2771:		memcpy(&powerup, &torso, sizeof(torso));
;2772:		powerup.hModel = cgs.media.doublerPowerupModel;
;2773:		powerup.frame = 0;
;2774:		powerup.oldframe = 0;
;2775:		powerup.customSkin = 0;
;2776:		trap_R_AddRefEntityToScene( &powerup );
;2777:	}
;2778:	if ( cent->currentState.powerups & ( 1 << PW_AMMOREGEN ) ) {
;2779:		memcpy(&powerup, &torso, sizeof(torso));
;2780:		powerup.hModel = cgs.media.ammoRegenPowerupModel;
;2781:		powerup.frame = 0;
;2782:		powerup.oldframe = 0;
;2783:		powerup.customSkin = 0;
;2784:		trap_R_AddRefEntityToScene( &powerup );
;2785:	}
;2786:	if ( cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) {
;2787:		if ( !ci->invulnerabilityStartTime ) {
;2788:			ci->invulnerabilityStartTime = cg.time;
;2789:		}
;2790:		ci->invulnerabilityStopTime = cg.time;
;2791:	}
;2792:	else {
;2793:		ci->invulnerabilityStartTime = 0;
;2794:	}
;2795:	if ( (cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) ||
;2796:		cg.time - ci->invulnerabilityStopTime < 250 ) {
;2797:
;2798:		memcpy(&powerup, &torso, sizeof(torso));
;2799:		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
;2800:		powerup.customSkin = 0;
;2801:		// always draw
;2802:		powerup.renderfx &= ~RF_THIRD_PERSON;
;2803:		VectorCopy(cent->lerpOrigin, powerup.origin);
;2804:
;2805:		if ( cg.time - ci->invulnerabilityStartTime < 250 ) {
;2806:			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
;2807:		}
;2808:		else if (cg.time - ci->invulnerabilityStopTime < 250 ) {
;2809:			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
;2810:		}
;2811:		else {
;2812:			c = 1;
;2813:		}
;2814:		VectorSet( powerup.axis[0], c, 0, 0 );
;2815:		VectorSet( powerup.axis[1], 0, c, 0 );
;2816:		VectorSet( powerup.axis[2], 0, 0, c );
;2817:		trap_R_AddRefEntityToScene( &powerup );
;2818:	}
;2819:
;2820:	t = cg.time - ci->medkitUsageTime;
;2821:	if ( ci->medkitUsageTime && t < 500 ) {
;2822:		memcpy(&powerup, &torso, sizeof(torso));
;2823:		powerup.hModel = cgs.media.medkitUsageModel;
;2824:		powerup.customSkin = 0;
;2825:		// always draw
;2826:		powerup.renderfx &= ~RF_THIRD_PERSON;
;2827:		VectorClear(angles);
;2828:		AnglesToAxis(angles, powerup.axis);
;2829:		VectorCopy(cent->lerpOrigin, powerup.origin);
;2830:		powerup.origin[2] += -24 + (float) t * 80 / 500;
;2831:		if ( t > 400 ) {
;2832:			c = (float) (t - 1000) * 0xff / 100;
;2833:			powerup.shaderRGBA[0] = 0xff - c;
;2834:			powerup.shaderRGBA[1] = 0xff - c;
;2835:			powerup.shaderRGBA[2] = 0xff - c;
;2836:			powerup.shaderRGBA[3] = 0xff - c;
;2837:		}
;2838:		else {
;2839:			powerup.shaderRGBA[0] = 0xff;
;2840:			powerup.shaderRGBA[1] = 0xff;
;2841:			powerup.shaderRGBA[2] = 0xff;
;2842:			powerup.shaderRGBA[3] = 0xff;
;2843:		}
;2844:		trap_R_AddRefEntityToScene( &powerup );
;2845:	}
;2846:#endif // MISSIONPACK
;2847:
;2848:	//
;2849:	// add the head
;2850:	//
;2851:	head.hModel = ci->headModel;
ADDRLP4 284+8
ADDRLP4 280
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 2852
;2852:	if (!head.hModel) {
ADDRLP4 284+8
INDIRI4
CNSTI4 0
NEI4 $1361
line 2853
;2853:		return;
ADDRGP4 $1263
JUMPV
LABELV $1361
line 2855
;2854:	}
;2855:	head.customSkin = ci->headSkin;
ADDRLP4 284+108
ADDRLP4 280
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 2857
;2856:
;2857:	VectorCopy( cent->lerpOrigin, head.lightingOrigin );
ADDRLP4 284+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2859
;2858:
;2859:	CG_PositionRotatedEntityOnTag( &head, &torso, ci->torsoModel, "tag_head");
ADDRLP4 284
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2861
;2860:
;2861:	head.shadowPlane = shadowPlane;
ADDRLP4 284+24
ADDRLP4 428
INDIRF4
ASGNF4
line 2862
;2862:	head.renderfx = renderfx;
ADDRLP4 284+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2865
;2863:
;2864:	// colored skin
;2865:	if ( darken ) {
ADDRLP4 432
INDIRI4
CNSTI4 0
EQI4 $1369
line 2866
;2866:		head.shaderRGBA[0] = 85;
ADDRLP4 284+116
CNSTU1 85
ASGNU1
line 2867
;2867:		head.shaderRGBA[1] = 85;
ADDRLP4 284+116+1
CNSTU1 85
ASGNU1
line 2868
;2868:		head.shaderRGBA[2] = 85;
ADDRLP4 284+116+2
CNSTU1 85
ASGNU1
line 2869
;2869:	} else {
ADDRGP4 $1370
JUMPV
LABELV $1369
line 2870
;2870:		head.shaderRGBA[0] = ci->headColor[0] * 255;
ADDRLP4 452
ADDRLP4 280
INDIRP4
CNSTI4 1616
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 456
CNSTF4 1325400064
ASGNF4
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
LTF4 $1378
ADDRLP4 448
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1379
JUMPV
LABELV $1378
ADDRLP4 448
ADDRLP4 452
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1379
ADDRLP4 284+116
ADDRLP4 448
INDIRU4
CVUU1 4
ASGNU1
line 2871
;2871:		head.shaderRGBA[1] = ci->headColor[1] * 255;
ADDRLP4 464
ADDRLP4 280
INDIRP4
CNSTI4 1620
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 468
CNSTF4 1325400064
ASGNF4
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
LTF4 $1383
ADDRLP4 460
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1384
JUMPV
LABELV $1383
ADDRLP4 460
ADDRLP4 464
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1384
ADDRLP4 284+116+1
ADDRLP4 460
INDIRU4
CVUU1 4
ASGNU1
line 2872
;2872:		head.shaderRGBA[2] = ci->headColor[2] * 255;
ADDRLP4 476
ADDRLP4 280
INDIRP4
CNSTI4 1624
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 480
CNSTF4 1325400064
ASGNF4
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
LTF4 $1388
ADDRLP4 472
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1389
JUMPV
LABELV $1388
ADDRLP4 472
ADDRLP4 476
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1389
ADDRLP4 284+116+2
ADDRLP4 472
INDIRU4
CVUU1 4
ASGNU1
line 2873
;2873:	}
LABELV $1370
line 2874
;2874:	head.shaderRGBA[3] = 255;
ADDRLP4 284+116+3
CNSTU1 255
ASGNU1
line 2876
;2875:
;2876:	CG_AddRefEntityWithPowerups( &head, &cent->currentState, ci->team );
ADDRLP4 284
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2887
;2877:
;2878:#ifdef MISSIONPACK
;2879:	CG_BreathPuffs(cent, &head);
;2880:
;2881:	CG_DustTrail(cent);
;2882:#endif
;2883:
;2884:	//
;2885:	// add the gun / barrel / flash
;2886:	//
;2887:	CG_AddPlayerWeapon( &torso, NULL, cent, ci->team );
ADDRLP4 140
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 2890
;2888:
;2889:	// add powerups floating behind the player
;2890:	CG_PlayerPowerups( cent, &torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 2891
;2891:}
LABELV $1263
endproc CG_Player 484 28
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 40 12
line 2903
;2892:
;2893:
;2894://=====================================================================
;2895:
;2896:/*
;2897:===============
;2898:CG_ResetPlayerEntity
;2899:
;2900:A player just came into view or teleported, so reset all animation info
;2901:===============
;2902:*/
;2903:void CG_ResetPlayerEntity( centity_t *cent ) {
line 2904
;2904:	cent->errorTime = -99999;		// guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
CNSTI4 -99999
ASGNI4
line 2905
;2905:	cent->extrapolated = qfalse;	
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTI4 0
ASGNI4
line 2907
;2906:
;2907:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2908
;2908:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2910
;2909:
;2910:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
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
line 2911
;2911:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
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
line 2913
;2912:
;2913:	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2914
;2914:	VectorCopy( cent->lerpAngles, cent->rawAngles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2916
;2915:
;2916:	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2917
;2917:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 696
ADDP4
INDIRF4
ASGNF4
line 2918
;2918:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 2919
;2919:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
CNSTF4 0
ASGNF4
line 2920
;2920:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
CNSTI4 0
ASGNI4
line 2922
;2921:
;2922:	memset( &cent->pe.torso, 0, sizeof( cent->pe.torso ) );
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2923
;2923:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 696
ADDP4
INDIRF4
ASGNF4
line 2924
;2924:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2925
;2925:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
ASGNF4
line 2926
;2926:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 2928
;2927:
;2928:	if ( cg_debugPosition.integer ) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $1397
line 2929
;2929:		CG_Printf("%i ResetPlayerEntity yaw=%f\n", cent->currentState.number, cent->pe.torso.yawAngle );
ADDRGP4 $1400
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 2930
;2930:	}
LABELV $1397
line 2931
;2931:}
LABELV $1392
endproc CG_ResetPlayerEntity 40 12
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
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PlayDroppedEvents
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $1400
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 61
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1366
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1334
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $1266
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $846
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $777
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 32
byte 1 108
byte 1 102
byte 1 45
byte 1 62
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $743
byte 1 65
byte 1 110
byte 1 105
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $739
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $734
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $721
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $698
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $692
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $690
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $672
byte 1 108
byte 1 0
align 1
LABELV $670
byte 1 119
byte 1 0
align 1
LABELV $668
byte 1 104
byte 1 99
byte 1 0
align 1
LABELV $666
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $649
byte 1 99
byte 1 50
byte 1 0
align 1
LABELV $647
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $643
byte 1 116
byte 1 0
align 1
LABELV $640
byte 1 110
byte 1 0
align 1
LABELV $576
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $552
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $520
byte 1 67
byte 1 71
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
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
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 33
byte 1 10
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $442
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $437
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $434
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 47
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $426
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 40
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $420
byte 1 48
byte 1 0
align 1
LABELV $417
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $386
byte 1 120
byte 1 97
byte 1 101
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $385
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $384
byte 1 117
byte 1 114
byte 1 105
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $383
byte 1 116
byte 1 97
byte 1 110
byte 1 107
byte 1 106
byte 1 114
byte 1 0
align 1
LABELV $382
byte 1 115
byte 1 111
byte 1 114
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $381
byte 1 115
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $380
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $379
byte 1 114
byte 1 97
byte 1 122
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $378
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $377
byte 1 111
byte 1 114
byte 1 98
byte 1 98
byte 1 0
align 1
LABELV $376
byte 1 109
byte 1 121
byte 1 110
byte 1 120
byte 1 0
align 1
LABELV $375
byte 1 109
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $374
byte 1 108
byte 1 117
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $373
byte 1 107
byte 1 108
byte 1 101
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $372
byte 1 107
byte 1 101
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $371
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $370
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $369
byte 1 100
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $368
byte 1 99
byte 1 114
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $367
byte 1 98
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $366
byte 1 98
byte 1 105
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $365
byte 1 98
byte 1 105
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $364
byte 1 97
byte 1 110
byte 1 97
byte 1 114
byte 1 107
byte 1 105
byte 1 0
align 1
LABELV $358
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $355
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $352
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $349
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $346
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $345
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $342
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $341
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $340
byte 1 37
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $337
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $327
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $322
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $319
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $318
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $315
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $312
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $304
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $301
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $298
byte 1 84
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $292
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $289
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $288
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $268
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $267
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $243
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $233
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $232
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $224
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $223
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $213
byte 1 0
align 1
LABELV $212
byte 1 112
byte 1 109
byte 1 0
align 1
LABELV $209
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $208
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $194
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
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
LABELV $169
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $163
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $152
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $143
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $140
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $139
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 0
align 1
LABELV $136
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $133
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $130
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $126
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $125
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $120
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
LABELV $112
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $104
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $89
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
LABELV $88
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
LABELV $87
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
LABELV $86
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
LABELV $85
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
LABELV $84
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
LABELV $83
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
LABELV $82
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
LABELV $81
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
LABELV $80
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
LABELV $79
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $77
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
