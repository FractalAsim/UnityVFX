Shader "Hidden/Readme"
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
            Quick Outline
=============

Developed by Chris Nolet (c) 2018


Instructions
------------

To add an outline to an object, drag-and-drop the Outline.cs
script onto the object. The outline materials will be loaded
at runtime.

You can also add outlines programmatically with:

    var outline = gameObject.AddComponent<Outline>();

    outline.OutlineMode = Outline.Mode.OutlineAll;
    outline.OutlineColor = Color.yellow;
    outline.OutlineWidth = 5f;

The outline script does a small amount of work in Awake().
For best results, use outline.enabled to toggle the outline.
Avoid removing and re-adding the component if possible.

For large meshes, you may also like to enable 'Precompute
Outline' in the editor. This will reduce the amount of work
performed in Awake().


Troubleshooting
---------------

If the outline appears off-center, please try the following:

1. Set 'Read/Write Enabled' on each model's import settings.
2. Disable 'Optimize Mesh Data' in the player settings.

            
            fixed4 frag(v2f_img i) : SV_Target
            {
                return mainImage(i.uv.xy * _ScreenParams.xy);
            }

            ENDCG
        }
    }
}
