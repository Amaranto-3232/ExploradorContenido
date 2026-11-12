/// @description disparo (akribillador)

obj = instance_create_layer(x + 20 * image_xscale, y - 27, "att", o_ork_shot);
obj.hspeed *= image_xscale;
obj.image_xscale = image_xscale;

hspeed = xSpeedTemp;
if(hspeed == 0) hspeed = xSpeed * image_xscale;
image_xscale = sign(hspeed);

alarm[1] = reloadSpeed;
