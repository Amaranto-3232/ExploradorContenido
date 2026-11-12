// evita duplicados (o_player es persistente y esta colocado en r_1) --
if(instance_number(o_player) > 1)
{
	instance_destroy();
	exit;
}

//stats -------------------------

hpMax = 100;
hp = hpMax;
invi_time = 45;

armorMax = 50;
armor = armorMax;
armor_regen_delay = 180; // 3 segundos
regen = 1;

faithMax = 100;
faith = 0;
fury = 0;
fury_time = 300;         // 5 segundos
dmg_mult = 1;

// Movimento ---------------------

xSpeed = 0;
xSpeedMax = 4.5;
xAccel = 0.5;

ySpeed = 0;
fallMax = 11;

jumpPower = 9;

grav = 0.4;

// Weapons -----------------------

weapon_list = ["bolter", "plasma", "chainsword"];
weapon_num = 0;
weapon = weapon_list[weapon_num];

canShoot = 1;

weaponMod_x = 15;
weaponMod_y = -25;

ammo_plasma_max = 20;
ammo_plasma = ammo_plasma_max;
heat = 0;
overheat = 0;

ammo_lase = 10; // (laser original, ya no se usa)

melee_time = 0;

// Control -----------------------

ground = 0;
right = 1;
crouch = 0;

dead = 0;
invi = 0;
flash = 0;

// Capitulo ----------------------

chapter = global.chapter;

bolter_mult = 1;
plasma_mult = 1;
melee_mult = 1;
heat_shot = 25;
bolter_rate = 12;
regen_mult = 1;

gun_y_stand = -25;
gun_y_crouch = -15;

spr = global.ch_spr[chapter + 1]; // sprites con los colores del capitulo

if(chapter >= 0)
{
	var _c = global.chapters[chapter];
	hpMax = _c.hp;          hp = hpMax;
	armorMax = _c.armor;    armor = armorMax;
	xSpeedMax = _c.speed;
	jumpPower = _c.jump;
	bolter_mult = _c.bolter;
	plasma_mult = _c.plasma;
	melee_mult = _c.melee;
	heat_shot = _c.heat;
	bolter_rate = _c.rate;
	regen_mult = _c.regen;

}

weaponMod_y = gun_y_stand;
mask_index = s_player_mask;

// HUD ---------------------------
if(!instance_exists(o_hud)) instance_create_depth(0, 0, -10000, o_hud);
