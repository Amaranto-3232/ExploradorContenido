event_inherited();

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
		if(collision_rectangle(x-12,y-10,x+12,y,o_terrain,0,1))
		{
			move_contact_solid(270,ySpeed);
		}
		else
		{
			ySpeed_temp = round(ySpeed);
			while(collision_rectangle(x-12,y,x+12,y+ySpeed_temp,o_terrain,0,1)!= noone and ySpeed_temp != 0)
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

if(collision_rectangle(x-12,y,x+12,y+1,o_terrain,0,1) and collision_rectangle(x-12,y-10,x+12,y,o_terrain,0,1)==noone)
{
	// ground --------------
	ground = 1;
	ySpeed = 0;
	xSpeed = 0;
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
