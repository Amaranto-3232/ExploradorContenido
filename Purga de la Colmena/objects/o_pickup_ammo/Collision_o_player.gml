if(other.ammo_plasma < other.ammo_plasma_max and !other.dead)
{
	other.ammo_plasma = min(other.ammo_plasma_max, other.ammo_plasma + 10);
	part_particles_create(global.part_front, x, y, global.p_plasma, 12);
	instance_destroy();
}
