using UnityEngine;

public class OrganClickHandler : MonoBehaviour
{
    public string organName;

    void OnMouseDown()
    {
        SendToFlutter(organName);
    }

    void SendToFlutter(string organ)
    {
        string json = "{\""type\"":\""organ_click\"",\""organ\"":\""" + organ + "\""}";
        UnityMessageManager.Instance.SendMessageToFlutter(json);
    }
}
