// la espada corta las balas enemigas (menos las ondas de choque)
if(other.object_index != o_shockwave)
{
	part_particles_create(global.part_front, other.x, other.y, global.p_pistol, 6);
	with(other) instance_destroy();
}
