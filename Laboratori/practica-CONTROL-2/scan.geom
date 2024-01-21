#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin, boundingBoxMax;
uniform float time;

void dibuixaCara(vec3 a, vec3 b, vec3 c, vec3 d) {
	gl_Position = modelViewProjectionMatrix * vec4(a, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(b, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(c, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(d, 1); EmitVertex();
	EndPrimitive();
}

void main( void )
{
	if (gl_PrimitiveIDIn == 0) {
		float y = boundingBoxMin.y;
        float z = boundingBoxMin.z;

		float x = 0, xMax = 0;
		if (mod(floor(time), 2) == 1) {
			x = mix(boundingBoxMin.x,boundingBoxMax.x, fract(time));
			xMax = mix(boundingBoxMin.x,boundingBoxMax.x, fract(time))+0.1;
		} else {
			x = mix(boundingBoxMin.x,boundingBoxMax.x, 1 - fract(time));
			xMax = mix(boundingBoxMin.x,boundingBoxMax.x, 1 - fract(time))+0.1;
		}


        float zMax = boundingBoxMax.z;
        float yMax = boundingBoxMax.y;


        gfrontColor = vec4(0,0,1,1); //front
        dibuixaCara(vec3(x,y,zMax), vec3(xMax,y,zMax), vec3(x,yMax,zMax), vec3(xMax,yMax,zMax));

        gfrontColor = vec4(0,0,1,1); // back
        dibuixaCara(vec3(xMax,yMax,z), vec3(xMax,y,z), vec3(x,yMax,z), vec3(x,y,z));

        gfrontColor = vec4(1,0,0,1); //left
        dibuixaCara(vec3(x,yMax,zMax), vec3(x,yMax,z), vec3(x,y,zMax), vec3(x,y,z));

        gfrontColor = vec4(1,0,0,1); //right
        dibuixaCara(vec3(xMax,yMax,zMax), vec3(xMax,y,zMax), vec3(xMax,yMax,z), vec3(xMax,y,z));

        gfrontColor = vec4(0,1,0,1); //bottom
        dibuixaCara(vec3(x,y,zMax), vec3(x,y,z), vec3(xMax,y,zMax), vec3(xMax,y,z));

        gfrontColor = vec4(0,1,0,1); //top
        dibuixaCara(vec3(x,yMax,zMax), vec3(xMax,yMax,zMax), vec3(x,yMax,z), vec3(xMax,yMax,z));
	}

	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
}
