#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform float speed = 1.0;
uniform float time;

void main( void )
{
	if (0 <= time && time < 1.0/speed) {
		if (gl_PrimitiveIDIn % 2 == 0) {
			for( int i = 0 ; i < 3 ; i++ )
			{
				gfrontColor = vfrontColor[i];
				gl_Position = gl_in[i].gl_Position;
				EmitVertex();
			}
			EndPrimitive();
		} else {
			//shrink
		}
	} else {
		if (gl_PrimitiveIDIn % 2 == 0) {
			//shrink
		} else {
			for( int i = 0 ; i < 3 ; i++ )
			{
				gfrontColor = vfrontColor[i];
				gl_Position = gl_in[i].gl_Position;
				EmitVertex();
			}
			EndPrimitive();
		}
	}

}
