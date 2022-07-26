if (live_call()) return live_result;
//camera_movement_controls
look_dir -= (window_mouse_get_x() - (window_get_width() / 2)) / 10;

window_mouse_set(window_get_width()/2,window_get_height()/2);

if keyboard_check_direct(vk_escape) { game_end(); }