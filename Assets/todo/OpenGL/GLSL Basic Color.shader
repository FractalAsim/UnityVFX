//Shader That draws the model and give it a solid color
//Step 1: Draw the vertex of model (setup gl_Position in Vertex Program)
//Step 2: Apply fragment color (setup gl_FragColor in Fragment Program)

Shader "GLSL/ Basic Color" 
{
	Properties
	{
		_SolidColor("Solid Color", Color) = (1, 1., 1., 1.0)
	}
	SubShader
	{
		Pass
		{
			GLSLPROGRAM // Begin GLSL

			uniform vec4 _SolidColor;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;//Draws the Vertex at the correct position in world
			}

			--endif // Ends vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = _SolidColor; // Set the Color
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}