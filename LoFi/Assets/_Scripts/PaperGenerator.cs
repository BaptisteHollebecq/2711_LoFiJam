using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaperGenerator : MonoBehaviour
{
    public Vector2 FactureSpawnRange;
    public Vector2 LettersSpawnRange;
    public Vector2 PubsSpawnRange;

    public List<GameObject> factures;

    public List<GameObject> letters;

    public List<GameObject> pubs;

    private void Start()
    {
        StartCoroutine(Letters());
        StartCoroutine(Pubs());
        StartCoroutine(Factures());
    }

    IEnumerator Letters()
    {
        while (true)
        {
            yield return new WaitForSeconds(Random.Range(LettersSpawnRange.x, LettersSpawnRange.y));
            SpawnLetters();
        }
    }


    IEnumerator Factures()
    {
        while (true)
        {
            yield return new WaitForSeconds(Random.Range(FactureSpawnRange.x, FactureSpawnRange.y));
            SpawnFacture();
        }
    }

    IEnumerator Pubs()
    {
        while (true)
        {
            yield return new WaitForSeconds(Random.Range(PubsSpawnRange.x, PubsSpawnRange.y));
            SpawnPubs();
        }
    }


    void SpawnPubs()
    {
        Instantiate(pubs[Random.Range(0, pubs.Count)], transform.position, transform.rotation, transform); ;
    }

    void SpawnFacture()
    {
        Instantiate(factures[Random.Range(0, factures.Count)], transform.position, transform.rotation, transform); ;
    }

    void SpawnLetters()
    {
        Instantiate(letters[Random.Range(0, letters.Count)], transform.position, transform.rotation, transform); ;
    }
}
