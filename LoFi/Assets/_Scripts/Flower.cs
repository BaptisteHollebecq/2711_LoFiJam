﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flower : MonoBehaviour
{
    public float TimetoGrow = 40;

    [HideInInspector]
    public FlowerPot pot;

    private float increase;
    private bool isDead = false;
    private Coroutine routine;

    private void Start()
    {
        transform.parent = null;
        transform.localScale = new Vector3(0, 0, 0);
        increase = 1 / TimetoGrow;
        routine = StartCoroutine(Grow());
    }

    IEnumerator Grow()
    {

        while (transform.localScale.x <= 1)
        {
            yield return new WaitForSeconds(1);
            switch (pot.actualState)
            {
                case State.Dry:
                    {
                        transform.localScale = new Vector3(transform.localScale.x + increase / 2, transform.localScale.y + increase / 2, transform.localScale.z + increase / 2);
                        break;
                    }
                case State.Perfect:
                    {
                        transform.localScale = new Vector3(transform.localScale.x + increase, transform.localScale.y + increase, transform.localScale.z + increase);
                        break;
                    }
                case State.Drown:
                    {
                        transform.localScale = new Vector3(transform.localScale.x + increase / 2, transform.localScale.y + increase / 2, transform.localScale.z + increase / 2);
                        break;
                    }
            }
        }

        {
            // POP DAT FLOWER
        } 
    }

    public void Kill()
    {
        //CHANGE MATERIAL 
        isDead = true;
        StopCoroutine(routine);
    }

    private void OnMouseDown()
    {
        if (isDead)
        {
            Destroy(gameObject);
            pot.Taken = false;
        }
    }

}
