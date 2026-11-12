var _w = display_get_gui_width();

draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(_w/2 - 230, 8, _w/2 + 230, 64, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(224,180,56));
draw_text_transformed(_w/2, 14, "PRUEBA DEL ASPIRANTE", 2, 2, 0);
draw_set_color(c_white);
draw_text(_w/2, 44, "TAB = saltar tutorial");
draw_set_halign(fa_left);
