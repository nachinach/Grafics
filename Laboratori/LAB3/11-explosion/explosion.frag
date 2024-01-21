/*#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D explosion;
in vec2 vtexCoord;


uniform float slice = 1.0/30.0;
uniform int fx = 8;
uniform int fy = 6;
uniform float time;

void main()
{
	int frames = fx*fy;
	float ybit = 1.0/fy;
	float xbit = 1.0/fx;
	
	int frame = int(mod(time/slice,frames));
	vec2 t = vec2((vtexCoord.s + (frame % fx))*xbit,(vtexCoord.t + (fy-1-frame/fx))*ybit);
	
    fragColor = texture(explosion, t);
    fragColor = fragColor.a * fragColor;
}
*/

#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D explosion;

uniform float time;
const float speed = 5;

void main()
{
    float slice = 1.0/2;
    int frame = int(mod(speed*time/slice, 48));
    float x = frame%8;
    float y = -(1+frame/8);

    vec2 texCoord = vtexCoord * vec2(1.0/8, 1.0/6);
    texCoord.x += x/8.0;
    texCoord.y += y/6.0;
    fragColor = texture(explosion, texCoord);
    fragColor *= fragColor.a;
}
