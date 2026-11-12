event_inherited();

// stats --------------------------

hpMax = 30;
hp = hpMax;
dmg = 20;

reloadSpeed = 90;
shootDelay = 30;

range_x = 200;
range_y = 64;

// movimiento ---------------------

xSpeed = 1;
xCheck = 11;

xSpeedTemp = 0;

// comportamiento ------------------

canShoot = 1;

if(irandom(1))
{
	hspeed = xSpeed;
}
else
{
	hspeed = -xSpeed;
	image_xscale = -1;
}
