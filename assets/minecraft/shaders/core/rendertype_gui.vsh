#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;

/* Start of custom Code */
#define BOTTOM_Y -0.99
#define grayColor vec4(0.8, 0.8, 0.8, 1.0)
out float dis;

/* End of custom Code */

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexColor = Color;

    /* Start of custom Code */
    dis = 0;
    if ((gl_Position.y > 2.5 || gl_Position.y < BOTTOM_Y) && ProjMat[3][0] == -1) {
        dis = 1;
    }

    if (Position.z == 50) {
        if (all(lessThan(abs(vertexColor - grayColor), vec4(0.2)))) {
            vertexColor = vec4(0);
        }
    }

    /* End of custom Code */
}