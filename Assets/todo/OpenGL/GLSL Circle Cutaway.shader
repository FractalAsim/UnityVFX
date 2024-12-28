//Shader That draws the model and discard fragments if fragments collides with a circle
//Step 1: Draw the vertex of model (Setup gl_Position in Vertex Program)
//Step 2: Compute the vertex world position using the fomular (pos = World Matrix * gl_Vertex )
//Step 3: Using an external Script, Push in a gameobject (circle) inverseMatrix ( World2Object )
//Step 4: Calculate the vertex local position inside the Cullers local space with fomular ( localposinculler = inverseMatrix * worldpos)
//Step 5: Discard the Fragments accordingly

//Properties
//_ColorFront	: Color of Front Face
//_ColorBack	: Color of Back Face

Shader "GLSL/ Circle Cutaway" 
{
	Properties
	{
		_ColorFront("color Front Facing", Color) = (0.0, 1.0, 0.0, 1.0)
		_ColorBack("color Back Facing", Color) = (1.0, 0.03, 0.0, 1.0)
	}	
	SubShader
	{
		Pass
		{
			Cull Off // Turn off Culling cause we should be able to see the inside if it gets "cutaway"
			//Cull Back
			//Cull Front

			GLSLPROGRAM // Begin GLSL

			uniform vec4 _ColorFront;
			uniform vec4 _ColorBack;

			--include "UnityCG.glslinc" // Includes _Object2World

			varying vec4 position_in_world_coordinates;

			uniform mat4 _CullerInverseMatrix;
			varying vec4 Local_Pos_In_Culler;

			--ifdef VERTEX // Begin vertex program/shader

			void main()

			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; //Draws the Vertex at the correct position in world

				position_in_world_coordinates = _Object2World * gl_Vertex;// WorldPos = World Matrix * local vertex pos

				Local_Pos_In_Culler = _CullerInverseMatrix * position_in_world_coordinates; //Multiply our world position with the Culler's InverseMatrix (World to Local) to get a local position based on the Culler's origin
				//Position on Local will change based on the culler inverse matrix
			}

			--endif // End vertex program/shader

			--ifdef FRAGMENT // Begin fragment program/shader

			void main()
			{
				if (length(Local_Pos_In_Culler.xyz) < 0.5) // If pos length is smaller than 0.5(based on unity standard circle) ( that means it has entered the target circle )
				{
					discard;
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