using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class UI_UPDown : MonoBehaviour
{
    public Sprite UpArrow;
    public Sprite DownArrow;

    public float MoveTiming;

    private bool isDown = true;
    private Image img;

    private void Awake()
    {
        img = GetComponent<Image>();
    }

    private void OnMouseDown()
    {
        if (isDown)
        {
            transform.parent.DOComplete();
            transform.parent.DOLocalMove(localPosPlusY(transform.parent.localPosition, 120), MoveTiming);
            img.sprite = DownArrow;
            isDown = false;
        }
        else
        {
            transform.parent.DOComplete();
            transform.parent.DOLocalMove(localPosPlusY(transform.parent.localPosition, -120), MoveTiming);
            img.sprite = UpArrow;
            isDown = true;
        }
    }

    Vector3 localPosPlusY(Vector3 pos, int value)
    {
        Vector3 ret = new Vector3(pos.x, pos.y + value, pos.z);
        return ret;
    }
}
