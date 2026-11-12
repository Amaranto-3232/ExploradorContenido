if(!near) exit;

var _w = display_get_gui_width();
var _h = display_get_gui_height();

var _bx = _w/2 - 420;
var _by = _h - 170;

draw_set_alpha(0.8);
draw_set_color(make_color_rgb(8,20,12));
draw_rectangle(_bx, _by, _bx + 840, _by + 120, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(93,255,122));
draw_rectangle(_bx, _by, _bx + 840, _by + 120, true);

draw_set_color(make_color_rgb(224,180,56));
draw_text(_bx + 16, _by + 10, "++ DATA-SLATE DE ENTRENAMIENTO ++");
draw_set_color(c_white);
draw_text_ext_transformed(_bx + 16, _by + 38, text, 18, 820 / 1.3, 1.3, 1.3, 0);
