data
align 4
LABELV gametype_items
address $69
address $70
address $71
address $72
byte 4 0
align 4
LABELV gametype_remap
byte 4 0
byte 4 1
byte 4 3
byte 4 4
align 4
LABELV gametype_remap2
byte 4 0
byte 4 1
byte 4 0
byte 4 2
byte 4 3
code
proc GametypeBits 36 8
file "..\..\..\..\code\q3_ui\ui_startserver.c"
line 94
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=============================================================================
;5:
;6:START SERVER MENU *****
;7:
;8:=============================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define GAMESERVER_BACK0		"menu/art/back_0"
;16:#define GAMESERVER_BACK1		"menu/art/back_1"
;17:#define GAMESERVER_NEXT0		"menu/art/next_0"
;18:#define GAMESERVER_NEXT1		"menu/art/next_1"
;19:#define GAMESERVER_FRAMEL		"menu/art/frame2_l"
;20:#define GAMESERVER_FRAMER		"menu/art/frame1_r"
;21:#define GAMESERVER_SELECT		"menu/art/maps_select"
;22:#define GAMESERVER_SELECTED		"menu/art/maps_selected"
;23:#define GAMESERVER_FIGHT0		"menu/art/fight_0"
;24:#define GAMESERVER_FIGHT1		"menu/art/fight_1"
;25:#define GAMESERVER_UNKNOWNMAP	"menu/art/unknownmap"
;26:#define GAMESERVER_ARROWS		"menu/art/gs_arrows_0"
;27:#define GAMESERVER_ARROWSL		"menu/art/gs_arrows_l"
;28:#define GAMESERVER_ARROWSR		"menu/art/gs_arrows_r"
;29:
;30:#define MAX_MAPROWS		2
;31:#define MAX_MAPCOLS		2
;32:#define MAX_MAPSPERPAGE	4
;33:
;34:#define MAX_NAMELENGTH	16
;35:
;36:#define ID_GAMETYPE				10
;37:#define ID_PICTURES				11	// 12, 13, 14
;38:#define ID_PREVPAGE				15
;39:#define ID_NEXTPAGE				16
;40:#define ID_STARTSERVERBACK		17
;41:#define ID_STARTSERVERNEXT		18
;42:
;43:typedef struct {
;44:	menuframework_s	menu;
;45:
;46:	menutext_s		banner;
;47:	menubitmap_s	framel;
;48:	menubitmap_s	framer;
;49:
;50:	menulist_s		gametype;
;51:	menubitmap_s	mappics[MAX_MAPSPERPAGE];
;52:	menubitmap_s	mapbuttons[MAX_MAPSPERPAGE];
;53:	menubitmap_s	arrows;
;54:	menubitmap_s	prevpage;
;55:	menubitmap_s	nextpage;
;56:	menubitmap_s	back;
;57:	menubitmap_s	next;
;58:
;59:	menutext_s		mapname;
;60:	menubitmap_s	item_null;
;61:
;62:	qboolean		multiplayer;
;63:	int				currentmap;
;64:	int				nummaps;
;65:	int				page;
;66:	int				maxpages;
;67:	int 			maplist[MAX_ARENAS];
;68:} startserver_t;
;69:
;70:static startserver_t s_startserver;
;71:
;72:static const char *gametype_items[] = {
;73:	"Free For All",
;74:	"Tournament",
;75:	"Team Deathmatch",
;76:	"Capture the Flag",
;77:	NULL
;78:};
;79:
;80:static int gametype_remap[] = { GT_FFA, GT_TOURNAMENT, GT_TEAM, GT_CTF };
;81:static int gametype_remap2[] = { 0, 1, 0, 2, 3 };
;82:
;83:// use ui_servers2.c definition
;84:extern const char* punkbuster_items[];
;85:
;86:static void UI_ServerOptionsMenu( qboolean multiplayer );
;87:
;88:
;89:/*
;90:=================
;91:GametypeBits
;92:=================
;93:*/
;94:static int GametypeBits( char *string ) {
line 99
;95:	int		bits;
;96:	char	*p;
;97:	char	*token;
;98:
;99:	bits = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 100
;100:	p = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $75
JUMPV
LABELV $74
line 101
;101:	while( 1 ) {
line 102
;102:		token = COM_ParseExt( &p, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 103
;103:		if( token[0] == 0 ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $77
line 104
;104:			break;
ADDRGP4 $76
JUMPV
LABELV $77
line 107
;105:		}
;106:
;107:		if( Q_stricmp( token, "ffa" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $81
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $79
line 108
;108:			bits |= 1 << GT_FFA;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 109
;109:			continue;
ADDRGP4 $75
JUMPV
LABELV $79
line 112
;110:		}
;111:
;112:		if( Q_stricmp( token, "tourney" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $84
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $82
line 113
;113:			bits |= 1 << GT_TOURNAMENT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 114
;114:			continue;
ADDRGP4 $75
JUMPV
LABELV $82
line 117
;115:		}
;116:
;117:		if( Q_stricmp( token, "single" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $87
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $85
line 118
;118:			bits |= 1 << GT_SINGLE_PLAYER;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 119
;119:			continue;
ADDRGP4 $75
JUMPV
LABELV $85
line 122
;120:		}
;121:
;122:		if( Q_stricmp( token, "team" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $90
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $88
line 123
;123:			bits |= 1 << GT_TEAM;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 124
;124:			continue;
ADDRGP4 $75
JUMPV
LABELV $88
line 127
;125:		}
;126:
;127:		if( Q_stricmp( token, "ctf" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $93
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $91
line 128
;128:			bits |= 1 << GT_CTF;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 129
;129:			continue;
LABELV $91
line 131
;130:		}
;131:	}
LABELV $75
line 101
ADDRGP4 $74
JUMPV
LABELV $76
line 133
;132:
;133:	return bits;
ADDRLP4 4
INDIRI4
RETI4
LABELV $73
endproc GametypeBits 36 8
bss
align 1
LABELV $95
skip 256
code
proc StartServer_Update 52 16
line 142
;134:}
;135:
;136:
;137:/*
;138:=================
;139:StartServer_Update
;140:=================
;141:*/
;142:static void StartServer_Update( void ) {
line 149
;143:	int				i;
;144:	int				top;
;145:	static	char	picname[MAX_MAPSPERPAGE][MAX_QPATH];
;146:	const char		*info;
;147:	char			mapname[MAX_NAMELENGTH];
;148:
;149:	top = s_startserver.page*MAX_MAPSPERPAGE;
ADDRLP4 20
ADDRGP4 s_startserver+2032
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
line 151
;150:
;151:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $97
line 152
;152:	{
line 153
;153:		if (top+i >= s_startserver.nummaps)
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ADDRGP4 s_startserver+2028
INDIRI4
LTI4 $101
line 154
;154:			break;
ADDRGP4 $120
JUMPV
LABELV $101
line 156
;155:
;156:		info = UI_GetArenaInfoByNumber( s_startserver.maplist[ top + i ]);
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
ASGNP4
line 157
;157:		Q_strncpyz( mapname, Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 158
;158:		Q_strupr( mapname );
ADDRLP4 4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 160
;159:
;160:		Com_sprintf( picname[i], sizeof(picname[i]), "levelshots/%s", mapname );
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 $95
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 162
;161:
;162:		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+44
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 163
;163:		s_startserver.mappics[i].generic.name   = picname[i];
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 $95
ADDP4
ASGNP4
line 164
;164:		s_startserver.mappics[i].shader         = 0;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+72
ADDP4
CNSTI4 0
ASGNI4
line 167
;165:
;166:		// reset
;167:		s_startserver.mapbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 168
;168:		s_startserver.mapbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 169
;169:	}
LABELV $98
line 151
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $97
line 171
;170:
;171:	for (; i<MAX_MAPSPERPAGE; i++)
ADDRGP4 $120
JUMPV
LABELV $117
line 172
;172:	{
line 173
;173:		s_startserver.mappics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+44
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 174
;174:		s_startserver.mappics[i].generic.name   = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+4
ADDP4
CNSTP4 0
ASGNP4
line 175
;175:		s_startserver.mappics[i].shader         = 0;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+72
ADDP4
CNSTI4 0
ASGNI4
line 178
;176:
;177:		// disable
;178:		s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 179
;179:		s_startserver.mapbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 180
;180:	}
LABELV $118
line 171
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $120
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $117
line 184
;181:
;182:
;183:	// no servers to start
;184:	if( !s_startserver.nummaps ) {
ADDRGP4 s_startserver+2028
INDIRI4
CNSTI4 0
NEI4 $131
line 185
;185:		s_startserver.next.generic.flags |= QMF_INACTIVE;
ADDRLP4 28
ADDRGP4 s_startserver+1760+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 188
;186:
;187:		// set the map name
;188:		strcpy( s_startserver.mapname.string, "NO MAPS FOUND" );
ADDRGP4 s_startserver+1852+64
INDIRP4
ARGP4
ADDRGP4 $138
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 189
;189:	}
ADDRGP4 $132
JUMPV
LABELV $131
line 190
;190:	else {
line 192
;191:		// set the highlight
;192:		s_startserver.next.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 28
ADDRGP4 s_startserver+1760+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 193
;193:		i = s_startserver.currentmap - top;
ADDRLP4 0
ADDRGP4 s_startserver+2024
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 194
;194:		if ( i >=0 && i < MAX_MAPSPERPAGE ) 
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $142
ADDRLP4 0
INDIRI4
CNSTI4 4
GEI4 $142
line 195
;195:		{
line 196
;196:			s_startserver.mappics[i].generic.flags    |= QMF_HIGHLIGHT;
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+44
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 197
;197:			s_startserver.mapbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 198
;198:		}
LABELV $142
line 201
;199:
;200:		// set the map name
;201:		info = UI_GetArenaInfoByNumber( s_startserver.maplist[ s_startserver.currentmap ]);
ADDRGP4 s_startserver+2024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 36
INDIRP4
ASGNP4
line 202
;202:		Q_strncpyz( s_startserver.mapname.string, Info_ValueForKey( info, "map" ), MAX_NAMELENGTH);
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 s_startserver+1852+64
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 203
;203:	}
LABELV $132
line 205
;204:	
;205:	Q_strupr( s_startserver.mapname.string );
ADDRGP4 s_startserver+1852+64
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 206
;206:}
LABELV $94
endproc StartServer_Update 52 16
proc StartServer_MapEvent 0 0
line 214
;207:
;208:
;209:/*
;210:=================
;211:StartServer_MapEvent
;212:=================
;213:*/
;214:static void StartServer_MapEvent( void* ptr, int event ) {
line 215
;215:	if( event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $155
line 216
;216:		return;
ADDRGP4 $154
JUMPV
LABELV $155
line 219
;217:	}
;218:
;219:	s_startserver.currentmap = (s_startserver.page*MAX_MAPSPERPAGE) + (((menucommon_s*)ptr)->id - ID_PICTURES);
ADDRGP4 s_startserver+2024
ADDRGP4 s_startserver+2032
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 11
SUBI4
ADDI4
ASGNI4
line 220
;220:	StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 221
;221:}
LABELV $154
endproc StartServer_MapEvent 0 0
proc StartServer_GametypeEvent 40 8
line 229
;222:
;223:
;224:/*
;225:=================
;226:StartServer_GametypeEvent
;227:=================
;228:*/
;229:static void StartServer_GametypeEvent( void* ptr, int event ) {
line 236
;230:	int			i;
;231:	int			count;
;232:	int			gamebits;
;233:	int			matchbits;
;234:	const char	*info;
;235:
;236:	if( event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $160
line 237
;237:		return;
ADDRGP4 $159
JUMPV
LABELV $160
line 240
;238:	}
;239:
;240:	count = UI_GetNumArenas();
ADDRLP4 20
ADDRGP4 UI_GetNumArenas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 241
;241:	s_startserver.nummaps = 0;
ADDRGP4 s_startserver+2028
CNSTI4 0
ASGNI4
line 242
;242:	matchbits = 1 << gametype_remap[s_startserver.gametype.curvalue];
ADDRLP4 12
CNSTI4 1
ADDRGP4 s_startserver+548+68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_remap
ADDP4
INDIRI4
LSHI4
ASGNI4
line 243
;243:	if( gametype_remap[s_startserver.gametype.curvalue] == GT_FFA ) {
ADDRGP4 s_startserver+548+68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_remap
ADDP4
INDIRI4
CNSTI4 0
NEI4 $165
line 244
;244:		matchbits |= ( 1 << GT_SINGLE_PLAYER );
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 245
;245:	}
LABELV $165
line 246
;246:	for( i = 0; i < count; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $172
JUMPV
LABELV $169
line 247
;247:		info = UI_GetArenaInfoByNumber( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 249
;248:
;249:		gamebits = GametypeBits( Info_ValueForKey( info, "type") );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $173
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 GametypeBits
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 250
;250:		if( !( gamebits & matchbits ) ) {
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
BANDI4
CNSTI4 0
NEI4 $174
line 251
;251:			continue;
ADDRGP4 $170
JUMPV
LABELV $174
line 254
;252:		}
;253:
;254:		s_startserver.maplist[ s_startserver.nummaps ] = i;
ADDRGP4 s_startserver+2028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 255
;255:		s_startserver.nummaps++;
ADDRLP4 36
ADDRGP4 s_startserver+2028
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 256
;256:	}
LABELV $170
line 246
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $172
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $169
line 257
;257:	s_startserver.maxpages = (s_startserver.nummaps + MAX_MAPSPERPAGE-1)/MAX_MAPSPERPAGE;
ADDRGP4 s_startserver+2036
ADDRGP4 s_startserver+2028
INDIRI4
CNSTI4 4
ADDI4
CNSTI4 1
SUBI4
CNSTI4 4
DIVI4
ASGNI4
line 258
;258:	s_startserver.page = 0;
ADDRGP4 s_startserver+2032
CNSTI4 0
ASGNI4
line 259
;259:	s_startserver.currentmap = 0;
ADDRGP4 s_startserver+2024
CNSTI4 0
ASGNI4
line 261
;260:
;261:	StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 262
;262:}
LABELV $159
endproc StartServer_GametypeEvent 40 8
proc StartServer_MenuEvent 12 8
line 270
;263:
;264:
;265:/*
;266:=================
;267:StartServer_MenuEvent
;268:=================
;269:*/
;270:static void StartServer_MenuEvent( void* ptr, int event ) {
line 271
;271:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $184
line 272
;272:		return;
ADDRGP4 $183
JUMPV
LABELV $184
line 275
;273:	}
;274:
;275:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $186
ADDRLP4 0
INDIRI4
CNSTI4 18
GTI4 $186
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $206-60
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $206
address $189
address $194
address $205
address $200
code
LABELV $189
line 277
;276:	case ID_PREVPAGE:
;277:		if( s_startserver.page > 0 ) {
ADDRGP4 s_startserver+2032
INDIRI4
CNSTI4 0
LEI4 $187
line 278
;278:			s_startserver.page--;
ADDRLP4 8
ADDRGP4 s_startserver+2032
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 279
;279:			StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 280
;280:		}
line 281
;281:		break;
ADDRGP4 $187
JUMPV
LABELV $194
line 284
;282:
;283:	case ID_NEXTPAGE:
;284:		if( s_startserver.page < s_startserver.maxpages - 1 ) {
ADDRGP4 s_startserver+2032
INDIRI4
ADDRGP4 s_startserver+2036
INDIRI4
CNSTI4 1
SUBI4
GEI4 $187
line 285
;285:			s_startserver.page++;
ADDRLP4 8
ADDRGP4 s_startserver+2032
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 286
;286:			StartServer_Update();
ADDRGP4 StartServer_Update
CALLV
pop
line 287
;287:		}
line 288
;288:		break;
ADDRGP4 $187
JUMPV
LABELV $200
line 291
;289:
;290:	case ID_STARTSERVERNEXT:
;291:		trap_Cvar_SetValue( "g_gameType", gametype_remap[s_startserver.gametype.curvalue] );
ADDRGP4 $201
ARGP4
ADDRGP4 s_startserver+548+68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_remap
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 292
;292:		UI_ServerOptionsMenu( s_startserver.multiplayer );
ADDRGP4 s_startserver+2020
INDIRI4
ARGI4
ADDRGP4 UI_ServerOptionsMenu
CALLV
pop
line 293
;293:		break;
ADDRGP4 $187
JUMPV
LABELV $205
line 296
;294:
;295:	case ID_STARTSERVERBACK:
;296:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 297
;297:		break;
LABELV $186
LABELV $187
line 299
;298:	}
;299:}
LABELV $183
endproc StartServer_MenuEvent 12 8
proc StartServer_LevelshotDraw 52 20
line 307
;300:
;301:
;302:/*
;303:===============
;304:StartServer_LevelshotDraw
;305:===============
;306:*/
;307:static void StartServer_LevelshotDraw( void *self ) {
line 316
;308:	menubitmap_s	*b;
;309:	int				x;
;310:	int				y;
;311:	int				w;
;312:	int				h;
;313:	int				n;
;314:	const char		*info;
;315:
;316:	b = (menubitmap_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 318
;317:
;318:	if( !b->generic.name ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $209
line 319
;319:		return;
ADDRGP4 $208
JUMPV
LABELV $209
line 322
;320:	}
;321:
;322:	if( b->generic.name && !b->shader ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $211
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $211
line 323
;323:		b->shader = trap_R_RegisterShaderNoMip( b->generic.name );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 324
;324:		if( !b->shader && b->errorpic ) {
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $213
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $213
line 325
;325:			b->shader = trap_R_RegisterShaderNoMip( b->errorpic );
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 326
;326:		}
LABELV $213
line 327
;327:	}
LABELV $211
line 329
;328:
;329:	if( b->focuspic && !b->focusshader ) {
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $215
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 0
NEI4 $215
line 330
;330:		b->focusshader = trap_R_RegisterShaderNoMip( b->focuspic );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 331
;331:	}
LABELV $215
line 333
;332:
;333:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 334
;334:	y = b->generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 335
;335:	w = b->width;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 336
;336:	h =	b->height;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
line 337
;337:	if( b->shader ) {
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $217
line 338
;338:		UI_DrawHandlePic( x, y, w, h, b->shader );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 339
;339:	}
LABELV $217
line 341
;340:
;341:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 342
;342:	y = b->generic.y + b->height;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 343
;343:	UI_FillRect( x, y, b->width, 28, colorBlack );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1105199104
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 345
;344:
;345:	x += b->width / 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ASGNI4
line 346
;346:	y += 4;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
line 347
;347:	n = s_startserver.page * MAX_MAPSPERPAGE + b->generic.id - ID_PICTURES;
ADDRLP4 20
ADDRGP4 s_startserver+2032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
CNSTI4 11
SUBI4
ASGNI4
line 349
;348:
;349:	info = UI_GetArenaInfoByNumber( s_startserver.maplist[ n ]);
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 40
INDIRP4
ASGNP4
line 350
;350:	UI_DrawString( x, y, Info_ValueForKey( info, "map" ), UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 352
;351:
;352:	x = b->generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 353
;353:	y = b->generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 354
;354:	w = b->width;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 355
;355:	h =	b->height + 28;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 28
ADDI4
ASGNI4
line 356
;356:	if( b->generic.flags & QMF_HIGHLIGHT ) {	
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 64
BANDU4
CNSTU4 0
EQU4 $221
line 357
;357:		UI_DrawHandlePic( x, y, w, h, b->focusshader );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 358
;358:	}
LABELV $221
line 359
;359:}
LABELV $208
endproc StartServer_LevelshotDraw 52 20
bss
align 1
LABELV $224
skip 64
code
proc StartServer_MenuInit 20 12
line 367
;360:
;361:
;362:/*
;363:=================
;364:StartServer_MenuInit
;365:=================
;366:*/
;367:static void StartServer_MenuInit( void ) {
line 374
;368:	int	i;
;369:	int	x;
;370:	int	y;
;371:	static char mapnamebuffer[64];
;372:
;373:	// zero set all our globals
;374:	memset( &s_startserver, 0 ,sizeof(startserver_t) );
ADDRGP4 s_startserver
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6136
ARGI4
ADDRGP4 memset
CALLP4
pop
line 376
;375:
;376:	StartServer_Cache();
ADDRGP4 StartServer_Cache
CALLV
pop
line 378
;377:
;378:	s_startserver.menu.wrapAround = qtrue;
ADDRGP4 s_startserver+276
CNSTI4 1
ASGNI4
line 379
;379:	s_startserver.menu.fullscreen = qtrue;
ADDRGP4 s_startserver+280
CNSTI4 1
ASGNI4
line 381
;380:
;381:	s_startserver.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_startserver+288
CNSTI4 10
ASGNI4
line 382
;382:	s_startserver.banner.generic.x	   = 320;
ADDRGP4 s_startserver+288+12
CNSTI4 320
ASGNI4
line 383
;383:	s_startserver.banner.generic.y	   = 16;
ADDRGP4 s_startserver+288+16
CNSTI4 16
ASGNI4
line 384
;384:	s_startserver.banner.string        = "GAME SERVER";
ADDRGP4 s_startserver+288+64
ADDRGP4 $234
ASGNP4
line 385
;385:	s_startserver.banner.color         = color_white;
ADDRGP4 s_startserver+288+72
ADDRGP4 color_white
ASGNP4
line 386
;386:	s_startserver.banner.style         = UI_CENTER;
ADDRGP4 s_startserver+288+68
CNSTI4 1
ASGNI4
line 388
;387:
;388:	s_startserver.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_startserver+364
CNSTI4 6
ASGNI4
line 389
;389:	s_startserver.framel.generic.name  = GAMESERVER_FRAMEL;
ADDRGP4 s_startserver+364+4
ADDRGP4 $242
ASGNP4
line 390
;390:	s_startserver.framel.generic.flags = QMF_INACTIVE;
ADDRGP4 s_startserver+364+44
CNSTU4 16384
ASGNU4
line 391
;391:	s_startserver.framel.generic.x	   = 0;  
ADDRGP4 s_startserver+364+12
CNSTI4 0
ASGNI4
line 392
;392:	s_startserver.framel.generic.y	   = 78;
ADDRGP4 s_startserver+364+16
CNSTI4 78
ASGNI4
line 393
;393:	s_startserver.framel.width  	   = 256;
ADDRGP4 s_startserver+364+80
CNSTI4 256
ASGNI4
line 394
;394:	s_startserver.framel.height  	   = 329;
ADDRGP4 s_startserver+364+84
CNSTI4 329
ASGNI4
line 396
;395:
;396:	s_startserver.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_startserver+456
CNSTI4 6
ASGNI4
line 397
;397:	s_startserver.framer.generic.name  = GAMESERVER_FRAMER;
ADDRGP4 s_startserver+456+4
ADDRGP4 $256
ASGNP4
line 398
;398:	s_startserver.framer.generic.flags = QMF_INACTIVE;
ADDRGP4 s_startserver+456+44
CNSTU4 16384
ASGNU4
line 399
;399:	s_startserver.framer.generic.x	   = 376;
ADDRGP4 s_startserver+456+12
CNSTI4 376
ASGNI4
line 400
;400:	s_startserver.framer.generic.y	   = 76;
ADDRGP4 s_startserver+456+16
CNSTI4 76
ASGNI4
line 401
;401:	s_startserver.framer.width  	   = 256;
ADDRGP4 s_startserver+456+80
CNSTI4 256
ASGNI4
line 402
;402:	s_startserver.framer.height  	   = 334;
ADDRGP4 s_startserver+456+84
CNSTI4 334
ASGNI4
line 404
;403:
;404:	s_startserver.gametype.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_startserver+548
CNSTI4 3
ASGNI4
line 405
;405:	s_startserver.gametype.generic.name		= "Game Type:";
ADDRGP4 s_startserver+548+4
ADDRGP4 $270
ASGNP4
line 406
;406:	s_startserver.gametype.generic.flags	= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_startserver+548+44
CNSTU4 258
ASGNU4
line 407
;407:	s_startserver.gametype.generic.callback	= StartServer_GametypeEvent;
ADDRGP4 s_startserver+548+48
ADDRGP4 StartServer_GametypeEvent
ASGNP4
line 408
;408:	s_startserver.gametype.generic.id		= ID_GAMETYPE;
ADDRGP4 s_startserver+548+8
CNSTI4 10
ASGNI4
line 409
;409:	s_startserver.gametype.generic.x		= 320 - 24;
ADDRGP4 s_startserver+548+12
CNSTI4 296
ASGNI4
line 410
;410:	s_startserver.gametype.generic.y		= 368;
ADDRGP4 s_startserver+548+16
CNSTI4 368
ASGNI4
line 411
;411:	s_startserver.gametype.itemnames		= gametype_items;
ADDRGP4 s_startserver+548+88
ADDRGP4 gametype_items
ASGNP4
line 413
;412:
;413:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $283
line 414
;414:	{
line 415
;415:		x =	(i % MAX_MAPCOLS) * (128+8) + 188;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
MODI4
CNSTI4 136
MULI4
CNSTI4 188
ADDI4
ASGNI4
line 416
;416:		y = (i / MAX_MAPROWS) * (128+8) + 96;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 136
MULI4
CNSTI4 96
ADDI4
ASGNI4
line 418
;417:
;418:		s_startserver.mappics[i].generic.type   = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656
ADDP4
CNSTI4 6
ASGNI4
line 419
;419:		s_startserver.mappics[i].generic.flags  = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+44
ADDP4
CNSTU4 16388
ASGNU4
line 420
;420:		s_startserver.mappics[i].generic.x	    = x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 421
;421:		s_startserver.mappics[i].generic.y	    = y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 422
;422:		s_startserver.mappics[i].generic.id		= ID_PICTURES+i;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 11
ADDI4
ASGNI4
line 423
;423:		s_startserver.mappics[i].width  		= 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+80
ADDP4
CNSTI4 128
ASGNI4
line 424
;424:		s_startserver.mappics[i].height  	    = 96;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+84
ADDP4
CNSTI4 96
ASGNI4
line 425
;425:		s_startserver.mappics[i].focuspic       = GAMESERVER_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+64
ADDP4
ADDRGP4 $302
ASGNP4
line 426
;426:		s_startserver.mappics[i].errorpic       = GAMESERVER_UNKNOWNMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+68
ADDP4
ADDRGP4 $305
ASGNP4
line 427
;427:		s_startserver.mappics[i].generic.ownerdraw = StartServer_LevelshotDraw;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656+56
ADDP4
ADDRGP4 StartServer_LevelshotDraw
ASGNP4
line 429
;428:
;429:		s_startserver.mapbuttons[i].generic.type     = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024
ADDP4
CNSTI4 6
ASGNI4
line 430
;430:		s_startserver.mapbuttons[i].generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_NODEFAULTINIT;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+44
ADDP4
CNSTU4 33028
ASGNU4
line 431
;431:		s_startserver.mapbuttons[i].generic.id       = ID_PICTURES+i;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 11
ADDI4
ASGNI4
line 432
;432:		s_startserver.mapbuttons[i].generic.callback = StartServer_MapEvent;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+48
ADDP4
ADDRGP4 StartServer_MapEvent
ASGNP4
line 433
;433:		s_startserver.mapbuttons[i].generic.x	     = x - 30;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 30
SUBI4
ASGNI4
line 434
;434:		s_startserver.mapbuttons[i].generic.y	     = y - 32;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 435
;435:		s_startserver.mapbuttons[i].width  		     = 256;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+80
ADDP4
CNSTI4 256
ASGNI4
line 436
;436:		s_startserver.mapbuttons[i].height  	     = 248;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+84
ADDP4
CNSTI4 248
ASGNI4
line 437
;437:		s_startserver.mapbuttons[i].generic.left     = x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 438
;438:		s_startserver.mapbuttons[i].generic.top  	 = y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 439
;439:		s_startserver.mapbuttons[i].generic.right    = x + 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 440
;440:		s_startserver.mapbuttons[i].generic.bottom   = y + 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 441
;441:		s_startserver.mapbuttons[i].focuspic         = GAMESERVER_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024+64
ADDP4
ADDRGP4 $333
ASGNP4
line 442
;442:	}
LABELV $284
line 413
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $283
line 444
;443:
;444:	s_startserver.arrows.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_startserver+1392
CNSTI4 6
ASGNI4
line 445
;445:	s_startserver.arrows.generic.name  = GAMESERVER_ARROWS;
ADDRGP4 s_startserver+1392+4
ADDRGP4 $337
ASGNP4
line 446
;446:	s_startserver.arrows.generic.flags = QMF_INACTIVE;
ADDRGP4 s_startserver+1392+44
CNSTU4 16384
ASGNU4
line 447
;447:	s_startserver.arrows.generic.x	   = 260;
ADDRGP4 s_startserver+1392+12
CNSTI4 260
ASGNI4
line 448
;448:	s_startserver.arrows.generic.y	   = 400;
ADDRGP4 s_startserver+1392+16
CNSTI4 400
ASGNI4
line 449
;449:	s_startserver.arrows.width  	   = 128;
ADDRGP4 s_startserver+1392+80
CNSTI4 128
ASGNI4
line 450
;450:	s_startserver.arrows.height  	   = 32;
ADDRGP4 s_startserver+1392+84
CNSTI4 32
ASGNI4
line 452
;451:
;452:	s_startserver.prevpage.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+1484
CNSTI4 6
ASGNI4
line 453
;453:	s_startserver.prevpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+1484+44
CNSTU4 260
ASGNU4
line 454
;454:	s_startserver.prevpage.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+1484+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 455
;455:	s_startserver.prevpage.generic.id	    = ID_PREVPAGE;
ADDRGP4 s_startserver+1484+8
CNSTI4 15
ASGNI4
line 456
;456:	s_startserver.prevpage.generic.x		= 260;
ADDRGP4 s_startserver+1484+12
CNSTI4 260
ASGNI4
line 457
;457:	s_startserver.prevpage.generic.y		= 400;
ADDRGP4 s_startserver+1484+16
CNSTI4 400
ASGNI4
line 458
;458:	s_startserver.prevpage.width  		    = 64;
ADDRGP4 s_startserver+1484+80
CNSTI4 64
ASGNI4
line 459
;459:	s_startserver.prevpage.height  		    = 32;
ADDRGP4 s_startserver+1484+84
CNSTI4 32
ASGNI4
line 460
;460:	s_startserver.prevpage.focuspic         = GAMESERVER_ARROWSL;
ADDRGP4 s_startserver+1484+64
ADDRGP4 $365
ASGNP4
line 462
;461:
;462:	s_startserver.nextpage.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+1576
CNSTI4 6
ASGNI4
line 463
;463:	s_startserver.nextpage.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+1576+44
CNSTU4 260
ASGNU4
line 464
;464:	s_startserver.nextpage.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+1576+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 465
;465:	s_startserver.nextpage.generic.id	    = ID_NEXTPAGE;
ADDRGP4 s_startserver+1576+8
CNSTI4 16
ASGNI4
line 466
;466:	s_startserver.nextpage.generic.x		= 321;
ADDRGP4 s_startserver+1576+12
CNSTI4 321
ASGNI4
line 467
;467:	s_startserver.nextpage.generic.y		= 400;
ADDRGP4 s_startserver+1576+16
CNSTI4 400
ASGNI4
line 468
;468:	s_startserver.nextpage.width  		    = 64;
ADDRGP4 s_startserver+1576+80
CNSTI4 64
ASGNI4
line 469
;469:	s_startserver.nextpage.height  		    = 32;
ADDRGP4 s_startserver+1576+84
CNSTI4 32
ASGNI4
line 470
;470:	s_startserver.nextpage.focuspic         = GAMESERVER_ARROWSR;
ADDRGP4 s_startserver+1576+64
ADDRGP4 $383
ASGNP4
line 472
;471:
;472:	s_startserver.mapname.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_startserver+1852
CNSTI4 9
ASGNI4
line 473
;473:	s_startserver.mapname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_startserver+1852+44
CNSTU4 16392
ASGNU4
line 474
;474:	s_startserver.mapname.generic.x	    = 320;
ADDRGP4 s_startserver+1852+12
CNSTI4 320
ASGNI4
line 475
;475:	s_startserver.mapname.generic.y	    = 440;
ADDRGP4 s_startserver+1852+16
CNSTI4 440
ASGNI4
line 476
;476:	s_startserver.mapname.string        = mapnamebuffer;
ADDRGP4 s_startserver+1852+64
ADDRGP4 $224
ASGNP4
line 477
;477:	s_startserver.mapname.style         = UI_CENTER|UI_BIGFONT;
ADDRGP4 s_startserver+1852+68
CNSTI4 33
ASGNI4
line 478
;478:	s_startserver.mapname.color         = text_color_normal;
ADDRGP4 s_startserver+1852+72
ADDRGP4 text_color_normal
ASGNP4
line 480
;479:
;480:	s_startserver.back.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+1668
CNSTI4 6
ASGNI4
line 481
;481:	s_startserver.back.generic.name     = GAMESERVER_BACK0;
ADDRGP4 s_startserver+1668+4
ADDRGP4 $400
ASGNP4
line 482
;482:	s_startserver.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+1668+44
CNSTU4 260
ASGNU4
line 483
;483:	s_startserver.back.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+1668+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 484
;484:	s_startserver.back.generic.id	    = ID_STARTSERVERBACK;
ADDRGP4 s_startserver+1668+8
CNSTI4 17
ASGNI4
line 485
;485:	s_startserver.back.generic.x		= 0;
ADDRGP4 s_startserver+1668+12
CNSTI4 0
ASGNI4
line 486
;486:	s_startserver.back.generic.y		= 480-64;
ADDRGP4 s_startserver+1668+16
CNSTI4 416
ASGNI4
line 487
;487:	s_startserver.back.width  		    = 128;
ADDRGP4 s_startserver+1668+80
CNSTI4 128
ASGNI4
line 488
;488:	s_startserver.back.height  		    = 64;
ADDRGP4 s_startserver+1668+84
CNSTI4 64
ASGNI4
line 489
;489:	s_startserver.back.focuspic         = GAMESERVER_BACK1;
ADDRGP4 s_startserver+1668+64
ADDRGP4 $417
ASGNP4
line 491
;490:
;491:	s_startserver.next.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_startserver+1760
CNSTI4 6
ASGNI4
line 492
;492:	s_startserver.next.generic.name     = GAMESERVER_NEXT0;
ADDRGP4 s_startserver+1760+4
ADDRGP4 $421
ASGNP4
line 493
;493:	s_startserver.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_startserver+1760+44
CNSTU4 272
ASGNU4
line 494
;494:	s_startserver.next.generic.callback = StartServer_MenuEvent;
ADDRGP4 s_startserver+1760+48
ADDRGP4 StartServer_MenuEvent
ASGNP4
line 495
;495:	s_startserver.next.generic.id	    = ID_STARTSERVERNEXT;
ADDRGP4 s_startserver+1760+8
CNSTI4 18
ASGNI4
line 496
;496:	s_startserver.next.generic.x		= 640;
ADDRGP4 s_startserver+1760+12
CNSTI4 640
ASGNI4
line 497
;497:	s_startserver.next.generic.y		= 480-64;
ADDRGP4 s_startserver+1760+16
CNSTI4 416
ASGNI4
line 498
;498:	s_startserver.next.width  		    = 128;
ADDRGP4 s_startserver+1760+80
CNSTI4 128
ASGNI4
line 499
;499:	s_startserver.next.height  		    = 64;
ADDRGP4 s_startserver+1760+84
CNSTI4 64
ASGNI4
line 500
;500:	s_startserver.next.focuspic         = GAMESERVER_NEXT1;
ADDRGP4 s_startserver+1760+64
ADDRGP4 $438
ASGNP4
line 502
;501:
;502:	s_startserver.item_null.generic.type	= MTYPE_BITMAP;
ADDRGP4 s_startserver+1928
CNSTI4 6
ASGNI4
line 503
;503:	s_startserver.item_null.generic.flags	= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
ADDRGP4 s_startserver+1928+44
CNSTU4 1050628
ASGNU4
line 504
;504:	s_startserver.item_null.generic.x		= 0;
ADDRGP4 s_startserver+1928+12
CNSTI4 0
ASGNI4
line 505
;505:	s_startserver.item_null.generic.y		= 0;
ADDRGP4 s_startserver+1928+16
CNSTI4 0
ASGNI4
line 506
;506:	s_startserver.item_null.width			= 640;
ADDRGP4 s_startserver+1928+80
CNSTI4 640
ASGNI4
line 507
;507:	s_startserver.item_null.height			= 480;
ADDRGP4 s_startserver+1928+84
CNSTI4 480
ASGNI4
line 509
;508:
;509:	Menu_AddItem( &s_startserver.menu, &s_startserver.banner );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 510
;510:	Menu_AddItem( &s_startserver.menu, &s_startserver.framel );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+364
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 511
;511:	Menu_AddItem( &s_startserver.menu, &s_startserver.framer );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+456
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 513
;512:
;513:	Menu_AddItem( &s_startserver.menu, &s_startserver.gametype );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+548
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 514
;514:	for (i=0; i<MAX_MAPSPERPAGE; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $454
line 515
;515:	{
line 516
;516:		Menu_AddItem( &s_startserver.menu, &s_startserver.mappics[i] );
ADDRGP4 s_startserver
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+656
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 517
;517:		Menu_AddItem( &s_startserver.menu, &s_startserver.mapbuttons[i] );
ADDRGP4 s_startserver
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_startserver+1024
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 518
;518:	}
LABELV $455
line 514
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $454
line 520
;519:
;520:	Menu_AddItem( &s_startserver.menu, &s_startserver.arrows );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1392
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 521
;521:	Menu_AddItem( &s_startserver.menu, &s_startserver.prevpage );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1484
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 522
;522:	Menu_AddItem( &s_startserver.menu, &s_startserver.nextpage );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1576
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 523
;523:	Menu_AddItem( &s_startserver.menu, &s_startserver.back );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1668
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 524
;524:	Menu_AddItem( &s_startserver.menu, &s_startserver.next );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1760
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 525
;525:	Menu_AddItem( &s_startserver.menu, &s_startserver.mapname );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1852
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 526
;526:	Menu_AddItem( &s_startserver.menu, &s_startserver.item_null );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 s_startserver+1928
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 528
;527:
;528:	StartServer_GametypeEvent( NULL, QM_ACTIVATED );
CNSTP4 0
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 StartServer_GametypeEvent
CALLV
pop
line 529
;529:}
LABELV $223
endproc StartServer_MenuInit 20 12
export StartServer_Cache
proc StartServer_Cache 104 16
line 538
;530:
;531:
;532:/*
;533:=================
;534:StartServer_Cache
;535:=================
;536:*/
;537:void StartServer_Cache( void )
;538:{
line 545
;539:	int				i;
;540:	const char		*info;
;541:	qboolean		precache;
;542:	char			picname[ MAX_QPATH ];
;543:	char			mapname[ MAX_NAMELENGTH ];
;544:
;545:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );	
ADDRGP4 $400
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 546
;546:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );	
ADDRGP4 $417
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 547
;547:	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT0 );	
ADDRGP4 $421
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 548
;548:	trap_R_RegisterShaderNoMip( GAMESERVER_NEXT1 );	
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 549
;549:	trap_R_RegisterShaderNoMip( GAMESERVER_FRAMEL );	
ADDRGP4 $242
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 550
;550:	trap_R_RegisterShaderNoMip( GAMESERVER_FRAMER );	
ADDRGP4 $256
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 551
;551:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECT );	
ADDRGP4 $333
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 552
;552:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECTED );	
ADDRGP4 $302
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 553
;553:	trap_R_RegisterShaderNoMip( GAMESERVER_UNKNOWNMAP );
ADDRGP4 $305
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 554
;554:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWS );
ADDRGP4 $337
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 555
;555:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWSL );
ADDRGP4 $365
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 556
;556:	trap_R_RegisterShaderNoMip( GAMESERVER_ARROWSR );
ADDRGP4 $383
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 558
;557:
;558:	precache = trap_Cvar_VariableValue("com_buildscript");
ADDRGP4 $468
ARGP4
ADDRLP4 92
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 88
ADDRLP4 92
INDIRF4
CVFI4 4
ASGNI4
line 560
;559:
;560:	if( precache ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $469
line 561
;561:		for( i = 0; i < UI_GetNumArenas(); i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $474
JUMPV
LABELV $471
line 562
;562:			info = UI_GetArenaInfoByNumber( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 96
INDIRP4
ASGNP4
line 563
;563:			Q_strncpyz( mapname, Info_ValueForKey( info, "map"), MAX_NAMELENGTH );
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 564
;564:			Q_strupr( mapname );
ADDRLP4 68
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 566
;565:
;566:			Com_sprintf( picname, sizeof(picname), "levelshots/%s", mapname );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 567
;567:			trap_R_RegisterShaderNoMip(picname);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 568
;568:		}
LABELV $472
line 561
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $474
ADDRLP4 96
ADDRGP4 UI_GetNumArenas
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $471
line 569
;569:	}
LABELV $469
line 570
;570:}
LABELV $467
endproc StartServer_Cache 104 16
export UI_StartServerMenu
proc UI_StartServerMenu 0 4
line 578
;571:
;572:
;573:/*
;574:=================
;575:UI_StartServerMenu
;576:=================
;577:*/
;578:void UI_StartServerMenu( qboolean multiplayer ) {
line 579
;579:	StartServer_MenuInit();
ADDRGP4 StartServer_MenuInit
CALLV
pop
line 580
;580:	s_startserver.multiplayer = multiplayer;
ADDRGP4 s_startserver+2020
ADDRFP4 0
INDIRI4
ASGNI4
line 581
;581:	UI_PushMenu( &s_startserver.menu );
ADDRGP4 s_startserver
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 582
;582:}
LABELV $475
endproc UI_StartServerMenu 0 4
data
align 4
LABELV dedicated_list
address $478
address $479
address $480
byte 4 0
align 4
LABELV playerType_list
address $481
address $482
address $483
byte 4 0
align 4
LABELV playerTeam_list
address $484
address $485
byte 4 0
align 4
LABELV botSkill_list
address $486
address $487
address $488
address $489
address $490
byte 4 0
code
proc BotAlreadySelected 8 8
line 678
;583:
;584:
;585:
;586:/*
;587:=============================================================================
;588:
;589:SERVER OPTIONS MENU *****
;590:
;591:=============================================================================
;592:*/
;593:
;594:#define ID_PLAYER_TYPE			20
;595:#define ID_MAXCLIENTS			21
;596:#define ID_DEDICATED			22
;597:#define ID_GO					23
;598:#define ID_BACK					24
;599:
;600:#define PLAYER_SLOTS			12
;601:
;602:
;603:typedef struct {
;604:	menuframework_s		menu;
;605:
;606:	menutext_s			banner;
;607:
;608:	menubitmap_s		mappic;
;609:	menubitmap_s		picframe;
;610:
;611:	menulist_s			dedicated;
;612:	menufield_s			timelimit;
;613:	menufield_s			fraglimit;
;614:	menufield_s			flaglimit;
;615:	menuradiobutton_s	friendlyfire;
;616:	menufield_s			hostname;
;617:	menuradiobutton_s	pure;
;618:	menulist_s			botSkill;
;619:
;620:	menutext_s			player0;
;621:	menulist_s			playerType[PLAYER_SLOTS];
;622:	menutext_s			playerName[PLAYER_SLOTS];
;623:	menulist_s			playerTeam[PLAYER_SLOTS];
;624:
;625:	menubitmap_s		go;
;626:	menubitmap_s		next;
;627:	menubitmap_s		back;
;628:
;629:	qboolean			multiplayer;
;630:	int					gametype;
;631:	char				mapnamebuffer[32];
;632:	char				playerNameBuffers[PLAYER_SLOTS][16];
;633:
;634:	qboolean			newBot;
;635:	int					newBotIndex;
;636:	char				newBotName[16];
;637:	
;638:	menulist_s		punkbuster;
;639:} serveroptions_t;
;640:
;641:static serveroptions_t s_serveroptions;
;642:
;643:static const char *dedicated_list[] = {
;644:	"No",
;645:	"LAN",
;646:	"Internet",
;647:	NULL
;648:};
;649:
;650:static const char *playerType_list[] = {
;651:	"Open",
;652:	"Bot",
;653:	"----",
;654:	NULL
;655:};
;656:
;657:static const char *playerTeam_list[] = {
;658:	"Blue",
;659:	"Red",
;660:	NULL
;661:};
;662:
;663:static const char *botSkill_list[] = {
;664:	"I Can Win",
;665:	"Bring It On",
;666:	"Hurt Me Plenty",
;667:	"Hardcore",
;668:	"Nightmare!",
;669:	NULL
;670:};
;671:
;672:
;673:/*
;674:=================
;675:BotAlreadySelected
;676:=================
;677:*/
;678:static qboolean BotAlreadySelected( const char *checkName ) {
line 681
;679:	int		n;
;680:
;681:	for( n = 1; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $492
line 682
;682:		if( s_serveroptions.playerType[n].curvalue != 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $496
line 683
;683:			continue;
ADDRGP4 $493
JUMPV
LABELV $496
line 685
;684:		}
;685:		if( (s_serveroptions.gametype >= GT_TEAM) &&
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $500
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+68
ADDP4
INDIRI4
ADDRGP4 s_serveroptions+6352
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+68
ADDP4
INDIRI4
EQI4 $500
line 686
;686:			(s_serveroptions.playerTeam[n].curvalue != s_serveroptions.playerTeam[s_serveroptions.newBotIndex].curvalue ) ) {
line 687
;687:			continue;
ADDRGP4 $493
JUMPV
LABELV $500
line 689
;688:		}
;689:		if( Q_stricmp( checkName, s_serveroptions.playerNameBuffers[n] ) == 0 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $508
line 690
;690:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $491
JUMPV
LABELV $508
line 692
;691:		}
;692:	}
LABELV $493
line 681
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $492
line 694
;693:
;694:	return qfalse;
CNSTI4 0
RETI4
LABELV $491
endproc BotAlreadySelected 8 8
proc ServerOptions_Start 168 24
line 703
;695:}
;696:
;697:
;698:/*
;699:=================
;700:ServerOptions_Start
;701:=================
;702:*/
;703:static void ServerOptions_Start( void ) {
line 716
;704:	int		timelimit;
;705:	int		fraglimit;
;706:	int		maxclients;
;707:	int		dedicated;
;708:	int		friendlyfire;
;709:	int		flaglimit;
;710:	int		pure;
;711:	int		skill;
;712:	int		n;
;713:	char	buf[64];
;714:	const char *info;
;715:
;716:	timelimit	 = atoi( s_serveroptions.timelimit.field.buffer );
ADDRGP4 s_serveroptions+656+64+12
ARGP4
ADDRLP4 104
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 104
INDIRI4
ASGNI4
line 717
;717:	fraglimit	 = atoi( s_serveroptions.fraglimit.field.buffer );
ADDRGP4 s_serveroptions+996+64+12
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 108
INDIRI4
ASGNI4
line 718
;718:	flaglimit	 = atoi( s_serveroptions.flaglimit.field.buffer );
ADDRGP4 s_serveroptions+1336+64+12
ARGP4
ADDRLP4 112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 112
INDIRI4
ASGNI4
line 719
;719:	dedicated	 = s_serveroptions.dedicated.curvalue;
ADDRLP4 88
ADDRGP4 s_serveroptions+548+68
INDIRI4
ASGNI4
line 720
;720:	friendlyfire = s_serveroptions.friendlyfire.curvalue;
ADDRLP4 92
ADDRGP4 s_serveroptions+1676+64
INDIRI4
ASGNI4
line 721
;721:	pure		 = s_serveroptions.pure.curvalue;
ADDRLP4 96
ADDRGP4 s_serveroptions+2084+64
INDIRI4
ASGNI4
line 722
;722:	skill		 = s_serveroptions.botSkill.curvalue + 1;
ADDRLP4 72
ADDRGP4 s_serveroptions+2152+68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 725
;723:
;724:	//set maxclients
;725:	for( n = 0, maxclients = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $532
JUMPV
LABELV $529
line 726
;726:		if( s_serveroptions.playerType[n].curvalue == 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $533
line 727
;727:			continue;
ADDRGP4 $530
JUMPV
LABELV $533
line 729
;728:		}
;729:		if( (s_serveroptions.playerType[n].curvalue == 1) && (s_serveroptions.playerNameBuffers[n][0] == 0) ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $537
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $537
line 730
;730:			continue;
ADDRGP4 $530
JUMPV
LABELV $537
line 732
;731:		}
;732:		maxclients++;
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 733
;733:	}
LABELV $530
line 725
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $532
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $529
line 735
;734:
;735:	switch( s_serveroptions.gametype ) {
ADDRLP4 116
ADDRGP4 s_serveroptions+6120
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
LTI4 $542
ADDRLP4 116
INDIRI4
CNSTI4 4
GTI4 $542
ADDRLP4 116
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $559
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $559
address $545
address $548
address $542
address $551
address $555
code
LABELV $545
LABELV $542
line 738
;736:	case GT_FFA:
;737:	default:
;738:		trap_Cvar_SetValue( "ui_ffa_fraglimit", fraglimit );
ADDRGP4 $546
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 739
;739:		trap_Cvar_SetValue( "ui_ffa_timelimit", timelimit );
ADDRGP4 $547
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 740
;740:		break;
ADDRGP4 $543
JUMPV
LABELV $548
line 743
;741:
;742:	case GT_TOURNAMENT:
;743:		trap_Cvar_SetValue( "ui_tourney_fraglimit", fraglimit );
ADDRGP4 $549
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 744
;744:		trap_Cvar_SetValue( "ui_tourney_timelimit", timelimit );
ADDRGP4 $550
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 745
;745:		break;
ADDRGP4 $543
JUMPV
LABELV $551
line 748
;746:
;747:	case GT_TEAM:
;748:		trap_Cvar_SetValue( "ui_team_fraglimit", fraglimit );
ADDRGP4 $552
ARGP4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 749
;749:		trap_Cvar_SetValue( "ui_team_timelimit", timelimit );
ADDRGP4 $553
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 750
;750:		trap_Cvar_SetValue( "ui_team_friendly", friendlyfire );
ADDRGP4 $554
ARGP4
ADDRLP4 92
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 751
;751:		break;
ADDRGP4 $543
JUMPV
LABELV $555
line 754
;752:
;753:	case GT_CTF:
;754:		trap_Cvar_SetValue( "ui_ctf_capturelimit", flaglimit );
ADDRGP4 $556
ARGP4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 755
;755:		trap_Cvar_SetValue( "ui_ctf_timelimit", timelimit );
ADDRGP4 $557
ARGP4
ADDRLP4 76
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 756
;756:		trap_Cvar_SetValue( "ui_ctf_friendly", friendlyfire );
ADDRGP4 $558
ARGP4
ADDRLP4 92
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 757
;757:		break;
LABELV $543
line 760
;758:	}
;759:
;760:	trap_Cvar_SetValue( "sv_maxclients", Com_Clamp( 0, 12, maxclients ) );
CNSTF4 0
ARGF4
CNSTF4 1094713344
ARGF4
ADDRLP4 68
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 120
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $560
ARGP4
ADDRLP4 120
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 761
;761:	trap_Cvar_SetValue( "dedicated", Com_Clamp( 0, 2, dedicated ) );
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 88
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 124
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $561
ARGP4
ADDRLP4 124
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 762
;762:	trap_Cvar_SetValue ("timelimit", Com_Clamp( 0, timelimit, timelimit ) );
CNSTF4 0
ARGF4
ADDRLP4 128
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $562
ARGP4
ADDRLP4 132
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 763
;763:	trap_Cvar_SetValue ("fraglimit", Com_Clamp( 0, fraglimit, fraglimit ) );
CNSTF4 0
ARGF4
ADDRLP4 136
ADDRLP4 80
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 140
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $563
ARGP4
ADDRLP4 140
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 764
;764:	trap_Cvar_SetValue ("capturelimit", Com_Clamp( 0, flaglimit, flaglimit ) );
CNSTF4 0
ARGF4
ADDRLP4 144
ADDRLP4 84
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 148
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $564
ARGP4
ADDRLP4 148
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 765
;765:	trap_Cvar_SetValue( "g_friendlyfire", friendlyfire );
ADDRGP4 $565
ARGP4
ADDRLP4 92
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 766
;766:	trap_Cvar_SetValue( "sv_pure", pure );
ADDRGP4 $566
ARGP4
ADDRLP4 96
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 767
;767:	trap_Cvar_Set("sv_hostname", s_serveroptions.hostname.field.buffer );
ADDRGP4 $567
ARGP4
ADDRGP4 s_serveroptions+1744+64+12
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 769
;768:	
;769:	trap_Cvar_SetValue( "sv_punkbuster", s_serveroptions.punkbuster.curvalue );
ADDRGP4 $571
ARGP4
ADDRGP4 s_serveroptions+6372+68
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 772
;770:
;771:	// the wait commands will allow the dedicated to take effect
;772:	info = UI_GetArenaInfoByNumber( s_startserver.maplist[ s_startserver.currentmap ]);
ADDRGP4 s_startserver+2024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 152
INDIRP4
ASGNP4
line 773
;773:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", Info_ValueForKey( info, "map" )));
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 156
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $576
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 160
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 776
;774:
;775:	// add bots
;776:	trap_Cmd_ExecuteText( EXEC_APPEND, "wait 3\n" );
CNSTI4 2
ARGI4
ADDRGP4 $577
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 777
;777:	for( n = 1; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $578
line 778
;778:		if( s_serveroptions.playerType[n].curvalue != 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $582
line 779
;779:			continue;
ADDRGP4 $579
JUMPV
LABELV $582
line 781
;780:		}
;781:		if( s_serveroptions.playerNameBuffers[n][0] == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $586
line 782
;782:			continue;
ADDRGP4 $579
JUMPV
LABELV $586
line 784
;783:		}
;784:		if( s_serveroptions.playerNameBuffers[n][0] == '-' ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $589
line 785
;785:			continue;
ADDRGP4 $579
JUMPV
LABELV $589
line 787
;786:		}
;787:		if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $592
line 788
;788:			Com_sprintf( buf, sizeof(buf), "addbot %s %i %s\n", s_serveroptions.playerNameBuffers[n], skill,
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $595
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+68
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playerTeam_list
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 790
;789:				playerTeam_list[s_serveroptions.playerTeam[n].curvalue] );
;790:		}
ADDRGP4 $593
JUMPV
LABELV $592
line 791
;791:		else {
line 792
;792:			Com_sprintf( buf, sizeof(buf), "addbot %s %i\n", s_serveroptions.playerNameBuffers[n], skill );
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $599
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 793
;793:		}
LABELV $593
line 794
;794:		trap_Cmd_ExecuteText( EXEC_APPEND, buf );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 795
;795:	}
LABELV $579
line 777
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $578
line 798
;796:
;797:	// set player's team
;798:	if( dedicated == 0 && s_serveroptions.gametype >= GT_TEAM ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $601
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $601
line 799
;799:		trap_Cmd_ExecuteText( EXEC_APPEND, va( "team %s\n", playerTeam_list[s_serveroptions.playerTeam[0].curvalue] ) );
ADDRGP4 $604
ARGP4
ADDRGP4 s_serveroptions+4544+68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playerTeam_list
ADDP4
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 800
;800:	}
LABELV $601
line 801
;801:}
LABELV $511
endproc ServerOptions_Start 168 24
proc ServerOptions_InitPlayerItems 12 12
line 809
;802:
;803:
;804:/*
;805:=================
;806:ServerOptions_InitPlayerItems
;807:=================
;808:*/
;809:static void ServerOptions_InitPlayerItems( void ) {
line 814
;810:	int		n;
;811:	int		v;
;812:
;813:	// init types
;814:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $608
line 815
;815:		v = 0;	// open
ADDRLP4 4
CNSTI4 0
ASGNI4
line 816
;816:	}
ADDRGP4 $609
JUMPV
LABELV $608
line 817
;817:	else {
line 818
;818:		v = 1;	// bot
ADDRLP4 4
CNSTI4 1
ASGNI4
line 819
;819:	}
LABELV $609
line 821
;820:	
;821:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $611
line 822
;822:		s_serveroptions.playerType[n].curvalue = v;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 823
;823:	}
LABELV $612
line 821
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $611
line 825
;824:
;825:	if( s_serveroptions.multiplayer && (s_serveroptions.gametype < GT_TEAM) ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $617
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
GEI4 $617
line 826
;826:		for( n = 8; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 8
ASGNI4
LABELV $621
line 827
;827:			s_serveroptions.playerType[n].curvalue = 2;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
CNSTI4 2
ASGNI4
line 828
;828:		}
LABELV $622
line 826
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $621
line 829
;829:	}
LABELV $617
line 832
;830:
;831:	// if not a dedicated server, first slot is reserved for the human on the server
;832:	if( s_serveroptions.dedicated.curvalue == 0 ) {
ADDRGP4 s_serveroptions+548+68
INDIRI4
CNSTI4 0
NEI4 $627
line 834
;833:		// human
;834:		s_serveroptions.playerType[0].generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_serveroptions+2336+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 835
;835:		s_serveroptions.playerType[0].curvalue = 0;
ADDRGP4 s_serveroptions+2336+68
CNSTI4 0
ASGNI4
line 836
;836:		trap_Cvar_VariableStringBuffer( "name", s_serveroptions.playerNameBuffers[0], sizeof(s_serveroptions.playerNameBuffers[0]) );
ADDRGP4 $635
ARGP4
ADDRGP4 s_serveroptions+6156
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 837
;837:		Q_CleanStr( s_serveroptions.playerNameBuffers[0] );
ADDRGP4 s_serveroptions+6156
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 838
;838:	}
LABELV $627
line 841
;839:
;840:	// init teams
;841:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $639
line 842
;842:		for( n = 0; n < (PLAYER_SLOTS / 2); n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 843
;843:			s_serveroptions.playerTeam[n].curvalue = 0;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+68
ADDP4
CNSTI4 0
ASGNI4
line 844
;844:		}
LABELV $643
line 842
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $642
line 845
;845:		for( ; n < PLAYER_SLOTS; n++ ) {
ADDRGP4 $651
JUMPV
LABELV $648
line 846
;846:			s_serveroptions.playerTeam[n].curvalue = 1;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+68
ADDP4
CNSTI4 1
ASGNI4
line 847
;847:		}
LABELV $649
line 845
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $651
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $648
line 848
;848:	}
ADDRGP4 $640
JUMPV
LABELV $639
line 849
;849:	else {
line 850
;850:		for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $654
line 851
;851:			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 852
;852:		}
LABELV $655
line 850
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $654
line 853
;853:	}
LABELV $640
line 854
;854:}
LABELV $607
endproc ServerOptions_InitPlayerItems 12 12
proc ServerOptions_SetPlayerItems 12 0
line 862
;855:
;856:
;857:/*
;858:=================
;859:ServerOptions_SetPlayerItems
;860:=================
;861:*/
;862:static void ServerOptions_SetPlayerItems( void ) {
line 874
;863:	int		start;
;864:	int		n;
;865:
;866:	// types
;867://	for( n = 0; n < PLAYER_SLOTS; n++ ) {
;868://		if( (!s_serveroptions.multiplayer) && (n > 0) && (s_serveroptions.playerType[n].curvalue == 0) ) {
;869://			s_serveroptions.playerType[n].curvalue = 1;
;870://		}
;871://	}
;872:
;873:	// names
;874:	if( s_serveroptions.dedicated.curvalue == 0 ) {
ADDRGP4 s_serveroptions+548+68
INDIRI4
CNSTI4 0
NEI4 $661
line 875
;875:		s_serveroptions.player0.string = "Human";
ADDRGP4 s_serveroptions+2260+64
ADDRGP4 $667
ASGNP4
line 876
;876:		s_serveroptions.playerName[0].generic.flags &= ~QMF_HIDDEN;
ADDRLP4 8
ADDRGP4 s_serveroptions+3632+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294963199
BANDU4
ASGNU4
line 878
;877:
;878:		start = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 879
;879:	}
ADDRGP4 $662
JUMPV
LABELV $661
line 880
;880:	else {
line 881
;881:		s_serveroptions.player0.string = "Open";
ADDRGP4 s_serveroptions+2260+64
ADDRGP4 $481
ASGNP4
line 882
;882:		start = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 883
;883:	}
LABELV $662
line 884
;884:	for( n = start; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $675
JUMPV
LABELV $672
line 885
;885:		if( s_serveroptions.playerType[n].curvalue == 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $676
line 886
;886:			s_serveroptions.playerName[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 887
;887:		}
ADDRGP4 $677
JUMPV
LABELV $676
line 888
;888:		else {
line 889
;889:			s_serveroptions.playerName[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 890
;890:		}
LABELV $677
line 891
;891:	}
LABELV $673
line 884
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $675
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $672
line 894
;892:
;893:	// teams
;894:	if( s_serveroptions.gametype < GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
GEI4 $684
line 895
;895:		return;
ADDRGP4 $660
JUMPV
LABELV $684
line 897
;896:	}
;897:	for( n = start; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $690
JUMPV
LABELV $687
line 898
;898:		if( s_serveroptions.playerType[n].curvalue == 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $691
line 899
;899:			s_serveroptions.playerTeam[n].generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 900
;900:		}
ADDRGP4 $692
JUMPV
LABELV $691
line 901
;901:		else {
line 902
;902:			s_serveroptions.playerTeam[n].generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 903
;903:		}
LABELV $692
line 904
;904:	}
LABELV $688
line 897
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $690
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $687
line 905
;905:}
LABELV $660
endproc ServerOptions_SetPlayerItems 12 0
proc ServerOptions_Event 8 0
line 913
;906:
;907:
;908:/*
;909:=================
;910:ServerOptions_Event
;911:=================
;912:*/
;913:static void ServerOptions_Event( void* ptr, int event ) {
line 914
;914:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 18
LTI4 $700
ADDRLP4 0
INDIRI4
CNSTI4 24
GTI4 $700
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $716-72
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $716
address $710
address $700
address $703
address $706
address $706
address $707
address $713
code
LABELV $703
line 920
;915:	
;916:	//if( event != QM_ACTIVATED && event != QM_LOSTFOCUS) {
;917:	//	return;
;918:	//}
;919:	case ID_PLAYER_TYPE:
;920:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $704
line 921
;921:			break;
ADDRGP4 $701
JUMPV
LABELV $704
line 923
;922:		}
;923:		ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 924
;924:		break;
ADDRGP4 $701
JUMPV
LABELV $706
line 928
;925:
;926:	case ID_MAXCLIENTS:
;927:	case ID_DEDICATED:
;928:		ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 929
;929:		break;
ADDRGP4 $701
JUMPV
LABELV $707
line 931
;930:	case ID_GO:
;931:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $708
line 932
;932:			break;
ADDRGP4 $701
JUMPV
LABELV $708
line 934
;933:		}
;934:		ServerOptions_Start();
ADDRGP4 ServerOptions_Start
CALLV
pop
line 935
;935:		break;
ADDRGP4 $701
JUMPV
LABELV $710
line 938
;936:
;937:	case ID_STARTSERVERNEXT:
;938:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $701
line 939
;939:			break;
ADDRGP4 $701
JUMPV
line 941
;940:		}
;941:		break;
LABELV $713
line 943
;942:	case ID_BACK:
;943:		if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $714
line 944
;944:			break;
ADDRGP4 $701
JUMPV
LABELV $714
line 946
;945:		}
;946:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 947
;947:		break;
LABELV $700
LABELV $701
line 949
;948:	}
;949:}
LABELV $699
endproc ServerOptions_Event 8 0
proc ServerOptions_PlayerNameEvent 4 4
line 952
;950:
;951:
;952:static void ServerOptions_PlayerNameEvent( void* ptr, int event ) {
line 955
;953:	int		n;
;954:
;955:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $719
line 956
;956:		return;
ADDRGP4 $718
JUMPV
LABELV $719
line 958
;957:	}
;958:	n = ((menutext_s*)ptr)->generic.id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 959
;959:	s_serveroptions.newBotIndex = n;
ADDRGP4 s_serveroptions+6352
ADDRLP4 0
INDIRI4
ASGNI4
line 960
;960:	UI_BotSelectMenu( s_serveroptions.playerNameBuffers[n] );
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRGP4 UI_BotSelectMenu
CALLV
pop
line 961
;961:}
LABELV $718
endproc ServerOptions_PlayerNameEvent 4 4
proc ServerOptions_StatusBar 4 20
line 969
;962:
;963:
;964:/*
;965:=================
;966:ServerOptions_StatusBar
;967:=================
;968:*/
;969:static void ServerOptions_StatusBar( void* ptr ) {
line 970
;970:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $724
JUMPV
LABELV $724
line 972
;971:	default:
;972:		UI_DrawString( 320, 440, "0 = NO LIMIT", UI_CENTER|UI_SMALLFONT, colorWhite );
CNSTI4 320
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $727
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 973
;973:		break;
LABELV $725
line 975
;974:	}
;975:}
LABELV $723
endproc ServerOptions_StatusBar 4 20
proc ServerOptions_LevelshotDraw 16 20
line 983
;976:
;977:
;978:/*
;979:===============
;980:ServerOptions_LevelshotDraw
;981:===============
;982:*/
;983:static void ServerOptions_LevelshotDraw( void *self ) {
line 989
;984:	menubitmap_s	*b;
;985:	int				x;
;986:	int				y;
;987:
;988:	// strange place for this, but it works
;989:	if( s_serveroptions.newBot ) {
ADDRGP4 s_serveroptions+6348
INDIRI4
CNSTI4 0
EQI4 $729
line 990
;990:		Q_strncpyz( s_serveroptions.playerNameBuffers[s_serveroptions.newBotIndex], s_serveroptions.newBotName, 16 );
ADDRGP4 s_serveroptions+6352
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRGP4 s_serveroptions+6356
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 991
;991:		s_serveroptions.newBot = qfalse;
ADDRGP4 s_serveroptions+6348
CNSTI4 0
ASGNI4
line 992
;992:	}
LABELV $729
line 994
;993:
;994:	b = (menubitmap_s *)self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 996
;995:
;996:	Bitmap_Draw( b );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Bitmap_Draw
CALLV
pop
line 998
;997:
;998:	x = b->generic.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 999
;999:	y = b->generic.y + b->height;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1000
;1000:	UI_FillRect( x, y, b->width, 40, colorBlack );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1109393408
ARGF4
ADDRGP4 colorBlack
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1002
;1001:
;1002:	x += b->width / 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ASGNI4
line 1003
;1003:	y += 4;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
line 1004
;1004:	UI_DrawString( x, y, s_serveroptions.mapnamebuffer, UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 s_serveroptions+6124
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1006
;1005:
;1006:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1007
;1007:	UI_DrawString( x, y, gametype_items[gametype_remap2[s_serveroptions.gametype]], UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_remap2
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametype_items
ADDP4
INDIRP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1008
;1008:}
LABELV $728
endproc ServerOptions_LevelshotDraw 16 20
proc ServerOptions_InitBotNames 1068 12
line 1011
;1009:
;1010:
;1011:static void ServerOptions_InitBotNames( void ) {
line 1020
;1012:	int			count;
;1013:	int			n;
;1014:	const char	*arenaInfo;
;1015:	const char	*botInfo;
;1016:	char		*p;
;1017:	char		*bot;
;1018:	char		bots[MAX_INFO_STRING];
;1019:
;1020:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $739
line 1021
;1021:		Q_strncpyz( s_serveroptions.playerNameBuffers[1], "grunt", 16 );
ADDRGP4 s_serveroptions+6156+16
ARGP4
ADDRGP4 $744
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1022
;1022:		Q_strncpyz( s_serveroptions.playerNameBuffers[2], "major", 16 );
ADDRGP4 s_serveroptions+6156+32
ARGP4
ADDRGP4 $747
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1023
;1023:		if( s_serveroptions.gametype == GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
NEI4 $748
line 1024
;1024:			Q_strncpyz( s_serveroptions.playerNameBuffers[3], "visor", 16 );
ADDRGP4 s_serveroptions+6156+48
ARGP4
ADDRGP4 $753
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1025
;1025:		}
ADDRGP4 $749
JUMPV
LABELV $748
line 1026
;1026:		else {
line 1027
;1027:			s_serveroptions.playerType[3].curvalue = 2;
ADDRGP4 s_serveroptions+2336+324+68
CNSTI4 2
ASGNI4
line 1028
;1028:		}
LABELV $749
line 1029
;1029:		s_serveroptions.playerType[4].curvalue = 2;
ADDRGP4 s_serveroptions+2336+432+68
CNSTI4 2
ASGNI4
line 1030
;1030:		s_serveroptions.playerType[5].curvalue = 2;
ADDRGP4 s_serveroptions+2336+540+68
CNSTI4 2
ASGNI4
line 1032
;1031:
;1032:		Q_strncpyz( s_serveroptions.playerNameBuffers[6], "sarge", 16 );
ADDRGP4 s_serveroptions+6156+96
ARGP4
ADDRGP4 $765
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1033
;1033:		Q_strncpyz( s_serveroptions.playerNameBuffers[7], "grunt", 16 );
ADDRGP4 s_serveroptions+6156+112
ARGP4
ADDRGP4 $744
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1034
;1034:		Q_strncpyz( s_serveroptions.playerNameBuffers[8], "major", 16 );
ADDRGP4 s_serveroptions+6156+128
ARGP4
ADDRGP4 $747
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1035
;1035:		if( s_serveroptions.gametype == GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
NEI4 $770
line 1036
;1036:			Q_strncpyz( s_serveroptions.playerNameBuffers[9], "visor", 16 );
ADDRGP4 s_serveroptions+6156+144
ARGP4
ADDRGP4 $753
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1037
;1037:		}
ADDRGP4 $771
JUMPV
LABELV $770
line 1038
;1038:		else {
line 1039
;1039:			s_serveroptions.playerType[9].curvalue = 2;
ADDRGP4 s_serveroptions+2336+972+68
CNSTI4 2
ASGNI4
line 1040
;1040:		}
LABELV $771
line 1041
;1041:		s_serveroptions.playerType[10].curvalue = 2;
ADDRGP4 s_serveroptions+2336+1080+68
CNSTI4 2
ASGNI4
line 1042
;1042:		s_serveroptions.playerType[11].curvalue = 2;
ADDRGP4 s_serveroptions+2336+1188+68
CNSTI4 2
ASGNI4
line 1044
;1043:
;1044:		return;
ADDRGP4 $738
JUMPV
LABELV $739
line 1047
;1045:	}
;1046:
;1047:	count = 1;	// skip the first slot, reserved for a human
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1050
;1048:
;1049:	// get info for this map
;1050:	arenaInfo = UI_GetArenaInfoByMap( s_serveroptions.mapnamebuffer );
ADDRGP4 s_serveroptions+6124
ARGP4
ADDRLP4 1048
ADDRGP4 UI_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1048
INDIRP4
ASGNP4
line 1053
;1051:
;1052:	// get the bot info - we'll seed with them if any are listed
;1053:	Q_strncpyz( bots, Info_ValueForKey( arenaInfo, "bots" ), sizeof(bots) );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $785
ARGP4
ADDRLP4 1052
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1054
;1054:	p = &bots[0];
ADDRLP4 0
ADDRLP4 20
ASGNP4
ADDRGP4 $787
JUMPV
line 1055
;1055:	while( *p && count < PLAYER_SLOTS ) {
LABELV $789
line 1057
;1056:		//skip spaces
;1057:		while( *p == ' ' ) {
line 1058
;1058:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1059
;1059:		}
LABELV $790
line 1057
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $789
line 1060
;1060:		if( !*p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $792
line 1061
;1061:			break;
ADDRGP4 $788
JUMPV
LABELV $792
line 1065
;1062:		}
;1063:
;1064:		// mark start of bot name
;1065:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $795
JUMPV
LABELV $794
line 1068
;1066:
;1067:		// skip until space of null
;1068:		while( *p && *p != ' ' ) {
line 1069
;1069:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1070
;1070:		}
LABELV $795
line 1068
ADDRLP4 1056
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $797
ADDRLP4 1056
INDIRI4
CNSTI4 32
NEI4 $794
LABELV $797
line 1071
;1071:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $798
line 1072
;1072:			*p++ = 0;
ADDRLP4 1060
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1060
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
CNSTI1 0
ASGNI1
line 1073
;1073:		}
LABELV $798
line 1075
;1074:
;1075:		botInfo = UI_GetBotInfoByName( bot );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 UI_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 1060
INDIRP4
ASGNP4
line 1076
;1076:		bot = Info_ValueForKey( botInfo, "name" );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 1064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1064
INDIRP4
ASGNP4
line 1078
;1077:
;1078:		Q_strncpyz( s_serveroptions.playerNameBuffers[count], bot, sizeof(s_serveroptions.playerNameBuffers[count]) );
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1079
;1079:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1080
;1080:	}
LABELV $787
line 1055
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $802
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $790
LABELV $802
LABELV $788
line 1083
;1081:
;1082:	// set the rest of the bot slots to "---"
;1083:	for( n = count; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $806
JUMPV
LABELV $803
line 1084
;1084:		strcpy( s_serveroptions.playerNameBuffers[n], "--------" );
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ARGP4
ADDRGP4 $808
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1085
;1085:	}
LABELV $804
line 1083
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $806
ADDRLP4 12
INDIRI4
CNSTI4 12
LTI4 $803
line 1088
;1086:
;1087:	// pad up to #8 as open slots
;1088:	for( ;count < 8; count++ ) {
ADDRGP4 $812
JUMPV
LABELV $809
line 1089
;1089:		s_serveroptions.playerType[count].curvalue = 0;
ADDRLP4 4
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
CNSTI4 0
ASGNI4
line 1090
;1090:	}
LABELV $810
line 1088
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $812
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $809
line 1093
;1091:
;1092:	// close off the rest by default
;1093:	for( ;count < PLAYER_SLOTS; count++ ) {
ADDRGP4 $818
JUMPV
LABELV $815
line 1094
;1094:		if( s_serveroptions.playerType[count].curvalue == 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $819
line 1095
;1095:			s_serveroptions.playerType[count].curvalue = 2;
ADDRLP4 4
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+68
ADDP4
CNSTI4 2
ASGNI4
line 1096
;1096:		}
LABELV $819
line 1097
;1097:	}
LABELV $816
line 1093
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $818
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $815
line 1098
;1098:}
LABELV $738
endproc ServerOptions_InitBotNames 1068 12
bss
align 1
LABELV $826
skip 64
code
proc ServerOptions_SetMenuItems 104 16
line 1106
;1099:
;1100:
;1101:/*
;1102:=================
;1103:ServerOptions_SetMenuItems
;1104:=================
;1105:*/
;1106:static void ServerOptions_SetMenuItems( void ) {
line 1111
;1107:	static char picname[MAX_QPATH];
;1108:	char		mapname[MAX_NAMELENGTH];
;1109:	const char	*info;
;1110:
;1111:	switch( s_serveroptions.gametype ) {
ADDRLP4 20
ADDRGP4 s_serveroptions+6120
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $827
ADDRLP4 20
INDIRI4
CNSTI4 4
GTI4 $827
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $863
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $863
address $830
address $838
address $827
address $845
address $854
code
LABELV $830
LABELV $827
line 1114
;1112:	case GT_FFA:
;1113:	default:
;1114:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_fraglimit" ) ) );
ADDRGP4 $546
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+996+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 28
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1115
;1115:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ffa_timelimit" ) ) );
ADDRGP4 $547
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+656+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1116
;1116:		break;
ADDRGP4 $828
JUMPV
LABELV $838
line 1119
;1117:
;1118:	case GT_TOURNAMENT:
;1119:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_fraglimit" ) ) );
ADDRGP4 $549
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+996+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 44
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1120
;1120:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_tourney_timelimit" ) ) );
ADDRGP4 $550
ARGP4
ADDRLP4 48
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+656+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 52
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1121
;1121:		break;
ADDRGP4 $828
JUMPV
LABELV $845
line 1124
;1122:
;1123:	case GT_TEAM:
;1124:		Com_sprintf( s_serveroptions.fraglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_fraglimit" ) ) );
ADDRGP4 $552
ARGP4
ADDRLP4 56
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+996+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 60
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1125
;1125:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_team_timelimit" ) ) );
ADDRGP4 $553
ARGP4
ADDRLP4 64
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+656+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 68
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1126
;1126:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_team_friendly" ) );
ADDRGP4 $554
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1676+64
ADDRLP4 76
INDIRF4
CVFI4 4
ASGNI4
line 1127
;1127:		break;
ADDRGP4 $828
JUMPV
LABELV $854
line 1130
;1128:
;1129:	case GT_CTF:
;1130:		Com_sprintf( s_serveroptions.flaglimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 100, trap_Cvar_VariableValue( "ui_ctf_capturelimit" ) ) );
ADDRGP4 $556
ARGP4
ADDRLP4 80
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1336+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 84
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1131
;1131:		Com_sprintf( s_serveroptions.timelimit.field.buffer, 4, "%i", (int)Com_Clamp( 0, 999, trap_Cvar_VariableValue( "ui_ctf_timelimit" ) ) );
ADDRGP4 $557
ARGP4
ADDRLP4 88
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1148829696
ARGF4
ADDRLP4 88
INDIRF4
ARGF4
ADDRLP4 92
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+656+64+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $834
ARGP4
ADDRLP4 92
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1132
;1132:		s_serveroptions.friendlyfire.curvalue = (int)Com_Clamp( 0, 1, trap_Cvar_VariableValue( "ui_ctf_friendly" ) );
ADDRGP4 $558
ARGP4
ADDRLP4 96
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 100
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+1676+64
ADDRLP4 100
INDIRF4
CVFI4 4
ASGNI4
line 1133
;1133:		break;
LABELV $828
line 1136
;1134:	}
;1135:
;1136:	Q_strncpyz( s_serveroptions.hostname.field.buffer, UI_Cvar_VariableString( "sv_hostname" ), sizeof( s_serveroptions.hostname.field.buffer ) );
ADDRGP4 $567
ARGP4
ADDRLP4 24
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 s_serveroptions+1744+64+12
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1137
;1137:	s_serveroptions.pure.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "sv_pure" ) );
ADDRGP4 $566
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+2084+64
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1140
;1138:
;1139:	// set the map pic
;1140:	info = UI_GetArenaInfoByNumber( s_startserver.maplist[ s_startserver.currentmap ]);
ADDRGP4 s_startserver+2024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_startserver+2040
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 1141
;1141:	Q_strncpyz( mapname, Info_ValueForKey( info, "map" ), sizeof( mapname ) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $105
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1142
;1142:	Q_strupr( mapname );
ADDRLP4 0
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 1143
;1143:	Com_sprintf( picname, sizeof( picname ), "levelshots/%s", mapname );
ADDRGP4 $826
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1144
;1144:	s_serveroptions.mappic.generic.name = picname;
ADDRGP4 s_serveroptions+364+4
ADDRGP4 $826
ASGNP4
line 1147
;1145:
;1146:	// set the map name
;1147:	strcpy( s_serveroptions.mapnamebuffer, s_startserver.mapname.string );
ADDRGP4 s_serveroptions+6124
ARGP4
ADDRGP4 s_startserver+1852+64
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1148
;1148:	Q_strupr( s_serveroptions.mapnamebuffer );
ADDRGP4 s_serveroptions+6124
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 1151
;1149:
;1150:	// get the player selections initialized
;1151:	ServerOptions_InitPlayerItems();
ADDRGP4 ServerOptions_InitPlayerItems
CALLV
pop
line 1152
;1152:	ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1155
;1153:
;1154:	// seed bot names
;1155:	ServerOptions_InitBotNames();
ADDRGP4 ServerOptions_InitBotNames
CALLV
pop
line 1156
;1156:	ServerOptions_SetPlayerItems();
ADDRGP4 ServerOptions_SetPlayerItems
CALLV
pop
line 1157
;1157:}
LABELV $825
endproc ServerOptions_SetMenuItems 104 16
proc PlayerName_Draw 36 20
line 1164
;1158:
;1159:/*
;1160:=================
;1161:PlayerName_Draw
;1162:=================
;1163:*/
;1164:static void PlayerName_Draw( void *item ) {
line 1171
;1165:	menutext_s	*s;
;1166:	float		*color;
;1167:	int			x, y;
;1168:	int			style;
;1169:	qboolean	focus;
;1170:
;1171:	s = (menutext_s *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1173
;1172:
;1173:	x = s->generic.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1174
;1174:	y =	s->generic.y;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1176
;1175:
;1176:	style = UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 1177
;1177:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $882
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $883
JUMPV
LABELV $882
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $883
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 1179
;1178:
;1179:	if ( s->generic.flags & QMF_GRAYED )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $884
line 1180
;1180:		color = text_color_disabled;
ADDRLP4 4
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $885
JUMPV
LABELV $884
line 1181
;1181:	else if ( focus )
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $886
line 1182
;1182:	{
line 1183
;1183:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 1184
;1184:		style |= UI_PULSE;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1185
;1185:	}
ADDRGP4 $887
JUMPV
LABELV $886
line 1186
;1186:	else if ( s->generic.flags & QMF_BLINK )
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $888
line 1187
;1187:	{
line 1188
;1188:		color = text_color_highlight;
ADDRLP4 4
ADDRGP4 text_color_highlight
ASGNP4
line 1189
;1189:		style |= UI_BLINK;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1190
;1190:	}
ADDRGP4 $889
JUMPV
LABELV $888
line 1192
;1191:	else
;1192:		color = text_color_normal;
ADDRLP4 4
ADDRGP4 text_color_normal
ASGNP4
LABELV $889
LABELV $887
LABELV $885
line 1194
;1193:
;1194:	if ( focus )
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $890
line 1195
;1195:	{
line 1197
;1196:		// draw cursor
;1197:		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color ); 
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1198
;1198:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 1199
;1199:	}
LABELV $890
line 1201
;1200:
;1201:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color );
ADDRLP4 8
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1202
;1202:	UI_DrawString( x + SMALLCHAR_WIDTH, y, s->string, style|UI_LEFT, color );
ADDRLP4 8
INDIRI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1203
;1203:}
LABELV $880
endproc PlayerName_Draw 36 20
proc ServerOptions_MenuInit 52 12
line 1213
;1204:
;1205:
;1206:/*
;1207:=================
;1208:ServerOptions_MenuInit
;1209:=================
;1210:*/
;1211:#define OPTIONS_X	456
;1212:
;1213:static void ServerOptions_MenuInit( qboolean multiplayer ) {
line 1217
;1214:	int		y;
;1215:	int		n;
;1216:
;1217:	memset( &s_serveroptions, 0 ,sizeof(serveroptions_t) );
ADDRGP4 s_serveroptions
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6480
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1218
;1218:	s_serveroptions.multiplayer = multiplayer;
ADDRGP4 s_serveroptions+6116
ADDRFP4 0
INDIRI4
ASGNI4
line 1219
;1219:	s_serveroptions.gametype = (int)Com_Clamp( 0, GT_MAX_GAME_TYPE-1, trap_Cvar_VariableValue( "g_gameType" ) );
ADDRGP4 $201
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+6120
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1220
;1220:	s_serveroptions.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "sv_punkbuster" ) );
ADDRGP4 $571
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 s_serveroptions+6372+68
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 1222
;1221:
;1222:	ServerOptions_Cache();
ADDRGP4 ServerOptions_Cache
CALLV
pop
line 1224
;1223:
;1224:	s_serveroptions.menu.wrapAround = qtrue;
ADDRGP4 s_serveroptions+276
CNSTI4 1
ASGNI4
line 1225
;1225:	s_serveroptions.menu.fullscreen = qtrue;
ADDRGP4 s_serveroptions+280
CNSTI4 1
ASGNI4
line 1227
;1226:
;1227:	s_serveroptions.banner.generic.type			= MTYPE_BTEXT;
ADDRGP4 s_serveroptions+288
CNSTI4 10
ASGNI4
line 1228
;1228:	s_serveroptions.banner.generic.x			= 320;
ADDRGP4 s_serveroptions+288+12
CNSTI4 320
ASGNI4
line 1229
;1229:	s_serveroptions.banner.generic.y			= 16;
ADDRGP4 s_serveroptions+288+16
CNSTI4 16
ASGNI4
line 1230
;1230:	s_serveroptions.banner.string  				= "GAME SERVER";
ADDRGP4 s_serveroptions+288+64
ADDRGP4 $234
ASGNP4
line 1231
;1231:	s_serveroptions.banner.color  				= color_white;
ADDRGP4 s_serveroptions+288+72
ADDRGP4 color_white
ASGNP4
line 1232
;1232:	s_serveroptions.banner.style  				= UI_CENTER;
ADDRGP4 s_serveroptions+288+68
CNSTI4 1
ASGNI4
line 1234
;1233:
;1234:	s_serveroptions.mappic.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_serveroptions+364
CNSTI4 6
ASGNI4
line 1235
;1235:	s_serveroptions.mappic.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_serveroptions+364+44
CNSTU4 16388
ASGNU4
line 1236
;1236:	s_serveroptions.mappic.generic.x			= 352;
ADDRGP4 s_serveroptions+364+12
CNSTI4 352
ASGNI4
line 1237
;1237:	s_serveroptions.mappic.generic.y			= 80;
ADDRGP4 s_serveroptions+364+16
CNSTI4 80
ASGNI4
line 1238
;1238:	s_serveroptions.mappic.width				= 160;
ADDRGP4 s_serveroptions+364+80
CNSTI4 160
ASGNI4
line 1239
;1239:	s_serveroptions.mappic.height				= 120;
ADDRGP4 s_serveroptions+364+84
CNSTI4 120
ASGNI4
line 1240
;1240:	s_serveroptions.mappic.errorpic				= GAMESERVER_UNKNOWNMAP;
ADDRGP4 s_serveroptions+364+68
ADDRGP4 $305
ASGNP4
line 1241
;1241:	s_serveroptions.mappic.generic.ownerdraw	= ServerOptions_LevelshotDraw;
ADDRGP4 s_serveroptions+364+56
ADDRGP4 ServerOptions_LevelshotDraw
ASGNP4
line 1243
;1242:
;1243:	s_serveroptions.picframe.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_serveroptions+456
CNSTI4 6
ASGNI4
line 1244
;1244:	s_serveroptions.picframe.generic.flags		= QMF_LEFT_JUSTIFY|QMF_INACTIVE|QMF_HIGHLIGHT;
ADDRGP4 s_serveroptions+456+44
CNSTU4 16452
ASGNU4
line 1245
;1245:	s_serveroptions.picframe.generic.x			= 352 - 38;
ADDRGP4 s_serveroptions+456+12
CNSTI4 314
ASGNI4
line 1246
;1246:	s_serveroptions.picframe.generic.y			= 80 - 40;
ADDRGP4 s_serveroptions+456+16
CNSTI4 40
ASGNI4
line 1247
;1247:	s_serveroptions.picframe.width  			= 320;
ADDRGP4 s_serveroptions+456+80
CNSTI4 320
ASGNI4
line 1248
;1248:	s_serveroptions.picframe.height  			= 320;
ADDRGP4 s_serveroptions+456+84
CNSTI4 320
ASGNI4
line 1249
;1249:	s_serveroptions.picframe.focuspic			= GAMESERVER_SELECT;
ADDRGP4 s_serveroptions+456+64
ADDRGP4 $333
ASGNP4
line 1251
;1250:
;1251:	y = 272;
ADDRLP4 4
CNSTI4 272
ASGNI4
line 1252
;1252:	if( s_serveroptions.gametype != GT_CTF ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 4
EQI4 $938
line 1253
;1253:		s_serveroptions.fraglimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+996
CNSTI4 4
ASGNI4
line 1254
;1254:		s_serveroptions.fraglimit.generic.name       = "Frag Limit:";
ADDRGP4 s_serveroptions+996+4
ADDRGP4 $944
ASGNP4
line 1255
;1255:		s_serveroptions.fraglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+996+44
CNSTU4 290
ASGNU4
line 1256
;1256:		s_serveroptions.fraglimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+996+12
CNSTI4 456
ASGNI4
line 1257
;1257:		s_serveroptions.fraglimit.generic.y	         = y;
ADDRGP4 s_serveroptions+996+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1258
;1258:		s_serveroptions.fraglimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+996+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 1259
;1259:		s_serveroptions.fraglimit.field.widthInChars = 3;
ADDRGP4 s_serveroptions+996+64+8
CNSTI4 3
ASGNI4
line 1260
;1260:		s_serveroptions.fraglimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+996+64+268
CNSTI4 3
ASGNI4
line 1261
;1261:	}
ADDRGP4 $939
JUMPV
LABELV $938
line 1262
;1262:	else {
line 1263
;1263:		s_serveroptions.flaglimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+1336
CNSTI4 4
ASGNI4
line 1264
;1264:		s_serveroptions.flaglimit.generic.name       = "Capture Limit:";
ADDRGP4 s_serveroptions+1336+4
ADDRGP4 $962
ASGNP4
line 1265
;1265:		s_serveroptions.flaglimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1336+44
CNSTU4 290
ASGNU4
line 1266
;1266:		s_serveroptions.flaglimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+1336+12
CNSTI4 456
ASGNI4
line 1267
;1267:		s_serveroptions.flaglimit.generic.y	         = y;
ADDRGP4 s_serveroptions+1336+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1268
;1268:		s_serveroptions.flaglimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+1336+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 1269
;1269:		s_serveroptions.flaglimit.field.widthInChars = 3;
ADDRGP4 s_serveroptions+1336+64+8
CNSTI4 3
ASGNI4
line 1270
;1270:		s_serveroptions.flaglimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+1336+64+268
CNSTI4 3
ASGNI4
line 1271
;1271:	}
LABELV $939
line 1273
;1272:
;1273:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1274
;1274:	s_serveroptions.timelimit.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+656
CNSTI4 4
ASGNI4
line 1275
;1275:	s_serveroptions.timelimit.generic.name       = "Time Limit:";
ADDRGP4 s_serveroptions+656+4
ADDRGP4 $980
ASGNP4
line 1276
;1276:	s_serveroptions.timelimit.generic.flags      = QMF_NUMBERSONLY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+656+44
CNSTU4 290
ASGNU4
line 1277
;1277:	s_serveroptions.timelimit.generic.x	         = OPTIONS_X;
ADDRGP4 s_serveroptions+656+12
CNSTI4 456
ASGNI4
line 1278
;1278:	s_serveroptions.timelimit.generic.y	         = y;
ADDRGP4 s_serveroptions+656+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1279
;1279:	s_serveroptions.timelimit.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+656+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 1280
;1280:	s_serveroptions.timelimit.field.widthInChars = 3;
ADDRGP4 s_serveroptions+656+64+8
CNSTI4 3
ASGNI4
line 1281
;1281:	s_serveroptions.timelimit.field.maxchars     = 3;
ADDRGP4 s_serveroptions+656+64+268
CNSTI4 3
ASGNI4
line 1283
;1282:
;1283:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $995
line 1284
;1284:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1285
;1285:		s_serveroptions.friendlyfire.generic.type     = MTYPE_RADIOBUTTON;
ADDRGP4 s_serveroptions+1676
CNSTI4 5
ASGNI4
line 1286
;1286:		s_serveroptions.friendlyfire.generic.flags    = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1676+44
CNSTU4 258
ASGNU4
line 1287
;1287:		s_serveroptions.friendlyfire.generic.x	      = OPTIONS_X;
ADDRGP4 s_serveroptions+1676+12
CNSTI4 456
ASGNI4
line 1288
;1288:		s_serveroptions.friendlyfire.generic.y	      = y;
ADDRGP4 s_serveroptions+1676+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1289
;1289:		s_serveroptions.friendlyfire.generic.name	  = "Friendly Fire:";
ADDRGP4 s_serveroptions+1676+4
ADDRGP4 $1007
ASGNP4
line 1290
;1290:	}
LABELV $995
line 1292
;1291:
;1292:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1293
;1293:	s_serveroptions.pure.generic.type			= MTYPE_RADIOBUTTON;
ADDRGP4 s_serveroptions+2084
CNSTI4 5
ASGNI4
line 1294
;1294:	s_serveroptions.pure.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2084+44
CNSTU4 258
ASGNU4
line 1295
;1295:	s_serveroptions.pure.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+2084+12
CNSTI4 456
ASGNI4
line 1296
;1296:	s_serveroptions.pure.generic.y				= y;
ADDRGP4 s_serveroptions+2084+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1297
;1297:	s_serveroptions.pure.generic.name			= "Pure Server:";
ADDRGP4 s_serveroptions+2084+4
ADDRGP4 $1017
ASGNP4
line 1299
;1298:
;1299:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $1018
line 1300
;1300:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1301
;1301:		s_serveroptions.dedicated.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+548
CNSTI4 3
ASGNI4
line 1302
;1302:		s_serveroptions.dedicated.generic.id		= ID_DEDICATED;
ADDRGP4 s_serveroptions+548+8
CNSTI4 22
ASGNI4
line 1303
;1303:		s_serveroptions.dedicated.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+548+44
CNSTU4 258
ASGNU4
line 1304
;1304:		s_serveroptions.dedicated.generic.callback	= ServerOptions_Event;
ADDRGP4 s_serveroptions+548+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 1305
;1305:		s_serveroptions.dedicated.generic.x			= OPTIONS_X;
ADDRGP4 s_serveroptions+548+12
CNSTI4 456
ASGNI4
line 1306
;1306:		s_serveroptions.dedicated.generic.y			= y;
ADDRGP4 s_serveroptions+548+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1307
;1307:		s_serveroptions.dedicated.generic.name		= "Dedicated:";
ADDRGP4 s_serveroptions+548+4
ADDRGP4 $1034
ASGNP4
line 1308
;1308:		s_serveroptions.dedicated.itemnames			= dedicated_list;
ADDRGP4 s_serveroptions+548+88
ADDRGP4 dedicated_list
ASGNP4
line 1309
;1309:	}
LABELV $1018
line 1311
;1310:
;1311:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $1037
line 1312
;1312:		y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1313
;1313:		s_serveroptions.hostname.generic.type       = MTYPE_FIELD;
ADDRGP4 s_serveroptions+1744
CNSTI4 4
ASGNI4
line 1314
;1314:		s_serveroptions.hostname.generic.name       = "Hostname:";
ADDRGP4 s_serveroptions+1744+4
ADDRGP4 $1043
ASGNP4
line 1315
;1315:		s_serveroptions.hostname.generic.flags      = QMF_SMALLFONT;
ADDRGP4 s_serveroptions+1744+44
CNSTU4 2
ASGNU4
line 1316
;1316:		s_serveroptions.hostname.generic.x          = OPTIONS_X;
ADDRGP4 s_serveroptions+1744+12
CNSTI4 456
ASGNI4
line 1317
;1317:		s_serveroptions.hostname.generic.y	        = y;
ADDRGP4 s_serveroptions+1744+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1318
;1318:		s_serveroptions.hostname.field.widthInChars = 18;
ADDRGP4 s_serveroptions+1744+64+8
CNSTI4 18
ASGNI4
line 1319
;1319:		s_serveroptions.hostname.field.maxchars     = 64;
ADDRGP4 s_serveroptions+1744+64+268
CNSTI4 64
ASGNI4
line 1320
;1320:	}
LABELV $1037
line 1322
;1321:
;1322:	y += BIGCHAR_HEIGHT+2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 1323
;1323:	s_serveroptions.punkbuster.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+6372
CNSTI4 3
ASGNI4
line 1324
;1324:	s_serveroptions.punkbuster.generic.name			= "Punkbuster:";
ADDRGP4 s_serveroptions+6372+4
ADDRGP4 $1059
ASGNP4
line 1325
;1325:	s_serveroptions.punkbuster.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+6372+44
CNSTU4 258
ASGNU4
line 1326
;1326:	s_serveroptions.punkbuster.generic.id			= 0;
ADDRGP4 s_serveroptions+6372+8
CNSTI4 0
ASGNI4
line 1327
;1327:	s_serveroptions.punkbuster.generic.x				= OPTIONS_X;
ADDRGP4 s_serveroptions+6372+12
CNSTI4 456
ASGNI4
line 1328
;1328:	s_serveroptions.punkbuster.generic.y				= y;
ADDRGP4 s_serveroptions+6372+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1329
;1329:	s_serveroptions.punkbuster.itemnames				= punkbuster_items;
ADDRGP4 s_serveroptions+6372+88
ADDRGP4 punkbuster_items
ASGNP4
line 1331
;1330:	
;1331:	y = 80;
ADDRLP4 4
CNSTI4 80
ASGNI4
line 1332
;1332:	s_serveroptions.botSkill.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 s_serveroptions+2152
CNSTI4 3
ASGNI4
line 1333
;1333:	s_serveroptions.botSkill.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2152+44
CNSTU4 258
ASGNU4
line 1334
;1334:	s_serveroptions.botSkill.generic.name			= "Bot Skill:  ";//GUNNM: are those extra spaces usefull?
ADDRGP4 s_serveroptions+2152+4
ADDRGP4 $1075
ASGNP4
line 1335
;1335:	s_serveroptions.botSkill.generic.x				= 32 + (strlen(s_serveroptions.botSkill.generic.name) + 2 ) * SMALLCHAR_WIDTH;
ADDRGP4 s_serveroptions+2152+4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 s_serveroptions+2152+12
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 16
ADDI4
CNSTI4 32
ADDI4
ASGNI4
line 1336
;1336:	s_serveroptions.botSkill.generic.y				= y;
ADDRGP4 s_serveroptions+2152+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1337
;1337:	s_serveroptions.botSkill.itemnames				= botSkill_list;
ADDRGP4 s_serveroptions+2152+88
ADDRGP4 botSkill_list
ASGNP4
line 1338
;1338:	s_serveroptions.botSkill.curvalue				= 1;
ADDRGP4 s_serveroptions+2152+68
CNSTI4 1
ASGNI4
line 1340
;1339:
;1340:	y += ( 2 * SMALLCHAR_HEIGHT );
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 1341
;1341:	s_serveroptions.player0.generic.type			= MTYPE_TEXT;
ADDRGP4 s_serveroptions+2260
CNSTI4 7
ASGNI4
line 1342
;1342:	s_serveroptions.player0.generic.flags			= QMF_SMALLFONT;
ADDRGP4 s_serveroptions+2260+44
CNSTU4 2
ASGNU4
line 1343
;1343:	s_serveroptions.player0.generic.x				= 32 + SMALLCHAR_WIDTH;
ADDRGP4 s_serveroptions+2260+12
CNSTI4 40
ASGNI4
line 1344
;1344:	s_serveroptions.player0.generic.y				= y;
ADDRGP4 s_serveroptions+2260+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1345
;1345:	s_serveroptions.player0.color					= color_orange;
ADDRGP4 s_serveroptions+2260+72
ADDRGP4 color_orange
ASGNP4
line 1346
;1346:	s_serveroptions.player0.style					= UI_LEFT|UI_SMALLFONT;
ADDRGP4 s_serveroptions+2260+68
CNSTI4 16
ASGNI4
line 1348
;1347:
;1348:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1097
line 1349
;1349:		s_serveroptions.playerType[n].generic.type		= MTYPE_SPINCONTROL;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336
ADDP4
CNSTI4 3
ASGNI4
line 1350
;1350:		s_serveroptions.playerType[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+44
ADDP4
CNSTU4 2
ASGNU4
line 1351
;1351:		s_serveroptions.playerType[n].generic.id		= ID_PLAYER_TYPE;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+8
ADDP4
CNSTI4 20
ASGNI4
line 1352
;1352:		s_serveroptions.playerType[n].generic.callback	= ServerOptions_Event;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+48
ADDP4
ADDRGP4 ServerOptions_Event
ASGNP4
line 1353
;1353:		s_serveroptions.playerType[n].generic.x			= 32;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+12
ADDP4
CNSTI4 32
ASGNI4
line 1354
;1354:		s_serveroptions.playerType[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1355
;1355:		s_serveroptions.playerType[n].itemnames			= playerType_list;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336+88
ADDP4
ADDRGP4 playerType_list
ASGNP4
line 1357
;1356:
;1357:		s_serveroptions.playerName[n].generic.type		= MTYPE_TEXT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632
ADDP4
CNSTI4 7
ASGNI4
line 1358
;1358:		s_serveroptions.playerName[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+44
ADDP4
CNSTU4 2
ASGNU4
line 1359
;1359:		s_serveroptions.playerName[n].generic.x			= 96;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+12
ADDP4
CNSTI4 96
ASGNI4
line 1360
;1360:		s_serveroptions.playerName[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1361
;1361:		s_serveroptions.playerName[n].generic.callback	= ServerOptions_PlayerNameEvent;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+48
ADDP4
ADDRGP4 ServerOptions_PlayerNameEvent
ASGNP4
line 1362
;1362:		s_serveroptions.playerName[n].generic.id		= n;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1363
;1363:		s_serveroptions.playerName[n].generic.ownerdraw	= PlayerName_Draw;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+56
ADDP4
ADDRGP4 PlayerName_Draw
ASGNP4
line 1364
;1364:		s_serveroptions.playerName[n].color				= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 1365
;1365:		s_serveroptions.playerName[n].style				= UI_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+68
ADDP4
CNSTI4 16
ASGNI4
line 1366
;1366:		s_serveroptions.playerName[n].string			= s_serveroptions.playerNameBuffers[n];
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+64
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 s_serveroptions+6156
ADDP4
ASGNP4
line 1367
;1367:		s_serveroptions.playerName[n].generic.top		= s_serveroptions.playerName[n].generic.y;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+24
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+16
ADDP4
INDIRI4
ASGNI4
line 1368
;1368:		s_serveroptions.playerName[n].generic.bottom	= s_serveroptions.playerName[n].generic.y + SMALLCHAR_HEIGHT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+32
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+16
ADDP4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1369
;1369:		s_serveroptions.playerName[n].generic.left		= s_serveroptions.playerName[n].generic.x - SMALLCHAR_HEIGHT/ 2;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+20
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+12
ADDP4
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1370
;1370:		s_serveroptions.playerName[n].generic.right		= s_serveroptions.playerName[n].generic.x + 16 * SMALLCHAR_WIDTH;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+28
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632+12
ADDP4
INDIRI4
CNSTI4 128
ADDI4
ASGNI4
line 1372
;1371:
;1372:		s_serveroptions.playerTeam[n].generic.type		= MTYPE_SPINCONTROL;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544
ADDP4
CNSTI4 3
ASGNI4
line 1373
;1373:		s_serveroptions.playerTeam[n].generic.flags		= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+44
ADDP4
CNSTU4 2
ASGNU4
line 1374
;1374:		s_serveroptions.playerTeam[n].generic.x			= 240;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+12
ADDP4
CNSTI4 240
ASGNI4
line 1375
;1375:		s_serveroptions.playerTeam[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1376
;1376:		s_serveroptions.playerTeam[n].itemnames			= playerTeam_list;
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544+88
ADDP4
ADDRGP4 playerTeam_list
ASGNP4
line 1378
;1377:
;1378:		y += ( SMALLCHAR_HEIGHT + 4 );
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 1379
;1379:	}
LABELV $1098
line 1348
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1097
line 1381
;1380:
;1381:	s_serveroptions.back.generic.type	  = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+6024
CNSTI4 6
ASGNI4
line 1382
;1382:	s_serveroptions.back.generic.name     = GAMESERVER_BACK0;
ADDRGP4 s_serveroptions+6024+4
ADDRGP4 $400
ASGNP4
line 1383
;1383:	s_serveroptions.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serveroptions+6024+44
CNSTU4 260
ASGNU4
line 1384
;1384:	s_serveroptions.back.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+6024+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 1385
;1385:	s_serveroptions.back.generic.id	      = ID_BACK;
ADDRGP4 s_serveroptions+6024+8
CNSTI4 24
ASGNI4
line 1386
;1386:	s_serveroptions.back.generic.x		  = 0;
ADDRGP4 s_serveroptions+6024+12
CNSTI4 0
ASGNI4
line 1387
;1387:	s_serveroptions.back.generic.y		  = 480-64;
ADDRGP4 s_serveroptions+6024+16
CNSTI4 416
ASGNI4
line 1388
;1388:	s_serveroptions.back.width  		  = 128;
ADDRGP4 s_serveroptions+6024+80
CNSTI4 128
ASGNI4
line 1389
;1389:	s_serveroptions.back.height  		  = 64;
ADDRGP4 s_serveroptions+6024+84
CNSTI4 64
ASGNI4
line 1390
;1390:	s_serveroptions.back.focuspic         = GAMESERVER_BACK1;
ADDRGP4 s_serveroptions+6024+64
ADDRGP4 $417
ASGNP4
line 1392
;1391:
;1392:	s_serveroptions.next.generic.type	  = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+5932
CNSTI4 6
ASGNI4
line 1393
;1393:	s_serveroptions.next.generic.name     = GAMESERVER_NEXT0;
ADDRGP4 s_serveroptions+5932+4
ADDRGP4 $421
ASGNP4
line 1394
;1394:	s_serveroptions.next.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_INACTIVE|QMF_GRAYED|QMF_HIDDEN;
ADDRGP4 s_serveroptions+5932+44
CNSTU4 28944
ASGNU4
line 1395
;1395:	s_serveroptions.next.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+5932+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 1396
;1396:	s_serveroptions.next.generic.id	      = ID_STARTSERVERNEXT;
ADDRGP4 s_serveroptions+5932+8
CNSTI4 18
ASGNI4
line 1397
;1397:	s_serveroptions.next.generic.x		  = 640;
ADDRGP4 s_serveroptions+5932+12
CNSTI4 640
ASGNI4
line 1398
;1398:	s_serveroptions.next.generic.y		  = 480-64-72;
ADDRGP4 s_serveroptions+5932+16
CNSTI4 344
ASGNI4
line 1399
;1399:	s_serveroptions.next.generic.statusbar  = ServerOptions_StatusBar;
ADDRGP4 s_serveroptions+5932+52
ADDRGP4 ServerOptions_StatusBar
ASGNP4
line 1400
;1400:	s_serveroptions.next.width  		  = 128;
ADDRGP4 s_serveroptions+5932+80
CNSTI4 128
ASGNI4
line 1401
;1401:	s_serveroptions.next.height  		  = 64;
ADDRGP4 s_serveroptions+5932+84
CNSTI4 64
ASGNI4
line 1402
;1402:	s_serveroptions.next.focuspic         = GAMESERVER_NEXT1;
ADDRGP4 s_serveroptions+5932+64
ADDRGP4 $438
ASGNP4
line 1404
;1403:
;1404:	s_serveroptions.go.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_serveroptions+5840
CNSTI4 6
ASGNI4
line 1405
;1405:	s_serveroptions.go.generic.name     = GAMESERVER_FIGHT0;
ADDRGP4 s_serveroptions+5840+4
ADDRGP4 $1202
ASGNP4
line 1406
;1406:	s_serveroptions.go.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_serveroptions+5840+44
CNSTU4 272
ASGNU4
line 1407
;1407:	s_serveroptions.go.generic.callback = ServerOptions_Event;
ADDRGP4 s_serveroptions+5840+48
ADDRGP4 ServerOptions_Event
ASGNP4
line 1408
;1408:	s_serveroptions.go.generic.id	    = ID_GO;
ADDRGP4 s_serveroptions+5840+8
CNSTI4 23
ASGNI4
line 1409
;1409:	s_serveroptions.go.generic.x		= 640;
ADDRGP4 s_serveroptions+5840+12
CNSTI4 640
ASGNI4
line 1410
;1410:	s_serveroptions.go.generic.y		= 480-64;
ADDRGP4 s_serveroptions+5840+16
CNSTI4 416
ASGNI4
line 1411
;1411:	s_serveroptions.go.width  		    = 128;
ADDRGP4 s_serveroptions+5840+80
CNSTI4 128
ASGNI4
line 1412
;1412:	s_serveroptions.go.height  		    = 64;
ADDRGP4 s_serveroptions+5840+84
CNSTI4 64
ASGNI4
line 1413
;1413:	s_serveroptions.go.focuspic         = GAMESERVER_FIGHT1;
ADDRGP4 s_serveroptions+5840+64
ADDRGP4 $1219
ASGNP4
line 1415
;1414:
;1415:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.banner );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1417
;1416:
;1417:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.mappic );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+364
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1418
;1418:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.picframe );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+456
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1420
;1419:
;1420:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.botSkill );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2152
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1421
;1421:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.player0 );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2260
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1422
;1422:	for( n = 0; n < PLAYER_SLOTS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1225
line 1423
;1423:		if( n != 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1229
line 1424
;1424:			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerType[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+2336
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1425
;1425:		}
LABELV $1229
line 1426
;1426:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerName[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 s_serveroptions+3632
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1427
;1427:		if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $1233
line 1428
;1428:			Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.playerTeam[n] );
ADDRGP4 s_serveroptions
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 108
MULI4
ADDRGP4 s_serveroptions+4544
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1429
;1429:		}
LABELV $1233
line 1430
;1430:	}
LABELV $1226
line 1422
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $1225
line 1432
;1431:
;1432:	if( s_serveroptions.gametype != GT_CTF ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 4
EQI4 $1237
line 1433
;1433:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.fraglimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+996
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1434
;1434:	}
ADDRGP4 $1238
JUMPV
LABELV $1237
line 1435
;1435:	else {
line 1436
;1436:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.flaglimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1336
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1437
;1437:	}
LABELV $1238
line 1438
;1438:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.timelimit );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+656
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1439
;1439:	if( s_serveroptions.gametype >= GT_TEAM ) {
ADDRGP4 s_serveroptions+6120
INDIRI4
CNSTI4 3
LTI4 $1243
line 1440
;1440:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.friendlyfire );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1676
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1441
;1441:	}
LABELV $1243
line 1442
;1442:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.pure );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+2084
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1443
;1443:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $1248
line 1444
;1444:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.dedicated );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+548
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1445
;1445:	}
LABELV $1248
line 1446
;1446:	if( s_serveroptions.multiplayer ) {
ADDRGP4 s_serveroptions+6116
INDIRI4
CNSTI4 0
EQI4 $1252
line 1447
;1447:		Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.hostname );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+1744
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1448
;1448:	}
LABELV $1252
line 1450
;1449:
;1450:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.back );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+6024
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1451
;1451:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.next );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+5932
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1452
;1452:	Menu_AddItem( &s_serveroptions.menu, &s_serveroptions.go );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+5840
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1454
;1453:
;1454:	Menu_AddItem( &s_serveroptions.menu, (void*) &s_serveroptions.punkbuster );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 s_serveroptions+6372
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1456
;1455:	
;1456:	ServerOptions_SetMenuItems();
ADDRGP4 ServerOptions_SetMenuItems
CALLV
pop
line 1457
;1457:}
LABELV $892
endproc ServerOptions_MenuInit 52 12
export ServerOptions_Cache
proc ServerOptions_Cache 0 4
line 1464
;1458:
;1459:/*
;1460:=================
;1461:ServerOptions_Cache
;1462:=================
;1463:*/
;1464:void ServerOptions_Cache( void ) {
line 1465
;1465:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK0 );
ADDRGP4 $400
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1466
;1466:	trap_R_RegisterShaderNoMip( GAMESERVER_BACK1 );
ADDRGP4 $417
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1467
;1467:	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT0 );
ADDRGP4 $1202
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1468
;1468:	trap_R_RegisterShaderNoMip( GAMESERVER_FIGHT1 );
ADDRGP4 $1219
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1469
;1469:	trap_R_RegisterShaderNoMip( GAMESERVER_SELECT );
ADDRGP4 $333
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1470
;1470:	trap_R_RegisterShaderNoMip( GAMESERVER_UNKNOWNMAP );
ADDRGP4 $305
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1471
;1471:}
LABELV $1260
endproc ServerOptions_Cache 0 4
proc UI_ServerOptionsMenu 0 4
line 1479
;1472:
;1473:
;1474:/*
;1475:=================
;1476:UI_ServerOptionsMenu
;1477:=================
;1478:*/
;1479:static void UI_ServerOptionsMenu( qboolean multiplayer ) {
line 1480
;1480:	ServerOptions_MenuInit( multiplayer );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ServerOptions_MenuInit
CALLV
pop
line 1481
;1481:	UI_PushMenu( &s_serveroptions.menu );
ADDRGP4 s_serveroptions
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 1482
;1482:}
LABELV $1261
endproc UI_ServerOptionsMenu 0 4
proc UI_BotSelectMenu_SortCompare 44 8
line 1543
;1483:
;1484:
;1485:
;1486:/*
;1487:=============================================================================
;1488:
;1489:BOT SELECT MENU *****
;1490:
;1491:=============================================================================
;1492:*/
;1493:
;1494:
;1495:#define BOTSELECT_BACK0			"menu/art/back_0"
;1496:#define BOTSELECT_BACK1			"menu/art/back_1"
;1497:#define BOTSELECT_ACCEPT0		"menu/art/accept_0"
;1498:#define BOTSELECT_ACCEPT1		"menu/art/accept_1"
;1499:#define BOTSELECT_SELECT		"menu/art/opponents_select"
;1500:#define BOTSELECT_SELECTED		"menu/art/opponents_selected"
;1501:#define BOTSELECT_ARROWS		"menu/art/gs_arrows_0"
;1502:#define BOTSELECT_ARROWSL		"menu/art/gs_arrows_l"
;1503:#define BOTSELECT_ARROWSR		"menu/art/gs_arrows_r"
;1504:
;1505:#define PLAYERGRID_COLS			4
;1506:#define PLAYERGRID_ROWS			4
;1507:#define MAX_MODELSPERPAGE		(PLAYERGRID_ROWS * PLAYERGRID_COLS)
;1508:
;1509:
;1510:typedef struct {
;1511:	menuframework_s	menu;
;1512:
;1513:	menutext_s		banner;
;1514:
;1515:	menubitmap_s	pics[MAX_MODELSPERPAGE];
;1516:	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
;1517:	menutext_s		picnames[MAX_MODELSPERPAGE];
;1518:
;1519:	menubitmap_s	arrows;
;1520:	menubitmap_s	left;
;1521:	menubitmap_s	right;
;1522:
;1523:	menubitmap_s	go;
;1524:	menubitmap_s	back;
;1525:
;1526:	int				numBots;
;1527:	int				modelpage;
;1528:	int				numpages;
;1529:	int				selectedmodel;
;1530:	int				sortedBotNums[MAX_BOTS];
;1531:	char			boticons[MAX_MODELSPERPAGE][MAX_QPATH];
;1532:	char			botnames[MAX_MODELSPERPAGE][16];
;1533:} botSelectInfo_t;
;1534:
;1535:static botSelectInfo_t	botSelectInfo;
;1536:
;1537:
;1538:/*
;1539:=================
;1540:UI_BotSelectMenu_SortCompare
;1541:=================
;1542:*/
;1543:static int QDECL UI_BotSelectMenu_SortCompare( const void *arg1, const void *arg2 ) {
line 1548
;1544:	int			num1, num2;
;1545:	const char	*info1, *info2;
;1546:	const char	*name1, *name2;
;1547:
;1548:	num1 = *(int *)arg1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1549
;1549:	num2 = *(int *)arg2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 1551
;1550:
;1551:	info1 = UI_GetBotInfoByNumber( num1 );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 1552
;1552:	info2 = UI_GetBotInfoByNumber( num2 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
ASGNP4
line 1554
;1553:
;1554:	name1 = Info_ValueForKey( info1, "name" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 1555
;1555:	name2 = Info_ValueForKey( info2, "name" );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 1557
;1556:
;1557:	return Q_stricmp( name1, name2 );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
LABELV $1263
endproc UI_BotSelectMenu_SortCompare 44 8
proc UI_BotSelectMenu_BuildList 12 16
line 1566
;1558:}
;1559:
;1560:
;1561:/*
;1562:=================
;1563:UI_BotSelectMenu_BuildList
;1564:=================
;1565:*/
;1566:static void UI_BotSelectMenu_BuildList( void ) {
line 1569
;1567:	int		n;
;1568:
;1569:	botSelectInfo.modelpage = 0;
ADDRGP4 botSelectInfo+4988
CNSTI4 0
ASGNI4
line 1570
;1570:	botSelectInfo.numBots = UI_GetNumBots();
ADDRLP4 4
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRGP4 botSelectInfo+4984
ADDRLP4 4
INDIRI4
ASGNI4
line 1571
;1571:	botSelectInfo.numpages = botSelectInfo.numBots / MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4992
ADDRGP4 botSelectInfo+4984
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 1572
;1572:	if( botSelectInfo.numBots % MAX_MODELSPERPAGE ) {
ADDRGP4 botSelectInfo+4984
INDIRI4
CNSTI4 16
MODI4
CNSTI4 0
EQI4 $1269
line 1573
;1573:		botSelectInfo.numpages++;
ADDRLP4 8
ADDRGP4 botSelectInfo+4992
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1574
;1574:	}
LABELV $1269
line 1577
;1575:
;1576:	// initialize the array
;1577:	for( n = 0; n < botSelectInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1276
JUMPV
LABELV $1273
line 1578
;1578:		botSelectInfo.sortedBotNums[n] = n;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+5000
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1579
;1579:	}
LABELV $1274
line 1577
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1276
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
LTI4 $1273
line 1582
;1580:
;1581:	// now sort it
;1582:	qsort( botSelectInfo.sortedBotNums, botSelectInfo.numBots, sizeof(botSelectInfo.sortedBotNums[0]), UI_BotSelectMenu_SortCompare );
ADDRGP4 botSelectInfo+5000
ARGP4
ADDRGP4 botSelectInfo+4984
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_BotSelectMenu_SortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1583
;1583:}
LABELV $1264
endproc UI_BotSelectMenu_BuildList 12 16
proc ServerPlayerIcon 80 20
line 1591
;1584:
;1585:
;1586:/*
;1587:=================
;1588:ServerPlayerIcon
;1589:=================
;1590:*/
;1591:static void ServerPlayerIcon( const char *modelAndSkin, char *iconName, int iconNameMaxSize ) {
line 1595
;1592:	char	*skin;
;1593:	char	model[MAX_QPATH];
;1594:
;1595:	Q_strncpyz( model, modelAndSkin, sizeof(model));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1596
;1596:	skin = Q_strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 1597
;1597:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1283
line 1598
;1598:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 1599
;1599:	}
ADDRGP4 $1284
JUMPV
LABELV $1283
line 1600
;1600:	else {
line 1601
;1601:		skin = "default";
ADDRLP4 0
ADDRGP4 $1285
ASGNP4
line 1602
;1602:	}
LABELV $1284
line 1604
;1603:
;1604:	Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_%s.tga", model, skin );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1286
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1606
;1605:
;1606:	if( !trap_R_RegisterShaderNoMip( iconName ) && Q_stricmp( skin, "default" ) != 0 ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $1287
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1285
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1287
line 1607
;1607:		Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_default.tga", model );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $1289
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1608
;1608:	}
LABELV $1287
line 1609
;1609:}
LABELV $1282
endproc ServerPlayerIcon 80 20
proc UI_BotSelectMenu_UpdateGrid 36 12
line 1617
;1610:
;1611:
;1612:/*
;1613:=================
;1614:UI_BotSelectMenu_UpdateGrid
;1615:=================
;1616:*/
;1617:static void UI_BotSelectMenu_UpdateGrid( void ) {
line 1622
;1618:	const char	*info;
;1619:	int			i;
;1620:    int			j;
;1621:
;1622:	j = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRLP4 4
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1623
;1623:	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++, j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1292
line 1624
;1624:		if( j < botSelectInfo.numBots ) { 
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
GEI4 $1296
line 1625
;1625:			info = UI_GetBotInfoByNumber( botSelectInfo.sortedBotNums[j] );
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+5000
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 1626
;1626:			ServerPlayerIcon( Info_ValueForKey( info, "model" ), botSelectInfo.boticons[i], MAX_QPATH );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $1300
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9096
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 ServerPlayerIcon
CALLV
pop
line 1627
;1627:			Q_strncpyz( botSelectInfo.botnames[i], Info_ValueForKey( info, "name" ), 16 );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1628
;1628:			Q_CleanStr( botSelectInfo.botnames[i] );
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1629
;1629: 			botSelectInfo.pics[i].generic.name = botSelectInfo.boticons[i];
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9096
ADDP4
ASGNP4
line 1630
;1630:			if( BotAlreadySelected( botSelectInfo.botnames[i] ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 BotAlreadySelected
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1307
line 1631
;1631:				botSelectInfo.picnames[i].color = color_red;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+72
ADDP4
ADDRGP4 color_red
ASGNP4
line 1632
;1632:			}
ADDRGP4 $1308
JUMPV
LABELV $1307
line 1633
;1633:			else {
line 1634
;1634:				botSelectInfo.picnames[i].color = color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 1635
;1635:			}
LABELV $1308
line 1636
;1636:			botSelectInfo.picbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 1637
;1637:		}
ADDRGP4 $1297
JUMPV
LABELV $1296
line 1638
;1638:		else {
line 1640
;1639:			// dead slot
;1640: 			botSelectInfo.pics[i].generic.name         = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+4
ADDP4
CNSTP4 0
ASGNP4
line 1641
;1641:			botSelectInfo.picbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1642
;1642:			botSelectInfo.botnames[i][0] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
CNSTI1 0
ASGNI1
line 1643
;1643:		}
LABELV $1297
line 1645
;1644:
;1645: 		botSelectInfo.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 1646
;1646: 		botSelectInfo.pics[i].shader               = 0;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+72
ADDP4
CNSTI4 0
ASGNI4
line 1647
;1647: 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 1648
;1648:	}
LABELV $1293
line 1623
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1292
line 1651
;1649:
;1650:	// set selected model
;1651:	i = botSelectInfo.selectedmodel % MAX_MODELSPERPAGE;
ADDRLP4 0
ADDRGP4 botSelectInfo+4996
INDIRI4
CNSTI4 16
MODI4
ASGNI4
line 1652
;1652:	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 1653
;1653:	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 1655
;1654:
;1655:	if( botSelectInfo.numpages > 1 ) {
ADDRGP4 botSelectInfo+4992
INDIRI4
CNSTI4 1
LEI4 $1332
line 1656
;1656:		if( botSelectInfo.modelpage > 0 ) {
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 0
LEI4 $1335
line 1657
;1657:			botSelectInfo.left.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4616+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 1658
;1658:		}
ADDRGP4 $1336
JUMPV
LABELV $1335
line 1659
;1659:		else {
line 1660
;1660:			botSelectInfo.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4616+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1661
;1661:		}
LABELV $1336
line 1663
;1662:
;1663:		if( botSelectInfo.modelpage < (botSelectInfo.numpages - 1) ) {
ADDRGP4 botSelectInfo+4988
INDIRI4
ADDRGP4 botSelectInfo+4992
INDIRI4
CNSTI4 1
SUBI4
GEI4 $1342
line 1664
;1664:			botSelectInfo.right.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4708+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 1665
;1665:		}
ADDRGP4 $1333
JUMPV
LABELV $1342
line 1666
;1666:		else {
line 1667
;1667:			botSelectInfo.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4708+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1668
;1668:		}
line 1669
;1669:	}
ADDRGP4 $1333
JUMPV
LABELV $1332
line 1670
;1670:	else {
line 1672
;1671:		// hide left/right markers
;1672:		botSelectInfo.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 botSelectInfo+4616+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1673
;1673:		botSelectInfo.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 24
ADDRGP4 botSelectInfo+4708+44
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 1674
;1674:	}
LABELV $1333
line 1675
;1675:}
LABELV $1290
endproc UI_BotSelectMenu_UpdateGrid 36 12
proc UI_BotSelectMenu_Default 28 8
line 1683
;1676:
;1677:
;1678:/*
;1679:=================
;1680:UI_BotSelectMenu_Default
;1681:=================
;1682:*/
;1683:static void UI_BotSelectMenu_Default( char *bot ) {
line 1689
;1684:	const char	*botInfo;
;1685:	const char	*test;
;1686:	int			n;
;1687:	int			i;
;1688:
;1689:	for( n = 0; n < botSelectInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1358
JUMPV
LABELV $1355
line 1690
;1690:		botInfo = UI_GetBotInfoByNumber( n );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1691
;1691:		test = Info_ValueForKey( botInfo, "name" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 1692
;1692:		if( Q_stricmp( bot, test ) == 0 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $1360
line 1693
;1693:			break;
ADDRGP4 $1357
JUMPV
LABELV $1360
line 1695
;1694:		}
;1695:	}
LABELV $1356
line 1689
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1358
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
LTI4 $1355
LABELV $1357
line 1696
;1696:	if( n == botSelectInfo.numBots ) {
ADDRLP4 0
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
NEI4 $1362
line 1697
;1697:		botSelectInfo.selectedmodel = 0;
ADDRGP4 botSelectInfo+4996
CNSTI4 0
ASGNI4
line 1698
;1698:		return;
ADDRGP4 $1354
JUMPV
LABELV $1362
line 1701
;1699:	}
;1700:
;1701:	for( i = 0; i < botSelectInfo.numBots; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1369
JUMPV
LABELV $1366
line 1702
;1702:		if( botSelectInfo.sortedBotNums[i] == n ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botSelectInfo+5000
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1371
line 1703
;1703:			break;
ADDRGP4 $1368
JUMPV
LABELV $1371
line 1705
;1704:		}
;1705:	}
LABELV $1367
line 1701
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1369
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
LTI4 $1366
LABELV $1368
line 1706
;1706:	if( i == botSelectInfo.numBots ) {
ADDRLP4 4
INDIRI4
ADDRGP4 botSelectInfo+4984
INDIRI4
NEI4 $1374
line 1707
;1707:		botSelectInfo.selectedmodel = 0;
ADDRGP4 botSelectInfo+4996
CNSTI4 0
ASGNI4
line 1708
;1708:		return;
ADDRGP4 $1354
JUMPV
LABELV $1374
line 1711
;1709:	}
;1710:
;1711:	botSelectInfo.selectedmodel = i;
ADDRGP4 botSelectInfo+4996
ADDRLP4 4
INDIRI4
ASGNI4
line 1712
;1712:}
LABELV $1354
endproc UI_BotSelectMenu_Default 28 8
proc UI_BotSelectMenu_LeftEvent 4 0
line 1720
;1713:
;1714:
;1715:/*
;1716:=================
;1717:UI_BotSelectMenu_LeftEvent
;1718:=================
;1719:*/
;1720:static void UI_BotSelectMenu_LeftEvent( void* ptr, int event ) {
line 1721
;1721:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1380
line 1722
;1722:		return;
ADDRGP4 $1379
JUMPV
LABELV $1380
line 1724
;1723:	}
;1724:	if( botSelectInfo.modelpage > 0 ) {
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 0
LEI4 $1382
line 1725
;1725:		botSelectInfo.modelpage--;
ADDRLP4 0
ADDRGP4 botSelectInfo+4988
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1726
;1726:		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4996
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1727
;1727:		UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 1728
;1728:	}
LABELV $1382
line 1729
;1729:}
LABELV $1379
endproc UI_BotSelectMenu_LeftEvent 4 0
proc UI_BotSelectMenu_RightEvent 4 0
line 1737
;1730:
;1731:
;1732:/*
;1733:=================
;1734:UI_BotSelectMenu_RightEvent
;1735:=================
;1736:*/
;1737:static void UI_BotSelectMenu_RightEvent( void* ptr, int event ) {
line 1738
;1738:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1389
line 1739
;1739:		return;
ADDRGP4 $1388
JUMPV
LABELV $1389
line 1741
;1740:	}
;1741:	if( botSelectInfo.modelpage < botSelectInfo.numpages - 1 ) {
ADDRGP4 botSelectInfo+4988
INDIRI4
ADDRGP4 botSelectInfo+4992
INDIRI4
CNSTI4 1
SUBI4
GEI4 $1391
line 1742
;1742:		botSelectInfo.modelpage++;
ADDRLP4 0
ADDRGP4 botSelectInfo+4988
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1743
;1743:		botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4996
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1744
;1744:		UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 1745
;1745:	}
LABELV $1391
line 1746
;1746:}
LABELV $1388
endproc UI_BotSelectMenu_RightEvent 4 0
proc UI_BotSelectMenu_BotEvent 12 0
line 1754
;1747:
;1748:
;1749:/*
;1750:=================
;1751:UI_BotSelectMenu_BotEvent
;1752:=================
;1753:*/
;1754:static void UI_BotSelectMenu_BotEvent( void* ptr, int event ) {
line 1757
;1755:	int		i;
;1756:
;1757:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1399
line 1758
;1758:		return;
ADDRGP4 $1398
JUMPV
LABELV $1399
line 1761
;1759:	}
;1760:
;1761:	for( i = 0; i < (PLAYERGRID_ROWS * PLAYERGRID_COLS); i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1401
line 1762
;1762: 		botSelectInfo.pics[i].generic.flags &= ~QMF_HIGHLIGHT;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 1763
;1763: 		botSelectInfo.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 1764
;1764:	}
LABELV $1402
line 1761
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1401
line 1767
;1765:
;1766:	// set selected
;1767:	i = ((menucommon_s*)ptr)->id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1768
;1768:	botSelectInfo.pics[i].generic.flags |= QMF_HIGHLIGHT;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 1769
;1769:	botSelectInfo.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 1770
;1770:	botSelectInfo.selectedmodel = botSelectInfo.modelpage * MAX_MODELSPERPAGE + i;
ADDRGP4 botSelectInfo+4996
ADDRGP4 botSelectInfo+4988
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1771
;1771:}
LABELV $1398
endproc UI_BotSelectMenu_BotEvent 12 0
proc UI_BotSelectMenu_BackEvent 0 0
line 1779
;1772:
;1773:
;1774:/*
;1775:=================
;1776:UI_BotSelectMenu_BackEvent
;1777:=================
;1778:*/
;1779:static void UI_BotSelectMenu_BackEvent( void* ptr, int event ) {
line 1780
;1780:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1416
line 1781
;1781:		return;
ADDRGP4 $1415
JUMPV
LABELV $1416
line 1783
;1782:	}
;1783:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1784
;1784:}
LABELV $1415
endproc UI_BotSelectMenu_BackEvent 0 0
proc UI_BotSelectMenu_SelectEvent 0 12
line 1792
;1785:
;1786:
;1787:/*
;1788:=================
;1789:UI_BotSelectMenu_SelectEvent
;1790:=================
;1791:*/
;1792:static void UI_BotSelectMenu_SelectEvent( void* ptr, int event ) {
line 1793
;1793:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $1419
line 1794
;1794:		return;
ADDRGP4 $1418
JUMPV
LABELV $1419
line 1796
;1795:	}
;1796:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1798
;1797:
;1798:	s_serveroptions.newBot = qtrue;
ADDRGP4 s_serveroptions+6348
CNSTI4 1
ASGNI4
line 1799
;1799:	Q_strncpyz( s_serveroptions.newBotName, botSelectInfo.botnames[botSelectInfo.selectedmodel % MAX_MODELSPERPAGE], 16 );
ADDRGP4 s_serveroptions+6356
ARGP4
ADDRGP4 botSelectInfo+4996
INDIRI4
CNSTI4 16
MODI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1800
;1800:}
LABELV $1418
endproc UI_BotSelectMenu_SelectEvent 0 12
export UI_BotSelectMenu_Cache
proc UI_BotSelectMenu_Cache 0 4
line 1808
;1801:
;1802:
;1803:/*
;1804:=================
;1805:UI_BotSelectMenu_Cache
;1806:=================
;1807:*/
;1808:void UI_BotSelectMenu_Cache( void ) {
line 1809
;1809:	trap_R_RegisterShaderNoMip( BOTSELECT_BACK0 );
ADDRGP4 $400
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1810
;1810:	trap_R_RegisterShaderNoMip( BOTSELECT_BACK1 );
ADDRGP4 $417
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1811
;1811:	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT0 );
ADDRGP4 $1426
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1812
;1812:	trap_R_RegisterShaderNoMip( BOTSELECT_ACCEPT1 );
ADDRGP4 $1427
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1813
;1813:	trap_R_RegisterShaderNoMip( BOTSELECT_SELECT );
ADDRGP4 $1428
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1814
;1814:	trap_R_RegisterShaderNoMip( BOTSELECT_SELECTED );
ADDRGP4 $1429
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1815
;1815:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWS );
ADDRGP4 $337
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1816
;1816:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSL );
ADDRGP4 $365
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1817
;1817:	trap_R_RegisterShaderNoMip( BOTSELECT_ARROWSR );
ADDRGP4 $383
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1818
;1818:}
LABELV $1425
endproc UI_BotSelectMenu_Cache 0 4
proc UI_BotSelectMenu_Init 32 12
line 1821
;1819:
;1820:
;1821:static void UI_BotSelectMenu_Init( char *bot ) {
line 1825
;1822:	int		i, j, k;
;1823:	int		x, y;
;1824:
;1825:	memset( &botSelectInfo, 0 ,sizeof(botSelectInfo) );
ADDRGP4 botSelectInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 10376
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1826
;1826:	botSelectInfo.menu.wrapAround = qtrue;
ADDRGP4 botSelectInfo+276
CNSTI4 1
ASGNI4
line 1827
;1827:	botSelectInfo.menu.fullscreen = qtrue;
ADDRGP4 botSelectInfo+280
CNSTI4 1
ASGNI4
line 1829
;1828:
;1829:	UI_BotSelectMenu_Cache();
ADDRGP4 UI_BotSelectMenu_Cache
CALLV
pop
line 1831
;1830:
;1831:	botSelectInfo.banner.generic.type	= MTYPE_BTEXT;
ADDRGP4 botSelectInfo+288
CNSTI4 10
ASGNI4
line 1832
;1832:	botSelectInfo.banner.generic.x		= 320;
ADDRGP4 botSelectInfo+288+12
CNSTI4 320
ASGNI4
line 1833
;1833:	botSelectInfo.banner.generic.y		= 16;
ADDRGP4 botSelectInfo+288+16
CNSTI4 16
ASGNI4
line 1834
;1834:	botSelectInfo.banner.string			= "SELECT BOT";
ADDRGP4 botSelectInfo+288+64
ADDRGP4 $1440
ASGNP4
line 1835
;1835:	botSelectInfo.banner.color			= color_white;
ADDRGP4 botSelectInfo+288+72
ADDRGP4 color_white
ASGNP4
line 1836
;1836:	botSelectInfo.banner.style			= UI_CENTER;
ADDRGP4 botSelectInfo+288+68
CNSTI4 1
ASGNI4
line 1838
;1837:
;1838:	y =	80;
ADDRLP4 8
CNSTI4 80
ASGNI4
line 1839
;1839:	for( i = 0, k = 0; i < PLAYERGRID_ROWS; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1448
JUMPV
LABELV $1445
line 1840
;1840:		x =	180;
ADDRLP4 4
CNSTI4 180
ASGNI4
line 1841
;1841:		for( j = 0; j < PLAYERGRID_COLS; j++, k++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $1449
line 1842
;1842:			botSelectInfo.pics[k].generic.type				= MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364
ADDP4
CNSTI4 6
ASGNI4
line 1843
;1843:			botSelectInfo.pics[k].generic.flags				= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+44
ADDP4
CNSTU4 16388
ASGNU4
line 1844
;1844:			botSelectInfo.pics[k].generic.x					= x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1845
;1845:			botSelectInfo.pics[k].generic.y					= y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1846
;1846: 			botSelectInfo.pics[k].generic.name				= botSelectInfo.boticons[k];
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 botSelectInfo+9096
ADDP4
ASGNP4
line 1847
;1847:			botSelectInfo.pics[k].width						= 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+80
ADDP4
CNSTI4 64
ASGNI4
line 1848
;1848:			botSelectInfo.pics[k].height					= 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+84
ADDP4
CNSTI4 64
ASGNI4
line 1849
;1849:			botSelectInfo.pics[k].focuspic					= BOTSELECT_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+64
ADDP4
ADDRGP4 $1429
ASGNP4
line 1850
;1850:			botSelectInfo.pics[k].focuscolor				= colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364+88
ADDP4
ADDRGP4 colorRed
ASGNP4
line 1852
;1851:
;1852:			botSelectInfo.picbuttons[k].generic.type		= MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836
ADDP4
CNSTI4 6
ASGNI4
line 1853
;1853:			botSelectInfo.picbuttons[k].generic.flags		= QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+44
ADDP4
CNSTU4 33028
ASGNU4
line 1854
;1854:			botSelectInfo.picbuttons[k].generic.callback	= UI_BotSelectMenu_BotEvent;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+48
ADDP4
ADDRGP4 UI_BotSelectMenu_BotEvent
ASGNP4
line 1855
;1855:			botSelectInfo.picbuttons[k].generic.id			= k;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1856
;1856:			botSelectInfo.picbuttons[k].generic.x			= x - 16;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 1857
;1857:			botSelectInfo.picbuttons[k].generic.y			= y - 16;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 1858
;1858:			botSelectInfo.picbuttons[k].generic.left		= x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1859
;1859:			botSelectInfo.picbuttons[k].generic.top			= y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1860
;1860:			botSelectInfo.picbuttons[k].generic.right		= x + 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 1861
;1861:			botSelectInfo.picbuttons[k].generic.bottom		= y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 1862
;1862:			botSelectInfo.picbuttons[k].width				= 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+80
ADDP4
CNSTI4 128
ASGNI4
line 1863
;1863:			botSelectInfo.picbuttons[k].height				= 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+84
ADDP4
CNSTI4 128
ASGNI4
line 1864
;1864:			botSelectInfo.picbuttons[k].focuspic			= BOTSELECT_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+64
ADDP4
ADDRGP4 $1428
ASGNP4
line 1865
;1865:			botSelectInfo.picbuttons[k].focuscolor			= colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836+88
ADDP4
ADDRGP4 colorRed
ASGNP4
line 1867
;1866:
;1867:			botSelectInfo.picnames[k].generic.type			= MTYPE_TEXT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308
ADDP4
CNSTI4 7
ASGNI4
line 1868
;1868:			botSelectInfo.picnames[k].generic.flags			= QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+44
ADDP4
CNSTU4 2
ASGNU4
line 1869
;1869:			botSelectInfo.picnames[k].generic.x				= x + 32;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 1870
;1870:			botSelectInfo.picnames[k].generic.y				= y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 1871
;1871:			botSelectInfo.picnames[k].string				= botSelectInfo.botnames[k];
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+64
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 botSelectInfo+10120
ADDP4
ASGNP4
line 1872
;1872:			botSelectInfo.picnames[k].color					= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 1873
;1873:			botSelectInfo.picnames[k].style					= UI_CENTER|UI_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308+68
ADDP4
CNSTI4 17
ASGNI4
line 1875
;1874:
;1875:			x += (64 + 6);
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 1876
;1876:		}
LABELV $1450
line 1841
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4
LTI4 $1449
line 1877
;1877:		y += (64 + SMALLCHAR_HEIGHT + 6);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 86
ADDI4
ASGNI4
line 1878
;1878:	}
LABELV $1446
line 1839
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1448
ADDRLP4 16
INDIRI4
CNSTI4 4
LTI4 $1445
line 1880
;1879:
;1880:	botSelectInfo.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4524
CNSTI4 6
ASGNI4
line 1881
;1881:	botSelectInfo.arrows.generic.name		= BOTSELECT_ARROWS;
ADDRGP4 botSelectInfo+4524+4
ADDRGP4 $337
ASGNP4
line 1882
;1882:	botSelectInfo.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 botSelectInfo+4524+44
CNSTU4 16384
ASGNU4
line 1883
;1883:	botSelectInfo.arrows.generic.x			= 260;
ADDRGP4 botSelectInfo+4524+12
CNSTI4 260
ASGNI4
line 1884
;1884:	botSelectInfo.arrows.generic.y			= 440;
ADDRGP4 botSelectInfo+4524+16
CNSTI4 440
ASGNI4
line 1885
;1885:	botSelectInfo.arrows.width				= 128;
ADDRGP4 botSelectInfo+4524+80
CNSTI4 128
ASGNI4
line 1886
;1886:	botSelectInfo.arrows.height				= 32;
ADDRGP4 botSelectInfo+4524+84
CNSTI4 32
ASGNI4
line 1888
;1887:
;1888:	botSelectInfo.left.generic.type			= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4616
CNSTI4 6
ASGNI4
line 1889
;1889:	botSelectInfo.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4616+44
CNSTU4 260
ASGNU4
line 1890
;1890:	botSelectInfo.left.generic.callback		= UI_BotSelectMenu_LeftEvent;
ADDRGP4 botSelectInfo+4616+48
ADDRGP4 UI_BotSelectMenu_LeftEvent
ASGNP4
line 1891
;1891:	botSelectInfo.left.generic.x			= 260;
ADDRGP4 botSelectInfo+4616+12
CNSTI4 260
ASGNI4
line 1892
;1892:	botSelectInfo.left.generic.y			= 440;
ADDRGP4 botSelectInfo+4616+16
CNSTI4 440
ASGNI4
line 1893
;1893:	botSelectInfo.left.width  				= 64;
ADDRGP4 botSelectInfo+4616+80
CNSTI4 64
ASGNI4
line 1894
;1894:	botSelectInfo.left.height  				= 32;
ADDRGP4 botSelectInfo+4616+84
CNSTI4 32
ASGNI4
line 1895
;1895:	botSelectInfo.left.focuspic				= BOTSELECT_ARROWSL;
ADDRGP4 botSelectInfo+4616+64
ADDRGP4 $365
ASGNP4
line 1897
;1896:
;1897:	botSelectInfo.right.generic.type	    = MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4708
CNSTI4 6
ASGNI4
line 1898
;1898:	botSelectInfo.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4708+44
CNSTU4 260
ASGNU4
line 1899
;1899:	botSelectInfo.right.generic.callback	= UI_BotSelectMenu_RightEvent;
ADDRGP4 botSelectInfo+4708+48
ADDRGP4 UI_BotSelectMenu_RightEvent
ASGNP4
line 1900
;1900:	botSelectInfo.right.generic.x			= 321;
ADDRGP4 botSelectInfo+4708+12
CNSTI4 321
ASGNI4
line 1901
;1901:	botSelectInfo.right.generic.y			= 440;
ADDRGP4 botSelectInfo+4708+16
CNSTI4 440
ASGNI4
line 1902
;1902:	botSelectInfo.right.width  				= 64;
ADDRGP4 botSelectInfo+4708+80
CNSTI4 64
ASGNI4
line 1903
;1903:	botSelectInfo.right.height  		    = 32;
ADDRGP4 botSelectInfo+4708+84
CNSTI4 32
ASGNI4
line 1904
;1904:	botSelectInfo.right.focuspic			= BOTSELECT_ARROWSR;
ADDRGP4 botSelectInfo+4708+64
ADDRGP4 $383
ASGNP4
line 1906
;1905:
;1906:	botSelectInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4892
CNSTI4 6
ASGNI4
line 1907
;1907:	botSelectInfo.back.generic.name		= BOTSELECT_BACK0;
ADDRGP4 botSelectInfo+4892+4
ADDRGP4 $400
ASGNP4
line 1908
;1908:	botSelectInfo.back.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4892+44
CNSTU4 260
ASGNU4
line 1909
;1909:	botSelectInfo.back.generic.callback	= UI_BotSelectMenu_BackEvent;
ADDRGP4 botSelectInfo+4892+48
ADDRGP4 UI_BotSelectMenu_BackEvent
ASGNP4
line 1910
;1910:	botSelectInfo.back.generic.x		= 0;
ADDRGP4 botSelectInfo+4892+12
CNSTI4 0
ASGNI4
line 1911
;1911:	botSelectInfo.back.generic.y		= 480-64;
ADDRGP4 botSelectInfo+4892+16
CNSTI4 416
ASGNI4
line 1912
;1912:	botSelectInfo.back.width			= 128;
ADDRGP4 botSelectInfo+4892+80
CNSTI4 128
ASGNI4
line 1913
;1913:	botSelectInfo.back.height			= 64;
ADDRGP4 botSelectInfo+4892+84
CNSTI4 64
ASGNI4
line 1914
;1914:	botSelectInfo.back.focuspic			= BOTSELECT_BACK1;
ADDRGP4 botSelectInfo+4892+64
ADDRGP4 $417
ASGNP4
line 1916
;1915:
;1916:	botSelectInfo.go.generic.type		= MTYPE_BITMAP;
ADDRGP4 botSelectInfo+4800
CNSTI4 6
ASGNI4
line 1917
;1917:	botSelectInfo.go.generic.name		= BOTSELECT_ACCEPT0;
ADDRGP4 botSelectInfo+4800+4
ADDRGP4 $1426
ASGNP4
line 1918
;1918:	botSelectInfo.go.generic.flags		= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 botSelectInfo+4800+44
CNSTU4 272
ASGNU4
line 1919
;1919:	botSelectInfo.go.generic.callback	= UI_BotSelectMenu_SelectEvent;
ADDRGP4 botSelectInfo+4800+48
ADDRGP4 UI_BotSelectMenu_SelectEvent
ASGNP4
line 1920
;1920:	botSelectInfo.go.generic.x			= 640;
ADDRGP4 botSelectInfo+4800+12
CNSTI4 640
ASGNI4
line 1921
;1921:	botSelectInfo.go.generic.y			= 480-64;
ADDRGP4 botSelectInfo+4800+16
CNSTI4 416
ASGNI4
line 1922
;1922:	botSelectInfo.go.width				= 128;
ADDRGP4 botSelectInfo+4800+80
CNSTI4 128
ASGNI4
line 1923
;1923:	botSelectInfo.go.height				= 64;
ADDRGP4 botSelectInfo+4800+84
CNSTI4 64
ASGNI4
line 1924
;1924:	botSelectInfo.go.focuspic			= BOTSELECT_ACCEPT1;
ADDRGP4 botSelectInfo+4800+64
ADDRGP4 $1427
ASGNP4
line 1926
;1925:
;1926:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.banner );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1927
;1927:	for( i = 0; i < MAX_MODELSPERPAGE; i++ ) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $1590
line 1928
;1928:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.pics[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+364
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1929
;1929:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picbuttons[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 botSelectInfo+1836
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1930
;1930:		Menu_AddItem( &botSelectInfo.menu,	&botSelectInfo.picnames[i] );
ADDRGP4 botSelectInfo
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 botSelectInfo+3308
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1931
;1931:	}
LABELV $1591
line 1927
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 16
LTI4 $1590
line 1932
;1932:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.arrows );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4524
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1933
;1933:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.left );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4616
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1934
;1934:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.right );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4708
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1935
;1935:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.back );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4892
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1936
;1936:	Menu_AddItem( &botSelectInfo.menu, &botSelectInfo.go );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 botSelectInfo+4800
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1938
;1937:
;1938:	UI_BotSelectMenu_BuildList();
ADDRGP4 UI_BotSelectMenu_BuildList
CALLV
pop
line 1939
;1939:	UI_BotSelectMenu_Default( bot );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_BotSelectMenu_Default
CALLV
pop
line 1940
;1940:	botSelectInfo.modelpage = botSelectInfo.selectedmodel / MAX_MODELSPERPAGE;
ADDRGP4 botSelectInfo+4988
ADDRGP4 botSelectInfo+4996
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 1941
;1941:	UI_BotSelectMenu_UpdateGrid();
ADDRGP4 UI_BotSelectMenu_UpdateGrid
CALLV
pop
line 1942
;1942:}
LABELV $1430
endproc UI_BotSelectMenu_Init 32 12
export UI_BotSelectMenu
proc UI_BotSelectMenu 0 4
line 1950
;1943:
;1944:
;1945:/*
;1946:=================
;1947:UI_BotSelectMenu
;1948:=================
;1949:*/
;1950:void UI_BotSelectMenu( char *bot ) {
line 1951
;1951:	UI_BotSelectMenu_Init( bot );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_BotSelectMenu_Init
CALLV
pop
line 1952
;1952:	UI_PushMenu( &botSelectInfo.menu );
ADDRGP4 botSelectInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 1953
;1953:}
LABELV $1604
endproc UI_BotSelectMenu 0 4
bss
align 4
LABELV botSelectInfo
skip 10376
align 4
LABELV s_serveroptions
skip 6480
import punkbuster_items
align 4
LABELV s_startserver
skip 6136
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_HudMenu
import UI_Hud_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_LoadCachedServers
import trap_LAN_SaveCachedServers
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import UI_VideoCheck
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $1440
byte 1 83
byte 1 69
byte 1 76
byte 1 69
byte 1 67
byte 1 84
byte 1 32
byte 1 66
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $1429
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1428
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1427
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1426
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1300
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1289
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
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
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
LABELV $1286
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
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1285
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1219
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
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1202
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
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1075
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1059
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $1043
byte 1 72
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $1034
byte 1 68
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 58
byte 1 0
align 1
LABELV $1017
byte 1 80
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $1007
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $980
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $962
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $944
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 32
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $834
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $808
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 0
align 1
LABELV $785
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $765
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $753
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $747
byte 1 109
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $744
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $727
byte 1 48
byte 1 32
byte 1 61
byte 1 32
byte 1 78
byte 1 79
byte 1 32
byte 1 76
byte 1 73
byte 1 77
byte 1 73
byte 1 84
byte 1 0
align 1
LABELV $667
byte 1 72
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $635
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $604
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $595
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $577
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $571
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $567
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $566
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $565
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
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $564
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
LABELV $563
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
LABELV $562
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
LABELV $561
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
LABELV $560
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
LABELV $558
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $557
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
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
LABELV $556
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
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
LABELV $554
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $553
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $552
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $550
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
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
LABELV $549
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
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
LABELV $547
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
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
LABELV $546
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
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
LABELV $490
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $489
byte 1 72
byte 1 97
byte 1 114
byte 1 100
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $488
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $487
byte 1 66
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 73
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 0
align 1
LABELV $486
byte 1 73
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 32
byte 1 87
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $485
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $484
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $483
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 0
align 1
LABELV $482
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $481
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $480
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $479
byte 1 76
byte 1 65
byte 1 78
byte 1 0
align 1
LABELV $478
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $468
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $438
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $421
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $417
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $400
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $383
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $365
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $337
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 103
byte 1 115
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $333
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $305
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $302
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $270
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $256
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 49
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $242
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 95
byte 1 108
byte 1 0
align 1
LABELV $234
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 32
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $201
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $173
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $138
byte 1 78
byte 1 79
byte 1 32
byte 1 77
byte 1 65
byte 1 80
byte 1 83
byte 1 32
byte 1 70
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $106
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $93
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $90
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $87
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $84
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $81
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $72
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $71
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
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
byte 1 0
align 1
LABELV $70
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $69
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
