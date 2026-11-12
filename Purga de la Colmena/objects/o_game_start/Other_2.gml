// globales ----------------------

randomize();
audio_stop_all();
display_set_gui_size(1280, 720);

global.previous_room = 0;

global.checkpoint = r_1;      // si mueres antes de tocar un estandarte vuelves a r_1
global.player_respawn = 0;

global.vidas = 3;             // (lives es una variable interna de GameMaker)
global.puntos = 0;            // (score es una variable interna de GameMaker)

global.shake_amt = 0;
global.shake_time = 0;

global.music = -1;
global.music_name = "";

// Capitulos ---------------------
// -1 = Aspirante (tutorial). 0..8 = capitulo elegido en r_select
global.chapter = -1;

// sprites del marine por capitulo (indice 0 = Aspirante, 1..9 = capitulos 0..8)
global.ch_spr = [
	{ stand: s_marine_stand, walk: s_marine_walk, jump: s_marine_jump, fall: s_marine_fall, crouch: s_marine_crouch, melee: s_marine_melee, death: s_marine_death },
	{ stand: s_m0_stand, walk: s_m0_walk, jump: s_m0_jump, fall: s_m0_fall, crouch: s_m0_crouch, melee: s_m0_melee, death: s_m0_death },
	{ stand: s_m1_stand, walk: s_m1_walk, jump: s_m1_jump, fall: s_m1_fall, crouch: s_m1_crouch, melee: s_m1_melee, death: s_m1_death },
	{ stand: s_m2_stand, walk: s_m2_walk, jump: s_m2_jump, fall: s_m2_fall, crouch: s_m2_crouch, melee: s_m2_melee, death: s_m2_death },
	{ stand: s_m3_stand, walk: s_m3_walk, jump: s_m3_jump, fall: s_m3_fall, crouch: s_m3_crouch, melee: s_m3_melee, death: s_m3_death },
	{ stand: s_m4_stand, walk: s_m4_walk, jump: s_m4_jump, fall: s_m4_fall, crouch: s_m4_crouch, melee: s_m4_melee, death: s_m4_death },
	{ stand: s_m5_stand, walk: s_m5_walk, jump: s_m5_jump, fall: s_m5_fall, crouch: s_m5_crouch, melee: s_m5_melee, death: s_m5_death },
	{ stand: s_m6_stand, walk: s_m6_walk, jump: s_m6_jump, fall: s_m6_fall, crouch: s_m6_crouch, melee: s_m6_melee, death: s_m6_death },
	{ stand: s_m7_stand, walk: s_m7_walk, jump: s_m7_jump, fall: s_m7_fall, crouch: s_m7_crouch, melee: s_m7_melee, death: s_m7_death },
	{ stand: s_m8_stand, walk: s_m8_walk, jump: s_m8_jump, fall: s_m8_fall, crouch: s_m8_crouch, melee: s_m8_melee, death: s_m8_death }
];

global.chapters = [
	{ name: "Order of the Caliban Vanguard", desc: "Veteranos implacables. Mas armadura y plasma reforzado.",
	  hp: 100, armor: 70, speed: 4.5, jump: 9.2, bolter: 1.0, plasma: 1.3, melee: 1.0, heat: 25, rate: 12, regen: 1.0 },
	{ name: "Ultramar Vanguard", desc: "Disciplina perfecta. Equilibrados y su armadura se regenera rapido.",
	  hp: 110, armor: 55, speed: 4.6, jump: 9.2, bolter: 1.1, plasma: 1.1, melee: 1.1, heat: 22, rate: 12, regen: 1.5 },
	{ name: "Bloodied Host", desc: "Sed de batalla. Brutales cuerpo a cuerpo y agiles.",
	  hp: 100, armor: 45, speed: 4.9, jump: 9.6, bolter: 1.0, plasma: 1.0, melee: 1.6, heat: 25, rate: 12, regen: 1.0 },
	{ name: "Iron Wolf Brotherhood", desc: "Cazadores salvajes. Rapidos y feroces de cerca.",
	  hp: 110, armor: 45, speed: 5.1, jump: 9.4, bolter: 1.0, plasma: 0.9, melee: 1.4, heat: 25, rate: 12, regen: 1.0 },
	{ name: "Fists of the Praetorian", desc: "Muralla viviente. Mucha vida y armadura, pero lentos.",
	  hp: 140, armor: 65, speed: 4.0, jump: 9.0, bolter: 1.15, plasma: 1.0, melee: 1.1, heat: 25, rate: 12, regen: 1.0 },
	{ name: "Dragonfire Guard", desc: "Forjados en fuego. Resistentes y su plasma casi no se calienta.",
	  hp: 120, armor: 55, speed: 4.2, jump: 9.0, bolter: 1.0, plasma: 1.2, melee: 1.1, heat: 14, rate: 12, regen: 1.0 },
	{ name: "Raven's Watch", desc: "Sombras veloces. Saltan mas alto y se mueven rapido.",
	  hp: 85, armor: 45, speed: 5.2, jump: 10.6, bolter: 1.1, plasma: 1.0, melee: 1.2, heat: 25, rate: 11, regen: 1.0 },
	{ name: "White Lightning Order", desc: "El rayo blanco. Los mas rapidos, con bolter de alta cadencia.",
	  hp: 90, armor: 40, speed: 5.7, jump: 9.6, bolter: 1.0, plasma: 1.0, melee: 1.1, heat: 25, rate: 8, regen: 1.0 },
	{ name: "Forgemasters of Iron", desc: "La carne es debil, el hierro es eterno. Armadura enorme que se repara sola.",
	  hp: 100, armor: 85, speed: 4.1, jump: 9.0, bolter: 1.1, plasma: 1.1, melee: 1.0, heat: 22, rate: 12, regen: 2.2 }
];

// Particulas --------------------

global.p_pistol = part_type_create();
part_type_shape(global.p_pistol,pt_shape_square);
part_type_size(global.p_pistol,0.05,0.10,0,0);
part_type_color3(global.p_pistol,2883583,1023999,26367);
part_type_alpha3(global.p_pistol,1,1,0);
part_type_speed(global.p_pistol,0.75,1.50,-0.06,0);
part_type_direction(global.p_pistol,0,359,0,0);
part_type_blend(global.p_pistol,1);
part_type_life(global.p_pistol,15,30);

global.p_spark_laser = part_type_create();
part_type_shape(global.p_spark_laser,pt_shape_flare);
part_type_size(global.p_spark_laser,0.09,0.15,0,0);
part_type_color2(global.p_spark_laser,16777088,16731392);
part_type_alpha3(global.p_spark_laser,1,1,0);
part_type_speed(global.p_spark_laser,0.8,1.5,-0.07,0);
part_type_direction(global.p_spark_laser,0,359,0,0);
part_type_blend(global.p_spark_laser,1);
part_type_life(global.p_spark_laser,25,38);

// bolter (explosion naranja) ----
global.p_bolter = part_type_create();
part_type_shape(global.p_bolter,pt_shape_square);
part_type_size(global.p_bolter,0.06,0.14,-0.002,0);
part_type_color3(global.p_bolter,make_color_rgb(255,240,160),make_color_rgb(255,140,30),make_color_rgb(120,30,10));
part_type_alpha3(global.p_bolter,1,0.8,0);
part_type_speed(global.p_bolter,1,2.5,-0.08,0);
part_type_direction(global.p_bolter,0,359,0,0);
part_type_blend(global.p_bolter,1);
part_type_life(global.p_bolter,12,26);

// plasma (azul cian) ------------
global.p_plasma = part_type_create();
part_type_shape(global.p_plasma,pt_shape_flare);
part_type_size(global.p_plasma,0.08,0.18,-0.003,0);
part_type_color3(global.p_plasma,c_white,make_color_rgb(80,220,255),make_color_rgb(20,80,255));
part_type_alpha3(global.p_plasma,1,1,0);
part_type_speed(global.p_plasma,0.8,2,-0.06,0);
part_type_direction(global.p_plasma,0,359,0,0);
part_type_blend(global.p_plasma,1);
part_type_life(global.p_plasma,18,34);

// sangre orka (verde) -----------
global.p_blood_ork = part_type_create();
part_type_shape(global.p_blood_ork,pt_shape_square);
part_type_size(global.p_blood_ork,0.04,0.09,0,0);
part_type_color2(global.p_blood_ork,make_color_rgb(110,210,70),make_color_rgb(30,90,20));
part_type_alpha2(global.p_blood_ork,1,0);
part_type_speed(global.p_blood_ork,1.5,3.5,0,0);
part_type_direction(global.p_blood_ork,20,160,0,0);
part_type_gravity(global.p_blood_ork,0.2,270);
part_type_life(global.p_blood_ork,25,45);

// sangre tiranida (morada) ------
global.p_blood_tyranid = part_type_create();
part_type_shape(global.p_blood_tyranid,pt_shape_square);
part_type_size(global.p_blood_tyranid,0.04,0.09,0,0);
part_type_color2(global.p_blood_tyranid,make_color_rgb(200,90,255),make_color_rgb(70,10,110));
part_type_alpha2(global.p_blood_tyranid,1,0);
part_type_speed(global.p_blood_tyranid,1.5,3.5,0,0);
part_type_direction(global.p_blood_tyranid,20,160,0,0);
part_type_gravity(global.p_blood_tyranid,0.2,270);
part_type_life(global.p_blood_tyranid,25,45);

// sangre del caos (roja) --------
global.p_blood_chaos = part_type_create();
part_type_shape(global.p_blood_chaos,pt_shape_square);
part_type_size(global.p_blood_chaos,0.04,0.09,0,0);
part_type_color2(global.p_blood_chaos,make_color_rgb(230,40,40),make_color_rgb(80,0,0));
part_type_alpha2(global.p_blood_chaos,1,0);
part_type_speed(global.p_blood_chaos,1.5,3.5,0,0);
part_type_direction(global.p_blood_chaos,20,160,0,0);
part_type_gravity(global.p_blood_chaos,0.2,270);
part_type_life(global.p_blood_chaos,25,45);

// fervor (dorado) ---------------
global.p_faith = part_type_create();
part_type_shape(global.p_faith,pt_shape_flare);
part_type_size(global.p_faith,0.05,0.12,-0.002,0);
part_type_color2(global.p_faith,make_color_rgb(255,240,150),make_color_rgb(230,170,30));
part_type_alpha3(global.p_faith,1,0.8,0);
part_type_speed(global.p_faith,0.5,1.2,0,0);
part_type_direction(global.p_faith,70,110,0,0);
part_type_blend(global.p_faith,1);
part_type_life(global.p_faith,20,40);

// humo de ambiente --------------
global.p_smoke = part_type_create();
part_type_shape(global.p_smoke,pt_shape_cloud);
part_type_size(global.p_smoke,0.6,1.4,0.004,0);
part_type_color2(global.p_smoke,make_color_rgb(90,70,70),make_color_rgb(40,30,30));
part_type_alpha3(global.p_smoke,0,0.12,0);
part_type_speed(global.p_smoke,0.2,0.5,0,0);
part_type_direction(global.p_smoke,80,100,0,0);
part_type_life(global.p_smoke,180,300);
