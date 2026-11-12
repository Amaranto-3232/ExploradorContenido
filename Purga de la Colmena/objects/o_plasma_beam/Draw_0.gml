gpu_set_blendmode(bm_add);

draw_self();
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale * 2.2, image_angle, c_aqua, image_alpha * 0.4);

gpu_set_blendmode(bm_normal);
