if(!dead)
{

// Input ------------------------

var _k_jump_p = keyboard_check_pressed(vk_alt) or keyboard_check_pressed(vk_space);
var _k_jump_r = keyboard_check_released(vk_alt) or keyboard_check_released(vk_space);
var _k_shoot  = keyboard_check(vk_control) or keyboard_check(ord("X"));

//horizontal--

if(keyboard_check(vk_right))
{
	if(xSpeed < 0) xSpeed = 0;
	if(xSpeed < xSpeedMax) xSpeed += xAccel;
	right = 1;
}

if(keyboard_check(vk_left))
{
	if(xSpeed > 0) xSpeed = 0;
	if(xSpeed > -xSpeedMax) xSpeed -= xAccel;
	right = 0;
}

if(keyboard_check(vk_right) and keyboard_check(vk_left)) xSpeed = 0;
if(!keyboard_check(vk_right) and !keyboard_check(vk_left)) xSpeed = 0;

//crouch---

if(keyboard_check(vk_down))
{
	if(ground)
	{
		crouch = 1;
		xSpeed = 0;
		weaponMod_y = gun_y_crouch;
	}
	else
	{
		crouch = 0;
		weaponMod_y = gun_y_stand;
	}
}
else
{
	crouch = 0;
	weaponMod_y = gun_y_stand;
}

//salto ----

if(_k_jump_p)
{
	if(ground == 1)
	{
		ground = 0;

		if(crouch)
		{
			if(place_free(x,y+1))
			{
				y += 1; // bajar de una plataforma atravesable
			}
			else
			{
				ySpeed = -jumpPower;
			}
		}
		else
		{
			ySpeed = -jumpPower;
		}
	}
}

if(_k_jump_r)
{
	if(ySpeed < 0) ySpeed = 0;
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

// caer al vacio = muerte
if(y > room_height + 64) hp = 0;

if(hp <= 0)
{
	hp = 0;
	dead = 1;
	invi = 1;
	fury = 0;
	dmg_mult = 1;
	alarm[1] = -1;
	alarm[4] = -1;
	part_particles_create(global.part_front, x, y - 28, global.p_blood_chaos, 30);
	c_screen_shake(6, 20);
}

if(collision_rectangle(x-12,y,x+12,y+1,o_terrain,0,1) and collision_rectangle(x-12,y-10,x+12,y,o_terrain,0,1)==noone)
{
	// ground --------------
	ground = 1;
	ySpeed = 0;
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

// Armadura (regeneracion) -----------------

if(regen and armor < armorMax) armor = min(armorMax, armor + 0.25 * regen_mult);

// Plasma (enfriamiento) -------------------

if(!overheat and heat > 0) heat = max(0, heat - 0.4);

// Cambio de arma (Q) ----------------------

if(keyboard_check_pressed(ord("Q")))
{
	weapon_num = (weapon_num + 1) mod array_length(weapon_list);
	weapon = weapon_list[weapon_num];
}

// Furia del Emperador (E) -----------------

if(keyboard_check_pressed(ord("E")) and faith >= faithMax and !fury)
{
	fury = 1;
	faith = 0;
	dmg_mult = 2;
	invi = 1;
	alarm[1] = -1;
	alarm[4] = fury_time;
	c_screen_shake(5, 15);
	part_particles_create(global.part_front, x, y - 28, global.p_faith, 40);
}

if(fury and irandom(2) == 0)
{
	part_particles_create(global.part_front, x + random_range(-14,14), y - random(50), global.p_faith, 1);
}

if(flash > 0) flash -= 1;
if(melee_time > 0) melee_time -= 1;

// Weapons ------------------------------

if(_k_shoot)
{
	if(canShoot)
	{
		switch(weapon)
		{
			case "bolter":
				c_weapon_bolter();
			break;

			case "plasma":
				c_weapon_plasma();
			break;

			case "chainsword":
				c_weapon_chainsword();
			break;

			// armas originales del V-10
			case "pistol":
				c_weapon_pistol();
			break;

			case "laser":
				c_weapon_laser();
			break;
		}
	}
}

}
//Respawn ----------------
else
{
	image_alpha -= 0.01;
	if(image_alpha <= 0) // (antes era == 0 y por decimales podia no cumplirse nunca)
	{
		if(room != r_tutorial) global.vidas -= 1; // en el tutorial no se pierden vidas

		if(global.vidas <= 0)
		{
			room_goto(r_gameover);
			instance_destroy();
			exit;
		}

		global.player_respawn = 1;
		hp = hpMax;
		armor = armorMax;
		ammo_plasma = max(ammo_plasma, 10);
		heat = 0;
		overheat = 0;
		xSpeed = 0;
		ySpeed = 0;
		dead = 0;
		invi = 1;
		alarm[1] = 90; // invulnerable un momento al reaparecer
		image_alpha = 1;

		room_goto(global.checkpoint);
	}
}
