
varying vec2 vUv;

void main()
{
    float strength = step(0.4, mod(vUv.x * 10.0, 1.0) ); 
    strength *= step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0) );

    float strength2 = step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0) ); 
    strength2 *= step(0.4, mod(vUv.y * 10.0, 1.0) );

  gl_FragColor = vec4(vec3(strength), 1.0);
}
