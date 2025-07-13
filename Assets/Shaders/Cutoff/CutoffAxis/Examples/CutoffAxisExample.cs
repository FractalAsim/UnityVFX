using UnityEngine;

[ExecuteInEditMode]
public class CutoffAxisExample : MonoBehaviour
{
    readonly int cutoffPropertyID = Shader.PropertyToID("_Cutoff2");
    readonly int minCutoffPropertyID = Shader.PropertyToID("_RangeMin");
    readonly int maxCutoffPropertyID = Shader.PropertyToID("_RangeMax");

    [SerializeField] Renderer CutoffObject;

    [SerializeField] Transform minYPlane;
    [SerializeField] Transform maxYPlane;

    void Update()
    {
        if (CutoffObject == null) return;
        if (minYPlane == null) return;
        if (maxYPlane == null) return;

        var sharedMaterial = CutoffObject.GetComponent<Renderer>().sharedMaterial;

        var min = minYPlane.position.y;
        var max = maxYPlane.position.y;
        sharedMaterial.SetFloat(minCutoffPropertyID, min);
        sharedMaterial.SetFloat(maxCutoffPropertyID, max);

        var cutoff = 0.5f * Mathf.Sin(Time.time) + 0.5f;
        sharedMaterial.SetFloat(cutoffPropertyID, cutoff);
    }
}