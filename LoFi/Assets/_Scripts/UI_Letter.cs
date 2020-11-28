using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UI_Letter : MonoBehaviour
{
    public Sprite baseSprite;
    public Sprite OpenedSprite;

    public List<int> possibleValue;

    public bool isOpen = false;
    private Paperasse papier;
    private Image img;
    private GameObject opening;

    private void Awake()
    {
        papier = GetComponent<Paperasse>();
        img = GetComponent<Image>();
        opening = transform.GetChild(0).gameObject;
        
    }

    private void Update()
    {
        if (papier.isOnScreen)
            opening.SetActive(true);
        else
            opening.SetActive(false);
    }

    public void Open()
    {
        if (papier.isOnScreen)
        {
            if (!isOpen)
            {
                isOpen = true;
                MoneyManager.Money += possibleValue[Random.Range(0,possibleValue.Count)];
                img.sprite = OpenedSprite;
            }
        }
    }
}