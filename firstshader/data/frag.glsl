precision highp float;


uniform float width;
uniform float height;
uniform float u_time;
uniform float transp;



vec2 iResolution;

float map(float X, float A, float B, float C, float D){
    return (X-A)/(B-A) * (D-C) + C;
}

void main() {
    vec2 st = gl_FragCoord.xy/vec2(width,height);
    gl_FragColor = vec4(st.x,1.0-abs(sin(u_time)),abs(sin(st.y)),1.0);
}