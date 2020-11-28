using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Facture : MonoBehaviour
{
    public Vector2 TimerRange;
    public Vector2 CostRange;

    public Text textTimer;
    public Text textCost;

    private int Timer;
    private int Cost;

    public bool one = false;
    public bool two = false;
    public bool three = false;

    public bool canDestroy = false;
    private Coroutine routine;
    private Paperasse paper;

    private void Start()
    {
        Timer = Random.Range(Mathf.FloorToInt(TimerRange.x), Mathf.FloorToInt(TimerRange.y + 1));
        Cost = Random.Range(Mathf.FloorToInt(CostRange.x), Mathf.FloorToInt(CostRange.y + 1));
        textTimer.text = Timer.ToString();
        textCost.text = Cost.ToString();
        routine = StartCoroutine(Timing());
        paper = GetComponent<Paperasse>();
    }

    IEnumerator Timing()
    {
        while (Timer > 0)
        {
            yield return new WaitForSeconds(1);
            Timer--;
            textTimer.text = Timer.ToString();
        }
        MoneyManager.Money -= Cost;
        canDestroy = true;
    }

    public int Check()
    {
        if (!(canDestroy) && paper.isOnScreen)
        {
            if (!one)
            {
                one = true;
                return 0;
            }
            else if (!two)
            {
                two = true;
                return 0;
            }
            else if (!three)
            {
                three = true;
                StopCoroutine(routine);
                canDestroy = true;
                return 0;
            }

        }
        return 1;
    }
}
