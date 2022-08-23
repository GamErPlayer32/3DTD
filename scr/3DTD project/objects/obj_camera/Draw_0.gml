if (live_call()) return live_result;
//get camera propertys
#region camera settings
var xa=2, ya=2, za=2, xb=0, yb=0, zb=0, xc=0, yc=0, zc=-1;
var fovy=70,aspect=16/9,zn=0.01,zf=32000;
#endregion

#region Update Camera Cords
xa = _x;
ya = _y;
za = _z;
xb = xa + dcos(_look_dir) * dcos(_look_pit);
yb = ya + dsin(_look_dir) * dcos(_look_pit);
zb = za - dsin(_look_pit);
#endregion
//First Person Camera

//set the cameras data
#region camera setup
draw_clear(c_black);
var camera = camera_get_active();
camera_set_view_mat(camera, matrix_build_lookat(xa,ya,za,	
												xb,yb,zb,
												xc,yc,zc));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(fovy,aspect,zn,zf));
camera_apply(camera);
#endregion

//submit the vertex / 3D objects to the world
#region Vertex Draw
matrix_set(matrix_world,matrix_build(0,0,0,	-90,0,0,	1,1,1));
vertex_submit(land,pr_trianglelist,sprite_get_texture(spr_texture_1,0));
matrix_set(matrix_world,matrix_build_identity());
#endregion
