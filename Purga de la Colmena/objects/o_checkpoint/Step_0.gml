if(instance_exists(o_player))
{
	if(o_player.dead == 0) global.player_respawn = 0;
}

if(global.checkpoint == room) image_index = 1; else image_index = 0;
