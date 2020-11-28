using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UI_BackButton : MonoBehaviour
{
    public static event System.Action<Camera> ChangeView;

    public Camera TargetWhenClicked;
    public Sprite BaseSprite;
    public Sprite OveredSprite;

    private Image img;

    private void Awake()
    {
        img = GetComponent<Image>();
    }

    private void OnMouseOver()
    {
        img.sprite = OveredSprite;
    }

    private void OnMouseExit()
    {
        img.sprite = BaseSprite;
    }

    private void OnMouseDown()
    {
        ChangeView?.Invoke(TargetWhenClicked);
    }

}
