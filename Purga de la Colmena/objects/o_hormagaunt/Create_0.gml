event_inherited();

// Stats ----------------------

hpMax = 20;
hp = hpMax;
dmg = 15;

score_value = 80;
faith_value = 10;
blood = global.p_blood_tyranid;

jumpPower = 8.5;
jumpTime = 90;      // salta mas seguido que el jumper original
sight = 420;        // solo persigue si ve al jugador

alarm[0] = irandom_range(jumpTime/2,jumpTime);

//movimiento --------------------

xSpeed = 0;
xSpeedMax = 6;      // y mas rapido

ySpeed = 0;
fallMax = 9;
grav = 0.3;

ground = 0;
was_ground = 0;
