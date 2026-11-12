/// @description Salto (fase 2 y 3)

if(!instance_exists(o_player) or !active) exit;

if(phase >= 2 and ground)
{
	ground = 0;
	ySpeed = -jumpPower;
	xSpeed = clamp((o_player.x - x) / 45, -xSpeedMax, xSpeedMax);
}

if(phase == 3) alarm[1] = 150; else alarm[1] = 110;
