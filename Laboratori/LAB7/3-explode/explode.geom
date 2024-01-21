#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 norm[];
in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

const float speed = 0.5;

void main( void )
{
	vec3 direccio = vec3(0);
	for( int i = 0 ; i < 3 ; i++ ) {
		direccio += norm[i];
	}
	direccio = direccio/3;

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		float factor = speed * time;
		mat4 trans = mat4(vec4(1,0,0,0),
						  vec4(0,1,0,0),
						  vec4(0,0,1,0),
						  vec4(factor * direccio.x,factor * direccio.y,factor * direccio.z,1));

		vec4 vtrans = trans * gl_in[i].gl_Position;
		gl_Position = modelViewProjectionMatrix * vtrans;
		EmitVertex();

		gfrontColor = vfrontColor[i];
		/*
		vec3 factor = speed * time * (norm[0]+norm[1]+norm[2])/3; //fora del bucle
		vec3 V = gl_in[i].gl_Position.xyz + factor;
		gl_Position = modelViewProjectionMatrix*vec4(V,1);
		EmitVertex();*/
	}
    EndPrimitive();
}
