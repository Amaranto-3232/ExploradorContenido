// Rifle de plasma: rayo instantaneo (basado en c_weapon_laser corregido)
function c_weapon_plasma()
{
	if(ammo_plasma <= 0 or overheat) exit;

	canShoot = 0;
	alarm[0] = 30; // recarga

	ammo_plasma -= 1;

	// calor -------------------------
	heat += heat_shot;
	if(heat >= 100)
	{
		heat = 100;
		overheat = 1;
		alarm[3] = 120; // 2 segundos bloqueado
	}

	var _dir = 1;
	if(!right) _dir = -1;

	var _sx = x + weaponMod_x * _dir;
	var _sy = y + weaponMod_y;

	tracer = instance_create_layer(_sx, _sy, "att", o_tracer_laser);
	obj = instance_create_layer(_sx, _sy, "att", o_plasma_beam);
	obj.image_angle = point_direction(_sx, _sy, tracer.x, tracer.y);
	obj.image_xscale = max(1, point_distance(_sx, _sy, tracer.x, tracer.y));
	obj.dmg = 25 * dmg_mult * plasma_mult;

	part_particles_create(global.part_front, tracer.x, tracer.y, global.p_plasma, 15);
	part_particles_create(global.part_front, _sx, _sy, global.p_plasma, 5);

	c_screen_shake(3, 6);
	c_sfx("snd_plasma");
}
