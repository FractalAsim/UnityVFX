using UnityEngine;

public class DissolveByHeight : MonoBehaviour
{
    [SerializeField] Material sharedMaterial1;
    [SerializeField] Material sharedMaterial2;

    const string interpolatePropertyName = "_Interpolation";
    const string heightPropertyName = "_Height";

    int interpolatePropertyID;
    int heightPropertyID;

    void Start()
    {
        interpolatePropertyID = Shader.PropertyToID(interpolatePropertyName);
        heightPropertyID = Shader.PropertyToID(heightPropertyName);
    }

    void Update()
    {
        sharedMaterial1.SetFloat(interpolatePropertyID, 3);
        sharedMaterial2.SetFloat(interpolatePropertyID, 3);

        float height = 5 * Mathf.Cos(Time.time) + 5; // 0 : 10

        sharedMaterial1.SetFloat(heightPropertyID, height);
        sharedMaterial2.SetFloat(heightPropertyID, height);
    }
}
