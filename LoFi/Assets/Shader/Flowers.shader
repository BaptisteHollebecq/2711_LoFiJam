// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Flowers"
{
	Properties
	{
		_NormalMap("Normal Map", 2D) = "white" {}
		_NormalScale("Normal Scale", Range( 0 , 3)) = 0
		_MainColor("Main Color", Color) = (1,0,0,0)
		_CurveMap("Curve Map", 2D) = "white" {}
		_SecondColor("Second Color", Color) = (1,1,1,0)
		_SecondColorMask("Second Color Mask", Range( 0 , 1)) = 0.8
		_ThicknessMap("Thickness Map", 2D) = "white" {}
		_SmoothnessInt("Smoothness Int", Range( 0 , 1)) = 0
		[HDR]_FakeSSSColor("Fake SSS Color", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _NormalScale;
		uniform float4 _MainColor;
		uniform float _SecondColorMask;
		uniform sampler2D _CurveMap;
		uniform float4 _CurveMap_ST;
		uniform float4 _SecondColor;
		uniform sampler2D _ThicknessMap;
		uniform float4 _ThicknessMap_ST;
		uniform float4 _FakeSSSColor;
		uniform float _SmoothnessInt;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalScale );
			float4 temp_cast_0 = (_SecondColorMask).xxxx;
			float4 temp_cast_1 = (_SecondColorMask).xxxx;
			float2 uv_CurveMap = i.uv_texcoord * _CurveMap_ST.xy + _CurveMap_ST.zw;
			float4 smoothstepResult9 = smoothstep( temp_cast_0 , temp_cast_1 , tex2D( _CurveMap, uv_CurveMap ));
			o.Albedo = ( ( _MainColor * ( 1.0 - smoothstepResult9 ) ) + ( smoothstepResult9 * _SecondColor ) ).rgb;
			float2 uv_ThicknessMap = i.uv_texcoord * _ThicknessMap_ST.xy + _ThicknessMap_ST.zw;
			float4 tex2DNode16 = tex2D( _ThicknessMap, uv_ThicknessMap );
			o.Emission = ( tex2DNode16.r * _FakeSSSColor ).rgb;
			o.Smoothness = ( tex2DNode16.r * _SmoothnessInt );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
435;73;1087;655;666.0308;844.374;1.506572;True;False
Node;AmplifyShaderEditor.SamplerNode;6;-1029.061,-1066.217;Inherit;True;Property;_CurveMap;Curve Map;3;0;Create;True;0;0;0;False;0;False;-1;0fccbb32ecfed1a4e995072facdd6ef3;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-946.1299,-779.7394;Inherit;False;Property;_SecondColorMask;Second Color Mask;5;0;Create;True;0;0;0;False;0;False;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-589.2963,-822.6355;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0.5188679,0.5188679,0.5188679,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;11;-292.9217,-843.4133;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;5;-352.9979,-1057.986;Inherit;False;Property;_MainColor;Main Color;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-361.1686,-536.2083;Inherit;False;Property;_SecondColor;Second Color;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-93.26543,-888.9634;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-109.8872,-679.8518;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;373.9849,297.0183;Inherit;False;Property;_SmoothnessInt;Smoothness Int;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-630.9409,-111.8303;Inherit;False;Property;_NormalScale;Normal Scale;1;0;Create;True;0;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-181.0662,112.5003;Inherit;True;Property;_ThicknessMap;Thickness Map;6;0;Create;True;0;0;0;False;0;False;-1;5d07f22d12bc0a7409e0618a98c3186b;5d07f22d12bc0a7409e0618a98c3186b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;24;7.346107,-469.0665;Inherit;False;Property;_FakeSSSColor;Fake SSS Color;8;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;599.9089,75.20222;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-277.3815,-194.677;Inherit;True;Property;_NormalMap;Normal Map;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;10;59.79384,-795.486;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;317.0063,-451.8853;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;813.8394,-284.8292;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Flowers;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;6;0
WireConnection;9;1;14;0
WireConnection;9;2;14;0
WireConnection;11;0;9;0
WireConnection;12;0;5;0
WireConnection;12;1;11;0
WireConnection;7;0;9;0
WireConnection;7;1;8;0
WireConnection;19;0;16;1
WireConnection;19;1;20;0
WireConnection;2;5;22;0
WireConnection;10;0;12;0
WireConnection;10;1;7;0
WireConnection;23;0;16;1
WireConnection;23;1;24;0
WireConnection;0;0;10;0
WireConnection;0;1;2;0
WireConnection;0;2;23;0
WireConnection;0;4;19;0
ASEEND*/
//CHKSM=F3D401C81C6C9E025BAC9684E73CC27AEEF05DB8