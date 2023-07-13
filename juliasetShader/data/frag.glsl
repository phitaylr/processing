precision highp float;

uniform float u_resW;
uniform float u_resH;
uniform float mouseX;
uniform float width;
uniform float height;
uniform int maxIterations;
uniform float centerx;
uniform float centery;

uniform float mouseY;
const float escapeRadius = 4.0;
const float escapeRadius2 = escapeRadius * escapeRadius;
//const int maxIterations = 40;

vec2 iResolution;

vec2 ipow2(vec2 v) {
  return vec2(v.x * v.x - v.y * v.y, v.x * v.y * 2.0);
}

// Procedural palette generator by Inigo Quilez.
// See: http://iquilezles.org/articles/palettes/
vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
  return a + b * cos(2*3.14 * (c * t + d));
}


float map(float X, float A, float B, float C, float D){
    return (X-A)/(B-A) * (D-C) + C;
}

vec3 paletteColor(float t) {
  vec3 a = vec3(0.75);
  vec3 b = vec3(1.0);
  vec3 c = vec3(1.0);
  vec3 d = vec3(0.05, 0.15, 0.2);
  return palette(fract(t + 0.5), a, b, c, d);
}



void main() {
  iResolution = vec2(u_resW, u_resH);

  vec2 uv = vec2(map(gl_FragCoord.x, 0, u_resW, centerx - width/2, centerx + width/2), map(gl_FragCoord.y, 0, u_resH, centery-height/2, centery+height/2));
  vec2 z = uv;
  vec2 c = vec2(map(mouseX, 0, u_resW, -4,4), map(mouseY, 0, u_resH, -4,4));
  // vec2 c = vec2(-.4, .6);
  //vec2 c = z;
  int iteration;

  // Iterate until either the escape radius or max iteration is exceeded.
  for (int i = 0; i < maxIterations; i++) {
    z = ipow2(ipow2(z)) + c;
    if (dot(z, z) > escapeRadius2) {
      break;
    }
    iteration++;
  }

  vec3 color = iteration >= maxIterations ? vec3(0.0) : paletteColor(float(iteration) / float(maxIterations));

  gl_FragColor = vec4(color, 1.0);
}