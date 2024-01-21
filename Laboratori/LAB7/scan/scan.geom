#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform float time;

uniform mat4 modelViewProjectionMatrix;

void makeFace(vec3 a, vec3 b, vec3 c, vec3 d ) {
        
        gl_Position = modelViewProjectionMatrix*vec4(a,1);EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(b,1);EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(c,1);EmitVertex();
        gl_Position = modelViewProjectionMatrix*vec4(d,1);EmitVertex();
        EndPrimitive();
}

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix *gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    if (gl_PrimitiveIDIn == 0) {

        float y = boundingBoxMin.y;
        float z = boundingBoxMin.z;
        float x = mix(boundingBoxMin.x,boundingBoxMax.x, fract(time));
        float xMax = mix(boundingBoxMin.x,boundingBoxMax.x, fract(time))+0.1;
        float zMax = boundingBoxMax.z;
        float yMax = boundingBoxMax.y;
        
        
        gfrontColor = vec4(0,0,1,1); //front
        makeFace(vec3(x,y,zMax), vec3(xMax,y,zMax), vec3(x,yMax,zMax), vec3(xMax,yMax,zMax));
        
        gfrontColor = vec4(0,0,1,1); // back
        makeFace(vec3(xMax,yMax,z), vec3(xMax,y,z), vec3(x,yMax,z), vec3(x,y,z));
        
        gfrontColor = vec4(1,0,0,1); //left
        makeFace(vec3(x,yMax,zMax), vec3(x,yMax,z), vec3(x,y,zMax), vec3(x,y,z));
        
        gfrontColor = vec4(1,0,0,1); //right
        makeFace(vec3(xMax,yMax,zMax), vec3(xMax,y,zMax), vec3(xMax,yMax,z), vec3(xMax,y,z));
        
        gfrontColor = vec4(0,1,0,1); //bottom
        makeFace(vec3(x,y,zMax), vec3(x,y,z), vec3(xMax,y,zMax), vec3(xMax,y,z));
        
        gfrontColor = vec4(0,1,0,1); //top
        makeFace(vec3(x,yMax,zMax), vec3(xMax,yMax,zMax), vec3(x,yMax,z), vec3(xMax,yMax,z));
        
       }
}
