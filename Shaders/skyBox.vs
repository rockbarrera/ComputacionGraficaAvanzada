//Se utiliza la version 3.3 de openGL
#version 330 core
//La posicion 0 es la misma que con el shader de color 
layout (location = 0) in vec3 in_position;

//Se declaran matrices uniformes de modelo, vista y proyección
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

//Se declara la variable de salida de las coordenadas de textura
out vec3 our_uv;

void main()
{
	//Se asigna la posicion de entrada
	our_uv = in_position;
	//A la posición se le asigna la transformación de la proyección, vista y modelo, con la posición que es un vector quaternión
	vec4 position = projection * view * model * vec4(in_position, 1.0);
	//¿No está declarada gl_Position?
	gl_Position = position.xyww;
}
