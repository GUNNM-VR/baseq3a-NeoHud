#include "cg_local.h"
#ifdef NEOHUD

#include "../ui/menudef.h"			// for the voice chats

#define HASH_TABLE_SIZE		2048
#define MEM_POOL_SIZE		128 * 1024 // 1024 * 1024 in UI_GAME
#define KEYWORDHASH_SIZE	512

#define SPEED_SOFT_LIMIT	500
#define HOLDABLE_ITEM_SOFT_LIMIT	60 //GUNNM fixme: find a correct limitt

const char * loadedHUDfilePath;

extern cgs_t cgs;
extern cg_t cg;

vec4_t health_colors[4];
vec4_t armor_colors[4];
vec4_t ammo_colors[4];
vec4_t teams_colors[4];

static char	memoryPool[MEM_POOL_SIZE];
static int	allocPoint, outOfMemory;

int FPS;

// Choose some arbitrary values more realistic
// as weapon soft limit, because AMMO_HARD_LIMIT,
// 200, is too much for most weapons
static int HUD_AmmoSoftLimit(int weapon) {
	switch (weapon)
	{
	case WP_MACHINEGUN:
		return 100;
		break;
	case WP_SHOTGUN:
		return 10;
		break;
	case WP_GRENADE_LAUNCHER:
		return 10;
		break;
	case WP_ROCKET_LAUNCHER:
		return 10;
		break;
	case WP_LIGHTNING:
		return 100;
		break;
	case WP_RAILGUN:
		return 20;
		break;
	case WP_PLASMAGUN:
		return 50;
		break;
	case WP_BFG:
		return 20;
		break;
#ifdef MISSIONPACK
		//TODO check values in Mission Pack
	case WP_NAILGUN:
		return 100;
		break;
	case WP_PROX_LAUNCHER:
		return 100;
		break;
	case WP_CHAINGUN:
		return 100;
		break;
#endif
	case WP_NONE:
	case WP_GRAPPLING_HOOK:
	case WP_GAUNTLET:
	default:
		return 0;
		break;
	}
}

//get soft limit for Health | Armor | Ammo | Weapon | Score | Time | HoldableItem | FPS | Speed | Fraglimit | Timelimit
//in order to draw a gradient texture, or select according color
static int HUD_SoftLimit(int property, int param) {
	switch (property)
	{
	case VAL_HEALTH:
		return cg.snap->ps.stats[STAT_MAX_HEALTH];
	case VAL_ARMOR:
		return cg.snap->ps.stats[STAT_MAX_HEALTH];
	case VAL_AMMO:
	{
		// AMMO_HARD_LIMIT (200) is too much for most weapons
		centity_t *cent = &cg_entities[cg.snap->ps.clientNum];
		int weapon = cent->currentState.weapon;
		return HUD_AmmoSoftLimit(weapon);
	}
	case VAL_WEAPON:
		return HUD_AmmoSoftLimit(param);
	case VAL_SCORE:
	case VAL_CAPFRAG_LIMIT:
		return (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
	case VAL_FRAG_LIMIT:
		return cgs.fraglimit;
	case VAL_CAPTURE_LIMIT:
		return cgs.capturelimit;
	case VAL_TIMER:
	case VAL_TIME_LIMIT:
		return cgs.timelimit;
	case VAL_HOLDABLE_ITEM:
		return HOLDABLE_ITEM_SOFT_LIMIT;
	case VAL_FPS:
	{
		//int com_maxfps = Cvar_Get( "com_maxfps", "125", 0 );
		//return com_maxfps; //GUNNM TODO
		return 240;
	}
	case VAL_SPEED:
		return SPEED_SOFT_LIMIT;
	case VAL_PLAYERS_NB_TEAM:
		return TEAM_MAXOVERLAY; //MAX_CLIENTS; //not really TEAM_MAXOVERLAY. What is the maximum player in a team?
	//those are string, so return 0
	case VAL_FOLLOW_NAME:
	case VAL_SNAPSHOT:
	case VAL_LOCATION:
	default:
		return 0;
	}
}

static int GetTeamPlayerstat(item_t *itm, statIndex_t STAT_X) {
	if (itm->propFlags & PROP_TEAM_PLAYER) {
		if (!itm->team_player) {
			return cg.snap->ps.stats[STAT_X];
		}
		if (itm->team_player < 0) {
			if (cg_currentSelectedPlayer.integer == cg.snap->ps.clientNum)
				return cg.snap->ps.stats[STAT_X];
			else {
				// for team players
				clientInfo_t	*ci;
				ci = &cgs.clientinfo[cg_currentSelectedPlayer.integer];
				if (STAT_X == STAT_ARMOR)
					return ci->armor;
				else if (STAT_X == STAT_HEALTH)
					return ci->health;
			}
		}
		else if (itm->team_player >= 1) {
			// if a team player is explicitely asked
			clientInfo_t	*ci;
			ci = &cgs.clientinfo[itm->team_player];
			if (STAT_X == STAT_ARMOR)
				return ci->armor;
			else if (STAT_X == STAT_HEALTH)
				return ci->health;
		}
	}
	return cg.snap->ps.stats[STAT_X];
}

static int CG_getScore(int param) {
	// Red score
	if (param == 1) {
		return cgs.scores1;
	}
	// Blue score
	else if (param == 2) {
		return cgs.scores2;
	}
	// Enemy score
	else if (param == 3) {
		if (cg.snap->ps.persistant[PERS_SCORE] == cgs.scores1)
			return cgs.scores2;
		else
			return cgs.scores1;
	}
	// Player score	
	else {
		return cg.snap->ps.persistant[PERS_SCORE];
	}
}

static int CG_getPleayersNumber(int param) {
	int nbPlyr = cg.numScores;//this is surely not the better way of having opposite team member. 

	int team = cg.snap->ps.persistant[PERS_TEAM];
	// Red team players number
	if (param == 1) {
		if (team == TEAM_RED)
			return numSortedTeamPlayers;
		else if (nbPlyr <= 0)
			return 0;
		else
			return nbPlyr - numSortedTeamPlayers;
	}
	// Blue team players number
	else if (param == 2) {
		if (team == TEAM_BLUE)
			return numSortedTeamPlayers;
		else if (nbPlyr <= 0)
			return 0;
		else
			return nbPlyr - numSortedTeamPlayers;
	}
	// Opposing team players number
	else if (param == 3) {
		if (nbPlyr <= 0)
			return 0;
		else if (cgs.gametype < GT_TEAM)
			return nbPlyr - 1;
		else
			return nbPlyr - numSortedTeamPlayers;
	}
	// Own team players number	
	else {
		if (cgs.gametype < GT_TEAM)
			return 1;
		else
			return numSortedTeamPlayers;
	}
}

static int CG_getTimer( void ) {
	int msec, seconds;
	msec = cg.time - cgs.levelStartTime;
	seconds = msec / 1000;
	return seconds;
}

static int CG_getAmmo( void ) {
	centity_t *cent;
	cent = &cg_entities[cg.snap->ps.clientNum];
	if (cent->currentState.weapon) {
		return cg.snap->ps.ammo[cent->currentState.weapon];
	}
	return 0;
}

//get value for Health | Armor | Ammo | Weapon | Score | Time | HoldableItem | FPS | Speed | Fraglimit | Timelimit
static int HUD_PropValue(item_t *itm, int oneFlag, int param) {
	switch (oneFlag)
	{
	case VAL_HEALTH:
		return GetTeamPlayerstat(itm, STAT_HEALTH);
	case VAL_ARMOR:
		return GetTeamPlayerstat(itm, STAT_ARMOR);
	case VAL_AMMO:
		return CG_getAmmo();
	case VAL_WEAPON:
		return cg.snap->ps.ammo[param];
	case VAL_SCORE:
		return CG_getScore(param);
	case VAL_PLAYERS_NB_TEAM:
		return CG_getPleayersNumber(param);
	case VAL_TIMER:
		return CG_getTimer();
	case VAL_HOLDABLE_ITEM:
		return cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
	case VAL_FPS:
		return FPS;
	case VAL_SPEED:
		return (int)cg.xyspeed;
	case VAL_CAPFRAG_LIMIT:
		return (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
	case VAL_FRAG_LIMIT:
		return cgs.fraglimit;
	case VAL_CAPTURE_LIMIT:
		return cgs.capturelimit;
	case VAL_TIME_LIMIT:
		//seconds only
		return ((cgs.timelimit) * 60);
	// those are string
	case VAL_LOCATION:
	case VAL_FOLLOW_NAME:
	case VAL_SNAPSHOT:
		return 0;
	default:
		return 0;
	}
}

int HUD_ItemCaptionValue(item_t *itm) {

	if (itm->propFlags & PROP_TEAM_PLAYER) {
		clientInfo_t *ci;
		int clientNum;

		if (itm->propFlags & PROP_TEAM_PLAYER) {
			if (!itm->team_player)
				clientNum = cg.snap->ps.clientNum;
			else if (itm->team_player < 0) {
				clientNum = cg_currentSelectedPlayer.integer;
			}
			else if (itm->team_player >= 1) {
				clientNum = itm->team_player;
			}
		}
		ci = cgs.clientinfo + sortedTeamPlayers[clientNum];

		if (ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
			if (itm->text.flags & VAL_HEALTH)		return ci->health;
			else if (itm->text.flags & VAL_ARMOR)	return ci->armor;
		}
	}

	if (itm->text.flags & VAL_HEALTH)				return HUD_PropValue(itm, VAL_HEALTH, itm->param);
	else if (itm->text.flags & VAL_FPS)				return HUD_PropValue(itm, VAL_FPS, itm->param);
	else if (itm->text.flags & VAL_ARMOR)			return HUD_PropValue(itm, VAL_ARMOR, itm->param);
	else if (itm->text.flags & VAL_AMMO)			return HUD_PropValue(itm, VAL_AMMO, itm->param);
	else if (itm->text.flags & VAL_WEAPON)			return HUD_PropValue(itm, VAL_WEAPON, itm->param);
	else if (itm->text.flags & VAL_SCORE)			return HUD_PropValue(itm, VAL_SCORE, itm->param);
	else if (itm->text.flags & VAL_TIMER)			return HUD_PropValue(itm, VAL_TIMER, itm->param);
	else if (itm->text.flags & VAL_SPEED)			return HUD_PropValue(itm, VAL_SPEED, itm->param);
	else if (itm->text.flags & VAL_CAPFRAG_LIMIT)	return HUD_PropValue(itm, VAL_CAPFRAG_LIMIT, itm->param);
	else if (itm->text.flags & VAL_FRAG_LIMIT)		return HUD_PropValue(itm, VAL_FRAG_LIMIT, itm->param);
	else if (itm->text.flags & VAL_CAPTURE_LIMIT)	return HUD_PropValue(itm, VAL_CAPTURE_LIMIT, itm->param);
	else if (itm->text.flags & VAL_TIME_LIMIT)		return HUD_PropValue(itm, VAL_TIME_LIMIT, itm->param);
	else if (itm->text.flags & VAL_HOLDABLE_ITEM)	return HUD_PropValue(itm, VAL_HOLDABLE_ITEM, itm->param);
	else if (itm->text.flags & VAL_PLAYERS_NB_TEAM)	return HUD_PropValue(itm, VAL_PLAYERS_NB_TEAM, itm->param);
	// Those are string, no need to send them
	//else if (itm->text.flags & VAL_FOLLOW_NAME)	return HUD_PropValue(itm, VAL_FOLLOW_NAME, itm->param);
	//else if (itm->text.flags & VAL_SNAPSHOT)		return HUD_PropValue(itm, VAL_SNAPSHOT, itm->param);
	//else if (itm->text.flags & VAL_LOCATION)		return HUD_PropValue(itm, VAL_LOCATION, itm->param);
	else return 0;
}

static int HUD_ItemSoftLimit(item_t *itm) {
	if (itm->text.flags & VAL_HEALTH)				return HUD_SoftLimit(VAL_HEALTH, itm->param);
	else if (itm->text.flags & VAL_FPS)				return HUD_SoftLimit(VAL_FPS, itm->param);
	else if (itm->text.flags & VAL_ARMOR)			return HUD_SoftLimit(VAL_ARMOR, itm->param);
	else if (itm->text.flags & VAL_AMMO)			return HUD_SoftLimit(VAL_AMMO, itm->param);
	else if (itm->text.flags & VAL_WEAPON)			return HUD_SoftLimit(VAL_WEAPON, itm->param);
	else if (itm->text.flags & VAL_SCORE)			return HUD_SoftLimit(VAL_SCORE, itm->param);
	else if (itm->text.flags & VAL_TIMER)			return HUD_SoftLimit(VAL_TIMER, itm->param);
	else if (itm->text.flags & VAL_SPEED)			return HUD_SoftLimit(VAL_SPEED, itm->param);
	else if (itm->text.flags & VAL_CAPFRAG_LIMIT)	return HUD_SoftLimit(VAL_CAPFRAG_LIMIT, itm->param);
	else if (itm->text.flags & VAL_FRAG_LIMIT)		return HUD_SoftLimit(VAL_FRAG_LIMIT, itm->param);
	else if (itm->text.flags & VAL_CAPTURE_LIMIT)	return HUD_SoftLimit(VAL_CAPTURE_LIMIT, itm->param);
	else if (itm->text.flags & VAL_TIME_LIMIT)		return HUD_SoftLimit(VAL_TIME_LIMIT, itm->param);
	else if (itm->text.flags & VAL_HOLDABLE_ITEM)	return HUD_SoftLimit(VAL_HOLDABLE_ITEM, itm->param);
	else if (itm->text.flags & VAL_PLAYERS_NB_TEAM)	return HUD_SoftLimit(VAL_PLAYERS_NB_TEAM, itm->param);
	//else if (itm->text.flags & VAL_FOLLOW_NAME)	return HUD_SoftLimit(VAL_FOLLOW_NAME, itm->param);
	//else if (itm->text.flags & VAL_SNAPSHOT)		return HUD_SoftLimit(VAL_SNAPSHOT, itm->param);
	//else if (itm->text.flags & VAL_LOCATION)		return HUD_SoftLimit(VAL_LOCATION, itm->param);
	else return 0;
}

static qboolean cvarTest(int flag) {
	if (flag & CV_cg_drawStatus			&& !cg_drawStatus.integer)			return qfalse;
	if (flag & CV_cg_drawWeaponSelect	&& !cg_drawWeaponSelect.integer)	return qfalse;//without the ! ?
	if (flag & CV_cg_drawAttacker		&& !cg_drawAttacker.integer)		return qfalse;
	if (flag & CV_cg_drawTeamOverlay	&& !cg_drawTeamOverlay.integer)		return qfalse;
	if (flag & CV_cg_drawCrosshairNames && !cg_drawCrosshairNames.integer)	return qfalse;
	if (flag & CV_cg_drawIcons			&& !cg_drawIcons.integer)			return qfalse;
	if (flag & CV_cg_draw3dIcons		&& !cg_draw3dIcons.integer)			return qfalse;
	if (flag & CV_cg_drawFPS			&& !cg_drawFPS.integer)				return qfalse;
	if (flag & CV_cg_drawSpeed			&& !cg_drawSpeed.integer)			return qfalse;
	if (flag & CV_cg_drawTimer			&& !cg_drawTimer.integer)			return qfalse;
	if (flag & CV_cg_lagometer			&& !cg_lagometer.integer)			return qfalse;
	if (flag & CV_cg_drawPing			&& !cg_drawPing.integer)			return qfalse;
	if (flag & CV_cg_drawSnapshot		&& !cg_drawSnapshot.integer)		return qfalse;
	if (flag & CV_cg_drawStatus			&& !cg_drawStatus.integer)			return qfalse;
	if (flag & CV_cg_drawRewards		&& !cg_drawRewards.integer)			return qfalse;
	if (flag & CV_cg_drawAmmoWarning	&& !cg_drawAmmoWarning.integer)		return qfalse;
	if (flag & CV_cg_drawCrosshair		&& !cg_drawCrosshair.integer)		return qfalse;
	return qtrue;
}

// Allow the drawing of the phone jack
// if we are completely past our buffers
qboolean isDisconnect() {
	int			cmdNum;
	usercmd_t	cmd;
	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
	trap_GetUserCmd(cmdNum, &cmd);
	if (cmd.serverTime <= cg.snap->ps.commandTime
		|| cmd.serverTime > cg.time) {	// special check for map_restart // bk 0102165 - FIXME
		return qtrue;
	}
	return qfalse;
}

static qboolean check_vis_gen_cases(const unsigned int visArray[2], int arrayIdx) {
	qboolean isCFT, inMenu;
	int flags = visArray[arrayIdx];

	qboolean visible = (arrayIdx == 0);

	// never show item
	if (visible && flags & VIS_NEVER)	return qfalse;

	//showScores
	if (cg.showScores) {
		if (visible && !(flags & VIS_IN_SCORE))	return qfalse;
		if (!visible && flags & VIS_IN_SCORE)	return qfalse;
	}

	//inMenu
	inMenu = (cg.snap->ps.eFlags & EF_TALK);
	if (inMenu) {
		//if (visible && !(flags & VIS_IN_MENU))	return qfalse; // deactivated: easier to choose a HUD file
		if (!visible && (flags & VIS_IN_MENU))		return qfalse;
	}

	//follow
	if (flags & VIS_PMF_FOLLOW) {
		if (visible && !(cg.snap->ps.pm_flags & PMF_FOLLOW))	return qfalse;
		if (!visible && cg.snap->ps.pm_flags & PMF_FOLLOW)		return qfalse;
	}

	//low ammo
	if (flags & VIS_LOW_AMMO_WARNING) {
		if (visible && !(cg.lowAmmoWarning == 1))						return qfalse;
		if (!visible && cg.lowAmmoWarning && cg.lowAmmoWarning != 2)	return qfalse;
	}

	// out of ammo
	if (flags & VIS_OUT_OF_AMMO) {
		if (visible && !(cg.lowAmmoWarning == 2))						return qfalse;
		if (!visible && cg.lowAmmoWarning && cg.lowAmmoWarning == 2)	return qfalse;
	}

	//warmup
	if (flags & VIS_WARMUP) {
		if (visible && !(cg.warmup))	return qfalse;
		if (!visible && cg.warmup)		return qfalse;
	}

	// local server
	if (flags & VIS_LOCAL_SERVER) {
		if (visible && !cgs.localServer)	return qfalse;
		if (!visible && cgs.localServer)	return qfalse;
	}

	// disconnect
	if (flags & VIS_DISCONNECTED) {
		if (visible && isDisconnect())		return qfalse;
		if (!visible && !isDisconnect())	return qfalse;
	}

	//blink the 'Connection Interrupted' message & icon
	if (flags & VIS_BLINK) {
		if (visible && (cg.time >> 9) & 1)		return qfalse;
		if (!visible && !((cg.time >> 9) & 1))	return qfalse;
	}

	//powerup
	if (flags & VIS_POWERUP_1) {
		if (visible && !cg.snap->ps.powerups[1])	return qfalse;
		if (!visible && cg.snap->ps.powerups[1])	return qfalse;
	}

	//ItemPickup really worked
	if (flags & VIS_PICKUP_ITEM) {
		if (visible && !cg.itemPickup)	return qfalse;
		if (!visible && cg.itemPickup)	return qfalse;
	}

	//firing
	if (flags & VIS_FIRING) {
		if (visible && !(cg.snap->ps.eFlags & EF_FIRING))	return qfalse;
		if (!visible && cg.snap->ps.eFlags & EF_FIRING)		return qfalse;
	}

	// VIS_BLUE_FLAG_TAKEN
	isCFT = (cgs.gametype == GT_CTF);
#ifdef MISSIONPACK
	isCFT = (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF)
#endif

	if (isCFT && (flags & VIS_BLUE_FLAG_TAKEN)) {
		if (visible && !cgs.blueflag)	return qfalse; // blue flag is not at base
		if (!visible && cgs.blueflag)	return qfalse; // blue flag at base
	}

	// VIS_RED_FLAG_TAKEN
	if (isCFT && (flags & VIS_RED_FLAG_TAKEN)) {
		if (visible && !cgs.redflag)	return qfalse; // red flag is not at base
		if (!visible && cgs.redflag)	return qfalse; // red flag at base
	}

	return qtrue;
}

static qboolean check_vis_GT_cases(const unsigned int visArray[2], int arrayIdx) {
	qboolean solo, isCFT;
	int team;
	int flags = visArray[arrayIdx];

	qboolean visible = (arrayIdx == 0);

	// check game type
	solo = (cgs.gametype < GT_TEAM);
	if (flags & VIS_TEAM_PLAY) {
		if (visible && solo)	return qfalse;
		if (!visible && !solo)	return qfalse;
	}

	// blue team
	team = cg.snap->ps.persistant[PERS_TEAM];
	if (flags & VIS_TEAM_BLUE) {
		if (visible && team != TEAM_BLUE)	return qfalse;
		if (!visible && team == TEAM_BLUE)	return qfalse;
	}

	// red team
	if (flags & VIS_TEAM_RED) {
		if (visible && team != TEAM_RED)	return qfalse;
		if (!visible && team == TEAM_RED)	return qfalse;
	}

	//spectator team
	if (flags & VIS_TEAM_SPECTATOR) {
		if (visible && team != TEAM_SPECTATOR)	return qfalse;
		if (!visible && team == TEAM_SPECTATOR)	return qfalse;
	}

	// in a team (bue or red)
	if (flags & VIS_TEAM_BLUE_OR_RED) {
		if (visible && (team != TEAM_BLUE && team != TEAM_RED))	 return qfalse;
		if (!visible && (team == TEAM_BLUE || team == TEAM_RED)) return qfalse;
	}

	//Tournament
	if (flags & VIS_GT_TOURNAMENT) {
		if (visible && cgs.gametype != GT_TOURNAMENT)	return qfalse;
		if (!visible && cgs.gametype == GT_TOURNAMENT)	return qfalse;
	}

	//free for all
	if (flags & VIS_GT_FFA) {
		if (visible && cgs.gametype != GT_FFA)	return qfalse;
		if (!visible && cgs.gametype == GT_FFA)	return qfalse;
	}

	//team deathmatch
	if (flags & VIS_GT_TDM) {
		if (visible && cgs.gametype != GT_TEAM)		return qfalse;
		if (!visible && cgs.gametype == GT_TEAM)	return qfalse;
	}

	//capture the flag
	isCFT = (cgs.gametype == GT_CTF);
#ifdef MISSIONPACK
	isCFT = (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF)
#endif

	if (flags & VIS_GT_CTF) {
		if (visible && !isCFT)	return qfalse;
		if (!visible && isCFT)	return qfalse;
	}

	//Obelisk
#ifdef MISSIONPACK
	if (flags & VIS_GT_OBELISK) {
		if (visible && cgs.gametype != GT_OBELISK)	return qfalse;
		if (!visible && cgs.gametype == GT_OBELISK)	return qfalse;
	}

	//Harvester
	if (flags & VIS_GT_HARVESTER) {
		if (visible && cgs.gametype != GT_HARVESTER)	return qfalse;
		if (!visible && cgs.gametype == GT_HARVESTER)	return qfalse;
	}
#endif

//GUNNM TODO
/*
	if (flags & VIS_GT_FREEZE) {
		if (visible && cgs.gametype != GT_FREEZE)	return qfalse;
		if (!visible && cgs.gametype == GT_FREEZE)	return qfalse;
	}
*/
	if (flags & VIS_SHOW_TEAMINFO) {
		qboolean teamInfo = (cg_currentSelectedPlayer.integer == numSortedTeamPlayers);
		if (visible && !teamInfo)	return qfalse;
		if (!visible && teamInfo)	return qfalse;
	}

#ifdef MISSIONPACK
	if (flags & CG_SHOW_IF_PLAYER_HAS_FLAG) {
		if (visible && !(cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]))	return qfalse;
		if (!visible && (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]))	return false;
	}
#endif
	return qtrue;
}

static qboolean check_vis_val_cases(const unsigned int visArray[2], int arrayIdx, const int param) {
	int flags = visArray[arrayIdx];

	qboolean visible = (arrayIdx == 0);

	//health
	if (flags & VAL_HEALTH) {
		if (visible  && !(cg.snap->ps.stats[STAT_HEALTH]))	return qfalse;
		if (!visible && (cg.snap->ps.stats[STAT_HEALTH]))	return qfalse;
	}

	//armor
	if (flags & VAL_ARMOR) {
		if (visible && !(cg.snap->ps.stats[STAT_ARMOR]))	return qfalse;
		if (!visible && (cg.snap->ps.stats[STAT_ARMOR]))	return qfalse;
	}

	//holdable item
	if (flags & VAL_HOLDABLE_ITEM) {
		if (visible && !(cg.snap->ps.stats[STAT_HOLDABLE_ITEM]))	return qfalse;
		if (!visible && !(cg.snap->ps.stats[STAT_HOLDABLE_ITEM]))	return qfalse;
	}

	//weapon
	if (flags & VAL_WEAPON) { // param: WeaponNb
		if (visible && !(cg.snap->ps.ammo[param]))	return qfalse;
		if (!visible && (cg.snap->ps.ammo[param]))	return qfalse;
	}

	//speed
	if (flags & VAL_SPEED) {
		if (visible && !((int)cg.xyspeed))	return qfalse;
		if (!visible && ((int)cg.xyspeed))	return qfalse;
	}

	//time limit
	if (flags & VAL_TIME_LIMIT) {
		if (visible && !(cgs.timelimit > 0))	return qfalse;
		if (!visible && (cgs.timelimit > 0))	return qfalse;
	}

	//frag limit
	if (flags & VAL_FRAG_LIMIT) {
		if (visible && !(cgs.fraglimit))	return qfalse;
		if (!visible && (cgs.fraglimit))	return qfalse;
	}

	//capture limit
	if (flags & VAL_CAPTURE_LIMIT) {
		if (visible && !(cgs.capturelimit))	return qfalse;
		if (!visible && (cgs.capturelimit))	return qfalse;
	}

	//capture limit / frag limit depending of game type
	if (flags & VAL_CAPFRAG_LIMIT) {
		int slimit = (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
		if (visible && !slimit)	return qfalse;
		if (!visible && slimit)	return qfalse;
	}

	// selected Weapon ammo
	if (flags & VAL_AMMO) {
		centity_t *cent = &cg_entities[cg.snap->ps.clientNum];
		if (visible && (!cent->currentState.weapon || !cg.snap->ps.ammo[cent->currentState.weapon]))	return qfalse;
		if (!visible && cent->currentState.weapon && cg.snap->ps.ammo[cent->currentState.weapon])		return qfalse;
	}

	// those visibility flags would make no sense
	/*if (flags & VAL_SCORE ||
		flags & VAL_TIMER ||
		flags & VAL_FPS ||
		flags & VAL_SNAPSHOT ||
		flags & VAL_FOLLOW_NAME ||
		flags & VAL_LOCATION) {
		return qtrue;
	}*/
	return qtrue;
}

static qboolean check_vis_teamPlayer_cases(const unsigned int visArray[2], int arrayIdx, const int param) {
	int flags = visArray[arrayIdx];

	qboolean visible = (arrayIdx == 0);
	int clientNum;

	//visibility flags of team player related item
	//if (visible && !(flags & VIS_TEAM_PLAYER)/* && (flags & VIS_TEAM_PLAYER)*/)	return qtrue;
	//if (!visible && (flags & VIS_TEAM_PLAYER))	return qtrue;//not usefull
	//if (visible && (flags & VIS_TEAM_PLAYER) && (cgs.gametype < GT_TEAM)) return qfalse;

	if (visible && (flags & VIS_TEAM_PLAYER)) {
		if (cgs.gametype < GT_TEAM) return qfalse;

		if (!param)
			clientNum = cg.snap->ps.clientNum;
		else if (param < 0)
			clientNum = cg_currentSelectedPlayer.integer;
		else if (param >= 1)
			clientNum = param;

		if (sortedTeamPlayers[clientNum] == cg.snap->ps.clientNum)
			return qfalse;
		else {
			clientInfo_t *ci;
			ci = cgs.clientinfo + sortedTeamPlayers[clientNum];
			if (!ci || !ci->infoValid)
				return qfalse;
		}
	}
	return qtrue;
}

// items in the HUD file are visible, unless specified
qboolean CG_HUDItemVisible(const item_t * itm) {
	if (itm->visible_prop_flags[0] & VIS_NEVER) {
		return qfalse;
	}
	else {
		// 0: visible cases / 1: hidden cases

		// general visibility flags
		if (!check_vis_gen_cases(itm->visible_prop_flags, 0))	return qfalse;
		if (!check_vis_gen_cases(itm->visible_prop_flags, 1))	return qfalse;

		// team play visibility flags
		if (!check_vis_GT_cases(itm->visible_GT_flags, 0))	return qfalse;
		if (!check_vis_GT_cases(itm->visible_GT_flags, 1))	return qfalse;

		// value visibility flags
		if (!check_vis_val_cases(itm->visible_val_flags, 0, itm->param))	return qfalse;
		if (!check_vis_val_cases(itm->visible_val_flags, 1, itm->param))	return qfalse;

		// team player item visibility
		if (!check_vis_teamPlayer_cases(itm->visible_GT_flags, 0, itm->team_player))	return qfalse;
		//if (!check_vis_teamPlayer_cases(itm->visible_GT_flags, 1, itm->team_player))	return qfalse;

		if (!cvarTest(itm->cvarTest_flags))
			return qfalse;
	}
	return qtrue;
}

// TODO create a ratio score1 / score2 depending of itm->param
float createScoreRatio(int param) {
	// player's score, or player team
	if (param == 1) {
		return (cgs.scores1 > cgs.scores2) ? 1.0f : 0.0f;
	}
	// other's score
	else if (param == 2) {
		return (cgs.scores2 > cgs.scores1) ? 1.0f : 0.0f;
	}
	return 1.0f;
}

//get gradient value for Health | Armor | Ammo | Weapon | Score | Time | HoldableItem | FPS | Speed | Fraglimit | Timelimit
float HUD_GradientValue(item_t *itm) {
	if (itm->gradientFlags & VAL_HEALTH) {
		int				health;
		int				maxHealth;
		health = HUD_PropValue(itm, VAL_HEALTH, itm->param);
		maxHealth = HUD_SoftLimit(VAL_HEALTH, itm->param);
		if (itm->param == 2) {
			// show health below the soft limit
			if (health > maxHealth)
				return ((float)(health - maxHealth) / (float)maxHealth);
			else
				return 0;
		}
		else {
			// show health above the soft limit
			if (health > maxHealth)
				return 1.0f;
			else
				return ((float)health / (float)maxHealth);
		}
	}
	else if (itm->gradientFlags & VAL_ARMOR) {
		int				armor;
		int				maxHealth;
		armor = HUD_PropValue(itm, VAL_ARMOR, itm->param);
		maxHealth = HUD_SoftLimit(VAL_ARMOR, itm->param);

		if (itm->param == 2) {
			// show health below the soft limit
			if (armor > maxHealth)
				return ((float)(armor - maxHealth) / (float)maxHealth);
			else
				return 0;
		}
		else {
			// show health above the soft limit
			if (armor > maxHealth)
				return 1.0f;
			else
				return ((float)armor / (float)maxHealth);
		}
	}
	else if (itm->gradientFlags & VAL_AMMO) {
		int				weapon;
		int				ammoSoftLimit;
		weapon = HUD_PropValue(itm, VAL_AMMO, itm->param);
		ammoSoftLimit = HUD_AmmoSoftLimit(weapon);
		if (ammoSoftLimit > 0) {
			return (float)weapon / (float)ammoSoftLimit;
		}
	}
	else if (itm->gradientFlags & VAL_WEAPON) {
		int				weapon;
		int				ammoSoftLimit;
		weapon = HUD_PropValue(itm, VAL_WEAPON, itm->param);
		ammoSoftLimit = HUD_AmmoSoftLimit(weapon);
		if (ammoSoftLimit>0) {
			return (float)weapon / (float)ammoSoftLimit;
		}
	}
	else if (itm->gradientFlags & VAL_SCORE || itm->gradientFlags & VAL_CAPFRAG_LIMIT) {
		int slimit = (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
		if (slimit > 0) {
			int itmVal = HUD_PropValue(itm, VAL_SCORE, itm->param);
			return (float)itmVal / (float)slimit;
		}
		else {
			return createScoreRatio(itm->param);
		}
	}

	else if (itm->gradientFlags & VAL_FRAG_LIMIT) {
		if (cgs.fraglimit > 0) {
			return (float)cg.snap->ps.persistant[PERS_SCORE] / (float)cgs.fraglimit;
		}
		else {
			return createScoreRatio(itm->param);
		}
	}
	else if (itm->gradientFlags & VAL_CAPTURE_LIMIT) {
		if (cgs.fraglimit > 0) {
			return (float)cg.snap->ps.persistant[PERS_SCORE] / (float)cgs.capturelimit;
		}
		else {
			return createScoreRatio(itm->param);
		}
	}

	else if (itm->gradientFlags & VAL_TIMER || itm->gradientFlags & VAL_TIME_LIMIT) {
		if (cgs.timelimit > 0) {
			int time_sec;
			int timelimit_secs;
			time_sec = HUD_PropValue(itm, VAL_TIMER, itm->param);
			timelimit_secs = HUD_PropValue(itm, VAL_TIME_LIMIT, itm->param);
			return (float)time_sec / (float)timelimit_secs;
		}
		else {
			return 1;
		}
	}
	else if (itm->gradientFlags & VAL_HOLDABLE_ITEM) {
		return (float)HUD_PropValue(itm, VAL_HOLDABLE_ITEM, itm->param) / (float)HOLDABLE_ITEM_SOFT_LIMIT;
	}
	else if (itm->gradientFlags & VAL_FPS) {
		return (float)FPS / (float)HUD_SoftLimit(VAL_FPS, itm->param);
	}
	else if (itm->gradientFlags & VAL_SPEED) {
		return cg.xyspeed / (float)SPEED_SOFT_LIMIT;
	}
	return 1.0f;
}

static int HUD_ColorIdx(item_t *itm, int value) {
	int	col_id;
	int softLimit;

	if (!(itm->forecolor.colorflags & C_COLOR_RGBA) ) {

		softLimit = HUD_ItemSoftLimit(itm);

		if (value > softLimit - 1) {
			col_id = 3; // white
		}
		else if (value > (softLimit / 4)) {
			col_id = 0; // yellow
		}
		else if (value > 0) {
			if (itm->propFlags & PROP_BLINK_WHEN_LOW) {
				col_id = ((cg.time >> 8) & 1) ? 1 : 0; // red / yellow flashing
			}
			else
				col_id = 1; // red
		}
		else {
			col_id = 1; // red
		}
	}
	return col_id;
}

void copyColor(vec4_t colSource, vec4_t *colDest) {
	(*colDest)[0] = colSource[0];
	(*colDest)[1] = colSource[1];
	(*colDest)[2] = colSource[2];
	(*colDest)[3] = colSource[3];
}

void HUD_color(item_t *itm, color_Def_t *colDef, vec4_t *colDest, vec4_t defaultCol) {
	if (colDef->colorflags & C_COLOR_RGBA) {
		copyColor(colDef->color, colDest);
	}
	else {
		if (colDef->colorflags & C_COLORS_HEALTH || colDef->colorflags & C_COLORS_ARMOR ||
			colDef->colorflags & C_COLORS_AMMO || colDef->colorflags & C_COLORS_TEAMS) {
			int value = HUD_ItemCaptionValue(itm);
			int idx = HUD_ColorIdx(itm, value);
			if (colDef->colorflags & C_COLORS_HEALTH) {
				copyColor(health_colors[idx], colDest);
			}
			else if (colDef->colorflags & C_COLORS_ARMOR) {
				copyColor(armor_colors[idx], colDest);
			}
			else if (colDef->colorflags & C_COLORS_AMMO) {
				copyColor(ammo_colors[idx], colDest);
			}
			else if (colDef->colorflags & C_COLORS_TEAMS) {
				copyColor(teams_colors[idx], colDest);
			}
		}
		else if (colDef->colorflags & C_COLOR_TEAM) {
			copyColor(teams_colors[playerTeam], colDest);
		}
		else if (colDef->colorflags & C_COLOR_BLUE_TEAM) {
			copyColor(teams_colors[HUD_TEAM_BLUE], colDest);
		}
		else if (colDef->colorflags & C_COLOR_RED_TEAM) {
			copyColor(teams_colors[HUD_TEAM_RED], colDest);
		}
		else if (colDef->colorflags & C_COLOR_NME) {
			// use opposite team color
			if (playerTeam == HUD_TEAM_RED) {
				copyColor(teams_colors[HUD_TEAM_BLUE], colDest);
			}
			else {
				copyColor(teams_colors[HUD_TEAM_RED], colDest);
			}
		}
		else {
			copyColor(defaultCol, colDest);
		}

		if (/*colDef->colorflags & C_COLOR_FORCE_ALPHA*/ colDef->alpha)
			(*colDest)[3] = colDef->alpha;
	}
}

void HUD_DrawGradientBackground(item_t *itm, rectangle_t *r) {
	qboolean	orientationInv;
	qhandle_t	shader;
	float		value;
	float		size;

	//invert the gradient direction
	orientationInv = (itm->propFlags & PROP_GRADIENT_INVERT);

	// allow color gradient when background not provided
	shader = CG_HUDShader(itm, cgs.media.whiteShader);

	value = HUD_GradientValue(itm);

	if (itm->propFlags & PROP_VERTICALBAR) {

		if (orientationInv) {
			// vertical top -> bottom
			size = value;
			CG_DrawGradientPic(itm, r->x, r->y, r->w, (r->h*size), 0, 0, 1, size, shader);
		}
		else {
			int invSize = 1 - value;
			// vertical bottom -> top
			size = 1 - value;

			if (itm->iconFlags & ICON_INVERT_W) {
				r->x += r->w;
				r->w = -r->w;
			}
			CG_DrawGradientPic(itm, r->x, r->y + (r->h*size), r->w, r->h - (r->h*size), 0, size, 1, 1, shader);
		}
	}
	else {
		if (orientationInv) {
			// horizontal right -> left
			size = 1 - value;
			CG_DrawGradientPic(itm, r->x + (r->w*size), r->y, r->w - (r->w*size), r->h, size, 0, 1, 1, shader);
		}
		else {
			// horizontal left -> right
			size = value;
			if (itm->iconFlags & ICON_INVERT_W) {
				r->x += (r->w*size);
				r->w = -r->w;
			}

			CG_DrawGradientPic(itm, r->x, r->y, (r->w*size), r->h, 0, 0, size, 1, shader);
		}
	}
}

// from cg_newdraw.c
void CG_CheckOrderPending() {
	// order pending was only CTF in Team Arena
	/*if (cgs.gametype < GT_CTF) {
		return;
	}*/
	if (cgs.gametype < GT_TEAM) {
		return;
	}

	if (cgs.orderPending) {
		const char *p1, *p2, *b;
		p1 = p2 = b = NULL;
		switch (cgs.currentOrder) {
		case TEAMTASK_OFFENSE:
			p1 = VOICECHAT_ONOFFENSE;
			p2 = VOICECHAT_OFFENSE;
			b = "+button7; wait; -button7";
			break;
		case TEAMTASK_DEFENSE:
			p1 = VOICECHAT_ONDEFENSE;
			p2 = VOICECHAT_DEFEND;
			b = "+button8; wait; -button8";
			break;
		case TEAMTASK_PATROL:
			p1 = VOICECHAT_ONPATROL;
			p2 = VOICECHAT_PATROL;
			b = "+button9; wait; -button9";
			break;
		case TEAMTASK_FOLLOW:
			p1 = VOICECHAT_ONFOLLOW;
			p2 = VOICECHAT_FOLLOWME;
			b = "+button10; wait; -button10";
			break;
		case TEAMTASK_CAMP:
			p1 = VOICECHAT_ONCAMPING;
			p2 = VOICECHAT_CAMP;
			break;
		case TEAMTASK_RETRIEVE:
			p1 = VOICECHAT_ONGETFLAG;
			p2 = VOICECHAT_RETURNFLAG;
			break;
		case TEAMTASK_ESCORT:
			p1 = VOICECHAT_ONFOLLOWCARRIER;
			p2 = VOICECHAT_FOLLOWFLAGCARRIER;
			break;
		}
		if (cg_currentSelectedPlayer.integer == numSortedTeamPlayers) {
			// to everyone
			trap_SendConsoleCommand(va("cmd vsay_team %s\n", p2));
		}
		else {
			// for the player self
			if (sortedTeamPlayers[cg_currentSelectedPlayer.integer] == cg.snap->ps.clientNum && p1) {
				trap_SendConsoleCommand(va("teamtask %i\n", cgs.currentOrder));
				//trap_SendConsoleCommand(va("cmd say_team %s\n", p2));
				trap_SendConsoleCommand(va("cmd vsay_team %s\n", p1));
			}
			else if (p2) {
				//trap_SendConsoleCommand(va("cmd say_team %s, %s\n", ci->name,p));
				trap_SendConsoleCommand(va("cmd vtell %d %s\n", sortedTeamPlayers[cg_currentSelectedPlayer.integer], p2));
			}
		}
		if (b) {
			trap_SendConsoleCommand(b);
		}
		cgs.orderPending = qfalse;
	}
}


// from cg_newdraw.c
qboolean CG_OtherTeamHasFlag() {
	if (cgs.gametype == GT_CTF
#ifdef MISSIONPACK
		|| cgs.gametype == GT_1FCTF
#endif
		) {
		int team = cg.snap->ps.persistant[PERS_TEAM];
#ifdef MISSIONPACK
		if (cgs.gametype == GT_1FCTF) {
			return ((team == TEAM_RED && cgs.flagStatus == FLAG_TAKEN_BLUE) || 
					(team == TEAM_BLUE && cgs.flagStatus == FLAG_TAKEN_RED));
		}
		else {
#endif
			return ((team == TEAM_RED && cgs.redflag == FLAG_TAKEN) ||
					(team == TEAM_BLUE && cgs.blueflag == FLAG_TAKEN));
#ifdef MISSIONPACK
		}
#endif
	}
	return qfalse;
}

qboolean CG_YourTeamHasFlag() {
	if (cgs.gametype == GT_CTF
#ifdef MISSIONPACK
		|| cgs.gametype == GT_1FCTF
#endif
		) {
		int team = cg.snap->ps.persistant[PERS_TEAM];
#ifdef MISSIONPACK
		if (cgs.gametype == GT_1FCTF) {
			return ((team == TEAM_RED && cgs.flagStatus == FLAG_TAKEN_RED) || 
					(team == TEAM_BLUE && cgs.flagStatus == FLAG_TAKEN_BLUE))
		}
		else {
#endif
			return ((team == TEAM_RED && cgs.blueflag == FLAG_TAKEN) || 
					(team == TEAM_BLUE && cgs.redflag == FLAG_TAKEN));
#ifdef MISSIONPACK
		}
#endif
	}
	return qfalse;
}

// from cg_newdraw.c
static void CG_SetSelectedPlayerName() {
	if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
		clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[cg_currentSelectedPlayer.integer];
		if (ci) {
			trap_Cvar_Set("cg_selectedPlayerName", ci->name);
			trap_Cvar_Set("cg_selectedPlayer", va("%d", sortedTeamPlayers[cg_currentSelectedPlayer.integer]));
			cgs.currentOrder = ci->teamTask;
		}
	}
	else {
		trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
	}
}

int CG_GetSelectedPlayer(void) {
#ifdef MISSIONPACK
	if (cg_currentSelectedPlayer.integer < 0 || cg_currentSelectedPlayer.integer >= numSortedTeamPlayers) {
		cg_currentSelectedPlayer.integer = 0;
	}
#endif
	return cg_currentSelectedPlayer.integer;
}

/*
=================
CG_SelectPrevPlayer & CG_SelectNextPlayer
from MISSIONPACK
bind PGUP "prevTeamMember"
bind PGDN "nextTeamMember"
bind o "nextOrder"
=================
*/
void CG_SelectNextPlayer(void) {
	CG_CheckOrderPending();

	if (cg_currentSelectedPlayer.integer >= 0 && cg_currentSelectedPlayer.integer < numSortedTeamPlayers) {
		cg_currentSelectedPlayer.integer++;
	}
	else {
		cg_currentSelectedPlayer.integer = 0;
	}
	CG_SetSelectedPlayerName();
}

void CG_SelectPrevPlayer(void) {
	CG_CheckOrderPending();

	if (cg_currentSelectedPlayer.integer > 0 && cg_currentSelectedPlayer.integer <= numSortedTeamPlayers) {
		cg_currentSelectedPlayer.integer--;
	}
	else {
		cg_currentSelectedPlayer.integer = numSortedTeamPlayers;
	}
	CG_SetSelectedPlayerName();
}

// from cg_newdraw.c
qhandle_t CG_StatusHandle(int task) {
	qhandle_t h = cgs.media.assaultShader;
	switch (task) {
	case TEAMTASK_OFFENSE:
		h = cgs.media.assaultShader;
		break;
	case TEAMTASK_DEFENSE:
		h = cgs.media.defendShader;
		break;
	case TEAMTASK_PATROL:
		h = cgs.media.patrolShader;
		break;
	case TEAMTASK_FOLLOW:
		h = cgs.media.followShader;
		break;
	case TEAMTASK_CAMP:
		h = cgs.media.campShader;
		break;
	case TEAMTASK_RETRIEVE:
		h = cgs.media.retrieveShader;
		break;
	case TEAMTASK_ESCORT:
		h = cgs.media.escortShader;
		break;
	default:
		h = cgs.media.assaultShader;
		break;
	}
	return h;
}


void CG_DrawSelectedPlayerStatus(rectDef_t *rect, int player) {
	clientInfo_t *ci = cgs.clientinfo + sortedTeamPlayers[player];
	if (ci) {
		qhandle_t h;
		if (cgs.orderPending && (cg_currentSelectedPlayer.integer == numSortedTeamPlayers || cg_currentSelectedPlayer.integer == player)) {
			// blink the icon
			if (cg.time > cgs.orderTime - 2500 && (cg.time >> 9) & 1) {
				return;
			}
			h = CG_StatusHandle(cgs.currentOrder);
		}
		else {
			h = CG_StatusHandle(ci->teamTask);
		}
		CG_DrawPic(rect->x, rect->y, rect->w, rect->h, h);
	}
}

// from cg_newdraw.c
static void CG_DrawPlayerStatus(rectDef_t *rect) {
	clientInfo_t *ci = &cgs.clientinfo[cg.snap->ps.clientNum];
	if (ci) {
		qhandle_t h = CG_StatusHandle(ci->teamTask);
		CG_DrawPic(rect->x, rect->y, rect->w, rect->h, h);
	}
}

static int HUDParamToTeamPlayerIdx(item_t * itm) {
	if (itm->propFlags & PROP_TEAM_PLAYER) {
		if (!itm->team_player)
			return cg.snap->ps.clientNum;
		else if (itm->team_player < 0) {
			return cg_currentSelectedPlayer.integer;
		}
		else if (itm->team_player >= 1) {
			return itm->team_player;
		}
	}
	return cg.snap->ps.clientNum;
}

void HUD_DrawBackground(item_t * itm, rectangle_t *r) {
	qhandle_t	shader = 0;

	int param = (itm->propFlags & PROP_TEAM_PLAYER) ? itm->team_player : itm->param;

	if (itm->iconFlags & ICON_GAME_TYPE) {
		shader = cgs.media.gameTypeShader[cgs.gametype];
	}
	else if (itm->iconFlags & ICON_HOLDABLE_ITEM) {
		int value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
		if (value) {
			CG_RegisterItemVisuals(value);
			shader = cg_items[value].icon;
		}
	}
	else if (itm->iconFlags & ICON_BLUE_FLAG) {
		shader = cgs.media.blueFlagShader[cgs.blueflag];//GUNNM TODO icon list parsed from the HUD file
	}
	else if (itm->iconFlags & ICON_RED_FLAG) {
		shader = cgs.media.redFlagShader[cgs.redflag];
	}
	else if (itm->iconFlags & ICON_ARMOR) {
		int clientNum;
		if (!param)
			clientNum = cg.snap->ps.clientNum;
		else if (param < 0) {
			clientNum = cg_currentSelectedPlayer.integer;
		}
		else if (param >= 1)
			clientNum = param;
		CG_Draw_Icon_Armor(itm, *r, clientNum);
	}
	else if (itm->iconFlags & ICON_AMMO) {
		int clientNum = HUDParamToTeamPlayerIdx(itm);
		CG_Draw_Icon_Ammo(itm, *r, clientNum);
	}
	else if (itm->iconFlags & ICON_POWERUP) {
		int clientNum = HUDParamToTeamPlayerIdx(itm);
		CG_DrawTeamPlayerPowerup(r, itm->team_player, 0 );
	}
	else if (itm->iconFlags & ICON_HEAD || itm->iconFlags & ICON_HEAD_ANIM ) {
		int clientNum = HUDParamToTeamPlayerIdx(itm);
		CG_DrawStatusBarHead(itm, *r, clientNum);
		return;
	}
	else if (itm->iconFlags & ICON_ATTACKER) {
		CG_DrawAttacker_icon(itm);
	}
	else if (itm->iconFlags & ICON_ORDER) {
		if (!param) {
			CG_DrawPlayerStatus(r);
		}
		else if (param < 0) {
			CG_DrawSelectedPlayerStatus(r, CG_GetSelectedPlayer());
		}
		else if (param >= 1) {
			CG_DrawSelectedPlayerStatus(r, param);
		}
		return;
	}
	else if (itm->shader) {
		shader = CG_HUDShader(itm, cgs.media.whiteShader);
	}

	if (shader) {
		if (itm->propFlags & PROP_VERTICALBAR) {
			if (itm->iconFlags & ICON_INVERT_W) {
				r->x += r->w;
				r->w = -r->w;
			}
			CG_DrawGradientPic(itm, r->x, r->y - r->h, r->w, r->h, 0, 0, 1, 1, shader);
		}
		else {
			if (itm->iconFlags & ICON_INVERT_W) {
				r->x += r->w;
				r->w = -r->w;
			}
			CG_DrawGradientPic(itm, r->x, r->y, r->w, r->h, 0, 0, 1, 1, shader);
		}
	}
}

const char * HUD_getText(item_t *itm, int value) {
	char		*s;

	if (itm->text.flags & VAL_TEXT) {
		s = itm->text.caption;
	}
	else if (itm->text.flags & VAL_SPEED) {
		if (itm->param == 1)
			s = va("%1.0i", value);
		else
			s = va("%1.0iups", value);
	}
	else if (itm->text.flags & VAL_NAME) {
		const char* plyrName = getTeamPlayerName(itm->team_player);
		s = va("%s", plyrName);
	}
	else if (itm->text.flags & VAL_HEALTH) {
		int playerHealth = getPlayerHealth(itm->team_player);
		s = va("%i", playerHealth);
	}
	else if (itm->text.flags & VAL_TIMER) {
		int			mins, seconds;
		int			msec;

		msec = cg.time - cgs.levelStartTime;
		seconds = msec / 1000;
		mins = seconds / 60;
		seconds -= mins * 60;

		msec = cg.time - cgs.levelStartTime;

		// param 2: countdown
		if (itm->param == 2 && cgs.timelimit) {
			msec = (cgs.timelimit * 60 * 1000) - msec;
		}

		seconds = msec / 1000;
		mins = seconds / 60;
		seconds -= mins * 60;

		if (itm->param == 1) {
			if (mins) {
				msec = msec - (mins * 60 * 1000) - (seconds * 1000);
				s = va("%i:%i:%02i", mins, seconds, msec);
			}
			else {
				msec -= (seconds * 1000);
				s = va("%i:%02i", seconds, msec);
			}
		}
		else {
			s = va("%i:%02i", mins, seconds);
		}
	}
	else if (itm->text.flags & VAL_FPS) {
		s = va("%ifps", FPS);
	}
	else if (itm->text.flags & VAL_FOLLOW_NAME) {
		s = cgs.clientinfo[cg.snap->ps.clientNum].name;
	}
	else if (itm->text.flags & VAL_SNAPSHOT) {
		s = va("time:%i snap:%i cmd:%i", cg.snap->serverTime, cg.latestSnapshotNum, cgs.serverCommandSequence);
	}
	else if (itm->text.flags & VAL_LOCATION) {
		const char* str = getPlayerLocation(itm->team_player);
		s = va("%s", str);
	}
	else if (itm->text.flags & VAL_CAPFRAG_LIMIT) {
		int lim = (cgs.gametype >= GT_CTF) ? cgs.capturelimit : cgs.fraglimit;
		s = va("%2i", lim);
	}
	else if (itm->text.flags & VAL_FRAG_LIMIT) {
		s = va("%2i", cgs.fraglimit);
	}
	else if (itm->text.flags & VAL_CAPTURE_LIMIT) {
		s = va("%2i", cgs.capturelimit);
	}
	else if (itm->text.flags & VAL_AMMO) {
		int val = HUD_PropValue(itm, VAL_AMMO, itm->param);
		s = va("%2i", val);
	}
	else if (itm->text.flags & VAL_ARMOR) {
		int val = GetTeamPlayerstat(itm, STAT_ARMOR);
		s = va("%2i", val);
	}
	else if (itm->text.flags & VAL_WEAPON) {
		int val = HUD_PropValue(itm, VAL_WEAPON, itm->param);
		s = va("%2i", val);
	}
	else if (itm->text.flags & VAL_HOLDABLE_ITEM) {
		int val = HUD_PropValue(itm, VAL_HOLDABLE_ITEM, itm->param);
		s = va("%2i", val);
	}
	else if (itm->text.flags & VAL_SCORE) {
		int val = HUD_PropValue(itm, VAL_SCORE, itm->param);
		s = va("%2i", val);
	}
	else if (itm->text.flags & VAL_TIME_LIMIT) {
		s = va("%2i", ((cgs.timelimit) * 60));
	}
	else {
		s = va("%i", value);
	}
	return s;
}

void HUD_Draw_Text(item_t *itm, rectangle_t *r) {
	int			value;
	const char	*s;
	vec4_t		forecolor;
	qboolean	showZeroValue;

	if (!itm->text.flags)
		return;

	value = HUD_ItemCaptionValue(itm);

	showZeroValue = (value == 0 && (itm->visible_prop_flags[1] & VIS_ZERO_VALUE));

	// allow 0 xhen VIS_SHOW_ZERO_VALUE in item's flags
	if (value >= 0 && !showZeroValue) {
		HUD_color(itm, &itm->forecolor, &forecolor, colorWhite);

		s = HUD_getText(itm, value);

#ifdef USE_NEW_FONT_RENDERER

		CG_SelectFont(itm->text.styleflags);

		CG_DrawString(r->x, r->y, s, forecolor, itm->fontsize.w, itm->fontsize.h, 0, itm->text.styleflags);

		CG_SelectFont(0);

		r->w = itm->fontsize.w * CG_DrawStrlen(s);
		if (itm->text.styleflags & DS_RIGHT)
			r->x -= r->w;
		if (itm->text.styleflags & DS_CENTER)
			r->x -= 0.5f * r->w;
		r->h = itm->fontsize.h;

#else
		trap_R_SetColor(forecolor);
		CG_DrawField(r->x, r->y, 3, value, itm->fontsize.w, itm->fontsize.h);
#endif
	}
}


/*
===============
HudShader
===============
*/
qhandle_t CG_HUDShader(item_t *itm, qhandle_t defaultShader) {
	if (!itm->shader)
		return defaultShader;
	else
		return itm->shader;
}

static qboolean rectangleIsNull(rectangle_t r) {
	return (!r.x && !r.y && !r.w && !r.h);
}

void getParentRect(const item_t *itm, rectangle_t *res) {
	item_t parentItm;

	if (!itm->parent) {
		return;
	}

	// the minus sign indicate that item is in dyn_itemArray
	if (itm->parent < 0) {
		parentItm = dyn_itemArray[-itm->parent];
	}
	else {
		parentItm = itemArray[itm->parent];
	}
	// use parent finalRect (real drawn rectangle for dynamic sized items)
	if (!rectangleIsNull(parentItm.finalRect)) {
		*res = parentItm.finalRect;
		return;
	}
	else {
		// if item not (or not yet) in this frame, use its original rect property
		if (!rectangleIsNull(parentItm.rect)) {
			*res = parentItm.rect;
		}
		else if (parentItm.parent) {
			getParentRect(&parentItm, res);
		}
	}
}

/*
================
CG_Update_Anchors
================
*/
void HUD_Update_Anchors(const item_t *itm, rectangle_t *r) {
	rectangle_t parentR;

	parentR.x = parentR.y = parentR.w = parentR.h = 0;

	getParentRect(itm, &parentR);
	
	if (rectangleIsNull(parentR)) {
		return;
	}

	// Left/Right and Top/Bottom should be inverted, but this was counter-intuitive.
	// (an item left to its parent, is actually anchored by its right side)

	if (itm->propFlags & PROP_ANCHOR_RIGHT) {
		r->x += parentR.x + parentR.w;
	}
	else if (itm->propFlags & PROP_ANCHOR_LEFT) {
		r->x += parentR.x - r->w;
	}
	else if (itm->propFlags & PROP_ANCHOR_CENTER) {
		r->x += parentR.x;
	}

	if (itm->propFlags & PROP_ANCHOR_BOTTOM) {
		r->y += parentR.y + parentR.h;
	}
	else if (itm->propFlags & PROP_ANCHOR_TOP) {
		r->y += parentR.y - itm->rect.h;
	}
	else if (itm->propFlags & PROP_ANCHOR_MIDDLE) {
		r->y += parentR.y;
	}

	// GUNNM TODO: use screen rectangle as a parent when no parent are provided
}

/*
===============
CG_Update_Margin
===============
*/
void HUD_Update_Margin(item_t *itm, rectangle_t *r)
{
	// return if no margins defined
	if (itm->margin.left == 0 && itm->margin.right == 0 &&
		itm->margin.top == 0 && itm->margin.bottom == 0) {
		return;
	}

	if (itm->propFlags & PROP_ANCHOR_LEFT ) {
		r->x -= itm->margin.left;
	}
	else if (itm->propFlags & PROP_ANCHOR_CENTER || (itm->propFlags & PROP_ANCHOR_RIGHT)) {
		r->x += itm->margin.right;
	}

	if (itm->propFlags & PROP_ANCHOR_BOTTOM || (itm->propFlags & PROP_ANCHOR_MIDDLE)) {
		r->y += itm->margin.bottom;
	}
	else if (itm->propFlags & PROP_ANCHOR_TOP) {
		r->y -= itm->margin.top;
	}
}


/*
===============
CG_Update_Valign
===============
*/
void HUD_Update_Valign(item_t *itm, rectangle_t *r)
{
	int h;
	if (itm->rect.h) {
		h = itm->rect.h;
	}
	else if (itm->fontsize.h) {
		h = itm->fontsize.h;
	}
	else {
		return;
	}

	if (itm->propFlags & PROP_VALIGN_TOP)
		r->y -= h;
	else if (itm->propFlags & PROP_VALIGN_BOTTOM)
		r->y += h;
	else if (itm->propFlags & PROP_VALIGN_MIDDLE)
		r->y -= itm->rect.y +200+ h * 0.5f;
}

void HUD_Update_finalRect(item_t *itm, int x, int y, int w, int h) {
	itm->finalRect.x = x;
	itm->finalRect.y = y;
	itm->finalRect.w = w;
	itm->finalRect.h = h;

	//GUNNM TODO if caption, use str lenght et charW according to align, valign, and charH

	//display all the finalRect, for debug:
	//CG_DrawPic(itm->finalRect.x, itm->finalRect.y, itm->finalRect.w, itm->finalRect.h, cgs.media.selectShader);
}
/*
===============
UI_Alloc
===============
*/
static void *HUD_Alloc(int size) {
	char *p;
	if (allocPoint + size > MEM_POOL_SIZE) {
		outOfMemory = qtrue;
		Com_Printf("HUD_Alloc: Failure. Out of memory!");
		return NULL;
	}
	p = &memoryPool[allocPoint];
	allocPoint += (size + 15) & ~15;
	return p;
}


/*
===============
UI_InitMemory
===============
*/
static void UI_InitMemory(void) {
	allocPoint = 0;
	outOfMemory = qfalse;
}


/*
================
return a hash value for the string
================
*/
static unsigned hashForString(const char *str) {
	int			i;
	unsigned	hash;
	char		letter;

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

typedef struct stringDef_s {
	struct stringDef_s *next;
	const char *str;
} stringDef_t;

static int strPoolIndex = 0;
static char strPool[STRING_POOL_SIZE];

static int strHandleCount = 0;
static stringDef_t *strHandle[HASH_TABLE_SIZE];


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
=================
keepTokenOnError

keep last token when parse error occured,
because token can't been unread
it will be the next one to be proceed
=================
*/
qboolean needCacheToken;
qboolean itemEnd;
qboolean propertyEnd;
char* cacheTokenStr;

static void keepTokenStr_OnError(pc_token_t token)
{
	cacheTokenStr = token.string;
	needCacheToken = qtrue;
}

static void resetTokenCache() {
	needCacheToken = qfalse;
	*cacheTokenStr = '\0';
}


/*
=================
PC_Int_Parse
=================
*/
static qboolean PC_Int_Parse(int handle, int *i) {
	pc_token_t token;
	int negative = qfalse;

	if (!i)
		return qfalse;

	if (!trap_PC_ReadToken(handle, &token))
		return qfalse;

	if (token.string[0] == '-') {
		if (!trap_PC_ReadToken(handle, &token))
			return qfalse;
		negative = qtrue;
	}
	else if (token.string[0] == '}' || token.string[0] == ';') {
		itemEnd = qtrue;
		return qfalse;
	}

	if (token.type != TT_NUMBER) {
		if (token.type == TT_NAME) {
			propertyEnd = qtrue;
		}
		else if (token.type == TT_STRING) {
			needCacheToken = qtrue;
			cacheTokenStr = (char *)token.string;
		}
		else {
			PC_SourceError(handle, "expected integer but found %s \n", token.string);
		}

		return qfalse;
	}

	*i = token.intvalue;
	if (negative)
		*i = -*i;
	return qtrue;
}

/*
===============
Keyword Hash
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

/*
===============
cvarTest list hash
===============
*/
typedef struct cvarTest_keywordHash_s
{
	char *keyword;
	vmCvar_t *cvar;
	int flag;
	struct cvarTest_keywordHash_s *next;
} cvarTest_keywordHash_t;

void cvarTest_KeywordHash_Add(cvarTest_keywordHash_t *table[], cvarTest_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

cvarTest_keywordHash_t *cvarTest_KeywordHash_Find(cvarTest_keywordHash_t *table[], char *keyword)
{
	cvarTest_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

cvarTest_keywordHash_t cvarTest_Keywords[] = {
	{"cg_drawWeaponSelect",		&cg_drawWeaponSelect,	CV_cg_drawWeaponSelect,		NULL},
	{"cg_drawAttacker",			&cg_drawAttacker,		CV_cg_drawAttacker,			NULL},
	{"cg_drawTeamOverlay",		&cg_drawTeamOverlay,	CV_cg_drawTeamOverlay,		NULL},
	{"cg_drawCrosshairNames",	&cg_drawCrosshairNames,	CV_cg_drawCrosshairNames,	NULL},
	{"cg_drawIcons",			&cg_drawIcons,			CV_cg_drawIcons,			NULL},
	{"cg_draw3dIcons",			&cg_draw3dIcons,		CV_cg_draw3dIcons,			NULL},
	{"cg_drawFPS",				&cg_drawFPS,			CV_cg_drawFPS,				NULL},
	{"cg_drawSpeed",			&cg_drawSpeed,			CV_cg_drawSpeed,			NULL},
	{"cg_drawTimer",			&cg_drawTimer,			CV_cg_drawTimer,			NULL},
	{"cg_lagometer",			&cg_lagometer,			CV_cg_lagometer,			NULL},
	{"cg_drawPing",				&cg_drawPing,			CV_cg_drawPing,				NULL},
	{"cg_drawSnapshot",			&cg_drawSnapshot,		CV_cg_drawSnapshot,			NULL},
	{"cg_drawStatus",			&cg_drawStatus,			CV_cg_drawStatus,			NULL},
	{"cg_drawRewards",			&cg_drawRewards,		CV_cg_drawRewards,			NULL},
	{"cg_drawAmmoWarning",		&cg_drawAmmoWarning,	CV_cg_drawAmmoWarning,		NULL},
	{"cg_drawCrosshair",		&cg_drawCrosshair,		CV_cg_drawCrosshair,		NULL},
	{NULL, 0, 0, NULL}
};

cvarTest_keywordHash_t *cvarTest_KeywordHash[KEYWORDHASH_SIZE];

//fill command_KeywordHash list
void cvarTest_SetupKeywordHash(void) {
	int i;

	memset(cvarTest_KeywordHash, 0, sizeof(cvarTest_KeywordHash));
	for (i = 0; cvarTest_Keywords[i].keyword; i++) {
		cvarTest_KeywordHash_Add(cvarTest_KeywordHash, &cvarTest_Keywords[i]);
	}
}


/*
=================
PC_Float_Parse
=================
*/
static qboolean PC_Float_Parse(int handle, float *f) {
	pc_token_t token;
	int negative = qfalse;

	if (!trap_PC_ReadToken(handle, &token)) {
		keepTokenStr_OnError( token );
		return qfalse;
	}

	// fixme: those are lazy fix.
	// take care of colors T and E when parsing color. 
	if (token.string[0] == 'T' || token.string[0] == 'E') {
		keepTokenStr_OnError(token);
		return qfalse;
	}
	// take care of colors arrays when parsing color.
	if (strcmp("HealthColors", cacheTokenStr) == 0 || strcmp("ArmorColors", cacheTokenStr) == 0 ||
		strcmp("AmmoColors", cacheTokenStr) == 0 || strcmp("TeamsColors", cacheTokenStr) == 0 || 
		strcmp("BlueTeamColor", cacheTokenStr) == 0 || strcmp("RedTeamColor", cacheTokenStr) == 0)
	{
		keepTokenStr_OnError(token);
		return qfalse;
	}

	if (token.string[0] == ';') {
		return qtrue;
	}
	else if (token.string[0] == '}') {
		itemEnd = qtrue;
		return qtrue;
	}
	// std separators
	else if (token.string[0] == ',') {
		if (!trap_PC_ReadToken(handle, &token)) {
			keepTokenStr_OnError(token);
			return qfalse;
		}
	}

	if (token.string[0] == '-') {
		if (!trap_PC_ReadToken(handle, &token)) {
			keepTokenStr_OnError(token);
			return qfalse;
		}
		negative = qtrue;
	}

	if ( token.type != TT_NUMBER ) {
		keepTokenStr_OnError(token);
		return qfalse;
	}

	if (negative)
		*f = -token.floatvalue;
	else
		*f = token.floatvalue;
	return qtrue;
}


/*
=================
PC_Color_Parse
=================
*/
static qboolean PC_Color_Parse(int handle, vec4_t *c) {
	int i;
	float f;
	for (i = 0; i < 4; i++) {
		if (!PC_Float_Parse(handle, &f)) {
			return qfalse;
		}
		(*c)[i] = f;
	}
	return qtrue;
}


/*
=================
parse color if RGBA, or add flag: C_COLOR_TEAMS | C_COLOR_TEAM
C_COLOR_NME | C_COLOR_HEALTH | C_COLOR_ARMOR | C_COLOR_AMMO
=================
*/
static qboolean Color_Str_Parse(int handle, color_Def_t *col) {
	int i;
	float f;

	for (i = 0; i < 4; i++) {
		if (!PC_Float_Parse(handle, &f)) {
			if (strcmp("TeamsColors", cacheTokenStr) == 0) {
				col->colorflags |= C_COLORS_TEAMS;
				resetTokenCache();
				return qtrue;
			}
			else if (cacheTokenStr[0] == 'T') {
				col->colorflags |= C_COLOR_TEAM;
				resetTokenCache();
				return qtrue;
			}
			else if (cacheTokenStr[0] == 'E') {
				col->colorflags |= C_COLOR_NME;
				resetTokenCache();
				return qtrue;
			}
			else if (strcmp("BlueTeamColor", cacheTokenStr) == 0) {
				col->colorflags |= C_COLOR_BLUE_TEAM;
				resetTokenCache();
				return qtrue;
			}
			else if (strcmp("RedTeamColor", cacheTokenStr) == 0) {
				col->colorflags |= C_COLOR_RED_TEAM;
				resetTokenCache();
				return qtrue;
			}
			else if (strcmp("HealthColors", cacheTokenStr) == 0) {
				col->colorflags |= C_COLORS_HEALTH;
				resetTokenCache();
				return qtrue;
			}
			else if (strcmp("ArmorColors", cacheTokenStr) == 0) {
				col->colorflags |= C_COLORS_ARMOR;
				resetTokenCache();
				return qtrue;
			}
			else if (strcmp("AmmoColors", cacheTokenStr) == 0) {
				col->colorflags |= C_COLORS_AMMO;
				resetTokenCache();
				return qtrue;
			}
			else {
				Com_Printf("Color parse error: %s\n", cacheTokenStr);
				return qfalse;
			}
		}

		// float parse success
		col->colorflags |= C_COLOR_RGBA;
		col->color[i] = f;
	}
	return qtrue;
}


/*
=================
PC_Rect_Parse
=================
*/
static qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
	int intNb = 0;
	if (PC_Float_Parse(handle, &r->x)) {
		intNb++;
		if (PC_Float_Parse(handle, &r->y)) {
			intNb++;
			if (PC_Float_Parse(handle, &r->w)) {
				intNb++;
				if (PC_Float_Parse(handle, &r->h)) {
					intNb++;
					return qtrue;
				}
			}
		}
	}
	return (intNb > 0);
}

/*
=================
PC_Margin_Parse
=================
*/
static qboolean PC_Margin_Parse(int handle, margin_t *m) {
	int paramNb = 0;
	if (PC_Float_Parse(handle, &m->left)) {
		paramNb++;
		if (PC_Float_Parse(handle, &m->right)) {
			paramNb++;
			if (PC_Float_Parse(handle, &m->top)) {
				paramNb++;
				if (PC_Float_Parse(handle, &m->bottom)) {
					paramNb++;
					return qtrue;
				}
			}
		}
	}
	return (paramNb > 0);
}


/*
=================
PC_String_Parse
=================
*/
static qboolean PC_String_Parse(int handle, const char **out) {
	pc_token_t token;

	if (!trap_PC_ReadToken(handle, &token))
		return qfalse;

	*(out) = String_Alloc(token.string);
	return qtrue;
}


/*
=================
PC_bool_Parse
=================
*/
static qboolean PC_bool_Parse(int handle, qboolean defaultValue, qboolean *b) {
	const char *temp;
	if (PC_String_Parse(handle, &temp)) {
		if (temp[0] == '}')	{
			*b = defaultValue;
			itemEnd = qtrue;
			return qtrue;
		}
		// e.g. when just the keyword 'visible' alone, it mean visible = qtrue
		else if (temp[0] == '\0' || temp[0] == ';') {
			*b = defaultValue;
			return qtrue;
		}
		else if ( strcmp("false", temp) == 0 || temp[0] == '0') {
			*b = qfalse;
			return qtrue;
		}
		else if ( strcmp("true", temp) == 0 || temp[0] == '1') {
			*b = qtrue;
			return qtrue;
		}
		else {
			if ( defaultValue )
				*b = qtrue;

			needCacheToken = qtrue;
			cacheTokenStr = (char *)temp ;
		}
	}

	*b = defaultValue;
	return qfalse;
}


/*
===============
properties Keyword Parse functions
===============
*/
static qboolean prop_name(item_t *itm, int handle) {
	const char *s;

	if (!PC_String_Parse(handle, &s)) {
		return qfalse;
	}
	else {
		strcpy(itm->item_name, s);
		return qtrue;
	}
}

// margin <float, float, float, float>
static qboolean prop_margin(item_t *itm, int handle) {
	if (!PC_Margin_Parse(handle, &itm->margin)) {
		return qfalse;
	}
	return qtrue;
}

// rect <rectangle>
static qboolean prop_rect(item_t *itm, int handle) {
	if (!PC_Rect_Parse(handle, &itm->rect)) {
		return qfalse;
	}

	if (itm->rect.w < 0)
		itm->iconFlags |= ICON_INVERT_W;
	if (itm->rect.h < 0)
		itm->iconFlags |= ICON_INVERT_H;

	return qtrue;
}

// pulseScale <float>
static qboolean prop_pulseScale(item_t *itm, int handle) {
	if (!PC_Float_Parse(handle, &itm->pulseScale)) {
		return qfalse;
	}
	return qtrue;
}

// CG_DrawString() flag
// proportional <boolean>
static qboolean prop_proportional(item_t *itm, int handle) {
	qboolean proportionalTmp;
	PC_bool_Parse(handle, qtrue, &proportionalTmp);
	if (proportionalTmp) {
		itm->text.styleflags |= DS_PROPORTIONAL;
	}
	return qtrue;
}

// CG_DrawString() flag
// shadow <boolean>
static qboolean prop_shadow(item_t *itm, int handle) {
	qboolean shadowTmp;
	PC_bool_Parse(handle, qtrue, &shadowTmp);
	if (shadowTmp) {
		itm->text.styleflags |= DS_SHADOW;
	}
	return qtrue;
}

// CG_DrawString() flag
// textAlign <textAlign_t>
static qboolean prop_textalign(item_t *itm, int handle) {
	const char *s;

	if (PC_String_Parse(handle, &s)) {
		if (s[0] == 'R')
			itm->text.styleflags |= DS_RIGHT;
		else if (s[0] == 'C')
			itm->text.styleflags |= DS_CENTER;
		else if (s[0] == 'L')
			//return item->text.styleflags |= DS_LEFT; // CG_DrawString() default value is left align
			return qtrue;	
		return qtrue;
	}
	return qfalse;
}

// image <const char*>
static qboolean prop_background(item_t *itm, int handle) {
	const char *s;
	if (!PC_String_Parse(handle, &s)) {
		return qfalse;
	}
	if (strcmp("ICON_GAME_TYPE", s) == 0) {
		itm->iconFlags |= ICON_GAME_TYPE;
		return qtrue;
	}
	else if (strcmp("ICON_HOLDABLE_ITEM", s) == 0) {
		itm->iconFlags |= ICON_HOLDABLE_ITEM;
		return qtrue;
	}
	else if (strcmp("ICON_BLUE_FLAG", s) == 0) {
		itm->iconFlags |= ICON_BLUE_FLAG;
		return qtrue;
	}
	else if (strcmp("ICON_RED_FLAG", s) == 0) {
		itm->iconFlags |= ICON_RED_FLAG;
		return qtrue;
	}
	else if (strcmp("ICON_HEAD", s) == 0) {
		itm->iconFlags |= ICON_HEAD;
		return qtrue;
	}
	else if (strcmp("ICON_HEAD_ANIM", s) == 0) {
		itm->iconFlags |= ICON_HEAD_ANIM;
		return qtrue;
	}
	else if (strcmp("ICON_ARMOR", s) == 0) {
		itm->iconFlags |= ICON_ARMOR;
		return qtrue;
	}
	else if (strcmp("ICON_AMMO", s) == 0) {
		itm->iconFlags |= ICON_AMMO;
		return qtrue;
	}
	else if (strcmp("ICON_ORDER", s) == 0) {
		itm->iconFlags |= ICON_ORDER;
		return qtrue;
	}
	else if (strcmp("ICON_POWERUP", s) == 0) {
		itm->iconFlags |= ICON_POWERUP;
		return qtrue;
	}
	else if (strcmp("ICON_ATTACKER", s) == 0) {
		itm->iconFlags |= ICON_ATTACKER;
		return qtrue;
	}
	// This one is the team arena animated background
	// it uses a special shader
	else if (strcmp("menuscreen2", s) == 0) {
		itm->shader = cgs.media.menuscreen2;
		return qtrue;
	}

	itm->shader = trap_R_RegisterShaderNoMip(s);
	return qtrue;
}


// verticalbar <qboolean>
static qboolean prop_verticalbar(item_t *itm, int handle) {
	qboolean vertic;
	qboolean def = qtrue;
	if (!PC_bool_Parse(handle, def, &vertic)) {
		// if keyword 'verticalbar' alone
		itm->propFlags |= PROP_VERTICALBAR;
		return def;
	}
	else if (vertic) {
		itm->propFlags |= PROP_VERTICALBAR;
	}
	return qtrue;
}

// fontsize <charSizeDef_t>
static qboolean prop_Size(item_t *itm, int handle) {
	qboolean onlyWidth;
	if (PC_Float_Parse(handle, &itm->fontsize.w)) {
		onlyWidth = qtrue;
		if (PC_Float_Parse(handle, &itm->fontsize.h)) {
			return qtrue;
		}
	}
	// if only Width is provided, height = width
	if (onlyWidth && !itm->fontsize.h)
		itm->fontsize.h = itm->fontsize.w;
	return onlyWidth;
}

// font <fontType_t>
static qboolean prop_font(item_t *itm, int handle) {
	const char *temp;

	if (PC_String_Parse(handle, &temp)) {
		if (strcmp("numbers", temp) == 0)
			itm->text.styleflags |= DS_FONT_NUMBER;
		//else if (strcmp("other", temp) == 0) // for futur dev
		//	itm->text.styleflags |= DS_FONT_OTHER;
		return qtrue;
	}
	return qfalse;
}

// param <int>
static qboolean prop_param(item_t *itm, int handle) {
	if (!PC_Int_Parse(handle, &itm->param)) {
		return qfalse;
	}
	return qtrue;
}

/*
=================
CheckAlpha
Use a specific alpha when provide after flag:
C_COLOR_TEAMS | C_COLOR_TEAM | etc..
=================
*/
//retour ligne 761---------------------------------------------------------------------------------
static qboolean CheckAlpha(int handle, color_Def_t *col, float *alpha) {//todo virer itm
	if (needCacheToken)//GUNNM TODO: do we need this test?
		return qfalse;

	if (col->colorflags & C_COLOR_RGBA)
		return qfalse;

	if (!PC_Float_Parse(handle, alpha)) {
		return qfalse;
	}

	return qtrue;
}

//GUNNM TODO factorise those 2 fct
// forecolor <vec4_t>
static qboolean prop_forecolor(item_t *itm, int handle) {
	if (!Color_Str_Parse(handle, &itm->forecolor)) {
		return qfalse;
	}

	if (CheckAlpha(handle, &itm->forecolor, &itm->forecolor.alpha)) {
		//itm->forecolor.colorflags |= C_COLOR_FORCE_ALPHA;
	}
	return qtrue;
}

// backcolor <vec4_t>
static qboolean prop_backcolor(item_t *itm, int handle) {
	if (!Color_Str_Parse(handle, &itm->backcolor)) {
		return qfalse;
	}
	
	if (CheckAlpha(handle, &itm->backcolor, &itm->backcolor.alpha)) {
		//itm->backcolor.colorflags |= C_COLOR_FORCE_ALPHA;
	}
	return qtrue;
}


static qboolean addAnchorFlags(item_t *itm, const char firstChar) {
	switch (firstChar) {
	case 'L':
		itm->propFlags |= PROP_ANCHOR_LEFT;
		return qtrue;
	case 'C':
		itm->propFlags |= PROP_ANCHOR_CENTER;
		return qtrue;
	case 'R':
		itm->propFlags |= PROP_ANCHOR_RIGHT;
		return qtrue;
	case 'T':
		itm->propFlags |= PROP_ANCHOR_TOP;
		return qtrue;
	case 'M':
		itm->propFlags |= PROP_ANCHOR_MIDDLE;
		return qtrue;
	case 'B':
		itm->propFlags |= PROP_ANCHOR_BOTTOM;
		return qtrue;
	default:
		return qfalse;
	}
}

// anchors <L|C|R> and <T|M|B> or <Left|Center|Right> and <Top|Middle|Bottom>
static qboolean prop_anchors(item_t *itm, int handle) {
	const char *temp;
	// one or two flags possible. eg: "anchor Top Right"
	if (PC_String_Parse(handle, &temp)) {
		addAnchorFlags(itm, temp[0]);
		// check if two anchors were defined
		if (PC_String_Parse(handle, &temp)) {
			if (temp[0] == '}') {
				itemEnd = qtrue;
				return qtrue;
			}

			if (!addAnchorFlags(itm, temp[0])) {
				needCacheToken = qtrue;
				cacheTokenStr = (char *)temp;
				// one anchor flag is enough
				return qtrue;
			}
		}
		else {
			needCacheToken = qtrue;
			cacheTokenStr = (char *)temp;
			return qtrue;
		}

		return qtrue;
	}
	return qfalse;
}

// fill <qboolean>
static qboolean prop_fill(item_t *itm, int handle) {
	qboolean res;
	qboolean defaultValue = qtrue;
	if (!PC_bool_Parse(handle, defaultValue, &res)) {
		if (defaultValue)
			itm->propFlags |= PROP_FILL;
		return defaultValue;
	}
	if (res) {
		itm->propFlags |= PROP_FILL;
	}

	return qtrue;
}

static qboolean bool_ParseStr(const char *str, qboolean defaultValue, qboolean *b) {
	if (str[0] == '}') {
		*b = defaultValue;
		itemEnd = qtrue;
		return qtrue;
	}
	// e.g. when just the keyword 'visible' alone, it mean visible = qtrue
	else if (str[0] == '\0' || str[0] == ';') {
		*b = defaultValue;
		return qtrue;
	}
	else if (strcmp("false", str) == 0 || str[0] == '0') {
		*b = qfalse;
		return qtrue;
	}
	else if (strcmp("true", str) == 0 || str[0] == '1') {
		*b = qtrue;
		return qtrue;
	}
	else {
		if (defaultValue)
			*b = qtrue;
	}

	return qfalse;
}

// icon3D <qboolean>
static qboolean prop_icon3D(item_t *itm, int handle) {
	qboolean res;
	qboolean defaultValue = qtrue;
	if (!PC_bool_Parse(handle, defaultValue, &res)) {
		if (defaultValue)
			itm->iconFlags |= ICON_3D;
		return defaultValue;
	}
	if (res) {
		itm->iconFlags |= ICON_3D;
	}
	return qtrue;
}
static qboolean prop_BlinkWhenLow(item_t *itm, int handle) {
	/*qboolean res;
	qboolean defaultValue = qtrue;
	if (!PC_bool_Parse(handle, defaultValue, &res)) {
		return defaultValue;
	}
	if (res) {*/
		itm->propFlags |= PROP_BLINK_WHEN_LOW;
	//}
	return qtrue;
}

// time <int>
static qboolean prop_time(item_t *itm, int handle) {
	if (!PC_Int_Parse(handle, &itm->time)) {
		return qfalse;
	}
	return qtrue;
}

static qboolean prop_TeamPlayer(item_t *itm, int handle) {
	if (!PC_Int_Parse(handle, &itm->team_player)) {
		return qfalse;
	}
	itm->propFlags |= PROP_TEAM_PLAYER;
	return qtrue;
}
/*
===============
value list hash
===============
*/
typedef struct flag_keywordHash_s
{
	char *keyword;
	int flag;
	struct flag_keywordHash_s *next;
} flag_keywordHash_t;

flag_keywordHash_t vis_Keywords[] = {
	//HUD keyword				Visibility flags		NULL
	{"VIS_IN_SCORE",			VIS_IN_SCORE,			NULL},
	{"VIS_NEVER",				VIS_NEVER,				NULL},
	{"VIS_IN_MENU",				VIS_IN_MENU,			NULL},
	{"VIS_LOCAL_SERVER",		VIS_LOCAL_SERVER,		NULL},
	{"VIS_PMF_FOLLOW",			VIS_PMF_FOLLOW,			NULL},
	{"VIS_LOW_AMMO_WARNING",	VIS_LOW_AMMO_WARNING,	NULL},
	{"VIS_OUT_OF_AMMO",			VIS_OUT_OF_AMMO,		NULL},
	{"VIS_WARMUP",				VIS_WARMUP,				NULL},
	{"VIS_ZERO_VALUE",			VIS_ZERO_VALUE,			NULL},
	{"VIS_DISCONNECTED",		VIS_DISCONNECTED,		NULL},
	{"VIS_BLINK",				VIS_BLINK,				NULL},
	{"VIS_BLUE_FLAG_TAKEN",		VIS_BLUE_FLAG_TAKEN,	NULL},
	{"VIS_RED_FLAG_TAKEN",		VIS_RED_FLAG_TAKEN,		NULL},
	{"VIS_POWERUP_1",			VIS_POWERUP_1,			NULL},
	{"VIS_PICKUP_ITEM",			VIS_PICKUP_ITEM,		NULL},//fixme: does not worked, item always visible
	{"VIS_FIRING",				VIS_FIRING,				NULL},
	{NULL, 0, NULL}
};

flag_keywordHash_t *flag_KeywordHash[KEYWORDHASH_SIZE];

void flag_KeywordHash_Add(flag_keywordHash_t *table[], flag_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

flag_keywordHash_t *flag_KeywordHash_Find(flag_keywordHash_t *table[], char *keyword)
{
	flag_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

void flag_SetupKeywordHash(void) {
	int i;

	memset(flag_KeywordHash, 0, sizeof(flag_KeywordHash));
	for (i = 0; vis_Keywords[i].keyword; i++) {
		flag_KeywordHash_Add(flag_KeywordHash, &vis_Keywords[i]);
	}
}

/*
===============
value visible flags list hash
===============
*/
void value_KeywordHash_Add(flag_keywordHash_t *table[], flag_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

flag_keywordHash_t *value_KeywordHash_Find(flag_keywordHash_t *table[], char *keyword)
{
	flag_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

flag_keywordHash_t value_Keywords[] = {
	// caption and gradient flags:
	{ "VAL_HEALTH",			VAL_HEALTH,			NULL },
	{ "VAL_ARMOR",			VAL_ARMOR,			NULL },
	{ "VAL_AMMO",			VAL_AMMO,			NULL },
	{ "VAL_WEAPON",			VAL_WEAPON,			NULL },
	{ "VAL_SCORE",			VAL_SCORE,			NULL },
	{ "VAL_TIMER",			VAL_TIMER,			NULL },
	{ "VAL_HOLDABLE_ITEM",	VAL_HOLDABLE_ITEM,	NULL },
	{ "VAL_FPS",			VAL_FPS,			NULL },
	{ "VAL_SPEED",			VAL_SPEED,			NULL },
	{ "VAL_FOLLOW_NAME",	VAL_FOLLOW_NAME,	NULL },
	{ "VAL_SNAPSHOT",		VAL_SNAPSHOT,		NULL },
	{ "VAL_CAPFRAG_LIMIT",	VAL_CAPFRAG_LIMIT,	NULL },
	{ "VAL_FRAG_LIMIT",		VAL_FRAG_LIMIT,		NULL },
	{ "VAL_CAPTURE_LIMIT",	VAL_CAPTURE_LIMIT,	NULL },
	{ "VAL_TIME_LIMIT",		VAL_TIME_LIMIT,		NULL },
	{ "VAL_LOCATION",		VAL_LOCATION,		NULL },
	{ "VAL_NAME",			VAL_NAME,			NULL },
	{ "VAL_PLAYERS_NB_TEAM",VAL_PLAYERS_NB_TEAM,NULL },

	{ NULL, 0, NULL }
};

flag_keywordHash_t *value_KeywordHash[KEYWORDHASH_SIZE];

//fill value_KeywordHash list
void value_SetupKeywordHash(void) {
	int i;

	memset(value_KeywordHash, 0, sizeof(value_KeywordHash));
	for (i = 0; value_Keywords[i].keyword; i++) {
		value_KeywordHash_Add(value_KeywordHash, &value_Keywords[i]);
	}
}

/*
===============
GT_visible flags list hash
===============
*/
void GT_Vis_KeywordHash_Add(flag_keywordHash_t *table[], flag_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

flag_keywordHash_t *GT_Vis_KeywordHash_Find(flag_keywordHash_t *table[], char *keyword)
{
	flag_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

flag_keywordHash_t GT_Vis_Keywords[] = {
	{"VIS_TEAM_PLAY",			VIS_TEAM_PLAY,			NULL},
	{"VIS_GT_TOURNAMENT",		VIS_GT_TOURNAMENT,		NULL},
	{"VIS_GT_FFA",				VIS_GT_FFA,				NULL},
	{"VIS_GT_TDM",				VIS_GT_TDM,				NULL},
	{"VIS_GT_CTF",				VIS_GT_CTF,				NULL},
#ifdef MISSIONPACK
	{"VIS_GT_1FCTF",			VIS_ONLY_GT_1FCTF,		NULL},
	{"VIS_GT_OBELISK",			VIS_ONLY_GT_OBELISK,	NULL},
	"VIS_GT_HARVESTER",			VIS_ONLY_GT_HARVESTER,	NULL },
#endif
	{ "VIS_GT_FREEZE",			VIS_GT_FREEZE,			NULL },
	{ "VIS_TEAM_BLUE",			VIS_TEAM_BLUE,			NULL },
	{ "VIS_TEAM_RED",			VIS_TEAM_RED,			NULL },
	{ "VIS_TEAM_SPEC",			VIS_TEAM_SPECTATOR,		NULL },
	{ "VIS_TEAM_BLUE_OR_RED",	VIS_TEAM_BLUE_OR_RED,	NULL },
	{ "VIS_TEAM_SPECTATOR",		VIS_TEAM_SPECTATOR,		NULL },
	{ "VIS_SHOW_TEAMINFO",		VIS_SHOW_TEAMINFO,		NULL },
	{ "VIS_TEAM_PLAYER",		VIS_TEAM_PLAYER,		NULL },
{ NULL, 0, NULL }
};

flag_keywordHash_t *GT_Vis_KeywordHash[KEYWORDHASH_SIZE];

//fill GT_Vis_KeywordHash list
void GT_Vis_SetupKeywordHash(void) {
	int i;

	memset(GT_Vis_KeywordHash, 0, sizeof(GT_Vis_KeywordHash));
	for (i = 0; GT_Vis_Keywords[i].keyword; i++) {
		GT_Vis_KeywordHash_Add(GT_Vis_KeywordHash, &GT_Vis_Keywords[i]);
	}
}


/*
===============
addVisibilityFlags
===============
*/
static qboolean addVisibilityFlags(item_t *itm, int handle, const char *temp) {
	// if keyword 'visible' alone, visible = qtrue
	if (temp[0] == '\0' || temp[0] == ';') {
		return qtrue;
	}
	else if (temp[0] == '0' || strcmp("false", temp) == 0) {
		itm->visible_prop_flags[0] |= VIS_NEVER;
		return qtrue;
	}
	else if (temp[0] == '1' || strcmp("true", temp) == 0) {
		return qtrue;
	}
	else {
		pc_token_t token;
		flag_keywordHash_t *key;
		int invertFlag = qfalse;

		// If '!' change visibility to invisibility
		if (temp[0] == '!') {
			if (!trap_PC_ReadToken(handle, &token)) {
				return qfalse;
			}
			temp = token.string;
			invertFlag = qtrue;
		}

		// add flag for keywords: VIS_NEVER | VIS_IN_MENU | etc.
		key = flag_KeywordHash_Find(flag_KeywordHash, (char *)temp);
		if (key) {
			if (invertFlag)
				itm->visible_prop_flags[1] |= key->flag;
			else
				itm->visible_prop_flags[0] |= key->flag;
			return qtrue;
		}

		// add flag for keywords: VIS_GT_FFA | VIS_GT_CTF | etc.
		key = GT_Vis_KeywordHash_Find(GT_Vis_KeywordHash, (char *)temp);
		if (key) {
			if (invertFlag)
				itm->visible_GT_flags[1] |= key->flag;
			else
				itm->visible_GT_flags[0] |= key->flag;
			return qtrue;
		}

		// add flag for keywords: VAL_HEALTH | VAL_ARMOR | etc.
		key = value_KeywordHash_Find(value_KeywordHash, (char *)temp);
		if (key) {		
			if (invertFlag)
				itm->visible_val_flags[1] |= key->flag;
			else
				itm->visible_val_flags[0] |= key->flag;
			return qtrue;
		}

		//Com_Printf("visibility key not found: %s\n", temp);
		return qfalse;
	}
}

static qboolean prop_visible(item_t *itm, int handle) {
	qboolean defaultValue = qtrue;
	const char *temp;
	qboolean end = qfalse;

	// several visibility flag possible, so we loop until parse error
	// then keep token on error (we can't unread a token)
	while (!end) {
		if (PC_String_Parse(handle, &temp)) {
			if (temp[0] == '}') {
				itemEnd = qtrue;
				return qtrue;
			}

			if (addVisibilityFlags(itm, handle, temp)) {
				continue;
			}
			else {
				needCacheToken = qtrue;
				cacheTokenStr = (char *)temp;
				end = qtrue;
			}
		}
		else {
			needCacheToken = qtrue;
			cacheTokenStr = (char *)temp;
			end = qtrue;
			// 'visible' alone is enough
			return qtrue;
		}
	}

	return qtrue;
}

static int parentIndex(const char *parentName) {
	int i;

	for (i = itemCount; i >= 0; i--) {
		if (strcmp(itemArray[i].item_name, parentName) == 0) {
			return itemArray[i].order;
		}
	}

	// it could be one of the dynamics item
	for (i = dyn_itemCount; i >= 0; i--) {
		if (strcmp(dyn_itemArray[i].item_name, parentName) == 0) {
			// use sign to indicate that parent is in dyn_itemArray
			return -dyn_itemArray[i].order;
		}
	}

	// use previous item if parent not found, and warn user.
	Com_Printf("parent item '%s' not found. Parent must be placed before the item.\n", parentName);
	return itemCount - 1;
}

static qboolean prop_parent(item_t *itm, int handle) {
	const char *temp;
	if (PC_String_Parse(handle, &temp)) {
		int idx = parentIndex(temp);

		if (idx == 0) {
			PC_SourceError(handle, "HUD item parent not found: %s \n", temp);
			return qfalse;
		}
		else {
			itm->parent = idx;
			return qtrue;
		}
	}
	return qfalse;
}

static qboolean prop_valign(item_t *itm, int handle) {
	const char *temp;
	if (PC_String_Parse(handle, &temp)) {
		if (temp[0] == 'T')
			itm->propFlags |= PROP_VALIGN_TOP;
		else if (temp[0] == 'M')
			itm->propFlags |= PROP_VALIGN_MIDDLE;
		else if (temp[0] == 'B')
			itm->propFlags |= PROP_VALIGN_BOTTOM;
		else
		{
			needCacheToken = qtrue;
			cacheTokenStr = (char *)temp;
			return qfalse;
		}
		return qtrue;
	}
	return qfalse;
}

static qboolean prop_cvarTest(item_t *itm, int handle) {
	const char *temp;
	if (!PC_String_Parse(handle, &temp)) {
		return qfalse;
	}
	else {
		cvarTest_keywordHash_t *key;
		char *tmp = (char *)temp;
		key = cvarTest_KeywordHash_Find(cvarTest_KeywordHash, tmp);
		if (!key) {
			PC_SourceError(handle, "unknown cvar %s", tmp);
		}
		else {
			itm->cvarTest_flags |= key->flag;
		}
	}
	return qtrue;
}

static qboolean ParseFlags(const char *s, unsigned int *flags, int handle) {
	flag_keywordHash_t *key;
	key = value_KeywordHash_Find(value_KeywordHash, (char *)s);
	if (!key) {
		//PC_SourceError(handle, "HUD item unknown value/caption: %s", s);
		return qfalse;
	}
	else {
		*flags |= key->flag;
		return qtrue;
	}
}

static qboolean prop_gradient(item_t *itm, int handle) {
	const char *s;
	if (PC_String_Parse(handle, &s)) {
		if (*s == '!') {
			itm->propFlags |= PROP_GRADIENT_INVERT;
			if (!PC_String_Parse(handle, &s)) {
				Com_Printf("Error HUD item %s, can't parse property 'gradient': %s", itm->item_name, s);
				return qfalse;
			}
		}
		return ParseFlags(s, &itm->gradientFlags, handle);
	}
	else {
		Com_Printf("Error HUD item %s, can't parse property 'gradient': %s", itm->item_name, s);
		return qfalse;
	}
}

static qboolean prop_caption(item_t *itm, int handle) {
	const char *s;
	if (PC_String_Parse(handle, &s)) {
		if (!ParseFlags(s, &itm->text.flags, handle)) {
			itm->text.caption = (char *)s;
			itm->text.flags |= VAL_TEXT;
		}
		return qtrue;
	}
	else {
		Com_Printf("Error HUD item %s, can't parse property 'caption': %s", itm->item_name, s);
		return qfalse;
	}
}


/*
===============
Hud items list hash
===============
*/
void items_KeywordHash_Add(items_keywordHash_t *table[], items_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

items_keywordHash_t *items_KeywordHash_Find(items_keywordHash_t *table[], char *keyword)
{
	items_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

items_keywordHash_t *items_KeywordHash[KEYWORDHASH_SIZE];

void items_SetupKeywordHash(void) {
	int i;
	memset(items_KeywordHash, 0, sizeof(items_KeywordHash));
	for (i = 0; item_Keywords[i].keyword; i++) {
		items_KeywordHash_Add(items_KeywordHash, &item_Keywords[i]);
	}
}

/*
===============
specifics items list hash
===============
*/
specifics_keywordHash_t specifics_item_Keywords[] = {
	{"INFO",			NULL},
	{"SetCvar",			NULL},
	{"HealthColors",	NULL},
	{"ArmorColors",		NULL},
	{"AmmoColors",		NULL},
	{"TeamsColors",		NULL},
	{"GameTypeIcons",	NULL},
	//{"WeaponIcons",	NULL},//TODO
	//{"AmmoIcons",		NULL},//TODO
	{NULL,				NULL}
};

void specifics_items_KeywordHash_Add(specifics_keywordHash_t *table[], specifics_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

specifics_keywordHash_t *specifics_items_KeywordHash_Find(specifics_keywordHash_t *table[], char *keyword)
{
	specifics_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

specifics_keywordHash_t *specifics_KeywordHash[KEYWORDHASH_SIZE];

void specifics_items_SetupKeywordHash(void) {
	int i;
	memset(specifics_KeywordHash, 0, sizeof(specifics_KeywordHash));
	for (i = 0; specifics_item_Keywords[i].keyword; i++) {
		specifics_items_KeywordHash_Add(specifics_KeywordHash, &specifics_item_Keywords[i]);
	}
}

/*
===============
Dynamics items list hash
===============
*/
item_t dyn_itemArray[MAX_HUD_ITEM];
int dyn_itemCount;

int IcoWeapList_idx;
int IcoWeapListSel_idx;
int WeapListSelName_idx;
int IcoPowerUp_idx;
int WarmFightMsg_idx;
int KillMsg_idx;
int ItemMsg_idx;
int ServerMsg_idx;
int TeamOverlay_Sel_idx;

dyn_items_keywordHash_t dyn_item_Keywords[] = {
	{"Icon_WeaponList",				&IcoWeapList_idx,		NULL},
	{"Icon_WeaponList_Selected",	&IcoWeapListSel_idx,	NULL},
	{"WeaponList_SelectedName",		&WeapListSelName_idx,	NULL},
	{"KillMessage",					&KillMsg_idx,			NULL},
	{"ItemMessage",					&ItemMsg_idx,			NULL},
	{"WarmupFightMessage",			&WarmFightMsg_idx,		NULL},
	{"ServerMessage",				&ServerMsg_idx,			NULL},
	{"Icon_PowerUp",				&IcoPowerUp_idx,		NULL},
	{"TeamOverlay_Selected",		&TeamOverlay_Sel_idx,	NULL},
	{NULL,							NULL,					NULL}
};

dyn_items_keywordHash_t *dyn_KeywordHash[KEYWORDHASH_SIZE];

void dyn_items_KeywordHash_Add(dyn_items_keywordHash_t *table[], dyn_items_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

void dyn_items_SetupKeywordHash(void) {
	int i;
	memset(dyn_KeywordHash, 0, sizeof(dyn_KeywordHash));
	for (i = 0; dyn_item_Keywords[i].keyword; i++) {
		dyn_items_KeywordHash_Add(dyn_KeywordHash, &dyn_item_Keywords[i]);
	}
}

dyn_items_keywordHash_t *dyn_items_KeywordHash_Find(dyn_items_keywordHash_t *table[], char *keyword)
{
	dyn_items_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}


/*
===============
properties list hash
===============
*/
typedef struct prop_keywordHash_s
{
	char *keyword;
	qboolean(*ownerDraw)(item_t *itm, int handle);
	struct prop_keywordHash_s *next;
} prop_keywordHash_t;


void prop_KeywordHash_Add(prop_keywordHash_t *table[], prop_keywordHash_t *key) {
	int hash;

	hash = KeywordHash_Key(key->keyword);
	key->next = table[hash];
	table[hash] = key;
}

prop_keywordHash_t *prop_KeywordHash_Find(prop_keywordHash_t *table[], char *keyword)
{
	prop_keywordHash_t *key;
	int hash;

	hash = KeywordHash_Key(keyword);
	for (key = table[hash]; key; key = key->next) {
		if (!Q_stricmp(key->keyword, keyword))
			return key;
	}
	return NULL;
}

// CPMA compatibility
/*static qboolean prop_textstyle(item_t *itm, int handle) {
	int res;
	if (!PC_Int_Parse(handle, &res)) {
		return qfalse;
	}
	if (res == 1) {
		itm->text.styleflags |= DS_SHADOW;
	}
	//what other textstyle value do?
	return qtrue;
}
// do nothing, it's for CPMA compatibility
static qboolean prop_textoffset(item_t *itm, int handle) {
	int res;
	if (!PC_Int_Parse(handle, &res)) {
		return qfalse;
	}
	else {
		if (!PC_Int_Parse(handle, &res)) {
			return qfalse;
		}
	}
	return qtrue;
}

// do nothing, it's for CPMA compatibility
static qboolean imagetc_Parse(int handle, margin_t *m) {
	int paramNb = 0;
	float res;
	if (PC_Float_Parse(handle, &res)) {
		paramNb++;
		if (PC_Float_Parse(handle, &res)) {
			paramNb++;
			if (PC_Float_Parse(handle, &res)) {
				paramNb++;
				if (PC_Float_Parse(handle, &res)) {
					paramNb++;
					return qtrue;
				}
			}
		}
	}
	return (paramNb > 0);
}
// do nothing, it's for CPMA compatibility
static qboolean prop_imagetc(item_t *itm, int handle) {
	if (!imagetc_Parse(handle, &itm->margin)) {
		return qfalse;
	}
	return qtrue;
}*/

prop_keywordHash_t itemProperty_Keywords[] = {
	{"name",		prop_name,			NULL},
	{"rect",		prop_rect,			NULL},
	{"background",	prop_background,	NULL},
	{"icon3D",		prop_icon3D,		NULL},
	{"cvarTest",	prop_cvarTest,		NULL},
	{"verticalbar", prop_verticalbar,	NULL},
	{"textalign",	prop_textalign,		NULL},
	{"fontsize",	prop_Size,			NULL},
	{"font",		prop_font,			NULL},
	{"param",		prop_param,			NULL},
	{"forecolor",	prop_forecolor,		NULL},
	{"backcolor",	prop_backcolor,		NULL},
	{"anchors",		prop_anchors,		NULL},
	{"fill",		prop_fill,			NULL},
	{"blink",		prop_BlinkWhenLow,	NULL},
	{"time",		prop_time,			NULL},
	{"visible",		prop_visible,		NULL},
	{"pulseScale",	prop_pulseScale,	NULL},
	{"proportional",prop_proportional,	NULL},
	{"shadow",		prop_shadow,		NULL},
	{"margin",		prop_margin,		NULL},
	{"valign",		prop_valign,		NULL},
	{"parent",		prop_parent,		NULL},
	{"gradient",	prop_gradient,		NULL},
	{"caption",		prop_caption,		NULL},
	{"team_player",	prop_TeamPlayer,	NULL},
	/*
	// CPMA compatibility
	{"color",		prop_forecolor,		NULL},
	{"bgcolor",		prop_backcolor,		NULL},
	{"image",		prop_background,	NULL},
	{"textstyle",	prop_textstyle,		NULL}, // do nothing
	{"visflags",	prop_textstyle,		NULL}, // do nothing
	{"alignh",		prop_textalign,		NULL},
	{"text",		prop_caption,		NULL},
	{"textoffset",	prop_textoffset,	NULL},	// do nothing
	{"imagetc",		prop_imagetc,		NULL},	// do nothing
	{"monospace",	prop_proportional,	NULL},
	*/

	/*
	// only usefull in UIGAME
	{"name",		prop_HUDname,			NULL},	// name of the HUD file
	{"author",		prop_HUDauthor,		NULL},	// author of the HUD file
	{"description",	prop_HUDdescription,	NULL},	// HUD short description
	*/
	{NULL,			0,					NULL}
};

prop_keywordHash_t *prop_KeywordHash[KEYWORDHASH_SIZE];

void prop_SetupKeywordHash(void) {
	int i;

	memset(prop_KeywordHash, 0, sizeof(prop_KeywordHash));
	for (i = 0; itemProperty_Keywords[i].keyword; i++) {
		prop_KeywordHash_Add(prop_KeywordHash, &itemProperty_Keywords[i]);
	}
}

/*
=================
itemProperties_Parse
parse properties (rect, image, ...) of each item
=================
*/
qboolean itemProperties_Parse(item_t *itm, int handle) {
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
		if (itemEnd) {
			itemEnd = qfalse;
			return qtrue;
		}

		if (propertyEnd) {
			key = prop_KeywordHash_Find(prop_KeywordHash, token.string);
			propertyEnd = qfalse;
		}	
		else if (needCacheToken) {
			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
				resetTokenCache();
				continue;
			}
			key = prop_KeywordHash_Find(prop_KeywordHash, cacheTokenStr);
			//resetTokenCache();
		}
		else {
			memset(&token, 0, sizeof(pc_token_t));

			if (!trap_PC_ReadToken(handle, &token)) {
				PC_SourceError(handle, "end of file inside property");
				return qfalse;
			}
			else if (*token.string == '}') {
				return qtrue;
			}
			else if (*token.string == ';' || *token.string == ',') {
				continue;
			}

			key = prop_KeywordHash_Find(prop_KeywordHash, token.string);
		}

		if (!key) {
			PC_SourceError(handle, "unknown property keyword %s", token.string);
			continue;
		}

		resetTokenCache();

		if (!key->ownerDraw((item_t *)itm, handle)) {
			PC_SourceError(handle, "couldn't parse property keyword %s", token.string);
			return qfalse;
		}
	}
	return qfalse;
}

// read until end of item
static qboolean skipItem(int handle) {
	pc_token_t token;
	while (*token.string != '}') {
		if (!trap_PC_ReadToken(handle, &token)) {
			return qfalse;
		}
	}
	return qtrue;
}

qboolean cvar_update(int handle, vmCvar_t *cvar) {
	int val;
	if (!PC_Int_Parse(handle, &val)) {
		return qfalse;
	}
	cvar->integer = val;
	return qtrue;
}

// Parse cvar_t and change cvar_t state
static qboolean script_Parse(int handle ) {
	pc_token_t token;
	cvarTest_keywordHash_t *key;

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

		if (needCacheToken)
		{
			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
				continue;
			}
			key = cvarTest_KeywordHash_Find(cvarTest_KeywordHash, cacheTokenStr);
			resetTokenCache();
		}
		else
		{
			memset(&token, 0, sizeof(pc_token_t));

			if (!trap_PC_ReadToken(handle, &token)) {
				PC_SourceError(handle, "end of file inside script");
				return qfalse;
			}

			if (*token.string == '}') {
				return qtrue;
			}
			if (*token.string == ';' || *token.string == ',') {
				continue;
			}
			key = cvarTest_KeywordHash_Find(cvarTest_KeywordHash, token.string);
		}

		if (!key) {
			PC_SourceError(handle, "unknown script keyword %s", token.string);
			continue;
		}

		if (!cvar_update(handle, key->cvar)) {
			PC_SourceError(handle, "couldn't parse script keyword %s", token.string);
			return qfalse;
		}
	}
	return qfalse;
}


qboolean parseColorItem(int handle, float array_colors[4][4]) {
	pc_token_t token;
	cvarTest_keywordHash_t *key;
	int colorIdx;

	if (!trap_PC_ReadToken(handle, &token)) {
		return qfalse;
	}

	if (*token.string != '{') {
		return qfalse;
	}

	colorIdx = 0;

	while (1) {
		// we can't unread token, so we check last token on parse error
		if (itemEnd)
		{
			itemEnd = qfalse;
			return qtrue;
		}

		if (needCacheToken)
		{
			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
				continue;
			}
			key = cvarTest_KeywordHash_Find(cvarTest_KeywordHash, cacheTokenStr);
			resetTokenCache();
		}
		else
		{
			memset(&token, 0, sizeof(pc_token_t));

			if (!trap_PC_ReadToken(handle, &token)) {
				PC_SourceError(handle, "end of file inside hud file");
				return qfalse;
			}

			if (*token.string == '}') { // exit the loop
				return qtrue;
			}

			if (*token.string == ';' || *token.string == ',') {
				continue;
			}

			if (strcmp("color", token.string) == 0) {
				if (!PC_Color_Parse(handle, &array_colors[colorIdx])) {
					Com_Printf("Parse color item error <%s>\n", token.string);
					return qfalse;
				}
				colorIdx++;
			}
		}
	}
	return qfalse;
}


static qboolean parse_one_gameType_icons(int handle, int GameTypeIdx) {
	const char *s;
	if (!PC_String_Parse(handle, &s)) {
		return qfalse;
	}

	cgs.media.gameTypeShader[GameTypeIdx] = trap_R_RegisterShaderNoMip(s);
	return qtrue;
}

// parse GameTypeIcons
qboolean parse_gameType_icons(int handle) {
	pc_token_t token;
	cvarTest_keywordHash_t *key;
	int GameTypeIdx;

	if (!trap_PC_ReadToken(handle, &token)) {
		return qfalse;
	}

	if (*token.string != '{') {
		return qfalse;
	}

	GameTypeIdx = 0;

	while (1) {
		// we can't unread token, so we check last token on parse error
		if (itemEnd)
		{
			itemEnd = qfalse;
			return qtrue;
		}

		if (needCacheToken)
		{
			if (*cacheTokenStr == ';' || *cacheTokenStr == ',') {
				continue;
			}
			key = cvarTest_KeywordHash_Find(cvarTest_KeywordHash, cacheTokenStr);
			resetTokenCache();
		}
		else
		{
			memset(&token, 0, sizeof(pc_token_t));

			if (!trap_PC_ReadToken(handle, &token)) {
				PC_SourceError(handle, "end of file inside hud file");
				return qfalse;
			}

			if (*token.string == '}') { // exit the loop
				return qtrue;
			}

			if (*token.string == ';' || *token.string == ',') {
				continue;
			}

			if (strcmp("background", token.string) == 0) {
				if (!parse_one_gameType_icons(handle, GameTypeIdx)) {
					Com_Printf("GameTypeIcons parse error\n");
					return qfalse;
				}
				GameTypeIdx++;
			}
		}
	}
	return qfalse;
}

static qboolean parse_specifics(int handle, pc_token_t *token) {
	specifics_keywordHash_t *key;

	// Check if non-HUD part
	key = specifics_items_KeywordHash_Find(specifics_KeywordHash, token->string);
	if (!key) {
		return qfalse;
	}

	if (strcmp("SetCvar", token->string) == 0) {
		script_Parse(handle);
		return qtrue;
	}
	else if (strcmp("INFO", token->string) == 0) {
		// 'INFO' properties are only needed in UIGAME 
		skipItem(handle);
		return qtrue;
	}
	else if (strcmp("HealthColors", token->string) == 0) {
		parseColorItem(handle, health_colors);
		return qtrue;
	}
	else if (strcmp("ArmorColors", token->string) == 0) {
		parseColorItem(handle, armor_colors);
		return qtrue;
	}
	else if (strcmp("AmmoColors", token->string) == 0) {
		parseColorItem(handle, ammo_colors);
		return qtrue;
	}
	else if (strcmp("TeamsColors", token->string) == 0) {
		parseColorItem(handle, teams_colors);
		return qtrue;
	}
	else if (strcmp("GameTypeIcons", token->string) == 0) {
		parse_gameType_icons(handle);
		return qtrue;
	}
	else {
		PC_SourceError(handle, "unknown specific_items keyword %s \n", token->string);
		return qfalse;
	}
}

static const struct item_t EmptyItem;

static qboolean parse_dynamics(int handle, pc_token_t *token) {
	dyn_items_keywordHash_t *key;

	// Check if non-HUD part
	key = dyn_items_KeywordHash_Find(dyn_KeywordHash, token->string);
	if (!key) {
		return qfalse;
	}
	else {
		dyn_itemArray[dyn_itemCount] = EmptyItem;

		// in order to find parent index
		dyn_itemArray[dyn_itemCount].order = itemCount;

		// keep item name (may be overwritten by name property)
		strcpy(dyn_itemArray[dyn_itemCount].item_name, token->string);

		// associate with index, by using pointer
		*key->idx = dyn_itemCount;

		// item matched, parse its properties
		itemProperties_Parse(&dyn_itemArray[dyn_itemCount], handle);

		dyn_itemCount++;
		return qtrue;
	}
}


qboolean HUDitems_Parse( int handle ) {
	pc_token_t token;
	items_keywordHash_t *key;

	// clear the HUD items arrays
	memset(&itemArray, 0, sizeof(itemArray));
	memset(&dyn_itemArray, 0, sizeof(dyn_itemArray));
	itemCount = dyn_itemCount = 0;

	while (1) {
		memset(&token, 0, sizeof(pc_token_t));

		if ( !trap_PC_ReadToken( handle, &token ) ) {
			if ( *token.string == '#' )
				return qfalse; // stop on preprocessor error
			
			return qtrue; // EOF
		}

		if (*token.string == '}') {
			return qtrue;
		}

		if (*token.string == '{') {
			continue;
		}
		// std separators
		else if (*token.string == ',' || *token.string == ';') {
			continue;
		}
		// CPMA compatibility (not anymore compatible)
		else if (*token.string == '!') {
			continue;
		}

		if (parse_specifics(handle, &token)) {
			continue;
		}

		if (parse_dynamics(handle, &token)) {
			continue;
		}

		key = items_KeywordHash_Find(items_KeywordHash, token.string);

		if ( !key ) {
			PC_SourceError(handle, "unknown HUD keyword item %s \n", token.string);
			continue;
		}
		else {
			itemArray[itemCount] = EmptyItem;

			// in order to find parent index
			itemArray[itemCount].order = itemCount;

			// keep item name (may be overwritten by name property)
			strcpy(itemArray[itemCount].item_name, token.string);
			
			// item matched, parse its properties
			itemProperties_Parse(&itemArray[itemCount], handle);

			// use pointer to associate specific draw function with item
			itemArray[itemCount].DrawItem = *key->draw_item;

			itemCount++;
		}
	}
	return qfalse;
}


qboolean HUD_FullParse( const char *filePath ) {
	int handle;
	qboolean res;

	resetTokenCache();

	Com_Printf("<%s> loading... \n", filePath);

	handle = trap_PC_LoadSource( filePath );

	if ( !handle ) {
		Com_Printf("HUD file not found <%s>\n", filePath);
		return qfalse;
	}
	
	res = HUDitems_Parse( handle );

	if (res) {
		loadedHUDfilePath = String_Alloc(filePath);
	}

	trap_PC_FreeSource(handle);
	return res;
}


/*
=================
CG_Load_Selected_HUD()
read cvar_t 'cg_hudFiles'
and load HUD
=================
*/
qboolean CG_CheckHUD( void ) {
	char buff[1024];
	char *hudSet;

	memset(buff, 0, sizeof(buff));

	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
	hudSet = buff;
	if (hudSet[0] == '\0') {
		hudSet = DEFAULT_HUD;
	}

	// don't load anything if same HUD
	if ( strcmp(loadedHUDfilePath, hudSet) == 0 ) {
		return qfalse;
	}

	// load HUD
	return HUD_FullParse( hudSet );
}


/*
=================
String_Init
=================
*/
void String_Init(void) {
	int i;
	for (i = 0; i < HASH_TABLE_SIZE; i++) {
		strHandle[i] = NULL;
	}
	strHandleCount = 0;
	strPoolIndex = 0;
	UI_InitMemory();
	// done once, but as we want to go fast,
	// we use keyword hash tables
	items_SetupKeywordHash();
	specifics_items_SetupKeywordHash();
	dyn_items_SetupKeywordHash();
	prop_SetupKeywordHash();
	flag_SetupKeywordHash();
	cvarTest_SetupKeywordHash();
	GT_Vis_SetupKeywordHash();
	value_SetupKeywordHash();
}


/*
=================
String_Alloc
=================
*/
const char *String_Alloc( const char *p ) {
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

		str = HUD_Alloc(sizeof(stringDef_t));
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

#endif // NEOHUD

