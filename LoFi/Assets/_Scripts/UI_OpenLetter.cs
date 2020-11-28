using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UI_OpenLetter : MonoBehaviour
{
    private UI_Letter lettre;

    private void Awake()
    {
        lettre = transform.parent.GetComponent<UI_Letter>();
    }

    private void OnMouseDown()
    {
        lettre.Open();
    }
}
