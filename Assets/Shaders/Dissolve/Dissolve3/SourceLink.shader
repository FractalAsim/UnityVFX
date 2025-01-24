Shader "Hidden/SourceLink"
{
    Properties {}
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert_img
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            uniform float   iFrame;
            uniform float   iChannelTime[4];
            uniform float3  iChannelResolution[4];
            uniform float4  iMouse;
            uniform float4  iDate;
            uniform float   iSampleRate;

            uniform sampler2D   iChannel0;
            uniform sampler2D   iChannel1;
            uniform sampler2D   iChannel2;
            uniform sampler2D   iChannel3;

            // Shadertoy code
            https://gist.github.com/nukeop/1d2e54bed93ca7e5a67794e45a402541/revisions
            
            fixed4 frag(v2f_img i) : SV_Target
            {
                return mainImage(i.uv.xy * _ScreenParams.xy);
            }

            ENDCG
        }
    }
}
