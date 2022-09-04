if (live_call()) return live_result;
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

//setup camera variables
#region Variables Setup
depth = 9999;
_spd = 0.1;
_x = 10;
_y = 10;
_z = 10;
_last_key_timer = 0;
_look_dir = 0;
_look_pit = 0;
#endregion

//Create Vertex Format
#region Vertex Format Create
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();
#endregion

//load Objects
#region load objects
land = scr_inport_obj("temp_house_playground.obj",vertex_format);
#endregion