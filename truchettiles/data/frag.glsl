precision highp float;


uniform float width;
uniform float height;
uniform float time;


vec2 iResolution;

float map(float X, float A, float B, float C, float D){
    return (X-A)/(B-A) * (D-C) + C;
}

vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}


void main() {
    vec2 st = gl_FragCoord.xy/vec2(width, height);
    vec3 color = vec3(0.0);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5)-st;
    float angle = atan(toCenter.y,toCenter.x) ;
    float radius = length(toCenter)*2.0;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color = hsb2rgb(vec3(((angle+time/500.)/6.28)+0.5 ,radius,1.0));

    gl_FragColor = vec4(color,1.0);
}