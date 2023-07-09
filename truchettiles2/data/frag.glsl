precision highp float;


uniform float width;
uniform float height;
uniform float time;
uniform float transp;



vec2 iResolution;

float map(float X, float A, float B, float C, float D){
    return (X-A)/(B-A) * (D-C) + C;
}



void main() {
    vec2 st = gl_FragCoord.xy/vec2(width, height);
    vec3 color = vec3(0.0);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5)-st;
    float angle = atan(toCenter.y,toCenter.x) ;
    float radius = length(toCenter)*1.4;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
    color = vec3( 0.0, radius-.2*sin(time/50.), 1.0-.2*cos(time/100.));

    gl_FragColor = vec4(color,transp);
}