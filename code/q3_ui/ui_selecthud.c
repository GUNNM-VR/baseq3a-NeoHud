/*
=======================================================================

SELECT HUD MENU

=======================================================================
*/

#include "ui_local.h"

#include "ui_HUDinfo.h"

#define ART_BACK0			"menu/art/back_0"
#define ART_BACK1			"menu/art/back_1"	
#define ART_FIGHT0			"menu/art/accept_0"
#define ART_FIGHT1			"menu/art/accept_1"
#define ART_BACKGROUND		"menu/art/addbotframe"
#define ART_ARROWS			"menu/art/arrows_vert_0"
#define ART_ARROWUP			"menu/art/arrows_vert_top"
#define ART_ARROWDOWN		"menu/art/arrows_vert_bot"

#define ID_BACK				10
#define ID_GO				11
#define ID_LIST				12
#define ID_UP				13
#define ID_DOWN				14

#define ID_SKILL			15
#define ID_TEAM				16

#define ID_HUDNAME0			20
#define ID_HUDNAME1			21
#define ID_HUDNAME2			22
#define ID_HUDNAME3			23
#define ID_HUDNAME4			24
#define ID_HUDNAME5			25
#define ID_HUDNAME6			26
#define ID_HUDNAME7			27
#define ID_HUDNAME8			28
#define ID_HUDNAME9			29
#define ID_HUDNAME10		30
#define ID_HUDNAME11		31

#define NB_VISIBLE_HUD		12

typedef struct {
	menuframework_s	menu;
	menubitmap_s	arrows;
	menubitmap_s	up;
	menubitmap_s	down;
	menutext_s		huds[NB_VISIBLE_HUD];
	menubitmap_s	go;
	menubitmap_s	back;

	int				numHuds;
	int				delay;//GUNNM what is it used for?
	int				baseHudNum;
	int				selectedHudNum;
	int				sortedHudNums[MAX_HUD_ITEM];
	char			hudnames[NB_VISIBLE_HUD][32];
	char			cg_hudFiles[MAX_HUD_FILEPATH];//the selected HUD path from cvar_t
} selectHudMenuInfo_t;

static selectHudMenuInfo_t	HudInfo;

static nameList_Def_t hudNameList[MAX_HUD_ITEM];


/*
=================
Get_cg_hudFiles
Get the cvar_t cg_hudFiles
=================
*/
char * Get_cg_hudFiles( void )
{
	char buff[1024];
	char *hudSet;
	memset(buff, 0, sizeof(buff));

	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
	hudSet = buff;
	if (hudSet[0] == '\0') {
		hudSet = DEFAULT_HUD;
	}
	return hudSet;
}


/*
=================
Set_cg_hudFiles
Set the cvar_t cg_hudFiles
=================
*/
void Set_cg_hudFiles()
{
	int hudId;
	hudId = HudInfo.selectedHudNum + HudInfo.baseHudNum;

	trap_Cvar_Set("cg_hudFiles", hudNameList[hudId].filePath);

	Q_strncpyz(HudInfo.cg_hudFiles, hudNameList[hudId].filePath, sizeof(HudInfo.cg_hudFiles));
}


/*
=================
CG_ParseInfo_HUD_File
create a new HUD in the list
then parse basic info only (name, author, description)
=================
*/
qboolean CG_ParseInfo_HUD_File(char *filePath) {
	int handle;
	int lenPath;
	char fileName[128];
	char *ext = "hud/";
	qboolean res;
	nameList_Def_t *HudNameInfo;

	if (HudInfo.numHuds >= MAX_HUD_ITEM) {
		Com_Printf("Error: Too many HUD files! (%i >= %i)\n", HudInfo.numHuds, MAX_HUD_ITEM);
		return qfalse;
	}

	handle = trap_PC_LoadSource(filePath);
	if (!handle) {
		Com_Printf("Error: HUD file <%s> not found\n", filePath);
		return qfalse;
	}

	// get filename by removing folder path and extension
	lenPath = strlen(ext);
	Q_strncpyz(fileName, filePath + lenPath, strlen(filePath) - lenPath - 3);

	HudNameInfo = &hudNameList[HudInfo.numHuds];
	memset(HudNameInfo, 0, sizeof(nameList_Def_t));

	HudNameInfo->filePath = String_Alloc(filePath);
	HudNameInfo->fileName = String_Alloc(fileName);

	res = elem_Info_Parse(handle, HudNameInfo);
	if (res) {
		HudInfo.numHuds++;
	}

	trap_PC_FreeSource(handle);

	return res;
}


/*
=================
ParseInfo_All_HUD_Files
get all cfg files in /hud folder then parse basic info
=================
*/
void ParseInfo_All_HUD_Files( void ) {
	int			numdirs;
	char		filePath[MAX_HUD_FILEPATH];
	char		dirlist[2048];// MAX_HUD_ITEM * MAX_HUD_FILEPATH ?
	char*		dirptr;
	int			i;
	int			dirlen;

	// clear HUD name list
	memset(&hudNameList, 0, sizeof(hudNameList));

	// get all cfg files in /hud folder
	numdirs = trap_FS_GetFileList("hud", ".cfg", dirlist, sizeof(dirlist));
	dirptr = dirlist;

//	Com_Error(ERR_DROP, "Error: numdirs: %i ", numdirs);

	for ( i = 0; i < numdirs; i++, dirptr += dirlen + 1 ) {
		// add path to filename //fixme: optimize
		char *tmpPath = "hud/";
		memset(filePath, 0, sizeof(filePath));

		dirlen = strlen(dirptr);
		memcpy(filePath, tmpPath, sizeof(tmpPath));
		memcpy(filePath + sizeof(tmpPath), dirptr, dirlen);

		

		// only parse the HUD info (full HUD will be parse on demand)
		CG_ParseInfo_HUD_File( filePath );
	}
}

/*
=================
PlayerModel_BuildList
load basic info from all cfg files in /hud
=================
*/
static void HUD_File_BuildList( void ) {
	char * buff;

	HudInfo.selectedHudNum = MAX_HUD_ITEM; //avoid selection of first one

	// Get hashList to allow parsing
	prop_SetupKeywordHash();

	// get selected HUD from cvar_t
	buff = Get_cg_hudFiles();
	Q_strncpyz(HudInfo.cg_hudFiles, buff, sizeof(HudInfo.cg_hudFiles));

	// only read name, author and description (INFO element)
	ParseInfo_All_HUD_Files();
}


/*
=================
UI_HudMenu_SetHudNames
=================
*/
static void UI_HudMenu_SetHudNames( void ) {
	int	i;

	const char *HUDname;
	const char *fileName;
	const char *filePath;
	HudInfo.selectedHudNum = MAX_HUD_ITEM;
	for ( i = 0; i < HudInfo.numHuds; i++ ) {
		HUDname  = hudNameList[HudInfo.baseHudNum + i].INFO.name;
		fileName = hudNameList[HudInfo.baseHudNum + i].fileName;
		filePath = hudNameList[HudInfo.baseHudNum + i].filePath;

		HudInfo.huds[i].color = color_orange;

		if (strcmp(filePath, HudInfo.cg_hudFiles) == 0 )
		{
			HudInfo.selectedHudNum = i;
			HudInfo.huds[i].color = color_white;
		}

		// show filePath if name not defined
		if (HUDname == '\0') {
			Q_strncpyz(HudInfo.hudnames[i], fileName, sizeof(HudInfo.hudnames[i]));
		}
		else {
			Q_strncpyz(HudInfo.hudnames[i], HUDname, sizeof(HudInfo.hudnames[i]));
		}
	}
}


/*
=================
UI_HudMenu_UpEvent
=================
*/
static void UI_HudMenu_UpEvent( void* ptr, int event ) {
	if (event != QM_ACTIVATED) {
		return;
	}

	if(HudInfo.baseHudNum > 0 ) {
		HudInfo.baseHudNum--;
		UI_HudMenu_SetHudNames();
	}
}


/*
=================
UI_HudMenu_AcceptEvent
=================
*/
static void UI_HudMenu_AcceptEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) {
		return;
	}

	UI_PopMenu();
}


/*
=================
UI_HudMenu_HudEvent
keep selected HUD in cvar_t
=================
*/
static void UI_HudMenu_HudEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) {
		return;
	}

	HudInfo.huds[HudInfo.selectedHudNum].color = color_orange;
	HudInfo.selectedHudNum = ((menucommon_s*)ptr)->id - ID_HUDNAME0;
	HudInfo.huds[HudInfo.selectedHudNum].color = color_white;

	Set_cg_hudFiles();
}


/*
=================
UI_HudMenu_BackEvent
=================
*/
static void UI_HudMenu_BackEvent(void* ptr, int event) {
	if (event != QM_ACTIVATED) {
		return;
	}
	UI_PopMenu();
}


/*
=================
UI_HudMenu_DownEvent
=================
*/
static void UI_HudMenu_DownEvent( void* ptr, int event ) {
	if (event != QM_ACTIVATED) {
		return;
	}
	
	if(HudInfo.baseHudNum + NB_VISIBLE_HUD < HudInfo.numHuds ) {
		HudInfo.baseHudNum++;
		UI_HudMenu_SetHudNames();
	}
}


/*
=================
UI_HudMenu_Draw
=================
*/
static void UI_HudMenu_Draw( void ) {
	UI_DrawBannerString( 320, 16, "SELECT HUD", UI_CENTER, color_white );
	UI_DrawNamedPic( 320-233, 240-166, 466, 332, ART_BACKGROUND );

	// standard menu drawing
	Menu_Draw( &HudInfo.menu );
}


static void UI_HudMenu_Init( void ) {
	int		n;
	int		y;
	int		count;

	memset( &HudInfo, 0, sizeof(HudInfo) );
	HudInfo.menu.draw = UI_HudMenu_Draw;
	HudInfo.menu.fullscreen = qfalse;
	HudInfo.menu.wrapAround = qtrue;
	HudInfo.delay = 1000;

	UI_Hud_Cache();

	count = HudInfo.numHuds < NB_VISIBLE_HUD ? HudInfo.numHuds : NB_VISIBLE_HUD;

	HudInfo.arrows.generic.type	= MTYPE_BITMAP;
	HudInfo.arrows.generic.name	= ART_ARROWS;
	HudInfo.arrows.generic.flags= QMF_INACTIVE;
	HudInfo.arrows.generic.x	= 200;
	HudInfo.arrows.generic.y	= 128;
	HudInfo.arrows.width		= 64;
	HudInfo.arrows.height		= 128;

	HudInfo.up.generic.type		= MTYPE_BITMAP;
	HudInfo.up.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	HudInfo.up.generic.x		= 200;
	HudInfo.up.generic.y		= 128;
	HudInfo.up.generic.id		= ID_UP;
	HudInfo.up.generic.callback	= UI_HudMenu_UpEvent;
	HudInfo.up.width  		    = 64;
	HudInfo.up.height  		    = 64;
	HudInfo.up.focuspic			= ART_ARROWUP;

	HudInfo.down.generic.type	= MTYPE_BITMAP;
	HudInfo.down.generic.flags  = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	HudInfo.down.generic.x		= 200;
	HudInfo.down.generic.y		= 128+64;
	HudInfo.down.generic.id	    = ID_DOWN;
	HudInfo.down.generic.callback= UI_HudMenu_DownEvent;
	HudInfo.down.width  		= 64;
	HudInfo.down.height  		= 64;
	HudInfo.down.focuspic       = ART_ARROWDOWN;

	for( n = 0, y = 120; n < count; n++, y += SMALLCHAR_HEIGHT) {
		HudInfo.huds[n].generic.type		= MTYPE_STEXT;
		HudInfo.huds[n].generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_SMALLFONT;
		HudInfo.huds[n].generic.id			= ID_HUDNAME0 + n;
		HudInfo.huds[n].generic.x			= 320 - 56;
		HudInfo.huds[n].generic.y			= y;
		HudInfo.huds[n].generic.callback	= UI_HudMenu_HudEvent;
		HudInfo.huds[n].string				= HudInfo.hudnames[n];
		HudInfo.huds[n].color				= color_orange;
		HudInfo.huds[n].style				= UI_LEFT; //| UI_LOWERCASE;// | UI_PULSE;
	}

	HudInfo.go.generic.type			= MTYPE_BITMAP;
	HudInfo.go.generic.name			= ART_FIGHT0;
	HudInfo.go.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	HudInfo.go.generic.id			= ID_GO;
	HudInfo.go.generic.callback		= UI_HudMenu_AcceptEvent;
	HudInfo.go.generic.x			= 320+128-128;
	HudInfo.go.generic.y			= 256+128-64;
	HudInfo.go.width  				= 128;
	HudInfo.go.height					= 64;
	HudInfo.go.focuspic				= ART_FIGHT1;

	HudInfo.back.generic.type		= MTYPE_BITMAP;
	HudInfo.back.generic.name		= ART_BACK0;
	HudInfo.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
	HudInfo.back.generic.id			= ID_BACK;
	HudInfo.back.generic.callback	= UI_HudMenu_BackEvent;
	HudInfo.back.generic.x			= 320-128;
	HudInfo.back.generic.y			= 256+128-64;
	HudInfo.back.width				= 128;
	HudInfo.back.height				= 64;
	HudInfo.back.focuspic			= ART_BACK1;

	HudInfo.baseHudNum = 0;
	UI_HudMenu_SetHudNames();

	Menu_AddItem( &HudInfo.menu, &HudInfo.arrows );
	Menu_AddItem( &HudInfo.menu, &HudInfo.up );
	Menu_AddItem( &HudInfo.menu, &HudInfo.down );
	for( n = 0; n < count; n++ ) {
		Menu_AddItem( &HudInfo.menu, &HudInfo.huds[n] );
	}
	Menu_AddItem( &HudInfo.menu, &HudInfo.go );
	Menu_AddItem( &HudInfo.menu, &HudInfo.back );
}


/*
=================
UI_Hud_Cache
=================
*/
void UI_Hud_Cache( void ) {
	trap_R_RegisterShaderNoMip( ART_BACK0 );
	trap_R_RegisterShaderNoMip( ART_BACK1 );
	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
	trap_R_RegisterShaderNoMip( ART_BACKGROUND );
	trap_R_RegisterShaderNoMip( ART_ARROWS );
	trap_R_RegisterShaderNoMip( ART_ARROWUP );
	trap_R_RegisterShaderNoMip( ART_ARROWDOWN );

	HUD_File_BuildList();
}


/*
=================
UI_HudMenu
=================
*/
void UI_HudMenu( void ) {
	UI_HudMenu_Init();
	UI_PushMenu( &HudInfo.menu );
}

