#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;
uniform sampler2D colormap;

void paintMario(float x, float y) {
    //fragColor = texture(colormap,vec2(-13/7.0 * (vtexCoord.s - x/13.0) + 6/7.0,(vtexCoord.t-y/13.)*13));

}

void paintKong(float x, float y) {
    //fragColor = texture(colormap,vec2(13/7.*(vtexCoord.s-x/13.)+1/7.,(vtexCoord.t-y/13.)*13));

}

void paintPrincess(float x, float y) {
   //fragColor = texture(colormap,vec2(13/7.*(vtexCoord.s-x/13.)+4/7.,(vtexCoord.t-y/13.)*13));

}

void paintWallY() {
    //fragColor = texture(colorMap, vec2(mod
    //fragColor = texture(colormap,vec2(mod(vtexCoord.s,1/7.) + 3/7., vtexCoord.t*13));
}

void paintWallX() {
    //fragColor = texture(colorMap, vec2(mod
    //fragColor = texture(colormap,vec2(mod(vtexCoord.s,1/7.) + 2/7., vtexCoord.t*13));
    vec2 texCoord = vtexCoord * vec2(1.0/7.0, 1.0/1.0); // escalat
                 // (mod (vtexCoord.s, 1/graella.x) + offset imatge ) * (graella.x / num imatges)
    float auxx = (mod(vtexCoord.s,1/13.0) + 9/(13.0)) * (13.0/7.0);/* fract(texCoord.s) * 13*/
    float auxy = texCoord.t * 13;

    fragColor = texture(colormap, vec2(auxx, auxy));
    //fragColor = vec4(1);
}

void paintBarrileV(float x, float y) {
    //fragColor = texture(colormap,vec2(13/7.*(vtexCoord.s-x/13.),(vtexCoord.t-y/13.)*13));
}

void paintBarrileH(float x, float y) {
    //fragColor = texture(colormap,vec2(13/7.*(vtexCoord.t-x/13.) + 0/7.,(vtexCoord.s-y/13.)*13));
}

void main()
{

    // graella 13x13
    float x = vtexCoord.s*13;
    float y = vtexCoord.t*13;

    if( y > 1 && y < 2 ) {
        paintWallX();
    }
    /*if (x > 6 && x < 7 && y > 7 && y < 8) paintMario(6,7);
    else if (x > 9 && x < 10 && y > 9 && y < 10) paintKong(9,9);
    else if (x > 4 && x < 5 && y > 11 && y < 12) paintPrincess(4,11);
    else if (y > 0 && y < 1 || y > 3 && y < 4 || y > 6 && y < 7 || y > 10 && y < 11) paintWallX();
    else if ( y < 4 && y < 5  || y >=5 && y <= 6 ) paintWallY();
    else if (x > 9 && x < 10 && (y > 7 && y < 8 || y > 8 && y < 9)) paintBarrileV(9,7);
    else if (x > 8 && x < 9 && (y > 7 && y < 8 )) paintBarrileH(7,8);*/
    else fragColor = vec4(0);
}
