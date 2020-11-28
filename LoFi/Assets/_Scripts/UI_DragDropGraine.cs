using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UI_DragDropGraine : MonoBehaviour
{
    public Graine graine;
    public LayerMask Pot;

    private Vector2 startPos;
    private bool GotIt = false;


    private void OnMouseDown()
    {
        if (graine.remaining > 0)
        {
            startPos = transform.localPosition;
            GotIt = true;
        }
        else
        {
            graine.BuyOne();
        }
    }

    private void OnMouseDrag()
    {
        if (GotIt)
        {
            transform.localPosition = new Vector2(Input.mousePosition.x - Screen.width / 2, Input.mousePosition.y - Screen.height / 2);
        }
    }

    private void OnMouseUp()
    {
        transform.localPosition = startPos;
        Ray ray = ManageCamera.activeCamera.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, Mathf.Infinity))
        {
            FlowerPot pot = hit.transform.GetComponent<FlowerPot>();
            if (GotIt && !pot.Taken)
            {
                graine.PlantSeed();
                GotIt = false;
                pot.SeedPlanted(graine.flower);
            }
        }
    }

}
