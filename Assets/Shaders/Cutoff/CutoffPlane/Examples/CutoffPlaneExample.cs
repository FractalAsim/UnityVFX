using UnityEngine;

[ExecuteInEditMode]
public class CutoffPlaneExample : MonoBehaviour
{
    [SerializeField] Material sharedMaterial;

    [SerializeField] Transform plane;

    readonly int enablePropertyID = Shader.PropertyToID("_Enable");
    readonly int pNormalPropertyID = Shader.PropertyToID("_PNormal");
    readonly int pCenterPropertyID = Shader.PropertyToID("_PCenter");

    public bool Enable = true;
    public bool Reverse = false;

    void Update()
    {
        plane.Rotate(new Vector3(0.5f, 0, 0));

        Vector3 normal = -plane.transform.forward;
        Vector3 pos = plane.transform.position;

        sharedMaterial.SetFloat(enablePropertyID, Enable ? 1 : 0);
        sharedMaterial.SetVector(pNormalPropertyID, Reverse ? normal : -normal);
        sharedMaterial.SetVector(pCenterPropertyID, pos);
    }
}