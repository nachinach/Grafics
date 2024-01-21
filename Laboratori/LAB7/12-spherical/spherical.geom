#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec2 gPos;

uniform float side = 0.1;
uniform mat4 projectionMatrix;


void main( void )
{
	vec4 centre = gl_in[0].gl_Position;
	gPos = vec2(0,1);
	gl_Position = projectionMatrix * (centre + vec4(side,-side,0,0)); EmitVertex(); // top left
	gPos = vec2(1,1);
	gl_Position = projectionMatrix * (centre + vec4(side,side,0,0)); EmitVertex(); // top right
	gPos = vec2(0,0);
	gl_Position = projectionMatrix * (centre + vec4(-side,-side,0,0)); EmitVertex(); // bottom left
	gPos = vec2(1,0);
	gl_Position = projectionMatrix * (centre + vec4(-side,side,0,0)); EmitVertex(); // bottom right

    EndPrimitive();
}
