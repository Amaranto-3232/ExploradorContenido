// la puerta se abre cuando el Kaudillo muere
if(!instance_exists(o_boss_warboss))
{
	part_particles_create(global.part_front, x + 16, y - 144, global.p_plasma, 40);
	instance_destroy();
}
image_alpha = 0.75 + 0.25 * sin(current_time / 100);
