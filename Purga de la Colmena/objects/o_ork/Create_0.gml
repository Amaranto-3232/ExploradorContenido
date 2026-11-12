event_inherited();

// stats --------------------------

hpMax = 40;
hp = hpMax;
dmg = 15;

score_value = 100;
faith_value = 12;
blood = global.p_blood_ork;

reloadSpeed = 90;
shootDelay = 25;

range_x = 220;
range_y = 64;

// movimiento ---------------------

xSpeed = 1;
xCheck = 14;

xSpeedTemp = 0;

charge_range = 80;   // a menos de 80px carga contra el jugador
charge_speed = 3;
charging = 0;

image_speed = 0.15;

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
