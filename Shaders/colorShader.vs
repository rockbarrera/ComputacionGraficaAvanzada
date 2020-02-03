//Versión de openGL 3.3
#version 330 core
//El diseño es en la posición 0(puede ser 1, 2, 3 ¿de qué depende que sea 1, 2, 3 entre otros?)
layout (location = 0) in vec3 position;

//Se definen las matrices de modelo, vista y proyección
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
	//Se le pasa la transformación a la GPU de la proyección, vista y modelo
	//La posición de transforma a un cuaternión para poder hacer la multiplicación
    gl_Position = projection * view * model * vec4(position, 1.0f);
} 