#include "ui_HUDinfo.h"

#define KEYWORDHASH_SIZE	512

qboolean needCacheToken;
qboolean itemEnd;
char* cacheTokenStr;

typedef struct stringDef_s {
	struct stringDef_s *next;
	const char *str;
} stringDef_t;

static stringDef_t *strHandle[HASH_TABLE_SIZE];

/*
================
return a hash value for the string
================
*/
static unsigned hashForString(const char *str) {
	int		i;
	unsigned	hash;
	char	letter;

	hash = 0;
	i = 0;
	while (str[i] != '\0') {
		letter = tolower(str[i]);
		hash += (unsigned)(letter)*(i + 119);
		i++;
	}
	hash &= (HASH_TABLE_SIZE - 1);
	return hash;
}

/*
=================
String_Alloc
=================
*/
const char *String_Alloc(const char *p) {
	int len;
	unsigned hash;
	stringDef_t *str, *last;
	static const char *staticNULL = "";

	if (p == NULL) {
		return NULL;
	}

	if (*p == 0) {
		return staticNULL;
	}

	hash = hashForString(p);

	str = strHandle[hash];
	while (str) {
		if (strcmp(p, str->str) == 0) {
			return str->str;
		}
		str = str->next;
	}

	len = strlen(p);
	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
		int ph = strPoolIndex;
		strcpy(&strPool[strPoolIndex], p);
		strPoolIndex += len + 1;

		str = strHandle[hash];
		last = str;
		while (str && str->next) {
			last = str;
			str = str->next;
		}

		str = UI_Alloc(sizeof(stringDef_t));
		if (!str) {
			return NULL;
		}
		str->next = NULL;
		str->str = &strPool[ph];
		if (last) {
			last->next = str;
		}
		else {
			strHandle[hash] = str;
		}
		return &strPool[ph];
	}
	return NULL;
}

/*
=================
PC_String_Parse
=================
*/
qboolean PC_String_Parse(int handle, const char **out) {
	pc_token_t token;

	if (!trap_PC_ReadToken(handle, &token))
		return qfalse;

	*(out) = String_Alloc(token.string);
	return qtrue;
}

/*
=================
PC_SourceError
help HUD creation by giving error information
=================
*/
static void PC_SourceError(int handle, char *format, ...) {
	int line;
	char filename[128];
	va_list argptr;
	static char string[4096];

	va_start(argptr, format);
	ED_vsprintf(string, format, argptr);
	va_end(argptr);

	filename[0] = '\0';
	line = 0;
	trap_PC_SourceFileAndLine(handle, filename, &line);

	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
}

/*
===============
properties list hash
===============
*/
int KeywordHash_Key(char *keyword) {
	int hash, i;

	hash = 0;
	for (i = 0; keyword[i] != '\0'; i++) {
		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
		else
			hash += keyword[i] * (119 + i);
	}
	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE - 1);
	return hash;
}

typedef struct prop_keywordHash_s
{
	char *keyword;
	qboolean(*func_prop)(item_t *item, int handle);
	struct prop_keywordHash_s *next;
} prop_keywordHash_t;

prop_keywordHash_t *prop_KeywordHash[KEYWORDHASH_SIZE];

void prop_KeywordHash_Add(prop_keywordHash_t *table[], prop_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

prop_keywordHash_t *prop_KeywordHash_Find(prop_keywordHash_t *table[], char *keyword) {
	prop_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

// name <string>
qboolean prop_name(item_t *item, int handle) {
	if (!PC_String_Parse(handle, &item->name)) {
		return qfalse;
	}
	return qtrue;
}

// author <string>
qboolean prop_author(item_t *item, int handle) {
	if (!PC_String_Parse(handle, &item->author)) {
		return qfalse;
	}
	return qtrue;
}

// description <string>
qboolean prop_description(item_t *item, int handle) {
	if (!PC_String_Parse(handle, &item->description)) {
		return qfalse;
	}
	return qtrue;
}

prop_keywordHash_t itemProperty_Keywords[] = {
	{"name",		prop_name,			NULL},	// name of the HUD file, not use in CGAME
	{"author",		prop_author,		NULL},	// author of the HUD file, not use in CGAME
	{"description",	prop_description,	NULL},	// HUD short description, not use in CGAME
	{NULL, 0, NULL}
};

/*
===============
prop_SetupKeywordHash
fill prop_KeywordHash list
===============
*/
void prop_SetupKeywordHash(void) {
	int i;
	memset(prop_KeywordHash, 0, sizeof(prop_KeywordHash));
	for (i = 0; itemProperty_Keywords[i].keyword; i++) {
		prop_KeywordHash_Add(prop_KeywordHash, &itemProperty_Keywords[i]);
	}
}

/*
===============
itemProperties_Parse
Parse item's properties 
===============
*/
qboolean itemProperties_Parse(item_t *hudElem, int handle) {
	pc_token_t token;
	prop_keywordHash_t *key;

	if (!trap_PC_ReadToken(handle, &token)) {
		return qfalse;
	}

	if (*token.string != '{') {
		return qfalse;
	}

	while (1) {
		// we can't unread token, so we check last token on parse error
		if (itemEnd)
		{
			itemEnd = qfalse;
			return qtrue;
		}

		if (needCacheToken) {
			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
				continue;
			}
			key = prop_KeywordHash_Find(prop_KeywordHash, cacheTokenStr);
			needCacheToken = qfalse;
		}
		else {
			memset(&token, 0, sizeof(pc_token_t));

			if (!trap_PC_ReadToken(handle, &token)) {
				PC_SourceError(handle, "end of file inside property");
				return qfalse;
			}

			if (*token.string == '}') {
				return qtrue;
			}
			if (*token.string == ';' || *token.string == ',') {
				continue;
			}
			key = prop_KeywordHash_Find(prop_KeywordHash, token.string);
		}

		if (!key) {
			PC_SourceError(handle, "unknown property keyword %s", token.string);
			continue;
		}

		if (!key->func_prop((item_t *)hudElem, handle)) {
			PC_SourceError(handle, "couldn't parse property keyword %s", token.string);
			return qfalse;
		}
	}
	return qfalse;
}


/*
=================
elemInfo_Parse()
Load .cfg files of directory and parse
basic info (name, author, description)
=================
*/
qboolean elem_Info_Parse(int handle, nameList_Def_t *elements) {
	pc_token_t token;
	qboolean res;

	if (elements->isLoaded)
		return qtrue;

	//Com_Error(ERR_DROP, "elements->isLoaded");
	// parse each elements, and parse properties for each element
	while (1) {
		memset(&token, 0, sizeof(pc_token_t));
		if (!trap_PC_ReadToken(handle, &token)) {
			return qfalse;
		}

		if (*token.string == '}') {
			return qtrue;
		}

		if (*token.string == '{') {
			continue;
		}

		// CPMA compatibility
		if (*token.string == '!') {
			continue;
		}

		// std separators
		if (*token.string == ',' || *token.string == ';') {
			continue;
		}

		// if element INFO found, parse its properties inside
		if (strcmp("INFO", token.string) == 0) {
			res = itemProperties_Parse(&elements->INFO, handle);
			elements->isLoaded = res;
			return res;
		}
		else {
			//continue;
			return qfalse;
		}
	}
	return res;
}
