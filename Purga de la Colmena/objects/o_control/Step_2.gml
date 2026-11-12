// camara que sigue al jugador + screen shake --------------

var _cam = view_camera[0];
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);

var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);

if(instance_exists(o_player))
{
	var _tx = o_player.x - _vw/2;
	var _ty = o_player.y - 40 - _vh/2;

	if(snap)
	{
		_cx = _tx;
		_cy = _ty;
		snap = 0;
	}
	else
	{
		_cx = lerp(_cx, _tx, 0.12);
		_cy = lerp(_cy, _ty, 0.12);
	}
}

_cx = clamp(_cx, 0, max(0, room_width - _vw));
_cy = clamp(_cy, 0, max(0, room_height - _vh));

// shake ---------------------------
var _sx = 0;
var _sy = 0;
if(global.shake_time > 0)
{
	_sx = random_range(-global.shake_amt, global.shake_amt);
	_sy = random_range(-global.shake_amt, global.shake_amt);
	global.shake_time -= 1;
	if(global.shake_time <= 0) global.shake_amt = 0;
}

// posicion redondeada: evita que el pixel art tiemble
camera_set_view_pos(_cam, round(_cx + _sx), round(_cy + _sy));
