#include "cg_drawhud.h"
#ifdef NEOHUD

/*
==============
CG_Draw_itemDef
Draws standard item
==============
*/
static void CG_Draw_itemDef(item_t * itm) {
	rectangle_t r;
	vec4_t		backcolor;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);
	HUD_Update_Valign(itm, &r);

	if (itm->backcolor.colorflags > 0) {
		HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

		if (itm->shader)
			trap_R_SetColor(backcolor);

		if (itm->propFlags & PROP_FILL)
			CG_FillRect(r.x, r.y, r.w, r.h, backcolor);
	}

	if (itm->gradientFlags)
		HUD_DrawGradientBackground(itm, &r);
	else {
		HUD_DrawBackground(itm, &r);
	}

	HUD_Draw_Text(itm, &r);

	if (itm->backcolor.colorflags > 0) {
		trap_R_SetColor(NULL);
	}

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}

/*
==============
CG_DrawField

Draws large numbers for status bar and powerups
==============
*/
#ifndef MISSIONPACK
static void CG_DrawField(int x, int y, int width, int value, float charWidth, float charHeight) {
	char	num[16], *ptr;
	int		l;
	int		frame;

	if (width < 1) {
		return;
	}

	// draw number string
	if (width > 5) {
		width = 5;
	}

	switch (width) {
	case 1:
		value = value > 9 ? 9 : value;
		value = value < 0 ? 0 : value;
		break;
	case 2:
		value = value > 99 ? 99 : value;
		value = value < -9 ? -9 : value;
		break;
	case 3:
		value = value > 999 ? 999 : value;
		value = value < -99 ? -99 : value;
		break;
	case 4:
		value = value > 9999 ? 9999 : value;
		value = value < -999 ? -999 : value;
		break;
	}

	Com_sprintf(num, sizeof(num), "%i", value);
	l = strlen(num);
	if (l > width)
		l = width;
	x += 2 + charWidth * (width - l);

	ptr = num;
	while (*ptr && l)
	{
		if (*ptr == '-')
			frame = STAT_MINUS;
		else
			frame = *ptr - '0';

		CG_DrawPic(x, y, charWidth, charHeight, cgs.media.numberShaders[frame]);
		x += charWidth;
		ptr++;
		l--;
	}
}
#endif // MISSIONPACK


/*
================
CG_DrawStatusBarHead

================
*/
#ifndef MISSIONPACK
void CG_DrawStatusBarHead(item_t *itm, rectangle_t rect, int clientNum) {
	vec3_t		angles;
	float		frac;
	qboolean	force3D;

	int x = rect.x;
	int w = rect.w;
	int h = rect.h;

	VectorClear(angles);

	force3D = (itm->iconFlags & ICON_3D);

	if (itm->iconFlags & ICON_HEAD_ANIM) {

		if (cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME) {
			float stretchX;
			frac = (float)(cg.time - cg.damageTime) / DAMAGE_TIME;
			w = rect.w * (1.5 - frac * 0.5);
			h = rect.h * (1.5 - frac * 0.5);
			stretchX = 0.5 * (w - rect.w);
			// kick in the direction of damage
			x = rect.x - (stretchX + cg.damageX * stretchX);
			cg.headStartYaw = 180 + cg.damageX * 45;
			cg.headEndYaw = 180 + 20 * cos(crandom()*M_PI);
			cg.headEndPitch = 5 * cos(crandom()*M_PI);
			cg.headStartTime = cg.time;
			cg.headEndTime = cg.time + 100 + random() * 2000;
		}
		else {
			if (cg.time >= cg.headEndTime) {
				// select a new head angle
				cg.headStartYaw = cg.headEndYaw;
				cg.headStartPitch = cg.headEndPitch;
				cg.headStartTime = cg.headEndTime;
				cg.headEndTime = cg.time + 100 + random() * 2000;
				cg.headEndYaw = 180 + 20 * cos(crandom()*M_PI);
				cg.headEndPitch = 5 * cos(crandom()*M_PI);
			}
		}

		// if the server was frozen for a while we may have a bad head start time
		if (cg.headStartTime > cg.time) {
			cg.headStartTime = cg.time;
		}

		frac = (cg.time - cg.headStartTime) / (float)(cg.headEndTime - cg.headStartTime);
		frac = frac * frac * (3 - 2 * frac);
		angles[YAW] = cg.headStartYaw + (cg.headEndYaw - cg.headStartYaw) * frac;
		angles[PITCH] = cg.headStartPitch + (cg.headEndPitch - cg.headStartPitch) * frac;
	}
	else {
		angles[PITCH] = 0;
		angles[YAW] = 180;
		angles[ROLL] = 0;
	}
	CG_DrawHead(x, rect.y, w, h, clientNum, angles, force3D);
}
#endif // MISSIONPACK

/*
================
CG_DrawTeamBackground
used in CG_DrawTeamBar() & CG_DrawOldScoreboard()
================
*/
void CG_DrawTeamBackground(int x, int y, int w, int h, float alpha, int team)
{
	float		*hcolor;
	qhandle_t	shader;

	if (team == TEAM_RED) {
		hcolor = teams_colors[TEAM_RED];
	}
	else if (team == TEAM_BLUE) {
		hcolor = teams_colors[TEAM_BLUE];
	}
	else {
		return;
	}

	hcolor[3] = alpha;
	trap_R_SetColor(hcolor);

	shader = cgs.media.teamStatusBar;
	CG_DrawPic(x, y, w, h, shader);
	trap_R_SetColor(NULL);
}


/*
================
CG_DrawTeamBar
================
*/
#ifndef MISSIONPACK
static void CG_DrawTeamBar(item_t *itm) {
	rectangle_t r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	CG_DrawTeamBackground(r.x, r.y, r.w, r.h, itm->backcolor.color[3], cg.snap->ps.persistant[PERS_TEAM]);

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}
#endif



/*
================
CG_Draw_Icon_Ammo
2D ico or 3D model
================
*/
#ifndef MISSIONPACK
void CG_Draw_Icon_Ammo(item_t *itm, rectangle_t rect, int clientNum) {
	centity_t		*cent;
	qboolean		force3D;

	force3D = (itm->iconFlags & ICON_3D);

	cent = &cg_entities[clientNum];

	if (cent->currentState.weapon) {
		// draw a 3D icon for ammo
		if ((cg_draw3dIcons.integer && cg_weapons[cent->currentState.weapon].ammoModel) || force3D) {
			vec3_t		angles;
			vec3_t		origin;

			VectorClear(angles);

			origin[0] = 70;
			origin[1] = 0;
			origin[2] = 0;
			angles[YAW] = 90 + 20 * sin((cg.time % TMOD_1000) / 1000.0);

			CG_Draw3DModel(rect.x, rect.y, rect.w, rect.h, cg_weapons[cent->currentState.weapon].ammoModel, 0, origin, angles);
		}
		// if we didn't draw a 3D icon, draw a 2D icon for armor
		else if (cg_drawIcons.integer) {
			qhandle_t shader;
			// actual player
			if (clientNum == cg.snap->ps.clientNum) {
				shader = CG_HUDShader(itm, cg_weapons[cg.predictedPlayerState.weapon].ammoIcon);
			}
			// team players
			else {
				shader = CG_HUDShader(itm, cg_weapons[cent->currentState.weapon].ammoIcon);
			}

			CG_DrawPic(rect.x, rect.y, rect.w, rect.h, shader);
		}
		HUD_Update_finalRect(itm, rect.x, rect.y, rect.w, rect.h);
	}
}
#endif // MISSIONPACK


/*
================
CG_Draw_Icon_Armor
2D ico or 3D model
================
*/
#ifndef MISSIONPACK
void CG_Draw_Icon_Armor(item_t *itm, rectangle_t rect, int clientNum) {
	centity_t		*cent;
	vec3_t			angles;
	vec3_t			origin;
	qboolean		force3D;

	int				armorVal;
	qboolean		showZeroValue;

	force3D = (itm->iconFlags & ICON_3D);

	// actual player
	if (clientNum == cg.snap->ps.clientNum) {
		armorVal = cg.snap->ps.stats[STAT_ARMOR];
	}
	// team players
	else {
		clientInfo_t	*ci;
		ci = &cgs.clientinfo[clientNum];
		armorVal = ci->armor;
	}

	cent = &cg_entities[clientNum];

	showZeroValue = (armorVal == 0 && (itm->visible_prop_flags[1] & VIS_ZERO_VALUE));

	if (armorVal && !showZeroValue) {
		// draw a 3D icon for armor
		if (cg_draw3dIcons.integer || force3D) {
			VectorClear(angles);
			origin[0] = 90;
			origin[1] = 0;
			origin[2] = -10;
			angles[YAW] = (cg.time & 2047) * 360 / 2048.0;
			CG_Draw3DModel(rect.x, rect.y, rect.w, rect.h, cgs.media.armorModel, 0, origin, angles);
		}
		// if we didn't draw a 3D icon, draw a 2D icon for armor
		else if (cg_drawIcons.integer) {
			if (!cg_draw3dIcons.integer && cg_drawIcons.integer) {
				qhandle_t shader = CG_HUDShader(itm, cgs.media.armorIcon);
				CG_DrawPic(rect.x, rect.y, rect.w, rect.h, shader);
			}
		}
		HUD_Update_finalRect(itm, rect.x, rect.y, rect.w, rect.h);
	}
}
#endif


/*
================
CG_Draw_Icon_Flag
2D ico or 3D model
================
*/
#ifndef MISSIONPACK
static void CG_Draw_Icon_Flag(item_t *itm) {
	rectangle_t r;
	int team;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	team = TEAM_NUM_TEAMS;

	if (cg.predictedPlayerState.powerups[PW_REDFLAG]) {
		team = TEAM_RED;
	}
	else if (cg.predictedPlayerState.powerups[PW_BLUEFLAG]) {
		team = TEAM_BLUE;
	}
	else if (cg.predictedPlayerState.powerups[PW_NEUTRALFLAG]) {
		team = TEAM_FREE;
	}

	if (team < TEAM_NUM_TEAMS) {
		r = itm->rect;

		HUD_Update_Anchors(itm, &r);
		HUD_Update_Margin(itm, &r);

		CG_DrawFlagModel(r.x, r.y, r.w, r.h, team, qfalse);

		HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
	}
}
#endif



#ifdef MISSIONPACK 
static void CG_Draw_Harverster_Armor_Icon(void)
{
	vec3_t		angles;
	vec3_t		origin;
	qhandle_t	handle;
	float		y;

	if (cg_drawStatus.integer == 0) {
		return;
	}

	y = cgs.screenYmax + 1 - ICON_SIZE;

	VectorClear(angles);

	// 3D
	if (cgs.gametype == GT_HARVESTER) {
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = (cg.time & 2047) * 360 / 2048.0;
		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
			handle = cgs.media.redCubeModel;
		}
		else {
			handle = cgs.media.blueCubeModel;
		}
		CG_Draw3DModel(640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles);
	}

	// if we didn't draw a 3D icon, draw a 2D icon for armor
	if (!cg_draw3dIcons.integer && cg_drawIcons.integer) {
		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
			handle = cgs.media.redCubeIcon;
		}
		else {
			handle = cgs.media.blueCubeIcon;
		}
		CG_DrawPic(640 - (TEXT_ICON_SPACE + ICON_SIZE), y, ICON_SIZE, ICON_SIZE, handle);
	}
	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}
#endif

#ifdef MISSIONPACK
static void CG_Draw_Harverster_Armor_Count(void)
{
	float		y;

	if (cg_drawStatus.integer == 0) {
		return;
	}

	y = cgs.screenYmax + 1 - ICON_SIZE;

	// cubes
	if (cgs.gametype == GT_HARVESTER) {
		int value;
		value = ps->generic1;
		if (value > 99) {
			value = 99;
		}
		trap_R_SetColor(colors[0]);
		CG_DrawField(640 - (HUD.StatusBar_ArmorCount.fontsize.w * 2 + TEXT_ICON_SPACE + ICON_SIZE), y, 2, value,
			HUD.StatusBar_ArmorCount.fontsize.w, HUD.StatusBar_ArmorCount.fontsize.h);
		trap_R_SetColor(NULL);
		HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
	}
}
#endif


/*
================
CG_DrawAttacker

================
*/
void CG_DrawAttacker_icon(item_t * itm) {
	int			clientNum;
	int			t;
	vec3_t		angles;
	rectangle_t	r;
	qboolean force3D;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}
#ifdef MISSIONPACK
	if (cg_paused.integer) {
		return;
	}
#endif

	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) {
		return;
	}

	if (!cg.attackerTime) {
		return;
	}

	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
	if (clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum) {
		return;
	}

	t = cg.time - cg.attackerTime;

	if (t > itm->time) {
		cg.attackerTime = 0;
		return;
	}

	angles[PITCH] = 0;
	angles[YAW] = 180;
	angles[ROLL] = 0;

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	force3D = (itm->iconFlags & ICON_3D);

	CG_DrawHead(r.x, r.y, r.w, r.h, clientNum, angles, force3D);

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}


static void CG_DrawAttacker_name(item_t * itm) {
	int			clientNum;
	int			t;
	const char	*info;
	const char	*name;
	vec4_t		forecolor;
	rectangle_t r;
	static vec4_t defaultColor = { 1.0f, 1.0f, 1.0f, 0.5f };

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

#ifdef MISSIONPACK
	if (cg_paused.integer) {
		return;
	}
#endif

	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) {
		return;
	}

	if (!cg.attackerTime) {
		return;
	}

	t = cg.time - cg.attackerTime;
	if (t > itm->time) {
		cg.attackerTime = 0;
		return;
	}

	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
	if (clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum) {
		return;
	}

	r = itm->rect;
	HUD_color(itm, &itm->forecolor, &forecolor, defaultColor);
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	info = CG_ConfigString(CS_PLAYERS + clientNum);
	name = Info_ValueForKey(info, "n");
	CG_DrawString(r.x, r.y, name, forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

	r.w = itm->fontsize.w * CG_DrawStrlen(name);

	if (itm->text.styleflags & DS_RIGHT)
		r.x -= r.w;
	if (itm->text.styleflags & DS_CENTER)
		r.x -= 0.5f * r.w;
	r.h = itm->fontsize.h;

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}

#define	FPS_FRAMES	4
static int CG_Calcul_FPS() {
	static int	previousTimes[FPS_FRAMES];
	static int	index;
	int			i, total;
	static int	previous;
	int			t, frameTime;

	// don't use serverTime, because that will be drifting to
	// correct for internet lag changes, timescales, timedemos, etc
	t = trap_Milliseconds();
	frameTime = t - previous;
	previous = t;

	previousTimes[index % FPS_FRAMES] = frameTime;
	index++;
	if (index > FPS_FRAMES) {
		// average multiple frames together to smooth changes out a bit
		total = 0;
		for (i = 0; i < FPS_FRAMES; i++) {
			total += previousTimes[i];
		}
		if (!total) {
			total = 1;
		}
		return 1000 * FPS_FRAMES / total;
	}
	return 0;
}


/*
==========================================
Team order & team info from MISSIONPACK
use with:
bind PGDN "nextOrder"
bind PGUP "nextTeamMember"
bind o "nextOrder"
bind p "confirmOrder"
==========================================
*/
const char * getTeamPlayerName(int playerIndex) {
	clientInfo_t *ci;
	int idx;

	if (playerIndex < 0)
		idx = cg_currentSelectedPlayer.integer;
	else
		idx = playerIndex;

	ci = cgs.clientinfo + sortedTeamPlayers[idx];
	if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
		return ci->name;
	}
	return "unknown";
}

const char* getPlayerLocation(int playerIndex) {
	const char	*p;
	clientInfo_t *ci;
	int idx;

	if (playerIndex < 0)
		idx = cg_currentSelectedPlayer.integer;
	else
		idx = playerIndex;

	ci = cgs.clientinfo + sortedTeamPlayers[idx];

	p = CG_ConfigString(CS_LOCATIONS + ci->location);
	if (!p || !*p)
		p = "unknown";

	return p;
}

int getPlayerHealth(int playerIndex) {
	int valHealth;

	// Actual player
	if (!playerIndex) {
		valHealth = cg.snap->ps.stats[STAT_HEALTH];
	}
	// selected team player
	else if (playerIndex < 0) {
		clientInfo_t *ci;
		ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
		valHealth = ci->health;
	}
	// any player
	else {
		clientInfo_t *ci;
		ci = cgs.clientinfo + sortedTeamPlayers[playerIndex];
		valHealth = ci->health;
	}
	return valHealth;
}

void CG_DrawTeamPlayerPowerup(rectDef_t *rect, int param, int powerUpNb) {
	int j;
	int x;
	clientInfo_t *ci;
	x = rect->x + 1;
	for (j = 0; j <= PW_NUM_POWERUPS; j++) {
		ci = cgs.clientinfo + sortedTeamPlayers[param];
		if (ci && ci->powerups & (1 << j)) {
			gitem_t	*item = BG_FindItemForPowerup(j);
			if (item) {
				CG_DrawPic(x, rect->y, rect->w, rect->h, trap_R_RegisterShader(item->icon));
				x += rect->w;
			}
		}
	}
	// FIXME: max of 3 powerups shown properly
}


/*
=================
CG_DrawTeamOverlay
=================
*/
static void CG_DrawTeamOverlay(item_t *itm) {
	int			x;
	int			i, j, len;
	const char	*p;
	//vec4_t		color;
	int			pwidth, lwidth;
	int			plyrs;
	char		st[16];
	clientInfo_t *ci;
	gitem_t		*item;
	int			count;
	int			iconW, iconH;
	qhandle_t	shader;
	rectangle_t r;
	int			teamId;
	vec4_t		forecolor;
	vec4_t		backcolor;
	vec4_t		defaultBackcolor;
	vec4_t		healthcolor;
	rectangle_t icoOrderRect;
	vec4_t		colorTxt;
	// selected player stuff
	item_t		itmSel;
	vec4_t		forecolorSel;
	vec4_t		backcolorSel;
	qhandle_t	shaderSel;
#ifdef MISSIONPACK
	if (cg_paused.integer) {
		return;
	}
#endif

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	plyrs = 0;

	// max player name width
	pwidth = 0;
	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
			plyrs++;
			len = CG_DrawStrlen(ci->name);
			if (len > pwidth)
				pwidth = len;
		}
	}

	if (!plyrs)
		return;

	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
		teamId = TEAM_RED;
	}
	else {
		teamId = TEAM_BLUE;
	}

	itmSel = dyn_itemArray[TeamOverlay_Sel_idx];

	copyColor(teams_colors[teamId], &defaultBackcolor);

	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;

	// max location name width
	lwidth = 0;
	for (i = 1; i < MAX_LOCATIONS; i++) {
		p = CG_ConfigString(CS_LOCATIONS + i);
		if (p && *p) {
			len = CG_DrawStrlen(p);
			if (len > lwidth)
				lwidth = len;
		}
	}

	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	r.h *= plyrs;

	// get HUD forecolor & backcolor
	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	HUD_color(itm, &itm->backcolor, &backcolor, defaultBackcolor);

	// get selected player forecolor & backcolor
	HUD_color(&itmSel, &itmSel.forecolor, &forecolorSel, colorWhite);
	HUD_color(&itmSel, &itmSel.backcolor, &backcolorSel, colorYellow);

	// Draw background
	shader = CG_HUDShader(itm, cgs.media.teamStatusBar);
	shaderSel = CG_HUDShader(&itmSel, cgs.media.teamStatusBar);

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
			// selected player
			if (i == cg_currentSelectedPlayer.integer || cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
				iconW = itmSel.fontsize.w;
				iconH = itmSel.fontsize.h;
				trap_R_SetColor(backcolorSel);
				CG_DrawPic(r.x, r.y, r.w, iconH, shaderSel);
				trap_R_SetColor(NULL);
				copyColor(forecolorSel, &colorTxt);
			}
			// not selected player
			else {
				iconW = itm->fontsize.w;
				iconH = itm->fontsize.h;
				trap_R_SetColor(backcolor);
				CG_DrawPic(r.x, r.y, r.w, iconH, shader);
				trap_R_SetColor(NULL);
				copyColor(forecolor, &colorTxt);
			}

			x = r.x + iconW;

			// Draw player's name
			CG_DrawString(x, r.y, ci->name, colorTxt, iconW, iconH, TEAM_OVERLAY_MAXNAME_WIDTH, itm->text.styleflags);

			// Draw player's order
			icoOrderRect.x = r.x + iconW * 2 + iconW * pwidth;
			icoOrderRect.y = r.y;
			icoOrderRect.w = iconH;
			icoOrderRect.h = iconH;
			CG_DrawSelectedPlayerStatus(&icoOrderRect, i);

			// Draw player's location
			if (lwidth) {
				p = CG_ConfigString(CS_LOCATIONS + ci->location);
				if (!p || !*p)
					p = "unknown";
				len = CG_DrawStrlen(p);
				if (len > lwidth)
					len = lwidth;

				//x = r.x + iconW * 2 + iconW * pwidth;
				x = r.x + iconW * 2 + iconW * pwidth + iconH;
				CG_DrawString(x, r.y, p, colorTxt, iconW, iconH, TEAM_OVERLAY_MAXLOCATION_WIDTH, itm->text.styleflags);
			}

			//
			// Draw player's health & armor
			//
			CG_GetColorForHealth(ci->health, ci->armor, healthcolor);
			Com_sprintf(st, sizeof(st), "%3i %3i", ci->health, ci->armor);

			x = r.x + iconW * 3 + iconW * pwidth + iconW * lwidth;
			CG_DrawString(x, r.y, st, healthcolor, iconW, iconH, 0, 0);

			//
			// Draw weapon icon
			//
			x += iconW * 3;

			if (cg_weapons[ci->curWeapon].weaponIcon) {
				CG_DrawPic(x, r.y, iconW, iconH, cg_weapons[ci->curWeapon].weaponIcon);
			}
			else {
				CG_DrawPic(x, r.y, iconW, iconH, cgs.media.deferShader);
			}

			//
			// Draw powerup icons
			//
			x = r.x;
			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
				if (ci->powerups & (1 << j)) {

					item = BG_FindItemForPowerup(j);
					if (item) {
						CG_DrawPic(x, r.y, iconW, iconH, trap_R_RegisterShader(item->icon));
						//if (right) {
						x -= iconW;
						/*} else {
							x += iconW;
						}*/
					}
				}
			}
			r.y += iconH;
		}
	}
}


/*
=================
CG_DrawScores

Draw the small two score display
=================
*/
int playerTeam;

static void CG_DrawScoreName(item_t *itm, qboolean ownScore) {
	const char	*name;
	const char	*s;
	vec4_t		forecolor;
	vec4_t		backcolor;
	int			i;
	rectangle_t r;
	int neededScore;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);
	HUD_Update_Valign(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

	name = "";

	if (!ownScore) {
		int playerScore;

		playerScore = cg.snap->ps.persistant[PERS_SCORE];

		if (cgs.scores1 == playerScore) {
			neededScore = cgs.scores2;
		}
		else {
			neededScore = cgs.scores1;
		}
	}

	if (neededScore == SCORE_NOT_PRESENT)
		return;

	if (cgs.gametype < GT_TEAM) {
		if (ownScore) {
			// actual player name
			name = cgs.clientinfo[cg.snap->ps.clientNum].name;
		}
		else {
			// opposite player's name
			for (i = 0; i < cgs.maxclients; i++) {
				if (cg.snap->ps.clientNum != i) {
					if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE) {
						name = cgs.clientinfo[i].name;
					}
				}
			}
		}
	}
	else {
		// Display blue team name
		if ((playerTeam == TEAM_BLUE && ownScore) || (playerTeam == TEAM_RED && !ownScore)) {
			name = "Blue Team";
		}
		else if ((playerTeam == TEAM_RED && ownScore) || (playerTeam == TEAM_BLUE && !ownScore)) {
			// Display red team name
			name = "Red Team";
		}
		else if (playerTeam == TEAM_SPECTATOR && ownScore) {
			name = "Spectator";
		}
		else if (playerTeam == TEAM_FREE && ownScore) {
			name = "Team Free";
		}
	}

	s = va("%s", name);

	if (itm->propFlags & PROP_FILL) {
		CG_FillRect(r.x, r.y, r.w, r.h, backcolor);
	}

	if (itm->shader) {
		trap_R_SetColor(backcolor);
		CG_DrawPic(r.x, r.y, r.w, r.h, itm->shader);
		trap_R_SetColor(NULL);
	}

	CG_DrawString(r.x, r.y, s, forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags); //GUNNM fixme: why color changes when dead?

	HUD_Update_finalRect(itm, itm->rect.x, itm->rect.y, max(r.w, itm->fontsize.w * CG_DrawStrlen(s)), itm->fontsize.h);
}

static void CG_DrawOneFlag(item_t *itm, qboolean ownFlag) {
	rectangle_t r;
	gitem_t		*item;
	vec4_t		backcolor;

	if (cgs.gametype != GT_CTF
#ifdef MISSIONPACK
		&& cgs.gametype != GT_1FCTF
#endif
		)
		return;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);
	HUD_Update_Valign(itm, &r);

	HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

	if (itm->propFlags & PROP_FILL) {
		CG_FillRect(r.x, r.y, r.w, r.h, backcolor);
	}

	playerTeam = cg.snap->ps.persistant[PERS_TEAM];

	// Display blue flag status
	if ((playerTeam == TEAM_BLUE && ownFlag) || (playerTeam == TEAM_RED && !ownFlag)) {

		item = BG_FindItemForPowerup(PW_BLUEFLAG);

		if (item) {
			if (cgs.blueflag >= 0 && cgs.blueflag <= 2) {
				CG_DrawPic(r.x, r.y, r.w, r.h, cgs.media.blueFlagShader[cgs.blueflag]);
			}
		}
	}
	// Display red flag status
	else if ((playerTeam == TEAM_RED && ownFlag) || (playerTeam == TEAM_BLUE && !ownFlag)) {
		item = BG_FindItemForPowerup(PW_REDFLAG);

		if (item) {
			if (cgs.redflag >= 0 && cgs.redflag <= 2) {
				CG_DrawPic(r.x, r.y, r.w, r.h, cgs.media.redFlagShader[cgs.redflag]);
			}
		}
	}

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}

static void CG_DrawOneScore(item_t *itm, qboolean ownScore) {
	const char	*s;
	int			s1, s2, playerScore;
	int			charW, charH;
	int			y, h;
	marginDef_t margin;
	qhandle_t	shader;
	rectangle_t r;
	int			neededScore;
	vec4_t		forecolor;
	vec4_t		backcolor;
	qboolean	spectator;
	int			team;

#ifdef MISSIONPACK
	return;
#endif

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);
	HUD_Update_Valign(itm, &r);

	charW = itm->fontsize.w;
	charH = itm->fontsize.h;

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

	shader = CG_HUDShader(itm, cgs.media.selectShader);

	margin = itm->margin;

	s1 = cgs.scores1;
	s2 = cgs.scores2;

	y = r.y - charH;

	h = margin.top + charH + margin.bottom;

	trap_R_SetColor(NULL);

	team = cg.snap->ps.persistant[PERS_TEAM];
	playerScore = cg.snap->ps.persistant[PERS_SCORE];
	spectator = (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR);

	if (ownScore) {
		neededScore = playerScore;
	}
	else {
		if (s1 == playerScore) {
			neededScore = s2;
		}
		else {
			neededScore = s1;
		}
	}

	if (neededScore == SCORE_NOT_PRESENT)
		return;

	s = va("%2i", neededScore);

	if (itm->propFlags & PROP_FILL) {
		//GUNNM fixme: why color changes when dead?
		CG_FillRect(r.x, r.y, r.w, r.h, backcolor);
	}

	CG_DrawString(itm->rect.x, itm->rect.y, s, forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

	HUD_Update_finalRect(itm, itm->rect.x, itm->rect.y, itm->fontsize.w * CG_DrawStrlen(s), itm->fontsize.h);
}


static void CG_DrawScoreOWN(item_t *itm) {
	CG_DrawOneScore(itm, qtrue);
}

static void CG_DrawScoreNME(item_t *itm) {
	CG_DrawOneScore(itm, qfalse);
}

static void CG_DrawNameOWN(item_t *itm) {
	CG_DrawScoreName(itm, qtrue);
}

static void CG_DrawNameNME(item_t *itm) {
	CG_DrawScoreName(itm, qfalse);
}

static void CG_DrawFlag_OWN(item_t *itm) {
	CG_DrawOneFlag(itm, qtrue);
}

static void CG_DrawFlag_NME(item_t *itm) {
	CG_DrawOneFlag(itm, qfalse);
}

#ifndef MISSIONPACK
static void CG_DrawScores(item_t *itm) {
	const char	*s;
	int			s1, s2, score;
	int			v;
	vec4_t		forecolor;
	gitem_t		*item;
	marginDef_t margin;
	qhandle_t	shader;
	int			charW, charH;
	int			x, x0, y, w, h;
	rectangle_t r;
	rectangle_t finalR;

#ifdef MISSIONPACK
	return;
#endif

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);
	HUD_Update_Valign(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	shader = CG_HUDShader(itm, cgs.media.selectShader);

	charW = itm->fontsize.w;
	charH = itm->fontsize.h;

	margin = itm->margin;

	s1 = cgs.scores1;
	s2 = cgs.scores2;

	y = r.y - charH;

	h = margin.top + charH + margin.bottom;

	// draw from the right side to left
	if (cgs.gametype >= GT_TEAM) {
		//
		// second score
		//
		s = va("%2i", s2);
		w = margin.left + CG_DrawStrlen(s) * charW + margin.right;
		x = r.x - w;

		CG_FillRect(x, y, w, h, teams_colors[TEAM_BLUE]);

		finalR.x = x;
		finalR.y = y;
		finalR.w = w;
		finalR.h = h;

		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
			CG_DrawPic(x, y, w, h, shader);// cgs.media.selectShader;
		}

		CG_DrawString(r.x - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);// DS_SHADOW | DS_RIGHT);

		if (cgs.gametype == GT_CTF) {
			// Display flag status
			item = BG_FindItemForPowerup(PW_BLUEFLAG);

			if (item) {
				if (cgs.blueflag >= 0 && cgs.blueflag <= 2) {
					CG_DrawPic(x, y - h, w, h, cgs.media.blueFlagShader[cgs.blueflag]);
				}
			}
		}

		//
		// first score
		//
		s = va("%2i", s1);
		w = margin.left + CG_DrawStrlen(s) * charW + margin.right;

		x -= w;
		CG_FillRect(x, y, w, h, teams_colors[TEAM_RED]);

		// final rect update
		if (x < finalR.x) {
			finalR.x = x;
			finalR.w += w;
		}

		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
			CG_DrawPic(x, y, w, h, shader);
		}

		CG_DrawString(r.x - w - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);//DS_SHADOW | DS_RIGHT);

		if (cgs.gametype == GT_CTF) {
			// Display flag status
			item = BG_FindItemForPowerup(PW_REDFLAG);

			if (item) {

				if (cgs.redflag >= 0 && cgs.redflag <= 2) {
					CG_DrawPic(x, y - h, w, h, cgs.media.redFlagShader[cgs.redflag]);
					// final rect update
					finalR.y = y - h;
					finalR.h += h;
				}
			}
		}

#ifdef MISSIONPACK
		if (cgs.gametype == GT_1FCTF) {
			// Display flag status
			item = BG_FindItemForPowerup(PW_NEUTRALFLAG);

			if (item) {
				if (cgs.flagStatus >= 0 && cgs.flagStatus <= 3) {
					CG_DrawPic(x, y - charH - margin2Y, w, h, cgs.media.flagShader[cgs.flagStatus]);
				}
			}
		}
#endif
		// score limit
		if (cgs.gametype >= GT_CTF) {
			v = cgs.capturelimit;
		}
		else {
			v = cgs.fraglimit;
		}
		if (v) {
			s = va("%2i", v);
			CG_DrawString(x - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);
		}
	}
	else {
		qboolean	spectator;
		x = r.x;
		score = cg.snap->ps.persistant[PERS_SCORE];
		spectator = (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR);

		// always show your score in the second box if not in first place
		if (s1 != score) {
			s2 = score;
		}

		if (s2 != SCORE_NOT_PRESENT) {
			x0 = x;
			s = va("%2i", s2);
			w = margin.left + CG_DrawStrlen(s) * charW + margin.right;
			x -= w;
			if (!spectator && score == s2 && score != s1) {
				CG_FillRect(x, y, w, h, teams_colors[TEAM_RED]);
				CG_DrawPic(x, y, w, h, shader);
			}
			else {
				CG_FillRect(x, y, w, h, teams_colors[TEAM_FREE]);
			}
			CG_DrawString(x0 - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);

			// final rect update
			finalR.x = x;
			finalR.y = y;
			finalR.w = w;
			finalR.h = h;
		}

		// first place
		if (s1 != SCORE_NOT_PRESENT) {
			x0 = x;
			s = va("%2i", s1);
			w = margin.left + CG_DrawStrlen(s) * charW + margin.right;
			x -= w;
			if (!spectator && score == s1) {
				//Com_Printf("A1 x: %i \n", x);
				CG_FillRect(x, y, w, h, teams_colors[TEAM_BLUE]);
				CG_DrawPic(x, y, w, h, shader);
			}
			else {
				CG_FillRect(x, y, w, h, teams_colors[TEAM_FREE]);
			}
			CG_DrawString(x0 - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);

			// final rect update
			finalR.x = x;
			finalR.y = y;
			finalR.w += w;
			finalR.h = h;
		}

		if (cgs.fraglimit) {
			s = va("%2i", cgs.fraglimit);
			CG_DrawString(x - margin.left, y + margin.top, s, forecolor, charW, charH, 0, itm->text.styleflags);
		}
	}

	HUD_Update_finalRect(itm, finalR.x, finalR.y, finalR.w, finalR.h);
}
#endif // MISSIONPACK


/*
================
CG_DrawPowerups
================
*/
#ifndef MISSIONPACK
static void CG_DrawPowerups(item_t *itm) {
	int				sorted[MAX_POWERUPS];
	int				sortedTime[MAX_POWERUPS];
	int				i, j, k, t, active;
	int				idColor;
	float			txtY, f;
	playerState_t	*ps;
	gitem_t			*item;
	item_t			ico_itm;
	rectangle_t		r, ico_r;
	vec4_t			forecolor;
	static vec4_t	defaultColor = { 0.2f, 1.0f, 0.2f, 1.0f };

#ifdef MISSIONPACK
	return;
#endif
	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	// PowerUpCounter properties
	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	// Icon_PowerUp properties
	ico_itm = dyn_itemArray[IcoPowerUp_idx];
	ico_r = ico_itm.rect;

	// Get player's state
	ps = &cg.snap->ps;

	if (ps->stats[STAT_HEALTH] <= 0) {
		return;
	}

	// sort the list by time remaining
	active = 0;
	for (i = 0; i < MAX_POWERUPS; i++) {
		if (!ps->powerups[i]) {
			continue;
		}
		t = ps->powerups[i] - cg.time;
		// don't draw if the powerup has unlimited time (999 seconds)
		// This is true with CTF flags
		if (t < 0 || t > 999000) {
			continue;
		}

		// insert into the list
		for (j = 0; j < active; j++) {
			if (sortedTime[j] >= t) {
				for (k = active - 1; k >= j; k--) {
					sorted[k + 1] = sorted[k];
					sortedTime[k + 1] = sortedTime[k];
				}
				break;
			}
		}
		sorted[j] = i;
		sortedTime[j] = t;
		active++;
	}

	HUD_color(itm, &itm->forecolor, &forecolor, defaultColor);
	trap_R_SetColor(forecolor);

	txtY = r.y;

	// draw the icons and timers
	for (i = 0; i < active; i++) {
		item = BG_FindItemForPowerup(sorted[i]);

		if (item) {
			idColor = 1;
			// draw counter
			CG_DrawField(r.x, txtY, 2, sortedTime[i] / 1000, itm->fontsize.w, itm->fontsize.h);

			HUD_Update_finalRect(itm, r.x, txtY, itm->fontsize.w * 2, itm->fontsize.h);

			txtY -= itm->fontsize.h + itm->margin.top;

			t = ps->powerups[sorted[i]];
			if (t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME) {
				trap_R_SetColor(NULL);
			}
			else {
				vec4_t	modulate;

				f = (float)(t - cg.time) / POWERUP_BLINK_TIME;
				f -= (int)f;
				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
				trap_R_SetColor(modulate);
			}

			if (cg.powerupActive == sorted[i] &&
				cg.time - cg.powerupTime < PULSE_TIME) {
				f = 1.0 - ((float)(cg.time - cg.powerupTime) / PULSE_TIME);
				f = (1.0 + (itm->pulseScale - 1.0) * f);
				ico_r.w *= f;
				ico_r.h *= f;
			}

			// use itm->finalRect to place the icon
			HUD_Update_Anchors(&ico_itm, &ico_r);
			HUD_Update_Margin(&ico_itm, &ico_r);
			CG_DrawPic(ico_r.x, ico_r.y, ico_r.w, ico_r.h, trap_R_RegisterShader(item->icon));

		} // if ( item )
	}// for each active item

	trap_R_SetColor(NULL);
}
#endif // MISSIONPACK


/*
===================
CG_DrawPickupItem
===================
*/
#ifndef MISSIONPACK
static void CG_DrawPickupItem_Icon(item_t * itm) {
	int			value;
	float		*fadeColor;
	vec4_t		forecolor;
	rectangle_t r;

#ifdef MISSIONPACK
	return;
#endif
	if (!CG_HUDItemVisible(itm)) {
		return;
	}
	value = cg.itemPickup;

	if (value) {
		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		fadeColor = CG_FadeColorTime(cg.itemPickupTime, 3000, 250, forecolor);

		if (fadeColor) {
			CG_RegisterItemVisuals(value);
			trap_R_SetColor(fadeColor);
			r = itm->rect;
			HUD_Update_Anchors(itm, &r);
			HUD_Update_Margin(itm, &r);
			CG_DrawPic(r.x, r.y, r.w, r.h, cg_items[value].icon);
			HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
			trap_R_SetColor(NULL);
		}
		else {
			cg.itemPickupCount = 0;
		}
	}
}


static void CG_DrawPickupItem(item_t * itm) {
	int			value;
	float		*fadeColor;
	vec4_t		forecolor;
	const char	*s;
	rectangle_t r;

#ifdef MISSIONPACK
	return;
#endif

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	value = cg.itemPickup;
	if (value) {
		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		fadeColor = CG_FadeColorTime(cg.itemPickupTime, 3000, 250, forecolor);
		if (fadeColor) {
			CG_RegisterItemVisuals(value);
			trap_R_SetColor(fadeColor);

			if (itm->param == 1) {
				s = va("%i", cg.itemPickupCount);
			}
			else if (itm->param == 2) {
				s = va("%s", bg_itemlist[value].pickup_name);
			}
			else if (cg.itemPickupCount > 1) {
				s = va("%s x%i", bg_itemlist[value].pickup_name, cg.itemPickupCount);
			}
			else {
				s = bg_itemlist[value].pickup_name;
			}

			r = itm->rect;
			HUD_Update_Anchors(itm, &r);
			HUD_Update_Margin(itm, &r);

			CG_DrawString(r.x, r.y, s, fadeColor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

			r.w = itm->fontsize.w * CG_DrawStrlen(s);
			if (itm->text.styleflags & DS_RIGHT)
				r.x -= r.w;
			if (itm->text.styleflags & DS_CENTER)
				r.x -= 0.5f * r.w;
			r.h = itm->fontsize.h;

			HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

			trap_R_SetColor(NULL);
		}
		else {
			cg.itemPickupCount = 0;
		}
	}
}
#endif // MISSIONPACK

//===========================================================================================

/*
=================
CG_DrawTeamInfo
=================
*/
#ifndef MISSIONPACK
static void CG_DrawTeamInfo(item_t * itm) {
	int			i, len;
	float		*hcolor;
	int			chatHeight;
	qhandle_t	shader;
	rectangle_t r;

#ifdef MISSIONPACK
	return;
#endif

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
		chatHeight = cg_teamChatHeight.integer;
	else
		chatHeight = TEAMCHAT_HEIGHT;

	if (chatHeight <= 0)
		return; // disabled

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	if (cgs.teamLastChatPos != cgs.teamChatPos) {
		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
			cgs.teamLastChatPos++;
		}

		r.h = (cgs.teamChatPos - cgs.teamLastChatPos) * itm->fontsize.h;

		r.w = 0;

		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
			if (len > r.w)
				r.w = len;
		}

		r.w *= itm->fontsize.w;
		r.w += itm->fontsize.w * 2;

		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
			hcolor = teams_colors[TEAM_RED];
		}
		else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
			hcolor = teams_colors[TEAM_BLUE];
		}
		else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
			hcolor = teams_colors[TEAM_SPECTATOR];
		}
		else {
			hcolor = teams_colors[TEAM_FREE];
		}

		trap_R_SetColor(hcolor);

		shader = CG_HUDShader(itm, cgs.media.teamStatusBar);
		CG_DrawPic(r.x, r.y - r.h, r.w, r.h, shader);

		trap_R_SetColor(NULL);

		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
		hcolor[3] = 1.0f;

		r.x += itm->fontsize.w;

		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
			r.y -= (cgs.teamChatPos - i) * itm->fontsize.h;
			CG_DrawString(r.x, r.y, cgs.teamChatMsgs[i % chatHeight], hcolor,
				itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);
		}
		HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
	}
}
#endif // MISSIONPACK


/*
===================
CG_DrawReward
===================
*/
static void CG_DrawReward(item_t *itm) {
	float		x;
	float		*fadeColor;
	vec4_t		forecolor;
	int			i, count;
	char		buf[32];
	rectangle_t	r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);

	fadeColor = CG_FadeColor(cg.rewardTime, itm->time, forecolor);
	if (!fadeColor) {
		if (cg.rewardStack > 0) {
			for (i = 0; i < cg.rewardStack; i++) {
				cg.rewardSound[i] = cg.rewardSound[i + 1];
				cg.rewardShader[i] = cg.rewardShader[i + 1];
				cg.rewardCount[i] = cg.rewardCount[i + 1];
			}
			cg.rewardTime = cg.time;
			cg.rewardStack--;
			fadeColor = CG_FadeColor(cg.rewardTime, itm->time, forecolor);
			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
		}
		else {
			return;
		}
	}

	trap_R_SetColor(fadeColor);

	/*
	count = cg.rewardCount[0]/10;				// number of big rewards to draw

	if (count) {
		y = 4;
		x = 320 - count * ICON_SIZE;
		for ( i = 0 ; i < count ; i++ ) {
			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
			x += (ICON_SIZE*2);
		}
	}

	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
	*/

	if (cg.rewardCount[0] >= 10) {
		x = r.x - r.w * 0.5f;

		CG_DrawPic(x, r.y, r.w, r.h, cg.rewardShader[0]);

		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
		CG_DrawString(r.x, r.y + r.h, buf, fadeColor,
			itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);
	}
	else {

		count = cg.rewardCount[0];
		x = r.x - count * r.w * 0.5f;

		for (i = 0; i < count; i++) {
			CG_DrawPic(x, r.y, r.w, r.h, cg.rewardShader[0]);
			x += r.w;
		}
	}

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

	trap_R_SetColor(NULL);
}

/*
===============================================================================

LAGOMETER

===============================================================================
*/

#define	LAG_SAMPLES		128
#define	MAX_LAGOMETER_PING	900
#define	MAX_LAGOMETER_RANGE	300

typedef struct {
	int		frameSamples[LAG_SAMPLES];
	int		frameCount;
	int		snapshotFlags[LAG_SAMPLES];
	int		snapshotSamples[LAG_SAMPLES];
	int		snapshotCount;
} lagometer_t;

lagometer_t		lagometer;

/*
==============
CG_AddLagometerFrameInfo

Adds the current interpolate / extrapolate bar for this frame
==============
*/
//same in cg_draw
void CG_AddLagometerFrameInfo(void) {
	int			offset;

	offset = cg.time - cg.latestSnapshotTime;
	lagometer.frameSamples[lagometer.frameCount & (LAG_SAMPLES - 1)] = offset;
	lagometer.frameCount++;
}

/*
==============
CG_AddLagometerSnapshotInfo

Each time a snapshot is received, log its ping time and
the number of snapshots that were dropped before it.

Pass NULL for a dropped packet.
==============
*/
//same in cg_draw.c
void CG_AddLagometerSnapshotInfo(snapshot_t *snap) {
	// dropped packet
	if (!snap) {
		lagometer.snapshotSamples[lagometer.snapshotCount & (LAG_SAMPLES - 1)] = -1;
		lagometer.snapshotCount++;
		return;
	}

	// add this snapshot's info
	lagometer.snapshotSamples[lagometer.snapshotCount & (LAG_SAMPLES - 1)] = snap->ping;
	lagometer.snapshotFlags[lagometer.snapshotCount & (LAG_SAMPLES - 1)] = snap->snapFlags;
	lagometer.snapshotCount++;
}

//same in cg_draw.c
void CG_CalculatePing(void) {
	int count, i, v;

	cg.meanPing = 0;

	for (i = 0, count = 0; i < LAG_SAMPLES; i++) {

		v = lagometer.snapshotSamples[i];
		if (v >= 0) {
			cg.meanPing += v;
			count++;
		}

	}

	if (count) {
		cg.meanPing /= count;
	}
}



/*
==============
CG_DrawLagometer_Ping
==============
*/
static void CG_DrawLagometer_Ping(item_t *itm) {
	int			a, x, y, i;
	float		v;
	float		range;
	int			icolor;
	float		vscale;
	vec4_t		forecolor;
	rectangle_t r;
	qhandle_t	shader;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	//
	// draw the graph
	//
#ifdef MISSIONPACK
	x = cgs.screenXmax + 1 - 48;
	y = cgs.screenYmax + 1 - 144;
#else
	x = itm->rect.x;
	y = itm->rect.y;
#endif

	trap_R_SetColor(NULL);

	r.x = x;
	r.y = y;
	r.w = itm->rect.w;
	r.h = itm->rect.h;
	CG_AdjustFrom640(&r.x, &r.y, &r.w, &r.h);

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

	// draw background
	if (itm->shader) {
		shader = CG_HUDShader(itm, cgs.media.lagometerShader);
		CG_DrawPic(x, y, itm->rect.w, itm->rect.h, shader);
	}
	else if (itm->backcolor.colorflags > 0) {
		vec4_t		backcolor;
		HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

		if (itm->shader || itm->propFlags & PROP_FILL)
			trap_R_SetColor(backcolor);

		if (itm->propFlags & PROP_FILL) {
			CG_FillRect(itm->rect.x, itm->rect.y, itm->rect.w, itm->rect.h, backcolor);
		}
	}

	icolor = -1;

	// draw the snapshot latency / drop graph
	range = r.h / 2;
	vscale = range / MAX_LAGOMETER_PING;

	for (a = 0; a < r.w; a++) {
		i = (lagometer.snapshotCount - 1 - a) & (LAG_SAMPLES - 1);
		v = lagometer.snapshotSamples[i];
		if (v > 0) {
			if (lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED) {
				if (icolor != 5) {
					icolor = 5;	// YELLOW for rate delay
					trap_R_SetColor(g_color_table[ColorIndex(COLOR_YELLOW)]);
				}
			}
			else {
				if (icolor != 3) {
					icolor = 3;
					trap_R_SetColor(g_color_table[ColorIndex(COLOR_GREEN)]);
				}
			}
			v = v * vscale;
			if (v > range) {
				v = range;
			}
			trap_R_DrawStretchPic(r.x + r.w - a, r.y + r.h - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
		}
		else if (v < 0) {
			if (icolor != 4) {
				icolor = 4;		// RED for dropped snapshots
				trap_R_SetColor(g_color_table[ColorIndex(COLOR_RED)]);
			}
			trap_R_DrawStretchPic(r.x + r.w - a, r.y + r.h - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader);
		}
	}

	if (!cg.demoPlayback) {
		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		CG_DrawString(x + 1, y, va("%ims", cg.meanPing), forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);// DS_PROPORTIONAL );
	}

	trap_R_SetColor(NULL);

	return;
}

/*
==============
CG_DrawLagometer
==============
*/
static void CG_DrawLagometer(item_t *itm) {
	int		a, x, y, i;
	float	v;
	float	mid, range;
	int		alternateCol;
	float	vscale;
	vec4_t	forecolor;
	float	ax, ay, aw, ah;
	qhandle_t	shader;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	//
	// draw the graph
	//
#ifdef MISSIONPACK
	x = cgs.screenXmax + 1 - 48;
	y = cgs.screenYmax + 1 - 144;
#else
	x = itm->rect.x;
	y = itm->rect.y;
#endif

	trap_R_SetColor(NULL);

	ax = x;
	ay = y;
	aw = itm->rect.w;
	ah = itm->rect.h;
	CG_AdjustFrom640(&ax, &ay, &aw, &ah);

	HUD_Update_finalRect(itm, ax, ay, aw, ah);

	// draw background
	if (itm->shader) {
		shader = CG_HUDShader(itm, cgs.media.lagometerShader);
		CG_DrawPic(x, y, itm->rect.w, itm->rect.h, shader);
	}
	else if (itm->backcolor.colorflags > 0) {
		vec4_t		backcolor;
		HUD_color(itm, &itm->backcolor, &backcolor, colorWhite);

		if (itm->shader || itm->propFlags & PROP_FILL)
			trap_R_SetColor(backcolor);

		if (itm->propFlags & PROP_FILL) {
			CG_FillRect(itm->rect.x, itm->rect.y, itm->rect.w, itm->rect.h, backcolor);
		}
	}

	// draw the frame interpolate / extrapolate graph
	alternateCol = -1;
	range = ah / 3;
	mid = ay + range;

	vscale = range / MAX_LAGOMETER_RANGE;

	for (a = 0; a < aw; a++) {
		i = (lagometer.frameCount - 1 - a) & (LAG_SAMPLES - 1);
		v = lagometer.frameSamples[i];
		v *= vscale;
		if (v > 0) {
			if (alternateCol != 1) {
				alternateCol = 1;
				trap_R_SetColor(g_color_table[ColorIndex(COLOR_YELLOW)]);
			}
			if (v > range) {
				v = range;
			}
			trap_R_DrawStretchPic(ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
		}
		else if (v < 0) {
			if (alternateCol != 2) {
				alternateCol = 2;
				trap_R_SetColor(g_color_table[ColorIndex(COLOR_BLUE)]);
			}
			v = -v;
			if (v > range) {
				v = range;
			}
			trap_R_DrawStretchPic(ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader);
		}
	}

	trap_R_SetColor(NULL);

	if (cg_nopredict.integer || cgs.synchronousClients) {
		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		CG_DrawString(cgs.screenXmax - 1, y, "snc", forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);
	}
}


/*
==============
CG_CenterPrint

Called for important messages that should stay in the center of the screen
for a few moments
==============
*/
void CG_CenterPrint(const char *str, int y, int charWidth, vec4_t color) {
	char	*s;

	Q_strncpyz(cg.centerPrint, str, sizeof(cg.centerPrint));

	cg.centerPrintTime = cg.time;
	cg.centerPrintY = y;
	cg.centerPrintCharWidth = charWidth;

	Vector4Copy(color, cg.centerPrintColor);

	// count the number of lines for centering
	cg.centerPrintLines = 1;
	s = cg.centerPrint;
	while (*s) {
		if (*s == '\n')
			cg.centerPrintLines++;
		s++;
	}
}


/*
=================
CG_DrawCursor
TODO
=================
*/
static void CG_DrawCursor(item_t * itm) {
	return;
}


/*
=================
CG_DrawCrosshair
=================
*/
static void CG_DrawCrosshair(item_t * itm) {
	float		f;
	int			ca;
	qhandle_t	shader;
	rectangle_t r;

	// don't draw if dead or the scoreboard is being explicitly shown
	if (cg.showScores || !cg.snap->ps.stats[STAT_HEALTH] > 0) {
		return;
	}

	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
		return;
	}

	if (cg.renderingThirdPerson /*&& !cg.vr_controller_type*/) {
		return;
	}

	if (!cg_drawCrosshair.integer) {
		return;
	}

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	// set color based on health
	if (cg_crosshairHealth.integer) {
		vec4_t color;
		HUD_color(itm, &itm->backcolor, &color, colorWhite);
		CG_ColorForHealth(color);
		trap_R_SetColor(color);
	}
	else {
		trap_R_SetColor(NULL);
	}

	r = itm->rect;

	if (!r.w && !r.h) {
		r.w = r.h = cg_crosshairSize.value;
	}

	// pulse the size of the crosshair when picking up items
	f = cg.time - cg.itemPickupBlendTime;
	if (f > 0 && f < ITEM_BLOB_TIME) {
		f /= ITEM_BLOB_TIME;
		r.w *= (1 + f);
		r.h *= (1 + f);
	}

	r.x = cg_crosshairX.integer;
	r.y = cg_crosshairY.integer;

	CG_AdjustFrom640(&r.x, &r.y, &r.w, &r.h);

	ca = cg_drawCrosshair.integer;
	if (ca < 0) {
		ca = 0;
	}

	shader = CG_HUDShader(itm, cgs.media.crosshairShader[ca % NUM_CROSSHAIRS]);

	r.x += cg.refdef.x + 0.5 * (cg.refdef.width - r.w) - cgs.screenXBias;
	r.y += cg.refdef.y + 0.5 * (cg.refdef.height - r.h) - cgs.screenYBias;

	trap_R_DrawStretchPic(r.x, r.y, r.w, r.h, 0, 0, 1, 1, shader);

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

	trap_R_SetColor(NULL);
}


/*
=====================
CG_DrawCrosshairNames
=====================
*/
static void CG_DrawCrosshairNames(item_t * itm) {
	const char	*name;
	float		*fadeColor;
	vec4_t		forecolor;
	rectangle_t r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	if (cg.renderingThirdPerson /*&& !cg.vr_controller_type*/) {
		return;
	}

	// scan the known entities to see if the crosshair is sighted on one
	CG_ScanForCrosshairEntity();

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);

	// color and display depend on time
	fadeColor = CG_FadeColor(cg.crosshairClientTime, itm->time, forecolor);
	if (!fadeColor) {
		trap_R_SetColor(NULL);
		return;
	}

	// draw the name of the player being looked at
	name = cgs.clientinfo[cg.crosshairClientNum].name;

#ifdef MISSIONPACK
	forecolor[3] *= 0.5f;
	w = CG_Text_Width(name, 0.3f, 0);
	CG_Text_Paint(320 - w / 2, 190, 0.3f, forecolor, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
#else

	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	CG_DrawString(r.x, r.y, name, fadeColor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);
#endif
	trap_R_SetColor(NULL);

	r.w = itm->fontsize.w * CG_DrawStrlen(name);
	if (itm->text.styleflags & DS_RIGHT)
		r.x -= r.w;
	if (itm->text.styleflags & DS_CENTER)
		r.x -= 0.5f * r.w;
	r.h = itm->fontsize.h;

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}


/*
=================
CG_DrawVote
=================
*/
static void CG_DrawVote(item_t *itm) {
	char		*s;
	int			sec;
	vec4_t		forecolor;
	rectangle_t	r;

	if (!cgs.voteTime) {
		return;
	}

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	// play a talk beep whenever it is modified
	if (cgs.voteModified) {
		cgs.voteModified = qfalse;
		trap_S_StartLocalSound(cgs.media.talkSound, CHAN_LOCAL_SOUND);
	}

	sec = (VOTE_TIME - (cg.time - cgs.voteTime)) / 1000;
	if (sec < 0) {
		sec = 0;
	}
#ifdef MISSIONPACK
	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
	CG_DrawString(cgs.screenXmin - 0, 58, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DF_PROPORTIONAL);
	s = "or press ESC then click Vote";
	CG_DrawString(cgs.screenXmin - 0, 58 + SMALLCHAR_HEIGHT + 2, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DF_PROPORTIONAL);
#else
	r = itm->rect;

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);

	CG_DrawString(r.x, r.y, s, forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

	r.w = itm->fontsize.w * CG_DrawStrlen(s);
	if (itm->text.styleflags & DS_RIGHT)
		r.x -= r.w;
	if (itm->text.styleflags & DS_CENTER)
		r.x -= 0.5f * r.w;
	r.h = itm->fontsize.h;

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
#endif
}


/*
=================
CG_DrawTeamVote
=================
*/
static void CG_DrawTeamVote(item_t *itm) {
	char		*s;
	int			sec;
	vec4_t		forecolor;
	int			cs_offset;
	rectangle_t	r;

	if (cgs.clientinfo[cg.clientNum].team == TEAM_RED)
		cs_offset = 0;
	else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE)
		cs_offset = 1;
	else
		return;

	if (!cgs.teamVoteTime[cs_offset]) {
		return;
	}

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	// play a talk beep whenever it is modified
	if (cgs.teamVoteModified[cs_offset]) {
		cgs.teamVoteModified[cs_offset] = qfalse;
		trap_S_StartLocalSound(cgs.media.talkSound, CHAN_LOCAL_SOUND);
	}

	sec = (VOTE_TIME - (cg.time - cgs.teamVoteTime[cs_offset])) / 1000;
	if (sec < 0) {
		sec = 0;
	}
	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
		cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset]);

	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	CG_DrawString(cgs.screenXmin + r.x, cgs.screenYmin + r.y, s, forecolor,
		itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

	r.w = itm->fontsize.w * CG_DrawStrlen(s);
	if (itm->text.styleflags & DS_RIGHT)
		r.x -= r.w;
	if (itm->text.styleflags & DS_CENTER)
		r.x -= 0.5f * r.w;
	r.h = itm->fontsize.h;

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
}



/*
=================
CG_DrawWarmup
=================
*/
static void CG_DrawWarmupGametype(item_t *itm) {
	int			w;
	int			cw;
	const char	*s;
	vec4_t		forecolor;
	rectangle_t r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	if (cg.warmup < 0) {
		return;
	}

	if (cgs.gametype == GT_FFA) {
		s = "Free For All";
	}
	else if (cgs.gametype == GT_TEAM) {
		s = "Team Deathmatch";
	}
	else if (cgs.gametype == GT_CTF) {
		s = "Capture the Flag";
#ifdef MISSIONPACK
	}
	else if (cgs.gametype == GT_1FCTF) {
		s = "One Flag CTF";
	}
	else if (cgs.gametype == GT_OBELISK) {
		s = "Overload";
	}
	else if (cgs.gametype == GT_HARVESTER) {
		s = "Harvester";
#endif
	}
	else {
		s = "";
	}
#ifdef MISSIONPACK
	w = CG_Text_Width(s, 0.6f, 0);
	CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
	w = CG_DrawStrlen(s);
	if (w > SCREEN_WIDTH / itm->fontsize.w) {
		cw = SCREEN_WIDTH / w;
	}
	else {
		cw = itm->fontsize.w;
	}

	r = itm->rect;
	HUD_Update_Anchors(itm, &r);
	HUD_Update_Margin(itm, &r);

	HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
	CG_DrawString(r.x, r.y, s, forecolor, cw, cw*1.1f, 0, itm->text.styleflags);

	r.w = cw * CG_DrawStrlen(s);
	if (itm->text.styleflags & DS_RIGHT)
		r.x -= r.w;
	if (itm->text.styleflags & DS_CENTER)
		r.x -= 0.5f * r.w;
	r.h = cw * 1.1f;

	HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
#endif
}

static void CG_DrawWarmupVersus(item_t *itm) {
	int			w;
	int			i;
	clientInfo_t *ci1, *ci2;
	int			cw;
	const char	*s;
	vec4_t		forecolor;
	rectangle_t r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	// find the two active players
	ci1 = NULL;
	ci2 = NULL;
	for (i = 0; i < cgs.maxclients; i++) {
		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE) {
			if (!ci1) {
				ci1 = &cgs.clientinfo[i];
			}
			else {
				ci2 = &cgs.clientinfo[i];
			}
		}
	}

	if (ci1 && ci2) {
		s = va("%s vs %s", ci1->name, ci2->name);
#ifdef MISSIONPACK
		w = CG_Text_Width(s, 0.6f, 0);
		CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
		r = itm->rect;
		HUD_Update_Anchors(itm, &r);
		HUD_Update_Margin(itm, &r);

		w = CG_DrawStrlen(s);

		if (w > SCREEN_WIDTH / itm->fontsize.w) {
			cw = SCREEN_WIDTH / w;
		}
		else {
			cw = itm->fontsize.w;
		}

		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		CG_DrawString(r.x, r.y, s, forecolor, cw, cw*1.5, 0, itm->text.styleflags);

		r.w = cw * CG_DrawStrlen(s);
		if (itm->text.styleflags & DS_RIGHT)
			r.x -= r.w;
		if (itm->text.styleflags & DS_CENTER)
			r.x -= 0.5f * r.w;
		r.h = cw * 1.5f;

		HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);

#endif
	}
}


static void CG_DrawWarmupCount(item_t *itm) {
	int			w;
#ifdef MISSIONPACK
	float		scale;
#endif
	int			cw;
	const char	*s;
	vec4_t		forecolor;
	rectangle_t r;

	if (!CG_HUDItemVisible(itm)) {
		return;
	}

	if (cg.warmupCount <= 0)
		return;
	else
	{
		r = itm->rect;

		s = va("Starts in: %i", cg.warmupCount);

		switch (cg.warmupCount) {
		case 1:
			cw = 12;
#ifdef MISSIONPACK
			scale = 0.54f;
#endif
			break;
		case 2:
			cw = 8;
#ifdef MISSIONPACK
			scale = 0.51f;
#endif
			break;
		case 3:
			cw = 4;
#ifdef MISSIONPACK
			scale = 0.48f;
#endif
			break;
		default:
			cw = 0;
#ifdef MISSIONPACK
			scale = 0.45f;
#endif
			break;
		}

		w = itm->fontsize.w + cw;

#ifdef MISSIONPACK
		w = CG_Text_Width(s, scale, 0);
		CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
		HUD_Update_Anchors(itm, &r);
		HUD_Update_Margin(itm, &r);

		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);
		CG_DrawString(r.x, r.y, s, forecolor, w, w * 1.5, 0, itm->text.styleflags);

		r.w = w * CG_DrawStrlen(s);
		if (itm->text.styleflags & DS_RIGHT)
			r.x -= r.w;
		if (itm->text.styleflags & DS_CENTER)
			r.x -= 0.5f * r.w;
		r.h = w * 1.5;

		HUD_Update_finalRect(itm, r.x, r.y, r.w, r.h);
#endif
	}
}

items_keywordHash_t item_Keywords[] = {
	{"itemDef",						CG_Draw_itemDef, 		NULL},
	{"Cursor",						CG_DrawCursor,			NULL},
	{"Crosshair",					CG_DrawCrosshair,		NULL},
	{"CrosshairNames",				CG_DrawCrosshairNames, 	NULL},
	{"WeaponList",					CG_DrawWeaponSelect_H, 	NULL},
	{"WeaponList_Vertical",			CG_DrawWeaponSelect_V, 	NULL},
	{"Reward",						CG_DrawReward, 			NULL},
	{"TeamChat",					CG_DrawTeamInfo, 		NULL},
	{"StatusBar_TeamBar",			CG_DrawTeamBar, 		NULL},
	{"Icon_Flag",					CG_Draw_Icon_Flag, 		NULL},
	{"VoteMessageArena",			CG_DrawVote, 			NULL},
	{"VoteMessageWorld",			CG_DrawTeamVote, 		NULL},
	{"NetGraph",					CG_DrawLagometer, 		NULL},
	{"NetGraphPing",				CG_DrawLagometer_Ping, 	NULL},
	{"TeamOverlay",					CG_DrawTeamOverlay, 	NULL},
	{"WarmupVersus",				CG_DrawWarmupVersus, 	NULL},
	{"WarmupGametype",				CG_DrawWarmupGametype, 	NULL},
	{"warmupCount",					CG_DrawWarmupCount, 	NULL},
	{"Attacker", 					CG_DrawAttacker_name, 	NULL},
	{"Icon_Attacker", 				CG_DrawAttacker_icon, 	NULL},
	{"ItemPickup", 					CG_DrawPickupItem,		NULL},
	{"Icon_ItemPickup", 			CG_DrawPickupItem_Icon,	NULL},
	{"PowerUpCounter", 				CG_DrawPowerups,		NULL},
	{"Score",						CG_DrawScores, 			NULL},
	{"Score_OWN", 					CG_DrawScoreOWN,		NULL},
	{"Score_NME", 					CG_DrawScoreNME,		NULL},
	{"Name_OWN", 					CG_DrawNameOWN,			NULL},
	{"Name_NME", 					CG_DrawNameNME,			NULL},
	{"Flag_OWN", 					CG_DrawFlag_OWN,		NULL},
	{"Flag_NME", 					CG_DrawFlag_NME,		NULL},
	/*
	// CPMA compatibility
	{"PreDecorate",					CG_Draw_itemDef, 		NULL},
	{"PostDecorate",				CG_Draw_itemDef, 		NULL},
	{"StatusBar_HealthBar",			CG_Draw_itemDef, 		NULL},
	{"StatusBar_HealthIcon",		CG_Draw_itemDef, 		NULL},
	{"StatusBar_HealthCount",		CG_Draw_itemDef, 		NULL},
	{"StatusBar_ArmorBar",			CG_Draw_itemDef, 		NULL},
	{"StatusBar_ArmorIcon",			CG_Draw_itemDef, 		NULL},
	{"StatusBar_ArmorCount",		CG_Draw_itemDef, 		NULL},
	{"StatusBar_AmmoCount",			CG_Draw_itemDef, 		NULL},
	{"StatusBar_AmmoIcon",			CG_Draw_itemDef, 		NULL},
	{"AmmoMessage",					CG_Draw_itemDef, 		NULL},
	{"Score_Limit",					CG_Draw_itemDef, 		NULL},
	{"TeamCount_OWN",				CG_Draw_itemDef, 		NULL},
	{"TeamIcon_OWN",				CG_Draw_itemDef, 		NULL},
	{"TeamCount_NME",				CG_Draw_itemDef, 		NULL},
	{"TeamIcon_NME",				CG_Draw_itemDef, 		NULL},
	{"GameTime",					CG_Draw_itemDef, 		NULL},
	{"FlagStatus_OWN", 				CG_DrawFlag_OWN,		NULL},
	{"FlagStatus_NME", 				CG_DrawFlag_NME,		NULL},*/
	{NULL,							NULL,					NULL}
};

item_t itemArray[MAX_HUD_ITEM];
int itemCount;

void CG_ShowResponseHead() {
#ifdef  MISSIONPACK
	Menus_OpenByName("voiceMenu");
	trap_Cvar_Set("cl_conXOffset", "72");
#endif
	cg.voiceTime = cg.time;
}


/*
=================
CG_Draw2D
=================
*/
void CG_Draw2D(stereoFrame_t stereoFrame)
{
	int		i;

#if defined MISSIONPACK || defined NEOHUD
	if (cgs.orderPending && cg.time > cgs.orderTime) {
		CG_CheckOrderPending();
	}
#endif
	// if we are taking a levelshot for the menu, don't draw anything
	if (cg.levelShot) {
		return;
	}

	if (cg_draw2D.integer == 0) {
		return;
	}

	if (cg.snap->ps.pm_type == PM_INTERMISSION) {
		CG_DrawIntermission();
		return;
	}

	/*
		if (cg.cameraMode) {
			return;
		}
	*/

	playerTeam = cg.snap->ps.persistant[PERS_TEAM];

	// load HUD if need
	CG_CheckHUD();

	if (stereoFrame != STEREO_LEFT) {
		FPS = CG_Calcul_FPS();
	}

#ifdef MISSIONPACK
	if (!cg.showScores && cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR) {
		if (cg_drawStatus.integer && cg.snap->ps.stats[STAT_HEALTH] > 0) {
			Menu_PaintAll();
			CG_DrawTimedMenus();

			CG_Draw_Harverster_Armor_Icon
				CG_Draw_Harverster_Armor_Count();
		}
		CG_DrawProxWarning();
		CG_DrawPersistantPowerup();
	}
#endif

	for (i = 0; i < itemCount; i++) {
		itemArray[i].DrawItem(&itemArray[i]);
	}

	// don't draw center string if scoreboard is up
	cg.scoreBoardShowing = CG_DrawScoreboard();
	if (!cg.scoreBoardShowing) {
		CG_DrawCenterString();
	}

	// draw cursor
	if (cgs.score_catched) {
		float x, y, w, h;
		trap_R_SetColor(NULL);
		x = cgs.cursorX - 12;
		y = cgs.cursorY - 12;
		w = 24;
		h = 24;
		CG_AdjustFrom640(&x, &y, &w, &h);
		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, cgs.media.cursor);
	}
	trap_R_SetColor(NULL);// GUNNM TODO check if usefull
}








#endif // NEOHUD
