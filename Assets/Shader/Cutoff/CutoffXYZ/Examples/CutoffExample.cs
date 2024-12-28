using UnityEngine;

[ExecuteInEditMode]
public class CutoffExample : MonoBehaviour
{
    [SerializeField] Material sharedMaterial;

    [SerializeField] Transform minYPlane;
    [SerializeField] Transform maxYPlane;

    const string reversePropertyName = "_XCutoff";
    const string xCutoffPropertyName = "_XCutoff";
    const string yCutoffPropertyName = "_YCutoff";
    const string zCutoffPropertyName = "_ZCutoff";
    const string minCutoffPropertyName = "_MinCutoff";
    const string maxCutoffPropertyName = "_MaxCutoff";

    readonly int reversePropertyID = Shader.PropertyToID(reversePropertyName);
    readonly int xCutoffPropertyID = Shader.PropertyToID(xCutoffPropertyName);
    readonly int yCutoffPropertyID = Shader.PropertyToID(yCutoffPropertyName);
    readonly int zCutoffPropertyID = Shader.PropertyToID(zCutoffPropertyName);
    readonly int minCutoffPropertyID = Shader.PropertyToID(minCutoffPropertyName);
    readonly int maxCutoffPropertyID = Shader.PropertyToID(maxCutoffPropertyName);

    public bool Reverse = false;

    void Update()
    {
        sharedMaterial.SetFloat(reversePropertyID, Reverse ? 1 : 0);

        var cutoff = 0.5f * Mathf.Sin(Time.time) + 0.5f;

        sharedMaterial.SetFloat(xCutoffPropertyID, 1);
        sharedMaterial.SetFloat(yCutoffPropertyID, cutoff);
        sharedMaterial.SetFloat(zCutoffPropertyID, 1);

        var min = minYPlane.position.y;
        var max = maxYPlane.position.y;

        sharedMaterial.SetFloat(minCutoffPropertyID, min);
        sharedMaterial.SetFloat(maxCutoffPropertyID, max);
    }
}