using UnityEngine;

public class DissolveByDistance : MonoBehaviour
{
    [SerializeField] Material sharedMaterial1;
    [SerializeField] Material sharedMaterial2;

    const string centerPropertyName = "_Center";
    const string distPropertyName = "_Distance";

    int centerPropertyID;
    int distPropertyID;

    void Start()
    {
        centerPropertyID = Shader.PropertyToID(centerPropertyName);
        distPropertyID = Shader.PropertyToID(distPropertyName);
    }

    void Update()
    {
        sharedMaterial1.SetVector(centerPropertyID, Vector4.zero);
        sharedMaterial2.SetVector(centerPropertyID, Vector4.zero);

        float dist = 15 * Mathf.Sin(Time.time) + 15; // 0 : 30

        sharedMaterial1.SetFloat(distPropertyID, dist);
        sharedMaterial2.SetFloat(distPropertyID, dist);
    }
}