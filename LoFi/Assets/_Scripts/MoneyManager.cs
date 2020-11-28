using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MoneyManager : MonoBehaviour
{
    public static int Money = 100;

    public Text MoneyText;

    public void Update()
    {
        MoneyText.text = Money.ToString();
    }
}
