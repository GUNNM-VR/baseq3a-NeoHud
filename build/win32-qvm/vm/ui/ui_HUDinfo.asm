data
align 4
LABELV strPoolIndex
byte 4 0
code
proc hashForString 16 4
file "..\..\..\..\code\q3_ui\ui_HUDinfo.c"
line 21
;1:#include "ui_HUDinfo.h"
;2:
;3:#define KEYWORDHASH_SIZE	512
;4:
;5:qboolean needCacheToken;
;6:qboolean itemEnd;
;7:char* cacheTokenStr;
;8:
;9:typedef struct stringDef_s {
;10:	struct stringDef_s *next;
;11:	const char *str;
;12:} stringDef_t;
;13:
;14:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;15:
;16:/*
;17:================
;18:return a hash value for the string
;19:================
;20:*/
;21:static unsigned hashForString(const char *str) {
line 26
;22:	int		i;
;23:	unsigned	hash;
;24:	char	letter;
;25:
;26:	hash = 0;
ADDRLP4 8
CNSTU4 0
ASGNU4
line 27
;27:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $24
JUMPV
LABELV $23
line 28
;28:	while (str[i] != '\0') {
line 29
;29:		letter = tolower(str[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 30
;30:		hash += (unsigned)(letter)*(i + 119);
ADDRLP4 8
ADDRLP4 8
INDIRU4
ADDRLP4 4
INDIRI1
CVII4 1
CVIU4 4
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
CVIU4 4
MULU4
ADDU4
ASGNU4
line 31
;31:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 32
;32:	}
LABELV $24
line 28
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $23
line 33
;33:	hash &= (HASH_TABLE_SIZE - 1);
ADDRLP4 8
ADDRLP4 8
INDIRU4
CNSTU4 2047
BANDU4
ASGNU4
line 34
;34:	return hash;
ADDRLP4 8
INDIRU4
RETU4
LABELV $22
endproc hashForString 16 4
data
align 4
LABELV $27
address $28
export String_Alloc
code
proc String_Alloc 40 8
line 42
;35:}
;36:
;37:/*
;38:=================
;39:String_Alloc
;40:=================
;41:*/
;42:const char *String_Alloc(const char *p) {
line 48
;43:	int len;
;44:	unsigned hash;
;45:	stringDef_t *str, *last;
;46:	static const char *staticNULL = "";
;47:
;48:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $29
line 49
;49:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $26
JUMPV
LABELV $29
line 52
;50:	}
;51:
;52:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $31
line 53
;53:		return staticNULL;
ADDRGP4 $27
INDIRP4
RETP4
ADDRGP4 $26
JUMPV
LABELV $31
line 56
;54:	}
;55:
;56:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 16
INDIRU4
ASGNU4
line 58
;57:
;58:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $34
JUMPV
LABELV $33
line 59
;59:	while (str) {
line 60
;60:		if (strcmp(p, str->str) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $36
line 61
;61:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $26
JUMPV
LABELV $36
line 63
;62:		}
;63:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 64
;64:	}
LABELV $34
line 59
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $33
line 66
;65:
;66:	len = strlen(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 67
;67:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 393216
GEI4 $38
line 68
;68:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 69
;69:		strcpy(&strPool[strPoolIndex], p);
ADDRGP4 strPoolIndex
INDIRI4
ADDRGP4 strPool
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 70
;70:		strPoolIndex += len + 1;
ADDRLP4 28
ADDRGP4 strPoolIndex
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 72
;71:
;72:		str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 73
;73:		last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $41
JUMPV
LABELV $40
line 74
;74:		while (str && str->next) {
line 75
;75:			last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 76
;76:			str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 77
;77:		}
LABELV $41
line 74
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $43
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $40
LABELV $43
line 79
;78:
;79:		str = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 80
;80:		if (!str) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $44
line 81
;81:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $26
JUMPV
LABELV $44
line 83
;82:		}
;83:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 84
;84:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 85
;85:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $46
line 86
;86:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 87
;87:		}
ADDRGP4 $47
JUMPV
LABELV $46
line 88
;88:		else {
line 89
;89:			strHandle[hash] = str;
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 90
;90:		}
LABELV $47
line 91
;91:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $26
JUMPV
LABELV $38
line 93
;92:	}
;93:	return NULL;
CNSTP4 0
RETP4
LABELV $26
endproc String_Alloc 40 8
export PC_String_Parse
proc PC_String_Parse 1048 8
line 101
;94:}
;95:
;96:/*
;97:=================
;98:PC_String_Parse
;99:=================
;100:*/
;101:qboolean PC_String_Parse(int handle, const char **out) {
line 104
;102:	pc_token_t token;
;103:
;104:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $49
line 105
;105:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $48
JUMPV
LABELV $49
line 107
;106:
;107:	*(out) = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1044
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1044
INDIRP4
ASGNP4
line 108
;108:	return qtrue;
CNSTI4 1
RETI4
LABELV $48
endproc PC_String_Parse 1048 8
bss
align 1
LABELV $53
skip 4096
code
proc PC_SourceError 136 16
line 117
;109:}
;110:
;111:/*
;112:=================
;113:PC_SourceError
;114:help HUD creation by giving error information
;115:=================
;116:*/
;117:static void PC_SourceError(int handle, char *format, ...) {
line 123
;118:	int line;
;119:	char filename[128];
;120:	va_list argptr;
;121:	static char string[4096];
;122:
;123:	va_start(argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 124
;124:	ED_vsprintf(string, format, argptr);
ADDRGP4 $53
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 125
;125:	va_end(argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 127
;126:
;127:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 128
;128:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 129
;129:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 131
;130:
;131:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $55
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $53
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 132
;132:}
LABELV $52
endproc PC_SourceError 136 16
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 139
;133:
;134:/*
;135:===============
;136:properties list hash
;137:===============
;138:*/
;139:int KeywordHash_Key(char *keyword) {
line 142
;140:	int hash, i;
;141:
;142:	hash = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 143
;143:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $60
JUMPV
LABELV $57
line 144
;144:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $61
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $61
line 145
;145:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $62
JUMPV
LABELV $61
line 147
;146:		else
;147:			hash += keyword[i] * (119 + i);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $62
line 148
;148:	}
LABELV $58
line 143
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $60
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $57
line 149
;149:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE - 1);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 4
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 150
;150:	return hash;
ADDRLP4 4
INDIRI4
RETI4
LABELV $56
endproc KeywordHash_Key 20 0
export prop_KeywordHash_Add
proc prop_KeywordHash_Add 8 4
line 162
;151:}
;152:
;153:typedef struct prop_keywordHash_s
;154:{
;155:	char *keyword;
;156:	qboolean(*func_prop)(item_t *item, int handle);
;157:	struct prop_keywordHash_s *next;
;158:} prop_keywordHash_t;
;159:
;160:prop_keywordHash_t *prop_KeywordHash[KEYWORDHASH_SIZE];
;161:
;162:void prop_KeywordHash_Add(prop_keywordHash_t *table[], prop_keywordHash_t *key) {
line 165
;163:	int hash;
;164:
;165:	hash = KeywordHash_Key(key->keyword);
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 166
;166:	key->next = table[hash];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 167
;167:	table[hash] = key;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 168
;168:}
LABELV $63
endproc prop_KeywordHash_Add 8 4
export prop_KeywordHash_Find
proc prop_KeywordHash_Find 16 8
line 170
;169:
;170:prop_keywordHash_t *prop_KeywordHash_Find(prop_keywordHash_t *table[], char *keyword) {
line 174
;171:	prop_keywordHash_t *key;
;172:	int hash;
;173:
;174:	hash = KeywordHash_Key(keyword);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 175
;175:	for (key = table[hash]; key; key = key->next) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $68
JUMPV
LABELV $65
line 176
;176:		if (!Q_stricmp(key->keyword, keyword))
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $69
line 177
;177:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $64
JUMPV
LABELV $69
line 178
;178:	}
LABELV $66
line 175
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $68
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $65
line 179
;179:	return NULL;
CNSTP4 0
RETP4
LABELV $64
endproc prop_KeywordHash_Find 16 8
export prop_name
proc prop_name 4 8
line 183
;180:}
;181:
;182:// name <string>
;183:qboolean prop_name(item_t *item, int handle) {
line 184
;184:	if (!PC_String_Parse(handle, &item->name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $72
line 185
;185:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $71
JUMPV
LABELV $72
line 187
;186:	}
;187:	return qtrue;
CNSTI4 1
RETI4
LABELV $71
endproc prop_name 4 8
export prop_author
proc prop_author 4 8
line 191
;188:}
;189:
;190:// author <string>
;191:qboolean prop_author(item_t *item, int handle) {
line 192
;192:	if (!PC_String_Parse(handle, &item->author)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $75
line 193
;193:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $75
line 195
;194:	}
;195:	return qtrue;
CNSTI4 1
RETI4
LABELV $74
endproc prop_author 4 8
export prop_description
proc prop_description 4 8
line 199
;196:}
;197:
;198:// description <string>
;199:qboolean prop_description(item_t *item, int handle) {
line 200
;200:	if (!PC_String_Parse(handle, &item->description)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $78
line 201
;201:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $78
line 203
;202:	}
;203:	return qtrue;
CNSTI4 1
RETI4
LABELV $77
endproc prop_description 4 8
data
export itemProperty_Keywords
align 4
LABELV itemProperty_Keywords
address $80
address prop_name
byte 4 0
address $81
address prop_author
byte 4 0
address $82
address prop_description
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export prop_SetupKeywordHash
code
proc prop_SetupKeywordHash 4 12
line 219
;204:}
;205:
;206:prop_keywordHash_t itemProperty_Keywords[] = {
;207:	{"name",		prop_name,			NULL},	// name of the HUD file, not use in CGAME
;208:	{"author",		prop_author,		NULL},	// author of the HUD file, not use in CGAME
;209:	{"description",	prop_description,	NULL},	// HUD short description, not use in CGAME
;210:	{NULL, 0, NULL}
;211:};
;212:
;213:/*
;214:===============
;215:prop_SetupKeywordHash
;216:fill prop_KeywordHash list
;217:===============
;218:*/
;219:void prop_SetupKeywordHash(void) {
line 221
;220:	int i;
;221:	memset(prop_KeywordHash, 0, sizeof(prop_KeywordHash));
ADDRGP4 prop_KeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 222
;222:	for (i = 0; itemProperty_Keywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $87
JUMPV
LABELV $84
line 223
;223:		prop_KeywordHash_Add(prop_KeywordHash, &itemProperty_Keywords[i]);
ADDRGP4 prop_KeywordHash
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemProperty_Keywords
ADDP4
ARGP4
ADDRGP4 prop_KeywordHash_Add
CALLV
pop
line 224
;224:	}
LABELV $85
line 222
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $87
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemProperty_Keywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $84
line 225
;225:}
LABELV $83
endproc prop_SetupKeywordHash 4 12
export itemProperties_Parse
proc itemProperties_Parse 1056 12
line 233
;226:
;227:/*
;228:===============
;229:itemProperties_Parse
;230:Parse item's properties 
;231:===============
;232:*/
;233:qboolean itemProperties_Parse(item_t *hudElem, int handle) {
line 237
;234:	pc_token_t token;
;235:	prop_keywordHash_t *key;
;236:
;237:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $89
line 238
;238:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $88
JUMPV
LABELV $89
line 241
;239:	}
;240:
;241:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $95
line 242
;242:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $88
JUMPV
LABELV $94
line 245
;243:	}
;244:
;245:	while (1) {
line 247
;246:		// we can't unread token, so we check last token on parse error
;247:		if (itemEnd)
ADDRGP4 itemEnd
INDIRI4
CNSTI4 0
EQI4 $97
line 248
;248:		{
line 249
;249:			itemEnd = qfalse;
ADDRGP4 itemEnd
CNSTI4 0
ASGNI4
line 250
;250:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $88
JUMPV
LABELV $97
line 253
;251:		}
;252:
;253:		if (needCacheToken) {
ADDRGP4 needCacheToken
INDIRI4
CNSTI4 0
EQI4 $99
line 254
;254:			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
ADDRLP4 1048
ADDRGP4 cacheTokenStr
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 59
EQI4 $103
ADDRLP4 1048
INDIRI4
CNSTI4 44
NEI4 $101
LABELV $103
line 255
;255:				continue;
ADDRGP4 $95
JUMPV
LABELV $101
line 257
;256:			}
;257:			key = prop_KeywordHash_Find(prop_KeywordHash, cacheTokenStr);
ADDRGP4 prop_KeywordHash
ARGP4
ADDRGP4 cacheTokenStr
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 prop_KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 258
;258:			needCacheToken = qfalse;
ADDRGP4 needCacheToken
CNSTI4 0
ASGNI4
line 259
;259:		}
ADDRGP4 $100
JUMPV
LABELV $99
line 260
;260:		else {
line 261
;261:			memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 263
;262:
;263:			if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $104
line 264
;264:				PC_SourceError(handle, "end of file inside property");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $106
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 265
;265:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $88
JUMPV
LABELV $104
line 268
;266:			}
;267:
;268:			if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $107
line 269
;269:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $88
JUMPV
LABELV $107
line 271
;270:			}
;271:			if (*token.string == ';' || *token.string == ',') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
EQI4 $114
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
NEI4 $110
LABELV $114
line 272
;272:				continue;
ADDRGP4 $95
JUMPV
LABELV $110
line 274
;273:			}
;274:			key = prop_KeywordHash_Find(prop_KeywordHash, token.string);
ADDRGP4 prop_KeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 prop_KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 275
;275:		}
LABELV $100
line 277
;276:
;277:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
line 278
;278:			PC_SourceError(handle, "unknown property keyword %s", token.string);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $118
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 279
;279:			continue;
ADDRGP4 $95
JUMPV
LABELV $116
line 282
;280:		}
;281:
;282:		if (!key->func_prop((item_t *)hudElem, handle)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1048
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $120
line 283
;283:			PC_SourceError(handle, "couldn't parse property keyword %s", token.string);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $122
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 284
;284:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $88
JUMPV
LABELV $120
line 286
;285:		}
;286:	}
LABELV $95
line 245
ADDRGP4 $94
JUMPV
line 287
;287:	return qfalse;
CNSTI4 0
RETI4
LABELV $88
endproc itemProperties_Parse 1056 12
export elem_Info_Parse
proc elem_Info_Parse 1056 12
line 298
;288:}
;289:
;290:
;291:/*
;292:=================
;293:elemInfo_Parse()
;294:Load .cfg files of directory and parse
;295:basic info (name, author, description)
;296:=================
;297:*/
;298:qboolean elem_Info_Parse(int handle, nameList_Def_t *elements) {
line 302
;299:	pc_token_t token;
;300:	qboolean res;
;301:
;302:	if (elements->isLoaded)
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $128
line 303
;303:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $124
JUMPV
LABELV $127
line 307
;304:
;305:	//Com_Error(ERR_DROP, "elements->isLoaded");
;306:	// parse each elements, and parse properties for each element
;307:	while (1) {
line 308
;308:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 309
;309:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $130
line 310
;310:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $130
line 313
;311:		}
;312:
;313:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $132
line 314
;314:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $124
JUMPV
LABELV $132
line 317
;315:		}
;316:
;317:		if (*token.string == '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $135
line 318
;318:			continue;
ADDRGP4 $128
JUMPV
LABELV $135
line 322
;319:		}
;320:
;321:		// CPMA compatibility
;322:		if (*token.string == '!') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 33
NEI4 $138
line 323
;323:			continue;
ADDRGP4 $128
JUMPV
LABELV $138
line 327
;324:		}
;325:
;326:		// std separators
;327:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $145
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $141
LABELV $145
line 328
;328:			continue;
ADDRGP4 $128
JUMPV
LABELV $141
line 332
;329:		}
;330:
;331:		// if element INFO found, parse its properties inside
;332:		if (strcmp("INFO", token.string) == 0) {
ADDRGP4 $148
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1048
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $146
line 333
;333:			res = itemProperties_Parse(&elements->INFO, handle);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 itemProperties_Parse
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1052
INDIRI4
ASGNI4
line 334
;334:			elements->isLoaded = res;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 1040
INDIRI4
ASGNI4
line 335
;335:			return res;
ADDRLP4 1040
INDIRI4
RETI4
ADDRGP4 $124
JUMPV
LABELV $146
line 337
;336:		}
;337:		else {
line 339
;338:			//continue;
;339:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $124
JUMPV
LABELV $128
line 307
ADDRGP4 $127
JUMPV
line 342
;340:		}
;341:	}
;342:	return res;
ADDRLP4 1040
INDIRI4
RETI4
LABELV $124
endproc elem_Info_Parse 1056 12
bss
export prop_KeywordHash
align 4
LABELV prop_KeywordHash
skip 2048
align 4
LABELV strHandle
skip 8192
export cacheTokenStr
align 4
LABELV cacheTokenStr
skip 4
export itemEnd
align 4
LABELV itemEnd
skip 4
export needCacheToken
align 4
LABELV needCacheToken
skip 4
import UI_Alloc
align 1
LABELV strPool
skip 393216
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
LABELV $148
byte 1 73
byte 1 78
byte 1 70
byte 1 79
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $118
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $82
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $81
byte 1 97
byte 1 117
byte 1 116
byte 1 104
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $80
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $55
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $28
byte 1 0
