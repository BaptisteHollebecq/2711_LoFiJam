using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum State { Dry, Perfect, Drown, Dead }

public class FlowerPot : MonoBehaviour
{
    public bool Taken = false;
    public float WaterAmonth = 0;

    public float TimerDecrease = 1;
    public float AmonthLost = 1;

    public Transform SpawnPlant;

    public GameObject blueFlower;
    public GameObject RedFlower;
    public GameObject GreenFlower;
    public GameObject YellowFlower;
    public GameObject PinkFlower;

    public State actualState = State.Dry;

    private bool alreadyDrying = false;
    private Flower flower = null;


    public void SeedPlanted(GraineType f)
    {
        Taken = true;
        switch (f)
        {
            case GraineType.Bleu:
                {
                    var inst = Instantiate(blueFlower, SpawnPlant);
                    flower = inst.GetComponent<Flower>();
                    flower.pot = this;
                    break;
                }
            case GraineType.Vert:
                {
                    var inst = Instantiate(GreenFlower, SpawnPlant);
                    flower = inst.GetComponent<Flower>();
                    flower.pot = this;
                    break;
                }
            case GraineType.Jaune:
                {
                    var inst = Instantiate(YellowFlower, SpawnPlant);
                    flower = inst.GetComponent<Flower>();
                    flower.pot = this;
                    break;
                }
            case GraineType.Rose:
                {
                    var inst = Instantiate(PinkFlower, SpawnPlant);
                    flower = inst.GetComponent<Flower>();
                    flower.pot = this;
                    break;
                }
            case GraineType.Rouge:
                {
                    var inst = Instantiate(RedFlower, SpawnPlant);
                    flower = inst.GetComponent<Flower>();
                    flower.pot = this;
                    break;
                }
        }
    }

    public void Water(float amonth)
    {
        WaterAmonth += amonth;

        CheckWater();


        if (!alreadyDrying)
        {
            alreadyDrying = true;
            StartCoroutine(Drying());
        }
    }

    void CheckWater()
    {
        if (WaterAmonth < 25)
            actualState = State.Dry;
        else if (WaterAmonth > 25 && WaterAmonth < 50)
            actualState = State.Perfect;
        else if (WaterAmonth > 50 && WaterAmonth < 75)
            actualState = State.Drown;
        else if (WaterAmonth > 75)
        {
            if (flower != null)
            {
                flower.Kill();
            }
        }
    }

    IEnumerator Drying()
    {
        while (WaterAmonth > 0)
        {
            yield return new WaitForSeconds(TimerDecrease);
            WaterAmonth -= AmonthLost;

            CheckWater();

            if (WaterAmonth <= 0)
            {
                WaterAmonth = 0;
                alreadyDrying = false;
                if (Taken)
                {
                    if (flower != null)
                        flower.Kill();
                }
            }
        }
    }
}
