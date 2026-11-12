// solo se destruye contra paredes, no contra el piso
if(place_meeting(x + sign(hspeed) * 4, y - 8, o_solid)) instance_destroy();
