#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

in vec2 P;
uniform int mode = 3;
float ample = 0.05;
float radi = 0.5;
float sc = 5;

uniform vec2 p1 = vec2(-3, -8); // 3m cap a l’esquerra (-X), 8m cap a baix (-Y)
uniform vec2 p2 = vec2( 3, -8);
uniform vec2 p3 = vec2(-2, 2);
uniform vec2 p4 = vec2( 2, 2);

uniform sampler2D courtMap;
uniform sampler2D player1;

void main()
{
    fragColor = texture(courtMap, vtexCoord);

    if (mode >= 1) {
        if (fract(P.x) <= ample || fract(P.y) <= ample) {
            fragColor = fragColor * vec4(vec3(1.2), 1);
        }

        if (mode == 2) {
            if (distance(P, p1) <= radi ||
                distance(P, p2) <= radi ||
                distance(P, p3) <= radi ||
                distance(P, p4) <= radi) {

                fragColor = vec4(vec3(0), 1);
            }

            if (distance(P, p1) <= radi-0.1 ||
                distance(P, p2) <= radi-0.1 ||
                distance(P, p3) <= radi-0.1 ||
                distance(P, p4) <= radi-0.1) {

                fragColor = vec4(1);
            }
        } else if (mode == 3) {
            vec4 C = vec4(0, 0, 1, 0);
            mat4 scale = mat4(vec4(sc,0,0,0),
                              vec4(0,sc*1.5,0,0),
                              vec4(0,0,1,0),
                              vec4(0,0,0,1));


            if (abs(P.x - p1.x) <= 1 && abs(P.y - p1.y) <= 1.3 ||
                abs(P.x - p2.x) <= 1 && abs(P.y - p2.y) <= 1.3 ) {
                C = texture(player1, (scale*vec4(vtexCoord,1,1)).xy + vec2(0.5, 0.75));
            }
            else if (abs(P.x - p3.x) <= 1 && abs(P.y - p3.y) <= 1.3 ||
                     abs(P.x - p4.x) <= 1 && abs(P.y - p4.y) <= 1.3) {

                float angle = radians(180.0);
                mat4 mrot = mat4(vec4(cos(angle),sin(angle),0,0),
                                 vec4(-sin(angle),cos(angle),0,0),
                                 vec4(0,0,1,0),vec4(0,0,0,1));
                C = texture(player1, (scale*mrot*vec4(vtexCoord,1,1)).xy + vec2(0, 0));
                //C = mrot * C;
            }


            if (C.r > 0.5 || C.b < 0.5) {
                fragColor = C;
            }
        }

    }
}
