Shader "Hidden/CutoffSectionBoxExample"
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
            using UnityEngine;

[ExecuteInEditMode]
public class CutoffSectionExample : MonoBehaviour
{
    [SerializeField] Transform SectionCube;

    [SerializeField] Material sharedMaterial;

    static const string enablePropertyName = "_Enable";
    static const string minXPropertyName = "_MinX";
    static const string maxXPropertyName = "_MaxX";
    static const string minYPropertyName = "_MinY";
    static const string maxYPropertyName = "_MaxY";
    static const string minZPropertyName = "_MinZ";
    static const string maxZPropertyName = "_MaxZ";

    readonly int enablePropertyID = Shader.PropertyToID(enablePropertyName);
    readonly int minXPropertyID = Shader.PropertyToID(minXPropertyName);
    readonly int maxXPropertyID = Shader.PropertyToID(maxXPropertyName);
    readonly int minYPropertyID = Shader.PropertyToID(minYPropertyName);
    readonly int maxYPropertyID = Shader.PropertyToID(maxYPropertyName);
    readonly int minZPropertyID = Shader.PropertyToID(minZPropertyName);
    readonly int maxZPropertyID = Shader.PropertyToID(maxZPropertyName);

    public bool EnableSection = true;

    Vector3 startPos = new();

    void Start()
    {
        startPos = SectionCube.position;
    }
    void Update()
    {
        SectionCube.position = startPos + new Vector3(Mathf.Sin(Time.time * 2) * 2 - 1, 0, 0);

        if (SectionCube == null) return;

        var pos = SectionCube.position;
        var scale = SectionCube.lossyScale;

        var min = pos - scale / 2;
        var max = pos + scale / 2;

        var minX = min.x;
        var maxX = max.x;

        var minY = min.y;
        var maxY = max.y;

        var minZ = min.z;
        var maxZ = max.z;

        sharedMaterial.SetFloat(enablePropertyID, EnableSection ? 1 : 0);
        sharedMaterial.SetFloat(minXPropertyID, minX);
        sharedMaterial.SetFloat(maxXPropertyID, maxX);
        sharedMaterial.SetFloat(minYPropertyID, minY);
        sharedMaterial.SetFloat(maxYPropertyID, maxY);
        sharedMaterial.SetFloat(minZPropertyID, minZ);
        sharedMaterial.SetFloat(maxZPropertyID, maxZ);
    }
}

            
            fixed4 frag(v2f_img i) : SV_Target
            {
                return mainImage(i.uv.xy * _ScreenParams.xy);
            }

            ENDCG
        }
    }
}
