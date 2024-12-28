//Shader That draws the model And Gives It A Color Based on Vertex Positioning (Local)
//Step 1: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 2: Copy The vertex position to a varying variable
//Step 3: Modify the position value so that it can be setup into the fragment color ( values between 0 to 1)
//Step 4: Apply fragment color (Setup gl_FragColor in Fragment Program)

Shader "GLSL/ Basic Local Positioning Color" 
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			GLSLPROGRAM // Begin GLSL

			varying vec4 position;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;//Draws the Vertex at the correct position in world

				position = gl_Vertex ;
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = position + vec4(0.5, 0.5, 0.5, 0.0);//Add so that ColorPosition Values lies within 0 to 1
				//Set the Color Depending on the position of the Vertex
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}