//Shader That draws the model that uses Alpha Blending and changes the transparency based on Normals direction
//Step 1: Setup Draw Queue as Transparent
//Step 2: Setup Blend Equation ( Blend Src dist )
//Step 3: Calculate the normals in world space with fomular [ pos = gl_Normal * world matrix * unity_Scale.w ]
//Step 4: Calculate the direction of camera facing the vertex with fomular [current - dest]
//Step 5: Apply fragment Color with alpha accordingly (Setup gl_FragColor in Fragment Program)

//Properties
//_Color	: Color of fragment
//_Thickness: Opcatiy Multiplier

Shader "GLSL/ Simple Silhouette" 
{
	Properties
	{
		_Color("Color", Color) = (1, 0,0, 0.3)
		_Thickness("Thickness",Float) = 1
	}

	SubShader
	{
		Tags
		{ 
			"Queue" = "Transparent"  // draw after all opaque geometry has been drawn
		}

		Pass{
			ZWrite Off // dont write to depth buffer to not occlude(block) other objects

			Blend SrcAlpha OneMinusSrcAlpha // standard alpha blending

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _Color;
			uniform float _Thickness;

			--include "UnityCG.glslinc" // Includes _Object2World,_World2Object,_WorldSpaceCameraPos,unity_Scale

			varying vec3 NormalsInWorld;// surface normal vector
			varying vec3 ViewDirection; // view direction 
				
			--ifdef VERTEX  // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world

				NormalsInWorld = normalize(vec3(vec4(gl_Normal, 0.0) * _World2Object));//Normals in World Space [gl_Normal * _World2Object * unity_Scale.w]
				
				ViewDirection = normalize(_WorldSpaceCameraPos - vec3(_Object2World * gl_Vertex)); //The Cameras Direction [current - dest]
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				float newOpacity = min(1.0, _Color.a/ abs(pow(dot(ViewDirection, NormalsInWorld), _Thickness)));
				//min() return the lesser of two values
				//if dot(ViewDirection, NormalsInWorld) == 0 that means its perpenducular
				// or orthogal which indicates as Silhouette

				gl_FragColor = vec4(vec3(_Color), newOpacity);
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}