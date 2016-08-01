using UnityEngine;
using UnityEngine.Assertions;
using System.Collections;

namespace Edge
{
	[ExecuteInEditMode]
	public class EdgeCamera : MonoBehaviour
	{
		public Shader EdgeShader;
		private const string EdgeShaderTag = "Edge";

		public void OnEnable()
		{
			PrepareShader ();

			Camera camera = GetComponent<Camera> ();

			camera.SetReplacementShader (EdgeShader, EdgeShaderTag);
		}

		private void PrepareShader()
		{
			Assert.IsNotNull (EdgeShader);
		}
	}
}