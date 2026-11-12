/// @description disparo de la rafaga

obj = instance_create_layer(x + 18 * image_xscale, y - 28, "att", o_cultist_shot);
obj.hspeed *= image_xscale;
obj.image_xscale = image_xscale;

image_index = 1;
alarm[2] = 5;

burst -= 1;
if(burst > 0) alarm[0] = 8;
else alarm[1] = 120;
