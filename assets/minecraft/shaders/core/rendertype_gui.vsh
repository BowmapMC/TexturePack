#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;

/* Start of custom Code */
#define BOTTOM_Y -0.99
// The gray color of the bar (not precise)
#define grayColor vec4(0.8, 0.8, 0.8, 1.0)
#define purpleBackgroundColor vec4(0.2, 0, 0.2, 0.95)
#define purpleOutlineBottomColor vec4(0.1, 0.08, 0.3, 1)
#define purpleOutlineTopColor vec4(0.13, 0.02, 0.33, 1)
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

    // Remove the gray bar before chat messages
    if (Position.x < 3 && Position.z == 50 && all(lessThan(abs(vertexColor - grayColor), vec4(0.5, 0.5, 0.5, 1.0)))) { // Checks if its the right color (there's no colors close so it just checks if it's within 50%)
        vertexColor = vec4(0); // Remove Gray Bar
    }

    // if (Position.z == 400) {

    //     // if (all(lessThan(abs(vertexColor - purpleOutlineBottomColor), vec4(0.1, 0.1, 0.1, 1)))) {
    //     //     match1 = true;
    //     // }

    //     // if (all(lessThan(abs(vertexColor - purpleOutlineTopColor), vec4(0.25, 0.25, 0.25, 1.0)))) {
    //     //     vertexColor = vec4(0.0, 0.89, 0.25, 1);
    //     // }

    //     // if (all(lessThan(abs(vertexColor - purpleOutlineBottomColor), vec4(0.20, 0.20, 0.20, 1.0)))) {
    //     //     vertexColor = vec4(0.12, 0.43, 0.1, 1);
    //     // }

    //     // if (all(lessThan(abs(vertexColor - purpleBackgroundColor), vec4(0.1373, 0.1373, 0.1373, 1.0)))) {
    //     //     vertexColor = vec4(0, 0.1, 0, 0.95);
    //     //     // vertexColor = vec4(1.0, 0, 0, 1.0);
    //     // }

    //     // if (match1 == true) {
    //     //     vertexColor = vec4(1, 0, 0, 1.0);
    //     // }


    // }
    
    
    // This handles the item background if you want to mess with it

    /* End of custom Code */
}