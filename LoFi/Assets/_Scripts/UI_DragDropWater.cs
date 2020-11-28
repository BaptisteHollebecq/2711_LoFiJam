using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class UI_DragDropWater : MonoBehaviour
{
    public float WateringTime = 2;
    public float WaterAmonth = 3;

    public LayerMask Pot;

    public Sprite baseSprite;
    public Sprite OverSprite;

    private Vector2 startPos;
    private bool isWatering = false;
    private Coroutine Watering;
    private FlowerPot pot;
    private Image img;

    private void Awake()
    {
        img = GetComponent<Image>();
    }

    private void OnMouseDown()
    {
        startPos = transform.localPosition;
    }

    private void OnMouseDrag()
    {
        transform.localPosition = new Vector2(Input.mousePosition.x - Screen.width / 2, Input.mousePosition.y - Screen.height / 2);
        Ray ray = ManageCamera.activeCamera.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, Mathf.Infinity, Pot))
        {
            pot = hit.transform.GetComponent<FlowerPot>();
            if (pot.Taken && !isWatering)
            {
                Watering = StartCoroutine(Water());
                isWatering = true;
                img.sprite = OverSprite;
            }
        }
        else
        {
            if (Watering != null)
                StopCoroutine(Watering);
            isWatering = false;
            pot = null;
            img.sprite = baseSprite;
        }
    }

    IEnumerator Water()
    {
        yield return new WaitForSeconds(WateringTime);
        pot.Water(WaterAmonth);
        isWatering = false;
    }

    private void OnMouseUp()
    {
        transform.localPosition = startPos;
        img.sprite = baseSprite;
    }
}
