draw_self();

// signo "!" flotando
if(!near)
{
	draw_set_halign(fa_center);
	draw_set_color(make_color_rgb(93,255,122));
	draw_text(x, y - 66 + sin(current_time / 200) * 3, "!");
	draw_set_halign(fa_left);
	draw_set_color(c_white);
}
