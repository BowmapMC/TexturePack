#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    
	// delete sidebar numbers
	if(	
		Position.z == 0.0 // Depth is correct (0 for guis)
		&&
		gl_Position.x >= 0.94 && gl_Position.y >= -0.35 // If position matches the sidebar
		&& 
		vertexColor.g == 84.0/255.0 && vertexColor.g == 84.0/255.0 && vertexColor.r == 252.0/255.0 // Checks if color is sidebar number red
		&&
		gl_VertexID <= 7 // check if it's the first character of a string !! if you want two characters removed replace '3' with '7'
	) {
		gl_Position = ProjMat * ModelViewMat * vec4(ScreenSize + 100.0, 0.0, 0.0); // move the vertices offscreen, idk if this is a good solution for that but vec4(0.0) doesnt do the trick for everyone
	}

	// Move chat 2 pixels to the left
	if (Position.z == 100.03 || Position.z == 100) {
		gl_Position = ProjMat * ModelViewMat * vec4(Position.x - 2.0, Position.y, Position.z, 1.0);
	}

}
