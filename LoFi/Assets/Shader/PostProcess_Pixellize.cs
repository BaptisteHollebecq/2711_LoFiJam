using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostProcess_Pixellize : MonoBehaviour
{
    public Material PostProcessMat;
    // Start is called before the first frame update
    private void Awake()
    {
        if (PostProcessMat == null)
        {
            enabled = false;
        }
        else
        {
            PostProcessMat.mainTexture = PostProcessMat.mainTexture;
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, PostProcessMat);
    }
}
