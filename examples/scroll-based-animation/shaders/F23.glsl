
varying vec2 vUv;

#include './includes/random.glsl'

void main()
{
  float strength = random(vUv);

  gl_FragColor = vec4(vec3(strength), 1.0);
}
