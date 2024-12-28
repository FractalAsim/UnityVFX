using UnityEngine;

[ExecuteInEditMode]
public class CutoffSectionPlaneExample : MonoBehaviour
{
    [SerializeField] Material sharedMaterial;

    [SerializeField] Transform plane;

    const string enablePropertyName = "Enable";
    const string pNormalPropertyName = "_PNormal";
    const string pCenterPropertyName = "_PCenter";

    readonly int enablePropertyID = Shader.PropertyToID(enablePropertyName);
    readonly int pNormalPropertyID = Shader.PropertyToID(pNormalPropertyName);
    readonly int pCenterPropertyID = Shader.PropertyToID(pCenterPropertyName);

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
