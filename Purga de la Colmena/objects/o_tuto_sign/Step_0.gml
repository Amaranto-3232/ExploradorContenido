near = 0;

if(instance_exists(o_player))
{
	if(abs(o_player.x - x) < 72 and abs(o_player.y - y) < 160) near = 1;
}

// acciones especiales -------------
if(near and !done)
{
	if(action == "faith")
	{
		o_player.faith = o_player.faithMax;
		part_particles_create(global.part_front, o_player.x, o_player.y - 30, global.p_faith, 30);
		done = 1;
	}
	if(action == "ammo")
	{
		o_player.ammo_plasma = o_player.ammo_plasma_max;
		done = 1;
	}
}
