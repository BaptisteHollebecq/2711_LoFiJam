using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public enum GraineType { Rouge, Bleu, Vert, Rose, Jaune }

public class Graine : MonoBehaviour
{
    public GraineType flower;
    public int remaining = 1;
    public int Cost = 100;

    public Text txt;
    public Text CostText;


    private void Start()
    {
        CostText.text = Cost.ToString();
        ActualiseText();
        if (remaining == 0)
            CostText.enabled = true;
        else
            CostText.enabled = false;
    }

    public void PlantSeed()
    {
        remaining--;
        ActualiseText();
        if (remaining == 0)
        {
            CostText.enabled = true;
        }
    }

    public void BuyOne()
    {
        if (MoneyManager.Money >= Cost)
        {
            remaining++;
            CostText.enabled = false;
            MoneyManager.Money -= Cost;
            ActualiseText();
        }
        
    }

    public void ActualiseText()
    {
        txt.text = remaining.ToString();
    }

}
