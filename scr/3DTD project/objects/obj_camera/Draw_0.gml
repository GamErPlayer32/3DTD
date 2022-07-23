if (live_call()) return live_result;
var xa=0, ya=0, za=100, xb=100, yb=100, zb=0, xc=0, yc=0, zc=-1;
var fovy=70,aspect=16/9,zn=1,zf=32000;

var camera = camera_get_active();
camera_set_view_mat(camera, matrix_build_lookat(xa,ya,za,	
												xb,yb,zb,
												xc,yc,zc));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(fovy,aspect,zn,zf));
camera_apply(camera);