precision highp float;

varying vec2 vTexCoord;
varying vec4 vVertexColor;

void main() {
  // Tell WebGL what color to make the pixel
  gl_FragColor = vVertexColor;
}