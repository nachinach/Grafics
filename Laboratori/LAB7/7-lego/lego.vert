#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 vfrontColor;
out vec2 vtexCoord;
const vec3 basicColors[5] = vec3[5] (
                        vec3(1.0,0.0,0.0),  //red
                        vec3(1.0,1.0,0.0),  //yellow
                        vec3(0.0,1.0,0.0),  //green
                        vec3(0.0,1.0,1.0),  //cian
                        vec3(0.0,0.0,1.0)); //blue
vec3 paint()
{
    vec3 paint = basicColors[0];
    float dMin = distance(basicColors[0],color);
    for (int i = 1 ; i < basicColors.length(); ++i) {
        float d = distance(basicColors[i],color);
        if (dMin > d) {
            dMin = d; paint = basicColors[i];
        }
    }
    return paint;
}

void main()
{
    vfrontColor = vec4(paint(),1);
    vtexCoord = texCoord;
    gl_Position = vec4(vertex, 1.0);
}
