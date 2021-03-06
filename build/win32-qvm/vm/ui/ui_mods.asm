code
proc UI_Mods_MenuEvent 8 8
file "..\..\..\..\code\q3_ui\ui_mods.c"
line 51
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:#define ART_BACK0			"menu/art/back_0"
;6:#define ART_BACK1			"menu/art/back_1"	
;7:#define ART_FIGHT0			"menu/art/load_0"
;8:#define ART_FIGHT1			"menu/art/load_1"
;9:#define ART_FRAMEL			"menu/art/frame2_l"
;10:#define ART_FRAMER			"menu/art/frame1_r"
;11:
;12:#define MAX_MODS			64
;13:#define NAMEBUFSIZE			( MAX_MODS * 48 )
;14:#define GAMEBUFSIZE			( MAX_MODS * 16 )
;15:
;16:#define ID_BACK				10
;17:#define ID_GO				11
;18:#define ID_LIST				12
;19:
;20:
;21:typedef struct {
;22:	menuframework_s	menu;
;23:
;24:	menutext_s		banner;
;25:	menubitmap_s	framel;
;26:	menubitmap_s	framer;
;27:
;28:	menulist_s		list;
;29:
;30:	menubitmap_s	back;
;31:	menubitmap_s	go;
;32:
;33:	char			description[NAMEBUFSIZE];
;34:	char			fs_game[GAMEBUFSIZE];
;35:
;36:	char			*descriptionPtr;
;37:	char			*fs_gamePtr;
;38:
;39:	char			*descriptionList[MAX_MODS];
;40:	char			*fs_gameList[MAX_MODS];
;41:} mods_t;
;42:
;43:static mods_t	s_mods;
;44:
;45:
;46:/*
;47:===============
;48:UI_Mods_MenuEvent
;49:===============
;50:*/
;51:static void UI_Mods_MenuEvent( void *ptr, int event ) {
line 52
;52:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $70
line 53
;53:		return;
ADDRGP4 $69
JUMPV
LABELV $70
line 56
;54:	}
;55:
;56:	switch ( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $81
ADDRLP4 0
INDIRI4
CNSTI4 11
EQI4 $75
ADDRGP4 $72
JUMPV
LABELV $75
line 58
;57:	case ID_GO:
;58:		trap_Cvar_Set( "fs_game", s_mods.fs_gameList[s_mods.list.curvalue] );
ADDRGP4 $76
ARGP4
ADDRGP4 s_mods+548+68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_mods+5200
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 59
;59:		trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $80
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 60
;60:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 61
;61:		break;
ADDRGP4 $73
JUMPV
LABELV $81
line 64
;62:
;63:	case ID_BACK:
;64:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 65
;65:		break;
LABELV $72
LABELV $73
line 67
;66:	}
;67:}
LABELV $69
endproc UI_Mods_MenuEvent 8 8
proc UI_Mods_ParseInfos 20 12
line 75
;68:
;69:
;70:/*
;71:===============
;72:UI_Mods_ParseInfos
;73:===============
;74:*/
;75:static void UI_Mods_ParseInfos( char *modDir, char *modDesc ) {
line 76
;76:	s_mods.fs_gameList[s_mods.list.numitems] = s_mods.fs_gamePtr;
ADDRGP4 s_mods+548+72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_mods+5200
ADDP4
ADDRGP4 s_mods+4940
INDIRP4
ASGNP4
line 77
;77:	Q_strncpyz( s_mods.fs_gamePtr, modDir, 16 );
ADDRGP4 s_mods+4940
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 79
;78:
;79:	s_mods.descriptionList[s_mods.list.numitems] = s_mods.descriptionPtr;
ADDRGP4 s_mods+548+72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_mods+4944
ADDP4
ADDRGP4 s_mods+4936
INDIRP4
ASGNP4
line 80
;80:	Q_strncpyz( s_mods.descriptionPtr, modDesc, 48 );
ADDRGP4 s_mods+4936
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 48
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 82
;81:
;82:	s_mods.list.itemnames[s_mods.list.numitems] = s_mods.descriptionPtr;
ADDRGP4 s_mods+548+72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 s_mods+548+88
INDIRP4
ADDP4
ADDRGP4 s_mods+4936
INDIRP4
ASGNP4
line 83
;83:	s_mods.descriptionPtr += strlen( s_mods.descriptionPtr ) + 1;
ADDRGP4 s_mods+4936
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRGP4 s_mods+4936
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
INDIRP4
ADDP4
ASGNP4
line 84
;84:	s_mods.fs_gamePtr += strlen( s_mods.fs_gamePtr ) + 1;
ADDRGP4 s_mods+4940
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRGP4 s_mods+4940
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 12
INDIRP4
INDIRP4
ADDP4
ASGNP4
line 85
;85:	s_mods.list.numitems++;
ADDRLP4 16
ADDRGP4 s_mods+548+72
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 86
;86:}
LABELV $82
endproc UI_Mods_ParseInfos 20 12
proc UI_Mods_LoadMods 2084 16
line 94
;87:
;88:
;89:/*
;90:===============
;91:UI_Mods_LoadMods
;92:===============
;93:*/
;94:static void UI_Mods_LoadMods( void ) {
line 102
;95:	int		numdirs;
;96:	char	dirlist[2048];
;97:	char	*dirptr;
;98:  char  *descptr;
;99:	int		i;
;100:	int		dirlen;
;101:
;102:	s_mods.list.itemnames = (const char **)s_mods.descriptionList;
ADDRGP4 s_mods+548+88
ADDRGP4 s_mods+4944
ASGNP4
line 103
;103:	s_mods.descriptionPtr = s_mods.description;
ADDRGP4 s_mods+4936
ADDRGP4 s_mods+840
ASGNP4
line 104
;104:	s_mods.fs_gamePtr = s_mods.fs_game;
ADDRGP4 s_mods+4940
ADDRGP4 s_mods+3912
ASGNP4
line 107
;105:
;106:	// always start off with baseq3
;107:	s_mods.list.numitems = 1;
ADDRGP4 s_mods+548+72
CNSTI4 1
ASGNI4
line 108
;108:	s_mods.list.itemnames[0] = s_mods.descriptionList[0] = "Quake III Arena";
ADDRLP4 2068
ADDRGP4 $117
ASGNP4
ADDRGP4 s_mods+4944
ADDRLP4 2068
INDIRP4
ASGNP4
ADDRGP4 s_mods+548+88
INDIRP4
ADDRLP4 2068
INDIRP4
ASGNP4
line 109
;109:	s_mods.fs_gameList[0] = "";
ADDRGP4 s_mods+5200
ADDRGP4 $119
ASGNP4
line 111
;110:
;111:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $120
ARGP4
ADDRGP4 $119
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2072
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2072
INDIRI4
ASGNI4
line 112
;112:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 113
;113:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 114
;114:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 2076
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 115
;115:		descptr = dirptr + dirlen;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 116
;116:		UI_Mods_ParseInfos( dirptr, descptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 UI_Mods_ParseInfos
CALLV
pop
line 117
;117:		dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ADDRLP4 2080
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 118
;118:	}
LABELV $122
line 113
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $121
line 120
;119:
;120:	trap_Print( va( "%i mods parsed\n", s_mods.list.numitems ) );
ADDRGP4 $125
ARGP4
ADDRGP4 s_mods+548+72
INDIRI4
ARGI4
ADDRLP4 2076
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2076
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 121
;121:	if (s_mods.list.numitems > MAX_MODS) {
ADDRGP4 s_mods+548+72
INDIRI4
CNSTI4 64
LEI4 $128
line 122
;122:		s_mods.list.numitems = MAX_MODS;
ADDRGP4 s_mods+548+72
CNSTI4 64
ASGNI4
line 123
;123:	}
LABELV $128
line 124
;124:}
LABELV $104
endproc UI_Mods_LoadMods 2084 16
proc UI_Mods_MenuInit 0 12
line 132
;125:
;126:
;127:/*
;128:===============
;129:UI_Mods_MenuInit
;130:===============
;131:*/
;132:static void UI_Mods_MenuInit( void ) {
line 133
;133:	UI_ModsMenu_Cache();
ADDRGP4 UI_ModsMenu_Cache
CALLV
pop
line 135
;134:
;135:	memset( &s_mods, 0 ,sizeof(mods_t) );
ADDRGP4 s_mods
ARGP4
CNSTI4 0
ARGI4
CNSTI4 5456
ARGI4
ADDRGP4 memset
CALLP4
pop
line 136
;136:	s_mods.menu.wrapAround = qtrue;
ADDRGP4 s_mods+276
CNSTI4 1
ASGNI4
line 137
;137:	s_mods.menu.fullscreen = qtrue;
ADDRGP4 s_mods+280
CNSTI4 1
ASGNI4
line 139
;138:
;139:	s_mods.banner.generic.type		= MTYPE_BTEXT;
ADDRGP4 s_mods+288
CNSTI4 10
ASGNI4
line 140
;140:	s_mods.banner.generic.x			= 320;
ADDRGP4 s_mods+288+12
CNSTI4 320
ASGNI4
line 141
;141:	s_mods.banner.generic.y			= 16;
ADDRGP4 s_mods+288+16
CNSTI4 16
ASGNI4
line 142
;142:	s_mods.banner.string			= "MODS";
ADDRGP4 s_mods+288+64
ADDRGP4 $144
ASGNP4
line 143
;143:	s_mods.banner.color				= color_white;
ADDRGP4 s_mods+288+72
ADDRGP4 color_white
ASGNP4
line 144
;144:	s_mods.banner.style				= UI_CENTER;
ADDRGP4 s_mods+288+68
CNSTI4 1
ASGNI4
line 146
;145:
;146:	s_mods.framel.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_mods+364
CNSTI4 6
ASGNI4
line 147
;147:	s_mods.framel.generic.name		= ART_FRAMEL;
ADDRGP4 s_mods+364+4
ADDRGP4 $152
ASGNP4
line 148
;148:	s_mods.framel.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_mods+364+44
CNSTU4 16384
ASGNU4
line 149
;149:	s_mods.framel.generic.x			= 0;  
ADDRGP4 s_mods+364+12
CNSTI4 0
ASGNI4
line 150
;150:	s_mods.framel.generic.y			= 78;
ADDRGP4 s_mods+364+16
CNSTI4 78
ASGNI4
line 151
;151:	s_mods.framel.width				= 256;
ADDRGP4 s_mods+364+80
CNSTI4 256
ASGNI4
line 152
;152:	s_mods.framel.height			= 329;
ADDRGP4 s_mods+364+84
CNSTI4 329
ASGNI4
line 154
;153:
;154:	s_mods.framer.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_mods+456
CNSTI4 6
ASGNI4
line 155
;155:	s_mods.framer.generic.name		= ART_FRAMER;
ADDRGP4 s_mods+456+4
ADDRGP4 $166
ASGNP4
line 156
;156:	s_mods.framer.generic.flags		= QMF_INACTIVE;
ADDRGP4 s_mods+456+44
CNSTU4 16384
ASGNU4
line 157
;157:	s_mods.framer.generic.x			= 376;
ADDRGP4 s_mods+456+12
CNSTI4 376
ASGNI4
line 158
;158:	s_mods.framer.generic.y			= 76;
ADDRGP4 s_mods+456+16
CNSTI4 76
ASGNI4
line 159
;159:	s_mods.framer.width				= 256;
ADDRGP4 s_mods+456+80
CNSTI4 256
ASGNI4
line 160
;160:	s_mods.framer.height			= 334;
ADDRGP4 s_mods+456+84
CNSTI4 334
ASGNI4
line 162
;161:
;162:	s_mods.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 s_mods+656
CNSTI4 6
ASGNI4
line 163
;163:	s_mods.back.generic.name		= ART_BACK0;
ADDRGP4 s_mods+656+4
ADDRGP4 $180
ASGNP4
line 164
;164:	s_mods.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_mods+656+44
CNSTU4 260
ASGNU4
line 165
;165:	s_mods.back.generic.id			= ID_BACK;
ADDRGP4 s_mods+656+8
CNSTI4 10
ASGNI4
line 166
;166:	s_mods.back.generic.callback	= UI_Mods_MenuEvent;
ADDRGP4 s_mods+656+48
ADDRGP4 UI_Mods_MenuEvent
ASGNP4
line 167
;167:	s_mods.back.generic.x			= 0;
ADDRGP4 s_mods+656+12
CNSTI4 0
ASGNI4
line 168
;168:	s_mods.back.generic.y			= 480-64;
ADDRGP4 s_mods+656+16
CNSTI4 416
ASGNI4
line 169
;169:	s_mods.back.width				= 128;
ADDRGP4 s_mods+656+80
CNSTI4 128
ASGNI4
line 170
;170:	s_mods.back.height				= 64;
ADDRGP4 s_mods+656+84
CNSTI4 64
ASGNI4
line 171
;171:	s_mods.back.focuspic			= ART_BACK1;
ADDRGP4 s_mods+656+64
ADDRGP4 $197
ASGNP4
line 173
;172:
;173:	s_mods.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 s_mods+748
CNSTI4 6
ASGNI4
line 174
;174:	s_mods.go.generic.name			= ART_FIGHT0;
ADDRGP4 s_mods+748+4
ADDRGP4 $201
ASGNP4
line 175
;175:	s_mods.go.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_mods+748+44
CNSTU4 272
ASGNU4
line 176
;176:	s_mods.go.generic.id			= ID_GO;
ADDRGP4 s_mods+748+8
CNSTI4 11
ASGNI4
line 177
;177:	s_mods.go.generic.callback		= UI_Mods_MenuEvent;
ADDRGP4 s_mods+748+48
ADDRGP4 UI_Mods_MenuEvent
ASGNP4
line 178
;178:	s_mods.go.generic.x				= 640;
ADDRGP4 s_mods+748+12
CNSTI4 640
ASGNI4
line 179
;179:	s_mods.go.generic.y				= 480-64;
ADDRGP4 s_mods+748+16
CNSTI4 416
ASGNI4
line 180
;180:	s_mods.go.width					= 128;
ADDRGP4 s_mods+748+80
CNSTI4 128
ASGNI4
line 181
;181:	s_mods.go.height				= 64;
ADDRGP4 s_mods+748+84
CNSTI4 64
ASGNI4
line 182
;182:	s_mods.go.focuspic				= ART_FIGHT1;
ADDRGP4 s_mods+748+64
ADDRGP4 $218
ASGNP4
line 185
;183:
;184:	// scan for mods
;185:	s_mods.list.generic.type		= MTYPE_SCROLLLIST;
ADDRGP4 s_mods+548
CNSTI4 8
ASGNI4
line 186
;186:	s_mods.list.generic.flags		= QMF_PULSEIFFOCUS|QMF_CENTER_JUSTIFY;
ADDRGP4 s_mods+548+44
CNSTU4 264
ASGNU4
line 187
;187:	s_mods.list.generic.callback	= UI_Mods_MenuEvent;
ADDRGP4 s_mods+548+48
ADDRGP4 UI_Mods_MenuEvent
ASGNP4
line 188
;188:	s_mods.list.generic.id			= ID_LIST;
ADDRGP4 s_mods+548+8
CNSTI4 12
ASGNI4
line 189
;189:	s_mods.list.generic.x			= 320;
ADDRGP4 s_mods+548+12
CNSTI4 320
ASGNI4
line 190
;190:	s_mods.list.generic.y			= 130;
ADDRGP4 s_mods+548+16
CNSTI4 130
ASGNI4
line 191
;191:	s_mods.list.width				= 48;
ADDRGP4 s_mods+548+92
CNSTI4 48
ASGNI4
line 192
;192:	s_mods.list.height				= 14;
ADDRGP4 s_mods+548+96
CNSTI4 14
ASGNI4
line 193
;193:	s_mods.list.scroll				= 1;
ADDRGP4 s_mods+548+80
CNSTI4 1
ASGNI4
line 195
;194:
;195:	UI_Mods_LoadMods();
ADDRGP4 UI_Mods_LoadMods
CALLV
pop
line 197
;196:
;197:	Menu_AddItem( &s_mods.menu, &s_mods.banner );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 198
;198:	Menu_AddItem( &s_mods.menu, &s_mods.framel );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+364
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 199
;199:	Menu_AddItem( &s_mods.menu, &s_mods.framer );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+456
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 200
;200:	Menu_AddItem( &s_mods.menu, &s_mods.list );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+548
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 201
;201:	Menu_AddItem( &s_mods.menu, &s_mods.back );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+656
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 202
;202:	Menu_AddItem( &s_mods.menu, &s_mods.go );
ADDRGP4 s_mods
ARGP4
ADDRGP4 s_mods+748
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 203
;203:}
LABELV $134
endproc UI_Mods_MenuInit 0 12
export UI_ModsMenu_Cache
proc UI_ModsMenu_Cache 0 4
line 210
;204:
;205:/*
;206:=================
;207:UI_Mods_Cache
;208:=================
;209:*/
;210:void UI_ModsMenu_Cache( void ) {
line 211
;211:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $180
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 212
;212:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $197
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 213
;213:	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
ADDRGP4 $201
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 214
;214:	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
ADDRGP4 $218
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 215
;215:	trap_R_RegisterShaderNoMip( ART_FRAMEL );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 216
;216:	trap_R_RegisterShaderNoMip( ART_FRAMER );
ADDRGP4 $166
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 217
;217:}
LABELV $242
endproc UI_ModsMenu_Cache 0 4
export UI_ModsMenu
proc UI_ModsMenu 0 4
line 225
;218:
;219:
;220:/*
;221:===============
;222:UI_ModsMenu
;223:===============
;224:*/
;225:void UI_ModsMenu( void ) {
line 226
;226:	UI_Mods_MenuInit();
ADDRGP4 UI_Mods_MenuInit
CALLV
pop
line 227
;227:	UI_PushMenu( &s_mods.menu );
ADDRGP4 s_mods
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 228
;228:}
LABELV $243
endproc UI_ModsMenu 0 4
bss
align 4
LABELV s_mods
skip 5456
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
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
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
LABELV $218
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $201
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $197
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
LABELV $180
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
LABELV $166
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
LABELV $152
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
LABELV $144
byte 1 77
byte 1 79
byte 1 68
byte 1 83
byte 1 0
align 1
LABELV $125
byte 1 37
byte 1 105
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $120
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $119
byte 1 0
align 1
LABELV $117
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $80
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $76
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
