#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec2 gtexCoord;
in vec3 tCentre;
uniform int mode = 3;
uniform float cut = -0.25;

void main()
{
    if ( mode == 2) {
        if (gtexCoord.s > 0.05 && gtexCoord.s < 0.95 &&
            gtexCoord.t > 0.05 && gtexCoord.t < 0.95) {

            fragColor = gfrontColor;
        } else {
            fragColor = vec4(0);
        }
    } else if ( mode == 3) {
        if (tCentre.x < cut || tCentre.y < cut || tCentre.z < cut) {
            if (gtexCoord.s > 0.05 && gtexCoord.s < 0.95 &&
                gtexCoord.t > 0.05 && gtexCoord.t < 0.95) {

                fragColor = gfrontColor;
            } else {
                fragColor = vec4(0);
            }
        } else {
            discard;
        }

    } else {
        fragColor = gfrontColor;
    }
}
