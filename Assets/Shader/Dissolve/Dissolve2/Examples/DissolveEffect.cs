using UnityEngine;

public class DissolveEffect : MonoBehaviour 
{
	float dissolveValue = 1.0f;
	bool isDissolving = false;

    Material dissolveMaterial;

	void Start()
	{
		dissolveMaterial = GetComponent<Renderer>().material;

        var maxVal = 0.0f;
        var verts = GetComponent<MeshFilter>().mesh.vertices;
		for (int i = 0; i < verts.Length; i++)
		{
			var v1 = verts[i];
			for (int j = 0; j < verts.Length; j++)
			{
				if (j == i) continue;
				var v2 = verts[j];
				float mag = (v1-v2).magnitude;
				if ( mag > maxVal ) maxVal = mag;
			}
		}
		 
		dissolveMaterial.SetFloat("_LargestVal", maxVal * 0.5f);
	}

	void Update()
	{
		if (isDissolving && dissolveMaterial != null)
		{
			dissolveValue = Mathf.Max(0.0f, dissolveValue - Time.deltaTime);
			dissolveMaterial.SetFloat("_DissolveValue", dissolveValue);

			if(dissolveValue == 0)
			{
				isDissolving = false;
				Reset();
            }
		}
	}

    public void TriggerDissolve(Vector3 hitPoint)
    {
        dissolveValue = 1.0f;
        dissolveMaterial.SetVector("_HitPos", (new Vector4(hitPoint.x, hitPoint.y, hitPoint.z, 1.0f)));
        isDissolving = true;
    }

    public void Reset()
    {
        dissolveValue = 1.0f;
        dissolveMaterial.SetFloat("_DissolveValue", dissolveValue);
    }
}