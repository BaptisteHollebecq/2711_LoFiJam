// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PostProcess_Pixellize"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_PixelSize("PixelSize", Float) = 1500
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_SpherifyStrenght("Spherify Strenght", Float) = 21.19
		_Float4("Float 4", Float) = 0
		_Float7("Float 7", Float) = 4
		_Float8("Float 8", Range( 0 , 1)) = 0.7703972
		_Texture0("Texture 0", 2D) = "white" {}
		_Float10("Float 10", Float) = 0.25

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _SpherifyStrenght;
			uniform float _PixelSize;
			uniform sampler2D _TextureSample0;
			uniform float _Float10;
			uniform sampler2D _Texture0;
			uniform float _Float4;
			uniform float _Float8;
			uniform float _Float7;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 texCoord4 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_2_0_g1 = texCoord4;
				float2 temp_output_11_0_g1 = ( temp_output_2_0_g1 - float2( 0.5,0.5 ) );
				float dotResult12_g1 = dot( temp_output_11_0_g1 , temp_output_11_0_g1 );
				float2 temp_cast_0 = (_SpherifyStrenght).xx;
				float2 temp_output_47_0 = ( temp_output_2_0_g1 + ( temp_output_11_0_g1 * ( dotResult12_g1 * dotResult12_g1 * temp_cast_0 ) ) + float2( 0,0 ) );
				float pixelWidth1 =  1.0f / _PixelSize;
				float pixelHeight1 = 1.0f / _PixelSize;
				half2 pixelateduv1 = half2((int)(temp_output_47_0.x / pixelWidth1) * pixelWidth1, (int)(temp_output_47_0.y / pixelHeight1) * pixelHeight1);
				float2 temp_cast_1 = (( _SpherifyStrenght + _Float10 )).xx;
				float2 temp_output_153_0 = ( temp_output_2_0_g1 + ( temp_output_11_0_g1 * ( dotResult12_g1 * dotResult12_g1 * temp_cast_1 ) ) + float2( 0,0 ) );
				float4 tex2DNode55 = tex2D( _TextureSample0, temp_output_153_0 );
				float smoothstepResult65 = smoothstep( 0.56 , 1.08 , tex2DNode55.r);
				float4 tex2DNode56 = tex2D( _Texture0, temp_output_153_0 );
				float smoothstepResult69 = smoothstep( 0.34 , 1.11 , tex2DNode56.r);
				float smoothstepResult100 = smoothstep( -0.1 , 0.67 , ( 1.0 - ( tex2DNode55.r + tex2DNode56.r ) ));
				float2 temp_cast_2 = (1.0).xx;
				float2 panner140 = ( _Time.y * temp_cast_2 + temp_output_47_0);
				

				finalColor = ( ( ( tex2D( _MainTex, pixelateduv1 ) * ( 1.0 - ( smoothstepResult65 + smoothstepResult69 ) ) ) + ( smoothstepResult100 * _Float4 ) ) + ( _Float8 * ( frac( ( ( _ScreenParams.y / _Float7 ) * tex2D( _Texture0, panner140 ).r ) ) - 0.5 ) ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18712
435;73;1087;655;987.7712;1628.544;2.960329;True;False
Node;AmplifyShaderEditor.RangedFloatNode;155;-2090.16,-1128.051;Inherit;False;Property;_Float10;Float 10;7;0;Create;True;0;0;0;False;0;False;0.25;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-2229.268,-776.7352;Inherit;False;Property;_SpherifyStrenght;Spherify Strenght;2;0;Create;True;0;0;0;False;0;False;21.19;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;154;-1922.206,-1158.636;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2214.405,-1002.68;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;143;-1492.203,-26.29594;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;47;-1878.784,-852.6199;Inherit;True;Spherize;-1;;1;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;153;-1777.768,-1099.887;Inherit;False;Spherize;-1;;1;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;138;-1218.434,-1180.148;Inherit;True;Property;_Texture0;Texture 0;6;0;Create;True;0;0;0;False;0;False;26ceb19d0f375624597edf4707a90634;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;141;-1421.508,-138.2352;Inherit;False;Constant;_Float9;Float 9;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-746.7438,-1204.333;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0.56;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-741.7935,-814.0396;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;0;False;0;False;0.34;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-731.8169,-1117.837;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;1.08;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-745.8962,-729.2487;Inherit;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;0;False;0;False;1.11;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;56;-923.3731,-1021.299;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;26ceb19d0f375624597edf4707a90634;26ceb19d0f375624597edf4707a90634;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenParams;114;1093.815,-114.695;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;116;1135.284,67.04552;Inherit;False;Property;_Float7;Float 7;4;0;Create;True;0;0;0;False;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;55;-921.3025,-1400.133;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;3f952faa2be8fcb48b52d7b6ae1725b5;3f952faa2be8fcb48b52d7b6ae1725b5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;140;-1202.031,-163.4507;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;65;-437.3732,-1224.285;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;69;-442.3549,-1027.522;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1537.513,-689.2161;Inherit;False;Property;_PixelSize;PixelSize;0;0;Create;True;0;0;0;False;0;False;1500;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-127.8515,-1512.043;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;139;-847.2284,-177.2932;Inherit;True;Property;_TextureSample2;Texture Sample 2;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;115;1392.837,-75.22534;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;112;181.6456,-512.5013;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCPixelate;1;-1267.117,-707.7072;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;91;112.1064,-1507.729;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;1618.561,-50.93347;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-138.9115,-1158.139;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;189.4838,-1271.992;Inherit;False;Constant;_Float5;Float 5;6;0;Create;True;0;0;0;False;0;False;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;457.3438,-1108.902;Inherit;False;Constant;_Float6;Float 6;7;0;Create;True;0;0;0;False;0;False;0.67;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;61;78.45484,-1163.784;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;113;394.663,-402.0802;Inherit;True;Property;_TextureSample3;Texture Sample 3;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;103;1674.854,-877.78;Inherit;False;Property;_Float4;Float 4;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;117;1751.166,-85.61829;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;100;408.8096,-1394.486;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;-1.13;False;2;FLOAT;0.94;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;1905.614,-363.3609;Inherit;False;Property;_Float8;Float 8;5;0;Create;True;0;0;0;False;0;False;0.7703972;0.7703972;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;130;1966.809,-84.44088;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;1832.047,-916.264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;877.5061,-453.1017;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;2228.208,-330.3082;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;2086.411,-692.0474;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;2356.452,-566.9654;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;111;2682.883,-572.1125;Float;False;True;-1;2;ASEMaterialInspector;0;2;PostProcess_Pixellize;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;154;0;49;0
WireConnection;154;1;155;0
WireConnection;47;2;4;0
WireConnection;47;4;49;0
WireConnection;153;2;4;0
WireConnection;153;4;154;0
WireConnection;56;0;138;0
WireConnection;56;1;153;0
WireConnection;55;1;153;0
WireConnection;140;0;47;0
WireConnection;140;2;141;0
WireConnection;140;1;143;2
WireConnection;65;0;55;1
WireConnection;65;1;63;0
WireConnection;65;2;64;0
WireConnection;69;0;56;1
WireConnection;69;1;67;0
WireConnection;69;2;68;0
WireConnection;90;0;55;1
WireConnection;90;1;56;1
WireConnection;139;0;138;0
WireConnection;139;1;140;0
WireConnection;115;0;114;2
WireConnection;115;1;116;0
WireConnection;1;0;47;0
WireConnection;1;1;5;0
WireConnection;1;2;5;0
WireConnection;91;0;90;0
WireConnection;118;0;115;0
WireConnection;118;1;139;1
WireConnection;54;0;65;0
WireConnection;54;1;69;0
WireConnection;61;0;54;0
WireConnection;113;0;112;0
WireConnection;113;1;1;0
WireConnection;117;0;118;0
WireConnection;100;0;91;0
WireConnection;100;1;104;0
WireConnection;100;2;105;0
WireConnection;130;0;117;0
WireConnection;102;0;100;0
WireConnection;102;1;103;0
WireConnection;156;0;113;0
WireConnection;156;1;61;0
WireConnection;136;0;137;0
WireConnection;136;1;130;0
WireConnection;101;0;156;0
WireConnection;101;1;102;0
WireConnection;134;0;101;0
WireConnection;134;1;136;0
WireConnection;111;0;134;0
ASEEND*/
//CHKSM=5DEBDF0041873FBCA378190D09ADBF97A76F972F