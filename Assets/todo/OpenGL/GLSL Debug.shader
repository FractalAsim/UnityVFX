Shader "GLSL/ Debug Shader" 
{
	SubShader
	{
		Pass
		{
			GLSLPROGRAM // Begin GLSL

			varying vec4 color;

			--ifdef VERTEX // Begin vertex program/shader

			attribute vec4 Tangent;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;//Draws the Vertex at the correct position in world

				//possibilities to play with:

				//color = gl_Vertex; //Color Based on Local Position of vertex
				//color = gl_Color; //Base Color Set by Unity Engine
				//color = vec4((gl_Normal + vec3(1.0, 1.0, 1.0)) / 2.0, 1.0); // Color(R,G,B) base on Normals (X,Y,Z) 
				//color = vec4(gl_MultiTexCoord0.x, 0.0, 0.0, 1.0);
				//color = vec4(0.0, gl_MultiTexCoord0.y, 0.0, 1.0);
				//color = gl_MultiTexCoord1; // Color Set to UVs of Texture Unit 1??
				//color = gl_MultiTexCoord2; // Color Set to UVs of Texture Unit 2??
				//color = gl_MultiTexCoord3; // Color Set to UVs of Texture Unit 3??
				color = Tangent; // What is this? perpenticular to surface normals
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				gl_FragColor = color; // set the output fragment color
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}