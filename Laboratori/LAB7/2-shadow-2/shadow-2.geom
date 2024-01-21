#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

in vec4 vfrontColor[];
out vec4 gfrontColor;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vec4(0,0,0,1);
		vec4 aux_gl_Position = gl_in[i].gl_Position;
		aux_gl_Position.y = boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix * aux_gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	if (gl_PrimitiveIDIn == 0) {
		float R = distance(boundingBoxMin, boundingBoxMax)/2;
		vec3 C = vec3((boundingBoxMax.x+boundingBoxMin.x)/2, boundingBoxMin.y-0.01, (boundingBoxMax.z+boundingBoxMin.z)/2);
		gfrontColor = vec4(0,1,1,1);

		//Vertex 0
		gl_Position = modelViewProjectionMatrix * vec4(C.x-R, C.y, C.z-R, 1);
		EmitVertex();
		//Vertex 1
		gl_Position = modelViewProjectionMatrix * vec4(C.x+R, C.y, C.z-R, 1);
		EmitVertex();
		//Vertex 2
		gl_Position = modelViewProjectionMatrix * vec4(C.x-R, C.y, C.z+R, 1);
		EmitVertex();
		//Vertex 3
		gl_Position = modelViewProjectionMatrix * vec4(C.x+R, C.y, C.z+R, 1);
		EmitVertex();

		EndPrimitive();
	}
}
