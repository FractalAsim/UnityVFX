using UnityEngine;

[ExecuteInEditMode]
public class CutoffSectionExample : MonoBehaviour
{
    [SerializeField] Transform SectionCube;

    [SerializeField] Material sharedMaterial;

    const string enablePropertyName = "_Enable";
    const string minXPropertyName = "_MinX";
    const string maxXPropertyName = "_MaxX";
    const string minYPropertyName = "_MinY";
    const string maxYPropertyName = "_MaxY";
    const string minZPropertyName = "_MinZ";
    const string maxZPropertyName = "_MaxZ";

    readonly int enablePropertyID = Shader.PropertyToID(enablePropertyName);
    readonly int minXPropertyID = Shader.PropertyToID(minXPropertyName);
    readonly int maxXPropertyID = Shader.PropertyToID(maxXPropertyName);
    readonly int minYPropertyID = Shader.PropertyToID(minYPropertyName);
    readonly int maxYPropertyID = Shader.PropertyToID(maxYPropertyName);
    readonly int minZPropertyID = Shader.PropertyToID(minZPropertyName);
    readonly int maxZPropertyID = Shader.PropertyToID(maxZPropertyName);

    public bool EnableSection = true;

    void Update()
    {
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
