// pausa -------------------------------
if(keyboard_check_pressed(ord("P")) or keyboard_check_pressed(vk_escape))
{
	if(!paused)
	{
		if(instance_exists(o_player))
		{
			paused = 1;
			pause_spr = sprite_create_from_surface(application_surface, 0, 0,
				surface_get_width(application_surface), surface_get_height(application_surface),
				false, false, 0, 0);
			instance_deactivate_all(true);
			part_system_automatic_update(global.part_front, false);
		}
	}
	else
	{
		paused = 0;
		instance_activate_all();
		part_system_automatic_update(global.part_front, true);
		if(sprite_exists(pause_spr)) sprite_delete(pause_spr);
		pause_spr = -1;
	}
}
