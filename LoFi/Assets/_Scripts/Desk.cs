using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Desk : MonoBehaviour
{
    public Transform PaperGenerator;

    private void OnMouseDown()
    {
        Ray ray = ManageCamera.activeCamera.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, Mathf.Infinity))
        {
            if (hit.collider.gameObject.layer == transform.gameObject.layer)
            {
                foreach (Transform child in PaperGenerator)
                {
                    Paperasse p = child.GetComponent<Paperasse>();
                    if (p.isOnScreen)
                    {
                        p.Back();
                    }
                }
            }
        }
    }
}
