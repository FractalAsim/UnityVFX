//Shader That draws the model and Apply Alpha Blend to Color
//Step 1: Setup Draw Queue as Transparent
//Step 2: Setup Blend Equation ( Blend Src dist )
//Step 3: Draw the Back Face vertex of model (Setup gl_Position in Vertex Program)
//Step 4: Apply fragment Color to Back Face  (Setup gl_FragColor in Fragment Program)
//Step 5: Draw the Front Face vertex of model (Setup gl_Position in Vertex Program)
//Step 6: Apply fragment Color to Front Face  (Setup gl_FragColor in Fragment Program)

//Properties
//_ColorFront	: Color of Front Face
//_ColorBack	: Color of Back Face

Shader "GLSL/ Alpha Blend"
{
	Properties
	{
		_ColorFront("color Front Facing", Color) = (0.0, 1.0, 0.0, 0.3)
		_ColorBack("color Back Facing", Color) = (1.0, 0.0, 0.0, 0.0)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent" // draw after all opaque geometry has been drawn
		}
		
		Pass 
		{
			Cull Front // Draw the Back Face  - Remove the Front Face

			ZWrite Off // dont write to depth buffer to not occlude(block) other objects

			Blend SrcAlpha OneMinusSrcAlpha // use alpha blending 
			//Blend One OneMinusSrcAlpha //Premultiplied Alpha Blend

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _ColorBack;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = _ColorBack; // Back Face Color
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}

		Pass
		{
			Cull Back // Draw the Front Face  - Remove the Back Face

			ZWrite Off // dont write to depth buffer to not occlude(block) other objects

			Blend SrcAlpha OneMinusSrcAlpha // Alpha Blend

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _ColorFront;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world
			}

			--endif // End vertex program/shader


			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = _ColorFront; // Front Face Color
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}