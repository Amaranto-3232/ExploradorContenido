event_inherited();

if(!instance_exists(o_player)) exit;

var _dx = o_player.x - x;
var _dy = o_player.y - y;

// carga ---------------------

if(abs(_dx) < charge_range and abs(_dy) < 40 and !o_player.dead)
{
	if(!charging)
	{
		charging = 1;
		alarm[0] = -1; // cancela el disparo
		canShoot = 1;
	}
	if(_dx >= 0) hspeed = charge_speed; else hspeed = -charge_speed;
	image_xscale = sign(hspeed);
}
else if(charging)
{
	charging = 0;
	hspeed = xSpeed * image_xscale;
}

// shoot ---------------------

if(!charging and canShoot and !o_player.dead)
{
	if(abs(_dx) <= range_x and abs(_dy) <= range_y)
	{
		xSpeedTemp = hspeed;
		hspeed = 0;
		canShoot = 0;
		alarm[0] = shootDelay;
	}
}

// checks --------------------

if(hspeed == 0)
{
	if(_dx > 0) image_xscale = 1; else image_xscale = -1;
	image_index = 0;
}

if(hspeed > 0)
{
	if(place_meeting(x+xCheck,y,o_solid) or collision_rectangle(x+18,y,x+20,y+2,o_terrain,0,1) == noone)
	{
		if(charging) hspeed = 0; else c_flip();
	}
}

if(hspeed < 0)
{
	if(place_meeting(x-xCheck,y,o_solid) or collision_rectangle(x-18,y,x-20,y+2,o_terrain,0,1) == noone)
	{
		if(charging) hspeed = 0; else c_flip();
	}
}
