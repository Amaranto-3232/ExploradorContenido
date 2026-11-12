event_inherited();

// Stats ----------------------

hpMax = 20;
hp = hpMax;
dmg = 15;

jumpPower = 8;
jumpTime = 140;

alarm[0] = irandom_range(jumpTime/2,jumpTime);

//moviemiento --------------------

xSpeed = 0;
xSpeedMax = 5;

ySpeed = 0;
fallMax = 9;
grav = 0.3;

ground = 0;
was_ground = 0;
