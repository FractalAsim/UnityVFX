//Shader That draws the model and Apply Multiplicative Alpha Blend to Color
//Step 1: Setup Draw Queue as Transparent
//Step 2: Setup Blend Equation ( Blend Src dist )
//Step 3: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 4: Apply fragment Color (Setup gl_FragColor in Fragment Program)

//Properties
//_Color	: Color of fragment

Shader "GLSL/ Multiplicative Blend" 
{
	Properties
	{
		_Color("Color",Color) = (1, 1, 1, 0.3)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"  // draw after all opaque geometry has been drawn
		}

		Pass{
			Cull Off // draw front and back faces

			ZWrite Off // dont write to depth buffer to not occlude(block) other objects

			Blend Zero OneMinusSrcAlpha // multiplicative blending for attenuation by the fragment's alpha

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _Color;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = _Color; // only alpha is used
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}