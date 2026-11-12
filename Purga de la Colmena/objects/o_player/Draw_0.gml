if(!dead)
{

// sprite checks --------------

if(ground)
{
	if(xSpeed == 0)
	{
		if(crouch)
		{
			sprite_index = spr.crouch;
		}
		else
		{
			sprite_index = spr.stand;
		}
	}
	else
	{
		sprite_index = spr.walk;
	}
}
else
{
	if(ySpeed < 0)
	{
		sprite_index = spr.jump;
	}
	else
	{
		sprite_index = spr.fall;
	}
}

if(melee_time > 0 and !crouch)
{
	sprite_index = spr.melee;
	if(melee_time > 6) image_index = 0; else image_index = 1;
}

if(right) image_xscale = 1; else image_xscale = -1;

if(crouch) mask_index = s_player_mask_crouch; else mask_index = s_player_mask;

if(invi and !fury) image_alpha = 0.6 + 0.4 * ((current_time div 80) mod 2); else image_alpha = 1;

}
else
{
	sprite_index = spr.death;
}

// color de la furia --------------
if(fury) image_blend = merge_color(c_white, make_color_rgb(255,210,80), 0.5 + 0.3 * sin(current_time / 80));
else image_blend = c_white;

if(flash > 0) gpu_set_fog(true, c_white, 0, 0);

draw_self();

if(flash > 0) gpu_set_fog(false, c_white, 0, 0);
