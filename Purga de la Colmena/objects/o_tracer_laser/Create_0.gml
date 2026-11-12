// Busca el punto de impacto del rayo (CORREGIDO: ahora tambien funciona a la izquierda)

var _dist = 300;

if(o_player.right)
{
	if(!collision_line(x,y,x+_dist,y,o_enemy_body,0,1))
	{
		move_contact_solid(0,_dist);
	}
	else
	{
		x_speed_temp = 0;
		while(x_speed_temp < _dist and !place_meeting(x+x_speed_temp,y,o_enemy_body) and !place_meeting(x+x_speed_temp,y,o_solid))
		{
			x_speed_temp += 4;
		}
		x += x_speed_temp + 16;
	}
}
else
{
	if(!collision_line(x,y,x-_dist,y,o_enemy_body,0,1))
	{
		move_contact_solid(180,_dist);
	}
	else
	{
		x_speed_temp = 0;
		while(x_speed_temp < _dist and !place_meeting(x-x_speed_temp,y,o_enemy_body) and !place_meeting(x-x_speed_temp,y,o_solid))
		{
			x_speed_temp += 4;
		}
		x -= x_speed_temp + 16;
	}
}

alarm[0] = 2;

part_particles_create(global.part_front, x, y, global.p_spark_laser, 10);
