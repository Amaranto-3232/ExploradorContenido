if(other.dmg <= 0) exit;

// los ataques que atraviesan solo danan una vez a cada enemigo
if(other.pierce)
{
	if(ds_list_find_index(other.hit_list, id) != -1) exit;
	ds_list_add(other.hit_list, id);
}

hp -= other.dmg;
flash = 5;
part_particles_create(global.part_front, other.x, other.y, blood, 6);

// un proyectil normal solo dana una vez y se destruye al impactar
// (bug de dano multiple corregido; lo destruye el enemigo para que el dano
//  siempre se aplique, sin importar el orden de las colisiones)
if(!other.pierce)
{
	other.dmg = 0;
	with(other) instance_destroy();
}
