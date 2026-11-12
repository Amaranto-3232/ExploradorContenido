var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, 0, _w, _h, false);
draw_set_alpha(1);

// titulo ---------------------------
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(224,180,56));
draw_text_transformed(_w/2, 18, "ELIGE TU CAPITULO", 3, 3, 0);
draw_set_halign(fa_left);

// grilla de retratos ---------------
var _gx = 40;
var _gy = 80;
var _cw = 196;
var _ch = 196;

for(var i = 0; i < 9; i++)
{
	var _x = _gx + (i mod 3) * _cw;
	var _y = _gy + (i div 3) * _ch;

	if(i == sel)
	{
		draw_set_color(make_color_rgb(70,50,10));
		draw_rectangle(_x, _y, _x + _cw - 8, _y + _ch - 8, false);
		draw_set_color(make_color_rgb(224,180,56));
		draw_rectangle(_x, _y, _x + _cw - 8, _y + _ch - 8, true);
		draw_rectangle(_x + 1, _y + 1, _x + _cw - 9, _y + _ch - 9, true);
		draw_sprite_ext(global.ch_spr[i + 1].stand, (t div 20) mod 2, _x + (_cw - 8)/2, _y + 166, 2.6, 2.6, 0, c_white, 1);
	}
	else
	{
		draw_set_color(make_color_rgb(25,25,30));
		draw_rectangle(_x, _y, _x + _cw - 8, _y + _ch - 8, false);
		draw_sprite_ext(global.ch_spr[i + 1].stand, 0, _x + (_cw - 8)/2, _y + 166, 2.6, 2.6, 0, make_color_rgb(120,120,120), 1);
	}
}

// panel del capitulo ---------------
var _c = global.chapters[sel];
var _px = 650;
var _py = 90;

draw_set_color(make_color_rgb(224,180,56));
draw_text_transformed(_px, _py, _c.name, 2, 2, 0);
draw_set_color(c_white);
draw_text_ext(_px, _py + 44, _c.desc, 20, 560);

// barras de estadisticas
var _names = ["VIDA", "ARMADURA", "VELOCIDAD", "SALTO", "BOLTER", "PLASMA", "CUERPO A CUERPO"];
var _vals = [_c.hp / 140, _c.armor / 85, _c.speed / 5.7, (_c.jump - 7) / 3.6,
             (_c.bolter * 12 / _c.rate) / 1.6, (_c.plasma * 25 / _c.heat) / 2.2, _c.melee / 1.6];

for(var i = 0; i < 7; i++)
{
	var _yy = _py + 100 + i * 30;
	draw_set_color(c_white);
	draw_text(_px, _yy, _names[i]);
	draw_set_color(make_color_rgb(40,40,45));
	draw_rectangle(_px + 170, _yy + 2, _px + 430, _yy + 16, false);
	draw_set_color(merge_color(make_color_rgb(180,60,40), make_color_rgb(224,180,56), clamp(_vals[i], 0, 1)));
	draw_rectangle(_px + 170, _yy + 2, _px + 170 + 260 * clamp(_vals[i], 0.05, 1), _yy + 16, false);
}

// vista previa del marine en el juego
draw_sprite_ext(global.ch_spr[sel + 1].walk, (t div 8) mod 4, _px + 520, _py + 480, 3, 3, 0, c_white, 1);

draw_set_color(c_white);
draw_text(_px, _py + 330, "FLECHAS = elegir");
if((t div 30) mod 2)
{
	draw_set_color(make_color_rgb(224,180,56));
	draw_text_transformed(_px, _py + 360, "ENTER = DESPLEGARSE", 1.6, 1.6, 0);
}
draw_set_color(c_white);
