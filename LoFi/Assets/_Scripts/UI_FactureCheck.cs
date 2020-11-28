using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UI_FactureCheck : MonoBehaviour
{
    public Sprite check;

    private Image img;
    private Facture fiak;
    private bool canCheck = true;

    private void Awake()
    {
        img = GetComponent<Image>();
        fiak = transform.parent.GetComponent<Facture>();
    }

    private void OnMouseDown()
    {
        if (canCheck)
        {
            if (fiak.Check() == 0)
            {
                img.sprite = check;
                canCheck = false;
            }
        }
    }
}
