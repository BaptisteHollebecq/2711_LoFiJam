using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlowerPot : MonoBehaviour
{
    public bool Taken = false;
    public float WaterAmonth = 0;

    public void SeedPlanted()
    {
        Taken = true;
    }

    public void Water(float amonth)
    {
        WaterAmonth += amonth;
    }
}
