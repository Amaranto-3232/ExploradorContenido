/// @description Invoca orkos (fase 3)

if(!active) exit;

if(phase == 3 and instance_number(o_ork) < 4)
{
	repeat(2)
	{
		var _ox = clamp(x + choose(-120, 120), 96, room_width - 96);
		instance_create_layer(_ox, y, "Instances", o_ork);
		part_particles_create(global.part_front, _ox, y - 28, global.p_smoke, 3);
	}
}

alarm[2] = 360;
