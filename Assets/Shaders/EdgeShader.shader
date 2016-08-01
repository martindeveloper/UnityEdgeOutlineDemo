Shader "Edge/EdgeOutline"
{
	Properties
	{
		_EdgeColor ("Edge Color", Color) = (0.5, 0.5, 0.5, 1.0)
		_EdgeIntensity ("Edge Intensity", Float) = 2.0
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
			"Edge" = "EdgeOutline"
		}

		Stencil
		{
			Ref 0
			Comp NotEqual
		}

		ZWrite Off
		ZTest Always
		Blend One One

		Pass
		{
			CGPROGRAM
			#pragma vertex vertexStage
			#pragma fragment fragmentStage
			
			#include "UnityCG.cginc"

			float4 _EdgeColor;
			float _EdgeIntensity;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{
				float2 uv : TEXCOORD0;
				half3 viewDirection : TEXCOORD1;
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			vertexOutput vertexStage (appdata v)
			{
				vertexOutput output;

				output.position = mul(UNITY_MATRIX_MVP, v.vertex);
				output.uv = TRANSFORM_TEX(v.uv, _MainTex);
				output.normal = UnityObjectToWorldNormal(v.normal);
				output.viewDirection = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz);

				return output;
			}
			
			fixed4 fragmentStage (vertexOutput input) : SV_Target
			{
				half rim = (1 - dot(input.normal, input.viewDirection)) * _EdgeIntensity;
				half4 rimColored = fixed4(rim, rim, rim, 0) * _EdgeColor;

				return rimColored;
			}
			ENDCG
		}
	}
}
