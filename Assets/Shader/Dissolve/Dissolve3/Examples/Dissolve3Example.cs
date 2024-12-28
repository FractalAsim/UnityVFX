using UnityEngine;

public class Dissolve3Example : MonoBehaviour
{
    [SerializeField] Material sharedMaterial;

    const string dissolvePropertyName = "_Level";

    int dissolvePropertyID;

    void Start()
    {
        dissolvePropertyID = Shader.PropertyToID(dissolvePropertyName);
    }

    void Update()
    {
        float dist = Mathf.Cos(Time.time) + 0.5f; // 0 : 1

        sharedMaterial.SetFloat(dissolvePropertyID, dist);
    }
}
