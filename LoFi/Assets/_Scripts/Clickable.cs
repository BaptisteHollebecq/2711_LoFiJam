using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Clickable : MonoBehaviour
{

    public static event System.Action<Camera> ChangeView;
    public Material BaseMat;
    public Material OverredMat;

    public Camera TargetWhenClicked;

    private MeshRenderer _meshRenderer;
    private bool isOk = false;

    private void Awake()
    {
        _meshRenderer = GetComponent<MeshRenderer>();
    }

    private void Update()
    {
        if (ManageCamera.activeCamera == Camera.main)
            isOk = true;
        else
            isOk = false;
    }


    private void OnMouseOver()
    {
        if (isOk)
            _meshRenderer.material = OverredMat;
    }

    private void OnMouseExit()
    {
        if (isOk)
            _meshRenderer.material = BaseMat;
    }

    private void OnMouseDown()
    {
        if (isOk)
        {
            _meshRenderer.material = BaseMat;
            ChangeView?.Invoke(TargetWhenClicked);

        }
        
    }
}
