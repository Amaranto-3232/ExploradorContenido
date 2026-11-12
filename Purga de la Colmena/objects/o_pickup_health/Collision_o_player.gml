if(other.hp < other.hpMax and !other.dead)
{
	other.hp = min(other.hpMax, other.hp + 30);
	part_particles_create(global.part_front, x, y, global.p_faith, 12);
	instance_destroy();
}
