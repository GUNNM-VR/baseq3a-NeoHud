data
align 4
LABELV playermodel_artlist
address $68
address $69
address $70
address $71
address $72
address $73
address $74
address $75
address $76
address $77
byte 4 0
code
proc PlayerModel_UpdateGrid 24 0
file "..\..\..\..\code\q3_ui\ui_playermodel.c"
line 93
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:#define MODEL_BACK0			"menu/art/back_0"
;6:#define MODEL_BACK1			"menu/art/back_1"
;7:#define MODEL_SELECT		"menu/art/opponents_select"
;8:#define MODEL_SELECTED		"menu/art/opponents_selected"
;9:#define MODEL_FRAMEL		"menu/art/frame1_l"
;10:#define MODEL_FRAMER		"menu/art/frame1_r"
;11:#define MODEL_PORTS			"menu/art/player_models_ports"
;12:#define MODEL_ARROWS		"menu/art/gs_arrows_0"
;13:#define MODEL_ARROWSL		"menu/art/gs_arrows_l"
;14:#define MODEL_ARROWSR		"menu/art/gs_arrows_r"
;15:
;16:#define LOW_MEMORY			(5 * 1024 * 1024)
;17:
;18:static char* playermodel_artlist[] =
;19:{
;20:	MODEL_BACK0,	
;21:	MODEL_BACK1,	
;22:	MODEL_SELECT,
;23:	MODEL_SELECTED,
;24:	MODEL_FRAMEL,
;25:	MODEL_FRAMER,
;26:	MODEL_PORTS,	
;27:	MODEL_ARROWS,
;28:	MODEL_ARROWSL,
;29:	MODEL_ARROWSR,
;30:	NULL
;31:};
;32:
;33:#define PLAYERGRID_COLS		4
;34:#define PLAYERGRID_ROWS		4
;35:#define MAX_MODELSPERPAGE	(PLAYERGRID_ROWS*PLAYERGRID_COLS)
;36:
;37:#define MAX_PLAYERMODELS	256
;38:
;39:#define ID_PLAYERPIC0		0
;40:#define ID_PLAYERPIC1		1
;41:#define ID_PLAYERPIC2		2
;42:#define ID_PLAYERPIC3		3
;43:#define ID_PLAYERPIC4		4
;44:#define ID_PLAYERPIC5		5
;45:#define ID_PLAYERPIC6		6
;46:#define ID_PLAYERPIC7		7
;47:#define ID_PLAYERPIC8		8
;48:#define ID_PLAYERPIC9		9
;49:#define ID_PLAYERPIC10		10
;50:#define ID_PLAYERPIC11		11
;51:#define ID_PLAYERPIC12		12
;52:#define ID_PLAYERPIC13		13
;53:#define ID_PLAYERPIC14		14
;54:#define ID_PLAYERPIC15		15
;55:#define ID_PREVPAGE			100
;56:#define ID_NEXTPAGE			101
;57:#define ID_BACK				102
;58:
;59:typedef struct
;60:{
;61:	menuframework_s	menu;
;62:	menubitmap_s	pics[MAX_MODELSPERPAGE];
;63:	menubitmap_s	picbuttons[MAX_MODELSPERPAGE];
;64:	menubitmap_s	framel;
;65:	menubitmap_s	framer;
;66:	menubitmap_s	ports;
;67:	menutext_s		banner;
;68:	menubitmap_s	back;
;69:	menubitmap_s	player;
;70:	menubitmap_s	arrows;
;71:	menubitmap_s	left;
;72:	menubitmap_s	right;
;73:	menutext_s		modelname;
;74:	menutext_s		skinname;
;75:	menutext_s		playername;
;76:	playerInfo_t	playerinfo;
;77:	int				nummodels;
;78:	char			modelnames[MAX_PLAYERMODELS][128];
;79:	int				modelpage;
;80:	int				numpages;
;81:	char			modelskin[64];
;82:	int				selectedmodel;
;83:} playermodel_t;
;84:
;85:static playermodel_t s_playermodel;
;86:
;87:/*
;88:=================
;89:PlayerModel_UpdateGrid
;90:=================
;91:*/
;92:static void PlayerModel_UpdateGrid( void )
;93:{
line 97
;94:	int	i;
;95:    int	j;
;96:
;97:	j = s_playermodel.modelpage * MAX_MODELSPERPAGE;
ADDRLP4 4
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 98
;98:	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++,j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $81
line 99
;99:	{
line 100
;100:		if (j < s_playermodel.nummodels)
ADDRLP4 4
INDIRI4
ADDRGP4 s_playermodel+5380
INDIRI4
GEI4 $85
line 101
;101:		{ 
line 103
;102:			// model/skin portrait
;103: 			s_playermodel.pics[i].generic.name         = s_playermodel.modelnames[j];
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5384
ADDP4
ASGNP4
line 104
;104:			s_playermodel.picbuttons[i].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 105
;105:		}
ADDRGP4 $86
JUMPV
LABELV $85
line 107
;106:		else
;107:		{
line 109
;108:			// dead slot
;109: 			s_playermodel.pics[i].generic.name         = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+4
ADDP4
CNSTP4 0
ASGNP4
line 110
;110:			s_playermodel.picbuttons[i].generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 111
;111:		}
LABELV $86
line 113
;112:
;113: 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 114
;114: 		s_playermodel.pics[i].shader               = 0;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+72
ADDP4
CNSTI4 0
ASGNI4
line 115
;115: 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 116
;116:	}
LABELV $82
line 98
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
LTI4 $81
line 118
;117:
;118:	if (s_playermodel.selectedmodel/MAX_MODELSPERPAGE == s_playermodel.modelpage)
ADDRGP4 s_playermodel+38224
INDIRI4
CNSTI4 16
DIVI4
ADDRGP4 s_playermodel+38152
INDIRI4
NEI4 $103
line 119
;119:	{
line 121
;120:		// set selected model
;121:		i = s_playermodel.selectedmodel % MAX_MODELSPERPAGE;
ADDRLP4 0
ADDRGP4 s_playermodel+38224
INDIRI4
CNSTI4 16
MODI4
ASGNI4
line 123
;122:
;123:		s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 124
;124:		s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 125
;125:	}
LABELV $103
line 127
;126:
;127:	if (s_playermodel.numpages > 1)
ADDRGP4 s_playermodel+38156
INDIRI4
CNSTI4 1
LEI4 $112
line 128
;128:	{
line 129
;129:		if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 0
LEI4 $115
line 130
;130:			s_playermodel.left.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_playermodel+3860+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
ADDRGP4 $116
JUMPV
LABELV $115
line 132
;131:		else
;132:			s_playermodel.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRGP4 s_playermodel+3860+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
LABELV $116
line 134
;133:
;134:		if (s_playermodel.modelpage < s_playermodel.numpages-1)
ADDRGP4 s_playermodel+38152
INDIRI4
ADDRGP4 s_playermodel+38156
INDIRI4
CNSTI4 1
SUBI4
GEI4 $122
line 135
;135:			s_playermodel.right.generic.flags &= ~QMF_INACTIVE;
ADDRLP4 16
ADDRGP4 s_playermodel+3952+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
ADDRGP4 $113
JUMPV
LABELV $122
line 137
;136:		else
;137:			s_playermodel.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 20
ADDRGP4 s_playermodel+3952+44
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 138
;138:	}
ADDRGP4 $113
JUMPV
LABELV $112
line 140
;139:	else
;140:	{
line 142
;141:		// hide left/right markers
;142:		s_playermodel.left.generic.flags |= QMF_INACTIVE;
ADDRLP4 8
ADDRGP4 s_playermodel+3860+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 143
;143:		s_playermodel.right.generic.flags |= QMF_INACTIVE;
ADDRLP4 12
ADDRGP4 s_playermodel+3952+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 144
;144:	}
LABELV $113
line 145
;145:}
LABELV $79
endproc PlayerModel_UpdateGrid 24 0
proc PlayerModel_UpdateModel 24 28
line 153
;146:
;147:/*
;148:=================
;149:PlayerModel_UpdateModel
;150:=================
;151:*/
;152:static void PlayerModel_UpdateModel( void )
;153:{
line 157
;154:	vec3_t	viewangles;
;155:	vec3_t	moveangles;
;156:
;157:	memset( &s_playermodel.playerinfo, 0, sizeof(playerInfo_t) );
ADDRGP4 s_playermodel+4272
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1108
ARGI4
ADDRGP4 memset
CALLP4
pop
line 159
;158:	
;159:	viewangles[YAW]   = 180 - 30;
ADDRLP4 0+4
CNSTF4 1125515264
ASGNF4
line 160
;160:	viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 161
;161:	viewangles[ROLL]  = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 162
;162:	VectorClear( moveangles );
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12+4
CNSTF4 0
ASGNF4
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 164
;163:
;164:	UI_PlayerInfo_SetModel( &s_playermodel.playerinfo, s_playermodel.modelskin );
ADDRGP4 s_playermodel+4272
ARGP4
ADDRGP4 s_playermodel+38160
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 165
;165:	UI_PlayerInfo_SetInfo( &s_playermodel.playerinfo, LEGS_IDLE, TORSO_STAND, viewangles, moveangles, WP_MACHINEGUN, qfalse );
ADDRGP4 s_playermodel+4272
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 166
;166:}
LABELV $134
endproc PlayerModel_UpdateModel 24 28
proc PlayerModel_SaveChanges 0 8
line 174
;167:
;168:/*
;169:=================
;170:PlayerModel_SaveChanges
;171:=================
;172:*/
;173:static void PlayerModel_SaveChanges( void )
;174:{
line 175
;175:	trap_Cvar_Set( "model", s_playermodel.modelskin );
ADDRGP4 $144
ARGP4
ADDRGP4 s_playermodel+38160
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 176
;176:	trap_Cvar_Set( "headmodel", s_playermodel.modelskin );
ADDRGP4 $146
ARGP4
ADDRGP4 s_playermodel+38160
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 177
;177:}
LABELV $143
endproc PlayerModel_SaveChanges 0 8
proc PlayerModel_MenuEvent 12 0
line 185
;178:
;179:/*
;180:=================
;181:PlayerModel_MenuEvent
;182:=================
;183:*/
;184:static void PlayerModel_MenuEvent( void* ptr, int event )
;185:{
line 186
;186:	if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $149
line 187
;187:		return;
ADDRGP4 $148
JUMPV
LABELV $149
line 189
;188:
;189:	switch (((menucommon_s*)ptr)->id)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
EQI4 $154
ADDRLP4 0
INDIRI4
CNSTI4 101
EQI4 $159
ADDRLP4 0
INDIRI4
CNSTI4 102
EQI4 $165
ADDRGP4 $151
JUMPV
line 190
;190:	{
LABELV $154
line 192
;191:		case ID_PREVPAGE:
;192:			if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 0
LEI4 $152
line 193
;193:			{
line 194
;194:				s_playermodel.modelpage--;
ADDRLP4 8
ADDRGP4 s_playermodel+38152
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 195
;195:				PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 196
;196:			}
line 197
;197:			break;
ADDRGP4 $152
JUMPV
LABELV $159
line 200
;198:
;199:		case ID_NEXTPAGE:
;200:			if (s_playermodel.modelpage < s_playermodel.numpages-1)
ADDRGP4 s_playermodel+38152
INDIRI4
ADDRGP4 s_playermodel+38156
INDIRI4
CNSTI4 1
SUBI4
GEI4 $152
line 201
;201:			{
line 202
;202:				s_playermodel.modelpage++;
ADDRLP4 8
ADDRGP4 s_playermodel+38152
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 203
;203:				PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 204
;204:			}
line 205
;205:			break;
ADDRGP4 $152
JUMPV
LABELV $165
line 208
;206:
;207:		case ID_BACK:
;208:			PlayerModel_SaveChanges();
ADDRGP4 PlayerModel_SaveChanges
CALLV
pop
line 209
;209:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 210
;210:			break;
LABELV $151
LABELV $152
line 212
;211:	}
;212:}
LABELV $148
endproc PlayerModel_MenuEvent 12 0
proc PlayerModel_MenuKey 44 8
line 220
;213:
;214:/*
;215:=================
;216:PlayerModel_MenuKey
;217:=================
;218:*/
;219:static sfxHandle_t PlayerModel_MenuKey( int key )
;220:{
line 224
;221:	menucommon_s*	m;
;222:	int				picnum;
;223:
;224:	switch (key)
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 134
EQI4 $169
ADDRLP4 8
INDIRI4
CNSTI4 135
EQI4 $178
ADDRLP4 8
INDIRI4
CNSTI4 135
GTI4 $192
LABELV $191
ADDRFP4 0
INDIRI4
CNSTI4 27
EQI4 $190
ADDRGP4 $167
JUMPV
LABELV $192
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 163
EQI4 $169
ADDRLP4 12
INDIRI4
CNSTI4 165
EQI4 $178
ADDRLP4 12
INDIRI4
CNSTI4 163
LTI4 $167
LABELV $193
ADDRFP4 0
INDIRI4
CNSTI4 179
EQI4 $190
ADDRGP4 $167
JUMPV
line 225
;225:	{
LABELV $169
line 228
;226:		case K_KP_LEFTARROW:
;227:		case K_LEFTARROW:
;228:			m = Menu_ItemAtCursor(&s_playermodel.menu);
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 229
;229:			picnum = m->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 230
;230:			if (picnum >= 0 && picnum <= 15)
ADDRLP4 20
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $168
ADDRLP4 20
INDIRI4
CNSTI4 15
GTI4 $168
line 231
;231:			{
line 232
;232:				if (picnum > 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $172
line 233
;233:				{
line 234
;234:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-1);
ADDRLP4 24
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 235
;235:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
LABELV $172
line 238
;236:					
;237:				}
;238:				else if (s_playermodel.modelpage > 0)
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 0
LEI4 $174
line 239
;239:				{
line 240
;240:					s_playermodel.modelpage--;
ADDRLP4 24
ADDRGP4 s_playermodel+38152
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 241
;241:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+15);
ADDRLP4 28
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 242
;242:					PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 243
;243:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
LABELV $174
line 246
;244:				}
;245:				else
;246:					return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
line 248
;247:			}
;248:			break;
LABELV $178
line 252
;249:
;250:		case K_KP_RIGHTARROW:
;251:		case K_RIGHTARROW:
;252:			m = Menu_ItemAtCursor(&s_playermodel.menu);
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 24
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 253
;253:			picnum = m->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 254
;254:			if (picnum >= 0 && picnum <= 15)
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $168
ADDRLP4 28
INDIRI4
CNSTI4 15
GTI4 $168
line 255
;255:			{
line 256
;256:				if ((picnum < 15) && (s_playermodel.modelpage*MAX_MODELSPERPAGE + picnum+1 < s_playermodel.nummodels))
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 15
GEI4 $181
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRGP4 s_playermodel+5380
INDIRI4
GEI4 $181
line 257
;257:				{
line 258
;258:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor+1);
ADDRLP4 36
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 259
;259:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
LABELV $181
line 261
;260:				}					
;261:				else if ((picnum == 15) && (s_playermodel.modelpage < s_playermodel.numpages-1))
ADDRLP4 0
INDIRI4
CNSTI4 15
NEI4 $185
ADDRGP4 s_playermodel+38152
INDIRI4
ADDRGP4 s_playermodel+38156
INDIRI4
CNSTI4 1
SUBI4
GEI4 $185
line 262
;262:				{
line 263
;263:					s_playermodel.modelpage++;
ADDRLP4 36
ADDRGP4 s_playermodel+38152
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 264
;264:					Menu_SetCursor(&s_playermodel.menu,s_playermodel.menu.cursor-15);
ADDRLP4 40
ADDRGP4 s_playermodel
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 15
SUBI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 265
;265:					PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 266
;266:					return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
LABELV $185
line 269
;267:				}
;268:				else
;269:					return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $166
JUMPV
line 271
;270:			}
;271:			break;
LABELV $190
line 275
;272:			
;273:		case K_MOUSE2:
;274:		case K_ESCAPE:
;275:			PlayerModel_SaveChanges();
ADDRGP4 PlayerModel_SaveChanges
CALLV
pop
line 276
;276:			break;
LABELV $167
LABELV $168
line 279
;277:	}
;278:
;279:	return ( Menu_DefaultKey( &s_playermodel.menu, key ) );
ADDRGP4 s_playermodel
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
LABELV $166
endproc PlayerModel_MenuKey 44 8
proc PlayerModel_PicEvent 48 12
line 288
;280:}
;281:
;282:/*
;283:=================
;284:PlayerModel_PicEvent
;285:=================
;286:*/
;287:static void PlayerModel_PicEvent( void* ptr, int event )
;288:{
line 295
;289:	int				modelnum;
;290:	int				maxlen;
;291:	char*			buffptr;
;292:	char*			pdest;
;293:	int				i;
;294:
;295:	if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $195
line 296
;296:		return;
ADDRGP4 $194
JUMPV
LABELV $195
line 298
;297:
;298:	for (i=0; i<PLAYERGRID_ROWS*PLAYERGRID_COLS; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $197
line 299
;299:	{
line 301
;300:		// reset
;301: 		s_playermodel.pics[i].generic.flags       &= ~QMF_HIGHLIGHT;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 4294967231
BANDU4
ASGNU4
line 302
;302: 		s_playermodel.picbuttons[i].generic.flags |= QMF_PULSEIFFOCUS;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 256
BORU4
ASGNU4
line 303
;303:	}
LABELV $198
line 298
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $197
line 306
;304:
;305:	// set selected
;306:	i = ((menucommon_s*)ptr)->id - ID_PLAYERPIC0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 307
;307:	s_playermodel.pics[i].generic.flags       |= QMF_HIGHLIGHT;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRU4
CNSTU4 64
BORU4
ASGNU4
line 308
;308:	s_playermodel.picbuttons[i].generic.flags &= ~QMF_PULSEIFFOCUS;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 4294967039
BANDU4
ASGNU4
line 311
;309:
;310:	// get model and strip icon_
;311:	modelnum = s_playermodel.modelpage*MAX_MODELSPERPAGE + i;
ADDRLP4 16
ADDRGP4 s_playermodel+38152
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 312
;312:	buffptr  = s_playermodel.modelnames[modelnum] + strlen("models/players/");
ADDRGP4 $211
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5384
ADDP4
ADDP4
ASGNP4
line 313
;313:	pdest    = strstr(buffptr,"icon_");
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 314
;314:	if (pdest)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $213
line 315
;315:	{
line 317
;316:		// track the whole model/skin name
;317:		Q_strncpyz(s_playermodel.modelskin,buffptr,pdest-buffptr+1);
ADDRGP4 s_playermodel+38160
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 318
;318:		strcat(s_playermodel.modelskin,pdest + 5);
ADDRGP4 s_playermodel+38160
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 321
;319:
;320:		// seperate the model name
;321:		maxlen = pdest-buffptr;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 322
;322:		if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $217
line 323
;323:			maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $217
line 324
;324:		Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
ADDRGP4 s_playermodel+4044+64
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 325
;325:		Q_strupr( s_playermodel.modelname.string );
ADDRGP4 s_playermodel+4044+64
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 328
;326:
;327:		// seperate the skin name
;328:		maxlen = strlen(pdest+5)+1;
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 329
;329:		if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $223
line 330
;330:			maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $223
line 331
;331:		Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
ADDRGP4 s_playermodel+4120+64
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 332
;332:		Q_strupr( s_playermodel.skinname.string );
ADDRGP4 s_playermodel+4120+64
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 334
;333:
;334:		s_playermodel.selectedmodel = modelnum;
ADDRGP4 s_playermodel+38224
ADDRLP4 16
INDIRI4
ASGNI4
line 336
;335:
;336:		if( trap_MemoryRemaining() > LOW_MEMORY ) {
ADDRLP4 44
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 5242880
LEI4 $230
line 337
;337:			PlayerModel_UpdateModel();
ADDRGP4 PlayerModel_UpdateModel
CALLV
pop
line 338
;338:		}
LABELV $230
line 339
;339:	}
LABELV $213
line 340
;340:}
LABELV $194
endproc PlayerModel_PicEvent 48 12
proc PlayerModel_DrawPlayer 12 24
line 348
;341:
;342:/*
;343:=================
;344:PlayerModel_DrawPlayer
;345:=================
;346:*/
;347:static void PlayerModel_DrawPlayer( void *self )
;348:{
line 351
;349:	menubitmap_s*	b;
;350:
;351:	b = (menubitmap_s*) self;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 353
;352:
;353:	if( trap_MemoryRemaining() <= LOW_MEMORY ) {
ADDRLP4 4
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5242880
GTI4 $233
line 354
;354:		UI_DrawProportionalString( b->generic.x, b->generic.y + b->height / 2, "LOW MEMORY", UI_LEFT, color_red );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
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
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRGP4 $235
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 355
;355:		return;
ADDRGP4 $232
JUMPV
LABELV $233
line 358
;356:	}
;357:
;358:	UI_DrawPlayer( b->generic.x, b->generic.y, b->width, b->height, &s_playermodel.playerinfo, uis.realtime/2 );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
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
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 s_playermodel+4272
ARGP4
ADDRGP4 uis+4
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 359
;359:}
LABELV $232
endproc PlayerModel_DrawPlayer 12 24
proc PlayerModel_BuildList 4244 20
line 367
;360:
;361:/*
;362:=================
;363:PlayerModel_BuildList
;364:=================
;365:*/
;366:static void PlayerModel_BuildList( void )
;367:{
line 381
;368:	int		numdirs;
;369:	int		numfiles;
;370:	char	dirlist[2048];
;371:	char	filelist[2048];
;372:	char	skinname[MAX_QPATH];
;373:	char*	dirptr;
;374:	char*	fileptr;
;375:	int		i;
;376:	int		j;
;377:	int		dirlen;
;378:	int		filelen;
;379:	qboolean precache;
;380:
;381:	precache = trap_Cvar_VariableValue("com_buildscript");
ADDRGP4 $239
ARGP4
ADDRLP4 4196
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 84
ADDRLP4 4196
INDIRF4
CVFI4 4
ASGNI4
line 383
;382:
;383:	s_playermodel.modelpage = 0;
ADDRGP4 s_playermodel+38152
CNSTI4 0
ASGNI4
line 384
;384:	s_playermodel.nummodels = 0;
ADDRGP4 s_playermodel+5380
CNSTI4 0
ASGNI4
line 387
;385:
;386:	// iterate directory of all player models
;387:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048 );
ADDRGP4 $242
ARGP4
ADDRGP4 $243
ARGP4
ADDRLP4 2148
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4200
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 2144
ADDRLP4 4200
INDIRI4
ASGNI4
line 388
;388:	dirptr  = dirlist;
ADDRLP4 76
ADDRLP4 2148
ASGNP4
line 389
;389:	for (i=0; i<numdirs && s_playermodel.nummodels < MAX_PLAYERMODELS; i++,dirptr+=dirlen+1)
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 $247
JUMPV
LABELV $244
line 390
;390:	{
line 391
;391:		dirlen = strlen(dirptr);
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4204
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4204
INDIRI4
ASGNI4
line 393
;392:		
;393:		if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $249
ADDRLP4 88
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $249
ADDRLP4 88
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $249
line 395
;394:
;395:		if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 4212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4212
INDIRI4
CNSTI4 0
EQI4 $255
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $254
ARGP4
ADDRLP4 4216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4216
INDIRI4
CNSTI4 0
NEI4 $251
LABELV $255
line 396
;396:			continue;
ADDRGP4 $245
JUMPV
LABELV $251
line 399
;397:			
;398:		// iterate all skin files in directory
;399:		numfiles = trap_FS_GetFileList( va("models/players/%s",dirptr), "tga", filelist, 2048 );
ADDRGP4 $256
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4220
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4220
INDIRP4
ARGP4
ADDRGP4 $257
ARGP4
ADDRLP4 96
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4224
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 4224
INDIRI4
ASGNI4
line 400
;400:		fileptr  = filelist;
ADDRLP4 64
ADDRLP4 96
ASGNP4
line 401
;401:		for (j=0; j<numfiles && s_playermodel.nummodels < MAX_PLAYERMODELS;j++,fileptr+=filelen+1)
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $261
JUMPV
LABELV $258
line 402
;402:		{
line 403
;403:			filelen = strlen(fileptr);
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 4228
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 4228
INDIRI4
ASGNI4
line 405
;404:
;405:			COM_StripExtension( fileptr, skinname, sizeof(skinname) );
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 408
;406:
;407:			// look for icon_????
;408:			if (!Q_stricmpn(skinname,"icon_",5))
ADDRLP4 0
ARGP4
ADDRGP4 $212
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4232
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 4232
INDIRI4
CNSTI4 0
NEI4 $263
line 409
;409:			{
line 410
;410:				Com_sprintf( s_playermodel.modelnames[s_playermodel.nummodels++],
ADDRLP4 4240
ADDRGP4 s_playermodel+5380
ASGNP4
ADDRLP4 4236
ADDRLP4 4240
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4240
INDIRP4
ADDRLP4 4236
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4236
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5384
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $269
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 415
;411:					sizeof( s_playermodel.modelnames[s_playermodel.nummodels] ),
;412:					"models/players/%s/%s", dirptr, skinname );
;413:				//if (s_playermodel.nummodels >= MAX_PLAYERMODELS)
;414:				//	return;
;415:			}
LABELV $263
line 417
;416:
;417:			if( precache ) {
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $270
line 418
;418:				trap_S_RegisterSound( va( "sound/player/announce/%s_wins.wav", skinname), qfalse );
ADDRGP4 $272
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4236
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4236
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 419
;419:			}
LABELV $270
line 420
;420:		}
LABELV $259
line 401
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 64
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 64
INDIRP4
ADDP4
ASGNP4
LABELV $261
ADDRLP4 68
INDIRI4
ADDRLP4 80
INDIRI4
GEI4 $273
ADDRGP4 s_playermodel+5380
INDIRI4
CNSTI4 256
LTI4 $258
LABELV $273
line 421
;421:	}	
LABELV $245
line 389
ADDRLP4 92
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 76
INDIRP4
ADDP4
ASGNP4
LABELV $247
ADDRLP4 92
INDIRI4
ADDRLP4 2144
INDIRI4
GEI4 $274
ADDRGP4 s_playermodel+5380
INDIRI4
CNSTI4 256
LTI4 $244
LABELV $274
line 425
;422:
;423:	//APSFIXME - Degenerate no models case
;424:
;425:	s_playermodel.numpages = s_playermodel.nummodels/MAX_MODELSPERPAGE;
ADDRGP4 s_playermodel+38156
ADDRGP4 s_playermodel+5380
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 426
;426:	if (s_playermodel.nummodels % MAX_MODELSPERPAGE)
ADDRGP4 s_playermodel+5380
INDIRI4
CNSTI4 16
MODI4
CNSTI4 0
EQI4 $277
line 427
;427:		s_playermodel.numpages++;
ADDRLP4 4204
ADDRGP4 s_playermodel+38156
ASGNP4
ADDRLP4 4204
INDIRP4
ADDRLP4 4204
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $277
line 428
;428:}
LABELV $238
endproc PlayerModel_BuildList 4244 20
proc PlayerModel_SetMenuItems 96 12
line 436
;429:
;430:/*
;431:=================
;432:PlayerModel_SetMenuItems
;433:=================
;434:*/
;435:static void PlayerModel_SetMenuItems( void )
;436:{
line 444
;437:	int				i;
;438:	int				maxlen;
;439:	char			modelskin[64];
;440:	char*			buffptr;
;441:	char*			pdest;
;442:
;443:	// name
;444:	trap_Cvar_VariableStringBuffer( "name", s_playermodel.playername.string, 16 );
ADDRGP4 $282
ARGP4
ADDRGP4 s_playermodel+4196+64
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 445
;445:	Q_CleanStr( s_playermodel.playername.string );
ADDRGP4 s_playermodel+4196+64
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 448
;446:
;447:	// model
;448:	trap_Cvar_VariableStringBuffer( "model", s_playermodel.modelskin, 64 );
ADDRGP4 $144
ARGP4
ADDRGP4 s_playermodel+38160
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 451
;449:	
;450:	// find model in our list
;451:	for (i=0; i<s_playermodel.nummodels; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $291
JUMPV
LABELV $288
line 452
;452:	{
line 454
;453:		// strip icon_
;454:		buffptr	= s_playermodel.modelnames[i] + strlen("models/players/");
ADDRGP4 $211
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 80
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5384
ADDP4
ADDP4
ASGNP4
line 455
;455:		pdest	= strstr(buffptr,"icon_");
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $212
ARGP4
ADDRLP4 84
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 84
INDIRP4
ASGNP4
line 456
;456:		if (pdest)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $289
line 457
;457:		{
line 458
;458:			Q_strncpyz(modelskin,buffptr,pdest-buffptr+1);
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 459
;459:			strcat(modelskin,pdest + 5);
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 460
;460:		}
line 462
;461:		else
;462:			continue;
LABELV $295
line 464
;463:
;464:		if (!Q_stricmp( s_playermodel.modelskin, modelskin ))
ADDRGP4 s_playermodel+38160
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $296
line 465
;465:		{
line 467
;466:			// found pic, set selection here		
;467:			s_playermodel.selectedmodel	= i;
ADDRGP4 s_playermodel+38224
ADDRLP4 4
INDIRI4
ASGNI4
line 468
;468:			s_playermodel.modelpage		= i/MAX_MODELSPERPAGE;
ADDRGP4 s_playermodel+38152
ADDRLP4 4
INDIRI4
CNSTI4 16
DIVI4
ASGNI4
line 471
;469:
;470:			// separate the model name
;471:			maxlen = pdest-buffptr;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 472
;472:			if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $301
line 473
;473:				maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $301
line 474
;474:			Q_strncpyz( s_playermodel.modelname.string, buffptr, maxlen );
ADDRGP4 s_playermodel+4044+64
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 475
;475:			Q_strupr( s_playermodel.modelname.string );
ADDRGP4 s_playermodel+4044+64
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 478
;476:
;477:			// separate the skin name
;478:			maxlen = strlen(pdest+5)+1;
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 479
;479:			if (maxlen > 16)
ADDRLP4 12
INDIRI4
CNSTI4 16
LEI4 $307
line 480
;480:				maxlen = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
LABELV $307
line 481
;481:			Q_strncpyz( s_playermodel.skinname.string, pdest+5, maxlen );
ADDRGP4 s_playermodel+4120+64
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 5
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 482
;482:			Q_strupr( s_playermodel.skinname.string );
ADDRGP4 s_playermodel+4120+64
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 483
;483:			break;
ADDRGP4 $290
JUMPV
LABELV $296
line 485
;484:		}
;485:	}
LABELV $289
line 451
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $291
ADDRLP4 4
INDIRI4
ADDRGP4 s_playermodel+5380
INDIRI4
LTI4 $288
LABELV $290
line 486
;486:}
LABELV $281
endproc PlayerModel_SetMenuItems 96 12
bss
align 1
LABELV $314
skip 32
align 1
LABELV $315
skip 32
align 1
LABELV $316
skip 32
code
proc PlayerModel_MenuInit 24 12
line 494
;487:
;488:/*
;489:=================
;490:PlayerModel_MenuInit
;491:=================
;492:*/
;493:static void PlayerModel_MenuInit( void )
;494:{
line 505
;495:	int			i;
;496:	int			j;
;497:	int			k;
;498:	int			x;
;499:	int			y;
;500:	static char	playername[32];
;501:	static char	modelname[32];
;502:	static char	skinname[32];
;503:
;504:	// zero set all our globals
;505:	memset( &s_playermodel, 0 ,sizeof(playermodel_t) );
ADDRGP4 s_playermodel
ARGP4
CNSTI4 0
ARGI4
CNSTI4 38228
ARGI4
ADDRGP4 memset
CALLP4
pop
line 507
;506:
;507:	PlayerModel_Cache();
ADDRGP4 PlayerModel_Cache
CALLV
pop
line 509
;508:
;509:	s_playermodel.menu.key        = PlayerModel_MenuKey;
ADDRGP4 s_playermodel+272
ADDRGP4 PlayerModel_MenuKey
ASGNP4
line 510
;510:	s_playermodel.menu.wrapAround = qtrue;
ADDRGP4 s_playermodel+276
CNSTI4 1
ASGNI4
line 511
;511:	s_playermodel.menu.fullscreen = qtrue;
ADDRGP4 s_playermodel+280
CNSTI4 1
ASGNI4
line 513
;512:
;513:	s_playermodel.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 s_playermodel+3508
CNSTI4 10
ASGNI4
line 514
;514:	s_playermodel.banner.generic.x     = 320;
ADDRGP4 s_playermodel+3508+12
CNSTI4 320
ASGNI4
line 515
;515:	s_playermodel.banner.generic.y     = 16;
ADDRGP4 s_playermodel+3508+16
CNSTI4 16
ASGNI4
line 516
;516:	s_playermodel.banner.string        = "PLAYER MODEL";
ADDRGP4 s_playermodel+3508+64
ADDRGP4 $327
ASGNP4
line 517
;517:	s_playermodel.banner.color         = color_white;
ADDRGP4 s_playermodel+3508+72
ADDRGP4 color_white
ASGNP4
line 518
;518:	s_playermodel.banner.style         = UI_CENTER;
ADDRGP4 s_playermodel+3508+68
CNSTI4 1
ASGNI4
line 520
;519:
;520:	s_playermodel.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3232
CNSTI4 6
ASGNI4
line 521
;521:	s_playermodel.framel.generic.name  = MODEL_FRAMEL;
ADDRGP4 s_playermodel+3232+4
ADDRGP4 $72
ASGNP4
line 522
;522:	s_playermodel.framel.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3232+44
CNSTU4 16388
ASGNU4
line 523
;523:	s_playermodel.framel.generic.x     = 0;
ADDRGP4 s_playermodel+3232+12
CNSTI4 0
ASGNI4
line 524
;524:	s_playermodel.framel.generic.y     = 78;
ADDRGP4 s_playermodel+3232+16
CNSTI4 78
ASGNI4
line 525
;525:	s_playermodel.framel.width         = 256;
ADDRGP4 s_playermodel+3232+80
CNSTI4 256
ASGNI4
line 526
;526:	s_playermodel.framel.height        = 329;
ADDRGP4 s_playermodel+3232+84
CNSTI4 329
ASGNI4
line 528
;527:
;528:	s_playermodel.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3324
CNSTI4 6
ASGNI4
line 529
;529:	s_playermodel.framer.generic.name  = MODEL_FRAMER;
ADDRGP4 s_playermodel+3324+4
ADDRGP4 $73
ASGNP4
line 530
;530:	s_playermodel.framer.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3324+44
CNSTU4 16388
ASGNU4
line 531
;531:	s_playermodel.framer.generic.x     = 376;
ADDRGP4 s_playermodel+3324+12
CNSTI4 376
ASGNI4
line 532
;532:	s_playermodel.framer.generic.y     = 76;
ADDRGP4 s_playermodel+3324+16
CNSTI4 76
ASGNI4
line 533
;533:	s_playermodel.framer.width         = 256;
ADDRGP4 s_playermodel+3324+80
CNSTI4 256
ASGNI4
line 534
;534:	s_playermodel.framer.height        = 334;
ADDRGP4 s_playermodel+3324+84
CNSTI4 334
ASGNI4
line 536
;535:
;536:	s_playermodel.ports.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3416
CNSTI4 6
ASGNI4
line 537
;537:	s_playermodel.ports.generic.name  = MODEL_PORTS;
ADDRGP4 s_playermodel+3416+4
ADDRGP4 $74
ASGNP4
line 538
;538:	s_playermodel.ports.generic.flags = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+3416+44
CNSTU4 16388
ASGNU4
line 539
;539:	s_playermodel.ports.generic.x     = 50;
ADDRGP4 s_playermodel+3416+12
CNSTI4 50
ASGNI4
line 540
;540:	s_playermodel.ports.generic.y     = 59;
ADDRGP4 s_playermodel+3416+16
CNSTI4 59
ASGNI4
line 541
;541:	s_playermodel.ports.width         = 274;
ADDRGP4 s_playermodel+3416+80
CNSTI4 274
ASGNI4
line 542
;542:	s_playermodel.ports.height        = 274;
ADDRGP4 s_playermodel+3416+84
CNSTI4 274
ASGNI4
line 544
;543:
;544:	y =	59;
ADDRLP4 8
CNSTI4 59
ASGNI4
line 545
;545:	for (i=0,k=0; i<PLAYERGRID_ROWS; i++)
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $374
JUMPV
LABELV $371
line 546
;546:	{
line 547
;547:		x =	50;
ADDRLP4 4
CNSTI4 50
ASGNI4
line 548
;548:		for (j=0; j<PLAYERGRID_COLS; j++,k++)
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $375
line 549
;549:		{
line 550
;550:			s_playermodel.pics[k].generic.type	   = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288
ADDP4
CNSTI4 6
ASGNI4
line 551
;551:			s_playermodel.pics[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+44
ADDP4
CNSTU4 16388
ASGNU4
line 552
;552:			s_playermodel.pics[k].generic.x		   = x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 553
;553:			s_playermodel.pics[k].generic.y		   = y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+16
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 554
;554:			s_playermodel.pics[k].width  		   = 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+80
ADDP4
CNSTI4 64
ASGNI4
line 555
;555:			s_playermodel.pics[k].height  		   = 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+84
ADDP4
CNSTI4 64
ASGNI4
line 556
;556:			s_playermodel.pics[k].focuspic         = MODEL_SELECTED;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+64
ADDP4
ADDRGP4 $71
ASGNP4
line 557
;557:			s_playermodel.pics[k].focuscolor       = colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288+88
ADDP4
ADDRGP4 colorRed
ASGNP4
line 559
;558:
;559:			s_playermodel.picbuttons[k].generic.type	 = MTYPE_BITMAP;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760
ADDP4
CNSTI4 6
ASGNI4
line 560
;560:			s_playermodel.picbuttons[k].generic.flags    = QMF_LEFT_JUSTIFY|QMF_NODEFAULTINIT|QMF_PULSEIFFOCUS;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+44
ADDP4
CNSTU4 33028
ASGNU4
line 561
;561:			s_playermodel.picbuttons[k].generic.id	     = ID_PLAYERPIC0+k;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 562
;562:			s_playermodel.picbuttons[k].generic.callback = PlayerModel_PicEvent;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+48
ADDP4
ADDRGP4 PlayerModel_PicEvent
ASGNP4
line 563
;563:			s_playermodel.picbuttons[k].generic.x    	 = x - 16;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+12
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 564
;564:			s_playermodel.picbuttons[k].generic.y		 = y - 16;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+16
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 16
SUBI4
ASGNI4
line 565
;565:			s_playermodel.picbuttons[k].generic.left	 = x;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 566
;566:			s_playermodel.picbuttons[k].generic.top		 = y;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 567
;567:			s_playermodel.picbuttons[k].generic.right	 = x + 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+28
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 568
;568:			s_playermodel.picbuttons[k].generic.bottom   = y + 64;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+32
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ASGNI4
line 569
;569:			s_playermodel.picbuttons[k].width  		     = 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+80
ADDP4
CNSTI4 128
ASGNI4
line 570
;570:			s_playermodel.picbuttons[k].height  		 = 128;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+84
ADDP4
CNSTI4 128
ASGNI4
line 571
;571:			s_playermodel.picbuttons[k].focuspic  		 = MODEL_SELECT;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+64
ADDP4
ADDRGP4 $70
ASGNP4
line 572
;572:			s_playermodel.picbuttons[k].focuscolor  	 = colorRed;
ADDRLP4 0
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760+88
ADDP4
ADDRGP4 colorRed
ASGNP4
line 574
;573:
;574:			x += 64+6;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 575
;575:		}
LABELV $376
line 548
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
LTI4 $375
line 576
;576:		y += 64+6;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 70
ADDI4
ASGNI4
line 577
;577:	}
LABELV $372
line 545
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $374
ADDRLP4 16
INDIRI4
CNSTI4 4
LTI4 $371
line 579
;578:
;579:	s_playermodel.playername.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4196
CNSTI4 9
ASGNI4
line 580
;580:	s_playermodel.playername.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4196+44
CNSTU4 16392
ASGNU4
line 581
;581:	s_playermodel.playername.generic.x	   = 320;
ADDRGP4 s_playermodel+4196+12
CNSTI4 320
ASGNI4
line 582
;582:	s_playermodel.playername.generic.y	   = 440;
ADDRGP4 s_playermodel+4196+16
CNSTI4 440
ASGNI4
line 583
;583:	s_playermodel.playername.string	       = playername;
ADDRGP4 s_playermodel+4196+64
ADDRGP4 $314
ASGNP4
line 584
;584:	s_playermodel.playername.style		   = UI_CENTER;
ADDRGP4 s_playermodel+4196+68
CNSTI4 1
ASGNI4
line 585
;585:	s_playermodel.playername.color         = text_color_normal;
ADDRGP4 s_playermodel+4196+72
ADDRGP4 text_color_normal
ASGNP4
line 587
;586:
;587:	s_playermodel.modelname.generic.type  = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4044
CNSTI4 9
ASGNI4
line 588
;588:	s_playermodel.modelname.generic.flags = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4044+44
CNSTU4 16392
ASGNU4
line 589
;589:	s_playermodel.modelname.generic.x	  = 497;
ADDRGP4 s_playermodel+4044+12
CNSTI4 497
ASGNI4
line 590
;590:	s_playermodel.modelname.generic.y	  = 54;
ADDRGP4 s_playermodel+4044+16
CNSTI4 54
ASGNI4
line 591
;591:	s_playermodel.modelname.string	      = modelname;
ADDRGP4 s_playermodel+4044+64
ADDRGP4 $315
ASGNP4
line 592
;592:	s_playermodel.modelname.style		  = UI_CENTER;
ADDRGP4 s_playermodel+4044+68
CNSTI4 1
ASGNI4
line 593
;593:	s_playermodel.modelname.color         = text_color_normal;
ADDRGP4 s_playermodel+4044+72
ADDRGP4 text_color_normal
ASGNP4
line 595
;594:
;595:	s_playermodel.skinname.generic.type   = MTYPE_PTEXT;
ADDRGP4 s_playermodel+4120
CNSTI4 9
ASGNI4
line 596
;596:	s_playermodel.skinname.generic.flags  = QMF_CENTER_JUSTIFY|QMF_INACTIVE;
ADDRGP4 s_playermodel+4120+44
CNSTU4 16392
ASGNU4
line 597
;597:	s_playermodel.skinname.generic.x	  = 497;
ADDRGP4 s_playermodel+4120+12
CNSTI4 497
ASGNI4
line 598
;598:	s_playermodel.skinname.generic.y	  = 394;
ADDRGP4 s_playermodel+4120+16
CNSTI4 394
ASGNI4
line 599
;599:	s_playermodel.skinname.string	      = skinname;
ADDRGP4 s_playermodel+4120+64
ADDRGP4 $316
ASGNP4
line 600
;600:	s_playermodel.skinname.style		  = UI_CENTER;
ADDRGP4 s_playermodel+4120+68
CNSTI4 1
ASGNI4
line 601
;601:	s_playermodel.skinname.color          = text_color_normal;
ADDRGP4 s_playermodel+4120+72
ADDRGP4 text_color_normal
ASGNP4
line 603
;602:
;603:	s_playermodel.player.generic.type      = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3676
CNSTI4 6
ASGNI4
line 604
;604:	s_playermodel.player.generic.flags     = QMF_INACTIVE;
ADDRGP4 s_playermodel+3676+44
CNSTU4 16384
ASGNU4
line 605
;605:	s_playermodel.player.generic.ownerdraw = PlayerModel_DrawPlayer;
ADDRGP4 s_playermodel+3676+56
ADDRGP4 PlayerModel_DrawPlayer
ASGNP4
line 606
;606:	s_playermodel.player.generic.x	       = 400;
ADDRGP4 s_playermodel+3676+12
CNSTI4 400
ASGNI4
line 607
;607:	s_playermodel.player.generic.y	       = -40;
ADDRGP4 s_playermodel+3676+16
CNSTI4 -40
ASGNI4
line 608
;608:	s_playermodel.player.width	           = 32*10;
ADDRGP4 s_playermodel+3676+80
CNSTI4 320
ASGNI4
line 609
;609:	s_playermodel.player.height            = 56*10;
ADDRGP4 s_playermodel+3676+84
CNSTI4 560
ASGNI4
line 611
;610:
;611:	s_playermodel.arrows.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_playermodel+3768
CNSTI4 6
ASGNI4
line 612
;612:	s_playermodel.arrows.generic.name		= MODEL_ARROWS;
ADDRGP4 s_playermodel+3768+4
ADDRGP4 $75
ASGNP4
line 613
;613:	s_playermodel.arrows.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_playermodel+3768+44
CNSTU4 16384
ASGNU4
line 614
;614:	s_playermodel.arrows.generic.x			= 125;
ADDRGP4 s_playermodel+3768+12
CNSTI4 125
ASGNI4
line 615
;615:	s_playermodel.arrows.generic.y			= 340;
ADDRGP4 s_playermodel+3768+16
CNSTI4 340
ASGNI4
line 616
;616:	s_playermodel.arrows.width				= 128;
ADDRGP4 s_playermodel+3768+80
CNSTI4 128
ASGNI4
line 617
;617:	s_playermodel.arrows.height				= 32;
ADDRGP4 s_playermodel+3768+84
CNSTI4 32
ASGNI4
line 619
;618:
;619:	s_playermodel.left.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_playermodel+3860
CNSTI4 6
ASGNI4
line 620
;620:	s_playermodel.left.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3860+44
CNSTU4 260
ASGNU4
line 621
;621:	s_playermodel.left.generic.callback		= PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3860+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 622
;622:	s_playermodel.left.generic.id			= ID_PREVPAGE;
ADDRGP4 s_playermodel+3860+8
CNSTI4 100
ASGNI4
line 623
;623:	s_playermodel.left.generic.x			= 125;
ADDRGP4 s_playermodel+3860+12
CNSTI4 125
ASGNI4
line 624
;624:	s_playermodel.left.generic.y			= 340;
ADDRGP4 s_playermodel+3860+16
CNSTI4 340
ASGNI4
line 625
;625:	s_playermodel.left.width  				= 64;
ADDRGP4 s_playermodel+3860+80
CNSTI4 64
ASGNI4
line 626
;626:	s_playermodel.left.height  				= 32;
ADDRGP4 s_playermodel+3860+84
CNSTI4 32
ASGNI4
line 627
;627:	s_playermodel.left.focuspic				= MODEL_ARROWSL;
ADDRGP4 s_playermodel+3860+64
ADDRGP4 $76
ASGNP4
line 629
;628:
;629:	s_playermodel.right.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3952
CNSTI4 6
ASGNI4
line 630
;630:	s_playermodel.right.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3952+44
CNSTU4 260
ASGNU4
line 631
;631:	s_playermodel.right.generic.callback	= PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3952+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 632
;632:	s_playermodel.right.generic.id			= ID_NEXTPAGE;
ADDRGP4 s_playermodel+3952+8
CNSTI4 101
ASGNI4
line 633
;633:	s_playermodel.right.generic.x			= 125+61;
ADDRGP4 s_playermodel+3952+12
CNSTI4 186
ASGNI4
line 634
;634:	s_playermodel.right.generic.y			= 340;
ADDRGP4 s_playermodel+3952+16
CNSTI4 340
ASGNI4
line 635
;635:	s_playermodel.right.width  				= 64;
ADDRGP4 s_playermodel+3952+80
CNSTI4 64
ASGNI4
line 636
;636:	s_playermodel.right.height  		    = 32;
ADDRGP4 s_playermodel+3952+84
CNSTI4 32
ASGNI4
line 637
;637:	s_playermodel.right.focuspic			= MODEL_ARROWSR;
ADDRGP4 s_playermodel+3952+64
ADDRGP4 $77
ASGNP4
line 639
;638:
;639:	s_playermodel.back.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_playermodel+3584
CNSTI4 6
ASGNI4
line 640
;640:	s_playermodel.back.generic.name     = MODEL_BACK0;
ADDRGP4 s_playermodel+3584+4
ADDRGP4 $68
ASGNP4
line 641
;641:	s_playermodel.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_playermodel+3584+44
CNSTU4 260
ASGNU4
line 642
;642:	s_playermodel.back.generic.callback = PlayerModel_MenuEvent;
ADDRGP4 s_playermodel+3584+48
ADDRGP4 PlayerModel_MenuEvent
ASGNP4
line 643
;643:	s_playermodel.back.generic.id	    = ID_BACK;
ADDRGP4 s_playermodel+3584+8
CNSTI4 102
ASGNI4
line 644
;644:	s_playermodel.back.generic.x		= 0;
ADDRGP4 s_playermodel+3584+12
CNSTI4 0
ASGNI4
line 645
;645:	s_playermodel.back.generic.y		= 480-64;
ADDRGP4 s_playermodel+3584+16
CNSTI4 416
ASGNI4
line 646
;646:	s_playermodel.back.width  		    = 128;
ADDRGP4 s_playermodel+3584+80
CNSTI4 128
ASGNI4
line 647
;647:	s_playermodel.back.height  		    = 64;
ADDRGP4 s_playermodel+3584+84
CNSTI4 64
ASGNI4
line 648
;648:	s_playermodel.back.focuspic         = MODEL_BACK1;
ADDRGP4 s_playermodel+3584+64
ADDRGP4 $69
ASGNP4
line 650
;649:
;650:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.banner );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3508
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 651
;651:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framel );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3232
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 652
;652:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.framer );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3324
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 653
;653:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.ports );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3416
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 654
;654:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.playername );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4196
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 655
;655:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.modelname );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4044
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 656
;656:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.skinname );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+4120
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 658
;657:
;658:	for (i=0; i<MAX_MODELSPERPAGE; i++)
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $546
line 659
;659:	{
line 660
;660:		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.pics[i] );
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 661
;661:		Menu_AddItem( &s_playermodel.menu,	&s_playermodel.picbuttons[i] );
ADDRGP4 s_playermodel
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+1760
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 662
;662:	}
LABELV $547
line 658
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 16
LTI4 $546
line 664
;663:
;664:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.player );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3676
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 665
;665:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.arrows );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3768
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 666
;666:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.left );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3860
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 667
;667:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.right );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3952
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 668
;668:	Menu_AddItem( &s_playermodel.menu,	&s_playermodel.back );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+3584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 674
;669:
;670:	// find all available models
;671://	PlayerModel_BuildList();
;672:
;673:	// set initial states
;674:	PlayerModel_SetMenuItems();
ADDRGP4 PlayerModel_SetMenuItems
CALLV
pop
line 677
;675:
;676:	// update user interface
;677:	PlayerModel_UpdateGrid();
ADDRGP4 PlayerModel_UpdateGrid
CALLV
pop
line 678
;678:	PlayerModel_UpdateModel();
ADDRGP4 PlayerModel_UpdateModel
CALLV
pop
line 679
;679:}
LABELV $313
endproc PlayerModel_MenuInit 24 12
export PlayerModel_Cache
proc PlayerModel_Cache 4 4
line 687
;680:
;681:/*
;682:=================
;683:PlayerModel_Cache
;684:=================
;685:*/
;686:void PlayerModel_Cache( void )
;687:{
line 690
;688:	int	i;
;689:
;690:	for( i = 0; playermodel_artlist[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $561
JUMPV
LABELV $558
line 691
;691:		trap_R_RegisterShaderNoMip( playermodel_artlist[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playermodel_artlist
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 692
;692:	}
LABELV $559
line 690
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $561
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 playermodel_artlist
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $558
line 694
;693:
;694:	PlayerModel_BuildList();
ADDRGP4 PlayerModel_BuildList
CALLV
pop
line 695
;695:	for( i = 0; i < s_playermodel.nummodels; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $565
JUMPV
LABELV $562
line 696
;696:		trap_R_RegisterShaderNoMip( s_playermodel.modelnames[i] );
ADDRLP4 0
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 s_playermodel+5384
ADDP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 697
;697:	}
LABELV $563
line 695
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $565
ADDRLP4 0
INDIRI4
ADDRGP4 s_playermodel+5380
INDIRI4
LTI4 $562
line 698
;698:}
LABELV $557
endproc PlayerModel_Cache 4 4
export UI_PlayerModelMenu
proc UI_PlayerModelMenu 0 8
line 701
;699:
;700:void UI_PlayerModelMenu(void)
;701:{
line 702
;702:	PlayerModel_MenuInit();
ADDRGP4 PlayerModel_MenuInit
CALLV
pop
line 704
;703:
;704:	UI_PushMenu( &s_playermodel.menu );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 706
;705:
;706:	Menu_SetCursorToItem( &s_playermodel.menu, &s_playermodel.pics[s_playermodel.selectedmodel % MAX_MODELSPERPAGE] );
ADDRGP4 s_playermodel
ARGP4
ADDRGP4 s_playermodel+38224
INDIRI4
CNSTI4 16
MODI4
CNSTI4 92
MULI4
ADDRGP4 s_playermodel+288
ADDP4
ARGP4
ADDRGP4 Menu_SetCursorToItem
CALLV
pop
line 707
;707:}
LABELV $568
endproc UI_PlayerModelMenu 0 8
bss
align 4
LABELV s_playermodel
skip 38228
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
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
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
LABELV $327
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $282
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $272
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
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 119
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $269
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
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $256
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
byte 1 0
align 1
LABELV $254
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $253
byte 1 46
byte 1 0
align 1
LABELV $243
byte 1 47
byte 1 0
align 1
LABELV $242
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
byte 1 0
align 1
LABELV $239
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
LABELV $235
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 77
byte 1 69
byte 1 77
byte 1 79
byte 1 82
byte 1 89
byte 1 0
align 1
LABELV $212
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 0
align 1
LABELV $211
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
byte 1 0
align 1
LABELV $146
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
LABELV $144
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $77
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
LABELV $76
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
LABELV $75
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
LABELV $74
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $73
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
LABELV $72
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
byte 1 108
byte 1 0
align 1
LABELV $71
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
LABELV $70
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
LABELV $69
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
LABELV $68
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
