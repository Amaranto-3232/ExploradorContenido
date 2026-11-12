// Muerte de un enemigo: particulas, puntos, fervor y posible botin
function c_enemy_die()
{
	part_particles_create(global.part_front, x, y - sprite_height/2, blood, 25);
	part_particles_create(global.part_front, x, y - sprite_height/2, global.p_bolter, 10);

	global.puntos += score_value;

	if(instance_exists(o_player))
	{
		if(!o_player.fury) o_player.faith = min(o_player.faithMax, o_player.faith + faith_value);
	}

	// botin -------------------------
	if(!boss and can_drop and irandom(99) < 20)
	{
		if(irandom(1)) instance_create_layer(x, y - 16, "Instances", o_pickup_health);
		else instance_create_layer(x, y - 16, "Instances", o_pickup_ammo);
	}

	if(boss)
	{
		part_particles_create(global.part_front, x, y - 48, global.p_bolter, 80);
		part_particles_create(global.part_front, x, y - 48, global.p_blood_ork, 80);
		c_screen_shake(10, 40);
	}
	else c_screen_shake(2, 6);

	c_sfx("snd_ork_die");
	instance_destroy();
}
