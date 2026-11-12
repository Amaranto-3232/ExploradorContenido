// humo de ambiente ---------------
if(room != r_menu and irandom(12) == 0)
{
	var _cam = view_camera[0];
	var _xx = camera_get_view_x(_cam) + random(camera_get_view_width(_cam));
	var _yy = camera_get_view_y(_cam) + camera_get_view_height(_cam);
	part_particles_create(global.part_front, _xx, _yy, global.p_smoke, 1);
}
