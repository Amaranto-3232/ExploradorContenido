if(global.checkpoint != room)
{
	part_particles_create(global.part_front, x, y - 50, global.p_faith, 25);
}
global.checkpoint = room;
