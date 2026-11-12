t += 1;

// mover en la grilla 3x3 ----------
if(keyboard_check_pressed(vk_right)) sel = (sel div 3) * 3 + ((sel mod 3) + 1) mod 3;
if(keyboard_check_pressed(vk_left))  sel = (sel div 3) * 3 + ((sel mod 3) + 2) mod 3;
if(keyboard_check_pressed(vk_down))  sel = (sel + 3) mod 9;
if(keyboard_check_pressed(vk_up))    sel = (sel + 6) mod 9;

// confirmar -----------------------
if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space))
{
	global.chapter = sel;
	room_goto(r_1);
}
