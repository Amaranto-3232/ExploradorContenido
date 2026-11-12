if(global.previous_room == target_room and instance_exists(o_player) and !global.player_respawn)
{
	o_player.x = x+64;
	o_player.y = y;
}
