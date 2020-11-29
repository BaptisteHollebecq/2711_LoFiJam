using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MoneyManager : MonoBehaviour
{
    public int StartingMoney = 100;

    public static int Money;

    public Text MoneyText;
    public GameObject canvasLoser;

    private bool lost = false;

    private void Start()
    {
        Money = StartingMoney;
        canvasLoser.SetActive(false);
    }

    public void Update()
    {
        MoneyText.text = Money.ToString();
        if(Money <= 0 && !lost)
        {
            lost = true;
            canvasLoser.SetActive(true);
        }
    }
}
