/*
==============================================================================

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/sciproto
$origin 0 -6 24
$base base
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17 stand18 stand19 

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8

/*
==============================================================================
SOLDIER CODE
==============================================================================
*/
void() scimgenforcer_fire =
{
	local vector org;

	// self.effects = self.effects | EF_MUZZLEFLASH; //redundant -- dumptruck_ds
	makevectors (self.angles);

	org = self.origin + v_forward * 30 + v_right * 5 + '0 0 12';

	LaunchLaser(org, self.enemy.origin - self.origin);
};
/*
================
GruntFireGrenadeScim
================
*/
void() GruntFireGrenadeScim =
{
	local	entity missile;

	// self.effects = self.effects | EF_MUZZLEFLASH; //redundant -- dumptruck_ds

	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;

// set missile speed

	makevectors (self.angles);

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 600;
	missile.velocity_z = 200;

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);

	missile.touch = OgreGrenadeTouch;

// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = OgreGrenadeExplode;

	// setmodel (missile, "progs/grenade.mdl");
	if (self.mdl_proj != "") // dumptruck_ds
	{
			setmodel (missile, self.mdl_proj);
		}
		else
		{
			setmodel (missile, "progs/grenade.mdl");
	}

	if (!missile.skin_proj) // dumptruck_ds
	{
			missile.skin = self.skin_proj;
		}
		else
		{
			missile.skin = 0;
	}

	setsize (missile, '0 0 0', '0 0 0');
	setorigin (missile, self.origin + v_forward * 30 + v_right * 5 + '0 0 16'); //dumptruck_ds
};

/*
================
MonFireSpikeScim // used for Grunts
================
*/

void() MonFireSpikeScim =
{
    local vector dir;
    // local entity old;

    sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
    self.attack_finished = time + 0.2;

    dir = normalize (self.enemy.origin - self.origin);
		makevectors (self.angles); //thanks Voidforce -- dumptruck_ds

    launch_spike (self.origin + v_forward * 30 + v_right * 5 + '0 0 12', dir);  //dumptruck_ds
    // launch_spike (self.origin + '0 0 16', dir);

    newmis.touch = superspike_touch;
    // setmodel (newmis, "progs/s_spike.mdl");
		if (self.mdl_proj != "") // dumptruck_ds
		{
				setmodel (newmis, self.mdl_proj);
			}
			else
			{
				setmodel (newmis, "progs/s_spike.mdl");
		}

		if (!newmis.skin_proj) // dumptruck_ds
		{
				newmis.skin = self.skin_proj;
			}
			else
			{
				newmis.skin = 0;
		}
	// dumptruck_ds - end

    setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
};

void() scim_fire;

void()	scim_stand1	=[	$stand1,	scim_stand2	] {ai_stand();};
void()	scim_stand2	=[	$stand2,	scim_stand3	] {ai_stand();};
void()	scim_stand3	=[	$stand3,	scim_stand4	] {ai_stand();};
void()	scim_stand4	=[	$stand4,	scim_stand5	] {ai_stand();};
void()	scim_stand5	=[	$stand5,	scim_stand6	] {ai_stand();};
void()	scim_stand6	=[	$stand6,	scim_stand7	] {ai_stand();};
void()	scim_stand7	=[	$stand7,	scim_stand8	] {ai_stand();};
void()	scim_stand8	=[	$stand8,	scim_stand9	] {ai_stand();};
void()	scim_stand9	=[	$stand9,	scim_stand10	] {ai_stand();};

void()	scim_stand10	=[	$stand10,	scim_stand11	] {ai_stand();};

void()	scim_stand11	=[	$stand11,	scim_stand12	] {ai_stand();};
void()	scim_stand12	=[	$stand12,	scim_stand13	] {ai_stand();};
void()	scim_stand13	=[	$stand13,	scim_stand14	] {ai_stand();};
void()	scim_stand14	=[	$stand14,	scim_stand15	] {ai_stand();};
void()	scim_stand15	=[	$stand15,	scim_stand16	] {ai_stand();};
void()	scim_stand16	=[	$stand16,	scim_stand17	] {ai_stand();};
void()	scim_stand17	=[	$stand17,	scim_stand18	] {ai_stand();};
void()	scim_stand18	=[	$stand18,	scim_stand19	] {ai_stand();};
void()	scim_stand19	=[	$stand19,	scim_stand1	] {ai_stand();};

void()	scim_walk1	=[	$walk1,	scim_walk2	] {
if (random() < 0.2)
	sound_idle (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_walk(2);};
void()	scim_walk2	=[	$walk2,	scim_walk3	] {ai_walk(6);};
void()	scim_walk3	=[	$walk3,	scim_walk4	] {ai_walk(6);};
void()	scim_walk4	=[	$walk4,	scim_walk5	] {ai_walk(6);};
void()	scim_walk5	=[	$walk5,	scim_walk6	] {ai_walk(6);};
void()	scim_walk6	=[	$walk6,	scim_walk7	] {ai_walk(6);};
void()	scim_walk7	=[	$walk7,	scim_walk8	] {ai_walk(6);};
void()	scim_walk8	=[	$walk8,	scim_walk1	] {ai_walk(6);};

void()	scim_run1	=[	$walk1,	scim_walk2	] {
if (random() < 0.2)
	sound_idle (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_walk(2);};
void()	scim_run2	=[	$walk2,	scim_walk3	] {ai_run(12);};
void()	scim_run3	=[	$walk3,	scim_walk4	] {ai_run(12);};
void()	scim_run4	=[	$walk4,	scim_walk5	] {ai_run(12);};
void()	scim_run5	=[	$walk5,	scim_walk6	] {ai_run(12);};
void()	scim_run6	=[	$walk6,	scim_walk7	] {ai_run(12);};
void()	scim_run7	=[	$walk7,	scim_walk8	] {ai_run(12);};
void()	scim_run8	=[	$walk8,	scim_walk1	] {ai_run(12);};

void(entity attacker, float damage)	scim_pain =
{
	local float r;

	if (self.pain_finished > time)
		return;

	r = random();

	if (r < 0.2)
	{
		self.pain_finished = time + 0.6;
		scim_stand1 ();
		sound_pain (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		self.pain_finished = time + 1.1;
		scim_stand1 ();
		sound_misc (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		self.pain_finished = time + 1.1;
		scim_stand1 ();
		sound_misc (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
};

void() scim_fire =
{ //dumptruck_ds start rocket grunt stuff

if (self.style == 1)

	{
		ai_face();

		W_GruntRocket();
	}

else if (self.style == 2)

	{
		ai_face();
		GruntFireGrenadeScim();
	}

else if (self.style == 3)

	{
		ai_face();
		scimgenforcer_fire();
	}

else if (self.style == 4)

	{
		ai_face();
		MonFireSpikeScim();
	}

else

	{
		local	vector	dir;
		local	entity	en;

		ai_face();

		sound_attack (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);

		// fire somewhat behind the player, so a dodging player is harder to hit
		en = self.enemy;

		dir = en.origin - en.velocity*0.2;
		dir = normalize (dir - self.origin);

		FireBullets (4, dir, '0.1 0.1 0');
	}

};

void()	scim_die1	=[	$stand1,	scim_die2	] {};
void()	scim_die2	=[	$stand1,	scim_die3	] {};
void()	scim_die3	=[	$stand1,	scim_die4	]
{self.solid = SOLID_NOT;
// style ammotype check -- dumptruck_ds
	if (self.style == 1)
	{
		self.ammo_rockets = 2;
	}
	if (self.style == 2)
	{
		self.ammo_rockets = 2;
	}
	if (self.style == 3)
	{
		self.ammo_cells = 5;
	}
	if (self.style == 4)
	{
		self.ammo_nails = 5;
	}
	else if (self.style == 0)
	{
		self.ammo_shells = 5;
	}
if(!self.keep_ammo)DropBackpack();};
void()	scim_die4	=[	$stand1,	scim_die5	] {};
void()	scim_die5	=[	$stand1,	scim_die6	] {};
void()	scim_die6	=[	$stand1,	scim_die7	] {};
void()	scim_die7	=[	$stand1,	scim_die8	] {};
void()	scim_die8	=[	$stand1,	scim_die9	] {};
void()	scim_die9	=[	$stand1,	scim_die10	] {};
void()	scim_die10	=[	$stand1,	scim_die10	] {};

void()	scim_cdie1	=[	$stand1,	scim_cdie2	] {};
void()	scim_cdie2	=[	$stand1,	scim_cdie3	] {ai_back(5);};
void()	scim_cdie3	=[	$stand1,	scim_cdie4	]
{self.solid = SOLID_NOT;
// style ammotype check -- dumptruck_ds
	if (self.style == 1)
	{
		self.ammo_rockets = 2;
	}
	if (self.style == 2)
	{
		self.ammo_rockets = 2;
	}
	if (self.style == 3)
	{
		self.ammo_cells = 5;
	}
	if (self.style == 4)
	{
		self.ammo_nails = 5;
	}
	else if (self.style == 0)
	{
		self.ammo_shells = 5;
	}
if(!self.keep_ammo)DropBackpack();ai_back(4);}; //dumptruck_ds
void()	scim_cdie4	=[	$stand1,	scim_cdie5	] {ai_back(13);};
void()	scim_cdie5	=[	$stand1,	scim_cdie6	] {ai_back(3);};
void()	scim_cdie6	=[	$stand1,	scim_cdie7	] {ai_back(4);};
void()	scim_cdie7	=[	$stand1,	scim_cdie8	] {};
void()	scim_cdie8	=[	$stand1,	scim_cdie9	] {};
void()	scim_cdie9	=[	$stand1,	scim_cdie10	] {};
void()	scim_cdie10	=[	$stand1,	scim_cdie11	] {};
void()	scim_cdie11	=[	$stand1,	scim_cdie11	] {};


void() scim_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		if (self.mdl_head != "") //dumptruck_ds custom_mdls
		{
			ThrowHead (self.mdl_head, self.health);
		}
		else
		{
			ThrowHead ("progs/h_guard.mdl", self.health);
		}
		// ThrowGib ("progs/gib1.mdl", self.health);
		// ThrowGib ("progs/gib2.mdl", self.health);
		// ThrowGib ("progs/gib3.mdl", self.health);
		if (self.mdl_gib1 != "") // custom models -- dumptruck_ds
		{
			ThrowGib (self.mdl_gib1, self.health);
		}
		else
		{
			ThrowGib ("progs/gib1.mdl", self.health);
		}
		if (self.mdl_gib2 != "")
		{
			ThrowGib (self.mdl_gib2, self.health);
		}
		else
		{
			ThrowGib ("progs/gib2.mdl", self.health);
		}
		if (self.mdl_gib3 != "")
		{
			ThrowGib (self.mdl_gib3, self.health);
		}
		else
		{
			ThrowGib ("progs/gib3.mdl", self.health);
		}
		DropStuff();
		return;
	}

// regular death
	sound_death (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	DropStuff();
	if (random() < 0.5)
		scim_die1 ();
	else
		scim_cdie1 ();
};


/*QUAKED monster_scim (1 0 0) (-16 -16 -24) (16 16 40) AMBUSH X X TRIGGER_SPAWNED X X X X NOT_ON_EASY NOT_ON_NORMAL NOT_ON_HARD_OR_NIGHTMARE NOT_IN_DEATHMATCH NOT_IN_COOP NOT_IN_SINGLEPLAYER X NOT_ON_HARD_ONLY NOT_ON_NIGHTMARE_ONLY
{
	model ("progs/soldier.mdl");
}
Grunt.

Default health = 30"

keep_ammo "1 = Don't drop backpack upon death"
snd_death "Path to custom death sound"
snd_pain "Path to custom pain sound"
snd_sight "Path to custom sight sound"
snd_attack "Path to custom attack sound (GUNSHOT)"
snd_idle "Path to custom idle sound"
snd_misc "Path to custom sound (PAIN 2)"

mdl_head(string) : "Path to custom head model"
mdl_body(string) : "Path to custom body model"
skin_head(float) : "Skin index of custom head model"
mdl_gib1(string) : "Path to custom 1st gib model"
mdl_gib2(string) : "Path to custom 2nd gib model"
mdl_gib3(string) : "Path to custom 3rd gib model"

style "Attack type"
0 "Default (shotgun)"
1 "Rockets"
2 "Grenades"
3 "lasers"
4 "Nails"

effects(choices) : "Add a visual effect to an entity"
0 : "None (Default)"
1 : "Brightfield (yellow particles)"
4 : "Bright light"
8 : "Dim light"

berserk(choices) "Skips certain pain animations similar to skill 3 (Makes a semi-nightmare monster!)"
0 : "Off (Default)"
1 : "Berserk (skip pain animations)"

delay(float) : "Delay spawn in for this amount of time"

wait(choices) : "Play an effect when trigger spawned?"
0 : "Teleport Effects (Default)"
1 : "Spawn Silently"

spawn_angry(Choices)
0 : "Only when trigger spawned, default behavior - not angry"
1 : "Only when trigger spawned, set to 1 to spawn angry at player"

health(integer) : "Set this to a custom health amount"
pain_target(string) : "Fire this target when pain_threshold is reached"
pain_threshold(integer) : "Fire pain_target when health drops below this amount"
sight_trigger(integer) : "1 = Fire target upon seeing the player instead of death"
skin(integer) : "Skin index (default 0) Use this when your custom model has more than one skin to select"
obit_name(string) : "When used with obit_method, this will set part of the text for a custom obituary. e.g. a Super Soldier! Using the examples here, the obituary would read: Player was eviscerated by a Super Solider!"
obit_method(string) : "When used with obit_name, will set part of the text for a custom obituary. e.g. eviscerated - If empty, defaults to killed."
damage_mod(float) : "USE WITH CAUTION! Multiply all damage from this monster by this number (e.g. 4 = Quad damage)"

*/
void() monster_scim =
{
	if (SUB_Inhibit ())  // new spawnflags for all entities -- iw
		return;

	if (deathmatch)
	{
		remove(self);
		return;
	}
	//dumptruck_ds custom_mdls
	precache_body_model ("progs/sciproto.mdl");
	precache_head_model ("progs/h_guard.mdl");
	precache_proj_model ("progs/missile.mdl"); // used if style == 1
	precache_proj_model ("progs/grenade.mdl"); // used if style == 2
	precache_model2 ("progs/laser.mdl"); // used if style == 3
	//dumptruck_ds custom_mdls
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound_death ("soldier/death1.wav");
	precache_sound_idle ("soldier/idle.wav");
	precache_sound_pain ("soldier/pain1.wav");
	precache_sound_misc ("soldier/pain2.wav");
	precache_sound_attack ("soldier/sattck1.wav");
	precache_sound_sight ("soldier/sight1.wav");
	precache_sound2 ("enforcer/enfire.wav"); // used if style == 3
	precache_sound2 ("enforcer/enfstop.wav"); // used if style == 3

	precache_sound ("player/udeath.wav");		// gib death

	precache_gib1 ("progs/gib1.mdl");
	precache_gib2 ("progs/gib2.mdl");
	precache_gib3 ("progs/gib3.mdl");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	//dumptruck_ds custom_mdls
	body_model ("progs/sciproto.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');

	if (!self.health) //thanks RennyC -- dumptruck_ds
	self.health = 30;

	self.th_stand = scim_stand1;
	self.th_walk = scim_walk1;
	self.th_run = scim_run1;
	self.th_missile = scim_stand1;
	self.th_pain = scim_pain;
	self.th_die = scim_die1;

	walkmonster_start ();
};

/* Scenic Dead Monster Patch stuff here from DeadStuff mod -- dumptruck_ds */

/*QUAKED monster_dead_scim (0 0.5 0.8) (-16 -16 -24) (16 16 32) SOLID FACE_UP X X X X X X NOT_ON_EASY NOT_ON_NORMAL NOT_ON_HARD_OR_NIGHTMARE NOT_IN_DEATHMATCH NOT_IN_COOP NOT_IN_SINGLEPLAYER X NOT_ON_HARD_ONLY NOT_ON_NIGHTMARE_ONLY
{
	model ({"path":"progs/soldier.mdl","frame":28});
}
*/
void() monster_dead_scim =
{
	if (SUB_Inhibit ())  // new spawnflags for all entities -- iw
		return;

	precache_model("progs/sciproto.mdl");
	setmodel(self, "progs/sciproto.mdl");
	if (self.spawnflags & 2)
	{
		self.frame = $stand1;

		if (self.spawnflags & 1)
		{
			self.solid = SOLID_BBOX;
                	setsize(self,'-38.27 -30.47 -50.3','22.1 25.35 30');
		}
		else
		{
			self.solid = SOLID_NOT;
		}
	}
	else
	{
		self.frame = $stand1;
		if (self.spawnflags & 1)
		{
			self.solid = SOLID_BBOX;
                	setsize(self,'-39.85 -29.35 -49.07','20.52 33.17 30');
		}
		else
		{
			self.solid = SOLID_NOT;
		}
	}
};
