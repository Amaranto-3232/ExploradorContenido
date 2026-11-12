event_inherited();

if(!instance_exists(o_player)) exit;

// mira al jugador ------------
if(o_player.x > x) image_xscale = 1; else image_xscale = -1;

// rafaga de 3 ----------------
if(canShoot and !o_player.dead)
{
	if(abs(o_player.x - x) <= range_x and abs(o_player.y - y) <= range_y)
	{
		canShoot = 0;
		burst = 3;
		alarm[0] = 20;
	}
}
