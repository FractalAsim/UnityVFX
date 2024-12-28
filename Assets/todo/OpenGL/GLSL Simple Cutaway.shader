//Shader That draws the model and discard fragments based on a User Specified Point Position in World
//Step 1: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 2: Compute the vertex world position using the fomular (pos = World Matrix * gl_Vertex )
//Step 3: Compare the vertex world position with the User specified point and Discard accordingly
//Step 4: Apply fragment Front and Back Facin color  (Setup gl_FragColor in Fragment Program)

//Properties
//_DiscardPoint	: The point that determines which fragments to be discarded
//_ColorFront	: Color of Front Face
//_ColorBack	: Color of Back Face

Shader "GLSL/ Simple Cutaway" 
{
	Properties
	{
		_DiscardPoint("a point in world space", Vector) = (0., 0., 0., 1.0)
		_ColorFront("color Front Facing", Color) = (0.0, 1.0, 0.0, 1.0)
		_ColorBack("color Back Facing", Color) = (1.0, 0.03, 0.0, 1.0)
	}

	SubShader
	{
		Pass
		{
			Cull Off // Turn off Culling cause we should be able to see the inside if it gets "cutaway"
			// Cull Front
			// Cull Back

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _DiscardPoint;
			uniform vec4 _ColorFront;
			uniform vec4 _ColorBack;

			--include "UnityCG.glslinc" // Includes _Object2World

			varying vec4 position_in_world_coordinates;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world

				position_in_world_coordinates = _Object2World * gl_Vertex;// WorldPos = World Matrix * local vertex pos
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				if (position_in_world_coordinates.x > _DiscardPoint.x) 
				{
					discard; // discard fragment if position.x is greater
				}
				else if (position_in_world_coordinates.y > _DiscardPoint.y)
				{
					discard; // discard fragment if position.y is greater
				}
				else if (position_in_world_coordinates.z > _DiscardPoint.z)
				{
					discard; // discard fragment if position.z is greater
				}
				if (gl_FrontFacing) 
				{
					gl_FragColor = _ColorFront; // Front Face Color
				}
				else
				{
					gl_FragColor = _ColorBack;// Back Face Color
				}
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}