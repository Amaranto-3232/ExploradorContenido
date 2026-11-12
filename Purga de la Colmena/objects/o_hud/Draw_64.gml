var _w = display_get_gui_width();
var _h = display_get_gui_height();

// pausa ---------------------------------------------------
if(paused)
{
	if(sprite_exists(pause_spr)) draw_sprite_stretched(pause_spr, 0, 0, 0, _w, _h);
	draw_set_alpha(0.6);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _w, _h, false);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(224,180,56));
	draw_text_transformed(_w/2, _h/2 - 20, "PAUSA", 4, 4, 0);
	draw_set_color(c_white);
	draw_text_transformed(_w/2, _h/2 + 50, "P o ESC para continuar", 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	exit;
}

if(!instance_exists(o_player)) exit;

var _p = o_player;
var _x = 24;
var _y = 20;
var _bw = 260;

// marco ---------------------------
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(_x - 10, _y - 10, _x + _bw + 150, _y + 150, false);
draw_set_alpha(1);

// vida ----------------------------
draw_set_color(make_color_rgb(60,10,10));
draw_rectangle(_x, _y, _x + _bw, _y + 16, false);
draw_set_color(make_color_rgb(220,40,40));
draw_rectangle(_x, _y, _x + _bw * (_p.hp / _p.hpMax), _y + 16, false);
draw_set_color(c_white);
draw_text(_x + _bw + 10, _y, "VIDA " + string(max(0, round(_p.hp))));

// armadura ------------------------
_y += 24;
draw_set_color(make_color_rgb(10,20,60));
draw_rectangle(_x, _y, _x + _bw, _y + 12, false);
draw_set_color(make_color_rgb(60,120,255));
draw_rectangle(_x, _y, _x + _bw * (_p.armor / _p.armorMax), _y + 12, false);
draw_set_color(c_white);
draw_text(_x + _bw + 10, _y - 2, "ARMADURA");

// fervor --------------------------
_y += 20;
draw_set_color(make_color_rgb(50,40,10));
draw_rectangle(_x, _y, _x + _bw, _y + 12, false);
draw_set_color(make_color_rgb(230,180,40));
draw_rectangle(_x, _y, _x + _bw * (_p.faith / _p.faithMax), _y + 12, false);
draw_set_color(c_white);
if(_p.fury) draw_text(_x + _bw + 10, _y - 2, "FURIA!");
else if(_p.faith >= _p.faithMax) draw_text(_x + _bw + 10, _y - 2, "FERVOR [E]");
else draw_text(_x + _bw + 10, _y - 2, "FERVOR");

// arma ----------------------------
_y += 26;
var _wname = "BOLTER";
if(_p.weapon == "plasma") _wname = "RIFLE DE PLASMA";
if(_p.weapon == "chainsword") _wname = "ESPADA SIERRA";
draw_set_color(make_color_rgb(224,180,56));
draw_text(_x, _y, "ARMA [Q]: " + _wname);

// plasma: municion y calor ---------
_y += 24;
draw_set_color(c_white);
draw_text(_x, _y, "PLASMA " + string(_p.ammo_plasma) + "/" + string(_p.ammo_plasma_max));
draw_set_color(make_color_rgb(40,40,40));
draw_rectangle(_x + 120, _y + 3, _x + _bw, _y + 13, false);
if(_p.overheat) draw_set_color(c_red); else draw_set_color(merge_color(c_aqua, c_orange, _p.heat/100));
draw_rectangle(_x + 120, _y + 3, _x + 120 + (_bw - 120) * (_p.heat / 100), _y + 13, false);
if(_p.overheat)
{
	draw_set_color(c_red);
	draw_text(_x + _bw + 10, _y, "SOBRECALENTADO");
}

// vidas y puntos ------------------
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_text_transformed(_w - 24, 20, "PUNTOS: " + string(global.puntos), 1.5, 1.5, 0);
draw_text_transformed(_w - 24, 50, "VIDAS: " + string(global.vidas), 1.5, 1.5, 0);
draw_set_color(make_color_rgb(224,180,56));
if(_p.chapter >= 0) draw_text(_w - 24, 82, string_upper(global.chapters[_p.chapter].name));
else draw_text(_w - 24, 82, "ASPIRANTE");
draw_set_halign(fa_left);

// barra del jefe ------------------
if(instance_exists(o_boss_warboss))
{
	var _b = o_boss_warboss;
	var _bx = _w/2 - 300;
	var _by = _h - 50;
	draw_set_alpha(0.6);
	draw_set_color(c_black);
	draw_rectangle(_bx - 6, _by - 28, _bx + 606, _by + 24, false);
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(40,10,10));
	draw_rectangle(_bx, _by, _bx + 600, _by + 18, false);
	draw_set_color(make_color_rgb(120,220,60));
	draw_rectangle(_bx, _by, _bx + 600 * max(0, _b.hp / _b.hpMax), _by + 18, false);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(_w/2, _by - 24, "KAUDILLO ORKO  -  FASE " + string(_b.phase));
	draw_set_halign(fa_left);
}

draw_set_color(c_white);
