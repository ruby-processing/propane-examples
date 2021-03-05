#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// ----------------------
// SHADERTOY UNIFORMS  -
// ----------------------

uniform vec3      iResolution;           // viewport resolution (in pixels)
uniform int       iFrame;                // shader playback frame

uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click

void mainImage( out vec4 fragColor, in vec2 fragCoord );

void main() {
    mainImage(gl_FragColor,gl_FragCoord.xy);
}

// ------------------------------
//  SHADERTOY CODE BEGINS HERE  -
// ------------------------------


//---------------------------------------------------------
// Shader:   Newton5Fractal.glsl  by tholzer
// Newton fractal with 3 or 4 or 5  symmetry (change #define NEWTON #).
// Press mouse button to change formula constants.
//           v1.0  2015-04-14
//           v1.1  2017-04-06  define NEWTON added
// tags:     2d, attractor, newton, fractal, complex, number
// info:     http://en.wikipedia.org/wiki/Newton_fractal
//---------------------------------------------------------

#define ITER 12
#define NEWTON 3   // 2,3,4,5

//---------------------------------------------------------
vec2 cinv(in vec2 a)            { return vec2(a.x, -a.y) / dot(a, a); }

vec2 cmul(in vec2 a, in vec2 b) { return vec2(a.x*b.x - a.y*b.y,   a.x*b.y + a.y*b.x); }

vec2 cdiv(in vec2 a, in vec2 b) { return cmul(a, cinv(b)); }
//---------------------------------------------------------
vec2 newton( in vec2 z )
{
  for (int i = 0; i < ITER; i++)
  {
    vec2 z2 = cmul(z, z);
    vec2 z3 = cmul(z2, z);
    vec2 z4 = cmul(z2, z2);
    vec2 z5 = cmul(z3, z2);

//---> change z calculation by uncomment different lines
#if NEWTON==2
    z -= cdiv(z3 - 1.0, 3.0 * z2);                      // original: z^3 - 1  / ( 3*z^2)
#elif NEWTON==3
    z -= cdiv(z3 - 0.5+0.05*iMouse.y, (0.5+0.01*iMouse.x) * z2);  // z^3 - my / (mx*z^2)
#elif NEWTON==4
    z -= cdiv(z4 - 0.5+0.05*iMouse.y, (0.5+0.01*iMouse.x) * z3);  // z^4 - my / (mx*z^3)
#elif NEWTON==5
    z -= cdiv(z5 - 0.5+0.05*iMouse.y, (0.5+0.1*iMouse.x) * z4);  // z^5 - my / (mx*z^4)
#endif
  }
  return z;
}
//---------------------------------------------------------
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
  uv.x *= iResolution.x / iResolution.y;
  vec2 z = newton(uv);
  fragColor = vec4(z.x, z.y, -z.y, 1.0);
}


// ----------------------------
//  SHADERTOY CODE ENDS HERE  -
// ----------------------------
