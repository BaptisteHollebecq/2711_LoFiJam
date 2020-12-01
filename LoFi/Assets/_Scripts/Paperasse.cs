using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Paperasse : MonoBehaviour
{
    public enum paperasseType { facture, lettre, pub, tuto}

    public paperasseType papier;

    public LayerMask table;
    public LayerMask corbeille;
    public float distanceopening;

    public bool isOnScreen = false;

    private Vector3 ClickPos;
    private bool canMove = false;
    private int onScreen = 0;

    private void Start()
    {
        transform.localPosition = new Vector3(transform.localPosition.x + Random.Range(-500, 790), transform.localPosition.y + Random.Range(-170, 350), 0);
    }

    public void Back()
    {
        isOnScreen = false;
        transform.localPosition = ClickPos;
        transform.localScale = new Vector3(1, 1, 1);
    }

    private void OnMouseDown()
    {
        onScreen = 0;
        foreach (Transform child in transform.parent)
        {
            Paperasse p = child.GetComponent<Paperasse>();
            if (p.isOnScreen)
            {
                onScreen++;
            }         
        }
        if (onScreen == 0)
        {
            canMove = true;
            transform.SetSiblingIndex(transform.parent.childCount - 1);
            ClickPos = transform.localPosition; canMove = true;
        }
        else
        {
            canMove = false;
        }

    }

    private void OnMouseUp()
    {
        if (Vector2.Distance(transform.localPosition, ClickPos) < distanceopening && canMove)
        {
            isOnScreen = true;
            transform.localPosition = Vector2.zero;
            transform.localScale = new Vector3(3, 3, 3);
        }
        else
        {
            Ray ray = ManageCamera.activeCamera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit, Mathf.Infinity, corbeille))
            {
                switch (papier)
                {
                    case paperasseType.facture:
                        {
                            if (GetComponent<Facture>().canDestroy)
                            {
                                Destroy(gameObject);
                            }
                            break;
                        }
                    case paperasseType.lettre:
                        {
                            Destroy(gameObject);
                            break;
                        }
                    case paperasseType.pub:
                        {
                            Destroy(gameObject);
                            break;
                        }
                }
            }
        }
    }

    private void OnMouseDrag()
    {
        if (!isOnScreen && canMove)
        {
            Ray ray = ManageCamera.activeCamera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit, Mathf.Infinity, table))
            {
                transform.localPosition = new Vector2(Input.mousePosition.x - Screen.width / 2, Input.mousePosition.y - Screen.height / 2);
            }
        }

    }
}
