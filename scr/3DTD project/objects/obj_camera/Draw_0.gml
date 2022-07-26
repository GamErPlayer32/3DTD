if (live_call()) return live_result;
//get camera propertys
var xa=2, ya=2, za=2, xb=0, yb=0, zb=0, xc=0, yc=0, zc=-1;
var fovy=70,aspect=16/9,zn=1,zf=32000;

//set the cameras data
var camera = camera_get_active();
camera_set_view_mat(camera, matrix_build_lookat(xa,ya,za,	
												xb,yb,zb,
												xc,yc,zc));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(fovy,aspect,zn,zf));
camera_apply(camera);

//submit the vertex / 3D objects to the world
vertex_submit(land,pr_trianglelist,sprite_get_texture(spr_texture_1,0));
