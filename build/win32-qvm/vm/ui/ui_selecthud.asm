data
align 4
LABELV strPoolIndex
byte 4 0
export Get_cg_hudFiles
code
proc Get_cg_hudFiles 1028 12
file "..\..\..\..\code\q3_ui\ui_selecthud.c"
line 76
;1:/*
;2:=======================================================================
;3:
;4:SELECT HUD MENU
;5:
;6:=======================================================================
;7:*/
;8:
;9:#include "ui_local.h"
;10:
;11:#include "ui_HUDinfo.h"
;12:
;13:#define ART_BACK0			"menu/art/back_0"
;14:#define ART_BACK1			"menu/art/back_1"	
;15:#define ART_FIGHT0			"menu/art/accept_0"
;16:#define ART_FIGHT1			"menu/art/accept_1"
;17:#define ART_BACKGROUND		"menu/art/addbotframe"
;18:#define ART_ARROWS			"menu/art/arrows_vert_0"
;19:#define ART_ARROWUP			"menu/art/arrows_vert_top"
;20:#define ART_ARROWDOWN		"menu/art/arrows_vert_bot"
;21:
;22:#define ID_BACK				10
;23:#define ID_GO				11
;24:#define ID_LIST				12
;25:#define ID_UP				13
;26:#define ID_DOWN				14
;27:
;28:#define ID_SKILL			15
;29:#define ID_TEAM				16
;30:
;31:#define ID_HUDNAME0			20
;32:#define ID_HUDNAME1			21
;33:#define ID_HUDNAME2			22
;34:#define ID_HUDNAME3			23
;35:#define ID_HUDNAME4			24
;36:#define ID_HUDNAME5			25
;37:#define ID_HUDNAME6			26
;38:#define ID_HUDNAME7			27
;39:#define ID_HUDNAME8			28
;40:#define ID_HUDNAME9			29
;41:#define ID_HUDNAME10		30
;42:#define ID_HUDNAME11		31
;43:
;44:#define NB_VISIBLE_HUD		12
;45:
;46:typedef struct {
;47:	menuframework_s	menu;
;48:	menubitmap_s	arrows;
;49:	menubitmap_s	up;
;50:	menubitmap_s	down;
;51:	menutext_s		huds[NB_VISIBLE_HUD];
;52:	menubitmap_s	go;
;53:	menubitmap_s	back;
;54:
;55:	int				numHuds;
;56:	int				delay;//GUNNM what is it used for?
;57:	int				baseHudNum;
;58:	int				selectedHudNum;
;59:	int				sortedHudNums[MAX_HUD_ITEM];
;60:	char			hudnames[NB_VISIBLE_HUD][32];
;61:	char			cg_hudFiles[MAX_HUD_FILEPATH];//the selected HUD path from cvar_t
;62:} selectHudMenuInfo_t;
;63:
;64:static selectHudMenuInfo_t	HudInfo;
;65:
;66:static nameList_Def_t hudNameList[MAX_HUD_ITEM];
;67:
;68:
;69:/*
;70:=================
;71:Get_cg_hudFiles
;72:Get the cvar_t cg_hudFiles
;73:=================
;74:*/
;75:char * Get_cg_hudFiles( void )
;76:{
line 79
;77:	char buff[1024];
;78:	char *hudSet;
;79:	memset(buff, 0, sizeof(buff));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 81
;80:
;81:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
ADDRGP4 $71
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 82
;82:	hudSet = buff;
ADDRLP4 1024
ADDRLP4 0
ASGNP4
line 83
;83:	if (hudSet[0] == '\0') {
ADDRLP4 1024
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $72
line 84
;84:		hudSet = DEFAULT_HUD;
ADDRLP4 1024
ADDRGP4 $74
ASGNP4
line 85
;85:	}
LABELV $72
line 86
;86:	return hudSet;
ADDRLP4 1024
INDIRP4
RETP4
LABELV $70
endproc Get_cg_hudFiles 1028 12
export Set_cg_hudFiles
proc Set_cg_hudFiles 4 12
line 97
;87:}
;88:
;89:
;90:/*
;91:=================
;92:Set_cg_hudFiles
;93:Set the cvar_t cg_hudFiles
;94:=================
;95:*/
;96:void Set_cg_hudFiles()
;97:{
line 99
;98:	int hudId;
;99:	hudId = HudInfo.selectedHudNum + HudInfo.baseHudNum;
ADDRLP4 0
ADDRGP4 HudInfo+1672
INDIRI4
ADDRGP4 HudInfo+1668
INDIRI4
ADDI4
ASGNI4
line 101
;100:
;101:	trap_Cvar_Set("cg_hudFiles", hudNameList[hudId].filePath);
ADDRGP4 $71
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 103
;102:
;103:	Q_strncpyz(HudInfo.cg_hudFiles, hudNameList[hudId].filePath, sizeof(HudInfo.cg_hudFiles));
ADDRGP4 HudInfo+2316
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList
ADDP4
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 104
;104:}
LABELV $75
endproc Set_cg_hudFiles 4 12
export CG_ParseInfo_HUD_File
proc CG_ParseInfo_HUD_File 180 12
line 114
;105:
;106:
;107:/*
;108:=================
;109:CG_ParseInfo_HUD_File
;110:create a new HUD in the list
;111:then parse basic info only (name, author, description)
;112:=================
;113:*/
;114:qboolean CG_ParseInfo_HUD_File(char *filePath) {
line 118
;115:	int handle;
;116:	int lenPath;
;117:	char fileName[128];
;118:	char *ext = "hud/";
ADDRLP4 144
ADDRGP4 $81
ASGNP4
line 122
;119:	qboolean res;
;120:	nameList_Def_t *HudNameInfo;
;121:
;122:	if (HudInfo.numHuds >= MAX_HUD_ITEM) {
ADDRGP4 HudInfo+1660
INDIRI4
CNSTI4 64
LTI4 $82
line 123
;123:		Com_Printf("Error: Too many HUD files! (%i >= %i)\n", HudInfo.numHuds, MAX_HUD_ITEM);
ADDRGP4 $85
ARGP4
ADDRGP4 HudInfo+1660
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 124
;124:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $80
JUMPV
LABELV $82
line 127
;125:	}
;126:
;127:	handle = trap_PC_LoadSource(filePath);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
line 128
;128:	if (!handle) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $87
line 129
;129:		Com_Printf("Error: HUD file <%s> not found\n", filePath);
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 130
;130:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $80
JUMPV
LABELV $87
line 134
;131:	}
;132:
;133:	// get filename by removing folder path and extension
;134:	lenPath = strlen(ext);
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 152
INDIRI4
ASGNI4
line 135
;135:	Q_strncpyz(fileName, filePath + lenPath, strlen(filePath) - lenPath - 3);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRLP4 156
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 3
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 137
;136:
;137:	HudNameInfo = &hudNameList[HudInfo.numHuds];
ADDRLP4 0
ADDRGP4 HudInfo+1660
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList
ADDP4
ASGNP4
line 138
;138:	memset(HudNameInfo, 0, sizeof(nameList_Def_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 140
;139:
;140:	HudNameInfo->filePath = String_Alloc(filePath);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 164
INDIRP4
ASGNP4
line 141
;141:	HudNameInfo->fileName = String_Alloc(fileName);
ADDRLP4 16
ARGP4
ADDRLP4 168
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 168
INDIRP4
ASGNP4
line 143
;142:
;143:	res = elem_Info_Parse(handle, HudNameInfo);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 elem_Info_Parse
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 172
INDIRI4
ASGNI4
line 144
;144:	if (res) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $91
line 145
;145:		HudInfo.numHuds++;
ADDRLP4 176
ADDRGP4 HudInfo+1660
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 146
;146:	}
LABELV $91
line 148
;147:
;148:	trap_PC_FreeSource(handle);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 150
;149:
;150:	return res;
ADDRLP4 12
INDIRI4
RETI4
LABELV $80
endproc CG_ParseInfo_HUD_File 180 12
export ParseInfo_All_HUD_Files
proc ParseInfo_All_HUD_Files 2332 16
line 160
;151:}
;152:
;153:
;154:/*
;155:=================
;156:ParseInfo_All_HUD_Files
;157:get all cfg files in /hud folder then parse basic info
;158:=================
;159:*/
;160:void ParseInfo_All_HUD_Files( void ) {
line 169
;161:	int			numdirs;
;162:	char		filePath[MAX_HUD_FILEPATH];
;163:	char		dirlist[2048];// MAX_HUD_ITEM * MAX_HUD_FILEPATH ?
;164:	char*		dirptr;
;165:	int			i;
;166:	int			dirlen;
;167:
;168:	// clear HUD name list
;169:	memset(&hudNameList, 0, sizeof(hudNameList));
ADDRGP4 hudNameList
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1536
ARGI4
ADDRGP4 memset
CALLP4
pop
line 172
;170:
;171:	// get all cfg files in /hud folder
;172:	numdirs = trap_FS_GetFileList("hud", ".cfg", dirlist, sizeof(dirlist));
ADDRGP4 $95
ARGP4
ADDRGP4 $96
ARGP4
ADDRLP4 272
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2320
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 268
ADDRLP4 2320
INDIRI4
ASGNI4
line 173
;173:	dirptr = dirlist;
ADDRLP4 256
ADDRLP4 272
ASGNP4
line 177
;174:
;175://	Com_Error(ERR_DROP, "Error: numdirs: %i ", numdirs);
;176:
;177:	for ( i = 0; i < numdirs; i++, dirptr += dirlen + 1 ) {
ADDRLP4 264
CNSTI4 0
ASGNI4
ADDRGP4 $100
JUMPV
LABELV $97
line 179
;178:		// add path to filename //fixme: optimize
;179:		char *tmpPath = "hud/";
ADDRLP4 2324
ADDRGP4 $81
ASGNP4
line 180
;180:		memset(filePath, 0, sizeof(filePath));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 182
;181:
;182:		dirlen = strlen(dirptr);
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 2328
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 2328
INDIRI4
ASGNI4
line 183
;183:		memcpy(filePath, tmpPath, sizeof(tmpPath));
ADDRLP4 0
ARGP4
ADDRLP4 2324
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 184
;184:		memcpy(filePath + sizeof(tmpPath), dirptr, dirlen);
ADDRLP4 0+4
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 189
;185:
;186:		
;187:
;188:		// only parse the HUD info (full HUD will be parse on demand)
;189:		CG_ParseInfo_HUD_File( filePath );
ADDRLP4 0
ARGP4
ADDRGP4 CG_ParseInfo_HUD_File
CALLI4
pop
line 190
;190:	}
LABELV $98
line 177
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 256
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 256
INDIRP4
ADDP4
ASGNP4
LABELV $100
ADDRLP4 264
INDIRI4
ADDRLP4 268
INDIRI4
LTI4 $97
line 191
;191:}
LABELV $94
endproc ParseInfo_All_HUD_Files 2332 16
proc HUD_File_BuildList 8 12
line 199
;192:
;193:/*
;194:=================
;195:PlayerModel_BuildList
;196:load basic info from all cfg files in /hud
;197:=================
;198:*/
;199:static void HUD_File_BuildList( void ) {
line 202
;200:	char * buff;
;201:
;202:	HudInfo.selectedHudNum = MAX_HUD_ITEM; //avoid selection of first one
ADDRGP4 HudInfo+1672
CNSTI4 64
ASGNI4
line 205
;203:
;204:	// Get hashList to allow parsing
;205:	prop_SetupKeywordHash();
ADDRGP4 prop_SetupKeywordHash
CALLV
pop
line 208
;206:
;207:	// get selected HUD from cvar_t
;208:	buff = Get_cg_hudFiles();
ADDRLP4 4
ADDRGP4 Get_cg_hudFiles
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 209
;209:	Q_strncpyz(HudInfo.cg_hudFiles, buff, sizeof(HudInfo.cg_hudFiles));
ADDRGP4 HudInfo+2316
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 212
;210:
;211:	// only read name, author and description (INFO element)
;212:	ParseInfo_All_HUD_Files();
ADDRGP4 ParseInfo_All_HUD_Files
CALLV
pop
line 213
;213:}
LABELV $102
endproc HUD_File_BuildList 8 12
proc UI_HudMenu_SetHudNames 20 12
line 221
;214:
;215:
;216:/*
;217:=================
;218:UI_HudMenu_SetHudNames
;219:=================
;220:*/
;221:static void UI_HudMenu_SetHudNames( void ) {
line 227
;222:	int	i;
;223:
;224:	const char *HUDname;
;225:	const char *fileName;
;226:	const char *filePath;
;227:	HudInfo.selectedHudNum = MAX_HUD_ITEM;
ADDRGP4 HudInfo+1672
CNSTI4 64
ASGNI4
line 228
;228:	for ( i = 0; i < HudInfo.numHuds; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $108
line 229
;229:		HUDname  = hudNameList[HudInfo.baseHudNum + i].INFO.name;
ADDRLP4 4
ADDRGP4 HudInfo+1668
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList+12
ADDP4
INDIRP4
ASGNP4
line 230
;230:		fileName = hudNameList[HudInfo.baseHudNum + i].fileName;
ADDRLP4 12
ADDRGP4 HudInfo+1668
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList+4
ADDP4
INDIRP4
ASGNP4
line 231
;231:		filePath = hudNameList[HudInfo.baseHudNum + i].filePath;
ADDRLP4 8
ADDRGP4 HudInfo+1668
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 24
MULI4
ADDRGP4 hudNameList
ADDP4
INDIRP4
ASGNP4
line 233
;232:
;233:		HudInfo.huds[i].color = color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 235
;234:
;235:		if (strcmp(filePath, HudInfo.cg_hudFiles) == 0 )
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 HudInfo+2316
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $120
line 236
;236:		{
line 237
;237:			HudInfo.selectedHudNum = i;
ADDRGP4 HudInfo+1672
ADDRLP4 0
INDIRI4
ASGNI4
line 238
;238:			HudInfo.huds[i].color = color_white;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+72
ADDP4
ADDRGP4 color_white
ASGNP4
line 239
;239:		}
LABELV $120
line 242
;240:
;241:		// show filePath if name not defined
;242:		if (HUDname == '\0') {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $126
line 243
;243:			Q_strncpyz(HudInfo.hudnames[i], fileName, sizeof(HudInfo.hudnames[i]));
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 HudInfo+1932
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 244
;244:		}
ADDRGP4 $127
JUMPV
LABELV $126
line 245
;245:		else {
line 246
;246:			Q_strncpyz(HudInfo.hudnames[i], HUDname, sizeof(HudInfo.hudnames[i]));
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 HudInfo+1932
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 247
;247:		}
LABELV $127
line 248
;248:	}
LABELV $109
line 228
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $111
ADDRLP4 0
INDIRI4
ADDRGP4 HudInfo+1660
INDIRI4
LTI4 $108
line 249
;249:}
LABELV $106
endproc UI_HudMenu_SetHudNames 20 12
proc UI_HudMenu_UpEvent 4 0
line 257
;250:
;251:
;252:/*
;253:=================
;254:UI_HudMenu_UpEvent
;255:=================
;256:*/
;257:static void UI_HudMenu_UpEvent( void* ptr, int event ) {
line 258
;258:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $133
line 259
;259:		return;
ADDRGP4 $132
JUMPV
LABELV $133
line 262
;260:	}
;261:
;262:	if(HudInfo.baseHudNum > 0 ) {
ADDRGP4 HudInfo+1668
INDIRI4
CNSTI4 0
LEI4 $135
line 263
;263:		HudInfo.baseHudNum--;
ADDRLP4 0
ADDRGP4 HudInfo+1668
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 264
;264:		UI_HudMenu_SetHudNames();
ADDRGP4 UI_HudMenu_SetHudNames
CALLV
pop
line 265
;265:	}
LABELV $135
line 266
;266:}
LABELV $132
endproc UI_HudMenu_UpEvent 4 0
proc UI_HudMenu_AcceptEvent 0 0
line 274
;267:
;268:
;269:/*
;270:=================
;271:UI_HudMenu_AcceptEvent
;272:=================
;273:*/
;274:static void UI_HudMenu_AcceptEvent(void* ptr, int event) {
line 275
;275:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $140
line 276
;276:		return;
ADDRGP4 $139
JUMPV
LABELV $140
line 279
;277:	}
;278:
;279:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 280
;280:}
LABELV $139
endproc UI_HudMenu_AcceptEvent 0 0
proc UI_HudMenu_HudEvent 0 0
line 289
;281:
;282:
;283:/*
;284:=================
;285:UI_HudMenu_HudEvent
;286:keep selected HUD in cvar_t
;287:=================
;288:*/
;289:static void UI_HudMenu_HudEvent(void* ptr, int event) {
line 290
;290:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $143
line 291
;291:		return;
ADDRGP4 $142
JUMPV
LABELV $143
line 294
;292:	}
;293:
;294:	HudInfo.huds[HudInfo.selectedHudNum].color = color_orange;
ADDRGP4 HudInfo+1672
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 295
;295:	HudInfo.selectedHudNum = ((menucommon_s*)ptr)->id - ID_HUDNAME0;
ADDRGP4 HudInfo+1672
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
SUBI4
ASGNI4
line 296
;296:	HudInfo.huds[HudInfo.selectedHudNum].color = color_white;
ADDRGP4 HudInfo+1672
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+72
ADDP4
ADDRGP4 color_white
ASGNP4
line 298
;297:
;298:	Set_cg_hudFiles();
ADDRGP4 Set_cg_hudFiles
CALLV
pop
line 299
;299:}
LABELV $142
endproc UI_HudMenu_HudEvent 0 0
proc UI_HudMenu_BackEvent 0 0
line 307
;300:
;301:
;302:/*
;303:=================
;304:UI_HudMenu_BackEvent
;305:=================
;306:*/
;307:static void UI_HudMenu_BackEvent(void* ptr, int event) {
line 308
;308:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $153
line 309
;309:		return;
ADDRGP4 $152
JUMPV
LABELV $153
line 311
;310:	}
;311:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 312
;312:}
LABELV $152
endproc UI_HudMenu_BackEvent 0 0
proc UI_HudMenu_DownEvent 4 0
line 320
;313:
;314:
;315:/*
;316:=================
;317:UI_HudMenu_DownEvent
;318:=================
;319:*/
;320:static void UI_HudMenu_DownEvent( void* ptr, int event ) {
line 321
;321:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $156
line 322
;322:		return;
ADDRGP4 $155
JUMPV
LABELV $156
line 325
;323:	}
;324:	
;325:	if(HudInfo.baseHudNum + NB_VISIBLE_HUD < HudInfo.numHuds ) {
ADDRGP4 HudInfo+1668
INDIRI4
CNSTI4 12
ADDI4
ADDRGP4 HudInfo+1660
INDIRI4
GEI4 $158
line 326
;326:		HudInfo.baseHudNum++;
ADDRLP4 0
ADDRGP4 HudInfo+1668
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 327
;327:		UI_HudMenu_SetHudNames();
ADDRGP4 UI_HudMenu_SetHudNames
CALLV
pop
line 328
;328:	}
LABELV $158
line 329
;329:}
LABELV $155
endproc UI_HudMenu_DownEvent 4 0
proc UI_HudMenu_Draw 0 20
line 337
;330:
;331:
;332:/*
;333:=================
;334:UI_HudMenu_Draw
;335:=================
;336:*/
;337:static void UI_HudMenu_Draw( void ) {
line 338
;338:	UI_DrawBannerString( 320, 16, "SELECT HUD", UI_CENTER, color_white );
CNSTI4 320
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 $164
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawBannerString
CALLV
pop
line 339
;339:	UI_DrawNamedPic( 320-233, 240-166, 466, 332, ART_BACKGROUND );
CNSTF4 1118699520
ARGF4
CNSTF4 1116995584
ARGF4
CNSTF4 1139343360
ARGF4
CNSTF4 1134952448
ARGF4
ADDRGP4 $165
ARGP4
ADDRGP4 UI_DrawNamedPic
CALLV
pop
line 342
;340:
;341:	// standard menu drawing
;342:	Menu_Draw( &HudInfo.menu );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 343
;343:}
LABELV $163
endproc UI_HudMenu_Draw 0 20
proc UI_HudMenu_Init 24 12
line 346
;344:
;345:
;346:static void UI_HudMenu_Init( void ) {
line 351
;347:	int		n;
;348:	int		y;
;349:	int		count;
;350:
;351:	memset( &HudInfo, 0, sizeof(HudInfo) );
ADDRGP4 HudInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2572
ARGI4
ADDRGP4 memset
CALLP4
pop
line 352
;352:	HudInfo.menu.draw = UI_HudMenu_Draw;
ADDRGP4 HudInfo+268
ADDRGP4 UI_HudMenu_Draw
ASGNP4
line 353
;353:	HudInfo.menu.fullscreen = qfalse;
ADDRGP4 HudInfo+280
CNSTI4 0
ASGNI4
line 354
;354:	HudInfo.menu.wrapAround = qtrue;
ADDRGP4 HudInfo+276
CNSTI4 1
ASGNI4
line 355
;355:	HudInfo.delay = 1000;
ADDRGP4 HudInfo+1664
CNSTI4 1000
ASGNI4
line 357
;356:
;357:	UI_Hud_Cache();
ADDRGP4 UI_Hud_Cache
CALLV
pop
line 359
;358:
;359:	count = HudInfo.numHuds < NB_VISIBLE_HUD ? HudInfo.numHuds : NB_VISIBLE_HUD;
ADDRGP4 HudInfo+1660
INDIRI4
CNSTI4 12
GEI4 $174
ADDRLP4 12
ADDRGP4 HudInfo+1660
INDIRI4
ASGNI4
ADDRGP4 $175
JUMPV
LABELV $174
ADDRLP4 12
CNSTI4 12
ASGNI4
LABELV $175
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 361
;360:
;361:	HudInfo.arrows.generic.type	= MTYPE_BITMAP;
ADDRGP4 HudInfo+288
CNSTI4 6
ASGNI4
line 362
;362:	HudInfo.arrows.generic.name	= ART_ARROWS;
ADDRGP4 HudInfo+288+4
ADDRGP4 $179
ASGNP4
line 363
;363:	HudInfo.arrows.generic.flags= QMF_INACTIVE;
ADDRGP4 HudInfo+288+44
CNSTU4 16384
ASGNU4
line 364
;364:	HudInfo.arrows.generic.x	= 200;
ADDRGP4 HudInfo+288+12
CNSTI4 200
ASGNI4
line 365
;365:	HudInfo.arrows.generic.y	= 128;
ADDRGP4 HudInfo+288+16
CNSTI4 128
ASGNI4
line 366
;366:	HudInfo.arrows.width		= 64;
ADDRGP4 HudInfo+288+80
CNSTI4 64
ASGNI4
line 367
;367:	HudInfo.arrows.height		= 128;
ADDRGP4 HudInfo+288+84
CNSTI4 128
ASGNI4
line 369
;368:
;369:	HudInfo.up.generic.type		= MTYPE_BITMAP;
ADDRGP4 HudInfo+380
CNSTI4 6
ASGNI4
line 370
;370:	HudInfo.up.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 HudInfo+380+44
CNSTU4 260
ASGNU4
line 371
;371:	HudInfo.up.generic.x		= 200;
ADDRGP4 HudInfo+380+12
CNSTI4 200
ASGNI4
line 372
;372:	HudInfo.up.generic.y		= 128;
ADDRGP4 HudInfo+380+16
CNSTI4 128
ASGNI4
line 373
;373:	HudInfo.up.generic.id		= ID_UP;
ADDRGP4 HudInfo+380+8
CNSTI4 13
ASGNI4
line 374
;374:	HudInfo.up.generic.callback	= UI_HudMenu_UpEvent;
ADDRGP4 HudInfo+380+48
ADDRGP4 UI_HudMenu_UpEvent
ASGNP4
line 375
;375:	HudInfo.up.width  		    = 64;
ADDRGP4 HudInfo+380+80
CNSTI4 64
ASGNI4
line 376
;376:	HudInfo.up.height  		    = 64;
ADDRGP4 HudInfo+380+84
CNSTI4 64
ASGNI4
line 377
;377:	HudInfo.up.focuspic			= ART_ARROWUP;
ADDRGP4 HudInfo+380+64
ADDRGP4 $207
ASGNP4
line 379
;378:
;379:	HudInfo.down.generic.type	= MTYPE_BITMAP;
ADDRGP4 HudInfo+472
CNSTI4 6
ASGNI4
line 380
;380:	HudInfo.down.generic.flags  = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 HudInfo+472+44
CNSTU4 260
ASGNU4
line 381
;381:	HudInfo.down.generic.x		= 200;
ADDRGP4 HudInfo+472+12
CNSTI4 200
ASGNI4
line 382
;382:	HudInfo.down.generic.y		= 128+64;
ADDRGP4 HudInfo+472+16
CNSTI4 192
ASGNI4
line 383
;383:	HudInfo.down.generic.id	    = ID_DOWN;
ADDRGP4 HudInfo+472+8
CNSTI4 14
ASGNI4
line 384
;384:	HudInfo.down.generic.callback= UI_HudMenu_DownEvent;
ADDRGP4 HudInfo+472+48
ADDRGP4 UI_HudMenu_DownEvent
ASGNP4
line 385
;385:	HudInfo.down.width  		= 64;
ADDRGP4 HudInfo+472+80
CNSTI4 64
ASGNI4
line 386
;386:	HudInfo.down.height  		= 64;
ADDRGP4 HudInfo+472+84
CNSTI4 64
ASGNI4
line 387
;387:	HudInfo.down.focuspic       = ART_ARROWDOWN;
ADDRGP4 HudInfo+472+64
ADDRGP4 $225
ASGNP4
line 389
;388:
;389:	for( n = 0, y = 120; n < count; n++, y += SMALLCHAR_HEIGHT) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
CNSTI4 120
ASGNI4
ADDRGP4 $229
JUMPV
LABELV $226
line 390
;390:		HudInfo.huds[n].generic.type		= MTYPE_STEXT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564
ADDP4
CNSTI4 11
ASGNI4
line 391
;391:		HudInfo.huds[n].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+44
ADDP4
CNSTU4 262
ASGNU4
line 392
;392:		HudInfo.huds[n].generic.id			= ID_HUDNAME0 + n;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 393
;393:		HudInfo.huds[n].generic.x			= 320 - 56;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+12
ADDP4
CNSTI4 264
ASGNI4
line 394
;394:		HudInfo.huds[n].generic.y			= y;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 395
;395:		HudInfo.huds[n].generic.callback	= UI_HudMenu_HudEvent;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+48
ADDP4
ADDRGP4 UI_HudMenu_HudEvent
ASGNP4
line 396
;396:		HudInfo.huds[n].string				= HudInfo.hudnames[n];
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+64
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 HudInfo+1932
ADDP4
ASGNP4
line 397
;397:		HudInfo.huds[n].color				= color_orange;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+72
ADDP4
ADDRGP4 color_orange
ASGNP4
line 398
;398:		HudInfo.huds[n].style				= UI_LEFT; //| UI_LOWERCASE;// | UI_PULSE;
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564+68
ADDP4
CNSTI4 0
ASGNI4
line 399
;399:	}
LABELV $227
line 389
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
LABELV $229
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $226
line 401
;400:
;401:	HudInfo.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 HudInfo+1476
CNSTI4 6
ASGNI4
line 402
;402:	HudInfo.go.generic.name			= ART_FIGHT0;
ADDRGP4 HudInfo+1476+4
ADDRGP4 $251
ASGNP4
line 403
;403:	HudInfo.go.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 HudInfo+1476+44
CNSTU4 260
ASGNU4
line 404
;404:	HudInfo.go.generic.id			= ID_GO;
ADDRGP4 HudInfo+1476+8
CNSTI4 11
ASGNI4
line 405
;405:	HudInfo.go.generic.callback		= UI_HudMenu_AcceptEvent;
ADDRGP4 HudInfo+1476+48
ADDRGP4 UI_HudMenu_AcceptEvent
ASGNP4
line 406
;406:	HudInfo.go.generic.x			= 320+128-128;
ADDRGP4 HudInfo+1476+12
CNSTI4 320
ASGNI4
line 407
;407:	HudInfo.go.generic.y			= 256+128-64;
ADDRGP4 HudInfo+1476+16
CNSTI4 320
ASGNI4
line 408
;408:	HudInfo.go.width  				= 128;
ADDRGP4 HudInfo+1476+80
CNSTI4 128
ASGNI4
line 409
;409:	HudInfo.go.height					= 64;
ADDRGP4 HudInfo+1476+84
CNSTI4 64
ASGNI4
line 410
;410:	HudInfo.go.focuspic				= ART_FIGHT1;
ADDRGP4 HudInfo+1476+64
ADDRGP4 $268
ASGNP4
line 412
;411:
;412:	HudInfo.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 HudInfo+1568
CNSTI4 6
ASGNI4
line 413
;413:	HudInfo.back.generic.name		= ART_BACK0;
ADDRGP4 HudInfo+1568+4
ADDRGP4 $272
ASGNP4
line 414
;414:	HudInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 HudInfo+1568+44
CNSTU4 260
ASGNU4
line 415
;415:	HudInfo.back.generic.id			= ID_BACK;
ADDRGP4 HudInfo+1568+8
CNSTI4 10
ASGNI4
line 416
;416:	HudInfo.back.generic.callback	= UI_HudMenu_BackEvent;
ADDRGP4 HudInfo+1568+48
ADDRGP4 UI_HudMenu_BackEvent
ASGNP4
line 417
;417:	HudInfo.back.generic.x			= 320-128;
ADDRGP4 HudInfo+1568+12
CNSTI4 192
ASGNI4
line 418
;418:	HudInfo.back.generic.y			= 256+128-64;
ADDRGP4 HudInfo+1568+16
CNSTI4 320
ASGNI4
line 419
;419:	HudInfo.back.width				= 128;
ADDRGP4 HudInfo+1568+80
CNSTI4 128
ASGNI4
line 420
;420:	HudInfo.back.height				= 64;
ADDRGP4 HudInfo+1568+84
CNSTI4 64
ASGNI4
line 421
;421:	HudInfo.back.focuspic			= ART_BACK1;
ADDRGP4 HudInfo+1568+64
ADDRGP4 $289
ASGNP4
line 423
;422:
;423:	HudInfo.baseHudNum = 0;
ADDRGP4 HudInfo+1668
CNSTI4 0
ASGNI4
line 424
;424:	UI_HudMenu_SetHudNames();
ADDRGP4 UI_HudMenu_SetHudNames
CALLV
pop
line 426
;425:
;426:	Menu_AddItem( &HudInfo.menu, &HudInfo.arrows );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 HudInfo+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 427
;427:	Menu_AddItem( &HudInfo.menu, &HudInfo.up );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 HudInfo+380
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 428
;428:	Menu_AddItem( &HudInfo.menu, &HudInfo.down );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 HudInfo+472
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 429
;429:	for( n = 0; n < count; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $297
JUMPV
LABELV $294
line 430
;430:		Menu_AddItem( &HudInfo.menu, &HudInfo.huds[n] );
ADDRGP4 HudInfo
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 HudInfo+564
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 431
;431:	}
LABELV $295
line 429
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $294
line 432
;432:	Menu_AddItem( &HudInfo.menu, &HudInfo.go );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 HudInfo+1476
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 433
;433:	Menu_AddItem( &HudInfo.menu, &HudInfo.back );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 HudInfo+1568
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 434
;434:}
LABELV $166
endproc UI_HudMenu_Init 24 12
export UI_Hud_Cache
proc UI_Hud_Cache 0 4
line 442
;435:
;436:
;437:/*
;438:=================
;439:UI_Hud_Cache
;440:=================
;441:*/
;442:void UI_Hud_Cache( void ) {
line 443
;443:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $272
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 444
;444:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $289
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 445
;445:	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
ADDRGP4 $251
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 446
;446:	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
ADDRGP4 $268
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 447
;447:	trap_R_RegisterShaderNoMip( ART_BACKGROUND );
ADDRGP4 $165
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 448
;448:	trap_R_RegisterShaderNoMip( ART_ARROWS );
ADDRGP4 $179
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 449
;449:	trap_R_RegisterShaderNoMip( ART_ARROWUP );
ADDRGP4 $207
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 450
;450:	trap_R_RegisterShaderNoMip( ART_ARROWDOWN );
ADDRGP4 $225
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 452
;451:
;452:	HUD_File_BuildList();
ADDRGP4 HUD_File_BuildList
CALLV
pop
line 453
;453:}
LABELV $301
endproc UI_Hud_Cache 0 4
export UI_HudMenu
proc UI_HudMenu 0 4
line 461
;454:
;455:
;456:/*
;457:=================
;458:UI_HudMenu
;459:=================
;460:*/
;461:void UI_HudMenu( void ) {
line 462
;462:	UI_HudMenu_Init();
ADDRGP4 UI_HudMenu_Init
CALLV
pop
line 463
;463:	UI_PushMenu( &HudInfo.menu );
ADDRGP4 HudInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 464
;464:}
LABELV $302
endproc UI_HudMenu 0 4
bss
align 4
LABELV hudNameList
skip 1536
align 4
LABELV HudInfo
skip 2572
import elem_Info_Parse
import prop_SetupKeywordHash
import String_Alloc
import UI_Alloc
align 1
LABELV strPool
skip 393216
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
LABELV $289
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
LABELV $272
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
LABELV $268
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
LABELV $251
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
LABELV $225
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
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $207
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
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $179
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
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $165
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
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $164
byte 1 83
byte 1 69
byte 1 76
byte 1 69
byte 1 67
byte 1 84
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 0
align 1
LABELV $96
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $95
byte 1 104
byte 1 117
byte 1 100
byte 1 0
align 1
LABELV $89
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 60
byte 1 37
byte 1 115
byte 1 62
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 33
byte 1 32
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $81
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 0
align 1
LABELV $74
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
LABELV $71
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
