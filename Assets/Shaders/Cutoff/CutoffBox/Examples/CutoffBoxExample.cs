using UnityEngine;

public class CutoffBoxExample : MonoBehaviour
{
    readonly int enablePropertyID = Shader.PropertyToID("_Enable");
    readonly int minPropertyID = Shader.PropertyToID("_Min");
    readonly int maxPropertyID = Shader.PropertyToID("_Max");

    public bool EnableCutoff = true;

    [SerializeField] Transform Cube;
    [SerializeField] Transform CutoffBox;

    Vector3 startPos = new();

    void Start()
    {
        if (CutoffBox == null) return;

        startPos = CutoffBox.position;
    }
    void Update()
    {
        if (Cube == null || CutoffBox == null) return;

        CutoffBox.position = startPos + new Vector3(Mathf.Sin(Time.time * 2) * 2 - 1, 0, 0);

        var pos = CutoffBox.position;
        var scale = CutoffBox.lossyScale;

        var min = pos - scale / 2f;
        var max = pos + scale / 2f;

        var sharedMaterial = Cube.GetComponent<Renderer>().sharedMaterial;
        sharedMaterial.SetFloat(enablePropertyID, EnableCutoff ? 1 : 0);
        sharedMaterial.SetVector(minPropertyID, min);
        sharedMaterial.SetVector(maxPropertyID, max);
    }
}