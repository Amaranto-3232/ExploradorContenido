event_inherited();

// stats --------------------------

hpMax = 500;
hp = hpMax;
dmg = 25;

score_value = 5000;
faith_value = 0;
blood = global.p_blood_ork;
boss = 1;

phase = 1;
active = 0;
alarm[3] = 60;        // pequena pausa antes de empezar

// movimiento ---------------------

xSpeed = 0;
walkSpeed = 1.2;
xSpeedMax = 5;
ySpeed = 0;
fallMax = 12;
grav = 0.35;
jumpPower = 8.5;

ground = 0;
was_ground = 0;

image_speed = 0.12;
