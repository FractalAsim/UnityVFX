// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/VertPerlinNoise" {
	Properties {
//		_Slide ("SliderTime", Range(0, 20)) = 0
		_PerlinScale ("Perlin Scale", Vector) = (50, 50, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Pass {
			
CGPROGRAM
#pragma fragmentoption ARB_precision_hint_fastest
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

//uniform float _Slide;
uniform half2 _PerlinScale;

		
//base input structs
struct vertexInput {
	float4 vertex : POSITION; //position (in object coordinates, i.e. local or model coordinates)
};
struct fragmentInput {
	float4 pos : SV_POSITION;
	fixed4 color : COLOR0;
};

// hash based 3d value noise
// function taken from [url]https://www.shadertoy.com/view/XslGRr[/url]
// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
 
// ported from GLSL to HLSL
 
float hash( float n )
{
    return frac(sin(n)*43758.5453);
}
 
float noise( float3 x )
{
    // The noise function returns a value in the range -1.0f -> 1.0f
 
    float3 p = floor(x);
    float3 f = frac(x);
 
    f       = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;
 
    return lerp(lerp(lerp( hash(n+0.0), hash(n+1.0),f.x),
                   lerp( hash(n+57.0), hash(n+58.0),f.x),f.y),
               lerp(lerp( hash(n+113.0), hash(n+114.0),f.x),
                   lerp( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
}

//vertex function
fragmentInput vert(vertexInput v) {
	fragmentInput o;
	
	float time = _Time.y;//_Slide + _Time.y;
	o.color = noise(float3(v.vertex.x * _PerlinScale.x, time, v.vertex.z * _PerlinScale.y));
	
	o.pos = UnityObjectToClipPos(v.vertex);

	return o;
}

//fragment function
fixed4 frag(fragmentInput IN) : COLOR {
	return IN.color;
}
		
ENDCG
		}
	} 
//	FallBack "Diffuse"
}