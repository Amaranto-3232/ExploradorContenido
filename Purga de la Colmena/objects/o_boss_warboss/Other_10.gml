/// @description Aterrizaje: ondas de choque

xSpeed = 0;

if(phase >= 2 and active)
{
	c_screen_shake(6, 15);

	var _w = instance_create_layer(x + 30, y, "att", o_shockwave);
	_w.hspeed = 5;

	_w = instance_create_layer(x - 30, y, "att", o_shockwave);
	_w.hspeed = -5;
	_w.image_xscale = -1;
}
