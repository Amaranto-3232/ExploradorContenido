t += 1;

if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space))
{
	if(room == r_menu)
	{
		global.chapter = -1;            // en el tutorial eres un Aspirante
		global.checkpoint = r_tutorial;
		global.player_respawn = 0;
		room_goto(r_tutorial);
	}
	else
	{
		game_restart(); // vuelve al menu con todo reiniciado
	}
}
