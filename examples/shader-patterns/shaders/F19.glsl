
varying vec2 vUv;

void main()
{
  float strength = step(0.7, mod(vUv.x - 0.65 * 1.0, 1.0)); 
  strength *= step(0.7, mod(vUv.y -0.65 * 1.0, 1.0)); 
  strength = 1.0 - strength; 

  gl_FragColor = vec4(vec3(strength), 1.0);
}
