using UnityEngine;

public class CircleCutaway : MonoBehaviour
{
    public Transform theCuller;

	void Update ()
    {
        //Get the World To Local Matrix of the Object we want to use to cull our object and save it into our Shader
        GetComponent<Renderer>().sharedMaterial.SetMatrix("_CullerInverseMatrix", theCuller.worldToLocalMatrix);
    }
}
