// Dano al jugador: primero armadura, luego vida
function c_player_damage(_dmg)
{
	if(_dmg <= 0) exit;

	with(o_player)
	{
		if(invi or dead or fury) exit;

		var _rest = _dmg;

		// armadura ------------------
		if(armor > 0)
		{
			var _abs = min(armor, _rest);
			armor -= _abs;
			_rest -= _abs;
		}

		hp -= _rest;

		invi = 1;
		alarm[1] = invi_time;

		// la armadura se regenera tras 3 segundos sin recibir dano
		regen = 0;
		alarm[2] = armor_regen_delay;

		flash = 6;
		c_screen_shake(4, 10);
		c_sfx("snd_hit");
	}
}
