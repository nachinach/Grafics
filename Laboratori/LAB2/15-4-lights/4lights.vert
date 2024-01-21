#version 330 core
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

uniform mat4 modelViewProjectionMatrix;

out vec3 N;   
out vec3 P; 

void main( void )
{
	gl_Position = modelViewProjectionMatrix*vec4(vertex,1.0);
	N = normal;
	P = vec4(vertex,1.0).xyz;
}



