if (live_call()) return live_result;
#region camera controls
_look_dir -= (window_mouse_get_x() - (window_get_width() / 2)) / 10;
_look_pit += (window_mouse_get_y() - (window_get_height() /2)) / 10;
_look_pit = clamp(_look_pit, -88, 88);
window_mouse_set(window_get_width()/2,window_get_height()/2);
#endregion

#region camera movement
if keyboard_check(vk_space) {
	_z += 1*_spd;	
	last_key_timer = 10;
}
if keyboard_check(vk_shift) {
	_z -= 1*_spd;
	last_key_timer = 10;
}
if keyboard_check(ord("W")) {
	_x += dcos(_look_dir)*_spd;
	_y += dsin(_look_dir)*_spd;
	last_key_timer = 10;
}
if keyboard_check(ord("A")) {
	_x += dcos(_look_dir+90)*_spd;
	_y += dsin(_look_dir+90)*_spd;
	last_key_timer = 10;
}
if keyboard_check(ord("S")) {
	_x -= dcos(_look_dir)*_spd;
	_y -= dsin(_look_dir)*_spd;
	last_key_timer = 10;
}
if keyboard_check(ord("D")) {
	_x += dcos(_look_dir-90)*_spd;
	_y += dsin(_look_dir-90)*_spd;
	_last_key_timer = 10;
}
_last_key_timer--;
if _last_key_timer < 0 {
}
#endregion


#region End Game
if keyboard_check_direct(vk_escape) { game_end(); }
#endregion