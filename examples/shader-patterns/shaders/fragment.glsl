#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

vec4 permute(vec4 x)
{
    return mod(((x*34.0)+1.0)*x, 289.0);
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
//
vec2 fade(vec2 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

float cnoise(vec2 P){
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);
  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x,gy.x);
  vec2 g10 = vec2(gx.y,gy.y);
  vec2 g01 = vec2(gx.z,gy.z);
  vec2 g11 = vec2(gx.w,gy.w);
  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));
  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

void main()
{
    //Pattern 3 - B&W left to right grading
    float strength = vUv.x;
    gl_FragColor = vec4(vUv, 1.0, 1.0);

    //Pattern 4 - B&W bottom to top grading
    // float strength = vUv.y;

    //Pattern 5 - B&W top to bottom grading
    // float strength = 1.0 - vUv.y ;

    //Pattern 6 - B&W bottom to top grading with a lot of white on top
    // float strength =  vUv.y * 10.0 ;

    //Pattern 7 - B&W volet-like degrade
    // float strength = mod(vUv.y * 10.0, 1.0) ;
    
    //Pattern 8 - B&W volet-like sharp divisions no degrade
    // float strength = mod(vUv.y * 10.0, 1.0) ;
    // strength = step(0.5, strength); // if strength is > 0.5 strength = 1 else strength = 0

    //Pattern 9 - B&W volet-like idem 8 with bigger black division
    // float strength = mod(vUv.y * 10.0, 1.0) ;
    // strength = step(0.8, strength); // if strength is > 0.5 strength = 1 else strength = 0

    //Pattern 10 - B&W volet-like idem 9 vertical divisions
    // float strength = mod(vUv.x * 10.0, 1.0) ;
    // strength = step(0.8, strength); // if strength is > 0.5 strength = 1 else strength = 0

    //Pattern 11 - White grid 
    // float strength = step(0.8, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength += step(0.8, mod(vUv.y * 10.0, 1.0) );

    //Pattern 12 - White points
    // float strength = step(0.8, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength *= step(0.8, mod(vUv.y * 10.0, 1.0) );

    //Pattern 13 - White horizontal pointille
    // float strength = step(0.2, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength *= step(0.8, mod(vUv.y * 10.0, 1.0) );

     //Pattern 14 - White inverted L
    // float strength = step(0.2, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength *= step(0.8, mod(vUv.y * 10.0, 1.0) );
    // float strength2 = step(0.8, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength2 *= step(0.2, mod(vUv.y * 10.0, 1.0) );
    // strength += strength2;

    //Pattern 15 - White crosses
    // float strength = step(0.4, mod(vUv.x * 10.0, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength *= step(0.8, mod(vUv.y * 10.0 + 0.2, 1.0) );
    // float strength2 = step(0.8, mod(vUv.x * 10.0 + 0.2, 1.0) ); // if strength is > 0.5 strength = 1 else strength = 0
    // strength2 *= step(0.4, mod(vUv.y * 10.0, 1.0) );
    // strength += strength2;

    //Pattern 16 - B&W horizontal grading towards center
    // float strength = abs(vUv.x - 0.5);

    //Pattern 17 - B&W grading towards center (cross)
    // float strength = min(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    //Pattern 18 - B&W grading towards center (cross)
    // float strength = max(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    //Pattern 19 - Frame
    // float strength = step(0.7, mod(vUv.x - 0.65 * 1.0, 1.0)); // yo
    // strength *= step(0.7, mod(vUv.y -0.65 * 1.0, 1.0)); // yo
    // strength = 1.0 - strength; //yo

    // float strength = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    //Pattern20 - Frame
    // float strength = step(0.4, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    //Pattern 21 - Ten tiles with each ona a different color making a gradiant
    // float strength =  floor(vUv.x * 10.0) /10.0; // if strength is > 0.5 strength = 1 else strength = 0

    //Pattern 22 - Ten tiles with each ona a different color making a gradiant
    // float strength =  floor(vUv.x * 10.0) /10.0; // if strength is > 0.5 strength = 1 else strength = 0
    // strength *=  floor(vUv.y * 10.0 ) /10.0;

    //Pattern 23 - timy points (tv static)
    // float strength = random(vUv);

    //Pattern 24 - grid with different coloros (random)
    // vec2 gridUv = vec2(
    //     floor(vUv.x * 10.0) /10.0,
    //     floor(vUv.y * 10.0) /10.0
    // );

    // float strength = random(gridUv);

    //Pattern 25 - timy points (tv static)
    // vec2 gridUv = vec2(
    //     floor(vUv.x  * 10.0) /10.0,
    //     floor((vUv.y + vUv.x )* 10.0 ) /10.0  
    // );

    // float strength = random(gridUv);

    //Pattern 27 black circle on the center degrading towards coins
    // float strength = length(vUv - 0.5) ;
    // float strength = distance(vUv, vec2(0.5)) ;

    //Pattern 28 white circle on the center degrading towards coins
    // float strength = 1.0 - distance(vUv, vec2(0.5)) ;

    //Pattern 29 white point in the center
    // float strength = 0.015/ distance(vUv, vec2(0.5));
 
    //Pattern 30 white point in the center
    // vec2 newVUv= vec2(
    //     vUv.x * 0.2 + 0.4,
    //     vUv.y
    // );

    // float strength = 0.015/ distance(newVUv, vec2(0.5));

    //Pattern 31 white star degrade
    // vec2 newVUvX= vec2(
    //     vUv.x * 0.1 + 0.45,
    //     vUv.y * 0.5 + 0.25
    // );
    // vec2 newVUvY= vec2(
    //     vUv.x * 0.5 + 0.25,
    //     vUv.y * 0.1 + 0.45
    // );
    // float strength = 0.015/ distance(newVUvX, vec2(0.5)) * 0.015/ distance(newVUvY, vec2(0.5));

    //Pattern 32 star rotation degrade
    // vec2 rotatedUv = rotate(vUv, PI * 0.25, vec2(0.5));

    // vec2 newVUvX= vec2(
    //     rotatedUv.x * 0.1 + 0.45,
    //     rotatedUv.y * 0.5 + 0.25
    // );
    // vec2 newVUvY= vec2(
    //     rotatedUv.x * 0.5 + 0.25,
    //     rotatedUv.y * 0.1 + 0.45
    // );
    // float strength = 0.015/ distance(newVUvX, vec2(0.5)) * 0.015/ distance(newVUvY, vec2(0.5));


    //Pattern 33 black circle on the center 
    // float strength = step(0.3, distance(vUv, vec2(0.5))) ;

    //Pattern 34 black ring degrade on the center 
    // float strength = abs(distance(vUv, vec2(0.5)) - 0.25) ;

    //Pattern 35 black ring on the center 
    // float strength = step(0.01, abs(distance(vUv, vec2(0.5)) - 0.25)) ;

    //Pattern 36 white ring on the center 
    // float strength = 1.0 - step(0.01, abs(distance(vUv, vec2(0.5)) - 0.25)) ;

    //Pattern 37 white ring on the center with waves
    // vec2 newVUv= vec2(
    //     vUv.x,
    //     vUv.y + sin(vUv.x  * 30.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(newVUv, vec2(0.5)) - 0.25));

    //Pattern 38 white ring on the center with waves
    // vec2 newVUv= vec2(
    //     vUv.x + sin(vUv.y * 30.0) * 0.1,
    //     vUv.y + sin(vUv.x * 30.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(newVUv, vec2(0.5)) - 0.25));

    //Pattern 39 white ring on the center with waves
    // vec2 newVUv= vec2(
    //     vUv.x + sin(vUv.y * 100.0) * 0.1,
    //     vUv.y + sin(vUv.x * 100.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(newVUv, vec2(0.5)) - 0.25));

    //Pattern 40 half degrade with angle from corner
    // float strength = vUv.x / vUv.y;
    // float angle = atan(vUv.x, vUv.y);
    // float strength = angle;

    //Pattern 41 half degrade with angle from the center
    // float angle = atan(vUv.x-0.5, vUv.y-0.5);
    // float strength = angle;

    // //Pattern 42 full degrade 360 angle from center
    // float angle = atan(vUv.x-0.5, vUv.y-0.5);
    // angle /= PI * 2.0;
    // angle += 0.5;
    // float strength = angle;

    //Pattern 43 volet-like but in a cicrlce fronm the center degrade on each volet
    // float angle = atan(vUv.x-0.5, vUv.y-0.5);
    // angle /= PI * 2.0;
    // angle += 0.5;
    // float strength = mod(angle * 20.0,1.0);


    //Pattern 44 volet-like but in a circle fronm the center without degrade
    // float angle = atan(vUv.x-0.5, vUv.y-0.5);
    // angle /= PI * 2.0;
    // angle += 0.5;
    // float strength = sin(angle * 50.0);

    //Pattern 45 circle with waves regularly changing radius
    // float angle = atan(vUv.x-0.5, vUv.y-0.5);
    // angle /= PI * 2.0;
    // angle += 0.5;
    // float sinusoid = sin(angle * 50.0);

    // float radius = 0.25 + sinusoid * 0.02;
    // float strength = 1.0 - step(0.01, abs(distance(vUv, vec2(0.5)) - radius)) ;

    //Pattern 46 Perlin noise
    //float strength = cnoise(vUv * 10.0);

    //Pattern 47 Perlin B&W
    // float strength = step(0.1, cnoise(vUv * 10.0));

    //Pattern 48 Perlin x-ray like
    // float strength = 1.0 - abs(cnoise(vUv * 10.0));

    //Pattern 49 Perlin x-ray like
    // float strength = sin(cnoise(vUv * 10.0) * 20.0);

    //Pattern 49 Perlin x-ray like
    // float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));

    //Clamp strength
    // float strength = clamp(strength, 0.0, 1.0);

    //Color version
    // vec3 blackColor = vec3(0.0);
    // vec3 uvColor = vec3(vUv, 1.0);
    // vec3 mixedColor = mix(blackColor, uvColor,strength);
    // gl_FragColor = vec4(mixedColor, 1.0);

    //B&W
    // gl_FragColor = vec4(vec3(strength), 1.0);

}