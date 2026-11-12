// Arma original del Plataformer V-10 (CORREGIDA)
// - el segundo objeto ahora es o_laser_player (el haz que hace dano)
// - sin municion no dispara
function c_weapon_laser()
{
	if(ammo_lase <= 0) exit;

	canShoot = 0;
	alarm[0] = 15; //reload speed
	ammo_lase -= 1;

	var _dir = 1;
	if(!right) _dir = -1;

	var _sx = x + weaponMod_x * _dir;
	var _sy = y + weaponMod_y;

	tracer = instance_create_layer(_sx, _sy, "att", o_tracer_laser);
	obj = instance_create_layer(_sx, _sy, "att", o_laser_player);
	obj.image_angle = point_direction(_sx, _sy, tracer.x, tracer.y);
	obj.image_xscale = max(1, point_distance(_sx, _sy, tracer.x, tracer.y));
}
