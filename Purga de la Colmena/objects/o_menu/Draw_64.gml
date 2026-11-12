var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, _w, _h, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _blink = (t div 30) mod 2;

if(room == r_menu)
{
	draw_set_color(make_color_rgb(224,180,56));
	draw_text_transformed(_w/2, 150, "PURGA DE LA COLMENA", 4, 4, 0);
	draw_set_color(c_white);
	draw_text_transformed(_w/2, 215, "Un Marine Espacial contra la invasion xenos", 1.5, 1.5, 0);

	draw_set_color(make_color_rgb(200,200,210));
	var _y = 320;
	draw_text(_w/2, _y,       "Flechas IZQ / DER ........ moverse");
	draw_text(_w/2, _y+28,    "Flecha ABAJO ............. agacharse");
	draw_text(_w/2, _y+56,    "ALT o ESPACIO ............ saltar");
	draw_text(_w/2, _y+84,    "CTRL o X ................. disparar / atacar");
	draw_text(_w/2, _y+112,   "Q ........................ cambiar arma");
	draw_text(_w/2, _y+140,   "E ........................ Furia del Emperador (fervor al 100)");
	draw_text(_w/2, _y+168,   "P o ESC .................. pausa");

	if(_blink)
	{
		draw_set_color(c_white);
		draw_text_transformed(_w/2, 580, "PRESIONA ENTER PARA EMPEZAR", 2, 2, 0);
	}
}
else if(room == r_gameover)
{
	draw_set_color(make_color_rgb(220,40,40));
	draw_text_transformed(_w/2, 240, "HAS CAIDO EN COMBATE", 4, 4, 0);
	draw_set_color(c_white);
	draw_text_transformed(_w/2, 340, "Puntuacion: " + string(global.puntos), 2, 2, 0);
	if(_blink) draw_text_transformed(_w/2, 480, "ENTER para volver al menu", 1.5, 1.5, 0);
}
else if(room == r_victory)
{
	draw_set_color(make_color_rgb(224,180,56));
	draw_text_transformed(_w/2, 220, "VICTORIA", 5, 5, 0);
	draw_set_color(c_white);
	draw_text_transformed(_w/2, 310, "El Kaudillo Orko ha caido. La colmena esta purgada.", 1.5, 1.5, 0);
	draw_text_transformed(_w/2, 380, "Puntuacion final: " + string(global.puntos), 2, 2, 0);
	if(_blink) draw_text_transformed(_w/2, 500, "ENTER para volver al menu", 1.5, 1.5, 0);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
