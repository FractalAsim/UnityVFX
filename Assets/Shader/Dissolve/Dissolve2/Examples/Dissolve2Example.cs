using UnityEngine;

public class Dissolve2Example : MonoBehaviour
{
    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            RaycastHit hitInfo;
            if (Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out hitInfo))
            {
                if (hitInfo.collider.gameObject.TryGetComponent(out DissolveEffect dissolveEffect))
                {
                    dissolveEffect.Reset();
                    dissolveEffect.TriggerDissolve(hitInfo.point);
                }
            }
        }
    }
}
