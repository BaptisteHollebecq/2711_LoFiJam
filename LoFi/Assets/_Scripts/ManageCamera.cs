using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ManageCamera : MonoBehaviour
{
    public List<Camera> cameras;
    public Camera StartingCamera;
    public Canvas moneyCanvas;

    [HideInInspector]
    public static Camera activeCamera;

    private void Awake()
    {
        Clickable.ChangeView += ChangeCam;
        UI_BackButton.ChangeView += ChangeCam;

        PlayerPrefs.SetInt("UnitySelectMonitor", 1);

        InitCam();
    }

    private void OnDestroy()
    {
        Clickable.ChangeView -= ChangeCam;
        UI_BackButton.ChangeView -= ChangeCam;
    }

    void ChangeCam(Camera cam)
    {
        foreach (Camera c in cameras)
        {
            if (c != cam)
            {
                c.enabled = false;
            }
            else
            {
                c.enabled = true;
                activeCamera = c;
                moneyCanvas.worldCamera = c;
                moneyCanvas.planeDistance = 1;
            }
        }
    }

    void InitCam()
    {
        foreach (Camera c in cameras)
        {
            if (c != StartingCamera)
            {
                c.enabled = false;
            }
            else
            {
                c.enabled = true;
                activeCamera = c;
                moneyCanvas.worldCamera = c;
                moneyCanvas.planeDistance = 1;
            }
        }
    }


}
