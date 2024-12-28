//Shader That draws the model And Gives It A Color Based on Vertex Positioning (World)
//Step 1: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 2: Compute the vertex world position using the fomular (pos = World Matrix * gl_Vertex )
//Step 4: Apply fragment color (Setup gl_FragColor in Fragment Program)

//Properties
//_Point		: The point which our color depends on
//_DistanceNear : The distrance threashold away from point to change color
//_ColorNear	: The color of fragment when near to point
//_ColorFar		: The color of fragment when far from point

Shader "GLSL/ Basic World Positioning Color" 
{
	Properties
	{
		_Point("a point in world space", Vector) = (0., 0., 0., 1.0)
		_Distance("threshold distance", Float) = 5.0
		_ColorNear("color near to point", Color) = (0.0, 1.0, 0.0, 1.0)
		_ColorFar("color far from point", Color) = (0.3, 0.3, 0.3, 1.0)
	}

	SubShader
	{
		Pass
		{
			GLSLPROGRAM // Begin GLSL

			uniform vec4 _Point;
			uniform float _Distance;
			uniform vec4 _ColorNear;
			uniform vec4 _ColorFar;

			--include "UnityCG.glslinc" // Includes _Object2World

			varying vec4 position_in_world_space;

			--ifdef VERTEX // Begin vertex program/shader

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world

				position_in_world_space = _Object2World * gl_Vertex;// WorldPos = World Matrix * local vertex pos
			}

			--endif // End vertex program/shader

--			ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				float dist = distance(position_in_world_space, _Point);
				//Distance between vertex's current position and point

				if (dist < _Distance)
				{
					gl_FragColor = _ColorNear;//Near color
				}
				else
				{
					gl_FragColor = _ColorFar;//Far Color
				}
			}

			--endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}