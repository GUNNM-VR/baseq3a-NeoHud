#include "../game/q_shared.h"
#ifdef NEOHUD
#include "../ui/menudef.h"

#define DEFAULT_HUD "hud/hud_classic.cfg"

#define MAX_HUD_NAME_SIZE 32
#define MAX_HUD_ITEM 256
#define MAX_HUD_FILEPATH 256
/*
#ifdef CGAME
#define STRING_POOL_SIZE 128*1024
#else
#define STRING_POOL_SIZE 384*1024
#endif*/
#define STRING_POOL_SIZE 256*256

#ifndef max
#define max(a,b) (((a) > (b)) ? (a) : (b))
#endif

typedef enum {
	HUD_TEAM_FREE,
	HUD_TEAM_RED,
	HUD_TEAM_BLUE,
	HUD_TEAM_SPECTATOR,
	HUD_TEAM_NUM_TEAMS
} HUDteam_t; //fixme: this enum is already in bg_public.h

extern vec4_t health_colors[4];
extern vec4_t armor_colors[4];
extern vec4_t ammo_colors[4];
extern vec4_t teams_colors[4];

const char	*String_Alloc(const char *p); // Prototype for String_Alloc
void		String_Init(void);
qboolean	CG_CheckHUD(void);

typedef struct {
	float x;
	float y;
	float w;
	float h;
} rectDef_t;
typedef rectDef_t rectangle_t;

typedef struct {
	float left;
	float right;
	float top;
	float bottom;
} marginDef_t;
typedef marginDef_t margin_t;

typedef struct {
	float w;
	float h;
} charSizeDef_t;
typedef charSizeDef_t fontSize_t;

typedef struct {
	vec4_t			color;
	unsigned int	colorflags;
	float			alpha;
} color_Def_t;

typedef struct {
	char			*caption;
	unsigned int	styleflags;
	unsigned int	flags;
} text_Def_t;

typedef struct item_t item_t;

struct item_t {
	char			item_name[MAX_TOKENLENGTH];
	int				order;
	int				parent;
	int				time;
	int				param;
	float			pulseScale;
	int				team_player;
	unsigned int	gradientFlags;
	unsigned int	propFlags;
	unsigned int	iconFlags;
	// severall visibles flags , because all the flags can't fit in a int 32.
	// 2 dimmension, [0] for visible cases | [1] for invisible case
	unsigned int	visible_prop_flags[2];
	unsigned int	visible_val_flags[2];
	unsigned int	visible_GT_flags[2];
	unsigned int	cvarTest_flags;

	rectangle_t		rect;
	rectangle_t		finalRect;
	fontSize_t		fontsize;
	color_Def_t		backcolor;
	color_Def_t		forecolor;
	margin_t		margin;
	qhandle_t		shader;
	text_Def_t		text;
	void (*DrawItem) (item_t *);
};

extern item_t itemArray[MAX_HUD_ITEM];
extern int itemCount;

extern item_t dyn_itemArray[MAX_HUD_ITEM];
extern int dyn_itemCount;

// cvarTest flags
enum CVARTestFlags
{
	CV_cg_drawStatus			= 1 << 0,
	CV_cg_drawWeaponSelect		= 1 << 1,
	CV_cg_drawAttacker			= 1 << 2,
	CV_cg_drawTeamOverlay		= 1 << 3,
	CV_cg_drawCrosshairNames	= 1 << 4,
	CV_cg_drawIcons				= 1 << 5,
	CV_cg_draw3dIcons			= 1 << 6,
	CV_cg_drawFPS				= 1 << 7,
	CV_cg_drawSpeed				= 1 << 8,
	CV_cg_drawTimer				= 1 << 9,
	CV_cg_lagometer				= 1 << 10,
	CV_cg_drawPing				= 1 << 11,
	CV_cg_drawSnapshot			= 1 << 12,
	CV_cg_drawRewards			= 1 << 13,
	CV_cg_drawAmmoWarning		= 1 << 14,
	CV_cg_drawCrosshair			= 1 << 15
};

// background flags
enum BGFlags
{
	ICON_GAME_TYPE		= 1 << 0,
	ICON_HOLDABLE_ITEM	= 1 << 1,
	ICON_BLUE_FLAG		= 1 << 2,
	ICON_RED_FLAG		= 1 << 3,
	ICON_INVERT_W		= 1 << 4, // rect w is negative in the HUD .cfg file
	ICON_INVERT_H		= 1 << 5, // rect h is negative in the HUD .cfg file
	ICON_HEAD			= 1 << 6, // param 0: actual player - param X: Xth player in player's team 
	ICON_HEAD_ANIM		= 1 << 7,
	ICON_3D				= 1 << 8,
	ICON_ARMOR			= 1 << 9,
	ICON_AMMO			= 1 << 10,
	ICON_ORDER			= 1 << 11,
	ICON_POWERUP		= 1 << 12,
	ICON_ATTACKER		= 1 << 13
};

// forecolor & backcolor flags (itm->forecolor.flags et itm->backcolor.flags )
enum ColorFlags{
	C_COLOR_RGBA			= 1 << 0,
	C_COLOR_TEAM			= 1 << 1,
	C_COLOR_NME				= 1 << 2,
	C_COLORS_HEALTH			= 1 << 3,
	C_COLORS_ARMOR			= 1 << 4,
	C_COLORS_AMMO			= 1 << 5,
	C_COLOR_BLUE_TEAM		= 1 << 6,
	C_COLOR_RED_TEAM		= 1 << 7,
	C_COLORS_TEAMS			= 1 << 8
};

// gradient value & caption flag
enum ValFlags {
	VAL_TEXT				= 1 << 0,
	VAL_NAME				= 1 << 1,
	VAL_AMMO				= 1 << 2,
	VAL_HEALTH				= 1 << 3,
	VAL_ARMOR				= 1 << 4,
	VAL_WEAPON				= 1 << 5,
	VAL_HOLDABLE_ITEM		= 1 << 6,
	VAL_FPS					= 1 << 7,
	VAL_TIMER				= 1 << 8,
	VAL_SPEED				= 1 << 9,
	VAL_SCORE				= 1 << 10,
	VAL_CAPFRAG_LIMIT		= 1 << 11,
	VAL_FRAG_LIMIT			= 1 << 12,
	VAL_CAPTURE_LIMIT		= 1 << 13,
	VAL_TIME_LIMIT			= 1 << 14,
	VAL_FOLLOW_NAME			= 1 << 15,
	VAL_SNAPSHOT			= 1 << 16,
	VAL_LOCATION			= 1 << 17,
	VAL_PLAYERS_NB_TEAM		= 1 << 18 //GUNNM TODO avec param 1: red | 2: blue | 3: opposing team player number | 0: own team (default if no param)
};

// CG_DrawString flags (itm->text.styleflags)
enum DSFlags {
	DS_SHADOW		= 1 << 0,
	DS_FORCE_COLOR	= 1 << 1, // allow allow color ^1 to ^7
	DS_PROPORTIONAL = 1 << 2,
	DS_CENTER		= 1 << 3,
	DS_RIGHT		= 1 << 4,
	DS_FONT_LETTER	= 1 << 5,
	DS_FONT_NUMBER	= 1 << 6,
	DS_FONT_OTHER	= 1 << 7, // for later dev
};

// visibility & invisibility flags
enum VisibleFlags {
	None					= 0,
	VIS_NEVER				= 1 << 0,
	VIS_IN_SCORE			= 1 << 1,
	VIS_IN_MENU				= 1 << 2,
	VIS_PMF_FOLLOW			= 1 << 3,
	VIS_LOCAL_SERVER		= 1 << 4,
	VIS_LOW_AMMO_WARNING	= 1 << 5,
	VIS_OUT_OF_AMMO			= 1 << 6,
	VIS_WARMUP				= 1 << 7,
	VIS_ZERO_VALUE			= 1 << 8,
	VIS_DISCONNECTED		= 1 << 9,
	VIS_BLINK				= 1 << 10,
	VIS_BLUE_FLAG_TAKEN		= 1 << 11,
	VIS_RED_FLAG_TAKEN		= 1 << 12,
	VIS_POWERUP_1			= 1 << 13,
	VIS_PICKUP_ITEM			= 1 << 14,
	VIS_FIRING				= 1 << 15,
	//VIS_MAX				= 1 << 32 (not included)
};

//visibleGameTypeFlags & visibleGameTypeFlags
enum GametypeVisibleFlags {
	VIS_GT_None = 0,
	VIS_TEAM_PLAY			= 1 << 0,
	VIS_GT_TOURNAMENT		= 1 << 1,
	VIS_GT_FFA				= 1 << 2,
	VIS_GT_TDM				= 1 << 3,
	VIS_GT_CTF				= 1 << 4,
	VIS_GT_FREEZE			= 1 << 5,
#ifdef MISSIONPACK
	VIS_GT_1FCTF			= 1 << 6,
	VIS_GT_OBELISK			= 1 << 7,
	VIS_GT_HARVESTER		= 1 << 8,
#endif
	VIS_TEAM_BLUE			= 1 << 9,
	VIS_TEAM_RED			= 1 << 10,
	VIS_TEAM_BLUE_OR_RED	= 1 << 11,
	VIS_TEAM_SPECTATOR		= 1 << 12,

	VIS_SHOW_TEAMINFO		= 1 << 13,
	VIS_TEAM_PLAYER			= 1 << 14,
};

// general item flags
enum PropFlags
{
	PROP_NONE				= 0,
	PROP_VALIGN_TOP			= 1 << 0,
	PROP_VALIGN_MIDDLE		= 1 << 1,
	PROP_VALIGN_BOTTOM		= 1 << 2,
	PROP_VERTICALBAR		= 1 << 3,
	PROP_ANCHOR_LEFT		= 1 << 4,
	PROP_ANCHOR_CENTER		= 1 << 5,
	PROP_ANCHOR_RIGHT		= 1 << 6,
	PROP_ANCHOR_TOP			= 1 << 7,
	PROP_ANCHOR_MIDDLE		= 1 << 8,
	PROP_ANCHOR_BOTTOM		= 1 << 9,
	PROP_GRADIENT_INVERT	= 1 << 10,
	PROP_GRADIENT			= 1 << 11,
	PROP_FILL				= 1 << 12,
	PROP_BLINK_WHEN_LOW		= 1 << 13,
	PROP_TEAM_PLAYER		= 1 << 14,
};

typedef struct HUD_items_keywordHash_s {
	char *keyword;
	void(*draw_item)(item_t *);
	struct HUD_items_keywordHash_s *next;
} items_keywordHash_t;
extern items_keywordHash_t item_Keywords[];

typedef struct specifics_items_keywordHash_s {
	char *keyword;
	struct specifics_items_keywordHash_s *next;
} specifics_keywordHash_t;

typedef struct dyn_items_keywordHash_s {
	char *keyword;
	int *idx;
	struct dyn_items_keywordHash_s *next;
} dyn_items_keywordHash_t;

// from cg_parseHUD.c
qhandle_t CG_HUDShader(item_t *item, qhandle_t defaultShader);
qboolean CG_HUDItemVisible(const item_t * itm);
void HUD_Update_Anchors(const item_t *itm, rectangle_t *r);
void HUD_Update_Margin(item_t *itm, rectangle_t *r);
void HUD_Update_Valign(item_t *itm, rectangle_t *r);

// Some HUD items are not drawn directly, we need to keep theirs index
extern int IcoWeapList_idx;
extern int IcoWeapListSel_idx;
extern int WeapListSelName_idx;
extern int IcoPowerUp_idx;
extern int WarmFightMsg_idx;
extern int KillMsg_idx;
extern int Attacker_idx;
extern int ItemMsg_idx;
extern int ServerMsg_idx;
extern int TeamOverlay_Sel_idx;

extern int FPS;
extern float HUD_GradientValue(item_t *itm);
extern void HUD_Draw_Text(item_t *itm, rectangle_t *r);

void copyColor(vec4_t colSource, vec4_t *colDest);

void HUD_DrawBackground(item_t *itm, rectangle_t *r);
void HUD_DrawGradientBackground(item_t *itm, rectangle_t *r);
void HUD_Update_finalRect(item_t *itm, int x, int y, int w, int h);

const char * getTeamPlayerName(int playerIndex);
const char *getPlayerLocation(int playerIndex);
int getPlayerHealth(int playerIndex);

// from cg_draw.c
extern int playerTeam;
void CG_DrawStatusBarHead(item_t *itm, rectangle_t rect, int clientNum);
void CG_Draw_Icon_Armor(item_t *itm, rectangle_t rect, int clientNum);
void CG_Draw_Icon_Ammo(item_t *itm, rectangle_t rect, int clientNum);
void CG_DrawTeamPlayerPowerup(rectDef_t *rect, int param, int powerUpNb);
int HUD_ItemCaptionValue(item_t *itm);
void HUD_color(item_t *itm, color_Def_t *colDef, vec4_t *colDest, vec4_t defaultCol);
void CG_DrawSelectedPlayerStatus(rectDef_t *rect, int player);
extern void CG_DrawAttacker_icon(item_t * itm);

#endif //NEOHUD
