global.part_front = part_system_create_layer("part_front",0);

// musica segun la room -----------
if(room == r_boss) c_music("snd_music_boss");
else if(room == r_1 or room == r_2 or room == r_3) c_music("snd_music_level");
