data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
export CG_Draw3DModel
code
proc CG_Draw3DModel 508 16
file "..\..\..\..\code\cgame\cg_draw.c"
line 257
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:
;8:#ifdef NEOHUD
;9:#include "cg_drawhud.h"
;10:#endif
;11:
;12:#ifdef MISSIONPACK
;13:#include "../ui/ui_shared.h"
;14:
;15:// used for scoreboard
;16:extern displayContextDef_t cgDC;
;17:menuDef_t *menuScoreboard = NULL;
;18:#else
;19:int drawTeamOverlayModificationCount = -1;
;20:#endif
;21:
;22:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;23:int	numSortedTeamPlayers;
;24:
;25:char systemChat[256];
;26:char teamChat1[256];
;27:char teamChat2[256];
;28:
;29:#ifdef MISSIONPACK
;30:
;31:int CG_Text_Width(const char *text, float scale, int limit) {
;32:  int count,len;
;33:	float out;
;34:	glyphInfo_t *glyph;
;35:	float useScale;
;36:// FIXME: see ui_main.c, same problem
;37://	const unsigned char *s = text;
;38:	const char *s = text;
;39:	fontInfo_t *font = &cgDC.Assets.textFont;
;40:	if (scale <= cg_smallFont.value) {
;41:		font = &cgDC.Assets.smallFont;
;42:	} else if (scale > cg_bigFont.value) {
;43:		font = &cgDC.Assets.bigFont;
;44:	}
;45:	useScale = scale * font->glyphScale;
;46:  out = 0;
;47:  if (text) {
;48:	len = strlen(text);
;49:		if (limit > 0 && len > limit) {
;50:			len = limit;
;51:		}
;52:		count = 0;
;53:		while (s && *s && count < len) {
;54:			if ( Q_IsColorString(s) ) {
;55:				s += 2;
;56:				continue;
;57:			} else {
;58:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;59:				out += glyph->xSkip;
;60:				s++;
;61:				count++;
;62:			}
;63:		}
;64:	}
;65:	return out * useScale;
;66:}
;67:
;68:int CG_Text_Height(const char *text, float scale, int limit) {
;69:  int len, count;
;70:	float max;
;71:	glyphInfo_t *glyph;
;72:	float useScale;
;73:// TTimo: FIXME
;74://	const unsigned char *s = text;
;75:	const char *s = text;
;76:	fontInfo_t *font = &cgDC.Assets.textFont;
;77:	if (scale <= cg_smallFont.value) {
;78:		font = &cgDC.Assets.smallFont;
;79:	} else if (scale > cg_bigFont.value) {
;80:		font = &cgDC.Assets.bigFont;
;81:	}
;82:	useScale = scale * font->glyphScale;
;83:	max = 0;
;84:	if (text) {
;85:		len = strlen(text);
;86:		if (limit > 0 && len > limit) {
;87:			len = limit;
;88:		}
;89:		count = 0;
;90:		while (s && *s && count < len) {
;91:			if ( Q_IsColorString(s) ) {
;92:				s += 2;
;93:				continue;
;94:			} else {
;95:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;96:				if (max < glyph->height) {
;97:					max = glyph->height;
;98:				}
;99:				s++;
;100:				count++;
;101:			}
;102:		}
;103:	}
;104:  return max * useScale;
;105:}
;106:
;107:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;108:  float w, h;
;109:  w = width * scale;
;110:  h = height * scale;
;111:  CG_AdjustFrom640( &x, &y, &w, &h );
;112:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;113:}
;114:
;115:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;116:  int len, count;
;117:	vec4_t newColor;
;118:	glyphInfo_t *glyph;
;119:	float useScale;
;120:	fontInfo_t *font = &cgDC.Assets.textFont;
;121:	if (scale <= cg_smallFont.value) {
;122:		font = &cgDC.Assets.smallFont;
;123:	} else if (scale > cg_bigFont.value) {
;124:		font = &cgDC.Assets.bigFont;
;125:	}
;126:	useScale = scale * font->glyphScale;
;127:  if (text) {
;128:// TTimo: FIXME
;129://		const unsigned char *s = text;
;130:		const char *s = text;
;131:		trap_R_SetColor( color );
;132:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;133:		len = strlen(text);
;134:		if (limit > 0 && len > limit) {
;135:			len = limit;
;136:		}
;137:		count = 0;
;138:		while (s && *s && count < len) {
;139:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;140:			//int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;141:			//float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;142:			if ( Q_IsColorString( s ) ) {
;143:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;144:				newColor[3] = color[3];
;145:				trap_R_SetColor( newColor );
;146:				s += 2;
;147:				continue;
;148:			} else {
;149:				float yadj = useScale * glyph->top;
;150:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;151:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;152:					colorBlack[3] = newColor[3];
;153:					trap_R_SetColor( colorBlack );
;154:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
;155:														glyph->imageWidth,
;156:														glyph->imageHeight,
;157:														useScale, 
;158:														glyph->s,
;159:														glyph->t,
;160:														glyph->s2,
;161:														glyph->t2,
;162:														glyph->glyph);
;163:					colorBlack[3] = 1.0;
;164:					trap_R_SetColor( newColor );
;165:				}
;166:				CG_Text_PaintChar(x, y - yadj, 
;167:													glyph->imageWidth,
;168:													glyph->imageHeight,
;169:													useScale, 
;170:													glyph->s,
;171:													glyph->t,
;172:													glyph->s2,
;173:													glyph->t2,
;174:													glyph->glyph);
;175:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;176:				x += (glyph->xSkip * useScale) + adjust;
;177:				s++;
;178:				count++;
;179:			}
;180:		}
;181:		trap_R_SetColor( NULL );
;182:	}
;183:}
;184:
;185:
;186:#endif
;187:
;188:/*
;189:==============
;190:CG_DrawField
;191:
;192:Draws large numbers for status bar and powerups
;193:==============
;194:*/
;195:#if !defined MISSIONPACK && !defined NEOHUD
;196:static void CG_DrawField (int x, int y, int width, int value) {
;197:	char	num[16], *ptr;
;198:	int		l;
;199:	int		frame;
;200:
;201:	if ( width < 1 ) {
;202:		return;
;203:	}
;204:
;205:	// draw number string
;206:	if ( width > 5 ) {
;207:		width = 5;
;208:	}
;209:
;210:	switch ( width ) {
;211:	case 1:
;212:		value = value > 9 ? 9 : value;
;213:		value = value < 0 ? 0 : value;
;214:		break;
;215:	case 2:
;216:		value = value > 99 ? 99 : value;
;217:		value = value < -9 ? -9 : value;
;218:		break;
;219:	case 3:
;220:		value = value > 999 ? 999 : value;
;221:		value = value < -99 ? -99 : value;
;222:		break;
;223:	case 4:
;224:		value = value > 9999 ? 9999 : value;
;225:		value = value < -999 ? -999 : value;
;226:		break;
;227:	}
;228:
;229:	Com_sprintf (num, sizeof(num), "%i", value);
;230:	l = strlen(num);
;231:	if (l > width)
;232:		l = width;
;233:	x += 2 + CHAR_WIDTH*(width - l);
;234:
;235:	ptr = num;
;236:	while (*ptr && l)
;237:	{
;238:		if (*ptr == '-')
;239:			frame = STAT_MINUS;
;240:		else
;241:			frame = *ptr -'0';
;242:
;243:		CG_DrawPic( x, y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
;244:		x += CHAR_WIDTH;
;245:		ptr++;
;246:		l--;
;247:	}
;248:}
;249:#endif // MISSIONPACK || NEOHUD
;250:
;251:
;252:/*
;253:================
;254:CG_Draw3DModel
;255:================
;256:*/
;257:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 261
;258:	refdef_t		refdef;
;259:	refEntity_t		ent;
;260:
;261:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $82
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
NEI4 $78
LABELV $82
line 262
;262:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 265
;263:	}
;264:
;265:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 267
;266:
;267:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 269
;268:
;269:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 270
;270:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 271
;271:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 272
;272:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 273
;273:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 274
;274:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 276
;275:
;276:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 278
;277:
;278:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 280
;279:
;280:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 281
;281:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 283
;282:
;283:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 284
;284:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 285
;285:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 286
;286:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 288
;287:
;288:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 290
;289:
;290:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 291
;291:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 292
;292:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 293
;293:}
LABELV $77
endproc CG_Draw3DModel 508 16
export CG_Draw3DModelColor
proc CG_Draw3DModelColor 544 16
line 306
;294:
;295:
;296:
;297:/*
;298:================
;299:CG_Draw3DModelColor
;300:================
;301:*/
;302:void CG_Draw3DModelColor( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, vec3_t color
;303:#ifdef NEOHUD
;304:, qboolean force3D
;305:#endif
;306: ) {
line 311
;307:	refdef_t		refdef;
;308:	refEntity_t		ent;
;309:
;310:#ifdef NEOHUD
;311:	if (!cg_drawIcons.integer || (!cg_draw3dIcons.integer && !force3D)) {
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $102
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $98
ADDRFP4 36
INDIRI4
CNSTI4 0
NEI4 $98
LABELV $102
line 312
;312:		return;
ADDRGP4 $97
JUMPV
LABELV $98
line 320
;313:	}
;314:#else
;315:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
;316:		return;
;317:	}
;318:#endif
;319:
;320:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 322
;321:
;322:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 324
;323:
;324:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 325
;325:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 326
;326:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 327
;327:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 328
;328:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 329
;329:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 331
;330:
;331:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 333
;332:
;333:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 335
;334:
;335:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 336
;336:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 338
;337:
;338:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 339
;339:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 340
;340:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 341
;341:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 343
;342:
;343:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 345
;344:
;345:	ent.shaderRGBA[0] = color[0] * 255;
ADDRLP4 512
ADDRFP4 32
INDIRP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 516
CNSTF4 1325400064
ASGNF4
ADDRLP4 512
INDIRF4
ADDRLP4 516
INDIRF4
LTF4 $119
ADDRLP4 508
ADDRLP4 512
INDIRF4
ADDRLP4 516
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $120
JUMPV
LABELV $119
ADDRLP4 508
ADDRLP4 512
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $120
ADDRLP4 368+116
ADDRLP4 508
INDIRU4
CVUU1 4
ASGNU1
line 346
;346:	ent.shaderRGBA[1] = color[1] * 255;
ADDRLP4 524
ADDRFP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 528
CNSTF4 1325400064
ASGNF4
ADDRLP4 524
INDIRF4
ADDRLP4 528
INDIRF4
LTF4 $124
ADDRLP4 520
ADDRLP4 524
INDIRF4
ADDRLP4 528
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $125
JUMPV
LABELV $124
ADDRLP4 520
ADDRLP4 524
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $125
ADDRLP4 368+116+1
ADDRLP4 520
INDIRU4
CVUU1 4
ASGNU1
line 347
;347:	ent.shaderRGBA[2] = color[2] * 255;
ADDRLP4 536
ADDRFP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 540
CNSTF4 1325400064
ASGNF4
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
LTF4 $129
ADDRLP4 532
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $130
JUMPV
LABELV $129
ADDRLP4 532
ADDRLP4 536
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $130
ADDRLP4 368+116+2
ADDRLP4 532
INDIRU4
CVUU1 4
ASGNU1
line 348
;348:	ent.shaderRGBA[3] = 255;
ADDRLP4 368+116+3
CNSTU1 255
ASGNU1
line 350
;349:
;350:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 351
;351:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 352
;352:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 353
;353:}
LABELV $97
endproc CG_Draw3DModelColor 544 16
export CG_DrawHead
proc CG_DrawHead 56 40
line 368
;354:
;355:
;356:/*
;357:================
;358:CG_DrawHead
;359:
;360:Used for the status bar, the scoreboard
;361:and CG_DrawAttacker
;362:================
;363:*/
;364:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles
;365:#ifdef NEOHUD
;366:, qboolean force3D
;367:#endif
;368: ) {
line 375
;369:	clipHandle_t	cm;
;370:	clientInfo_t	*ci;
;371:	float			len;
;372:	vec3_t			origin;
;373:	vec3_t			mins, maxs;
;374:
;375:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
ADDRFP4 16
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 377
;376:
;377:	if ( cg_draw3dIcons.integer
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
NEI4 $138
ADDRFP4 24
INDIRI4
CNSTI4 0
EQI4 $135
LABELV $138
line 381
;378:#ifdef NEOHUD
;379:	 || force3D
;380:#endif
;381:	 ) {
line 383
;382:
;383:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 384
;384:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $139
line 385
;385:			return;
ADDRGP4 $133
JUMPV
LABELV $139
line 389
;386:		}
;387:
;388:		// offset the origin y and z to center the head
;389:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 391
;390:
;391:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 392
;392:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 396
;393:
;394:		// calculate distance so the head nearly fills the box
;395:		// assume heads are taller than wide
;396:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
CNSTF4 1060320051
MULF4
ASGNF4
line 397
;397:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 400
;398:
;399:		// allow per-model tweaking
;400:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRF4
ADDF4
ASGNF4
line 403
;401:
;402:#ifdef NEOHUD
;403:		CG_Draw3DModelColor( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, ci->headColor, force3D);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1616
ADDP4
ARGP4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DModelColor
CALLV
pop
line 407
;404:#else
;405:		CG_Draw3DModelColor( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, ci->headColor );
;406:#endif
;407:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $136
JUMPV
LABELV $135
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $153
line 408
;408:		trap_R_SetColor ( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 409
;409:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 410
;410:	}
LABELV $153
LABELV $136
line 413
;411:
;412:	// if they are deferred, draw a cross out
;413:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $156
line 414
;414:		trap_R_SetColor ( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 415
;415:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+148752+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 416
;416:	}
LABELV $156
line 417
;417:}
LABELV $133
endproc CG_DrawHead 56 40
export CG_DrawFlagModel
proc CG_DrawFlagModel 68 32
line 426
;418:
;419:/*
;420:================
;421:CG_DrawFlagModel
;422:
;423:Used for both the status bar and the scoreboard
;424:================
;425:*/
;426:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 433
;427:	qhandle_t		cm;
;428:	float			len;
;429:	vec3_t			origin, angles;
;430:	vec3_t			mins, maxs;
;431:	qhandle_t		handle;
;432:
;433:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $161
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $161
line 435
;434:
;435:		VectorClear( angles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 437
;436:
;437:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+148752+36
INDIRI4
ASGNI4
line 440
;438:
;439:		// offset the origin y and z to center the flag
;440:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 442
;441:
;442:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 443
;443:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 447
;444:
;445:		// calculate distance so the flag nearly fills the box
;446:		// assume heads are taller than wide
;447:		len = 0.5 * ( maxs[2] - mins[2] );
ADDRLP4 52
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 448
;448:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 450
;449:
;450:		angles[YAW] = 60 * sin( ( cg.time % TMOD_2000 ) / 2000.0 );
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5730265
MODI4
CVIF4 4
CNSTF4 973279855
MULF4
ARGF4
ADDRLP4 60
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 60
INDIRF4
CNSTF4 1114636288
MULF4
ASGNF4
line 452
;451:
;452:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $178
line 453
;453:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148752+36
INDIRI4
ASGNI4
line 454
;454:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $179
JUMPV
LABELV $178
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $182
line 455
;455:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148752+40
INDIRI4
ASGNI4
line 456
;456:		} else if( team == TEAM_FREE ) {
ADDRGP4 $183
JUMPV
LABELV $182
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $160
line 457
;457:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148752+44
INDIRI4
ASGNI4
line 458
;458:		} else {
line 459
;459:			return;
LABELV $187
LABELV $183
LABELV $179
line 461
;460:		}
;461:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 462
;462:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $162
JUMPV
LABELV $161
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $190
line 465
;463:		gitem_t *item;
;464:
;465:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $193
line 466
;466:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 467
;467:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $194
JUMPV
LABELV $193
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $195
line 468
;468:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 469
;469:		} else if( team == TEAM_FREE ) {
ADDRGP4 $196
JUMPV
LABELV $195
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $160
line 470
;470:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 471
;471:		} else {
line 472
;472:			return;
LABELV $198
LABELV $196
LABELV $194
line 474
;473:		}
;474:		if (item) {
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $199
line 475
;475:			CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 476
;476:		}
LABELV $199
line 477
;477:	}
LABELV $190
LABELV $162
line 478
;478:}
LABELV $160
endproc CG_DrawFlagModel 68 32
proc CG_DrawHoldableItem 4 20
line 1602
;479:
;480:/*
;481:================
;482:CG_DrawStatusBarHead
;483:
;484:================
;485:*/
;486:#if !defined MISSIONPACK && !defined NEOHUD
;487:
;488:static void CG_DrawStatusBarHead( float x ) {
;489:	vec3_t		angles;
;490:	float		size, stretch;
;491:	float		frac;
;492:
;493:	VectorClear( angles );
;494:
;495:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
;496:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
;497:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
;498:
;499:		stretch = size - ICON_SIZE * 1.25;
;500:		// kick in the direction of damage
;501:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
;502:
;503:		cg.headStartYaw = 180 + cg.damageX * 45;
;504:
;505:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
;506:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
;507:
;508:		cg.headStartTime = cg.time;
;509:		cg.headEndTime = cg.time + 100 + random() * 2000;
;510:	} else {
;511:		if ( cg.time >= cg.headEndTime ) {
;512:			// select a new head angle
;513:			cg.headStartYaw = cg.headEndYaw;
;514:			cg.headStartPitch = cg.headEndPitch;
;515:			cg.headStartTime = cg.headEndTime;
;516:			cg.headEndTime = cg.time + 100 + random() * 2000;
;517:
;518:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
;519:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
;520:		}
;521:
;522:		size = ICON_SIZE * 1.25;
;523:	}
;524:
;525:	// if the server was frozen for a while we may have a bad head start time
;526:	if ( cg.headStartTime > cg.time ) {
;527:		cg.headStartTime = cg.time;
;528:	}
;529:
;530:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
;531:	frac = frac * frac * ( 3 - 2 * frac );
;532:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
;533:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
;534:
;535:	CG_DrawHead( x, cgs.screenYmax + 1 - size, size, size, cg.snap->ps.clientNum, angles );
;536:}
;537:#endif // MISSIONPACK
;538:
;539:
;540:/*
;541:================
;542:CG_DrawStatusBarFlag
;543:
;544:================
;545:*/
;546:#if !defined MISSIONPACK && !defined NEOHUD
;547:static void CG_DrawStatusBarFlag( float x, int team ) {
;548:	CG_DrawFlagModel( x, cgs.screenYmax + 1 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
;549:}
;550:#endif // MISSIONPACK
;551:
;552:
;553:/*
;554:================
;555:CG_DrawTeamBackground
;556:================
;557:*/
;558:#ifndef NEOHUD
;559:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;560:{
;561:	vec4_t		hcolor;
;562:
;563:	hcolor[3] = alpha;
;564:	if ( team == TEAM_RED ) {
;565:		hcolor[0] = 1.0f;
;566:		hcolor[1] = 0.0f;
;567:		hcolor[2] = 0.0f;
;568:	} else if ( team == TEAM_BLUE ) {
;569:		hcolor[0] = 0.0f;
;570:		hcolor[1] = 0.1f;
;571:		hcolor[2] = 1.0f;
;572:	} else {
;573:		return;
;574:	}
;575:	trap_R_SetColor( hcolor );
;576:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
;577:	trap_R_SetColor( NULL );
;578:}
;579:#endif
;580:
;581:/*
;582:================
;583:CG_DrawStatusBar
;584:================
;585:*/
;586:#if !defined MISSIONPACK && !defined NEOHUD
;587:#define STATUSBAR_HEIGHT 60
;588:static void CG_DrawStatusBar( void ) {
;589:	int			color;
;590:	centity_t	*cent;
;591:	playerState_t	*ps;
;592:	int			value;
;593:	vec4_t		hcolor;
;594:	vec3_t		angles;
;595:	vec3_t		origin;
;596:	float		y;
;597:#ifdef MISSIONPACK
;598:	qhandle_t	handle;
;599:#endif
;600:	static float colors[4][4] = { 
;601://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;602:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;603:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;604:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;605:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;606:
;607:	if ( cg_drawStatus.integer == 0 ) {
;608:		return;
;609:	}
;610:
;611:	// draw the team background
;612:	CG_DrawTeamBackground( cgs.screenXmin, cgs.screenYmax - STATUSBAR_HEIGHT + 1,
;613:		cgs.screenXmax - cgs.screenXmin + 1, STATUSBAR_HEIGHT, 
;614:		0.33f, cg.snap->ps.persistant[ PERS_TEAM ] );
;615:
;616:	y = cgs.screenYmax + 1 - ICON_SIZE;
;617:
;618:	cent = &cg_entities[cg.snap->ps.clientNum];
;619:	ps = &cg.snap->ps;
;620:
;621:	VectorClear( angles );
;622:
;623:	// draw any 3D icons first, so the changes back to 2D are minimized
;624:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
;625:		origin[0] = 70;
;626:		origin[1] = 0;
;627:		origin[2] = 0;
;628:		angles[YAW] = 90 + 20 * sin( ( cg.time % TMOD_1000 ) / 1000.0 );
;629:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
;630:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;631:	}
;632:
;633:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
;634:
;635:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
;636:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
;637:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
;638:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
;639:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
;640:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
;641:	}
;642:
;643:	if ( ps->stats[ STAT_ARMOR ] ) {
;644:		origin[0] = 90;
;645:		origin[1] = 0;
;646:		origin[2] = -10;
;647:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;648:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
;649:					   cgs.media.armorModel, 0, origin, angles );
;650:	}
;651:#ifdef MISSIONPACK
;652:	if( cgs.gametype == GT_HARVESTER ) {
;653:		origin[0] = 90;
;654:		origin[1] = 0;
;655:		origin[2] = -10;
;656:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;657:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;658:			handle = cgs.media.redCubeModel;
;659:		} else {
;660:			handle = cgs.media.blueCubeModel;
;661:		}
;662:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;663:	}
;664:#endif
;665:	//
;666:	// ammo
;667:	//
;668:	if ( cent->currentState.weapon ) {
;669:		value = ps->ammo[cent->currentState.weapon];
;670:		if ( value > -1 ) {
;671:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
;672:				&& cg.predictedPlayerState.weaponTime > 100 ) {
;673:				// draw as dark grey when reloading
;674:				color = 2;	// dark grey
;675:			} else {
;676:				if ( value >= 0 ) {
;677:					color = 0;	// yellow
;678:				} else {
;679:					color = 1;	// red
;680:				}
;681:			}
;682:#ifdef USE_NEW_FONT_RENDERER
;683:			CG_SelectFont( 1 );
;684:			CG_DrawString( CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;685:			CG_SelectFont( 0 );
;686:#else
;687:			trap_R_SetColor( colors[color] );
;688:			CG_DrawField( 0, y, 3, value );
;689:#endif
;690:			trap_R_SetColor( NULL );
;691:
;692:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;693:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;694:				qhandle_t	icon;
;695:
;696:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
;697:				if ( icon ) {
;698:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, icon );
;699:				}
;700:			}
;701:		}
;702:	}
;703:
;704:	//
;705:	// health
;706:	//
;707:	value = ps->stats[STAT_HEALTH];
;708:	if ( value > 100 ) {
;709:		color = 3; // white
;710:	} else if ( value > 25 ) {
;711:		color = 0; 	// yellow
;712:	} else if (value > 0) {
;713:		color = (cg.time >> 8) & 1;	// red/yellow flashing
;714:	} else {
;715:		color = 1; // red
;716:	}
;717:
;718:#ifdef USE_NEW_FONT_RENDERER
;719:	CG_SelectFont( 1 );
;720:	CG_DrawString( 185 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;721:	CG_SelectFont( 0 );
;722:#else
;723:	trap_R_SetColor( colors[ color ] );
;724:	// stretch the health up when taking damage
;725:	CG_DrawField( 185, y, 3, value );
;726:#endif
;727:	
;728:	CG_ColorForHealth( hcolor );
;729:	trap_R_SetColor( hcolor );
;730:
;731:	//
;732:	// armor
;733:	//
;734:	value = ps->stats[STAT_ARMOR];
;735:	if ( value > 0 ) {
;736:#ifdef USE_NEW_FONT_RENDERER
;737:		CG_SelectFont( 1 );
;738:		CG_DrawString( 370 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;739:		CG_SelectFont( 0 );
;740:#else
;741:		trap_R_SetColor( colors[0] );
;742:		CG_DrawField( 370, y, 3, value );
;743:#endif
;744:		trap_R_SetColor( NULL );
;745:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;746:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;747:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
;748:		}
;749:	}
;750:
;751:#ifdef MISSIONPACK
;752:	//
;753:	// cubes
;754:	//
;755:	if( cgs.gametype == GT_HARVESTER ) {
;756:		value = ps->generic1;
;757:		if( value > 99 ) {
;758:			value = 99;
;759:		}
;760:		trap_R_SetColor( colors[0] );
;761:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), y, 2, value);
;762:		trap_R_SetColor( NULL );
;763:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;764:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;765:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;766:				handle = cgs.media.redCubeIcon;
;767:			} else {
;768:				handle = cgs.media.blueCubeIcon;
;769:			}
;770:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), y, ICON_SIZE, ICON_SIZE, handle );
;771:		}
;772:	}
;773:#endif
;774:}
;775:#endif
;776:
;777:/*
;778:===========================================================================================
;779:
;780:  UPPER RIGHT CORNER
;781:
;782:===========================================================================================
;783:*/
;784:
;785:/*
;786:================
;787:CG_DrawAttacker
;788:
;789:================
;790:*/
;791:#ifndef NEOHUD
;792:static float CG_DrawAttacker( float y ) {
;793:	int			t;
;794:	float		size;
;795:	vec3_t		angles;
;796:	const char	*info;
;797:	const char	*name;
;798:	int			clientNum;
;799:	vec4_t		color;
;800:
;801:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
;802:		return y;
;803:	}
;804:
;805:	if ( !cg.attackerTime ) {
;806:		return y;
;807:	}
;808:
;809:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
;810:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
;811:		return y;
;812:	}
;813:
;814:	t = cg.time - cg.attackerTime;
;815:	if ( t > ATTACKER_HEAD_TIME ) {
;816:		cg.attackerTime = 0;
;817:		return y;
;818:	}
;819:
;820:	size = ICON_SIZE * 1.25;
;821:
;822:	angles[PITCH] = 0;
;823:	angles[YAW] = 180;
;824:	angles[ROLL] = 0;
;825:	CG_DrawHead( cgs.screenXmax + 1 - size, y, size, size, clientNum, angles );
;826:
;827:	info = CG_ConfigString( CS_PLAYERS + clientNum );
;828:	name = Info_ValueForKey(  info, "n" );
;829:	y += size;
;830:
;831:	VectorSet( color, 1, 1, 1 );
;832:	color[3] = 0.5f;
;833:
;834:	CG_DrawString( cgs.screenXmax - 4, y, name, color, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_PROPORTIONAL | DS_RIGHT );
;835:
;836:	return y + BIGCHAR_HEIGHT + 2;
;837:}
;838:#endif
;839:
;840:/*
;841:================
;842:CG_DrawSpeedMeter
;843:================
;844:*/
;845:#ifndef NEOHUD
;846:static float CG_DrawSpeedMeter( float y ) {
;847:	const char *s;
;848:
;849:	/* speed meter can get in the way of the scoreboard */
;850:	if ( cg.scoreBoardShowing ) {
;851:		return y;
;852:	}
;853:
;854:	s = va( "%1.0fups", cg.xyspeed );
;855:
;856:	if ( cg_drawSpeed.integer == 1 ) {
;857:		/* top left-hand corner of screen */
;858:		CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
;859:		return y + BIGCHAR_HEIGHT + 4;
;860:	} else {
;861:		/* center of screen */
;862:		CG_DrawString( 320, 300, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;863:		return y;
;864:	}
;865:}
;866:#endif
;867:
;868:/*
;869:==================
;870:CG_DrawSnapshot
;871:==================
;872:*/
;873:#ifndef NEOHUD
;874:static float CG_DrawSnapshot( float y ) {
;875:	const char *s;
;876:
;877:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
;878:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;879:
;880:	CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;881:
;882:	return y + BIGCHAR_HEIGHT + 4;
;883:}
;884:#endif
;885:
;886:/*
;887:==================
;888:CG_DrawFPS
;889:==================
;890:*/
;891:#ifndef NEOHUD
;892:#define	FPS_FRAMES	4
;893:static float CG_DrawFPS( float y ) {
;894:	const char	*s;
;895:	static int	previousTimes[FPS_FRAMES];
;896:	static int	index;
;897:	int		i, total;
;898:	int		fps;
;899:	static	int	previous;
;900:	int		t, frameTime;
;901:
;902:	// don't use serverTime, because that will be drifting to
;903:	// correct for internet lag changes, timescales, timedemos, etc
;904:	t = trap_Milliseconds();
;905:	frameTime = t - previous;
;906:	previous = t;
;907:
;908:	previousTimes[index % FPS_FRAMES] = frameTime;
;909:	index++;
;910:	if ( index > FPS_FRAMES ) {
;911:		// average multiple frames together to smooth changes out a bit
;912:		total = 0;
;913:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
;914:			total += previousTimes[i];
;915:		}
;916:		if ( !total ) {
;917:			total = 1;
;918:		}
;919:		fps = 1000 * FPS_FRAMES / total;
;920:
;921:		s = va( "%ifps", fps );
;922:		CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
;923:	}
;924:
;925:	return y + BIGCHAR_HEIGHT + 4;
;926:}
;927:#endif
;928:
;929:/*
;930:=================
;931:CG_DrawTimer
;932:=================
;933:*/
;934:#ifndef NEOHUD
;935:static float CG_DrawTimer( float y ) {
;936:	const char	*s;
;937:	int			mins, seconds;
;938:	int			msec;
;939:
;940:	msec = cg.time - cgs.levelStartTime;
;941:
;942:	seconds = msec / 1000;
;943:	mins = seconds / 60;
;944:	seconds -= mins * 60;
;945:
;946:	s = va( "%i:%02i", mins, seconds );
;947:	CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
;948:
;949:	return y + BIGCHAR_HEIGHT + 4;
;950:}
;951:#endif
;952:
;953:
;954:/*
;955:=================
;956:CG_DrawTeamOverlay
;957:=================
;958:*/
;959:#ifndef NEOHUD
;960:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
;961:	int x, w, h, xx;
;962:	int i, j, len;
;963:	const char *p;
;964:	vec4_t		hcolor;
;965:	int pwidth, lwidth;
;966:	int plyrs;
;967:	char st[16];
;968:	clientInfo_t *ci;
;969:	gitem_t	*item;
;970:	int ret_y, count;
;971:
;972:	if ( !cg_drawTeamOverlay.integer ) {
;973:		return y;
;974:	}
;975:
;976:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
;977:		return y; // Not on any team
;978:	}
;979:
;980:	plyrs = 0;
;981:
;982:	// max player name width
;983:	pwidth = 0;
;984:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
;985:	for (i = 0; i < count; i++) {
;986:		ci = cgs.clientinfo + sortedTeamPlayers[i];
;987:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
;988:			plyrs++;
;989:			len = CG_DrawStrlen(ci->name);
;990:			if (len > pwidth)
;991:				pwidth = len;
;992:		}
;993:	}
;994:
;995:	if (!plyrs)
;996:		return y;
;997:
;998:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
;999:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
;1000:
;1001:	// max location name width
;1002:	lwidth = 0;
;1003:	for (i = 1; i < MAX_LOCATIONS; i++) {
;1004:		p = CG_ConfigString(CS_LOCATIONS + i);
;1005:		if (p && *p) {
;1006:			len = CG_DrawStrlen(p);
;1007:			if (len > lwidth)
;1008:				lwidth = len;
;1009:		}
;1010:	}
;1011:
;1012:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
;1013:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
;1014:
;1015:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
;1016:
;1017:	if ( right )
;1018:		x = cgs.screenXmax + 1 - w;
;1019:	else
;1020:		x = cgs.screenXmin;
;1021:
;1022:	h = plyrs * TINYCHAR_HEIGHT;
;1023:
;1024:	if ( upper ) {
;1025:		ret_y = y + h;
;1026:	} else {
;1027:		y -= h;
;1028:		ret_y = y;
;1029:	}
;1030:
;1031:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
;1032:		hcolor[0] = 1.0f;
;1033:		hcolor[1] = 0.0f;
;1034:		hcolor[2] = 0.0f;
;1035:		hcolor[3] = 0.33f;
;1036:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
;1037:		hcolor[0] = 0.0f;
;1038:		hcolor[1] = 0.0f;
;1039:		hcolor[2] = 1.0f;
;1040:		hcolor[3] = 0.33f;
;1041:	}
;1042:	trap_R_SetColor( hcolor );
;1043:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
;1044:	trap_R_SetColor( NULL );
;1045:
;1046:	for (i = 0; i < count; i++) {
;1047:		ci = cgs.clientinfo + sortedTeamPlayers[i];
;1048:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
;1049:
;1050:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
;1051:
;1052:			xx = x + TINYCHAR_WIDTH;
;1053:
;1054:			CG_DrawString( xx, y, ci->name, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH, DS_PROPORTIONAL );
;1055:
;1056:			if (lwidth) {
;1057:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
;1058:				if (!p || !*p)
;1059:					p = "unknown";
;1060:				len = CG_DrawStrlen(p);
;1061:				if (len > lwidth)
;1062:					len = lwidth;
;1063:
;1064://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;1065://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;1066:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
;1067:				CG_DrawString( xx, y, p, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXLOCATION_WIDTH, DS_PROPORTIONAL );
;1068:			}
;1069:
;1070:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
;1071:
;1072:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
;1073:
;1074:			xx = x + TINYCHAR_WIDTH * 3 + 
;1075:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1076:
;1077:			CG_DrawString( xx, y, st, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0 );
;1078:
;1079:			// draw weapon icon
;1080:			xx += TINYCHAR_WIDTH * 3;
;1081:
;1082:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
;1083:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
;1084:					cg_weapons[ci->curWeapon].weaponIcon );
;1085:			} else {
;1086:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
;1087:					cgs.media.deferShader );
;1088:			}
;1089:
;1090:			// Draw powerup icons
;1091:			if (right) {
;1092:				xx = x;
;1093:			} else {
;1094:				xx = x + w - TINYCHAR_WIDTH;
;1095:			}
;1096:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
;1097:				if (ci->powerups & (1 << j)) {
;1098:
;1099:					item = BG_FindItemForPowerup( j );
;1100:
;1101:					if (item) {
;1102:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
;1103:						trap_R_RegisterShader( item->icon ) );
;1104:						if (right) {
;1105:							xx -= TINYCHAR_WIDTH;
;1106:						} else {
;1107:							xx += TINYCHAR_WIDTH;
;1108:						}
;1109:					}
;1110:				}
;1111:			}
;1112:
;1113:			y += TINYCHAR_HEIGHT;
;1114:		}
;1115:	}
;1116:
;1117:	return ret_y;
;1118:}
;1119:#endif
;1120:
;1121:/*
;1122:=====================
;1123:CG_DrawUpperRight
;1124:
;1125:=====================
;1126:*/
;1127:#ifndef NEOHUD
;1128:static void CG_DrawUpperRight(stereoFrame_t stereoFrame)
;1129:{
;1130:	float	y;
;1131:
;1132:	y = cgs.screenYmin;
;1133:
;1134:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
;1135:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
;1136:	} 
;1137:	if ( cg_drawSnapshot.integer ) {
;1138:		y = CG_DrawSnapshot( y );
;1139:	}
;1140:	if (cg_drawFPS.integer && (stereoFrame == STEREO_CENTER || stereoFrame == STEREO_RIGHT)) {
;1141:		y = CG_DrawFPS( y );
;1142:	}
;1143:	if ( cg_drawSpeed.integer ) {
;1144:		y = CG_DrawSpeedMeter( y );
;1145:	}	
;1146:	if ( cg_drawTimer.integer ) {
;1147:		y = CG_DrawTimer( y );
;1148:	}
;1149:	if ( cg_drawAttacker.integer ) {
;1150:		y = CG_DrawAttacker( y );
;1151:	}
;1152:}
;1153:#endif
;1154:
;1155:/*
;1156:===========================================================================================
;1157:
;1158:  LOWER RIGHT CORNER
;1159:
;1160:===========================================================================================
;1161:*/
;1162:
;1163:/*
;1164:=================
;1165:CG_DrawScores
;1166:
;1167:Draw the small two score display
;1168:=================
;1169:*/
;1170:#if !defined MISSIONPACK && !defined NEOHUD
;1171:static float CG_DrawScores( float y ) {
;1172:	const char	*s;
;1173:	int			s1, s2, score;
;1174:	int			x, x0, w;
;1175:	int			v;
;1176:	vec4_t		color;
;1177:	float		y1;
;1178:	gitem_t		*item;
;1179:
;1180:	s1 = cgs.scores1;
;1181:	s2 = cgs.scores2;
;1182:
;1183:	y -=  BIGCHAR_HEIGHT + 8 - 4;
;1184:
;1185:	y1 = y;
;1186:
;1187:	// draw from the right side to left
;1188:	if ( cgs.gametype >= GT_TEAM ) {
;1189:		x0 = cgs.screenXmax + 1;
;1190:		color[0] = 0.0f;
;1191:		color[1] = 0.1f;
;1192:		color[2] = 1.0f;
;1193:		color[3] = 0.33f;
;1194:		// second score
;1195:		s = va( "%2i", s2 );
;1196:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1197:		x = x0 - w;
;1198:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1199:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;1200:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1201:		}
;1202:		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1203:
;1204:		if ( cgs.gametype == GT_CTF ) {
;1205:			// Display flag status
;1206:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
;1207:
;1208:			if (item) {
;1209:				y1 = y - BIGCHAR_HEIGHT - 8;
;1210:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
;1211:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
;1212:				}
;1213:			}
;1214:		}
;1215:		color[0] = 1.0f;
;1216:		color[1] = 0.0f;
;1217:		color[2] = 0.0f;
;1218:		color[3] = 0.33f;
;1219:		// first score
;1220:		x0 = x;
;1221:		s = va( "%2i", s1 );
;1222:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1223:		x -= w;
;1224:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1225:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
;1226:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1227:		}
;1228:
;1229:		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1230:
;1231:		if ( cgs.gametype == GT_CTF ) {
;1232:			// Display flag status
;1233:			item = BG_FindItemForPowerup( PW_REDFLAG );
;1234:
;1235:			if (item) {
;1236:				y1 = y - BIGCHAR_HEIGHT - 8;
;1237:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
;1238:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
;1239:				}
;1240:			}
;1241:		}
;1242:
;1243:#ifdef MISSIONPACK
;1244:		if ( cgs.gametype == GT_1FCTF ) {
;1245:			// Display flag status
;1246:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1247:
;1248:			if (item) {
;1249:				y1 = y - BIGCHAR_HEIGHT - 8;
;1250:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1251:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1252:				}
;1253:			}
;1254:		}
;1255:#endif
;1256:		if ( cgs.gametype >= GT_CTF ) {
;1257:			v = cgs.capturelimit;
;1258:		} else {
;1259:			v = cgs.fraglimit;
;1260:		}
;1261:		if ( v ) {
;1262:			s = va( "%2i", v );
;1263:			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1264:		}
;1265:
;1266:	} else {
;1267:		qboolean	spectator;
;1268:
;1269:		x = cgs.screenXmax + 1;
;1270:
;1271:		score = cg.snap->ps.persistant[PERS_SCORE];
;1272:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
;1273:
;1274:		// always show your score in the second box if not in first place
;1275:		if ( s1 != score ) {
;1276:			s2 = score;
;1277:		}
;1278:		if ( s2 != SCORE_NOT_PRESENT ) {
;1279:			x0 = x;
;1280:			s = va( "%2i", s2 );
;1281:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1282:			x -= w;
;1283:			if ( !spectator && score == s2 && score != s1 ) {
;1284:				color[0] = 1.0f;
;1285:				color[1] = 0.0f;
;1286:				color[2] = 0.0f;
;1287:				color[3] = 0.33f;
;1288:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1289:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1290:			} else {
;1291:				color[0] = 0.5f;
;1292:				color[1] = 0.5f;
;1293:				color[2] = 0.5f;
;1294:				color[3] = 0.33f;
;1295:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1296:			}	
;1297:			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1298:		}
;1299:
;1300:		// first place
;1301:		if ( s1 != SCORE_NOT_PRESENT ) {
;1302:			x0 = x;
;1303:			s = va( "%2i", s1 );
;1304:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1305:			x -= w;
;1306:			if ( !spectator && score == s1 ) {
;1307:				color[0] = 0.0f;
;1308:				color[1] = 0.1f;
;1309:				color[2] = 1.0f;
;1310:				color[3] = 0.33f;
;1311:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1312:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1313:			} else {
;1314:				color[0] = 0.5f;
;1315:				color[1] = 0.5f;
;1316:				color[2] = 0.5f;
;1317:				color[3] = 0.33f;
;1318:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1319:			}
;1320:			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1321:		}
;1322:
;1323:		if ( cgs.fraglimit ) {
;1324:			s = va( "%2i", cgs.fraglimit );
;1325:			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1326:		}
;1327:	}
;1328:
;1329:	return y1 - 8;
;1330:}
;1331:#endif // MISSIONPACK
;1332:
;1333:
;1334:/*
;1335:================
;1336:CG_DrawPowerups
;1337:================
;1338:*/
;1339:#if !defined MISSIONPACK && !defined NEOHUD
;1340:static float CG_DrawPowerups( float y ) {
;1341:	int		sorted[MAX_POWERUPS];
;1342:	int		sortedTime[MAX_POWERUPS];
;1343:	int		i, j, k;
;1344:	int		active;
;1345:	playerState_t	*ps;
;1346:	int		t;
;1347:	gitem_t	*item;
;1348:	int		x;
;1349:	int		color;
;1350:	float	size;
;1351:	float	f;
;1352:	static const float colors[2][4] = { 
;1353:		{ 0.2f, 1.0f, 0.2f, 1.0f },
;1354:		{ 1.0f, 0.2f, 0.2f, 1.0f } 
;1355:	};
;1356:
;1357:	ps = &cg.snap->ps;
;1358:
;1359:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
;1360:		return y;
;1361:	}
;1362:
;1363:	// sort the list by time remaining
;1364:	active = 0;
;1365:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
;1366:		if ( !ps->powerups[ i ] ) {
;1367:			continue;
;1368:		}
;1369:		t = ps->powerups[ i ] - cg.time;
;1370:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1371:		// This is true of the CTF flags
;1372:		if ( t < 0 || t > 999000) {
;1373:			continue;
;1374:		}
;1375:
;1376:		// insert into the list
;1377:		for ( j = 0 ; j < active ; j++ ) {
;1378:			if ( sortedTime[j] >= t ) {
;1379:				for ( k = active - 1 ; k >= j ; k-- ) {
;1380:					sorted[k+1] = sorted[k];
;1381:					sortedTime[k+1] = sortedTime[k];
;1382:				}
;1383:				break;
;1384:			}
;1385:		}
;1386:		sorted[j] = i;
;1387:		sortedTime[j] = t;
;1388:		active++;
;1389:	}
;1390:
;1391:	// draw the icons and timers
;1392:	x = cgs.screenXmax + 1 - ICON_SIZE - CHAR_WIDTH * 2;
;1393:	for ( i = 0 ; i < active ; i++ ) {
;1394:		item = BG_FindItemForPowerup( sorted[i] );
;1395:
;1396:		if ( item ) {
;1397:
;1398:			color = 1;
;1399:
;1400:			y -= ICON_SIZE;
;1401:
;1402:			trap_R_SetColor( colors[color] );
;1403:			CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
;1404:
;1405:			t = ps->powerups[ sorted[i] ];
;1406:			if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
;1407:				trap_R_SetColor( NULL );
;1408:			} else {
;1409:				vec4_t	modulate;
;1410:
;1411:				f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
;1412:				f -= (int)f;
;1413:				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
;1414:				trap_R_SetColor( modulate );
;1415:			}
;1416:
;1417:			if ( cg.powerupActive == sorted[i] && 
;1418:				cg.time - cg.powerupTime < PULSE_TIME ) {
;1419:				f = 1.0 - ( (float)( cg.time - cg.powerupTime ) / PULSE_TIME );
;1420:				size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
;1421:			} else {
;1422:				size = ICON_SIZE;
;1423:			}
;1424:
;1425:			CG_DrawPic( cgs.screenXmax + 1 - size, y + ICON_SIZE / 2 - size / 2, 
;1426:				size, size, trap_R_RegisterShader( item->icon ) );
;1427:		} // if ( item )
;1428:	}
;1429:	trap_R_SetColor( NULL );
;1430:
;1431:	return y;
;1432:}
;1433:#endif // MISSIONPACK
;1434:
;1435:
;1436:/*
;1437:=====================
;1438:CG_DrawLowerRight
;1439:
;1440:=====================
;1441:*/
;1442:#if !defined MISSIONPACK && !defined NEOHUD
;1443:static void CG_DrawLowerRight( void ) {
;1444:	float	y;
;1445:
;1446:	y = cgs.screenYmax + 1 - STATUSBAR_HEIGHT;
;1447:
;1448:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
;1449:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
;1450:	} 
;1451:
;1452:	y = CG_DrawScores( y );
;1453:	y = CG_DrawPowerups( y );
;1454:}
;1455:#endif // MISSIONPACK
;1456:
;1457:
;1458:/*
;1459:===================
;1460:CG_DrawPickupItem
;1461:===================
;1462:*/
;1463:#if !defined MISSIONPACK && !defined NEOHUD
;1464:static int CG_DrawPickupItem( int y ) {
;1465:	int		value;
;1466:	float	*fadeColor;
;1467:	const char *text;
;1468:
;1469:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
;1470:		return y;
;1471:	}
;1472:
;1473:	y -= PICKUP_ICON_SIZE;
;1474:
;1475:	value = cg.itemPickup;
;1476:	if ( value ) {
;1477:		fadeColor = CG_FadeColorTime( cg.itemPickupTime, 3000, 250 );
;1478:		if ( fadeColor ) {
;1479:			CG_RegisterItemVisuals( value );
;1480:			trap_R_SetColor( fadeColor );
;1481:			CG_DrawPic( cgs.screenXmin + 8, y, PICKUP_ICON_SIZE, PICKUP_ICON_SIZE, cg_items[ value ].icon );
;1482:			if ( cg.itemPickupCount > 1 ) {
;1483:				text = va( "%s x%i", bg_itemlist[ value ].pickup_name, cg.itemPickupCount );
;1484:			} else {
;1485:				text = bg_itemlist[ value ].pickup_name;
;1486:			}
;1487:
;1488:			CG_DrawString( cgs.screenXmin + PICKUP_ICON_SIZE + 16, y + (PICKUP_ICON_SIZE/2 - PICKUP_TEXT_SIZE/2), 
;1489:				text, fadeColor, PICKUP_TEXT_SIZE, PICKUP_TEXT_SIZE, 0, DS_SHADOW | DS_PROPORTIONAL );
;1490:			
;1491:			trap_R_SetColor( NULL );
;1492:		} else {
;1493:			cg.itemPickupCount = 0;
;1494:		}
;1495:	}
;1496:	
;1497:	return y;
;1498:}
;1499:#endif // MISSIONPACK
;1500:
;1501:
;1502:/*
;1503:=====================
;1504:CG_DrawLowerLeft
;1505:=====================
;1506:*/
;1507:#if !defined MISSIONPACK && !defined NEOHUD
;1508:static void CG_DrawLowerLeft( void ) {
;1509:	float	y;
;1510:
;1511:	y = cgs.screenYmax + 1 - STATUSBAR_HEIGHT;
;1512:
;1513:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
;1514:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
;1515:	} 
;1516:
;1517:	y = CG_DrawPickupItem( y );
;1518:}
;1519:#endif // MISSIONPACK
;1520:
;1521:
;1522://===========================================================================================
;1523:
;1524:/*
;1525:=================
;1526:CG_DrawTeamInfo
;1527:=================
;1528:*/
;1529:#if !defined MISSIONPACK && !defined NEOHUD
;1530:static void CG_DrawTeamInfo( void ) {
;1531:	int w, h;
;1532:	int i, len;
;1533:	vec4_t		hcolor;
;1534:	int		chatHeight;
;1535:
;1536:	#define CHATLOC_Y (cgs.screenYmax + 1 - STATUSBAR_HEIGHT ) // bottom end
;1537:	#define CHATLOC_X (cgs.screenXmin)
;1538:
;1539:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
;1540:		chatHeight = cg_teamChatHeight.integer;
;1541:	else
;1542:		chatHeight = TEAMCHAT_HEIGHT;
;1543:	if (chatHeight <= 0)
;1544:		return; // disabled
;1545:
;1546:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
;1547:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
;1548:			cgs.teamLastChatPos++;
;1549:		}
;1550:
;1551:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
;1552:
;1553:		w = 0;
;1554:
;1555:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
;1556:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
;1557:			if (len > w)
;1558:				w = len;
;1559:		}
;1560:		w *= TINYCHAR_WIDTH;
;1561:		w += TINYCHAR_WIDTH * 2;
;1562:
;1563:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
;1564:			hcolor[0] = 1.0f;
;1565:			hcolor[1] = 0.0f;
;1566:			hcolor[2] = 0.0f;
;1567:			hcolor[3] = 0.33f;
;1568:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;1569:			hcolor[0] = 0.0f;
;1570:			hcolor[1] = 0.0f;
;1571:			hcolor[2] = 1.0f;
;1572:			hcolor[3] = 0.33f;
;1573:		} else {
;1574:			hcolor[0] = 0.0f;
;1575:			hcolor[1] = 1.0f;
;1576:			hcolor[2] = 0.0f;
;1577:			hcolor[3] = 0.33f;
;1578:		}
;1579:
;1580:		trap_R_SetColor( hcolor );
;1581:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, w, h, cgs.media.teamStatusBar );
;1582:		trap_R_SetColor( NULL );
;1583:
;1584:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
;1585:		hcolor[3] = 1.0f;
;1586:
;1587:		for ( i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i-- ) {
;1588:			CG_DrawString( CHATLOC_X + TINYCHAR_WIDTH, CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1589:				cgs.teamChatMsgs[i % chatHeight], hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, DS_PROPORTIONAL );
;1590:		}
;1591:	}
;1592:}
;1593:#endif // MISSIONPACK
;1594:
;1595:
;1596:/*
;1597:===================
;1598:CG_DrawHoldableItem
;1599:===================
;1600:*/
;1601:#ifndef MISSIONPACK
;1602:static void CG_DrawHoldableItem( void ) { 
line 1605
;1603:	int		value;
;1604:
;1605:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 1606
;1606:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $204
line 1607
;1607:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1608
;1608:		CG_DrawPic( cgs.screenXmax + 1 - ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1111490560
SUBF4
ARGF4
CNSTF4 1129840640
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1609
;1609:	}
LABELV $204
line 1610
;1610:}
LABELV $202
endproc CG_DrawHoldableItem 4 20
export CG_DrawCenterString
proc CG_DrawCenterString 1052 32
line 1979
;1611:#endif // MISSIONPACK
;1612:
;1613:#ifdef MISSIONPACK
;1614:/*
;1615:===================
;1616:CG_DrawPersistantPowerup
;1617:===================
;1618:*/
;1619:#if 0 // sos001208 - DEAD
;1620:static void CG_DrawPersistantPowerup( void ) { 
;1621:	int		value;
;1622:
;1623:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;1624:	if ( value ) {
;1625:		CG_RegisterItemVisuals( value );
;1626:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1627:	}
;1628:}
;1629:#endif
;1630:#endif // MISSIONPACK
;1631:
;1632:
;1633:/*
;1634:===================
;1635:CG_DrawReward
;1636:===================
;1637:*/
;1638:#ifndef NEOHUD
;1639:static void CG_DrawReward( void ) { 
;1640:	float	*color;
;1641:	int		i, count;
;1642:	float	x, y;
;1643:	char	buf[32];
;1644:
;1645:	if ( !cg_drawRewards.integer ) {
;1646:		return;
;1647:	}
;1648:
;1649:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
;1650:	if ( !color ) {
;1651:		if (cg.rewardStack > 0) {
;1652:			for(i = 0; i < cg.rewardStack; i++) {
;1653:				cg.rewardSound[i] = cg.rewardSound[i+1];
;1654:				cg.rewardShader[i] = cg.rewardShader[i+1];
;1655:				cg.rewardCount[i] = cg.rewardCount[i+1];
;1656:			}
;1657:			cg.rewardTime = cg.time;
;1658:			cg.rewardStack--;
;1659:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
;1660:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
;1661:		} else {
;1662:			return;
;1663:		}
;1664:	}
;1665:
;1666:	trap_R_SetColor( color );
;1667:
;1668:	/*
;1669:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;1670:
;1671:	if (count) {
;1672:		y = 4;
;1673:		x = 320 - count * ICON_SIZE;
;1674:		for ( i = 0 ; i < count ; i++ ) {
;1675:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;1676:			x += (ICON_SIZE*2);
;1677:		}
;1678:	}
;1679:
;1680:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;1681:	*/
;1682:
;1683:	if ( cg.rewardCount[0] >= 10 ) {
;1684:		y = 56; // FIXME: cgs.screenYmin + 56?
;1685:		x = 320 - ICON_SIZE/2;
;1686:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
;1687:		Com_sprintf( buf, sizeof( buf ), "%d", cg.rewardCount[0] );
;1688:		CG_DrawString( 320, y + ICON_SIZE, buf, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER );
;1689:	}
;1690:	else {
;1691:
;1692:		count = cg.rewardCount[0];
;1693:
;1694:		y = 56; // FIXME: cgs.screenYmin + 56?
;1695:		x = 320 - count * ICON_SIZE/2;
;1696:		for ( i = 0 ; i < count ; i++ ) {
;1697:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
;1698:			x += ICON_SIZE;
;1699:		}
;1700:	}
;1701:	trap_R_SetColor( NULL );
;1702:}
;1703:#endif
;1704:
;1705:
;1706:/*
;1707:===============================================================================
;1708:
;1709:LAGOMETER
;1710:
;1711:===============================================================================
;1712:*/
;1713:#ifndef NEOHUD
;1714:#define	LAG_SAMPLES		128
;1715:
;1716:
;1717:typedef struct {
;1718:	int		frameSamples[LAG_SAMPLES];
;1719:	int		frameCount;
;1720:	int		snapshotFlags[LAG_SAMPLES];
;1721:	int		snapshotSamples[LAG_SAMPLES];
;1722:	int		snapshotCount;
;1723:} lagometer_t;
;1724:
;1725:lagometer_t		lagometer;
;1726:#endif
;1727:
;1728:/*
;1729:==============
;1730:CG_AddLagometerFrameInfo
;1731:
;1732:Adds the current interpolate / extrapolate bar for this frame
;1733:==============
;1734:*/
;1735:#ifndef NEOHUD
;1736:void CG_AddLagometerFrameInfo( void ) {
;1737:	int			offset;
;1738:
;1739:	offset = cg.time - cg.latestSnapshotTime;
;1740:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
;1741:	lagometer.frameCount++;
;1742:}
;1743:#endif
;1744:
;1745:/*
;1746:==============
;1747:CG_AddLagometerSnapshotInfo
;1748:
;1749:Each time a snapshot is received, log its ping time and
;1750:the number of snapshots that were dropped before it.
;1751:
;1752:Pass NULL for a dropped packet.
;1753:==============
;1754:*/
;1755:#ifndef NEOHUD
;1756:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
;1757:	// dropped packet
;1758:	if ( !snap ) {
;1759:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
;1760:		lagometer.snapshotCount++;
;1761:		return;
;1762:	}
;1763:
;1764:	// add this snapshot's info
;1765:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
;1766:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
;1767:	lagometer.snapshotCount++;
;1768:}
;1769:#endif
;1770:
;1771:/*
;1772:==============
;1773:CG_DrawDisconnect
;1774:
;1775:Should we draw something differnet for long lag vs no packets?
;1776:==============
;1777:*/
;1778:#ifndef NEOHUD
;1779:static void CG_DrawDisconnect( void ) {
;1780:	float		x, y;
;1781:	int			cmdNum;
;1782:	usercmd_t	cmd;
;1783:	const char	*s;
;1784:
;1785:	// draw the phone jack if we are completely past our buffers
;1786:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
;1787:	trap_GetUserCmd( cmdNum, &cmd );
;1788:	if ( cmd.serverTime <= cg.snap->ps.commandTime
;1789:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
;1790:		return;
;1791:	}
;1792:
;1793:	// also add text in center of screen
;1794:	s = "Connection Interrupted";
;1795:	CG_DrawString( 320, cgs.screenYmin + 100, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_PROPORTIONAL | DS_CENTER );
;1796:
;1797:	// blink the icon
;1798:	if ( ( cg.time >> 9 ) & 1 ) {
;1799:		return;
;1800:	}
;1801:
;1802:	x = cgs.screenXmax + 1 - 48;
;1803:	y = cgs.screenYmax + 1 - 48;
;1804:
;1805:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader( "gfx/2d/net.tga" ) );
;1806:}
;1807:#endif
;1808:
;1809:#ifndef NEOHUD
;1810:#define	MAX_LAGOMETER_PING	900
;1811:#define	MAX_LAGOMETER_RANGE	300
;1812:
;1813:/*
;1814:==============
;1815:CG_DrawLagometer
;1816:==============
;1817:*/
;1818:static void CG_DrawLagometer( void ) {
;1819:	int		a, x, y, i;
;1820:	float	v;
;1821:	float	ax, ay, aw, ah, mid, range;
;1822:	int		color;
;1823:	float	vscale;
;1824:
;1825:	if ( !cg_lagometer.integer || cgs.localServer ) {
;1826:		CG_DrawDisconnect();
;1827:		return;
;1828:	}
;1829:
;1830:	//
;1831:	// draw the graph
;1832:	//
;1833:#ifdef MISSIONPACK
;1834:	x = cgs.screenXmax + 1 - 48;
;1835:	y = cgs.screenYmax + 1 - 144;
;1836:#else
;1837:	x = cgs.screenXmax + 1 - 48;
;1838:	y = cgs.screenYmax + 1 - 48;
;1839:#endif
;1840:
;1841:	trap_R_SetColor( NULL );
;1842:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
;1843:
;1844:	ax = x;
;1845:	ay = y;
;1846:	aw = 48;
;1847:	ah = 48;
;1848:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
;1849:
;1850:	color = -1;
;1851:	range = ah / 3;
;1852:	mid = ay + range;
;1853:
;1854:	vscale = range / MAX_LAGOMETER_RANGE;
;1855:
;1856:	// draw the frame interpoalte / extrapolate graph
;1857:	for ( a = 0 ; a < aw ; a++ ) {
;1858:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
;1859:		v = lagometer.frameSamples[i];
;1860:		v *= vscale;
;1861:		if ( v > 0 ) {
;1862:			if ( color != 1 ) {
;1863:				color = 1;
;1864:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
;1865:			}
;1866:			if ( v > range ) {
;1867:				v = range;
;1868:			}
;1869:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
;1870:		} else if ( v < 0 ) {
;1871:			if ( color != 2 ) {
;1872:				color = 2;
;1873:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
;1874:			}
;1875:			v = -v;
;1876:			if ( v > range ) {
;1877:				v = range;
;1878:			}
;1879:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
;1880:		}
;1881:	}
;1882:
;1883:	// draw the snapshot latency / drop graph
;1884:	range = ah / 2;
;1885:	vscale = range / MAX_LAGOMETER_PING;
;1886:
;1887:	for ( a = 0 ; a < aw ; a++ ) {
;1888:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
;1889:		v = lagometer.snapshotSamples[i];
;1890:		if ( v > 0 ) {
;1891:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
;1892:				if ( color != 5 ) {
;1893:					color = 5;	// YELLOW for rate delay
;1894:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
;1895:				}
;1896:			} else {
;1897:				if ( color != 3 ) {
;1898:					color = 3;
;1899:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
;1900:				}
;1901:			}
;1902:			v = v * vscale;
;1903:			if ( v > range ) {
;1904:				v = range;
;1905:			}
;1906:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
;1907:		} else if ( v < 0 ) {
;1908:			if ( color != 4 ) {
;1909:				color = 4;		// RED for dropped snapshots
;1910:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
;1911:			}
;1912:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
;1913:		}
;1914:	}
;1915:
;1916:	trap_R_SetColor( NULL );
;1917:
;1918:	if ( cg_nopredict.integer || cgs.synchronousClients ) {
;1919:		CG_DrawString( cgs.screenXmax-1, y, "snc", colorWhite, 5, 10, 0, DS_PROPORTIONAL | DS_RIGHT );
;1920:	}
;1921:
;1922:	if ( !cg.demoPlayback ) {
;1923:		CG_DrawString( x+1, y, va( "%ims", cg.meanPing ), colorWhite, 5, 10, 0, DS_PROPORTIONAL );
;1924:	}
;1925:
;1926:	CG_DrawDisconnect();
;1927:}
;1928:#endif
;1929:
;1930:
;1931:
;1932:/*
;1933:===============================================================================
;1934:
;1935:CENTER PRINTING
;1936:
;1937:===============================================================================
;1938:*/
;1939:
;1940:
;1941:/*
;1942:==============
;1943:CG_CenterPrint
;1944:
;1945:Called for important messages that should stay in the center of the screen
;1946:for a few moments
;1947:==============
;1948:*/
;1949:#ifndef NEOHUD
;1950:void CG_CenterPrint( const char *str, int y, int charWidth ) {
;1951:	char	*s;
;1952:
;1953:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
;1954:
;1955:	cg.centerPrintTime = cg.time;
;1956:	cg.centerPrintY = y;
;1957:	cg.centerPrintCharWidth = charWidth;
;1958:
;1959:	// count the number of lines for centering
;1960:	cg.centerPrintLines = 1;
;1961:	s = cg.centerPrint;
;1962:	while( *s ) {
;1963:		if (*s == '\n')
;1964:			cg.centerPrintLines++;
;1965:		s++;
;1966:	}
;1967:}
;1968:#endif
;1969:
;1970:
;1971:/*
;1972:===================
;1973:CG_DrawCenterString
;1974:===================
;1975:*/
;1976:#ifndef NEOHUD
;1977:static
;1978:#endif
;1979:void CG_DrawCenterString( void ) {
line 1988
;1980:	char	*start;
;1981:	int		l;
;1982:	int		y;
;1983:#ifdef MISSIONPACK // bk010221 - unused else
;1984:	int h;
;1985:#endif
;1986:	float	*fadeColor;
;1987:
;1988:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+116488
INDIRI4
CNSTI4 0
NEI4 $209
line 1989
;1989:		return;
ADDRGP4 $208
JUMPV
LABELV $209
line 1992
;1990:	}
;1991:#ifdef NEOHUD
;1992:	fadeColor = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value, cg.centerPrintColor);
ADDRGP4 cg+116488
INDIRI4
ARGI4
ADDRGP4 cg_centertime+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
ARGI4
ADDRGP4 cg+117528
ARGP4
ADDRLP4 16
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 1996
;1993:#else
;1994:	fadeColor = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
;1995:#endif
;1996:	if ( !fadeColor ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $215
line 1997
;1997:		return;
ADDRGP4 $208
JUMPV
LABELV $215
line 2000
;1998:	}
;1999:
;2000:	trap_R_SetColor( fadeColor );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2002
;2001:
;2002:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+116500
ASGNP4
line 2004
;2003:
;2004:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+116496
INDIRI4
ADDRGP4 cg+117524
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $221
JUMPV
LABELV $220
line 2006
;2005:
;2006:	while ( 1 ) {
line 2009
;2007:		char linebuffer[1024];
;2008:
;2009:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $223
line 2010
;2010:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1044
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $229
ADDRLP4 1044
INDIRI4
CNSTI4 10
NEI4 $227
LABELV $229
line 2011
;2011:				break;
ADDRGP4 $225
JUMPV
LABELV $227
line 2013
;2012:			}
;2013:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 20
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2014
;2014:		}
LABELV $224
line 2009
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $223
LABELV $225
line 2015
;2015:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 20
ADDP4
CNSTI1 0
ASGNI1
line 2024
;2016:
;2017:#ifdef MISSIONPACK
;2018:		w = CG_Text_Width(linebuffer, 0.5, 0);
;2019:		h = CG_Text_Height(linebuffer, 0.5, 0);
;2020:		x = (SCREEN_WIDTH - w) / 2;
;2021:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2022:		y += h + 6;
;2023:#else
;2024:		CG_DrawString( 320, y, linebuffer, fadeColor, cg.centerPrintCharWidth, cg.centerPrintCharWidth * 1.5, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
CNSTF4 1134559232
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 cg+116492
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cg+116492
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2026
;2025:
;2026:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 cg+116492
INDIRI4
CVIF4 4
CNSTF4 1069547520
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $234
JUMPV
LABELV $233
line 2028
;2027:#endif
;2028:		while ( *start && ( *start != '\n' ) ) {
line 2029
;2029:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2030
;2030:		}
LABELV $234
line 2028
ADDRLP4 1044
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $236
ADDRLP4 1044
INDIRI4
CNSTI4 10
NEI4 $233
LABELV $236
line 2031
;2031:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $237
line 2032
;2032:			break;
ADDRGP4 $222
JUMPV
LABELV $237
line 2034
;2033:		}
;2034:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2035
;2035:	}
LABELV $221
line 2006
ADDRGP4 $220
JUMPV
LABELV $222
line 2037
;2036:
;2037:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2038
;2038:}
LABELV $208
endproc CG_DrawCenterString 1052 32
export CG_ScanForCrosshairEntity
proc CG_ScanForCrosshairEntity 92 28
line 2123
;2039:
;2040:
;2041:
;2042:/*
;2043:================================================================================
;2044:
;2045:CROSSHAIR
;2046:
;2047:================================================================================
;2048:*/
;2049:
;2050:
;2051:/*
;2052:=================
;2053:CG_DrawCrosshair
;2054:=================
;2055:*/
;2056:#ifndef NEOHUD
;2057:static void CG_DrawCrosshair( void ) {
;2058:	float		w, h;
;2059:	qhandle_t	hShader;
;2060:	float		f;
;2061:	float		x, y;
;2062:	int			ca;
;2063:
;2064:	if ( !cg_drawCrosshair.integer ) {
;2065:		return;
;2066:	}
;2067:
;2068:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
;2069:		return;
;2070:	}
;2071:
;2072:	if ( cg.renderingThirdPerson ) {
;2073:		return;
;2074:	}
;2075:
;2076:	// set color based on health
;2077:	if ( cg_crosshairHealth.integer ) {
;2078:		vec4_t		hcolor;
;2079:
;2080:		CG_ColorForHealth( hcolor );
;2081:		trap_R_SetColor( hcolor );
;2082:	} else {
;2083:		trap_R_SetColor( NULL );
;2084:	}
;2085:
;2086:	w = h = cg_crosshairSize.value;
;2087:
;2088:	// pulse the size of the crosshair when picking up items
;2089:	f = cg.time - cg.itemPickupBlendTime;
;2090:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
;2091:		f /= ITEM_BLOB_TIME;
;2092:		w *= ( 1 + f );
;2093:		h *= ( 1 + f );
;2094:	}
;2095:
;2096:	x = cg_crosshairX.integer;
;2097:	y = cg_crosshairY.integer;
;2098:
;2099:	CG_AdjustFrom640( &x, &y, &w, &h );
;2100:
;2101:	ca = cg_drawCrosshair.integer;
;2102:	if ( ca < 0 ) {
;2103:		ca = 0;
;2104:	}
;2105:
;2106:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
;2107:
;2108:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w) - cgs.screenXBias,
;2109:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h) - cgs.screenYBias,
;2110:		w, h, 0, 0, 1, 1, hShader );
;2111:}
;2112:#endif
;2113:
;2114:
;2115:/*
;2116:=================
;2117:CG_ScanForCrosshairEntity
;2118:=================
;2119:*/
;2120:#ifndef NEOHUD
;2121:static
;2122:#endif
;2123:void CG_ScanForCrosshairEntity( void ) {
line 2128
;2124:	trace_t		trace;
;2125:	vec3_t		start, end;
;2126:	int			content;
;2127:
;2128:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 2129
;2129:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 2131
;2130:
;2131:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 84
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2133
;2132:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;2133:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $255
line 2134
;2134:		return;
ADDRGP4 $239
JUMPV
LABELV $255
line 2138
;2135:	}
;2136:
;2137:	// if the player is in fog, don't show it
;2138:	content = CG_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 88
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 88
INDIRI4
ASGNI4
line 2139
;2139:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $259
line 2140
;2140:		return;
ADDRGP4 $239
JUMPV
LABELV $259
line 2144
;2141:	}
;2142:
;2143:	// if the player is invisible, don't show it
;2144:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $261
line 2145
;2145:		return;
ADDRGP4 $239
JUMPV
LABELV $261
line 2149
;2146:	}
;2147:
;2148:	// update the fade timer
;2149:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+117552
ADDRLP4 0+52
INDIRI4
ASGNI4
line 2150
;2150:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+117556
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2151
;2151:}
LABELV $239
endproc CG_ScanForCrosshairEntity 92 28
export CG_DrawScoreboard
proc CG_DrawScoreboard 4 0
line 2292
;2152:
;2153:
;2154:/*
;2155:=====================
;2156:CG_DrawCrosshairNames
;2157:=====================
;2158:*/
;2159:#ifndef NEOHUD
;2160:static void CG_DrawCrosshairNames( void ) {
;2161:	float		*color;
;2162:	const char	*name;
;2163:
;2164:	if ( !cg_drawCrosshair.integer ) {
;2165:		return;
;2166:	}
;2167:	if ( !cg_drawCrosshairNames.integer ) {
;2168:		return;
;2169:	}
;2170:	if ( cg.renderingThirdPerson ) {
;2171:		return;
;2172:	}
;2173:
;2174:	// scan the known entities to see if the crosshair is sighted on one
;2175:	CG_ScanForCrosshairEntity();
;2176:
;2177:	// draw the name of the player being looked at
;2178:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
;2179:	if ( !color ) {
;2180:		trap_R_SetColor( NULL );
;2181:		return;
;2182:	}
;2183:
;2184:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
;2185:#ifdef MISSIONPACK
;2186:	color[3] *= 0.5f;
;2187:	w = CG_Text_Width(name, 0.3f, 0);
;2188:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;2189:#else
;2190:	color[3] *= 0.5f;
;2191:	CG_DrawString( 320, 174, name, color, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_CENTER | DS_PROPORTIONAL );
;2192:#endif
;2193:	trap_R_SetColor( NULL );
;2194:}
;2195:#endif
;2196:
;2197://==============================================================================
;2198:
;2199:/*
;2200:=================
;2201:CG_DrawSpectator
;2202:=================
;2203:*/
;2204:#ifndef NEOHUD
;2205:static void CG_DrawSpectator( void ) {
;2206:	CG_DrawString( 320, cgs.screenYmax - 40 + 1, "SPECTATOR", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;2207:	if ( cgs.gametype == GT_TOURNAMENT ) {
;2208:		CG_DrawString( 320, cgs.screenYmax - 20 + 1, "waiting to play", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;2209:	} else if ( cgs.gametype >= GT_TEAM ) {
;2210:		CG_DrawString( 320, cgs.screenYmax - 20 + 1, "press ESC and use the JOIN menu to play", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;2211:	}
;2212:}
;2213:#endif
;2214:
;2215:/*
;2216:=================
;2217:CG_DrawVote
;2218:=================
;2219:*/
;2220:#ifndef NEOHUD
;2221:static void CG_DrawVote( void ) {
;2222:	char	*s;
;2223:	int		sec;
;2224:
;2225:	if ( !cgs.voteTime ) {
;2226:		return;
;2227:	}
;2228:
;2229:	// play a talk beep whenever it is modified
;2230:	if ( cgs.voteModified ) {
;2231:		cgs.voteModified = qfalse;
;2232:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;2233:	}
;2234:
;2235:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
;2236:	if ( sec < 0 ) {
;2237:		sec = 0;
;2238:	}
;2239:#ifdef MISSIONPACK
;2240:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;2241:	CG_DrawString( cgs.screenXmin - 0, 58, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DF_PROPORTIONAL );
;2242:	s = "or press ESC then click Vote";
;2243:	CG_DrawString( cgs.screenXmin - 0, 58 + SMALLCHAR_HEIGHT + 2, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DF_PROPORTIONAL );
;2244:#else
;2245:	s = va( "VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
;2246:	CG_DrawString( cgs.screenXmin - 0, 58, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL ); // DS_SHADOW?
;2247:#endif
;2248:}
;2249:#endif
;2250:
;2251:/*
;2252:=================
;2253:CG_DrawTeamVote
;2254:=================
;2255:*/
;2256:#ifndef NEOHUD
;2257:static void CG_DrawTeamVote(void) {
;2258:	char	*s;
;2259:	int		sec, cs_offset;
;2260:
;2261:	if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED )
;2262:		cs_offset = 0;
;2263:	else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE )
;2264:		cs_offset = 1;
;2265:	else
;2266:		return;
;2267:
;2268:	if ( !cgs.teamVoteTime[cs_offset] ) {
;2269:		return;
;2270:	}
;2271:
;2272:	// play a talk beep whenever it is modified
;2273:	if ( cgs.teamVoteModified[cs_offset] ) {
;2274:		cgs.teamVoteModified[cs_offset] = qfalse;
;2275:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;2276:	}
;2277:
;2278:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
;2279:	if ( sec < 0 ) {
;2280:		sec = 0;
;2281:	}
;2282:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
;2283:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;2284:
;2285:	CG_DrawString( cgs.screenXmin - 0, 90, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL ); // DF_SHADOW?
;2286:}
;2287:#endif
;2288:
;2289:#ifndef NEOHUD
;2290:static
;2291:#endif
;2292:qboolean CG_DrawScoreboard( void ) {
line 2357
;2293:#ifdef MISSIONPACK
;2294:	static qboolean firstTime = qtrue;
;2295:	float fade, *fadeColor;
;2296:
;2297:	if (menuScoreboard) {
;2298:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;2299:	}
;2300:	if (cg_paused.integer) {
;2301:		cg.deferredPlayerLoading = 0;
;2302:		firstTime = qtrue;
;2303:		return qfalse;
;2304:	}
;2305:
;2306:	// should never happen in Team Arena
;2307:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2308:		cg.deferredPlayerLoading = 0;
;2309:		firstTime = qtrue;
;2310:		return qfalse;
;2311:	}
;2312:
;2313:	// don't draw scoreboard during death while warmup up
;2314:	if ( cg.warmup && !cg.showScores ) {
;2315:		return qfalse;
;2316:	}
;2317:
;2318:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2319:		fade = 1.0;
;2320:		fadeColor = colorWhite;
;2321:	} else {
;2322:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;2323:		if ( !fadeColor ) {
;2324:			// next time scoreboard comes up, don't print killer
;2325:			cg.deferredPlayerLoading = 0;
;2326:			cg.killerName[0] = 0;
;2327:			firstTime = qtrue;
;2328:			return qfalse;
;2329:		}
;2330:		fade = *fadeColor;
;2331:	}
;2332:
;2333:
;2334:	if (menuScoreboard == NULL) {
;2335:		if ( cgs.gametype >= GT_TEAM ) {
;2336:			menuScoreboard = Menus_FindByName("teamscore_menu");
;2337:		} else {
;2338:			menuScoreboard = Menus_FindByName("score_menu");
;2339:		}
;2340:	}
;2341:
;2342:	if (menuScoreboard) {
;2343:		if (firstTime) {
;2344:			CG_SetScoreSelection(menuScoreboard);
;2345:			firstTime = qfalse;
;2346:		}
;2347:		Menu_Paint(menuScoreboard, qtrue);
;2348:	}
;2349:
;2350:	// load any models that have been deferred
;2351:	if ( ++cg.deferredPlayerLoading > 10 ) {
;2352:		CG_LoadDeferredPlayers();
;2353:	}
;2354:
;2355:	return qtrue;
;2356:#else
;2357:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $269
endproc CG_DrawScoreboard 4 0
export CG_DrawIntermission
proc CG_DrawIntermission 0 0
line 2370
;2358:#endif
;2359:}
;2360:
;2361:
;2362:/*
;2363:=================
;2364:CG_DrawIntermission
;2365:=================
;2366:*/
;2367:#ifndef NEOHUD
;2368:static
;2369:#endif
;2370:void CG_DrawIntermission( void ) {
line 2377
;2371:#ifdef MISSIONPACK
;2372:	//if (cg_singlePlayer.integer) {
;2373:	//	CG_DrawCenterString();
;2374:	//	return;
;2375:	//}
;2376:#else
;2377:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
NEI4 $271
line 2378
;2378:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2379
;2379:		return;
ADDRGP4 $270
JUMPV
LABELV $271
line 2382
;2380:	}
;2381:#endif
;2382:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2384
;2383:#ifdef NEOHUD
;2384:	CG_DrawScoreboard();
ADDRGP4 CG_DrawScoreboard
CALLI4
pop
line 2388
;2385:#else
;2386:	cg.scoreBoardShowing = CG_DrawScoreboard();
;2387:#endif
;2388:}
LABELV $270
endproc CG_DrawIntermission 0 0
proc CG_DrawTourneyScoreboard 0 0
line 2746
;2389:
;2390:
;2391:/*
;2392:=================
;2393:CG_DrawFollow
;2394:=================
;2395:*/
;2396:#ifndef NEOHUD
;2397:static qboolean CG_DrawFollow( void ) {
;2398:
;2399:	const char	*name;
;2400:
;2401:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
;2402:		return qfalse;
;2403:	}
;2404:
;2405:	CG_DrawString( 320, cgs.screenYmin + 24, "following", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_CENTER | DS_SHADOW );
;2406:
;2407:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
;2408:
;2409:	CG_DrawString( 320, cgs.screenYmin + 40, name, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_FORCE_COLOR | DS_SHADOW | DS_CENTER );
;2410:
;2411:	return qtrue;
;2412:}
;2413:#endif
;2414:
;2415:
;2416:/*
;2417:=================
;2418:CG_DrawAmmoWarning
;2419:=================
;2420:*/
;2421:#ifndef NEOHUD
;2422:static void CG_DrawAmmoWarning( void ) {
;2423:	const char	*s;
;2424:
;2425:	if ( cg_drawAmmoWarning.integer == 0 ) {
;2426:		return;
;2427:	}
;2428:
;2429:	if ( !cg.lowAmmoWarning ) {
;2430:		return;
;2431:	}
;2432:
;2433:	if ( cg.lowAmmoWarning == 2 ) {
;2434:		s = "OUT OF AMMO";
;2435:	} else {
;2436:		s = "LOW AMMO WARNING";
;2437:	}
;2438:
;2439:	CG_DrawString( 320, 64, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_PROPORTIONAL | DS_CENTER | DS_SHADOW );
;2440:}
;2441:#endif
;2442:
;2443:
;2444:#ifdef MISSIONPACK
;2445:/*
;2446:=================
;2447:CG_DrawProxWarning
;2448:=================
;2449:*/
;2450:static void CG_DrawProxWarning( void ) {
;2451:	char s [32];
;2452:	static int proxTime;
;2453:	static int proxCounter;
;2454:	static int proxTick;
;2455:
;2456:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;2457:		proxTime = 0;
;2458:		return;
;2459:	}
;2460:
;2461:	if ( proxTime == 0 ) {
;2462:		proxTime = cg.time + 5000;
;2463:		proxCounter = 5;
;2464:		proxTick = 0;
;2465:	}
;2466:
;2467:	if (cg.time > proxTime) {
;2468:		proxTick = proxCounter--;
;2469:		proxTime = cg.time + 1000;
;2470:	}
;2471:
;2472:	if (proxTick != 0) {
;2473:		Com_sprintf( s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick );
;2474:	} else {
;2475:		Com_sprintf( s, sizeof(s), "YOU HAVE BEEN MINED" );
;2476:	}
;2477:
;2478:	CG_DrawString( 320, 64 + 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)], BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DF_SHADOW | DF_FORCE_COLOR | DF_CENTER );
;2479:#endif
;2480:
;2481:
;2482:/*
;2483:=================
;2484:CG_DrawWarmup
;2485:=================
;2486:*/
;2487:#ifndef NEOHUD
;2488:static void CG_DrawWarmup( void ) {
;2489:	int			w;
;2490:	int			i;
;2491:#ifdef MISSIONPACK
;2492:	float scale;
;2493:#endif
;2494:	clientInfo_t *ci1, *ci2;
;2495:	int			cw;
;2496:	const char	*s;
;2497:
;2498:	if ( !cg.warmup ) {
;2499:		return;
;2500:	}
;2501:
;2502:	if ( cg.warmup < 0 ) {
;2503:		CG_DrawString( 320,24, "Waiting for players", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0,
;2504:			DS_PROPORTIONAL | DS_CENTER | DS_SHADOW );
;2505:		return;
;2506:	}
;2507:
;2508:	if ( cgs.gametype == GT_TOURNAMENT ) {
;2509:		// find the two active players
;2510:		ci1 = NULL;
;2511:		ci2 = NULL;
;2512:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
;2513:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
;2514:				if ( !ci1 ) {
;2515:					ci1 = &cgs.clientinfo[i];
;2516:				} else {
;2517:					ci2 = &cgs.clientinfo[i];
;2518:				}
;2519:			}
;2520:		}
;2521:
;2522:		if ( ci1 && ci2 ) {
;2523:			s = va( "%s vs %s", ci1->name, ci2->name );
;2524:#ifdef MISSIONPACK
;2525:			w = CG_Text_Width(s, 0.6f, 0);
;2526:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2527:#else
;2528:			w = CG_DrawStrlen( s );
;2529:			if ( w > 640 / GIANT_WIDTH ) {
;2530:				cw = 640 / w;
;2531:			} else {
;2532:				cw = GIANT_WIDTH;
;2533:			}
;2534:			CG_DrawString( 320, 20, s, colorWhite, cw, cw*1.5, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;2535:#endif
;2536:		}
;2537:	} else {
;2538:		if ( cgs.gametype == GT_FFA ) {
;2539:			s = "Free For All";
;2540:		} else if ( cgs.gametype == GT_TEAM ) {
;2541:			s = "Team Deathmatch";
;2542:		} else if ( cgs.gametype == GT_CTF ) {
;2543:			s = "Capture the Flag";
;2544:#ifdef MISSIONPACK
;2545:		} else if ( cgs.gametype == GT_1FCTF ) {
;2546:			s = "One Flag CTF";
;2547:		} else if ( cgs.gametype == GT_OBELISK ) {
;2548:			s = "Overload";
;2549:		} else if ( cgs.gametype == GT_HARVESTER ) {
;2550:			s = "Harvester";
;2551:#endif
;2552:		} else {
;2553:			s = "";
;2554:		}
;2555:#ifdef MISSIONPACK
;2556:		w = CG_Text_Width(s, 0.6f, 0);
;2557:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2558:#else
;2559:		w = CG_DrawStrlen( s );
;2560:		if ( w > 640 / GIANT_WIDTH ) {
;2561:			cw = 640 / w;
;2562:		} else {
;2563:			cw = GIANT_WIDTH;
;2564:		}
;2565:		CG_DrawString( 320, 25, s, colorWhite, cw, cw*1.1f, 0, DS_PROPORTIONAL | DS_SHADOW | DS_CENTER );
;2566:#endif
;2567:	}
;2568:
;2569:	if ( cg.warmupCount <= 0 )
;2570:		return;
;2571:
;2572:	s = va( "Starts in: %i", cg.warmupCount );
;2573:
;2574:	switch ( cg.warmupCount ) {
;2575:	case 1:
;2576:		cw = 28;
;2577:#ifdef MISSIONPACK
;2578:		scale = 0.54f;
;2579:#endif
;2580:		break;
;2581:	case 2:
;2582:		cw = 24;
;2583:#ifdef MISSIONPACK
;2584:		scale = 0.51f;
;2585:#endif
;2586:		break;
;2587:	case 3:
;2588:		cw = 20;
;2589:#ifdef MISSIONPACK
;2590:		scale = 0.48f;
;2591:#endif
;2592:		break;
;2593:	default:
;2594:		cw = 16;
;2595:#ifdef MISSIONPACK
;2596:		scale = 0.45f;
;2597:#endif
;2598:		break;
;2599:	}
;2600:
;2601:#ifdef MISSIONPACK
;2602:	w = CG_Text_Width(s, scale, 0);
;2603:	CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2604:#else
;2605:	CG_DrawString( 320, 70, s, colorWhite, cw, cw * 1.5, 0, DS_CENTER | DS_SHADOW | DS_PROPORTIONAL );
;2606:#endif
;2607:}
;2608:#endif
;2609:
;2610:
;2611://==================================================================================
;2612:#ifdef MISSIONPACK
;2613:/* 
;2614:=================
;2615:CG_DrawTimedMenus
;2616:=================
;2617:*/
;2618:void CG_DrawTimedMenus( void ) {
;2619:	if (cg.voiceTime) {
;2620:		int t = cg.time - cg.voiceTime;
;2621:		if ( t > 2500 ) {
;2622:			Menus_CloseByName("voiceMenu");
;2623:			trap_Cvar_Set("cl_conXOffset", "0");
;2624:			cg.voiceTime = 0;
;2625:		}
;2626:	}
;2627:}
;2628:#endif
;2629:
;2630:
;2631:/*
;2632:=================
;2633:CG_Draw2D
;2634:=================
;2635:*/
;2636:#ifndef NEOHUD
;2637:static void CG_Draw2D( stereoFrame_t stereoFrame )
;2638:{
;2639:#if defined MISSIONPACK || defined NEOHUD
;2640:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;2641:		CG_CheckOrderPending();
;2642:	}
;2643:#endif
;2644:	// if we are taking a levelshot for the menu, don't draw anything
;2645:	if ( cg.levelShot ) {
;2646:		return;
;2647:	}
;2648:
;2649:	if ( cg_draw2D.integer == 0 ) {
;2650:		return;
;2651:	}
;2652:
;2653:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
;2654:		CG_DrawIntermission();
;2655:		return;
;2656:	}
;2657:
;2658:/*
;2659:	if (cg.cameraMode) {
;2660:		return;
;2661:	}
;2662:*/
;2663:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
;2664:		CG_DrawSpectator();
;2665:		CG_DrawCrosshair();
;2666:		CG_DrawCrosshairNames();
;2667:	} else {
;2668:		// don't draw any status if dead or the scoreboard is being explicitly shown
;2669:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
;2670:
;2671:#ifdef MISSIONPACK
;2672:			if ( cg_drawStatus.integer ) {
;2673:				Menu_PaintAll();
;2674:				CG_DrawTimedMenus();
;2675:			}
;2676:#else
;2677:			CG_DrawStatusBar();
;2678:#endif
;2679:      
;2680:			CG_DrawAmmoWarning();
;2681:
;2682:#ifdef MISSIONPACK
;2683:			CG_DrawProxWarning();
;2684:#endif      
;2685:			CG_DrawCrosshair();
;2686:			CG_DrawCrosshairNames();
;2687:			CG_DrawWeaponSelect();
;2688:
;2689:#ifndef MISSIONPACK
;2690:			CG_DrawHoldableItem();
;2691:#else
;2692:			//CG_DrawPersistantPowerup();
;2693:#endif
;2694:			CG_DrawReward();
;2695:		}
;2696:    
;2697:		if ( cgs.gametype >= GT_TEAM ) {
;2698:#ifndef MISSIONPACK
;2699:			CG_DrawTeamInfo();
;2700:#endif
;2701:		}
;2702:	}
;2703:
;2704:	CG_DrawVote();
;2705:	CG_DrawTeamVote();
;2706:
;2707:	CG_DrawLagometer();
;2708:
;2709:#ifdef MISSIONPACK
;2710:	if (!cg_paused.integer) {
;2711:		CG_DrawUpperRight(stereoFrame);
;2712:	}
;2713:#else
;2714:	CG_DrawUpperRight(stereoFrame);
;2715:#endif
;2716:
;2717:#ifndef MISSIONPACK
;2718:	CG_DrawLowerRight();
;2719:	CG_DrawLowerLeft();
;2720:#endif
;2721:
;2722:	if ( !CG_DrawFollow() ) {
;2723:		CG_DrawWarmup();
;2724:	}
;2725:
;2726:	// don't draw center string if scoreboard is up
;2727:	cg.scoreBoardShowing = CG_DrawScoreboard();
;2728:	if ( !cg.scoreBoardShowing ) {
;2729:		CG_DrawCenterString();
;2730:	}
;2731:
;2732:	if ( cgs.score_catched ) {
;2733:		float x, y, w, h;
;2734:		trap_R_SetColor( NULL );
;2735:		x = cgs.cursorX - 12;
;2736:		y = cgs.cursorY - 12;
;2737:		w = 24;
;2738:		h = 24;
;2739:		CG_AdjustFrom640( &x, &y, &w, &h );
;2740:		trap_R_DrawStretchPic( x, y, w, h, 0, 0, 1, 1, cgs.media.cursor );
;2741:	}
;2742:}
;2743:#endif
;2744:
;2745:
;2746:static void CG_DrawTourneyScoreboard( void ) {
line 2749
;2747:#ifdef MISSIONPACK
;2748:#else
;2749:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 2751
;2750:#endif
;2751:}
LABELV $276
endproc CG_DrawTourneyScoreboard 0 0
proc CG_WarmupEvents 1220 16
line 2775
;2752:
;2753:#ifndef NEOHUD
;2754:static void CG_CalculatePing( void ) {
;2755:	int count, i, v;
;2756:
;2757:	cg.meanPing = 0;
;2758:
;2759:	for ( i = 0, count = 0; i < LAG_SAMPLES; i++ ) {
;2760:
;2761:		v = lagometer.snapshotSamples[i];
;2762:		if ( v >= 0 ) {
;2763:			cg.meanPing += v;
;2764:			count++;
;2765:		}
;2766:
;2767:	}
;2768:
;2769:	if ( count ) {
;2770:		cg.meanPing /= count;
;2771:	}
;2772:}
;2773:#endif
;2774:
;2775:static void CG_WarmupEvents( void ) {
line 2778
;2776:	int	count;
;2777:
;2778:	if ( !cg.warmup )
ADDRGP4 cg+117848
INDIRI4
CNSTI4 0
NEI4 $278
line 2779
;2779:		return;
ADDRGP4 $277
JUMPV
LABELV $278
line 2781
;2780:
;2781:	if ( cg.warmup < 0 ) {
ADDRGP4 cg+117848
INDIRI4
CNSTI4 0
GEI4 $281
line 2782
;2782:		cg.warmupCount = -1;
ADDRGP4 cg+117852
CNSTI4 -1
ASGNI4
line 2783
;2783:		return;
ADDRGP4 $277
JUMPV
LABELV $281
line 2786
;2784:	}
;2785:
;2786:	if ( cg.warmup < cg.time ) {
ADDRGP4 cg+117848
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $285
line 2787
;2787:		cg.warmup = 0;
ADDRGP4 cg+117848
CNSTI4 0
ASGNI4
line 2788
;2788:		count = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2789
;2789:	} else {
ADDRGP4 $286
JUMPV
LABELV $285
line 2790
;2790:		count = ( cg.warmup - cg.time + 999 ) / 1000;
ADDRLP4 0
ADDRGP4 cg+117848
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 999
ADDI4
CNSTI4 1000
DIVI4
ASGNI4
line 2791
;2791:	}
LABELV $286
line 2793
;2792:
;2793:	if ( cg.warmupCount == -2 && cg.demoPlayback ) {
ADDRGP4 cg+117852
INDIRI4
CNSTI4 -2
NEI4 $292
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
EQI4 $292
line 2794
;2794:		cg.warmupCount = 0;
ADDRGP4 cg+117852
CNSTI4 0
ASGNI4
line 2795
;2795:	}
LABELV $292
line 2797
;2796:
;2797:	if ( cg.warmupCount == count ) {
ADDRGP4 cg+117852
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $297
line 2798
;2798:		return;
ADDRGP4 $277
JUMPV
LABELV $297
line 2801
;2799:	}
;2800:
;2801:	cg.warmupCount = count;
ADDRGP4 cg+117852
ADDRLP4 0
INDIRI4
ASGNI4
line 2802
;2802:	cg.timelimitWarnings = 0;
ADDRGP4 cg+107616
CNSTI4 0
ASGNI4
line 2804
;2803:
;2804:	switch ( count ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $303
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $303
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $327
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $327
address $304
address $318
address $321
address $324
code
LABELV $304
line 2806
;2805:		case 0:
;2806:			if ( cg.warmupFightSound <= cg.time ) {
ADDRGP4 cg+117856
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $305
line 2807
;2807:				trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148752+948
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2808
;2808:				cg.warmupFightSound = cg.time + 750;
ADDRGP4 cg+117856
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 2809
;2809:			}
LABELV $305
line 2811
;2810:#ifdef NEOHUD
;2811:			{
line 2813
;2812:			item_t itm;
;2813:			itm = dyn_itemArray[WarmFightMsg_idx];
ADDRLP4 8
ADDRGP4 WarmFightMsg_idx
INDIRI4
CNSTI4 1212
MULI4
ADDRGP4 dyn_itemArray
ADDP4
INDIRB
ASGNB 1212
line 2814
;2814:			CG_CenterPrint( "FIGHT!", itm.rect.y, itm.fontsize.w, itm.forecolor.color );
ADDRGP4 $313
ARGP4
ADDRLP4 8+1088+4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8+1120
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8+1152
ARGP4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 2815
;2815:			}
line 2819
;2816:#else
;2817:			CG_CenterPrint( "FIGHT!", 120, GIANTCHAR_WIDTH*2 );
;2818:#endif			
;2819:			break;
ADDRGP4 $303
JUMPV
LABELV $318
line 2822
;2820:
;2821:		case 1:
;2822:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148752+944
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2823
;2823:			break;
ADDRGP4 $303
JUMPV
LABELV $321
line 2826
;2824:
;2825:		case 2:
;2826:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148752+940
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2827
;2827:			break;
ADDRGP4 $303
JUMPV
LABELV $324
line 2830
;2828:
;2829:		case 3:
;2830:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148752+936
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2831
;2831:			break;
line 2834
;2832:
;2833:		default:
;2834:			break;
LABELV $303
line 2836
;2835:	}
;2836:}
LABELV $277
endproc CG_WarmupEvents 1220 16
export CG_WarmupEvent
proc CG_WarmupEvent 0 0
line 2841
;2837:
;2838:
;2839:
;2840:// will be called on warmup end and when client changed
;2841:void CG_WarmupEvent( void ) {
line 2843
;2842:
;2843:	cg.attackerTime = 0;
ADDRGP4 cg+117604
CNSTI4 0
ASGNI4
line 2844
;2844:	cg.attackerName[0] = '\0';
ADDRGP4 cg+117568
CNSTI1 0
ASGNI1
line 2846
;2845:
;2846:	cg.itemPickupTime = 0;
ADDRGP4 cg+117868
CNSTI4 0
ASGNI4
line 2847
;2847:	cg.itemPickupBlendTime = 0;
ADDRGP4 cg+117872
CNSTI4 0
ASGNI4
line 2848
;2848:	cg.itemPickupCount = 0;
ADDRGP4 cg+117864
CNSTI4 0
ASGNI4
line 2850
;2849:
;2850:	cg.killerTime = 0;
ADDRGP4 cg+115432
CNSTI4 0
ASGNI4
line 2851
;2851:	cg.killerName[0] = '\0';
ADDRGP4 cg+115368
CNSTI1 0
ASGNI1
line 2853
;2852:	
;2853:	cg.damageTime = 0;
ADDRGP4 cg+117888
CNSTI4 0
ASGNI4
line 2855
;2854:
;2855:	cg.rewardStack = 0;
ADDRGP4 cg+117612
CNSTI4 0
ASGNI4
line 2856
;2856:	cg.rewardTime = 0;
ADDRGP4 cg+117616
CNSTI4 0
ASGNI4
line 2858
;2857:	
;2858:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+117876
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2860
;2859:
;2860:	cg.lowAmmoWarning = 0;
ADDRGP4 cg+117544
CNSTI4 0
ASGNI4
line 2862
;2861:
;2862:	cg.followTime = 0;
ADDRGP4 cg+149108
CNSTI4 0
ASGNI4
line 2863
;2863:}
LABELV $328
endproc CG_WarmupEvent 0 0
proc CG_ApplyClientChange 0 0
line 2868
;2864:
;2865:
;2866:// called each time client team changed
;2867:static void CG_ApplyClientChange( void )
;2868:{
line 2869
;2869:	CG_WarmupEvent();
ADDRGP4 CG_WarmupEvent
CALLV
pop
line 2870
;2870:	CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 2871
;2871:}
LABELV $343
endproc CG_ApplyClientChange 0 0
data
align 4
LABELV $345
byte 4 -1
align 4
LABELV $346
byte 4 -1
align 4
LABELV $347
byte 4 -1
export CG_TrackClientTeamChange
code
proc CG_TrackClientTeamChange 8 4
line 2880
;2872:
;2873:
;2874:/*
;2875:=====================
;2876:CG_TrackClientTeamChange
;2877:=====================
;2878:*/
;2879:void CG_TrackClientTeamChange( void ) 
;2880:{
line 2888
;2881:	static int spec_client = -1;
;2882:	static int spec_team = -1;
;2883:	static int curr_team = -1;
;2884:
;2885:	int		ti; // team from clientinfo 
;2886:	int		tp; // persistant team from snapshot
;2887:
;2888:	if ( !cg.snap )
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $348
line 2889
;2889:		return;
ADDRGP4 $344
JUMPV
LABELV $348
line 2891
;2890:
;2891:	tp = cg.snap->ps.persistant[ PERS_TEAM ];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 2892
;2892:	ti = cgs.clientinfo[ cg.snap->ps.clientNum ].team;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 2894
;2893:
;2894:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) && tp != TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $355
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $355
line 2895
;2895:		ti = tp; // use team from persistant info
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 2896
;2896:	}
LABELV $355
line 2899
;2897:
;2898:	// team changed
;2899:	if ( curr_team != ti )
ADDRGP4 $347
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $358
line 2900
;2900:	{
line 2901
;2901:		curr_team = ti;
ADDRGP4 $347
ADDRLP4 4
INDIRI4
ASGNI4
line 2902
;2902:		spec_client = cg.snap->ps.clientNum;
ADDRGP4 $345
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2903
;2903:		spec_team = tp;
ADDRGP4 $346
ADDRLP4 0
INDIRI4
ASGNI4
line 2905
;2904:
;2905:		if ( spec_team == TEAM_SPECTATOR )
ADDRGP4 $346
INDIRI4
CNSTI4 3
NEI4 $361
line 2906
;2906:			spec_team = curr_team;
ADDRGP4 $346
ADDRGP4 $347
INDIRI4
ASGNI4
LABELV $361
line 2908
;2907:
;2908:		CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2909
;2909:		CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2910
;2910:		return;
ADDRGP4 $344
JUMPV
LABELV $358
line 2913
;2911:	}
;2912:
;2913:	if ( curr_team == TEAM_SPECTATOR )
ADDRGP4 $347
INDIRI4
CNSTI4 3
NEI4 $364
line 2914
;2914:	{
line 2915
;2915:		if ( spec_team != tp )
ADDRGP4 $346
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $366
line 2916
;2916:		{
line 2917
;2917:			spec_team  = tp;
ADDRGP4 $346
ADDRLP4 0
INDIRI4
ASGNI4
line 2918
;2918:			spec_client = cg.snap->ps.clientNum;
ADDRGP4 $345
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2920
;2919:
;2920:			CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2921
;2921:			CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2922
;2922:			return;
ADDRGP4 $344
JUMPV
LABELV $366
line 2925
;2923:		}
;2924:
;2925:		if ( cgs.gametype >= GT_TEAM ) 
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $370
line 2926
;2926:		{
line 2927
;2927:			spec_client = cg.snap->ps.clientNum;
ADDRGP4 $345
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2928
;2928:			return;
ADDRGP4 $344
JUMPV
LABELV $370
line 2931
;2929:		}
;2930:		// pass through to spec client checks
;2931:	}
LABELV $364
line 2933
;2932:	
;2933:	if ( spec_client != cg.snap->ps.clientNum ) 
ADDRGP4 $345
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $374
line 2934
;2934:	{
line 2935
;2935:		spec_client = cg.snap->ps.clientNum;
ADDRGP4 $345
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2936
;2936:		spec_team = tp;
ADDRGP4 $346
ADDRLP4 0
INDIRI4
ASGNI4
line 2938
;2937:
;2938:		if ( spec_team == TEAM_SPECTATOR )
ADDRGP4 $346
INDIRI4
CNSTI4 3
NEI4 $378
line 2939
;2939:			spec_team = cgs.clientinfo[ cg.snap->ps.clientNum ].team;
ADDRGP4 $346
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
LABELV $378
line 2941
;2940:
;2941:		CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2942
;2942:		CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2943
;2943:	}
LABELV $374
line 2944
;2944:}
LABELV $344
endproc CG_TrackClientTeamChange 8 4
export CG_DrawActive
proc CG_DrawActive 0 4
line 2954
;2945:
;2946:
;2947:/*
;2948:=====================
;2949:CG_DrawActive
;2950:
;2951:Perform all drawing needed to completely fill the screen
;2952:=====================
;2953:*/
;2954:void CG_DrawActive( stereoFrame_t stereoView ) {
line 2956
;2955:	// optionally draw the info screen instead
;2956:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $385
line 2957
;2957:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 2958
;2958:		return;
ADDRGP4 $384
JUMPV
LABELV $385
line 2961
;2959:	}
;2960:
;2961:	if ( !cg.demoPlayback ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $388
line 2962
;2962:		CG_CalculatePing();
ADDRGP4 CG_CalculatePing
CALLV
pop
line 2963
;2963:	}
LABELV $388
line 2966
;2964:
;2965:	// optionally draw the tournement scoreboard instead
;2966:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $391
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $391
line 2967
;2967:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 2968
;2968:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 2969
;2969:		return;
ADDRGP4 $384
JUMPV
LABELV $391
line 2973
;2970:	}
;2971:
;2972:	// clear around the rendered view if sized down
;2973:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 2976
;2974:
;2975:	// draw 3D view
;2976:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109056
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 2979
;2977:
;2978:	// play warmup sounds and display text
;2979:	CG_WarmupEvents();
ADDRGP4 CG_WarmupEvents
CALLV
pop
line 2982
;2980:
;2981:	// draw status bar and other floating elements
;2982:	CG_Draw2D( stereoView );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Draw2D
CALLV
pop
line 2983
;2983:}
LABELV $384
endproc CG_DrawActive 0 4
import CG_CalculatePing
import CG_Draw2D
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
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_ForceModelChange
import CG_ShowResponseHead
import CG_CheckOrderPending
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_DrawTeamBackground
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
bss
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $313
byte 1 70
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 33
byte 1 0
