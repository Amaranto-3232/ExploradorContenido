event_inherited();

if(!instance_exists(o_player)) exit;

// fase segun la vida ---------------
var _old = phase;
if(hp > hpMax * 0.66) phase = 1;
else if(hp > hpMax * 0.33) phase = 2;
else phase = 3;

if(phase != _old)
{
	c_screen_shake(8, 25);
	part_particles_create(global.part_front, x, y - 48, global.p_bolter, 40);
	if(phase == 2) { alarm[1] = 40; }
	if(phase == 3) { walkSpeed = 2.2; alarm[2] = 120; image_blend = make_color_rgb(255,170,170); }
}

if(active)
{
	var _dir = 1;
	if(o_player.x < x) _dir = -1;

	// caminar hacia el jugador (fases 1 y 3) ----
	if(ground)
	{
		if(phase != 2 or alarm[1] > 20)
		{
			if(abs(o_player.x - x) > 40) xSpeed = walkSpeed * _dir; else xSpeed = 0;
		}
		image_xscale = _dir;
	}

	// disparo ------------------------------------
	if(alarm[0] <= 0) alarm[0] = 100;
}

// Movimiento -----------------------

if(xSpeed != 0)
{
	if(xSpeed > 0)
	{
		move_contact_solid(0,xSpeed);
	}
	else
	{
		move_contact_solid(180,abs(xSpeed));
	}
}

if(ySpeed != 0)
{
	if(ySpeed > 0)
	{
		if(collision_rectangle(x-26,y-10,x+26,y,o_terrain,0,1))
		{
			move_contact_solid(270,ySpeed);
		}
		else
		{
			ySpeed_temp = round(ySpeed);
			while(collision_rectangle(x-26,y,x+26,y+ySpeed_temp,o_terrain,0,1)!= noone and ySpeed_temp != 0)
			{
				ySpeed_temp -= 1;
			}
			y += ySpeed_temp;
		}
	}
	else
	{
		move_contact_solid(90,abs(ySpeed));
	}
}

// Checks ----------------------------

was_ground = ground;

if(collision_rectangle(x-26,y,x+26,y+1,o_terrain,0,1) and collision_rectangle(x-26,y-10,x+26,y,o_terrain,0,1)==noone)
{
	// ground --------------
	ground = 1;
	ySpeed = 0;
	if(!was_ground) { event_user(0); }
}
else
{
	// air ------------------
	ground = 0;
	ySpeed += grav;
	if(ySpeed > fallMax) ySpeed = fallMax;

	if(ySpeed < 0)
	{
		if(!place_free(x,y-1))
		{
			ySpeed = 0;
		}
	}
}

// caer al vacio
if(y > room_height + 64) instance_destroy();

// animacion ---------
if(xSpeed == 0 or !ground) image_index = 1;
