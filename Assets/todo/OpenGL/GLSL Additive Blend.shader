//Shader That draws the model and Apply Additive Alpha Blend to Color
//Step 1: Setup Draw Queue as Transparent
//Step 2: Setup Blend Equation ( Blend Src dist )
//Step 3: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 4: Apply fragment Color (Setup gl_FragColor in Fragment Program)

//Properties
//_Color	: Color of fragment

Shader "GLSL/ Additive Blend" 
{
	Properties
	{
		_Color("Color",Color) = (0.0, 0.3, 1, 0.2)
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

			Blend SrcColor One // additive blending
			//One One, // Just Add Color
			//SrcColor One // Additive Blend using Color Only
			//SrcAlpha One // Additive Blend using Alpha
			//OneMinusSrcColor One // Inverse of Color
			//OneMinusSrcAlpha One //Inverse of Alpha

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
