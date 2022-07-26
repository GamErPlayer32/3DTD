if (live_call()) return live_result;
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

//setup camera variables
depth = 9999;
_x = 1;
_y = 1;
_z = 1;

//Create Vertex Format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();

//load Objects
land = scr_inport_obj("temp_house_playground.obj",vertex_format);