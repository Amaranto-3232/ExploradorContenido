// Arma original del Plataformer V-10 (se mantiene como referencia)
function c_weapon_pistol()
{
	canShoot = 0;
	alarm[0] = 15; //reload speed
	if(right)
	{
		obj = instance_create_layer(x+weaponMod_x,y+weaponMod_y,"att",o_pistol);
	}
	else
	{
		obj = instance_create_layer(x-weaponMod_x,y+weaponMod_y,"att",o_pistol);
		obj.image_xscale = -1;
		obj.hspeed *= -1;
	}
}
