/// @description Disparo

if(!instance_exists(o_player) or !active) exit;

var _dir = image_xscale;
var _n = 1;
if(phase == 3) _n = 3;

for(var i = 0; i < _n; i++)
{
	obj = instance_create_layer(x + 40 * _dir, y - 46, "att", o_ork_shot);
	obj.hspeed = 7 * _dir;
	obj.vspeed = (i - (_n - 1) / 2) * 1.5;
	obj.image_xscale = _dir;
}

if(phase == 3) alarm[0] = 60; else alarm[0] = 100;
