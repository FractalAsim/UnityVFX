//Shader that combine two passes for additive and multiplicative blending for an order-independent approximation to alpha blending
//Step 1: Setup Draw Queue as Transparent
//Step 2: Setup Blend Equation ( Blend Src dist )
//Step 3: Pass 1 : Apply multiplicative Blend
//Step 4: Pass 2 : Apply Additive Blend

//Properties
//_Color	: Color of fragment

Shader "GLSL/ Order Independent Alpha Blend" 
{
	Properties
	{
		_Color("Color",Color) = (0.0, 0.2, 1, 0.1)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"  // draw after all opaque geometry has been drawn
		}

		Pass
		{
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

		Pass
		{
			Cull Off // draw front and back faces

			ZWrite Off // dont write to depth buffer to not occlude(block) other objects

			Blend SrcColor One // additive blending

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
				gl_FragColor = _Color;
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}