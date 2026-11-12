// Reproduce un sonido por nombre SOLO si existe en el proyecto.
// Asi el juego compila aunque todavia no agregues los archivos de audio.
// Nombres preparados: snd_bolter, snd_plasma, snd_chainsword, snd_ork_die, snd_hit,
//                     snd_music_level, snd_music_boss
function c_sfx(_name)
{
	var _snd = asset_get_index(_name);
	if(_snd != -1 and audio_exists(_snd)) audio_play_sound(_snd, 1, false);
}

function c_music(_name)
{
	if(global.music_name == _name) exit;
	if(global.music != -1) audio_stop_sound(global.music);
	global.music = -1;
	global.music_name = _name;

	var _snd = asset_get_index(_name);
	if(_snd != -1 and audio_exists(_snd)) global.music = audio_play_sound(_snd, 10, true);
}
