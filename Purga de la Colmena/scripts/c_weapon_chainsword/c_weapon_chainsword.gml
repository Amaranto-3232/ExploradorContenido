// Espada sierra: ataque cuerpo a cuerpo
function c_weapon_chainsword()
{
	canShoot = 0;
	alarm[0] = 25; // recarga
	melee_time = 12;

	var _dir = 1;
	if(!right) _dir = -1;

	obj = instance_create_layer(x + 26 * _dir, y - 30, "att", o_chainsword_hit);
	obj.image_xscale = _dir;
	obj.dir = _dir;
	obj.dmg = 30 * dmg_mult * melee_mult;

	c_sfx("snd_chainsword");
}
