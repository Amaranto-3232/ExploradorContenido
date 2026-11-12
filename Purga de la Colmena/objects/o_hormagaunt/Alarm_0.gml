/// @description Salto hacia el jugador

alarm[0] = irandom_range(jumpTime/2, jumpTime);

if(!instance_exists(o_player)) exit;
if(abs(o_player.x - x) > sight or abs(o_player.y - y) > 200) exit;
if(!ground) exit;

ground = 0;
ySpeed -= jumpPower;
xSpeed = xSpeedMax;

if(o_player.x > x)
{
	image_xscale = 1;
}
else
{
	image_xscale = -1;
	xSpeed *= -1;
}
