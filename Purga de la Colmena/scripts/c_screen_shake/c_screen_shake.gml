// Temblor de camara: intensidad en pixeles, duracion en frames
function c_screen_shake(_amount, _time)
{
	if(_amount >= global.shake_amt or global.shake_time <= 0)
	{
		global.shake_amt = _amount;
		global.shake_time = _time;
	}
}
