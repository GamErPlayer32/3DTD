function draw_sprite_billboard(_si,_ii,_xx,_yy,_zz,_scale,_vis,_dir){
	shader_set(shd_billboard);
	matrix_set(matrix_world,matrix_build(_xx,_yy,_zz,0,0,_dir+90,1,1,1));
	draw_sprite_ext(_si,_ii,0,0,_scale,_scale,0,make_color_rgb(255*_vis,255*_vis,255*_vis),1);
	matrix_set(matrix_world,matrix_build_identity());
	shader_reset();
}
function scr_inport_obj(filename,vf){
	/// @param File
	/// @param Vertex Format
	var obj_file = file_text_open_read(filename);
	var model=vertex_start(vf);
	
	var vertex_x = ds_list_create();
	var vertex_y = ds_list_create();
	var vertex_z = ds_list_create();
	var vertex_nx = ds_list_create();
	var vertex_ny = ds_list_create();
	var vertex_nz = ds_list_create();
	var vertex_xtex = ds_list_create();
	var vertex_ytex = ds_list_create();
	
	while(not file_text_eof(obj_file)) {
		var line=file_text_read_string(obj_file); //currentline
		file_text_readln(obj_file); //next line
		var terms, index;
		index=0;
		terms[0]="";
		terms[string_count(line," ")]="";
		for(var i=1; i<=string_length(line);i++;) {
			if (string_char_at(line,i)==" ") {
				index++;
				terms[index]="";
			} else {
				terms[index]=terms[index]+string_char_at(line,i);
			}
		}
		switch(terms[0]) {
			case "v":
				if terms[1] == "" { terms[1] = 0; }
				if terms[2] == "" { terms[2] = 0; }
				if terms[3] == "" { terms[3] = 0; }
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
				break;
			case "vt":
				if terms[1] == "" { terms[1] = 0; }
				if terms[2] == "" { terms[2] = 0; }
				ds_list_add(vertex_xtex, real(terms[1]));
				ds_list_add(vertex_ytex, real(terms[2]));	
				break;
			case "vn":
				break;
			case "f":
				var xx_a = 0;
				var yy_a = 0;
				var zz_a = 0;
				var xtex_a = 0;
				var ytex_a = 0;
				var xx_b = 0;
				var yy_b = 0;
				var zz_b = 0;
				var xtex_b = 0;
				var ytex_b = 0;
				var xx_c = 0;
				var yy_c = 0;
				var zz_c = 0;
				var xtex_c = 0;
				var ytex_c = 0;
				for(var n=1; n<=3; n++;) {
					var data, index;
					index=0;
					data[0]="";
					data[string_count(terms[n]," ")]="";
					for(var i=1; i<string_length(terms[n]);i++;) {
						if (string_char_at(terms[n],i) =="/") {
							index++;
							data[index]="";
						} else {
							data[index]=data[index]+string_char_at(terms[n],i);	
						}
					}
					//show_debug_message(string(n));
					if n == 1 {
					xx_a = ds_list_find_value(vertex_x,real(data[0])-1);
					yy_a = ds_list_find_value(vertex_y,real(data[0])-1);
					zz_a = ds_list_find_value(vertex_z,real(data[0])-1);
					xtex_a = ds_list_find_value(vertex_xtex,real(data[1])-1);
					ytex_a = ds_list_find_value(vertex_ytex,real(data[1])-1);
					} else if n == 2 {
					xx_b = ds_list_find_value(vertex_x,real(data[0])-1);
					yy_b = ds_list_find_value(vertex_y,real(data[0])-1);
					zz_b= ds_list_find_value(vertex_z,real(data[0])-1);
					xtex_b = ds_list_find_value(vertex_xtex,real(data[1])-1);
					ytex_b = ds_list_find_value(vertex_ytex,real(data[1])-1);	
					} else if n == 3 {
					xx_c = ds_list_find_value(vertex_x,real(data[0])-1);
					yy_c = ds_list_find_value(vertex_y,real(data[0])-1);
					zz_c = ds_list_find_value(vertex_z,real(data[0])-1);
					xtex_c = ds_list_find_value(vertex_xtex,real(data[1])-1);
					ytex_c = ds_list_find_value(vertex_ytex,real(data[1])-1);	
					}
					
					
					
				}
				var va = new Vector3(xx_a,yy_a,zz_a);
				var vb = new Vector3(xx_b,yy_b,zz_b);
				var vc = new Vector3(xx_c,yy_c,zz_c);
				
				var ea = vb.Sub(va);
				var eb = vc.Sub(va);
				
				var normb = ea.Cross(eb).Normalize();
				
				vertex_point_create(model,xx_a,yy_a,zz_a,c_white,1,xtex_a,ytex_a,normb.x,normb.y,normb.z);
				vertex_point_create(model,xx_b,yy_b,zz_b,c_white,1,xtex_b,ytex_b,normb.x,normb.y,normb.z);
				vertex_point_create(model,xx_c,yy_c,zz_c,c_white,1,xtex_c,ytex_c,normb.x,normb.y,normb.z);
				break;
		}
		
	}
	vertex_end(model);
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);
	
	file_text_close(obj_file);
	return model;
}
function Vector3(x, y, z) constructor {
    self.x = x;
    self.y = y;
    self.z = z;
    
    static Sub = function(val) {
        return new Vector3(self.x - val.x, self.y - val.y, self.z - val.z);
    };
    
    static Cross = function(val) {
        return new Vector3(self.y * val.z - val.y * self.z, self.z * val.x - val.z * self.x, self.x * val.y - val.x * self.y);
    };
    
    static Magnitude = function() {
        return point_distance_3d(0, 0, 0, self.x, self.y, self.z);
    };
    
    static Normalize = function() {
        var mag = self.Magnitude();
        return new Vector3(self.x / mag, self.y / mag, self.z / mag);
    };
}
function vertex_start(_vf) {
	var _vb = vertex_create_buffer();
	vertex_begin( _vb , _vf)
	return _vb;
}
function vertex_point_create() {
	/// @param vbuffer
	/// @param x
	/// @param y
	/// @param z
	/// @param color
	/// @param alpha
	/// @param u
	/// @param v
	/// @param nx
	/// @param ny
	/// @param nz
	
	var _x = 0; //1
	var _y = 0; //2
	var _z = 0; //3
	var _color = c_white;
	var _alpha = 1;
	var _u = 0;
	var _v = 0;
	var _nx = 0;
	var _ny = 0;
	var _nz = 0;
	if argument_count > 0 {
	if is_undefined(argument[0]) { game_end(); } else { var _vb = argument[0]; }
	if argument_count > 1 {
	if is_undefined(argument[1]) { _x = 0; } else { _x = argument[1]; }
	if argument_count > 2 {
	if is_undefined(argument[2]) { _y = 0; } else { _y = argument[2]; }
	if argument_count > 3 {
	if is_undefined(argument[3]) { _z = 0; } else { _z = argument[3]; }
	if argument_count > 4 {
	if is_undefined(argument[4]) { _color = c_white; } else { _color = argument[4]; }
	if argument_count > 5 {
	if is_undefined(argument[5]) { _alpha = 1; } else { _alpha = argument[5]; }
	if argument_count > 6 {
	if is_undefined(argument[6]) { _u = 0; } else { _u = argument[6]; }
	if argument_count > 7 {
	if is_undefined(argument[7]) { _v = 0; } else { _v = argument[7]; }
	if argument_count > 8 {
	if is_undefined(argument[8]) { _nx = 0; } else { _nx = argument[8]; }
	if argument_count > 9 {
	if is_undefined(argument[9]) { _ny = 0; } else { _ny = argument[9]; }
	if argument_count > 10 {
	if is_undefined(argument[10]) { _nz = 0; } else { _nz = argument[10]; }
	if argument_count > 11 {
	game_end();
	}}}}}}}}}}}} else {
		game_end(); 
	}
	vertex_position_3d( _vb , _x , _y , _z );
	vertex_normal( _vb , _nx , _ny , _nz );
	vertex_texcoord( _vb , _u , _v );
	vertex_color( _vb , _color , _alpha );
}