using UnityEngine;

namespace Edge
{
	public class Player : MonoBehaviour
	{
		public Vector3 DampLength = Vector3.one;
		public Vector3 DampMask = new Vector3 (1.0f, 0.0f, 0.0f);

		public void Update()
		{
			Vector3 offset = Mathf.Cos (Time.time) / 10 * DampLength;

			GetComponent<Transform> ().position += Vector3.Scale(offset, DampMask);
		}
	}
}