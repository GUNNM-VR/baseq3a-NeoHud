#include "../game/q_shared.h"

#define DEFAULT_HUD "hud/hud_classic.cfg"
#define MAX_HUD_NAME_SIZE 32
#define MAX_HUD_ITEM 64
#define MAX_HUD_FILEPATH 256

#define STRING_POOL_SIZE 384*1024
#define HASH_TABLE_SIZE 2048

static int strPoolIndex = 0;
static char strPool[STRING_POOL_SIZE];

void *UI_Alloc(int size);
extern int ED_vsprintf(char *buffer, const char *fmt, va_list argptr);

const char *String_Alloc(const char *p);
void prop_SetupKeywordHash(void);

typedef struct item_t item_t;

struct item_t {
	const char	*name;			// name of the HUD file, not use in CGAME
	const char	*author;		// author of the HUD file, not use in CGAME
	const char	*description;	// HUD short description, not use in CGAME
};

typedef struct {
	const char	*filePath;
	const char	*fileName;
	qboolean	isLoaded;
	item_t		INFO;
} nameList_Def_t;

qboolean elem_Info_Parse(int handle, nameList_Def_t *elements);

