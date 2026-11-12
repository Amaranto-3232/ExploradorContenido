// el dano lo maneja c_player_damage (armadura -> vida)
c_player_damage(other.dmg);

// las balas enemigas se destruyen al impactar (bug corregido)
if(object_is_ancestor(other.object_index, o_enemy_att))
{
	with(other) instance_destroy();
}
