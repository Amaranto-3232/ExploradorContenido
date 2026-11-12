// Bolter: proyectil explosivo, municion infinita (basado en c_weapon_pistol)
function c_weapon_bolter()
{
	canShoot = 0;
	alarm[0] = bolter_rate; // recarga (depende del capitulo)

	var _dir = 1;
	if(!right) _dir = -1;

	obj = instance_create_layer(x + weaponMod_x * _dir, y + weaponMod_y, "att", o_bolter_shot);
	obj.image_xscale = _dir;
	obj.hspeed *= _dir;
	obj.dmg *= dmg_mult * bolter_mult;

	// fogonazo ---------------------
	part_particles_create(global.part_front, obj.x, obj.y, global.p_bolter, 3);

	c_sfx("snd_bolter");
}
